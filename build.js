// build.js — Génère index.html à partir de template.html
// Les credentials ne sont PLUS injectés dans le HTML.
// Ils restent dans les variables d'environnement Vercel / .env
// et sont utilisés uniquement par api/db.js côté serveur.

const fs   = require('fs');
const path = require('path');

function build() {
  const src = path.join(__dirname, 'template.html');
  const dst = path.join(__dirname, 'index.html');

  if (!fs.existsSync(src)) {
    console.error('❌  template.html introuvable');
    process.exit(1);
  }

  // Simple copie — aucune variable sensible n'est injectée
  fs.copyFileSync(src, dst);
  console.log('✅  index.html généré (proxy sécurisé via /api/db)');
  console.log('   →', dst);
  console.log('');
  console.log('   Variables requises dans Vercel → Settings → Environment Variables :');
  console.log('   • SUPABASE_URL');
  console.log('   • SUPABASE_ANON');
  console.log('   • APP_KEY');
  console.log('   • SESSION_SECRET   ⚠️ NOUVELLE — obligatoire, signe les sessions.');
  console.log('                        Génère une valeur aléatoire longue, ex: openssl rand -hex 32');
  console.log('');
  console.log('   Anciennes variables (mots de passe en clair) — conservées comme');
  console.log('   solution de repli tant que le mot de passe correspondant n\'a pas');
  console.log('   été redéfini depuis le site (Paramètres > Mots de passe) :');
  console.log('   • ADMIN_PASSWORD');
  console.log('   • MARINE_PASSWORD');
  console.log('   • DEV_PASSWORD');
  console.log('   • STAGIAIRE_PASSWORD (anciennement BALADE_PASSWORD, toujours accepté)');
  console.log('   • TRAVAUX_PASSWORD');
  console.log('   • INSCRIPTION_PASSWORD');
}

build();