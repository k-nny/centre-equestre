// api/ffe-news.js — Relais des actualités de la FFE (Vercel Serverless Function)
//
// Le navigateur ne peut pas lire ffe.com directement (CORS) : cette fonction
// récupère le flux RSS/Atom côté serveur et renvoie du JSON simple.
//
// Ordre de recherche du flux :
//   1. variable d'environnement FFE_NEWS_FEED_URL (si définie) — à privilégier
//   2. détection automatique : balise <link rel="alternate" type="application/rss+xml">
//      de la page d'accueil de ffe.com
//   3. quelques adresses de flux courantes
//
// Sécurité : seules des URL de ffe.com sont appelées (pas de proxy ouvert).

const HOME = 'https://www.ffe.com/';
const CANDIDATES = [
  'https://www.ffe.com/feed',
  'https://www.ffe.com/rss',
  'https://www.ffe.com/rss.xml',
  'https://www.ffe.com/feed.xml',
  'https://www.ffe.com/actualites/feed',
];
const MAX_ITEMS = 8;

const isFfeUrl = (u) => {
  try {
    const { protocol, hostname } = new URL(u);
    return protocol === 'https:' && (hostname === 'ffe.com' || hostname.endsWith('.ffe.com'));
  } catch { return false; }
};

async function fetchText(url, ms = 5000) {
  const ctrl = new AbortController();
  const t = setTimeout(() => ctrl.abort(), ms);
  try {
    const r = await fetch(url, {
      signal: ctrl.signal,
      headers: { 'User-Agent': 'Mozilla/5.0 (compatible; CentreEquestreBot/1.0)', Accept: 'application/rss+xml, application/atom+xml, application/xml, text/xml, text/html;q=0.8' },
    });
    if (!r.ok) throw new Error('HTTP ' + r.status);
    return await r.text();
  } finally { clearTimeout(t); }
}

