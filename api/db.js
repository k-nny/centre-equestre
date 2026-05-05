// api/db.js — Proxy Supabase sécurisé (Vercel Serverless Function)

export default async function handler(req, res) {
  // ── CORS ──────────────────────────────────────────────────────────
  const origin = req.headers.origin || '';
  const host = req.headers.host || '';
  const okCors =
    !origin ||
    origin.includes(host) ||
    /localhost|127\.0\.0\.1/.test(origin) ||
    origin.endsWith('.vercel.app');
  if (!okCors) return res.status(403).json({ error: 'Forbidden' });

  res.setHeader('Cache-Control', 'no-store');

  // ── Variables d'env ───────────────────────────────────────────────
  const SUPA_URL  = process.env.SUPABASE_URL  || '';
  const SUPA_ANON = process.env.SUPABASE_ANON || '';
  const APP_KEY   = process.env.APP_KEY       || '';

  // ── Client Supabase léger (fetch direct) ─────────────────────────
  const supabase = {
    from: (table) => ({
      select: async (cols = '*') => {
        const r = await fetch(
          `${SUPA_URL}/rest/v1/${table}?select=${encodeURIComponent(cols)}`,
          { headers: { apikey: SUPA_ANON, Authorization: `Bearer ${SUPA_ANON}` } }
        );
        const data = await r.json();
        return { data: Array.isArray(data) ? data : [], error: r.ok ? null : data };
      },
      insert: async (rows) => {
        const r = await fetch(`${SUPA_URL}/rest/v1/${table}`, {
          method: 'POST',
          headers: {
            apikey: SUPA_ANON, Authorization: `Bearer ${SUPA_ANON}`,
            'Content-Type': 'application/json', Prefer: 'return=representation'
          },
          body: JSON.stringify(Array.isArray(rows) ? rows : [rows])
        });
        const data = await r.json();
        return { data, error: r.ok ? null : data };
      },
      upsert: async (row, opts = {}) => {
        const conflict = opts.onConflict ? `?on_conflict=${opts.onConflict}` : '';
        const r = await fetch(`${SUPA_URL}/rest/v1/${table}${conflict}`, {
          method: 'POST',
          headers: {
            apikey: SUPA_ANON, Authorization: `Bearer ${SUPA_ANON}`,
            'Content-Type': 'application/json',
            Prefer: 'resolution=merge-duplicates,return=representation'
          },
          body: JSON.stringify(Array.isArray(row) ? row : [row])
        });
        const data = await r.json();
        return { data, error: r.ok ? null : data };
      }
    })
  };

  if (req.method !== 'POST') return res.status(405).json({ error: 'Method not allowed' });

  // ── Lecture du body ───────────────────────────────────────────────
  let body;
  try {
    body = typeof req.body === 'string' ? JSON.parse(req.body) : req.body;
  } catch {
    return res.status(400).json({ error: 'Invalid JSON' });
  }

  const { action, token } = body;

  // ── PING ──────────────────────────────────────────────────────────
  if (action === 'ping') {
    try {
      await initPasswords(supabase);
      const { data: pwRows } = await supabase.from('app_passwords').select('key,hash');
      const siteRow = (pwRows || []).find(r => r.key === 'site');
      const hash = siteRow?.hash || fnv32(process.env.SITE_PASSWORD || '');
      return res.json({ ok: true, hash });
    } catch (e) {
      return res.status(500).json({ error: e.message });
    }
  }

  // ── AUTH ──────────────────────────────────────────────────────────
  if (action === 'auth') {
    const { password } = body;
    if (!password) return res.status(400).json({ ok: false });
    try {
      await initPasswords(supabase);
      const { data: pwRows } = await supabase.from('app_passwords').select('key,hash');
      const pw = {};
      (pwRows || []).forEach(r => { pw[r.key] = r.hash; });

      // Fallback vars d'env si BDD vide
      if (!pw.site)    pw.site    = fnv32(process.env.SITE_PASSWORD    || '');
      if (!pw.admin)   pw.admin   = fnv32(process.env.ADMIN_PASSWORD   || '');
      if (!pw.dev)     pw.dev     = fnv32(process.env.DEV_PASSWORD     || '');
      if (!pw.marine)  pw.marine  = fnv32(process.env.MARINE_PASSWORD  || '');
      if (!pw.balades) pw.balades = fnv32(process.env.BALADES_PASSWORD || '');

      const hash = fnv32(password);
      const roles = [
        { key: 'dev',     role: 'dev'     },
        { key: 'marine',  role: 'marine'  },
        { key: 'admin',   role: 'admin'   },
        { key: 'balades', role: 'balades' },
        { key: 'site',    role: 'site'    },
      ];
      for (const r of roles) {
        if (hash === pw[r.key]) {
          const tok = Buffer.from(
            JSON.stringify({ ts: Date.now(), role: r.role })
          ).toString('base64');
          return res.json({ ok: true, token: tok, hash, role: r.role });
        }
      }
      return res.status(401).json({ ok: false });
    } catch (e) {
      return res.status(500).json({ error: e.message });
    }
  }

  // ── UPDATE PASSWORD ───────────────────────────────────────────────
  if (action === 'update-password') {
    if (!isAllowed(token, ['admin', 'dev'])) {
      return res.status(403).json({ error: 'Non autorisé' });
    }
    const { pwKey, newValue } = body;
    const allowed = ['site', 'admin', 'dev', 'marine', 'balades'];
    if (!allowed.includes(pwKey)) {
      return res.status(400).json({ error: 'Clé non autorisée' });
    }
    if (!newValue || newValue.length < 4) {
      return res.status(400).json({ error: 'Mot de passe trop court (min 4 car.)' });
    }
    try {
      const { error } = await supabase.from('app_passwords').upsert(
        { key: pwKey, hash: fnv32(newValue), updated_at: new Date().toISOString() },
        { onConflict: 'key' }
      );
      if (error) return res.status(500).json({ error: error.message || JSON.stringify(error) });
      return res.json({ ok: true });
    } catch (e) {
      return res.status(500).json({ error: e.message });
    }
  }

  // ── SEND TICKET EMAIL ─────────────────────────────────────────────
  if (action === 'send-ticket-email') {
    if (!isAllowed(token, ['admin', 'dev', 'marine', 'site'])) {
      return res.status(401).json({ error: 'Unauthorized' });
    }
    try {
      const { ticket } = body;
      const resendKey = process.env.RESEND_API_KEY;
      const toEmail   = process.env.NOTIF_EMAIL;
      if (!resendKey || !toEmail) return res.json({ ok: false, error: 'Config email manquante' });

      const hasImage  = !!ticket.screenshot;
      const base64Data = hasImage
        ? ticket.screenshot.replace(/^data:image\/[^;]+;base64,/, '')
        : null;

      const emailBody = {
        from: 'Ecuries <onboarding@resend.dev>',
        to: toEmail,
        subject: `[Nouveau Ticket] ${ticket.titre}`,
        html: `
          <p><strong>Type :</strong> ${ticket.type} | <strong>Priorité :</strong> ${ticket.priorite}</p>
          <p><strong>Description :</strong> ${ticket.description || '—'}</p>
          <p><em>Envoyé depuis l'application de gestion des écuries</em></p>
        `
      };
      if (hasImage) {
        emailBody.attachments = [{
          filename: 'screenshot.png',
          content: base64Data,
          encoding: 'base64'
        }];
      }
      const emailRes = await fetch('https://api.resend.com/emails', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${resendKey}`
        },
        body: JSON.stringify(emailBody)
      });
      return res.json({ ok: emailRes.ok });
    } catch (e) {
      return res.status(500).json({ error: e.message });
    }
  }

  // ── SEND TICKET RETOUR EMAIL ──────────────────────────────────────
  if (action === 'send-ticket-retour-email') {
    // Uniquement admin → dev (pas l'inverse)
    if (!isAllowed(token, ['admin'])) {
      return res.status(401).json({ error: 'Unauthorized' });
    }
    try {
      const { message, ticketTitre } = body;
      const resendKey = process.env.RESEND_API_KEY;
      const toEmail   = process.env.NOTIF_EMAIL;
      if (!resendKey || !toEmail) return res.json({ ok: false, error: 'Config email manquante' });

      const emailRes = await fetch('https://api.resend.com/emails', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${resendKey}`
        },
        body: JSON.stringify({
          from: 'Ecuries <onboarding@resend.dev>',
          to: toEmail,
          subject: `[Retour Admin] ${ticketTitre}`,
          html: `
            <p><strong>Retour de l'admin :</strong></p>
            <p>${message}</p>
            <p><em>Ticket : ${ticketTitre}</em></p>
          `
        })
      });
      return res.json({ ok: emailRes.ok });
    } catch (e) {
      return res.status(500).json({ error: e.message });
    }
  }

  // ── UPLOAD ICÔNE DISCIPLINE ───────────────────────────────────────
  if (action === 'upload-icon') {
    if (!isAllowed(token, ['admin', 'dev'])) {
      return res.status(403).json({ error: 'Non autorisé' });
    }
    const { discipline, fileBase64, mimeType } = body;
    if (!discipline || !fileBase64 || !mimeType) {
      return res.status(400).json({ error: 'Paramètres manquants' });
    }
    try {
      const slug = discipline.toLowerCase()
        .normalize('NFD').replace(/[\u0300-\u036f]/g, '')
        .replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '');
      const ext = { 'image/svg+xml': 'svg', 'image/png': 'png', 'image/jpeg': 'jpg', 'image/webp': 'webp' }[mimeType] || 'png';
      const fileName = `${slug}.${ext}`;
      const binary   = Buffer.from(fileBase64, 'base64');
      const bucket   = 'discipline-icons';

      const upRes = await fetch(`${SUPA_URL}/storage/v1/object/${bucket}/${fileName}`, {
        method: 'PUT',
        headers: {
          apikey: SUPA_ANON, Authorization: `Bearer ${SUPA_ANON}`,
          'Content-Type': mimeType, 'x-upsert': 'true'
        },
        body: binary
      });
      if (!upRes.ok) {
        const err = await upRes.text();
        return res.status(500).json({ error: 'Storage upload failed: ' + err });
      }

      const publicUrl = `${SUPA_URL}/storage/v1/object/public/${bucket}/${fileName}`;
      const upsertRes = await fetch(
        `${SUPA_URL}/rest/v1/discipline_icons?on_conflict=discipline,app_key`,
        {
          method: 'POST',
          headers: {
            apikey: SUPA_ANON, Authorization: `Bearer ${SUPA_ANON}`,
            'Content-Type': 'application/json',
            Prefer: 'resolution=merge-duplicates,return=representation'
          },
          body: JSON.stringify([{ discipline, icon_url: publicUrl, app_key: APP_KEY }])
        }
      );
      if (!upsertRes.ok) {
        const err = await upsertRes.text();
        return res.status(500).json({ error: 'DB upsert failed: ' + err });
      }
      return res.json({ ok: true, url: publicUrl });
    } catch (e) {
      return res.status(500).json({ error: e.message });
    }
  }

  // ── DELETE ICÔNE DISCIPLINE ───────────────────────────────────────
  if (action === 'delete-icon') {
    if (!isAllowed(token, ['admin', 'dev'])) {
      return res.status(403).json({ error: 'Non autorisé' });
    }
    const { discipline, fileName } = body;
    if (!discipline) return res.status(400).json({ error: 'discipline manquant' });
    try {
      if (fileName) {
        await fetch(`${SUPA_URL}/storage/v1/object/discipline-icons/${fileName}`, {
          method: 'DELETE',
          headers: { apikey: SUPA_ANON, Authorization: `Bearer ${SUPA_ANON}` }
        });
      }
      await fetch(
        `${SUPA_URL}/rest/v1/discipline_icons?discipline=eq.${encodeURIComponent(discipline)}&app_key=eq.${encodeURIComponent(APP_KEY)}`,
        { method: 'DELETE', headers: { apikey: SUPA_ANON, Authorization: `Bearer ${SUPA_ANON}` } }
      );
      return res.json({ ok: true });
    } catch (e) {
      return res.status(500).json({ error: e.message });
    }
  }

  // ── QUERY (select / insert / update / delete) ─────────────────────
  if (action === 'query') {
    const isMutation = ['insert', 'update', 'delete'].includes(body.method);
    if (isMutation && !isAllowed(token, ['admin', 'dev', 'marine', 'site', 'balades'])) {
      return res.status(403).json({ error: 'Session invalide ou expirée' });
    }
    try {
      const result = await supabaseQuery({
        url: SUPA_URL, anon: SUPA_ANON, appKey: APP_KEY,
        table:  body.table,
        method: body.method,
        select: body.select,
        filter: body.filter,
        data:   body.data,
        order:  body.order,
        single: body.single
      });
      return res.status(200).json(result);
    } catch (e) {
      return res.status(500).json({ error: e.message });
    }
  }

  return res.status(400).json({ error: 'Action inconnue' });
}

