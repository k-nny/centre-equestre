# Documentation RGPD — Centre équestre (Les Écuries de l'Octroi)

Document technique interne. Complète le **Registre RGPD** accessible dans
l'application (Admin/Dev → 🔒 Registre RGPD) et la page publique
**Politique de confidentialité** (lien sur l'écran de connexion, sur le
formulaire d'inscription, et URL directe `/politique-confidentialite`).

Le texte affiché aux familles sur ces deux pages est modifiable directement
depuis l'application (Admin/Dev → 🔒 Registre RGPD → section « Politique de
confidentialité »), sans toucher au code — ce document sert de référence
technique complémentaire, pas de source de vérité pour le texte public.

## 1. Données personnelles traitées, par table Supabase

| Table                  | Données personnelles                                                                 | Personnes concernées         |
|-------------------------|----------------------------------------------------------------------------------------|-------------------------------|
| `cavaliers`             | prénom, nom, téléphone                                                                 | Cavaliers                     |
| `inscriptions`          | identité, date de naissance, sexe, adresse, e-mail, téléphone du cavalier **et** du responsable légal, contacts d'urgence (nom, lien de parenté, téléphone), case « avis médical favorable » (donnée de santé déclarative), droit à l'image, groupe WhatsApp, signature électronique (image), numéros de chèque | Cavaliers, responsables légaux, contacts d'urgence |
| `cartes_heures`         | montant, méthode de paiement, numéro/date de règlement, liées à un `cavalier_id`        | Cavaliers / familles          |
| `stage_participants`    | prénom, téléphone, montant, méthode de paiement                                         | Cavaliers                     |
| `balade_participants`   | prénom                                                                                   | Cavaliers                     |
| `moniteurs`              | prénom                                                                                   | Moniteurs                     |
| `tickets` / `ticket_retours` | contenu libre (signalements internes), peut contenir des noms si mentionnés dans le texte | Personnel                |
| `taches_completions`, `travaux` | `fait_par` (prénom), photos éventuelles                                          | Personnel                     |
| `app_params`             | contient notamment le texte de la politique de confidentialité (`privacy_policy_html`) — pas une donnée personnelle, mentionné pour information | — |

Les autres tables (`groupes`, `seances`, `equides`, `disciplines`,
`equide_statuts`, `app_settings`, `annonces`, `discipline_icons`) ne
contiennent pas, ou pas directement, de données à caractère personnel.

## 2. Finalités

Identification des cavaliers, gestion des inscriptions et des dossiers,
organisation des cours/stages/sorties, sécurité (contacts d'urgence,
aptitude médicale déclarée), gestion des cartes d'heures et des règlements,
communication liée aux activités du centre équestre.

## 3. Row Level Security (RLS)

Toutes les tables contenant des données personnelles doivent avoir RLS
activée dans Supabase, avec une policy comparant la colonne `app_key` à la
valeur de la variable d'environnement `APP_KEY`. Ce document ne remplace
pas une vérification directe dans le dashboard Supabase (Authentication →
Policies) : à faire au moins une fois avant mise en production, en
particulier pour les tables `inscriptions`, `app_credentials` et `travaux`.

**Point de vigilance** : si `APP_KEY` (variable Vercel) a été laissée à une
valeur d'exemple générique au lieu d'une chaîne unique et secrète, vérifier
qu'elle correspond bien à la valeur utilisée dans les policies SQL — les
deux doivent être strictement identiques pour que l'application fonctionne
et que l'isolation des données soit effective.

## 4. Clés Supabase et exposition côté client

- `SUPABASE_URL`, `SUPABASE_ANON`, `APP_KEY` et `SESSION_SECRET` sont lus
  uniquement dans `api/db.js` (fonction serverless Vercel), via
  `process.env`. Le front-end (`template.html`) ne connaît que l'endpoint
  `/api/db` — aucune de ces variables n'y apparaît.
- Aucune clé `service_role` Supabase n'est utilisée dans le projet ; seule
  la clé `anon` est utilisée côté serveur, avec le filtrage applicatif par
  `app_key`.
