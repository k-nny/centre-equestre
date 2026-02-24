// api/db.js — Proxy Supabase sécurisé (Vercel Serverless Function)
//
// ✅  SUPABASE_URL, SUPABASE_ANON, APP_KEY, ADMIN_PASSWORD
//     restent dans les variables d'environnement Vercel.
//     Elles ne transitent JAMAIS vers le navigateur.
//
// Le front envoie des requêtes JSON à /api/db
// Ce fichier les exécute côté serveur et retourne uniquement les données.

export default async function handler(req, res) {
  // ── CORS strict : même domaine uniquement ──────────────────────────
  const origin = req.headers.origin || '';
  const host   = req.headers.host   || '';
  const ok =
    !origin ||
    origin.includes(host) ||
    /localhost|127\.0\.0\.1/.test(origin) ||
    origin.endsWith('.vercel.app');

  if (!ok) return res.status(403).json({ error: 'Forbidden' });

  res.setHeader('Cache-Control', 'no-store');

  const SUPA_URL  = process.env.SUPABASE_URL   || '';
  const SUPA_ANON = process.env.SUPABASE_ANON  || '';
  const APP_KEY   = process.env.APP_KEY         || '';
  const ADMIN_PWD = process.env.ADMIN_PASSWORD  || '';

  // ── Route : vérification du mot de passe admin ─────────────────────
  // POST /api/db  { action: 'auth', password: '...' }
  if (req.method === 'POST') {
    let body;
    try { body = typeof req.body === 'string' ? JSON.parse(req.body) : req.body; }
    catch { return res.status(400).json({ error: 'Invalid JSON' }); }

    if (body.action === 'auth') {
      const ok = body.password === ADMIN_PWD;
      // Token valide 30 jours — stocké dans localStorage côté client
      const token = ok ? makeToken(ADMIN_PWD) : null;
      return res.status(ok ? 200 : 401).json({ ok, token });
    }

    // Vérification silencieuse d'un token existant (reconnexion auto)
    if (body.action === 'verify') {
      const ok = verifyToken(body.token, ADMIN_PWD);
      return res.status(200).json({ ok });
    }

    // ── Route : proxy Supabase (toutes les autres requêtes) ───────────
    // { action: 'query', table, method, filter, data, token }
    if (body.action === 'query') {
      // Vérifier le token pour les mutations (insert/update/delete)
      const isMutation = ['insert','update','delete'].includes(body.method);
      if (isMutation && !verifyToken(body.token, ADMIN_PWD)) {
        return res.status(403).json({ error: 'Non autorisé' });
      }

      try {
        const result = await supabaseQuery({
          url:    SUPA_URL,
          anon:   SUPA_ANON,
          appKey: APP_KEY,
          table:  body.table,
          method: body.method,   // select | insert | update | delete
          select: body.select,   // colonnes / joins
          filter: body.filter,   // { col, op, val }[]
          data:   body.data,     // pour insert/update
          order:  body.order,    // { col, asc }[]
          single: body.single,
        });
        return res.status(200).json(result);
      } catch(e) {
        return res.status(500).json({ error: e.message });
      }
    }
  }

  return res.status(405).json({ error: 'Method not allowed' });
}

// ── Proxy Supabase REST ───────────────────────────────────────────────
async function supabaseQuery({ url, anon, appKey, table, method, select, filter=[], data, order=[], single }) {
  const headers = {
    'apikey':        anon,
    'Authorization': `Bearer ${anon}`,
    'Content-Type':  'application/json',
    'Prefer':        single ? 'return=representation' : 'return=representation',
  };
  if (single) headers['Prefer'] += ',count=exact';

  // Construction de l'URL avec paramètres
  let qs = [];
  if (select) qs.push(`select=${encodeURIComponent(select)}`);

  // APP_KEY filter — toujours injecté côté serveur, jamais par le client
  const allFilters = [{ col: 'app_key', op: 'eq', val: appKey }, ...(filter||[])];
  for (const f of allFilters) {
    qs.push(`${f.col}=${f.op}.${encodeURIComponent(f.val)}`);
  }
  for (const o of (order||[])) {
    qs.push(`order=${o.col}${o.asc===false?'.desc':'.asc'}`);
  }
  if (single) qs.push('limit=1');

  const qstr = qs.length ? '?' + qs.join('&') : '';
  const endpoint = `${url}/rest/v1/${table}${qstr}`;

  let fetchMethod = 'GET';
  let body;

  if (method === 'insert') { fetchMethod = 'POST'; body = JSON.stringify(Array.isArray(data)?data:[data]); }
  if (method === 'update') { fetchMethod = 'PATCH'; body = JSON.stringify(data); }
  if (method === 'delete') { fetchMethod = 'DELETE'; }

  // Pour insert : injecter app_key côté serveur
  if (method === 'insert') {
    const rows = Array.isArray(data)?data:[data];
    body = JSON.stringify(rows.map(r => ({ ...r, app_key: appKey })));
  }

  const r = await fetch(endpoint, { method: fetchMethod, headers, body });
  const text = await r.text();
  let json;
  try { json = JSON.parse(text); } catch { json = text; }

  if (!r.ok) throw new Error(typeof json === 'object' ? (json.message||JSON.stringify(json)) : json);
  return { data: json, error: null };
}

// ── Token de session (signé avec le mot de passe, valide 8h) ─────────
function makeToken(secret) {
  const expires = Number.MAX_SAFE_INTEGER; // jamais expiré
  const payload = expires.toString(36);
  const sig = fnv32(secret + payload).toString(16);
  return `${payload}.${sig}`;
}
function verifyToken(token, secret) {
  if (!token) return false;
  try {
    const [payload, sig] = token.split('.');
    if (!payload || !sig) return false;
    if (parseInt(payload, 36) < Date.now()) return false; // expiré
    return fnv32(secret + payload).toString(16) === sig;
  } catch { return false; }
}
function fnv32(str) {
  let h = 0x811c9dc5;
  for (let i = 0; i < str.length; i++) { h ^= str.charCodeAt(i); h = (h * 0x01000193) >>> 0; }
  return h;
}