// ── Helpers ───────────────────────────────────────────────────────────

// Vérifie si le token base64 a un des rôles autorisés
function isAllowed(token, allowedRoles) {
  if (!token) return false;
  try {
    const decoded = JSON.parse(Buffer.from(token, 'base64').toString());
    return allowedRoles.includes(decoded.role);
  } catch {
    return false;
  }
}

// Hash FNV32
function fnv32(str) {
  let h = 0x811c9dc5;
  for (let i = 0; i < str.length; i++) {
    h ^= str.charCodeAt(i);
    h = Math.imul(h, 0x01000193) >>> 0;
  }
  return h.toString(16);
}

// Init mots de passe en BDD si absents
async function initPasswords(supabase) {
  try {
    const { data } = await supabase.from('app_passwords').select('key');
    const existing = (data || []).map(r => r.key);
    const defaults = [
      { key: 'site',    value: process.env.SITE_PASSWORD    || '' },
      { key: 'admin',   value: process.env.ADMIN_PASSWORD   || '' },
      { key: 'dev',     value: process.env.DEV_PASSWORD     || '' },
      { key: 'marine',  value: process.env.MARINE_PASSWORD  || '' },
      { key: 'balades', value: process.env.BALADES_PASSWORD || '' },
    ];
    for (const d of defaults) {
      if (!existing.includes(d.key) && d.value) {
        await supabase.from('app_passwords')
          .insert({ key: d.key, hash: fnv32(d.value) });
      }
    }
  } catch (e) {
    console.warn('initPasswords error:', e.message);
  }
}

