# 🐴 Centre Équestre — Application de gestion

## 📁 Structure du projet

```
centre-equestre/
├── .env             ← Vos clés secrètes (à remplir, ne pas committer)
├── .gitignore       ← Protège votre .env de GitHub
├── template.html    ← Code source de l'app (avec placeholders)
├── index.html       ← Fichier généré automatiquement (ne pas modifier)
├── build.js         ← Script qui injecte le .env dans template.html
├── package.json     ← Commandes npm
└── vercel.json      ← Configuration du déploiement Vercel
```

---

## ⚙️ Configuration

Ouvrez le fichier `.env` et remplissez vos valeurs :

```env
SUPABASE_URL=https://xxxx.supabase.co
SUPABASE_ANON=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
APP_KEY=CLE_SECRETE_FRONTOFFICE
ADMIN_PASSWORD=votre_mot_de_passe
```

**Où trouver ces valeurs ?**
- `SUPABASE_URL` et `SUPABASE_ANON` → supabase.com → votre projet → Settings → API
- `APP_KEY` → la clé que vous avez définie dans vos règles RLS Supabase
- `ADMIN_PASSWORD` → choisissez librement un mot de passe pour le mode admin

---

## 🚀 Lancement en local

```bash
node build.js       # génère index.html
# puis ouvrez index.html dans votre navigateur
```

---

## ☁️ Déploiement sur Vercel

### Méthode recommandée (variables d'environnement Vercel)

Sur Vercel, **ne mettez pas votre `.env` sur GitHub**. À la place :

1. Pushez votre projet sur GitHub **sans le `.env`** (il est dans `.gitignore`)
2. Sur [vercel.com](https://vercel.com), importez le projet
3. Dans **Settings → Environment Variables**, ajoutez les 4 variables :
   - `SUPABASE_URL`
   - `SUPABASE_ANON`
   - `APP_KEY`
   - `ADMIN_PASSWORD`
4. Redéployez — Vercel exécutera `node build.js` automatiquement

### Méthode simple (fichier déjà buildé)

Si vous ne voulez pas vous occuper de GitHub/Vercel :
1. Remplissez votre `.env`
2. Lancez `node build.js` → un `index.html` est généré
3. Glissez uniquement `index.html` sur Vercel via leur interface web

---

## 🗃️ Base de données Supabase — Tables à créer

Copiez-collez ce SQL dans l'éditeur SQL de votre projet Supabase :

```sql
create table cavaliers (
  id uuid default gen_random_uuid() primary key,
  created_at timestamptz default now(),
  prenom text not null,
  present bool default true,
  app_key text
);

create table equides (
  id uuid default gen_random_uuid() primary key,
  created_at timestamptz default now(),
  nom text not null,
  heures_semaine int default 0,
  app_key text
);

create table moniteurs (
  id uuid default gen_random_uuid() primary key,
  created_at timestamptz default now(),
  prenom text not null,
  disponible bool default true,
  app_key text
);

create table cours_instances (
  id uuid default gen_random_uuid() primary key,
  created_at timestamptz default now(),
  date date,
  heure time,
  type_cours text,
  moniteur_id uuid references moniteurs(id),
  app_key text
);

create table affectations (
  id uuid default gen_random_uuid() primary key,
  created_at timestamptz default now(),
  cours_instance_id uuid references cours_instances(id),
  cavalier_id uuid references cavaliers(id),
  equide_id uuid references equides(id),
  moniteur_id uuid references moniteurs(id),
  app_key text
);
```

### Règles RLS (Row Level Security)

Activez RLS sur chaque table, puis ajoutez cette policy (remplacez `<table>` et `<VOTRE_APP_KEY>`) :

```sql
alter table <table> enable row level security;

create policy "Front-end access" on <table>
for all
using (app_key = '<VOTRE_APP_KEY>')
with check (app_key = '<VOTRE_APP_KEY>');
```

À faire pour les 5 tables : `cavaliers`, `equides`, `moniteurs`, `cours_instances`, `affectations`.
