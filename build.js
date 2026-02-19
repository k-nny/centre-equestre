// ─────────────────────────────────────────────────────────────
// build.js — Génère index.html à partir du template
// - En local   : lit les variables depuis .env
// - Sur Vercel : lit les variables depuis process.env
// Usage : node build.js
// ─────────────────────────────────────────────────────────────
const fs   = require('fs');
const path = require('path');

// Charger le .env local s'il existe (ignoré sur Vercel)
function loadLocalEnv() {
  const envPath = path.join(__dirname, '.env');
  if (!fs.existsSync(envPath)) return;
  const lines = fs.readFileSync(envPath, 'utf8').split('\n');
  for (const line of lines) {
    const trimmed = line.trim();
    if (!trimmed || trimmed.startsWith('#')) continue;
    const [key, ...rest] = trimmed.split('=');
    const k = key.trim();
    // Ne pas écraser une variable déjà définie dans l'environnement
    if (!process.env[k]) process.env[k] = rest.join('=').trim();
  }
}

// Vérifier que toutes les variables requises sont présentes
function checkRequired() {
  const required = ['SUPABASE_URL', 'SUPABASE_ANON', 'APP_KEY', 'ADMIN_PASSWORD'];
  const missing  = required.filter(k => !process.env[k]);
  if (missing.length) {
    console.error('❌  Variables manquantes :');
    missing.forEach(k => console.error('   •', k));
    console.error('\n   → En local : remplissez le fichier .env');
    console.error('   → Sur Vercel : ajoutez-les dans Settings → Environment Variables');
    process.exit(1);
  }
}

function build() {
  loadLocalEnv();
  checkRequired();

  const templatePath = path.join(__dirname, 'template.html');
  const outputPath   = path.join(__dirname, 'index.html');

  if (!fs.existsSync(templatePath)) {
    console.error('❌  Fichier template.html introuvable');
    process.exit(1);
  }

  let html = fs.readFileSync(templatePath, 'utf8');

  html = html
    .replace('VOTRE_URL_SUPABASE',       process.env.SUPABASE_URL)
    .replace('VOTRE_CLE_ANON_SUPABASE',  process.env.SUPABASE_ANON)
    .replace('VOTRE_APP_KEY_RLS',         process.env.APP_KEY)
    .replace('VOTRE_MOT_DE_PASSE_ADMIN', process.env.ADMIN_PASSWORD);

  fs.writeFileSync(outputPath, html, 'utf8');
  console.log('✅  index.html généré avec succès !');
  console.log('   →', outputPath);
}

build();