// Proxy Supabase REST
async function supabaseQuery({ url, anon, appKey, table, method, select, filter = [], data, order = [], single }) {
  const headers = {
    apikey: anon,
    Authorization: `Bearer ${anon}`,
    'Content-Type': 'application/json',
    Prefer: 'return=representation'
  };

  

  const useAppKey = true;

  let qs = [];
  if (select) qs.push(`select=${encodeURIComponent(select)}`);

  const allFilters = useAppKey
    ? [{ col: 'app_key', op: 'eq', val: appKey }, ...(filter || [])]
    : (filter || []);

  for (const f of allFilters) {
    qs.push(`${f.col}=${f.op}.${encodeURIComponent(f.val)}`);
  }
  for (const o of (order || [])) {
    qs.push(`order=${o.col}${o.asc === false ? '.desc' : '.asc'}`);
  }
  if (single) qs.push('limit=1');

  const qstr  = qs.length ? '?' + qs.join('&') : '';
  const endpoint = `${url}/rest/v1/${table}${qstr}`;

  let fetchMethod = 'GET';
  let fetchBody;

  if (method === 'insert') {
    fetchMethod = 'POST';
    const rows = Array.isArray(data) ? data : [data];
    fetchBody = JSON.stringify(
      useAppKey ? rows.map(r => ({ ...r, app_key: appKey })) : rows
    );
  }
  if (method === 'update') {
    fetchMethod = 'PATCH';
    fetchBody = JSON.stringify(data);
  }
  if (method === 'delete') {
    fetchMethod = 'DELETE';
  }

  const r = await fetch(endpoint, { method: fetchMethod, headers, body: fetchBody });
  const text = await r.text();
  let json;
  try { json = JSON.parse(text); } catch { json = text; }

  if (!r.ok) {
    throw new Error(typeof json === 'object' ? (json.message || JSON.stringify(json)) : json);
  }
  return { data: json, error: null };
}

// makeToken / verifyToken conservés pour compatibilité ascendante si besoin
function makeToken(secret) {
  const expires = Number.MAX_SAFE_INTEGER;
  const payload = expires.toString(36);
  const sig = fnv32(secret + payload).toString(16);
  return `${payload}.${sig}`;
}
function verifyToken(token, secret) {
  if (!token) return false;
  try {
    // Nouveau format base64
    const decoded = JSON.parse(Buffer.from(token, 'base64').toString());
    return !!decoded.role;
  } catch {}
  // Ancien format payload.sig
  try {
    const [payload, sig] = token.split('.');
    if (!payload || !sig) return false;
    if (parseInt(payload, 36) < Date.now()) return false;
    return fnv32(secret + payload).toString(16) === sig;
  } catch { return false; }
}