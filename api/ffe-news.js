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

function parseFeed(xml) {
  const blocks = xml.match(/<item[\s>][\s\S]*?<\/item>/gi) || xml.match(/<entry[\s>][\s\S]*?<\/entry>/gi) || [];
  return blocks.slice(0, MAX_ITEMS).map((b) => {
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

export default async function handler(req, res) {
  if (req.method !== 'GET') return res.status(405).json({ error: 'Method not allowed' });
  // Cache CDN 30 min : évite de solliciter ffe.com à chaque affichage
  res.setHeader('Cache-Control', 's-maxage=1800, stale-while-revalidate=86400');

  for (const url of await discoverFeedUrls()) {
    try {
      const items = parseFeed(await fetchText(url));
      if (items.length) return res.status(200).json({ items, feedUrl: url, home: HOME });
    } catch { /* on essaie l'adresse suivante */ }
  }
  // Pas de flux trouvé : le front affichera un lien vers ffe.com
  res.setHeader('Cache-Control', 's-maxage=300');
  return res.status(200).json({ items: [], feedUrl: null, home: HOME });
}
