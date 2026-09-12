// api/db.js — Proxy Supabase sécurisé (Vercel Serverless Function)
//
// ✅  SUPABASE_URL, SUPABASE_ANON, APP_KEY, SESSION_SECRET
//     restent dans les variables d'environnement Vercel.
//     Elles ne transitent JAMAIS vers le navigateur.
//
// 🔐 Les MOTS DE PASSE DES RÔLES sont stockés CHIFFRÉS (AES-256-GCM,
//     réversible) dans la table Supabase "app_credentials" — modifiables
//     ET consultables depuis le site (Paramètres > Mots de passe, réservé
//     admin/dev) sans redéploiement. La clé de chiffrement est dérivée de
//     SESSION_SECRET (aucune variable d'environnement supplémentaire).
//     Les anciennes variables d'environnement (ADMIN_PASSWORD, etc.)
//     restent utilisables comme solution de repli tant qu'un mot de passe
//     n'a pas encore été défini en base pour un rôle donné.
//
// Le front envoie des requêtes JSON à /api/db
// Ce fichier les exécute côté serveur et retourne uniquement les données.

import crypto from 'crypto';

// ══════════════════════════════════════════════════
//  RÔLES CONNUS DE L'APPLICATION
// ══════════════════════════════════════════════════
const ROLES = ['admin', 'marine', 'dev', 'stagiaire', 'travaux', 'inscription'];

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
  const SESSION_SECRET = process.env.SESSION_SECRET || '';

  // Anciennes variables d'environnement — solution de repli tant qu'un mot
  // de passe n'a pas été migré en base pour ce rôle (voir getStoredCreds).
  const ENV_FALLBACK = {
    admin: process.env.ADMIN_PASSWORD || '',
    marine: process.env.MARINE_PASSWORD || '',
    dev: process.env.DEV_PASSWORD || '',
    // 'stagiaire' s'appelait 'balade' avant — on accepte les deux noms de variable
    stagiaire: process.env.STAGIAIRE_PASSWORD || process.env.BALADE_PASSWORD || '',
    travaux: process.env.TRAVAUX_PASSWORD || '',
    inscription: process.env.INSCRIPTION_PASSWORD || '',
  };

  // ══════════════════════════════════════════════════
  //  CHIFFREMENT RÉVERSIBLE DES MOTS DE PASSE (AES-256-GCM)
  //  Clé dérivée de SESSION_SECRET — pas de variable d'env supplémentaire.
  // ══════════════════════════════════════════════════
  function credentialsKey() {
    return crypto.scryptSync(SESSION_SECRET, 'app-credentials-salt-v1', 32);
  }
  function encryptPassword(password) {
    const iv = crypto.randomBytes(12);
    const cipher = crypto.createCipheriv('aes-256-gcm', credentialsKey(), iv);
    const encrypted = Buffer.concat([cipher.update(password, 'utf8'), cipher.final()]);
    const tag = cipher.getAuthTag();
    return [iv.toString('hex'), tag.toString('hex'), encrypted.toString('hex')].join(':');
  }
  function decryptPassword(stored) {
    try {
      const [ivHex, tagHex, dataHex] = stored.split(':');
      const decipher = crypto.createDecipheriv('aes-256-gcm', credentialsKey(), Buffer.from(ivHex, 'hex'));
      decipher.setAuthTag(Buffer.from(tagHex, 'hex'));
      const decrypted = Buffer.concat([decipher.update(Buffer.from(dataHex, 'hex')), decipher.final()]);
      return decrypted.toString('utf8');
    } catch { return null; }
  }

  // ══════════════════════════════════════════════════
  //  TOKEN DE SESSION — signé avec SESSION_SECRET (jamais avec le mot de
  //  passe lui-même). Valide indéfiniment, comme avant.
  // ══════════════════════════════════════════════════
  function makeToken(role) {
    const expires = Number.MAX_SAFE_INTEGER;
    const payload = `${role}.${expires.toString(36)}`;
    const sig = crypto.createHmac('sha256', SESSION_SECRET).update(payload).digest('hex');
    return `${Buffer.from(payload).toString('base64url')}.${sig}`;
  }
  function verifyToken(token, role) {
    if (!token || !SESSION_SECRET) return false;
    try {
      const [payloadB64, sig] = token.split('.');
      if (!payloadB64 || !sig) return false;
      const payload = Buffer.from(payloadB64, 'base64url').toString();
      const [tokRole, expStr] = payload.split('.');
      if (tokRole !== role) return false;
      if (parseInt(expStr, 36) < Date.now()) return false;
      const expectedSig = crypto.createHmac('sha256', SESSION_SECRET).update(payload).digest('hex');
      const a = Buffer.from(sig, 'hex'), b = Buffer.from(expectedSig, 'hex');
      if (a.length !== b.length) return false;
      return crypto.timingSafeEqual(a, b);
    } catch { return false; }
  }

  // ── Lit les identifiants stockés en base (table app_credentials) ──
  // Table volontairement JAMAIS exposée via l'action générique 'query'
  // (voir plus bas) : seules ces routes dédiées peuvent la lire/écrire.
  async function getStoredCreds() {
    try {
      const url = `${SUPA_URL}/rest/v1/app_credentials?select=role,password_encrypted&app_key=eq.${encodeURIComponent(APP_KEY)}`;
      const r = await fetch(url, { headers: { apikey: SUPA_ANON, Authorization: `Bearer ${SUPA_ANON}` } });
      if (!r.ok) return {};
      const rows = await r.json();
      const map = {};
      rows.forEach(row => { map[row.role] = row.password_encrypted; });
      return map;
    } catch { return {}; }
  }

  // 2. Route 'auth' — vérifie le mot de passe contre la base (priorité)
  //    puis, à défaut, contre l'ancienne variable d'environnement.
  if (req.method === 'POST' && req.body.action === 'auth') {
    const { password } = req.body;
    if (!password) return res.status(401).json({ error: 'Invalide' });
    if (!SESSION_SECRET) {
      // Config incomplète : on refuse plutôt que de signer les tokens avec une clé vide
      return res.status(500).json({ error: 'Configuration serveur incomplète (SESSION_SECRET manquant)' });
    }
    const stored = await getStoredCreds();
    for (const role of ROLES) {
      const enc = stored[role];
      if (enc) {
        const real = decryptPassword(enc);
        if (real !== null && real === password) return res.json({ ok: true, token: makeToken(role), role });
      } else if (ENV_FALLBACK[role] && password === ENV_FALLBACK[role]) {
        return res.json({ ok: true, token: makeToken(role), role });
      }
    }
    return res.status(401).json({ error: 'Invalide' });
  }

  // 3. Ajouter l'action d'envoi d'email (à mettre avant le bloc 'query')
  if (req.method === 'POST' && req.body.action === 'send-ticket-email') {
    const { ticket, token } = req.body;

    if (!verifyToken(token, 'admin') && !verifyToken(token, 'dev')) {
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
  if (req.method === 'POST' && req.body.action === 'send-ticket-retour-email') {
    const { message, ticketTitre, auteur, token } = req.body;

    if (!verifyToken(token, 'admin') && !verifyToken(token, 'dev')) {
      return res.status(401).json({ error: 'Unauthorized' });
    }

    const resendKey = process.env.RESEND_API_KEY;
    const toEmail = process.env.NOTIF_EMAIL;

    const auteurLabel = auteur || 'Utilisateur';
    const html = `
  <p><strong>De :</strong> ${auteurLabel}</p>
  <p><strong>Retour :</strong> ${message}</p>
  <p><em>Envoyé depuis l'application de gestion des écuries</em></p>
`;

    const body = {
      from: 'Ecuries <onboarding@resend.dev>',
      to: toEmail,
      subject: `[Retour Ticket — ${auteurLabel}] ${ticketTitre}`,
      html
    };

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

  // ── Route : changer le mot de passe d'un rôle (admin/dev uniquement) ──
  // POST /api/db { action: 'change-password', token, role, newPassword }
  if (req.method === 'POST' && req.body.action === 'change-password') {
    const { token, role, newPassword } = req.body;
    if (!verifyToken(token, 'admin') && !verifyToken(token, 'dev')) {
      return res.status(403).json({ error: 'Non autorisé' });
    }
    if (!ROLES.includes(role)) return res.status(400).json({ error: 'Rôle inconnu' });
    if (!newPassword || newPassword.length < 4) return res.status(400).json({ error: 'Mot de passe trop court (4 caractères minimum)' });
    const password_encrypted = encryptPassword(newPassword);
    const upsertUrl = `${SUPA_URL}/rest/v1/app_credentials?on_conflict=role`;
    const r = await fetch(upsertUrl, {
      method: 'POST',
      headers: {
        'apikey': SUPA_ANON,
        'Authorization': `Bearer ${SUPA_ANON}`,
        'Content-Type': 'application/json',
        'Prefer': 'resolution=merge-duplicates,return=representation',
      },
      body: JSON.stringify([{ role, password_encrypted, updated_at: new Date().toISOString(), app_key: APP_KEY }]),
    });
    if (!r.ok) {
      const err = await r.text();
      return res.status(500).json({ error: 'Échec de la mise à jour : ' + err });
    }
    return res.status(200).json({ ok: true });
  }

  // ── Route : consulter le mot de passe en clair d'un rôle (admin/dev) ──
  // POST /api/db { action: 'reveal-password', token, role }
  if (req.method === 'POST' && req.body.action === 'reveal-password') {
    const { token, role } = req.body;
    if (!verifyToken(token, 'admin') && !verifyToken(token, 'dev')) {
      return res.status(403).json({ error: 'Non autorisé' });
    }
    if (!ROLES.includes(role)) return res.status(400).json({ error: 'Rôle inconnu' });
    const stored = await getStoredCreds();
    const enc = stored[role];
    if (enc) {
      const real = decryptPassword(enc);
      if (real === null) return res.status(500).json({ error: 'Déchiffrement impossible' });
      return res.status(200).json({ ok: true, password: real, source: 'base' });
    }
    if (ENV_FALLBACK[role]) {
      return res.status(200).json({ ok: true, password: ENV_FALLBACK[role], source: 'env' });
    }
    return res.status(404).json({ error: 'Aucun mot de passe défini pour ce rôle' });
  }

  // ── Route : vérification du mot de passe admin ─────────────────────
  // POST /api/db  { action: 'auth', password: '...' }
  if (req.method === 'POST') {
    let body;
    try { body = typeof req.body === 'string' ? JSON.parse(req.body) : req.body; }
    catch { return res.status(400).json({ error: 'Invalid JSON' }); }

    // Vérification silencieuse d'un token existant (reconnexion auto)
    // Le rôle n'étant pas transmis, on teste chaque rôle connu.
    if (body.action === 'verify') {
      const ok = ROLES.some(r => verifyToken(body.token, r));
      return res.status(200).json({ ok });
    }

    // Ping : retourne une empreinte du mot de passe ACTUEL DU RÔLE DEMANDÉ
    // (base ou env var), pour détecter un changement, sans jamais révéler
    // le mot de passe lui-même — le client compare juste l'empreinte stockée.
    // ⚠️ Le rôle doit être transmis : sans lui, on ne peut pas savoir quel
    // mot de passe comparer, et vérifier systématiquement celui de l'admin
    // forçait une reconnexion à chaque refresh pour tous les autres rôles.
    if (body.action === 'ping') {
      const role = ROLES.includes(body.role) ? body.role : null;
      if (!role) return res.status(200).json({ hash: null });
      const stored = await getStoredCreds();
      const source = stored[role] ? (decryptPassword(stored[role]) ?? '') : ENV_FALLBACK[role];
      const hash = fnv32(source || '').toString(16);
      return res.status(200).json({ hash });
    }

    // ── Upload icône discipline vers Supabase Storage ─────────────────
    // { action: 'upload-icon', token, discipline, fileBase64, mimeType }
    if (body.action === 'upload-icon') {
      if (!verifyToken(body.token, 'admin') && !verifyToken(body.token, 'dev'))
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
      if (!verifyToken(body.token, 'admin') && !verifyToken(body.token, 'dev'))
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
      // Table protégée : ne transite JAMAIS par le proxy générique, même en
      // lecture — seules les routes dédiées ci-dessus (auth, change-password,
      // reveal-password) peuvent la lire/écrire. Empêche toute fuite vers le client.
      if (body.table === 'app_credentials') {
        return res.status(403).json({ error: 'Table protégée' });
      }

      // Vérifier le token pour les mutations (insert/update/delete)
      const isMutation = ['insert', 'update', 'delete'].includes(body.method);
      if (isMutation) {
        const isAdmin = verifyToken(body.token, 'admin');
        const ismarine = verifyToken(body.token, 'marine');
        const isDev = verifyToken(body.token, 'dev');
        const isTravaux = verifyToken(body.token, 'travaux');

        // Table "annonces" (bandeaux dev) : uniquement dev (et admin en secours)
        if (body.table === 'annonces' && !isAdmin && !isDev) {
          return res.status(403).json({ error: 'Réservé au développeur' });
        }

        // Exception : cocher/décocher une tâche du jour est accessible SANS connexion
        // (checklist affichée publiquement), mais limité à l'insert/update des seuls
        // champs completee / completed_at (+ tache_id / date à la création).
        const TACHES_COMP_PUBLIC_FIELDS = ['completee', 'completed_at', 'tache_id', 'date'];
        const isTachesCompletionPublic =
          body.table === 'taches_completions' &&
          ['insert', 'update'].includes(body.method) &&
          Object.keys(body.data || {}).every(k => TACHES_COMP_PUBLIC_FIELDS.includes(k));

        // Exception : envoyer le contrat d'inscription est accessible SANS connexion
        // (formulaire public rempli par les familles) — uniquement en création (insert),
        // jamais en update/delete, pour empêcher toute modification a posteriori.
        const isInscriptionPublic =
          body.table === 'inscriptions' && body.method === 'insert';

        if (!isAdmin && !isDev && !ismarine && !isTravaux && !isTachesCompletionPublic && !isInscriptionPublic) {
          return res.status(403).json({ error: 'Session invalide ou expirée' });
        }
        // Le rôle Travaux (seul, sans admin/dev) : lecture + "marquer fait" uniquement
        if (isTravaux && !isAdmin && !isDev) {
          if (body.table !== 'travaux') {
            return res.status(403).json({ error: 'Accès restreint au module Travaux' });
          }
          if (body.method !== 'update') {
            return res.status(403).json({ error: 'Le rôle Travaux ne peut que consulter et marquer les travaux comme faits' });
          }
          const allowedFields = ['fait', 'completed_at', 'fait_par'];
          const dataKeys = Object.keys(body.data || {});
          if (dataKeys.some(k => !allowedFields.includes(k))) {
            return res.status(403).json({ error: 'Le rôle Travaux ne peut pas modifier ces champs' });
          }
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

// ── FNV32 (utilisé uniquement pour l'empreinte du 'ping', pas pour la
//     sécurité des mots de passe — voir encryptPassword/decryptPassword) ──
function fnv32(str) {
  let h = 0x811c9dc5;
  for (let i = 0; i < str.length; i++) { h ^= str.charCodeAt(i); h = (h * 0x01000193) >>> 0; }
  return h;
}