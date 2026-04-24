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
  const host = req.headers.host || '';
  const ok =
    !origin ||
    origin.includes(host) ||
    /localhost|127\.0\.0\.1/.test(origin) ||
    origin.endsWith('.vercel.app');

  if (!ok) return res.status(403).json({ error: 'Forbidden' });

  res.setHeader('Cache-Control', 'no-store');

  const SUPA_URL = process.env.SUPABASE_URL || '';
  const SUPA_ANON = process.env.SUPABASE_ANON || '';
  const APP_KEY = process.env.APP_KEY || '';
  const ADMIN_PWD = process.env.ADMIN_PASSWORD || '';
  const DEV_PASSWORD = process.env.DEV_PASSWORD || '';

  // [DANS LE HANDLER, APRES LES CONST SUPA_URL, etc.]

  // 1. Ajouter 'tickets' à la liste des tables autorisées sans filtrage app_key si nécessaire
  // Mais ici, tu as ajouté une colonne app_key à 'tickets', donc db.js le gérera tout seul.

  // 2. Modifier la route 'auth' et ajouter 'auth-dev'
  if (req.method === 'POST' && req.body.action === 'auth') {
    const { password } = req.body;
    if (password === ADMIN_PWD) return res.json({ ok: true, token: makeToken(ADMIN_PWD), role: 'admin' });
    if (password === DEV_PASSWORD) return res.json({ ok: true, token: makeToken(DEV_PASSWORD), role: 'dev' });
    return res.status(401).json({ error: 'Invalide' });
  }

  // 3. Ajouter l'action d'envoi d'email (à mettre avant le bloc 'query')
  if (req.method === 'POST' && req.body.action === 'send-ticket-email') {
    const { ticket, token } = req.body;

    if (!verifyToken(token, ADMIN_PWD) && !verifyToken(token, DEV_PASSWORD)) {
      return res.status(401).json({ error: 'Unauthorized' });
    }

    const resendKey = process.env.RESEND_API_KEY;
    const toEmail = process.env.NOTIF_EMAIL;

    const hasImage = !!ticket.screenshot;

    const base64Data = hasImage
      ? ticket.screenshot.replace(/^data:image\/png;base64,/, "")
      : null;

    const html = `
  <p><strong>Type:</strong> ${ticket.type} | <strong>Priorité:</strong> ${ticket.priorite}</p>
  <p><strong>Description:</strong> ${ticket.description}</p>
  ${hasImage
        ? `<p>Screenshot: <img src="cid:my-image" /></p>`
        : ""
      }
  <p><em>Envoyé depuis l'application de gestion des écuries</em></p>
`;

    const body = {
      from: 'Ecuries <onboarding@resend.dev>',
      to: toEmail,
      subject: `[Nouveau Ticket] ${ticket.titre}`,
      html
    };

    // 👉 seulement si image
    if (hasImage) {
      body.attachments = [
        {
          filename: "image.png",
          content: base64Data,
          encoding: "base64",
          cid: "my-image",
        },
      ];
    }

    const emailRes = await fetch('https://api.resend.com/emails', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${resendKey}`
      },
      body: JSON.stringify(body)
    });
    return res.json({ ok: emailRes.ok });
  }

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

    // Ping : retourne un hash public du mot de passe pour détecter un changement
    // Sans révéler le mot de passe — le client compare juste le hash stocké
    if (body.action === 'ping') {
      const hash = fnv32(ADMIN_PWD).toString(16);
      return res.status(200).json({ hash });
    }

    // ── Upload icône discipline vers Supabase Storage ─────────────────
    // { action: 'upload-icon', token, discipline, fileBase64, mimeType }
    if (body.action === 'upload-icon') {
      if (!verifyToken(body.token, ADMIN_PWD) && !verifyToken(body.token, DEV_PASSWORD))
        return res.status(403).json({ error: 'Non autorisé' });

      const { discipline, fileBase64, mimeType } = body;
      if (!discipline || !fileBase64 || !mimeType)
        return res.status(400).json({ error: 'Paramètres manquants' });

      // Nom de fichier : slugify discipline
      const slug = discipline.toLowerCase()
        .normalize('NFD').replace(/[\u0300-\u036f]/g, '')
        .replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '');
      const ext = mimeType === 'image/svg+xml' ? 'svg'
        : mimeType === 'image/png' ? 'png'
          : mimeType === 'image/jpeg' ? 'jpg'
            : mimeType === 'image/webp' ? 'webp'
              : 'png';
      const fileName = `${slug}.${ext}`;

      // Convertir base64 → binaire
      const binary = Buffer.from(fileBase64, 'base64');
      const bucket = 'discipline-icons';

      // Upload vers Supabase Storage (upsert)
      const storageUrl = `${SUPA_URL}/storage/v1/object/${bucket}/${fileName}`;
      const upRes = await fetch(storageUrl, {
        method: 'PUT',
        headers: {
          'apikey': SUPA_ANON,
          'Authorization': `Bearer ${SUPA_ANON}`,
          'Content-Type': mimeType,
          'x-upsert': 'true',
        },
        body: binary,
      });
      if (!upRes.ok) {
        const err = await upRes.text();
        return res.status(500).json({ error: 'Storage upload failed: ' + err });
      }

      // URL publique
      const publicUrl = `${SUPA_URL}/storage/v1/object/public/${bucket}/${fileName}`;

      // Upsert dans la table discipline_icons
      const upsertUrl = `${SUPA_URL}/rest/v1/discipline_icons?on_conflict=discipline,app_key`;
      const upsertRes = await fetch(upsertUrl, {
        method: 'POST',
        headers: {
          'apikey': SUPA_ANON,
          'Authorization': `Bearer ${SUPA_ANON}`,
          'Content-Type': 'application/json',
          'Prefer': 'resolution=merge-duplicates,return=representation',
        },
        body: JSON.stringify([{ discipline, icon_url: publicUrl, app_key: APP_KEY }]),
      });
      if (!upsertRes.ok) {
        const err = await upsertRes.text();
        return res.status(500).json({ error: 'DB upsert failed: ' + err });
      }

      return res.status(200).json({ ok: true, url: publicUrl });
    }

    // ── Suppression icône discipline ──────────────────────────────────
    // { action: 'delete-icon', token, discipline, fileName }
    if (body.action === 'delete-icon') {
      if (!verifyToken(body.token, ADMIN_PWD) && !verifyToken(body.token, DEV_PASSWORD))
        return res.status(403).json({ error: 'Non autorisé' });

      const { discipline, fileName } = body;
      if (!discipline) return res.status(400).json({ error: 'discipline manquant' });

      // Supprimer du Storage si fileName fourni
      if (fileName) {
        const delUrl = `${SUPA_URL}/storage/v1/object/discipline-icons/${fileName}`;
        await fetch(delUrl, {
          method: 'DELETE',
          headers: { 'apikey': SUPA_ANON, 'Authorization': `Bearer ${SUPA_ANON}` },
        });
      }

      // Supprimer de la table
      const delDbUrl = `${SUPA_URL}/rest/v1/discipline_icons?discipline=eq.${encodeURIComponent(discipline)}&app_key=eq.${encodeURIComponent(APP_KEY)}`;
      await fetch(delDbUrl, {
        method: 'DELETE',
        headers: { 'apikey': SUPA_ANON, 'Authorization': `Bearer ${SUPA_ANON}` },
      });

      return res.status(200).json({ ok: true });
    }

    // ── Route : proxy Supabase (toutes les autres requêtes) ───────────
    // { action: 'query', table, method, filter, data, token }
    if (body.action === 'query') {
      // Vérifier le token pour les mutations (insert/update/delete)
      const isMutation = ['insert', 'update', 'delete'].includes(body.method);
      if (isMutation) {
        const isAdmin = verifyToken(body.token, ADMIN_PWD);
        const isDev = verifyToken(body.token, DEV_PASSWORD);

        if (!isAdmin && !isDev) {
          return res.status(403).json({ error: 'Session invalide ou expirée' });
        }
      }

      try {
        const result = await supabaseQuery({
          url: SUPA_URL,
          anon: SUPA_ANON,
          appKey: APP_KEY,
          table: body.table,
          method: body.method,   // select | insert | update | delete
          select: body.select,   // colonnes / joins
          filter: body.filter,   // { col, op, val }[]
          data: body.data,     // pour insert/update
          order: body.order,    // { col, asc }[]
          single: body.single,
        });
        return res.status(200).json(result);
      } catch (e) {
        return res.status(500).json({ error: e.message });
      }
    }
  }

  return res.status(405).json({ error: 'Method not allowed' });
}

// ── Proxy Supabase REST ───────────────────────────────────────────────
async function supabaseQuery({ url, anon, appKey, table, method, select, filter = [], data, order = [], single }) {
  const headers = {
    'apikey': anon,
    'Authorization': `Bearer ${anon}`,
    'Content-Type': 'application/json',
    'Prefer': single ? 'return=representation' : 'return=representation',
  };
  if (single) headers['Prefer'] += ',count=exact';

  // Construction de l'URL avec paramètres
  let qs = [];
  if (select) qs.push(`select=${encodeURIComponent(select)}`);

  // APP_KEY filter — injecté côté serveur sauf pour les tables sans cette colonne
  const NO_APPKEY_TABLES = ['disciplines'];
  const allFilters = NO_APPKEY_TABLES.includes(table)
    ? (filter || [])
    : [{ col: 'app_key', op: 'eq', val: appKey }, ...(filter || [])];
  for (const f of allFilters) {
    qs.push(`${f.col}=${f.op}.${encodeURIComponent(f.val)}`);
  }
  for (const o of (order || [])) {
    qs.push(`order=${o.col}${o.asc === false ? '.desc' : '.asc'}`);
  }
  if (single) qs.push('limit=1');

  const qstr = qs.length ? '?' + qs.join('&') : '';
  const endpoint = `${url}/rest/v1/${table}${qstr}`;

  let fetchMethod = 'GET';
  let body;

  if (method === 'insert') { fetchMethod = 'POST'; body = JSON.stringify(Array.isArray(data) ? data : [data]); }
  if (method === 'update') { fetchMethod = 'PATCH'; body = JSON.stringify(data); }
  if (method === 'delete') { fetchMethod = 'DELETE'; }

  // Pour insert : injecter app_key côté serveur (sauf tables sans cette colonne)
  if (method === 'insert') {
    const rows = Array.isArray(data) ? data : [data];
    body = JSON.stringify(NO_APPKEY_TABLES.includes(table)
      ? rows
      : rows.map(r => ({ ...r, app_key: appKey })));
  }

  const r = await fetch(endpoint, { method: fetchMethod, headers, body });
  const text = await r.text();
  let json;
  try { json = JSON.parse(text); } catch { json = text; }

  if (!r.ok) throw new Error(typeof json === 'object' ? (json.message || JSON.stringify(json)) : json);
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