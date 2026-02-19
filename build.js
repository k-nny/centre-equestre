// ─────────────────────────────────────────────────────────────
// build.js — Génère index.html à partir du template + .env
// Usage : node build.js
// ─────────────────────────────────────────────────────────────
const fs   = require('fs');
const path = require('path');

// Charger le .env manuellement (pas de dépendance externe)
function loadEnv(filepath) {
  if (!fs.existsSync(filepath)) {
    console.error('❌  Fichier .env introuvable :', filepath);
    process.exit(1);
  }
  const lines = fs.readFileSync(filepath, 'utf8').split('\n');
  const env   = {};
  for (const line of lines) {
    const trimmed = line.trim();
    if (!trimmed || trimmed.startsWith('#')) continue;
    const [key, ...rest] = trimmed.split('=');
    env[key.trim()] = rest.join('=').trim();
  }
  return env;
}

// Vérifier que toutes les variables requises sont présentes
function checkRequired(env) {
  const required = ['SUPABASE_URL', 'SUPABASE_ANON', 'APP_KEY', 'ADMIN_PASSWORD'];
  const missing  = required.filter(k => !env[k] || env[k].startsWith('https://xxxx'));
  if (missing.length) {
    console.error('❌  Variables manquantes ou non configurées dans .env :');
    missing.forEach(k => console.error('   •', k));
    process.exit(1);
  }
}

// Injecter les variables dans le template HTML
function build() {
  const envPath      = path.join(__dirname, '.env');
  const templatePath = path.join(__dirname, 'template.html');
  const outputPath   = path.join(__dirname, 'index.html');

  const env = loadEnv(envPath);
  checkRequired(env);

  if (!fs.existsSync(templatePath)) {
    console.error('❌  Fichier template.html introuvable');
    process.exit(1);
  }

  let html = fs.readFileSync(templatePath, 'utf8');

  // Remplacer les placeholders
  html = html
    .replace('VOTRE_URL_SUPABASE',        env.SUPABASE_URL)
    .replace('VOTRE_CLE_ANON_SUPABASE',   env.SUPABASE_ANON)
    .replace('VOTRE_APP_KEY_RLS',          env.APP_KEY)
    .replace('VOTRE_MOT_DE_PASSE_ADMIN',  env.ADMIN_PASSWORD);

  fs.writeFileSync(outputPath, html, 'utf8');
  console.log('✅  index.html généré avec succès !');
  console.log('   →', outputPath);
}

build();