const decodeEntities = (s) => s
  .replace(/&#(\d+);/g, (_, n) => String.fromCodePoint(+n))
  .replace(/&#x([0-9a-f]+);/gi, (_, n) => String.fromCodePoint(parseInt(n, 16)))
  .replace(/&nbsp;/g, ' ').replace(/&lt;/g, '<').replace(/&gt;/g, '>')
  .replace(/&quot;/g, '"').replace(/&apos;/g, "'").replace(/&amp;/g, '&');

const clean = (s = '') => decodeEntities(
  s.replace(/<!\[CDATA\[([\s\S]*?)\]\]>/g, '$1').replace(/<[^>]*>/g, ' ')
).replace(/\s+/g, ' ').trim();

const tag = (block, name) => {
  const m = block.match(new RegExp(`<${name}[^>]*>([\\s\\S]*?)</${name}>`, 'i'));
  return m ? m[1] : '';
};

function parseFeed(xml, max = MAX_ITEMS) {
  const blocks = xml.match(/<item[\s>][\s\S]*?<\/item>/gi) || xml.match(/<entry[\s>][\s\S]*?<\/entry>/gi) || [];
  return blocks.slice(0, max).map((b) => {
    let link = clean(tag(b, 'link'));
    if (!link) { const m = b.match(/<link[^>]*href=["']([^"']+)["']/i); link = m ? decodeEntities(m[1]) : ''; }
    const rawDate = clean(tag(b, 'pubDate') || tag(b, 'published') || tag(b, 'updated') || tag(b, 'dc:date'));
    const d = rawDate ? new Date(rawDate) : null;
    let summary = clean(tag(b, 'description') || tag(b, 'summary') || tag(b, 'content:encoded') || tag(b, 'content'));
    if (summary.length > 220) summary = summary.slice(0, 217).replace(/\s+\S*$/, '') + '…';
    return {
      title: clean(tag(b, 'title')),
      link: isFfeUrl(link) ? link : '',
      date: d && !isNaN(d) ? d.toISOString() : null,
      summary,
    };
  }).filter((i) => i.title);
}

async function discoverFeedUrls() {
  const urls = [];
  if (process.env.FFE_NEWS_FEED_URL && isFfeUrl(process.env.FFE_NEWS_FEED_URL)) urls.push(process.env.FFE_NEWS_FEED_URL);
  try {
    const html = await fetchText(HOME);
    const links = html.match(/<link[^>]+type=["']application\/(?:rss|atom)\+xml["'][^>]*>/gi) || [];
    for (const l of links) {
      const m = l.match(/href=["']([^"']+)["']/i);
      if (!m) continue;
      try { const u = new URL(decodeEntities(m[1]), HOME).href; if (isFfeUrl(u)) urls.push(u); } catch { /* ignore */ }
    }
  } catch { /* la page d'accueil peut être indisponible : on tente les adresses courantes */ }
  return [...new Set([...urls, ...CANDIDATES])];
}

const NEWS_URL = 'https://www.ffe.com/actualites';

// Lecture de la page « Actualités » du site (Drupal, pas de flux RSS à jour).
// Chaque article : <h3><a href="/actualites/...">Titre</a></h3>, une date JJ/MM/AAAA,
// une vignette et des étiquettes (catégorie / discipline) placées avant le titre.
function parseActualitesPage(html) {
  const re = /<h3[^>]*>\s*<a[^>]+href=["']([^"']*\/actualites\/[^"']+)["'][^>]*>([\s\S]*?)<\/a>/gi;
  const hits = [];
  let m;
  while ((m = re.exec(html))) hits.push({ href: m[1], title: clean(m[2]), start: m.index, end: re.lastIndex });

  const seen = new Set();
  const items = [];
  let prevEnd = 0;
  hits.forEach((h, idx) => {
    let link = '';
    try { link = new URL(decodeEntities(h.href), NEWS_URL).href; } catch { /* ignore */ }
    if (!h.title || !isFfeUrl(link) || seen.has(link)) return;
    seen.add(link);

    // Date : première date JJ/MM/AAAA entre ce titre et le titre suivant
    const next = hits[idx + 1] ? hits[idx + 1].start : html.length;
    const after = html.slice(h.end, next);
    const dm = after.match(/(\d{2})\/(\d{2})\/(\d{4})/);
    const date = dm ? new Date(`${dm[3]}-${dm[2]}-${dm[1]}T12:00:00Z`) : null;

    // Vignette + étiquettes : région située entre l'article précédent et ce titre
    const before = html.slice(prevEnd, h.start);
    const imgs = [...before.matchAll(/<img\b[^>]*>/gi)];
    const lastImg = imgs.length ? imgs[imgs.length - 1] : null;
    let image = '';
    const srcM = lastImg && lastImg[0].match(/\ssrc=["']([^"']+)["']/i);
    if (srcM) { try { image = new URL(decodeEntities(srcM[1]), NEWS_URL).href; } catch { /* ignore */ } }
    const tagsHtml = lastImg ? before.slice(lastImg.index + lastImg[0].length) : '';
    const tagsText = clean(tagsHtml.replace(/<\/(div|li|span|p|a)>/gi, '$& | '));
    const tags = tagsText.split('|').map((t) => t.trim()).filter((t) => t && t.length <= 40 && !/^>/.test(t)).slice(0, 3);

    if (dm) prevEnd = h.end + after.indexOf(dm[0]) + dm[0].length; else prevEnd = h.end;
    items.push({
      title: h.title,
      link,
      date: date && !isNaN(date) ? date.toISOString() : null,
      summary: '',
      image: /^https:\/\/(?:[\w-]+\.)*ffe\.com\//.test(image) ? image : '',
      tags,
    });
  });
  return items;
}

async function scrapeActualites() {
  const items = parseActualitesPage(await fetchText(NEWS_URL, 7000));
  return items.sort((a, b) => (b.date || '').localeCompare(a.date || ''));
}

const MAX_AGE_DAYS = 180; // un flux dont la dernière actu a plus de 6 mois est considéré périmé

const newest = (items) => items.reduce((m, i) => (i.date && i.date > m ? i.date : m), '');

export default async function handler(req, res) {
  if (req.method !== 'GET') return res.status(405).json({ error: 'Method not allowed' });
  // Cache CDN 30 min : évite de solliciter ffe.com à chaque affichage
  res.setHeader('Cache-Control', 's-maxage=1800, stale-while-revalidate=3600');

  // 1) Page « Actualités » de ffe.com (source principale, à jour)
  try {
    const items = (await scrapeActualites()).slice(0, MAX_ITEMS);
    if (items.length) return res.status(200).json({ items, feedUrl: NEWS_URL, home: HOME });
  } catch { /* on tente les flux RSS en secours */ }

  // 2) Secours : flux RSS/Atom
  const explicit = process.env.FFE_NEWS_FEED_URL && isFfeUrl(process.env.FFE_NEWS_FEED_URL)
    ? [process.env.FFE_NEWS_FEED_URL] : null;
  const urls = explicit || await discoverFeedUrls();

  // On lit tous les flux candidats et on garde celui dont l'actu la plus récente est la plus fraîche
  const results = (await Promise.all(urls.map(async (url) => {
    try {
      const items = parseFeed(await fetchText(url), 30)
        .sort((a, b) => (b.date || '').localeCompare(a.date || ''));
      return items.length ? { url, items, latest: newest(items) } : null;
    } catch { return null; }
  }))).filter(Boolean).sort((a, b) => b.latest.localeCompare(a.latest));

  const best = results[0];
  const limit = new Date(Date.now() - MAX_AGE_DAYS * 864e5).toISOString();
  if (best && best.latest && best.latest >= limit) {
    const oneYear = new Date(Date.now() - 365 * 864e5).toISOString();
    const recent = best.items.filter((i) => i.date && i.date >= oneYear); // on écarte les vieilles entrées
    return res.status(200).json({ items: recent.slice(0, MAX_ITEMS), feedUrl: best.url, home: HOME });
  }
  // Aucun flux, ou flux périmé : le front affichera un lien vers ffe.com
  res.setHeader('Cache-Control', 's-maxage=300');
  return res.status(200).json({
    items: [], feedUrl: best ? best.url : null, stale: !!best, latest: best ? best.latest : null, home: HOME,
  });
}