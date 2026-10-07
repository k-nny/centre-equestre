# Centre équestre — Les Écuries de l'Octroi

Application web de gestion pour un centre équestre : planning des cours,
cavaliers, chevaux, moniteurs, cartes d'heures, stages, balades, tâches
d'entretien, travaux, inscriptions en ligne et registre RGPD.

Pas de framework front-end : une seule page HTML (`template.html`) avec
JavaScript vanilla, servie via Vercel. Le stockage des données se fait sur
Supabase (PostgreSQL), accédé exclusivement via un proxy serverless
(`api/db.js`) — aucune clé Supabase n'est jamais envoyée au navigateur.

## Sommaire

- [Stack technique](#stack-technique)
- [Structure du projet](#structure-du-projet)
- [Installation locale](#installation-locale)
- [Variables d'environnement](#variables-denvironnement)
- [Déploiement (Vercel)](#déploiement-vercel)
- [Rôles et accès](#rôles-et-accès)
- [Fonctionnalités par rôle](#fonctionnalités-par-rôle)
- [Sécurité](#sécurité)
- [RGPD](#rgpd)
- [Documentation complémentaire](#documentation-complémentaire)

## Stack technique

| Composant       | Techno                                      |
|------------------|----------------------------------------------|
| Front-end        | HTML/CSS/JS vanilla (`template.html`), aucun framework |
| Hébergement      | Vercel (fichiers statiques + fonction serverless) |
| Backend / API    | `api/db.js` — fonction serverless Node (Vercel Functions), proxy vers Supabase |
| Base de données  | Supabase (PostgreSQL), Row Level Security activée |
| E-mails          | Resend (notifications internes) + Gmail/Nodemailer (envoi du contrat d'inscription) |
| Authentification | Mots de passe par rôle, jetons de session signés (HMAC-SHA256) |

## Structure du projet

```
centre-equestre/
├── template.html        # Source unique de l'application (HTML+CSS+JS)
├── index.html            # Généré par build.js — NE PAS éditer directement, ni committer
├── build.js               # Copie template.html → index.html, affiche les variables requises
├── api/
│   └── db.js              # Fonction serverless : auth, proxy Supabase, envoi d'e-mails, upload d'icônes
├── Signature.png           # Image utilisée dans la génération du PDF de contrat
├── favicon.ico
├── vercel.json             # Config Vercel (build, région des fonctions, réécritures d'URL)
├── package.json
├── README.md                (ce fichier)
├── DOCUMENTATION_RGPD.md     # Cartographie des données, sécurité, prestataires
└── .env.example              # Modèle des variables d'environnement à renseigner
```

**Important** : tout le code vit dans `template.html`. `index.html` est
généré automatiquement par `node build.js` et ne doit jamais être modifié ni
committé (il est dans `.gitignore`) — modifiez toujours `template.html`, puis
relancez le build.

## Installation locale

Prérequis : Node.js ≥ 16, un projet Supabase existant (tables déjà créées),
un compte Vercel pour le déploiement.

```bash
npm install
cp .env.example .env     # puis remplir .env avec vos vraies valeurs
node build.js            # génère index.html à partir de template.html
npm run dev               # build + sert le site en local sur http://localhost:3000
```

**Remarque** : en local, `api/db.js` ne fonctionne que si vous utilisez
`vercel dev` (qui simule l'environnement des fonctions serverless et charge
le `.env`). Un simple `npx serve` sert uniquement les fichiers statiques —
pratique pour vérifier l'affichage, mais les appels à `/api/db` échoueront.
Pour tester l'API en local :

```bash
npm i -g vercel
vercel dev
```

## Variables d'environnement

À définir dans Vercel → Settings → Environment Variables (et dans `.env` en
local). Voir aussi `.env.example`.

| Variable | Obligatoire | Rôle |
|---|---|---|
| `SUPABASE_URL` | ✅ | URL du projet Supabase |
| `SUPABASE_ANON` | ✅ | Clé anonyme Supabase (jamais la clé `service_role`) |
| `APP_KEY` | ✅ | Clé applicative utilisée par les policies RLS Supabase pour isoler les données de ce déploiement |
| `SESSION_SECRET` | ✅ | Secret utilisé pour signer les jetons de session (HMAC) et chiffrer les mots de passe de rôle en base. Générer avec `openssl rand -hex 32` |
| `ADMIN_PASSWORD` | Repli | Mot de passe du rôle admin tant qu'il n'a pas été redéfini depuis Paramètres > Mots de passe (alors stocké chiffré en base) |
| `MARINE_PASSWORD` | Repli | idem, rôle Marine |
| `DEV_PASSWORD` | Repli | idem, rôle Dev |
| `STAGIAIRE_PASSWORD` | Repli | idem, rôle Stagiaire (ancien nom : `BALADE_PASSWORD`, toujours accepté) |
| `TRAVAUX_PASSWORD` | Repli | idem, rôle Travaux |
| `INSCRIPTION_PASSWORD` | Repli | idem, rôle Inscription (kiosque formulaire public) |
| `GMAIL_USER` | Pour l'envoi du contrat | Adresse Gmail utilisée pour envoyer le contrat d'inscription signé |
| `GMAIL_APP_PASSWORD` | Pour l'envoi du contrat | Mot de passe d'application Gmail (pas le mot de passe du compte) |
| `RESEND_API_KEY` | Pour les notifications tickets | Clé API Resend |
| `NOTIF_EMAIL` | Pour les notifications tickets | Adresse qui reçoit les notifications de nouveaux tickets/retours |

Les variables `*_PASSWORD` sont une solution de repli : une fois qu'un mot
de passe de rôle est redéfini depuis l'application (Paramètres > Mots de
passe), c'est la version chiffrée stockée en base (table `app_credentials`)
qui prévaut.

## Déploiement (Vercel)

1. Connecter le repo à un projet Vercel.
2. Renseigner toutes les variables d'environnement ci-dessus.
3. `buildCommand` (`node build.js`) et `outputDirectory` (`.`) sont déjà
   configurés dans `vercel.json`.
4. Déployer. `vercel.json` déclare aussi une réécriture pour que
   `/politique-confidentialite` serve correctement la page.

Par défaut, les fonctions Vercel s'exécutent dans la région `iad1`
(Washington D.C., États-Unis) sauf si une région est explicitement
configurée dans `vercel.json` (`"regions"`) ou dans les paramètres du
projet Vercel — à vérifier si un hébergement strictement UE est requis
(voir `DOCUMENTATION_RGPD.md`).

## Rôles et accès

| Rôle | Accès |
|---|---|
| **admin** | Accès complet (sauf page Annonces, réservée au rôle dev) |
| **dev** | Accès complet, y compris Annonces |
| **marine** | Page Séances uniquement (+ planning public) |
| **travaux** | Page Travaux uniquement |
| **stagiaire** | Planning public, Tâches du jour, Balades (lecture) |
| **inscription** | Formulaire d'inscription public uniquement (kiosque) |
| *(aucun rôle / public)* | Planning (Vue), Tâches du jour, Balades, formulaire d'Inscription |

L'autorisation est vérifiée **côté serveur** dans `api/db.js` pour chaque
mutation (insert/update/delete) et pour la lecture des tables contenant des
données personnelles sensibles — pas seulement côté interface.

## Fonctionnalités par rôle

- **Planning (Vue)** — public, actualisation automatique + bouton manuel
- **Tâches du jour / Travaux** — checklist avec photo à l'appui (appareil
  photo), gestion des priorités
- **Cavaliers / Chevaux / Moniteurs / Groupes / Séances** — gestion
  administrative complète
- **Cartes d'heures** — suivi des heures et paiements par cavalier
- **Stages / Balades** — gestion des inscriptions et participants
- **Inscriptions en ligne** — formulaire public avec signature électronique,
  génération et envoi automatique du contrat PDF
- **Tickets / Retours** — remontées internes avec notification e-mail
- **Registre RGPD** (admin/dev) — registre de traitement + éditeur de la
  politique de confidentialité publique (avec barre d'outils de mise en
  forme, pas besoin de connaître le HTML)

## Sécurité

- Authentification par rôle, jetons signés HMAC, mots de passe chiffrés
  (AES-256-GCM) en base
- Row Level Security Supabase + filtrage applicatif par `APP_KEY`
- Aucune clé secrète Supabase (`service_role`) utilisée ni exposée au
  navigateur
- Lecture des tables sensibles (`inscriptions`, `cartes_heures`, `tickets`,
  `ticket_retours`, `travaux`) protégée côté serveur, pas seulement côté
  interface
- Droits par rôle vérifiés côté serveur pour chaque mutation

Détail complet : voir `DOCUMENTATION_RGPD.md`.

## RGPD

Le projet inclut :
- une page publique **Politique de confidentialité** (lien sur l'écran de
  connexion et sur le formulaire d'inscription, éditable depuis
  Admin/Dev → 🔒 Registre RGPD) ;
- un **registre de traitement** interne (Admin/Dev → 🔒 Registre RGPD) ;
- la documentation technique associée : `DOCUMENTATION_RGPD.md`.

Avant mise en production, complétez les informations marquées
`[À RENSEIGNER]` dans ces deux pages (coordonnées du responsable de
traitement, durées de conservation, etc.).

## Documentation complémentaire

- [`DOCUMENTATION_RGPD.md`](./DOCUMENTATION_RGPD.md) — cartographie des
  données personnelles, état de la sécurité, prestataires, ce qui reste à
  vérifier/renseigner
- [`CHANGELOG.md`](./CHANGELOG.md) — historique des correctifs de sécurité
  et de bugs apportés au projet
- [`.env.example`](./.env.example) — modèle de configuration