- `build.js` ne modifie jamais `template.html` lors de la génération
  d'`index.html` : aucun secret n'est injecté dans le HTML livré au
  navigateur.

## 5. Protection des lectures sensibles (correctif de sécurité appliqué)

`api/db.js` exige un jeton de session valide (n'importe quel rôle) pour
toute lecture (`select`) sur les tables `inscriptions`, `cartes_heures`,
`tickets`, `ticket_retours`, `travaux` — en plus de la vérification déjà en
place pour les mutations (insert/update/delete). Sans cela, ces tables
étaient accessibles via un appel direct à `/api/db`, sans mot de passe,
dès lors qu'on connaissait l'URL du site : l'interface masquait ces pages,
mais l'API elle-même ne vérifiait rien pour la lecture.

Tables volontairement laissées en lecture publique (comportement voulu de
l'application, pas un oubli) : `cavaliers`, `seances`, `affectations_seance`,
`groupes`, `equides`, `moniteurs`, `stages`, `stage_participants`,
`stage_chevaux`, `balades`, `balade_participants`, `taches`,
`taches_completions`, `disciplines`, `discipline_icons`, `equide_statuts`,
`app_settings`, `app_params`, `annonces`. La page « Vue » (planning) affiche
notamment, sans connexion, les noms des cavaliers inscrits aux séances du
jour — pensé comme un affichage public (écran d'accueil/tablette). À
valider consciemment si ce n'est pas déjà fait : c'est une exposition de
données personnelles qui doit être un choix assumé du centre équestre.

## 6. Authentification et autorisations

- Mots de passe des rôles stockés chiffrés (AES-256-GCM) en base
  (`app_credentials`), clé dérivée de `SESSION_SECRET` ; repli sur les
  variables d'environnement tant qu'un mot de passe n'a pas été redéfini
  depuis l'application.
- Jetons de session signés par HMAC-SHA256 (`SESSION_SECRET`), comparaison
  en temps constant (`crypto.timingSafeEqual`).
- Les mutations vérifient le rôle **côté serveur**, pas seulement côté
  interface (ex. le rôle Travaux ne peut modifier que des champs précis de
  la table `travaux`, contrôle imposé par `api/db.js`).
- Les jetons de session n'expirent jamais tant que le mot de passe du rôle
  n'est pas changé (point de conception à connaître, pas un bug).

## 7. Prestataires (sous-traitants)

- **Vercel** — hébergement statique + fonction serverless `api/db.js`. Par
  défaut, région `iad1` (Washington D.C., États-Unis) sauf configuration
  contraire (`vercel.json` → `"regions"` ou paramètres du projet).
- **Supabase** — base de données + stockage de fichiers (icônes). Région
  dépendant du choix fait à la création du projet Supabase.
- **Resend** — envoi des notifications de tickets/retours. Données de
  compte stockées aux États-Unis d'après la documentation Resend, quelle
  que soit la région d'envoi.
- **Google / Gmail** — envoi du contrat d'inscription approuvé
  (`GMAIL_USER` / `GMAIL_APP_PASSWORD`, via `nodemailer`). Le cadre
  contractuel diffère selon qu'il s'agit d'un compte Google Workspace
  professionnel ou d'un compte Gmail grand public standard.

Le détail destiné aux familles est dans la politique de confidentialité
publique (éditable depuis l'application) ; ce document donne le détail
technique correspondant.

## 8. Cookies / traceurs

Aucun traceur tiers (Google Analytics, GTM, pixel publicitaire) dans le
projet. Seul `localStorage` est utilisé (jeton de session, rôle actif,
dernière page visitée) — strictement nécessaire au fonctionnement du
service, donc exempté de consentement d'après la doctrine CNIL. Aucune
bannière cookies n'est nécessaire.

Deux scripts externes sont chargés depuis un CDN (jsDelivr) : `jspdf` et
`html2canvas`, utilisés uniquement pour générer localement, dans le
navigateur de l'administrateur, le PDF du contrat d'inscription. Ils ne
déposent pas de traceur.