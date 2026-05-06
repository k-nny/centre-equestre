--
-- PostgreSQL database dump
--

\restrict XDoYUG7CUfuopJdRy4cW0LkP7SshXP8FCdyhWZRjiiwM4bOTnDyRrmjx6qh6j9N

-- Dumped from database version 17.6
-- Dumped by pg_dump version 18.0

-- Started on 2026-05-06 10:12:11

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 392 (class 1259 OID 22439)
-- Name: affectations_seance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.affectations_seance (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    seance_id uuid NOT NULL,
    cavalier_id uuid,
    equide_id uuid,
    absent boolean DEFAULT false,
    motif_absence text,
    rattrapage boolean DEFAULT false,
    date_rattrapage date,
    app_key text,
    rattrapage_effectue boolean DEFAULT false,
    cours_exceptionnel boolean DEFAULT false,
    nom_exceptionnel text,
    montant_exceptionnel numeric(7,2),
    regle_exceptionnel boolean DEFAULT false,
    methode_paiement_exc text,
    date_reglement_exc date,
    date_cours_rattrape date,
    cours_carte boolean DEFAULT false
);


ALTER TABLE public.affectations_seance OWNER TO postgres;

--
-- TOC entry 405 (class 1259 OID 67241)
-- Name: app_params; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.app_params (
    key text NOT NULL,
    value text NOT NULL,
    updated_at timestamp with time zone DEFAULT now(),
    app_key text
);


ALTER TABLE public.app_params OWNER TO postgres;

--
-- TOC entry 402 (class 1259 OID 51502)
-- Name: app_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.app_settings (
    key text NOT NULL,
    value text,
    app_key text
);


ALTER TABLE public.app_settings OWNER TO postgres;

--
-- TOC entry 409 (class 1259 OID 67430)
-- Name: balade_participants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.balade_participants (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    balade_id uuid,
    prenom text NOT NULL,
    equide_id uuid,
    note text,
    app_key text
);


ALTER TABLE public.balade_participants OWNER TO postgres;

--
-- TOC entry 408 (class 1259 OID 67421)
-- Name: balades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.balades (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    titre text NOT NULL,
    date date NOT NULL,
    heure time without time zone,
    nb_places integer,
    note text,
    app_key text
);


ALTER TABLE public.balades OWNER TO postgres;

--
-- TOC entry 401 (class 1259 OID 51473)
-- Name: cartes_heures; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cartes_heures (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    cavalier_id uuid,
    nb_heures numeric(5,1) NOT NULL,
    heures_utilisees numeric(5,1) DEFAULT 0,
    date_expiration date,
    created_at timestamp with time zone DEFAULT now(),
    app_key text,
    prix_heure numeric(7,2),
    prix_total numeric(7,2),
    regle boolean DEFAULT false,
    methode_paiement text,
    date_reglement date
);


ALTER TABLE public.cartes_heures OWNER TO postgres;

--
-- TOC entry 388 (class 1259 OID 22364)
-- Name: cavalier_groupes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cavalier_groupes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    cavalier_id uuid NOT NULL,
    groupe_id uuid NOT NULL,
    app_key text
);


ALTER TABLE public.cavalier_groupes OWNER TO postgres;

--
-- TOC entry 387 (class 1259 OID 22355)
-- Name: cavaliers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cavaliers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    prenom text NOT NULL,
    telephone text,
    app_key text,
    nom text,
    semaine_type text DEFAULT 'toutes'::text
);


ALTER TABLE public.cavaliers OWNER TO postgres;

--
-- TOC entry 397 (class 1259 OID 38092)
-- Name: discipline_icons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.discipline_icons (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    discipline text NOT NULL,
    icon_url text NOT NULL,
    app_key text
);


ALTER TABLE public.discipline_icons OWNER TO postgres;

--
-- TOC entry 398 (class 1259 OID 38111)
-- Name: disciplines; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.disciplines (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    nom text NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.disciplines OWNER TO postgres;

--
-- TOC entry 390 (class 1259 OID 22396)
-- Name: equide_statuts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.equide_statuts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    equide_id uuid NOT NULL,
    type text NOT NULL,
    date date NOT NULL,
    date_fin date,
    heure_debut time without time zone,
    heure_fin time without time zone,
    note text,
    app_key text
);


ALTER TABLE public.equide_statuts OWNER TO postgres;

--
-- TOC entry 389 (class 1259 OID 22384)
-- Name: equides; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.equides (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    nom text NOT NULL,
    categorie text,
    annee_naissance integer,
    heures_prev numeric(5,2) DEFAULT 0,
    hors_cours boolean DEFAULT false,
    app_key text,
    note text,
    heures_reel numeric
);


ALTER TABLE public.equides OWNER TO postgres;

--
-- TOC entry 386 (class 1259 OID 22335)
-- Name: groupes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.groupes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    nom text NOT NULL,
    jour integer NOT NULL,
    heure time without time zone NOT NULL,
    moniteur_id uuid,
    eleve_moniteur_id uuid,
    couleur text DEFAULT '#c9a84c'::text,
    note text,
    app_key text,
    icone_niveau text
);


ALTER TABLE public.groupes OWNER TO postgres;

--
-- TOC entry 385 (class 1259 OID 22324)
-- Name: moniteurs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.moniteurs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    prenom text NOT NULL,
    disponible boolean DEFAULT true,
    est_eleve_moniteur boolean DEFAULT false,
    app_key text,
    contact_stages boolean DEFAULT false
);


ALTER TABLE public.moniteurs OWNER TO postgres;

--
-- TOC entry 391 (class 1259 OID 22410)
-- Name: seances; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seances (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    groupe_id uuid,
    date date NOT NULL,
    heure time without time zone,
    discipline text,
    moniteur_id uuid,
    moniteur2_id uuid,
    moniteur2_cheval_id uuid,
    app_key text,
    nom_ponctuel text,
    couleur_ponctuel text,
    heure_fin time without time zone,
    note_seance text
);


ALTER TABLE public.seances OWNER TO postgres;

--
-- TOC entry 395 (class 1259 OID 22494)
-- Name: stage_chevaux; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stage_chevaux (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    stage_id uuid NOT NULL,
    equide_id uuid,
    demi_journee text DEFAULT 'journee'::text,
    note text,
    app_key text
);


ALTER TABLE public.stage_chevaux OWNER TO postgres;

--
-- TOC entry 394 (class 1259 OID 22474)
-- Name: stage_participants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stage_participants (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    stage_id uuid NOT NULL,
    prenom text NOT NULL,
    telephone text,
    demi_journee text DEFAULT 'journee'::text,
    equide_id uuid,
    note text,
    app_key text,
    regle boolean DEFAULT false,
    montant numeric(7,2),
    methode_paiement text,
    date_reglement date
);


ALTER TABLE public.stage_participants OWNER TO postgres;

--
-- TOC entry 393 (class 1259 OID 22465)
-- Name: stages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    titre text NOT NULL,
    date_debut date NOT NULL,
    date_fin date NOT NULL,
    notes text,
    app_key text
);


ALTER TABLE public.stages OWNER TO postgres;

--
-- TOC entry 406 (class 1259 OID 67267)
-- Name: taches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.taches (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    titre text NOT NULL,
    description text,
    frequence text DEFAULT 'quotidien'::text NOT NULL,
    jour_semaine integer,
    ordre integer DEFAULT 0,
    actif boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now(),
    app_key text
);


ALTER TABLE public.taches OWNER TO postgres;

--
-- TOC entry 407 (class 1259 OID 67279)
-- Name: taches_completions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.taches_completions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tache_id uuid,
    date date NOT NULL,
    completee boolean DEFAULT false,
    completee_par text,
    completed_at timestamp with time zone,
    app_key text
);


ALTER TABLE public.taches_completions OWNER TO postgres;

--
-- TOC entry 404 (class 1259 OID 67194)
-- Name: ticket_retours; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ticket_retours (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    ticket_id uuid,
    auteur text DEFAULT 'dev'::text NOT NULL,
    message text NOT NULL,
    lu boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    app_key text
);


ALTER TABLE public.ticket_retours OWNER TO postgres;

--
-- TOC entry 403 (class 1259 OID 59361)
-- Name: tickets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tickets (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    titre text NOT NULL,
    description text,
    type text NOT NULL,
    priorite text DEFAULT 'normale'::text,
    statut text DEFAULT 'nouveau'::text,
    created_at timestamp with time zone DEFAULT now(),
    app_key text,
    screenshot text
);


ALTER TABLE public.tickets OWNER TO postgres;

--
-- TOC entry 4011 (class 0 OID 22439)
-- Dependencies: 392
-- Data for Name: affectations_seance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.affectations_seance (id, created_at, seance_id, cavalier_id, equide_id, absent, motif_absence, rattrapage, date_rattrapage, app_key, rattrapage_effectue, cours_exceptionnel, nom_exceptionnel, montant_exceptionnel, regle_exceptionnel, methode_paiement_exc, date_reglement_exc, date_cours_rattrape, cours_carte) FROM stdin;
a24479b3-6fb8-4ca8-9e79-af2d3a216efb	2026-03-23 09:51:43.442773+00	bcfa1cdb-f190-48cc-82db-b2131505cb9f	ce4184ad-5144-4b9b-8276-0111197e0885	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
84bdcf3f-8ee7-4302-8d9d-24e2ae019eb7	2026-02-23 14:09:55.038335+00	30694148-ec94-4f41-b1d9-b1773bfed8ce	9430b606-42b0-45c9-aca3-c56c6d23d11b	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
856e121a-a797-4074-92dc-5bb13776c459	2026-02-23 14:09:55.038335+00	30694148-ec94-4f41-b1d9-b1773bfed8ce	86c197e6-24db-4d82-8572-d86b5ca15b2f	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
75b475ed-8d1d-466b-a0b5-d610311fb1cf	2026-02-23 14:09:55.038335+00	30694148-ec94-4f41-b1d9-b1773bfed8ce	00ef1cb1-a558-407b-8798-c0db3f382cb8	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9391842c-06ad-4085-bc8c-b7dec8617bea	2026-02-26 08:17:58.238936+00	5c82a8f9-39eb-488d-ac29-c1668c07b3f9	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
cc5aba6a-e886-45f0-854c-7dd1aee70af1	2026-02-23 14:09:55.571481+00	bcbea96f-86b9-451f-b811-f6fd1044247f	f6b2c3bc-2197-44c1-a848-d18a66e3fdf5	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1b355e35-46e4-4c3a-b62c-8367abdf60ed	2026-02-23 14:09:55.571481+00	bcbea96f-86b9-451f-b811-f6fd1044247f	b0054d27-f377-41ad-a026-a2893c27692a	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8b690d07-fa14-4846-904f-577c44f79cb1	2026-02-23 14:09:55.571481+00	bcbea96f-86b9-451f-b811-f6fd1044247f	1d2c9275-719e-452b-9298-ec476ac53155	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f4310801-bb5e-4a3c-a6dd-f75c0af45276	2026-02-23 14:09:55.571481+00	bcbea96f-86b9-451f-b811-f6fd1044247f	7c879cb9-b214-4851-9fb7-cd84b0698bb7	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
60d1c9ce-724a-4c6c-b128-1bb3f4c8d6d1	2026-02-23 14:09:56.091042+00	b258389e-bcbd-4667-a455-a81878116055	70610b82-10ea-46b2-a99b-59c187db69da	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9d47521e-aa54-4d0b-9378-df86ba7ac5ee	2026-02-23 14:09:56.091042+00	b258389e-bcbd-4667-a455-a81878116055	7851fd12-1e6f-4a02-b957-c2120bc0ac83	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9c07fd80-5106-4813-9402-f2c84287f582	2026-02-23 14:09:56.091042+00	b258389e-bcbd-4667-a455-a81878116055	a41687b8-6f23-46d2-abbb-285d71a1331c	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4f902d8f-d0e9-42d0-8fc7-95024ea33932	2026-02-23 14:09:56.091042+00	b258389e-bcbd-4667-a455-a81878116055	8b2745aa-d94a-48b9-be06-1aa87aac12d0	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a8c0fd7d-b2bb-4775-99f9-bede651de8a1	2026-02-23 14:09:56.091042+00	b258389e-bcbd-4667-a455-a81878116055	386cac04-cc49-4dd7-bb14-b17b9760795b	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
422db2d6-4693-473e-bd29-0872d197b5fc	2026-02-23 14:09:56.091042+00	b258389e-bcbd-4667-a455-a81878116055	ed3a44cb-388f-431a-bf56-2d35af78ea8a	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8fdb0b86-3240-4bbe-ba3c-f73aa1b63c14	2026-02-23 14:09:56.65498+00	2e38fe25-d5f7-4ff8-a88b-1c730cddfd7b	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
57f91629-ece6-40ca-99d3-2595f81a85b4	2026-02-23 14:09:56.65498+00	2e38fe25-d5f7-4ff8-a88b-1c730cddfd7b	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
56c21337-ed89-4a56-bfb4-3010bb1c9791	2026-02-23 14:40:46.312582+00	de69ecf6-d7bc-44e8-a539-cdb518a5a14c	9c87739b-74ad-47b9-a70f-6efc26c93f00	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
73199697-9331-4104-b397-9a6ef5892b3f	2026-02-23 14:09:56.65498+00	2e38fe25-d5f7-4ff8-a88b-1c730cddfd7b	d2566406-84dd-4204-a6c7-31a91107623a	\N	t	ANR	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4ec166d6-0a88-4391-a9e3-38227a415036	2026-02-23 14:09:56.65498+00	2e38fe25-d5f7-4ff8-a88b-1c730cddfd7b	e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6ef76227-f2b5-4d1d-b060-3b69e1963b96	2026-02-23 14:09:56.65498+00	2e38fe25-d5f7-4ff8-a88b-1c730cddfd7b	7374ef8e-c3b3-40aa-b6b4-7ae7159a7ce6	c6bc37d8-7c43-4ae3-9c95-4f6488a42f09	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0876c6f0-f0c2-4278-b7eb-1bb43987cce7	2026-02-23 14:40:46.312582+00	de69ecf6-d7bc-44e8-a539-cdb518a5a14c	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
fe42d925-38c1-42aa-b5cb-d602ca7d0d79	2026-02-23 14:40:46.312582+00	de69ecf6-d7bc-44e8-a539-cdb518a5a14c	ce4184ad-5144-4b9b-8276-0111197e0885	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4b9d94e3-7ecb-41df-b8b3-82ede0bfb6b8	2026-02-23 14:40:46.958514+00	48a6221e-76aa-44dc-bed5-ce24bc3c584b	9aa72019-ede1-4b37-a63b-400a20a683a7	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b39f0b1f-cbed-49d5-9b8e-09e5f436b55b	2026-02-23 14:40:47.563835+00	de5d0847-82cf-4e66-84d5-f7b1825b3274	2d98b2aa-9762-4798-8e28-fcb15c380bf5	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ef47d0ff-de33-4c97-937f-f6fdcc2289c1	2026-04-04 06:12:50.398561+00	604fb666-c6f4-4edc-94e5-9c5ff12b979d	70610b82-10ea-46b2-a99b-59c187db69da	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4ba83139-b65c-4f24-bfc2-d5f7ef956c40	2026-02-23 14:40:46.958514+00	48a6221e-76aa-44dc-bed5-ce24bc3c584b	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
edd0d6fe-7178-44b1-8659-476bbb076111	2026-02-23 14:40:46.958514+00	48a6221e-76aa-44dc-bed5-ce24bc3c584b	01fdbddd-ee76-4200-a153-47cc61d67398	\N	t	🅰️	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
599760e5-3d5b-4a76-a834-e1960332f04a	2026-02-23 14:40:46.958514+00	48a6221e-76aa-44dc-bed5-ce24bc3c584b	7dd68452-30ed-4829-857d-bebc61aff9c1	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ff9308c2-2d79-4ff2-80a6-3341678e9226	2026-02-23 14:40:47.563835+00	de5d0847-82cf-4e66-84d5-f7b1825b3274	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
cbf32e10-9f47-439b-9f7e-ae973197afde	2026-02-23 14:40:47.563835+00	de5d0847-82cf-4e66-84d5-f7b1825b3274	97a3f8b8-caff-4988-b24a-2b7e54d155ee	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
fd676909-2e3b-4f3f-93a1-7c27730cab47	2026-02-23 14:40:47.563835+00	de5d0847-82cf-4e66-84d5-f7b1825b3274	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6b3bfa48-56ae-4deb-b468-5917629db5f8	2026-02-23 14:40:47.563835+00	de5d0847-82cf-4e66-84d5-f7b1825b3274	13e202ee-272d-415f-8d66-f7669b85afb8	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ee1c22bf-3e48-48e5-ac52-914c7ce75728	2026-02-23 14:40:47.563835+00	de5d0847-82cf-4e66-84d5-f7b1825b3274	6c379005-03bc-478f-aabd-ad3f75f6477a	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d136c089-12a4-4d0a-a7ac-314035e4252a	2026-02-23 14:40:48.141246+00	fdf2c631-a3fe-434f-9319-6cc2d7c862bd	8b6e4db3-9332-457c-8e1a-ad88af0c40be	\N	t	ANR	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8522d488-73d2-4a28-a21e-2793ccdf9dd7	2026-02-23 14:40:47.563835+00	de5d0847-82cf-4e66-84d5-f7b1825b3274	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	\N	t	\N	f	2025-09-03	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
dc586b43-63bc-42b8-a676-dd41a189a1ad	2026-02-26 08:32:18.60796+00	f0712d2b-f503-40c3-b90e-df6fe70edacb	f6b2c3bc-2197-44c1-a848-d18a66e3fdf5	b6d87440-e59a-402a-81f1-4d996a9a9300	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e9315081-b9d4-4a69-8e32-0aff0cc19f91	2026-02-23 14:40:46.312582+00	de69ecf6-d7bc-44e8-a539-cdb518a5a14c	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
84455e60-12b7-4e71-a4df-2556d9f6c0da	2026-02-26 08:32:18.60796+00	f0712d2b-f503-40c3-b90e-df6fe70edacb	b0054d27-f377-41ad-a026-a2893c27692a	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4b57913f-7f51-4581-9640-487f5dc30b50	2026-02-26 08:35:19.48554+00	aad629e6-7ea6-4628-b260-dd5ff6a4f5ea	9c87739b-74ad-47b9-a70f-6efc26c93f00	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
29bc6e3b-753e-442b-9ed4-fb64377d5a3e	2026-02-26 08:32:18.60796+00	f0712d2b-f503-40c3-b90e-df6fe70edacb	1d2c9275-719e-452b-9298-ec476ac53155	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
387560e0-21f4-476f-8331-06d02a11d6eb	2026-02-26 08:32:18.60796+00	f0712d2b-f503-40c3-b90e-df6fe70edacb	7c879cb9-b214-4851-9fb7-cd84b0698bb7	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8629c692-c015-408d-bd5a-f70b43f075c9	2026-02-23 14:40:46.958514+00	48a6221e-76aa-44dc-bed5-ce24bc3c584b	1c9e7097-df1c-4540-b79b-35055f8f080f	\N	t	AND ⛔️	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5f2a4c5a-9828-40b8-8149-4f71774b9490	2026-02-26 08:35:19.48554+00	aad629e6-7ea6-4628-b260-dd5ff6a4f5ea	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
527f665d-0433-4f9e-a680-22dde03f82db	2026-02-26 08:35:19.48554+00	aad629e6-7ea6-4628-b260-dd5ff6a4f5ea	ce4184ad-5144-4b9b-8276-0111197e0885	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
420c031f-13ec-4080-bad6-180fd7504877	2026-02-26 08:35:21.083545+00	1cdde4ac-7a64-4550-9508-bac0092cc67a	8b6e4db3-9332-457c-8e1a-ad88af0c40be	\N	t	\N	f	2025-12-20	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c8467d88-3dc5-41ce-9ef3-4a9307bab9ea	2026-02-26 08:35:21.083545+00	1cdde4ac-7a64-4550-9508-bac0092cc67a	ddbca8c2-9bfd-4ab2-90d1-8c8127be9331	b6d87440-e59a-402a-81f1-4d996a9a9300	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
85f454f6-6885-45c7-985d-32f2eefea94d	2026-02-26 08:35:21.083545+00	1cdde4ac-7a64-4550-9508-bac0092cc67a	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6446ad45-33ca-4b1c-a558-11cf4bba276e	2026-02-26 08:35:21.083545+00	1cdde4ac-7a64-4550-9508-bac0092cc67a	7e7447f5-56a1-4513-9606-978058d389d5	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7205a2ba-8164-4835-8c56-b9cbb4305712	2026-02-26 08:35:21.083545+00	1cdde4ac-7a64-4550-9508-bac0092cc67a	ceb5bad4-3051-4086-ac9c-a67e6c124aee	d532c50a-26f4-4491-bcb3-e8fe9bb5105d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
de325ec9-9a09-41d9-b02b-861631823045	2026-02-26 08:53:02.000942+00	e25e7b46-4f82-4794-9be5-4bfecb733da4	386cac04-cc49-4dd7-bb14-b17b9760795b	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
91535300-72ae-49cb-ad1f-c548dad4789a	2026-02-26 09:08:21.008008+00	85967229-e0e1-4902-9062-86c70e0fc505	9aa72019-ede1-4b37-a63b-400a20a683a7	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9210729b-e1c7-4cb4-9cb2-87c6c42be57b	2026-02-26 09:27:51.132129+00	79bfb15d-03f1-4264-8f14-67ea3bf69834	9aa72019-ede1-4b37-a63b-400a20a683a7	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
96d1ad1d-5702-4ab7-af69-7b71acf531b9	2026-03-23 09:51:43.442773+00	bcfa1cdb-f190-48cc-82db-b2131505cb9f	9c87739b-74ad-47b9-a70f-6efc26c93f00	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
ea773ae3-f1cf-42d8-a64d-174628f4bce4	2026-04-03 08:24:39.364376+00	82a8c06b-8f4f-44b1-8491-4504fc06bb56	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	76876dd9-f4c0-455c-9b22-08799cc72af0	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2025-09-20	f
c139dd49-ffa4-4715-a219-50e5c1d544cd	2026-02-26 09:08:22.515337+00	de9f9356-1fd2-4d2a-aea9-584ad5b0f1ad	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
3e01aae5-3151-4e80-b4c8-e53f0a3f98e1	2026-03-23 09:51:43.442773+00	bcfa1cdb-f190-48cc-82db-b2131505cb9f	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
23ddd567-6fe3-4d7f-802e-d45331eb6009	2026-02-23 14:40:48.141246+00	fdf2c631-a3fe-434f-9319-6cc2d7c862bd	ddbca8c2-9bfd-4ab2-90d1-8c8127be9331	b6d87440-e59a-402a-81f1-4d996a9a9300	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c39c40ac-ebee-48ef-a73c-6c27dac76996	2026-02-23 14:52:23.56165+00	cd6e72e3-0a96-41bb-be86-0aa459db0c20	e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
56961751-7a03-4d55-9bbf-b90db1f14764	2026-02-23 14:40:48.141246+00	fdf2c631-a3fe-434f-9319-6cc2d7c862bd	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	\N	t	AND	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1aec598d-3bc9-4a09-8c2c-555b741c3284	2026-02-23 14:40:48.141246+00	fdf2c631-a3fe-434f-9319-6cc2d7c862bd	7e7447f5-56a1-4513-9606-978058d389d5	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7a5a7d9c-1d2e-475e-93cb-4fb4841fdf7d	2026-02-23 14:40:48.141246+00	fdf2c631-a3fe-434f-9319-6cc2d7c862bd	ceb5bad4-3051-4086-ac9c-a67e6c124aee	c48c89f9-082b-4835-9a9f-e3ee05ed3476	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
dfc26db9-4501-4c3c-8149-0ab489b8c79d	2026-02-23 14:40:48.660553+00	3ce5a94a-c352-4869-a6be-b6ac0f2cb940	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	\N	t	QUININE	f	2025-09-10	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
ff653464-81cf-4b3e-a200-08135faadc3c	2026-02-23 14:40:48.660553+00	3ce5a94a-c352-4869-a6be-b6ac0f2cb940	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
38f118f0-d88d-49f2-b183-79e7c3e3de9e	2026-02-23 14:40:48.660553+00	3ce5a94a-c352-4869-a6be-b6ac0f2cb940	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c00cb316-b0a7-4c16-a2c0-7e9b17ef7baa	2026-03-27 16:08:41.802402+00	47ce8225-99a7-44c7-8153-b17a84a2df9f	3cbd32b1-84a7-4596-92d0-903d6ea1f631	76876dd9-f4c0-455c-9b22-08799cc72af0	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
a1c6f81a-42ae-491d-ae5f-ce9ade7faa8e	2026-02-23 14:52:21.956062+00	56352309-68cf-4232-b801-c1896cfa74ed	9430b606-42b0-45c9-aca3-c56c6d23d11b	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7f690176-06d3-40dc-bb84-65dbdc8db899	2026-02-23 14:52:21.956062+00	56352309-68cf-4232-b801-c1896cfa74ed	86c197e6-24db-4d82-8572-d86b5ca15b2f	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
90fac449-66b1-41c9-bc29-5aba0b56244f	2026-02-23 14:52:21.956062+00	56352309-68cf-4232-b801-c1896cfa74ed	00ef1cb1-a558-407b-8798-c0db3f382cb8	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
648c9230-739c-4c2a-952f-b5091dc2ad36	2026-02-23 14:52:21.956062+00	56352309-68cf-4232-b801-c1896cfa74ed	a3f3ccb1-7c00-4b52-9837-dc69331b521c	\N	t	HIAOU	f	2025-11-19	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
84cef172-4a10-47ef-b276-1443735b6477	2026-02-23 14:52:22.545083+00	acee9400-ff93-4167-a857-1b5d520eeaf7	f6b2c3bc-2197-44c1-a848-d18a66e3fdf5	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d17550e2-fbbf-4d78-bdf9-0361b22c30ec	2026-02-23 14:52:22.545083+00	acee9400-ff93-4167-a857-1b5d520eeaf7	b0054d27-f377-41ad-a026-a2893c27692a	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9ceb99e0-766a-482e-b632-8885c592809c	2026-02-23 14:52:22.545083+00	acee9400-ff93-4167-a857-1b5d520eeaf7	1d2c9275-719e-452b-9298-ec476ac53155	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1bd362ae-7d90-4750-bd57-3518146efdaf	2026-02-23 14:52:22.545083+00	acee9400-ff93-4167-a857-1b5d520eeaf7	7c879cb9-b214-4851-9fb7-cd84b0698bb7	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
93b25a53-39b8-4d9a-85d1-557c84cc2949	2026-03-31 06:34:16.551613+00	9c5c0078-03e0-43c0-8b4f-468f202e6fb4	893bb307-08a3-4af2-ba54-6c5da32206ad	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
90706d33-5f6a-4c30-b2b6-46a24869894c	2026-02-23 14:52:23.044064+00	ec1f31a3-7b63-44a9-a59e-c8e0dc2f9282	70610b82-10ea-46b2-a99b-59c187db69da	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
14a8c363-f679-445c-b75b-bf30f4dd1c7f	2026-02-23 14:52:23.044064+00	ec1f31a3-7b63-44a9-a59e-c8e0dc2f9282	7851fd12-1e6f-4a02-b957-c2120bc0ac83	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e40a0014-b17d-4908-999b-39e3e617c395	2026-02-23 14:52:23.044064+00	ec1f31a3-7b63-44a9-a59e-c8e0dc2f9282	a41687b8-6f23-46d2-abbb-285d71a1331c	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2d06e0c9-1b27-4fe4-b010-9e64c770de6c	2026-02-23 14:52:23.044064+00	ec1f31a3-7b63-44a9-a59e-c8e0dc2f9282	8b2745aa-d94a-48b9-be06-1aa87aac12d0	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
597adafd-70f9-4afc-a050-7c1bc5ec5c58	2026-02-23 14:52:23.044064+00	ec1f31a3-7b63-44a9-a59e-c8e0dc2f9282	386cac04-cc49-4dd7-bb14-b17b9760795b	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
24c21a54-3d14-4b87-aed6-ab28d733fb58	2026-02-23 14:52:23.044064+00	ec1f31a3-7b63-44a9-a59e-c8e0dc2f9282	ed3a44cb-388f-431a-bf56-2d35af78ea8a	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1c964b42-e00b-4c43-b8a9-45c333b84fa8	2026-02-23 14:52:23.56165+00	cd6e72e3-0a96-41bb-be86-0aa459db0c20	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c7b5f495-edb5-4eb3-ba47-209f760dff14	2026-02-23 14:52:23.56165+00	cd6e72e3-0a96-41bb-be86-0aa459db0c20	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0ce4f66e-4514-4804-ba5a-0840476db7b1	2026-02-23 14:52:23.56165+00	cd6e72e3-0a96-41bb-be86-0aa459db0c20	7374ef8e-c3b3-40aa-b6b4-7ae7159a7ce6	c6bc37d8-7c43-4ae3-9c95-4f6488a42f09	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b1571925-408c-4ef5-85b3-7d3f99698e3b	2026-02-23 15:01:51.224147+00	e8559a96-f5e8-4945-a5b1-01bfc6ae6b82	9aa72019-ede1-4b37-a63b-400a20a683a7	\N	t	BE WIZE	f	2025-10-04	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
5ece5ecb-2d48-443e-81ae-18fafc381422	2026-02-23 15:01:50.666711+00	44ade6df-3050-47aa-a672-24d01f7c0cd8	9c87739b-74ad-47b9-a70f-6efc26c93f00	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6fe85b4e-c8eb-4a51-9c07-f46e921b8d9c	2026-02-23 15:01:52.324789+00	4479c828-5699-4868-9190-ea2d1636bff0	ddbca8c2-9bfd-4ab2-90d1-8c8127be9331	\N	t	1s/2. S.P.	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f3403c5b-f515-493b-a562-452f2266bd3e	2026-02-23 15:01:50.666711+00	44ade6df-3050-47aa-a672-24d01f7c0cd8	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e3c02acb-ca66-4531-8fe2-527e6a104630	2026-02-23 15:01:50.666711+00	44ade6df-3050-47aa-a672-24d01f7c0cd8	ce4184ad-5144-4b9b-8276-0111197e0885	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
30353357-87ed-47f7-a655-e604dd6b310b	2026-03-31 06:34:17.885435+00	9c5c0078-03e0-43c0-8b4f-468f202e6fb4	322417b3-f05a-488c-b3b6-8956e7e4413a	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
5db1edd8-c392-4a55-a98a-478fced0f294	2026-02-23 15:01:51.224147+00	e8559a96-f5e8-4945-a5b1-01bfc6ae6b82	1c9e7097-df1c-4540-b79b-35055f8f080f	\N	t	AND ⛔️	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2dcf2aa3-bd16-4c19-b389-b0963850d9e0	2026-02-23 15:01:51.224147+00	e8559a96-f5e8-4945-a5b1-01bfc6ae6b82	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
904da3b3-88b4-4b65-9908-f9f68edf1ef8	2026-02-23 15:01:51.224147+00	e8559a96-f5e8-4945-a5b1-01bfc6ae6b82	7dd68452-30ed-4829-857d-bebc61aff9c1	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
31c01d80-c2d6-49ad-b1f9-47d78f834718	2026-02-23 15:01:51.752609+00	b9293e91-2051-430b-95f2-df07d543a35d	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
10b866a5-21c0-466a-8a86-95523a736ef0	2026-02-23 15:01:51.752609+00	b9293e91-2051-430b-95f2-df07d543a35d	97a3f8b8-caff-4988-b24a-2b7e54d155ee	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
baa5823a-a584-4262-a5c9-f37f8d9269d6	2026-02-23 15:01:51.752609+00	b9293e91-2051-430b-95f2-df07d543a35d	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
082a34ef-eb82-4932-8de3-7e2737360d59	2026-02-23 15:01:51.752609+00	b9293e91-2051-430b-95f2-df07d543a35d	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0195cd35-c2d8-4c67-9cb5-15ce1d98c092	2026-02-23 15:01:51.752609+00	b9293e91-2051-430b-95f2-df07d543a35d	13e202ee-272d-415f-8d66-f7669b85afb8	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9f99bcc2-7ad2-428e-ab4f-cbd2fc0d106e	2026-02-23 15:01:51.752609+00	b9293e91-2051-430b-95f2-df07d543a35d	6c379005-03bc-478f-aabd-ad3f75f6477a	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6ea97f4a-feea-472e-b24c-efb5faf0b516	2026-02-23 15:01:51.752609+00	b9293e91-2051-430b-95f2-df07d543a35d	2d98b2aa-9762-4798-8e28-fcb15c380bf5	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
01bb8986-11f3-4c1e-bffe-d724f5cbb40a	2026-02-23 15:01:52.324789+00	4479c828-5699-4868-9190-ea2d1636bff0	8b6e4db3-9332-457c-8e1a-ad88af0c40be	d532c50a-26f4-4491-bcb3-e8fe9bb5105d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6ca05344-4e1a-446e-bf46-d03eee941c38	2026-03-31 06:34:18.477446+00	9c5c0078-03e0-43c0-8b4f-468f202e6fb4	8dab5312-dbee-4f86-83dd-0874ffc99c46	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
19206b24-d6dc-4b4a-a79d-5292dead806c	2026-02-23 15:01:52.324789+00	4479c828-5699-4868-9190-ea2d1636bff0	7e7447f5-56a1-4513-9606-978058d389d5	c48c89f9-082b-4835-9a9f-e3ee05ed3476	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
93862b00-46d6-4bf2-852b-52fefa4eab40	2026-02-23 15:01:52.324789+00	4479c828-5699-4868-9190-ea2d1636bff0	ceb5bad4-3051-4086-ac9c-a67e6c124aee	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
526ec395-7c91-497e-9453-a7010c9b8cb5	2026-02-23 15:01:52.324789+00	4479c828-5699-4868-9190-ea2d1636bff0	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7ec5bf0c-1212-457d-93be-7df1ab6acd21	2026-02-23 15:01:52.872373+00	31385a7f-e740-4fe4-96b8-7f6d6e8efa64	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c8c6c817-ef5b-4273-b694-2009da4c29f6	2026-02-23 15:01:52.872373+00	31385a7f-e740-4fe4-96b8-7f6d6e8efa64	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c50fd8dc-85a4-4cb3-a195-f144b66aecce	2026-02-23 15:01:52.872373+00	31385a7f-e740-4fe4-96b8-7f6d6e8efa64	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ea1c57b5-a525-434a-ae80-27ac22e1b3a3	2026-02-23 14:54:55.621777+00	acee9400-ff93-4167-a857-1b5d520eeaf7	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2025-09-06	f
78f1e99e-5649-4f3b-bca3-657d36198ad5	2026-03-31 06:34:19.024855+00	9c5c0078-03e0-43c0-8b4f-468f202e6fb4	8a158331-8983-4d93-8d27-616394540f3d	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
216df3a0-e612-426e-9650-50c559954e69	2026-02-23 15:01:51.224147+00	e8559a96-f5e8-4945-a5b1-01bfc6ae6b82	01fdbddd-ee76-4200-a153-47cc61d67398	\N	t	🅰️	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c6a068c2-5bfb-4b36-80e2-90ec476a70b7	2026-02-23 15:01:50.666711+00	44ade6df-3050-47aa-a672-24d01f7c0cd8	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
dea690d6-1ddc-4041-8c2a-c5ac876c4713	2026-02-23 15:06:40.06483+00	5b667016-ca2a-4a5b-b3c8-db5f5d9a131d	9430b606-42b0-45c9-aca3-c56c6d23d11b	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e1daab90-dacd-45be-b3c5-9a064ab26f5f	2026-02-23 15:06:40.06483+00	5b667016-ca2a-4a5b-b3c8-db5f5d9a131d	86c197e6-24db-4d82-8572-d86b5ca15b2f	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
81402982-780d-489f-9da5-5b9742c0ea2f	2026-02-23 15:06:40.06483+00	5b667016-ca2a-4a5b-b3c8-db5f5d9a131d	00ef1cb1-a558-407b-8798-c0db3f382cb8	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b355ec26-51f7-4fe6-9ce7-2b69a7a1e4a4	2026-02-23 15:06:40.633848+00	f32a983b-eeae-44f6-a9f0-c2decfcc7abf	f6b2c3bc-2197-44c1-a848-d18a66e3fdf5	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4712f34e-43dc-4ec3-bbed-354c5e21e700	2026-02-23 15:06:40.633848+00	f32a983b-eeae-44f6-a9f0-c2decfcc7abf	b0054d27-f377-41ad-a026-a2893c27692a	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
bbb6f07b-c0a5-4821-bde2-55ee43bd4e4c	2026-02-23 15:06:40.633848+00	f32a983b-eeae-44f6-a9f0-c2decfcc7abf	1d2c9275-719e-452b-9298-ec476ac53155	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
969e9faf-b50d-4a76-9eea-a32266ab8a8c	2026-02-23 15:06:40.633848+00	f32a983b-eeae-44f6-a9f0-c2decfcc7abf	7c879cb9-b214-4851-9fb7-cd84b0698bb7	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
46d403c1-3bec-449a-b863-f0081f7fd038	2026-02-23 15:06:41.683059+00	e51eea33-8a16-4702-9aaa-5ff0e3be42e6	e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
117ab49c-3bee-40ae-80cd-3c51ed4cb1b3	2026-02-23 15:06:41.683059+00	e51eea33-8a16-4702-9aaa-5ff0e3be42e6	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f8c4bf2a-78d5-476b-a49b-2a4593522772	2026-02-23 15:06:41.683059+00	e51eea33-8a16-4702-9aaa-5ff0e3be42e6	7374ef8e-c3b3-40aa-b6b4-7ae7159a7ce6	c6bc37d8-7c43-4ae3-9c95-4f6488a42f09	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f3763d35-8796-4bc3-9b4d-0440ee1223db	2026-02-26 08:55:14.558105+00	1bc4ac24-436c-4792-aff6-5182aba42a0a	7e7447f5-56a1-4513-9606-978058d389d5	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ac783d01-a059-4c0a-bc9c-6073f2552044	2026-02-26 09:21:45.576887+00	d2ccada8-904b-4149-828d-79adbd475c54	d2566406-84dd-4204-a6c7-31a91107623a	5e250204-ceee-4813-b935-df2600156009	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2025-09-10	f
b5da0cd7-2676-4b0b-8e65-d3cc654d521e	2026-02-26 09:23:45.096827+00	fd63b4dd-4165-4092-8cdf-2f1d33994c71	7c879cb9-b214-4851-9fb7-cd84b0698bb7	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-01-21	f
22603376-4282-4f98-b184-37871c6236be	2026-04-01 17:36:12.966329+00	28501d06-1151-454b-a3bc-ff30c768509a	893bb307-08a3-4af2-ba54-6c5da32206ad	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
b88f76b7-2c93-4b05-8c1c-6910f85cc5a3	2026-02-26 09:31:20.542435+00	79bfb15d-03f1-4264-8f14-67ea3bf69834	\N	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Nathan	\N	t	Offert	\N	\N	f
d9c285ba-2edc-4952-8600-29bd479bbf49	2026-03-04 14:09:11.367707+00	b721e3e0-3ab4-47f0-a5dd-a156f7f6f41e	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5ac05dac-b8e8-4f17-82c5-08deb506e6f7	2026-02-26 09:39:51.277038+00	c2dcf1fe-b4ad-478d-b2a7-f1918bacee42	01fdbddd-ee76-4200-a153-47cc61d67398	\N	t	RATTRAPAGE	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a73b5bfa-7af6-4da2-b076-3c70b2e6929c	2026-02-26 09:39:51.277038+00	c2dcf1fe-b4ad-478d-b2a7-f1918bacee42	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8c44c4db-b21a-429f-af20-b7db660b2688	2026-02-26 09:39:51.277038+00	c2dcf1fe-b4ad-478d-b2a7-f1918bacee42	1c9e7097-df1c-4540-b79b-35055f8f080f	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
01724b90-2a38-4643-983a-f6980bc0136c	2026-02-26 09:39:51.277038+00	c2dcf1fe-b4ad-478d-b2a7-f1918bacee42	7dd68452-30ed-4829-857d-bebc61aff9c1	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d9ae13e3-3b70-41fd-a5ac-32b3bed7fbbb	2026-02-26 09:39:52.207552+00	0d31b9de-8b27-4329-bdf0-50a3ab3fcf6d	8b6e4db3-9332-457c-8e1a-ad88af0c40be	\N	t	ANR	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
af30cab9-e1c0-41e4-b96a-9d0b49509df5	2026-02-26 09:39:52.207552+00	0d31b9de-8b27-4329-bdf0-50a3ab3fcf6d	ddbca8c2-9bfd-4ab2-90d1-8c8127be9331	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
50681fd9-5765-4094-a954-053ffc5eff42	2026-02-26 09:39:52.207552+00	0d31b9de-8b27-4329-bdf0-50a3ab3fcf6d	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4595538e-ba35-4951-a935-03f2e6689fe1	2026-02-26 09:39:52.207552+00	0d31b9de-8b27-4329-bdf0-50a3ab3fcf6d	7e7447f5-56a1-4513-9606-978058d389d5	d532c50a-26f4-4491-bcb3-e8fe9bb5105d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
80078aa2-b9f3-404e-8687-c3c9977922b6	2026-02-26 09:39:52.207552+00	0d31b9de-8b27-4329-bdf0-50a3ab3fcf6d	ceb5bad4-3051-4086-ac9c-a67e6c124aee	b6d87440-e59a-402a-81f1-4d996a9a9300	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
17193a38-c7c4-4f85-a74b-9a2122851266	2026-02-23 14:09:55.038335+00	30694148-ec94-4f41-b1d9-b1773bfed8ce	a3f3ccb1-7c00-4b52-9837-dc69331b521c	\N	t	DIAOUL	f	2025-11-12	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
fb6789db-1f4e-4d85-821b-43aa13fd45a9	2026-03-04 14:09:11.367707+00	b721e3e0-3ab4-47f0-a5dd-a156f7f6f41e	7e7447f5-56a1-4513-9606-978058d389d5	b6d87440-e59a-402a-81f1-4d996a9a9300	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
042e4876-f09f-4775-a1b2-eb7f8a19c965	2026-02-23 15:06:41.683059+00	e51eea33-8a16-4702-9aaa-5ff0e3be42e6	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	\N	t	EXKY	f	2025-11-29	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
f2e575b1-333c-4860-a90a-92c2f803f567	2026-03-04 14:09:11.367707+00	b721e3e0-3ab4-47f0-a5dd-a156f7f6f41e	ceb5bad4-3051-4086-ac9c-a67e6c124aee	d532c50a-26f4-4491-bcb3-e8fe9bb5105d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
506b264d-6c09-45ad-9764-63559d2937dd	2026-02-23 15:06:40.06483+00	5b667016-ca2a-4a5b-b3c8-db5f5d9a131d	a3f3ccb1-7c00-4b52-9837-dc69331b521c	\N	t	DIAOUL	f	2025-12-03	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
a6595375-fbfb-4579-a3e4-20179158b863	2026-02-26 08:35:19.48554+00	aad629e6-7ea6-4628-b260-dd5ff6a4f5ea	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
83607508-06ba-42e1-8c75-b19591bc5490	2026-02-26 09:39:51.277038+00	c2dcf1fe-b4ad-478d-b2a7-f1918bacee42	9aa72019-ede1-4b37-a63b-400a20a683a7	\N	t	VENOM	f	2026-01-31	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
4226394c-8591-41e8-9e25-641ecce8426f	2026-02-23 15:30:22.508725+00	82a8c06b-8f4f-44b1-8491-4504fc06bb56	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
429729c3-52b6-42a4-8b51-39446dd17b90	2026-02-26 09:27:50.666234+00	3447bd6b-755e-48df-be3e-81551e4aff05	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b5637b25-22f8-4c97-883e-5f6e52217e83	2026-02-25 09:48:12.500027+00	ce6506b4-3400-4b57-b684-5ebd3add6900	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
38c0cc84-6917-4f26-8ee6-7fc91b9b4420	2026-02-26 09:08:20.539272+00	0ad8eb46-6bb4-4808-a050-5b90fef3b9fd	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
24416996-ea97-46e1-8b36-0bf0d1f797b1	2026-02-26 08:33:49.690084+00	f0712d2b-f503-40c3-b90e-df6fe70edacb	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	d532c50a-26f4-4491-bcb3-e8fe9bb5105d	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2025-12-20	f
968424f7-50bc-4ab0-a9d1-c806275018bb	2026-03-27 16:08:42.324479+00	47ce8225-99a7-44c7-8153-b17a84a2df9f	080111ef-d8d7-4662-ba20-cd5ff1bfa389	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
0ce5adbc-d1c6-41a7-a6fe-872d390de24a	2026-03-31 13:30:35.751827+00	fa0274f2-55e2-424a-be15-f8f050991b0e	7fb3adc8-4473-43a4-84a8-c76a60e2665f	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
ce1f4cee-3175-4941-86ab-73e198c9b514	2026-03-27 09:18:44.326394+00	74914a88-5ef1-446f-80d4-7a87209eeaec	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-03-28	f
f0ed03f4-9070-4d50-9dea-e2cefafd1770	2026-03-31 15:42:54.582358+00	4cb6bb35-e1a5-4482-96d0-b332197766a7	080111ef-d8d7-4662-ba20-cd5ff1bfa389	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
9fab15aa-38d9-4c3b-b7d4-e1bd3bff279e	2026-03-31 17:31:48.342755+00	7eaed77e-0be6-41d2-af22-e3124a2a7458	322417b3-f05a-488c-b3b6-8956e7e4413a	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
eba87bb4-93eb-480c-9914-a8b0b856c4d2	2026-04-01 17:36:13.500037+00	28501d06-1151-454b-a3bc-ff30c768509a	3cbd32b1-84a7-4596-92d0-903d6ea1f631	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
d48ec582-e91a-4b4b-80e4-c4c5a4fe17be	2026-04-01 17:36:14.036774+00	28501d06-1151-454b-a3bc-ff30c768509a	080111ef-d8d7-4662-ba20-cd5ff1bfa389	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
4c3f57f6-e23e-4775-88a5-b26fd63551ff	2026-03-23 09:51:44.019294+00	f67bbea7-6b82-4f66-a99e-a40559dd54de	1c9e7097-df1c-4540-b79b-35055f8f080f	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
c638d64a-f777-4302-90f2-a5df7329f032	2026-03-23 09:51:44.019294+00	f67bbea7-6b82-4f66-a99e-a40559dd54de	01fdbddd-ee76-4200-a153-47cc61d67398	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
c6a6776d-15ec-4865-9779-b789f7c86a46	2026-03-23 09:51:44.019294+00	f67bbea7-6b82-4f66-a99e-a40559dd54de	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
24c8c4d5-e2f5-49a2-a5d7-4d664d76c1fa	2026-03-23 09:51:44.019294+00	f67bbea7-6b82-4f66-a99e-a40559dd54de	7dd68452-30ed-4829-857d-bebc61aff9c1	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f3c14eef-393b-4a71-b894-4fdb45acb75a	2026-02-26 09:40:27.456062+00	b1caa34e-dffe-4deb-90f5-516d18244bc6	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-02-07	f
04def8f8-355c-43fe-b41b-f28ebf50bcb4	2026-02-26 09:39:18.154114+00	9b32720f-f5ea-47bf-9cc5-c6b620330159	1c9e7097-df1c-4540-b79b-35055f8f080f	5e250204-ceee-4813-b935-df2600156009	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-01-31	f
372c7494-21ab-4b92-bd00-9a52b793703f	2026-02-23 15:06:41.683059+00	e51eea33-8a16-4702-9aaa-5ff0e3be42e6	d2566406-84dd-4204-a6c7-31a91107623a	\N	t	\N	f	2026-01-31	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
95780361-7ab7-41bd-9b79-fd38b2cda72c	2026-02-25 09:48:10.187011+00	2e1b56fc-f0c7-44ba-9f10-a398c4dbde04	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	\N	t	🅰️	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5556045c-de66-4aab-829d-bef47c5e0884	2026-02-26 08:47:35.22926+00	a716377a-2088-458f-aa9b-30d8095e77f0	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	\N	t	🅰️	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8fa3b4a6-1da4-4052-b7a8-4c7daa23109d	2026-02-26 09:19:08.958489+00	355c7448-e956-498c-a1cc-df3a7dca7790	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	\N	t	🅰️	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
bd03eafa-f1ea-49e7-9f5d-cbc5049acee6	2026-03-23 09:51:44.019294+00	f67bbea7-6b82-4f66-a99e-a40559dd54de	9aa72019-ede1-4b37-a63b-400a20a683a7	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
4934a025-76e9-4379-9876-b04f4e92fec5	2026-02-23 15:06:41.172065+00	8fa7160a-ebf4-4286-b6a8-0cd9b83f7cd3	70610b82-10ea-46b2-a99b-59c187db69da	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
276cc60e-a623-4dcf-ae81-1cf0deb99e2e	2026-02-23 15:06:41.172065+00	8fa7160a-ebf4-4286-b6a8-0cd9b83f7cd3	7851fd12-1e6f-4a02-b957-c2120bc0ac83	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
203d300d-d264-4d3e-98d1-e910325d89fc	2026-02-23 15:06:41.172065+00	8fa7160a-ebf4-4286-b6a8-0cd9b83f7cd3	a41687b8-6f23-46d2-abbb-285d71a1331c	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
87d4ab07-b2e2-476d-a9fa-30635dd9d2fd	2026-02-23 15:06:41.172065+00	8fa7160a-ebf4-4286-b6a8-0cd9b83f7cd3	8b2745aa-d94a-48b9-be06-1aa87aac12d0	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e30155d2-74a9-489e-918f-b344ffe736f4	2026-02-23 15:06:41.172065+00	8fa7160a-ebf4-4286-b6a8-0cd9b83f7cd3	386cac04-cc49-4dd7-bb14-b17b9760795b	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
60c55393-ce87-4f33-be94-0205b67f6a51	2026-02-23 15:06:41.172065+00	8fa7160a-ebf4-4286-b6a8-0cd9b83f7cd3	ed3a44cb-388f-431a-bf56-2d35af78ea8a	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7e6e1789-79e8-456d-b37f-56bb7d067b52	2026-02-23 15:12:55.272346+00	b1f5a2d3-034f-4e34-9f65-ddf845270a5c	7e7447f5-56a1-4513-9606-978058d389d5	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9eca4fa6-9cc8-42a2-8255-da8264351465	2026-02-23 15:12:53.564701+00	0c71fea4-6237-4d2d-b593-b7bbe71bef03	9c87739b-74ad-47b9-a70f-6efc26c93f00	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
754ff370-7374-429e-9d39-08eb78a14c04	2026-02-23 15:12:54.733551+00	b635ab3b-ad01-46e5-8088-1636e5e60a34	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6f7b28e0-c3ca-44d2-9610-03761b93ab11	2026-02-23 15:12:53.564701+00	0c71fea4-6237-4d2d-b593-b7bbe71bef03	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
469aa0f7-d752-4176-a873-abfbc0a5381d	2026-02-23 15:12:53.564701+00	0c71fea4-6237-4d2d-b593-b7bbe71bef03	ce4184ad-5144-4b9b-8276-0111197e0885	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
48b58cb5-58a6-4f50-98a1-1c6ebde2b5c9	2026-02-23 15:12:54.105163+00	f43a68a1-59b5-4e19-bbb9-5ca90c669e27	9aa72019-ede1-4b37-a63b-400a20a683a7	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
22e599fc-ad05-4cb6-b799-9c244b6a0fd7	2026-03-23 09:51:44.598945+00	ac9e2ac7-b88d-427f-b83b-2b20d22a219c	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0a8f7587-bd1f-4bc6-9a54-9e54958f58fc	2026-02-23 15:25:50.030544+00	696c75c2-7d03-4d19-8823-a1f1d2e8647c	d2566406-84dd-4204-a6c7-31a91107623a	\N	t	\N	f	2026-02-07	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e4bb4da0-6d5a-4739-a94b-af0f7afc8d22	2026-02-23 15:12:54.105163+00	f43a68a1-59b5-4e19-bbb9-5ca90c669e27	01fdbddd-ee76-4200-a153-47cc61d67398	\N	t	🅰️	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
165fc2e3-3918-46b1-b117-10116f892f3d	2026-02-23 15:12:54.105163+00	f43a68a1-59b5-4e19-bbb9-5ca90c669e27	7dd68452-30ed-4829-857d-bebc61aff9c1	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c75850f0-f1bf-4677-ab34-1dd82d47f0b9	2026-02-23 15:12:54.733551+00	b635ab3b-ad01-46e5-8088-1636e5e60a34	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
43460ce3-bd6f-4ffd-8695-9ec1ecb3f361	2026-02-23 15:12:54.733551+00	b635ab3b-ad01-46e5-8088-1636e5e60a34	97a3f8b8-caff-4988-b24a-2b7e54d155ee	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
79661988-0533-4563-aaca-d04345f7d84c	2026-02-23 15:12:54.733551+00	b635ab3b-ad01-46e5-8088-1636e5e60a34	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
797bf2f7-7d90-4172-90e2-4594776071a3	2026-02-23 15:12:54.733551+00	b635ab3b-ad01-46e5-8088-1636e5e60a34	13e202ee-272d-415f-8d66-f7669b85afb8	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
53c03c6e-b892-46d9-9f68-35b6de3d7e83	2026-02-23 15:12:54.733551+00	b635ab3b-ad01-46e5-8088-1636e5e60a34	6c379005-03bc-478f-aabd-ad3f75f6477a	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e2cacac8-32b6-43ad-bea3-306eb0c66a51	2026-02-23 15:12:54.733551+00	b635ab3b-ad01-46e5-8088-1636e5e60a34	2d98b2aa-9762-4798-8e28-fcb15c380bf5	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
58b97d8e-4e01-4913-aef6-85b74f8ec62b	2026-02-23 15:12:55.272346+00	b1f5a2d3-034f-4e34-9f65-ddf845270a5c	8b6e4db3-9332-457c-8e1a-ad88af0c40be	c48c89f9-082b-4835-9a9f-e3ee05ed3476	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
640fb989-05e1-4abe-b385-6402ba39f484	2026-02-23 15:12:55.272346+00	b1f5a2d3-034f-4e34-9f65-ddf845270a5c	ddbca8c2-9bfd-4ab2-90d1-8c8127be9331	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
88b6efc5-5e07-4fa0-b7ce-4359734fe2a8	2026-02-23 15:12:55.272346+00	b1f5a2d3-034f-4e34-9f65-ddf845270a5c	ceb5bad4-3051-4086-ac9c-a67e6c124aee	b6d87440-e59a-402a-81f1-4d996a9a9300	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
de6e3b3e-622f-4abd-a5f6-cfb52de55d96	2026-02-23 15:12:55.813801+00	f1f53439-b535-4cfe-9289-a14fd665a064	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5411da39-4e28-40ae-9c12-5e36ab16d6c3	2026-02-23 15:12:55.813801+00	f1f53439-b535-4cfe-9289-a14fd665a064	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
51b2bace-ab08-4a1c-b099-5fbdc6658d2a	2026-02-23 15:12:55.813801+00	f1f53439-b535-4cfe-9289-a14fd665a064	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5ba19d65-4a2b-4e6e-80b9-e2ec345e829b	2026-02-23 15:25:49.482896+00	66ef7a72-791c-4da0-a7cb-6f38fc602989	8b2745aa-d94a-48b9-be06-1aa87aac12d0	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0380a187-1d03-46c0-9859-b7d9c8c35532	2026-02-23 15:25:49.482896+00	66ef7a72-791c-4da0-a7cb-6f38fc602989	386cac04-cc49-4dd7-bb14-b17b9760795b	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
746a2c13-1686-44e7-a518-1ef0c1bdb431	2026-03-27 16:10:54.821152+00	f9032505-6437-443d-afba-7fd48f7e424d	322417b3-f05a-488c-b3b6-8956e7e4413a	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
cd658c62-1691-410f-bac2-86bba51621cd	2026-02-23 15:25:48.357973+00	bc9e084a-ebac-4afa-a2d7-83398edfedeb	9430b606-42b0-45c9-aca3-c56c6d23d11b	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
787d3ab5-635f-4b8d-af9e-a55bc65f8033	2026-02-23 15:25:48.357973+00	bc9e084a-ebac-4afa-a2d7-83398edfedeb	86c197e6-24db-4d82-8572-d86b5ca15b2f	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9032adda-b4af-4448-91c0-a2d995d63868	2026-02-23 15:25:48.357973+00	bc9e084a-ebac-4afa-a2d7-83398edfedeb	00ef1cb1-a558-407b-8798-c0db3f382cb8	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f9f97b6e-12c0-4b36-a571-c2741a4ec167	2026-02-23 15:25:50.030544+00	696c75c2-7d03-4d19-8823-a1f1d2e8647c	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	\N	t	JALOUSE	f	2025-12-06	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
908b06bf-9920-473d-8258-cb50f1a02262	2026-02-23 15:25:48.900239+00	026c203e-89d8-452f-9325-9d4141a6c008	f6b2c3bc-2197-44c1-a848-d18a66e3fdf5	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5b291777-fcd2-4299-b3c9-21e600f1428f	2026-02-23 15:25:48.900239+00	026c203e-89d8-452f-9325-9d4141a6c008	b0054d27-f377-41ad-a026-a2893c27692a	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
db89d793-49d9-4758-9964-f1ebebcd777b	2026-02-23 15:25:48.900239+00	026c203e-89d8-452f-9325-9d4141a6c008	1d2c9275-719e-452b-9298-ec476ac53155	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0d7a8d09-4136-4fff-b9ef-c741dbc0fb7c	2026-02-23 15:25:48.900239+00	026c203e-89d8-452f-9325-9d4141a6c008	7c879cb9-b214-4851-9fb7-cd84b0698bb7	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c33fd68a-8bd0-452c-909f-da2903565c81	2026-02-23 15:25:49.482896+00	66ef7a72-791c-4da0-a7cb-6f38fc602989	70610b82-10ea-46b2-a99b-59c187db69da	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
08784dec-1403-4bf0-b3ed-7598dc26e12a	2026-02-23 15:25:49.482896+00	66ef7a72-791c-4da0-a7cb-6f38fc602989	7851fd12-1e6f-4a02-b957-c2120bc0ac83	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
3daddc79-a0c6-4c32-a7d5-fcf7084b8b9e	2026-02-23 15:25:49.482896+00	66ef7a72-791c-4da0-a7cb-6f38fc602989	a41687b8-6f23-46d2-abbb-285d71a1331c	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e8e8bda8-07b3-45ed-9adf-0919ec7eabd4	2026-02-23 15:25:48.357973+00	bc9e084a-ebac-4afa-a2d7-83398edfedeb	a3f3ccb1-7c00-4b52-9837-dc69331b521c	\N	t	HIAOU	f	2026-01-14	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
625c26c4-edb2-4e14-8669-4c4eac1edf13	2026-02-23 15:12:55.272346+00	b1f5a2d3-034f-4e34-9f65-ddf845270a5c	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
71f59b75-fe9b-4942-981a-dbfa69df74a6	2026-02-23 15:25:50.030544+00	696c75c2-7d03-4d19-8823-a1f1d2e8647c	e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5419c01d-b3ce-4ae3-9f3f-1c9edfb35486	2026-02-23 15:25:50.030544+00	696c75c2-7d03-4d19-8823-a1f1d2e8647c	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
be226eca-f145-4242-94a3-1dcff4d7d69e	2026-02-23 15:25:50.030544+00	696c75c2-7d03-4d19-8823-a1f1d2e8647c	7374ef8e-c3b3-40aa-b6b4-7ae7159a7ce6	c6bc37d8-7c43-4ae3-9c95-4f6488a42f09	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
137f373d-d2c9-4321-8bab-28e8a9e52ff3	2026-02-23 15:12:53.564701+00	0c71fea4-6237-4d2d-b593-b7bbe71bef03	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
3ae1a90a-8bf8-4ecc-a9b6-0596e2711735	2026-02-26 08:21:05.032937+00	d5913a3d-10e7-48e3-9ca4-0efeae5f9711	86c197e6-24db-4d82-8572-d86b5ca15b2f	\N	t	AND	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ed3bb923-bdb7-45c8-a4d3-9b8f977a90bb	2026-03-23 09:51:44.598945+00	ac9e2ac7-b88d-427f-b83b-2b20d22a219c	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e7695730-260c-446e-9762-38f301e57ab8	2026-02-23 15:30:22.508725+00	82a8c06b-8f4f-44b1-8491-4504fc06bb56	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8d16d60b-3076-4b2d-b1ae-3845b1c03f25	2026-02-23 15:30:22.508725+00	82a8c06b-8f4f-44b1-8491-4504fc06bb56	ce4184ad-5144-4b9b-8276-0111197e0885	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
474cc2a3-f7e8-4bac-bf1c-31b72ede0591	2026-02-23 15:25:49.482896+00	66ef7a72-791c-4da0-a7cb-6f38fc602989	ed3a44cb-388f-431a-bf56-2d35af78ea8a	\N	t	ANR ⛔️. Pas de date de rattrapage.	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
70dcb848-6ed5-43ba-93e2-8d6333fa122d	2026-03-31 13:30:36.015638+00	fa0274f2-55e2-424a-be15-f8f050991b0e	19dfcd2c-5aaf-4e09-ac63-9856393cfb3c	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
a341581b-65f8-4c0d-a110-a7b2db6bce89	2026-03-31 15:42:55.303258+00	4cb6bb35-e1a5-4482-96d0-b332197766a7	8dab5312-dbee-4f86-83dd-0874ffc99c46	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
8f79a938-e58e-40b3-830c-ad2c330b6e4a	2026-03-31 17:34:27.60603+00	c48eefd6-ffc9-418e-817c-ef860de8f966	3cbd32b1-84a7-4596-92d0-903d6ea1f631	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
27ba316c-c6d8-4d38-bbb0-8ae3ed31bf77	2026-02-23 15:30:23.033891+00	25a1e016-96c3-48d9-826a-445ce02d1374	9aa72019-ede1-4b37-a63b-400a20a683a7	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7472d04e-2ef6-4665-af9f-0418f220b886	2026-03-06 08:56:14.527598+00	bacdb2e9-0db8-4cca-8aad-3920c22e2cb5	8b2745aa-d94a-48b9-be06-1aa87aac12d0	\N	t	AND ⛔️	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a1b09005-8fe9-48f3-9144-88f795fe9743	2026-02-23 15:30:23.033891+00	25a1e016-96c3-48d9-826a-445ce02d1374	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
01009aee-e274-4cf5-9784-971d712f722c	2026-02-23 15:30:23.033891+00	25a1e016-96c3-48d9-826a-445ce02d1374	1c9e7097-df1c-4540-b79b-35055f8f080f	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
3694ad09-44b1-4a01-89a2-5557f48f8e42	2026-02-23 15:30:23.033891+00	25a1e016-96c3-48d9-826a-445ce02d1374	7dd68452-30ed-4829-857d-bebc61aff9c1	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
88591a32-9c3c-43ca-aaf9-6fbd4dd91a25	2026-02-23 15:30:23.561793+00	5e9e8a31-d32e-467b-978d-bcab5c9b8628	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b3fd094d-39c9-4a1e-b774-85587b6f4577	2026-02-23 15:30:23.561793+00	5e9e8a31-d32e-467b-978d-bcab5c9b8628	97a3f8b8-caff-4988-b24a-2b7e54d155ee	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9138a043-891d-436f-b9e5-d4163d614ec2	2026-02-23 15:30:23.561793+00	5e9e8a31-d32e-467b-978d-bcab5c9b8628	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
24e57438-2a5b-431c-b034-7422160aec17	2026-02-23 15:30:23.561793+00	5e9e8a31-d32e-467b-978d-bcab5c9b8628	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
931045b3-6b4c-42df-acf0-ba6fa0b47132	2026-02-23 15:30:23.561793+00	5e9e8a31-d32e-467b-978d-bcab5c9b8628	6c379005-03bc-478f-aabd-ad3f75f6477a	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
cc0a3476-5d38-4498-8dc5-4a51e82bb652	2026-02-23 15:30:23.561793+00	5e9e8a31-d32e-467b-978d-bcab5c9b8628	2d98b2aa-9762-4798-8e28-fcb15c380bf5	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9d5a44b1-1f8d-4d97-b91b-999d49e2f569	2026-02-23 15:30:24.641862+00	c301dd0c-0478-4fec-afae-99f2ed6778ab	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
431d655c-b91d-4333-b89f-39068a7b61b2	2026-02-23 15:30:24.641862+00	c301dd0c-0478-4fec-afae-99f2ed6778ab	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
125bdf4e-8423-470e-ad1d-5a7af13ab656	2026-02-23 15:30:24.641862+00	c301dd0c-0478-4fec-afae-99f2ed6778ab	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6acc0cca-26d3-4927-befd-0cc6905a64bc	2026-02-26 09:24:10.721567+00	caaafdef-03ae-40c7-be51-4b842d2d14b7	a3f3ccb1-7c00-4b52-9837-dc69331b521c	\N	t	ANR	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c8b7ddb9-57c7-490c-be72-4eec81b75888	2026-02-26 08:21:05.032937+00	d5913a3d-10e7-48e3-9ca4-0efeae5f9711	a3f3ccb1-7c00-4b52-9837-dc69331b521c	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a33fce9b-5a47-4efb-af6e-5fa37751ae18	2026-02-26 09:21:59.955056+00	d2ccada8-904b-4149-828d-79adbd475c54	\N	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Clémentine	\N	t	Offert	\N	\N	f
002da571-5127-45da-941a-96c22a10f402	2026-02-26 08:21:05.032937+00	d5913a3d-10e7-48e3-9ca4-0efeae5f9711	00ef1cb1-a558-407b-8798-c0db3f382cb8	\N	t	AND	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4c9662b1-10ed-4f2a-8bf4-adec90f6127f	2026-02-26 08:58:18.948335+00	51dd6893-2456-4c8d-a80c-2db452619567	70610b82-10ea-46b2-a99b-59c187db69da	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c6371a9d-1246-4e7a-bc12-b799c35689cd	2026-02-26 08:58:18.948335+00	51dd6893-2456-4c8d-a80c-2db452619567	a41687b8-6f23-46d2-abbb-285d71a1331c	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0a622e61-caeb-4f6a-ada4-73ffe77103d5	2026-02-26 08:58:18.948335+00	51dd6893-2456-4c8d-a80c-2db452619567	7851fd12-1e6f-4a02-b957-c2120bc0ac83	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d61e5463-f332-47b2-94b6-b03c2bc111a5	2026-02-26 08:58:18.948335+00	51dd6893-2456-4c8d-a80c-2db452619567	8b2745aa-d94a-48b9-be06-1aa87aac12d0	\N	t	RATTRAPAGE	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e00a3769-8ee1-42b6-a6b4-b884d1354f8f	2026-02-26 08:58:18.948335+00	51dd6893-2456-4c8d-a80c-2db452619567	386cac04-cc49-4dd7-bb14-b17b9760795b	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
cc51e582-f3c4-4edd-8030-70467ddf6ab9	2026-02-26 08:58:18.948335+00	51dd6893-2456-4c8d-a80c-2db452619567	ed3a44cb-388f-431a-bf56-2d35af78ea8a	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c83dbdc3-9a6e-4902-a917-1fc1f237dae0	2026-02-26 09:10:48.781119+00	85967229-e0e1-4902-9062-86c70e0fc505	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2025-12-13	f
7b76a142-d8bd-460e-8f04-721ebd0c9f51	2026-02-26 09:24:10.721567+00	caaafdef-03ae-40c7-be51-4b842d2d14b7	9430b606-42b0-45c9-aca3-c56c6d23d11b	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
680a3985-4289-4dbf-bc69-5e96543583dd	2026-02-26 09:24:10.721567+00	caaafdef-03ae-40c7-be51-4b842d2d14b7	86c197e6-24db-4d82-8572-d86b5ca15b2f	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
bcec98fa-21ce-4967-9cc8-4e54eab3599b	2026-02-26 09:24:10.721567+00	caaafdef-03ae-40c7-be51-4b842d2d14b7	00ef1cb1-a558-407b-8798-c0db3f382cb8	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
091eb553-4a6c-4551-b58b-e4f864120bf6	2026-02-26 09:24:11.770854+00	86deb28f-b6ef-464e-89db-9a89ac6282b1	70610b82-10ea-46b2-a99b-59c187db69da	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e300ac26-6004-4cbb-90c4-56d5d07c72fd	2026-02-26 09:24:11.770854+00	86deb28f-b6ef-464e-89db-9a89ac6282b1	7851fd12-1e6f-4a02-b957-c2120bc0ac83	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8cb77309-13eb-439c-af71-dabab402cf02	2026-02-26 09:24:11.770854+00	86deb28f-b6ef-464e-89db-9a89ac6282b1	a41687b8-6f23-46d2-abbb-285d71a1331c	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9d81d9c8-27c7-418d-9854-cf98775e03ca	2026-02-26 09:24:11.770854+00	86deb28f-b6ef-464e-89db-9a89ac6282b1	8b2745aa-d94a-48b9-be06-1aa87aac12d0	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
68d56cba-2bc6-437d-98db-45c43ddc622f	2026-02-26 09:24:11.770854+00	86deb28f-b6ef-464e-89db-9a89ac6282b1	386cac04-cc49-4dd7-bb14-b17b9760795b	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c8e4a929-5810-4e99-ac3d-a65d1b412531	2026-02-26 09:24:11.770854+00	86deb28f-b6ef-464e-89db-9a89ac6282b1	ed3a44cb-388f-431a-bf56-2d35af78ea8a	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
da324df4-a272-473c-aa39-74a4725feeef	2026-02-26 09:36:21.367335+00	3d18a280-48c7-4a3b-95a7-1a3b3504d907	e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
893886f6-11d6-4d50-900f-cc602908bf04	2026-02-26 08:35:20.574832+00	b57de755-f67c-4031-af22-277377011cf7	97a3f8b8-caff-4988-b24a-2b7e54d155ee	\N	t	RATTRAPAGE	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
9b2bf360-07d6-4042-a82c-4c2b195c7fe2	2026-02-23 15:30:23.561793+00	5e9e8a31-d32e-467b-978d-bcab5c9b8628	13e202ee-272d-415f-8d66-f7669b85afb8	\N	t	EXKY	f	2025-10-04	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
75627138-2134-4b73-8f72-2740ecc158f9	2026-02-25 09:48:09.549819+00	f0860785-fe45-4b7d-90d3-ecf45fcf770f	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	\N	t	CHARLY	f	2025-11-12	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
6f93b333-803d-4ac3-9611-8359d2678985	2026-03-23 09:51:44.598945+00	ac9e2ac7-b88d-427f-b83b-2b20d22a219c	2d98b2aa-9762-4798-8e28-fcb15c380bf5	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9c2d8bcc-3415-429b-bd8c-e8fca98a0a78	2026-03-06 08:56:14.527598+00	bacdb2e9-0db8-4cca-8aad-3920c22e2cb5	70610b82-10ea-46b2-a99b-59c187db69da	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
459256e9-0385-43b0-b323-d05710076f19	2026-02-26 09:32:01.572578+00	79bfb15d-03f1-4264-8f14-67ea3bf69834	d2566406-84dd-4204-a6c7-31a91107623a	c6bc37d8-7c43-4ae3-9c95-4f6488a42f09	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2025-09-17	f
c989f9d1-8559-46a0-a5a8-f3c7594a66a8	2026-03-06 08:56:14.527598+00	bacdb2e9-0db8-4cca-8aad-3920c22e2cb5	a41687b8-6f23-46d2-abbb-285d71a1331c	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c8be5ff7-3bd3-4558-99db-30420f601090	2026-03-06 08:56:14.527598+00	bacdb2e9-0db8-4cca-8aad-3920c22e2cb5	7851fd12-1e6f-4a02-b957-c2120bc0ac83	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4d12b811-b0d7-415c-84fe-4e98f71feb7d	2026-02-26 09:08:21.995857+00	287cb5c5-9f6f-418b-9d73-7a4c8137126b	ddbca8c2-9bfd-4ab2-90d1-8c8127be9331	\N	t	1s/2. S.P.	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c1cdfec8-5642-464b-b76f-a60933c2aaa3	2026-03-31 13:35:17.728476+00	bd080027-1aa2-4c42-8f8c-0bdc23ab9887	893bb307-08a3-4af2-ba54-6c5da32206ad	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
c1921ae6-01e4-4f02-986d-e84627572e00	2026-03-31 16:49:00.794924+00	bf7dc421-1745-4455-a7b3-5abc17d0a3e1	aaedc900-37ff-4b01-88cb-82c36deffca8	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
10c4d3cd-6195-4648-a5cf-bc3660ee6880	2026-03-31 16:49:02.11777+00	bf7dc421-1745-4455-a7b3-5abc17d0a3e1	466a4031-fc42-48c9-88c5-1a1925e19912	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
c23128ea-950a-4434-b0f7-228899d4c8c8	2026-03-31 16:49:02.855322+00	bf7dc421-1745-4455-a7b3-5abc17d0a3e1	8a158331-8983-4d93-8d27-616394540f3d	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
5dbb3db6-d09e-485f-987b-b782437a6dab	2026-03-31 17:34:28.191383+00	c48eefd6-ffc9-418e-817c-ef860de8f966	080111ef-d8d7-4662-ba20-cd5ff1bfa389	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
f4a668b6-ec58-4021-b968-222adec27eaf	2026-04-01 17:36:14.602733+00	28501d06-1151-454b-a3bc-ff30c768509a	aaedc900-37ff-4b01-88cb-82c36deffca8	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
71769b8a-1630-4dfc-a81f-c86210157195	2026-04-02 10:32:04.800512+00	11527b8f-faf1-4400-baea-63574f55633b	19dfcd2c-5aaf-4e09-ac63-9856393cfb3c	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
ca5795f2-1623-47e3-b6b5-6dccc3e8b994	2026-04-02 10:32:05.500445+00	11527b8f-faf1-4400-baea-63574f55633b	8dab5312-dbee-4f86-83dd-0874ffc99c46	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
d37e9a9b-802f-4f4a-af42-d48b5b853a14	2026-04-02 10:32:05.982096+00	11527b8f-faf1-4400-baea-63574f55633b	893bb307-08a3-4af2-ba54-6c5da32206ad	835b104d-b18b-4876-ba72-ffea56c43563	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
d1a726f2-6369-47bb-a197-d9ae6a62527f	2026-03-23 09:51:44.598945+00	ac9e2ac7-b88d-427f-b83b-2b20d22a219c	6c379005-03bc-478f-aabd-ad3f75f6477a	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
33aff14d-d984-405d-b7c5-c89c0ba8be27	2026-03-23 09:51:44.598945+00	ac9e2ac7-b88d-427f-b83b-2b20d22a219c	97a3f8b8-caff-4988-b24a-2b7e54d155ee	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
12ec7165-6687-4ddb-a339-921d6385b98e	2026-02-23 15:30:23.033891+00	25a1e016-96c3-48d9-826a-445ce02d1374	01fdbddd-ee76-4200-a153-47cc61d67398	\N	t	🅰️	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8c7118e3-d89b-4fc2-a9e6-0506dc52a385	2026-02-23 15:30:22.508725+00	82a8c06b-8f4f-44b1-8491-4504fc06bb56	9c87739b-74ad-47b9-a70f-6efc26c93f00	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8888b350-d0db-4eac-80e6-446f9ea6739b	2026-02-24 09:13:09.285818+00	7665c054-298a-4e8c-b24e-1e73732beb7d	9c87739b-74ad-47b9-a70f-6efc26c93f00	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
65267ea7-7ddd-4214-bf16-e9ea25c7dfff	2026-02-23 15:30:24.127982+00	e0f938e9-769a-4090-95bc-c24b78c5bb0b	8b6e4db3-9332-457c-8e1a-ad88af0c40be	\N	t	1s/2. S.P.	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
39ead8aa-eb35-4f22-b3ba-feb24775ca33	2026-02-23 15:30:24.127982+00	e0f938e9-769a-4090-95bc-c24b78c5bb0b	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4a9677a6-bd24-4178-9093-c4aa8d0a2815	2026-02-23 15:30:24.127982+00	e0f938e9-769a-4090-95bc-c24b78c5bb0b	7e7447f5-56a1-4513-9606-978058d389d5	b6d87440-e59a-402a-81f1-4d996a9a9300	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7bf71705-e51b-4f77-b43f-e208e7d0f035	2026-02-23 15:30:24.127982+00	e0f938e9-769a-4090-95bc-c24b78c5bb0b	ceb5bad4-3051-4086-ac9c-a67e6c124aee	d532c50a-26f4-4491-bcb3-e8fe9bb5105d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
967f390f-87f4-4bba-a0e0-1bfe57c42aac	2026-02-23 15:38:13.749067+00	5c6f79e8-04b1-4e75-8e11-b3796d2ded92	b0054d27-f377-41ad-a026-a2893c27692a	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
80fe20a0-91de-4aa3-885e-2974325e7d02	2026-03-27 16:10:55.37464+00	f9032505-6437-443d-afba-7fd48f7e424d	8a158331-8983-4d93-8d27-616394540f3d	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
9656e689-aea1-4216-82ee-5955776d87ed	2026-02-23 15:38:15.494998+00	a5ba1f81-de78-4de0-bf9d-c8d2a728eab2	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
53b117e3-237a-4a57-94fd-698bab9c9be9	2026-02-24 09:13:09.285818+00	7665c054-298a-4e8c-b24e-1e73732beb7d	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e213a6d1-2b22-4de6-9cef-4e32d5a3ea36	2026-02-23 15:38:13.027754+00	9dbdc39c-c7d7-44b5-9030-95a55121370d	86c197e6-24db-4d82-8572-d86b5ca15b2f	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e47e1c06-84dd-4dee-833a-4b77f2a8cc88	2026-02-24 08:24:45.100082+00	acee9400-ff93-4167-a857-1b5d520eeaf7	\N	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Lisette	30.00	t	Chèque	\N	\N	f
07bb1125-5e87-45ef-b86e-729c0b579265	2026-02-24 08:26:00.235472+00	f32a983b-eeae-44f6-a9f0-c2decfcc7abf	\N	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Thaïssa	30.00	t	Espèces	\N	\N	f
888a4160-4e6d-48a8-9823-3df108edf56b	2026-02-24 09:13:09.285818+00	7665c054-298a-4e8c-b24e-1e73732beb7d	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	\N	t	AND	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
634a23e9-aca1-44b3-a722-3e89b7fd5047	2026-02-24 09:13:09.973918+00	7a8b218d-0f7d-4c19-a8e2-921d5515f4d9	01fdbddd-ee76-4200-a153-47cc61d67398	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ad210f33-fc6b-4937-9593-09ed95c8a887	2026-02-24 09:13:09.973918+00	7a8b218d-0f7d-4c19-a8e2-921d5515f4d9	1c9e7097-df1c-4540-b79b-35055f8f080f	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
15243e00-cdaa-4eb0-a7d0-bd6cba58b3e4	2026-02-24 09:13:09.973918+00	7a8b218d-0f7d-4c19-a8e2-921d5515f4d9	7dd68452-30ed-4829-857d-bebc61aff9c1	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a3b65f4a-b7e9-4dc5-97de-8cc195734932	2026-02-24 09:13:10.710641+00	e42487f9-0eed-4e72-ba57-7d45bfb144f4	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e735dee7-f872-4d9a-9515-66fd215c0bc2	2026-02-24 09:13:10.710641+00	e42487f9-0eed-4e72-ba57-7d45bfb144f4	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
670e63df-1653-452c-b43d-720da2c452bf	2026-02-24 09:13:10.710641+00	e42487f9-0eed-4e72-ba57-7d45bfb144f4	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ef3a4d1d-81d6-431b-b4a4-655007c34711	2026-02-23 15:38:14.501128+00	886c9056-eb44-4ccc-8cfc-d0b33b50e218	7851fd12-1e6f-4a02-b957-c2120bc0ac83	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
fe08d218-a7cb-4220-9dc7-939453864c28	2026-02-23 15:30:24.127982+00	e0f938e9-769a-4090-95bc-c24b78c5bb0b	ddbca8c2-9bfd-4ab2-90d1-8c8127be9331	\N	t	1s/2. S.P.	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
806062de-177e-4701-90bd-649821c418f0	2026-02-24 09:13:09.973918+00	7a8b218d-0f7d-4c19-a8e2-921d5515f4d9	9aa72019-ede1-4b37-a63b-400a20a683a7	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
50738163-1813-4d09-abb0-fdf16ea9dcd8	2026-02-24 09:13:10.710641+00	e42487f9-0eed-4e72-ba57-7d45bfb144f4	13e202ee-272d-415f-8d66-f7669b85afb8	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
452c0214-dbc7-4ca3-a5ee-fb3abe013ece	2026-02-24 09:13:10.710641+00	e42487f9-0eed-4e72-ba57-7d45bfb144f4	6c379005-03bc-478f-aabd-ad3f75f6477a	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2ff0711b-cf65-4775-9804-eced06ba071a	2026-02-24 09:13:10.710641+00	e42487f9-0eed-4e72-ba57-7d45bfb144f4	2d98b2aa-9762-4798-8e28-fcb15c380bf5	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b72e16aa-342b-4f1e-8f80-3953bd243e55	2026-02-24 09:13:10.710641+00	e42487f9-0eed-4e72-ba57-7d45bfb144f4	97a3f8b8-caff-4988-b24a-2b7e54d155ee	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d62800d3-5558-4cb9-9ad3-a45c421e46b1	2026-02-24 09:13:11.350476+00	ca4b5db9-b467-4c20-b575-f0ca3bf1642b	8b6e4db3-9332-457c-8e1a-ad88af0c40be	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
80cc9b98-4126-4eab-a12a-49c309d18ec1	2026-02-24 09:13:11.350476+00	ca4b5db9-b467-4c20-b575-f0ca3bf1642b	ddbca8c2-9bfd-4ab2-90d1-8c8127be9331	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9ce7b116-b619-424a-8122-6f90804296d4	2026-02-24 09:13:11.350476+00	ca4b5db9-b467-4c20-b575-f0ca3bf1642b	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9d15df26-51c8-496b-8a9d-90816690d263	2026-02-24 09:13:11.350476+00	ca4b5db9-b467-4c20-b575-f0ca3bf1642b	7e7447f5-56a1-4513-9606-978058d389d5	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
eda277e9-773f-4e5e-b9ed-f084b7aedb64	2026-02-24 09:13:11.350476+00	ca4b5db9-b467-4c20-b575-f0ca3bf1642b	ceb5bad4-3051-4086-ac9c-a67e6c124aee	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2eccc863-0092-4de3-b35a-dd8a57d389d6	2026-02-24 09:13:11.996323+00	69f5290b-889e-40e1-abf8-258e2e7946f7	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b95844a5-68c6-4d86-ad18-b9ba86a2d02a	2026-02-24 09:13:11.996323+00	69f5290b-889e-40e1-abf8-258e2e7946f7	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
694952fc-e192-4e28-af66-0b500bc9fe00	2026-02-26 08:21:05.530989+00	555ccb27-8d80-4e2b-b5b9-aea2ed283984	b0054d27-f377-41ad-a026-a2893c27692a	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b6bf067d-2030-45fa-a9a0-b40f14cd7a3d	2026-02-26 08:21:05.530989+00	555ccb27-8d80-4e2b-b5b9-aea2ed283984	1d2c9275-719e-452b-9298-ec476ac53155	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
44ce870b-ffa0-418c-93c8-991cce73e16d	2026-02-26 08:21:06.608898+00	9d0ea650-77ef-42b3-8366-6d941bd82594	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8b566012-47ba-4e31-b118-f36b2d5c3d69	2026-02-26 08:21:06.608898+00	9d0ea650-77ef-42b3-8366-6d941bd82594	e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
bfc8edee-d517-4a99-a689-d13be240d09b	2026-02-26 08:21:06.608898+00	9d0ea650-77ef-42b3-8366-6d941bd82594	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
534bf312-64e6-4c71-a8ab-db20b96377af	2026-02-26 08:21:06.608898+00	9d0ea650-77ef-42b3-8366-6d941bd82594	7374ef8e-c3b3-40aa-b6b4-7ae7159a7ce6	c6bc37d8-7c43-4ae3-9c95-4f6488a42f09	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f152d9e0-f6bd-4154-b963-5fd16da4c699	2026-02-26 08:21:06.608898+00	9d0ea650-77ef-42b3-8366-6d941bd82594	d2566406-84dd-4204-a6c7-31a91107623a	\N	t	RATTRAPAGE	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
dd2bff29-b5a6-4993-bcef-67d3b38e48a7	2026-02-26 08:35:39.298567+00	aad629e6-7ea6-4628-b260-dd5ff6a4f5ea	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c420e766-6e45-43ca-a91a-0772e0577e01	2026-02-24 09:13:09.285818+00	7665c054-298a-4e8c-b24e-1e73732beb7d	ce4184ad-5144-4b9b-8276-0111197e0885	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ef35a53c-a2d7-4969-8479-06cbdfeec6ff	2026-02-24 09:13:09.973918+00	7a8b218d-0f7d-4c19-a8e2-921d5515f4d9	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	\N	t	\N	f	2026-03-07	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
3ac7ffd1-7b2c-4913-bf17-40be5f8ee98b	2026-02-23 15:38:13.027754+00	9dbdc39c-c7d7-44b5-9030-95a55121370d	00ef1cb1-a558-407b-8798-c0db3f382cb8	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
65c945c8-5364-4ab0-a58e-9abc0af65228	2026-02-23 15:38:13.027754+00	9dbdc39c-c7d7-44b5-9030-95a55121370d	a3f3ccb1-7c00-4b52-9837-dc69331b521c	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5944e132-3416-43f6-8fe3-5f4828106cf7	2026-02-23 15:38:13.749067+00	5c6f79e8-04b1-4e75-8e11-b3796d2ded92	f6b2c3bc-2197-44c1-a848-d18a66e3fdf5	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f4db8311-ee78-4ee6-bbf3-d97c7b0a888f	2026-02-23 15:38:13.749067+00	5c6f79e8-04b1-4e75-8e11-b3796d2ded92	1d2c9275-719e-452b-9298-ec476ac53155	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
dcf16b25-48b1-40b5-b291-e56f4f2cb7ab	2026-02-23 15:38:13.749067+00	5c6f79e8-04b1-4e75-8e11-b3796d2ded92	7c879cb9-b214-4851-9fb7-cd84b0698bb7	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5b94a58e-e81a-4aec-8aaa-cf2fd5151c69	2026-02-23 15:38:14.501128+00	886c9056-eb44-4ccc-8cfc-d0b33b50e218	70610b82-10ea-46b2-a99b-59c187db69da	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
fa45c8c8-5605-482c-afde-abb2fd393ac4	2026-02-23 15:38:14.501128+00	886c9056-eb44-4ccc-8cfc-d0b33b50e218	a41687b8-6f23-46d2-abbb-285d71a1331c	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
abdeaccb-dca0-4aeb-9b5a-4059b81768ce	2026-02-23 15:38:14.501128+00	886c9056-eb44-4ccc-8cfc-d0b33b50e218	8b2745aa-d94a-48b9-be06-1aa87aac12d0	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1c9fbc6e-cdaa-4cb1-8161-78dbc1ec30b6	2026-02-23 15:38:14.501128+00	886c9056-eb44-4ccc-8cfc-d0b33b50e218	386cac04-cc49-4dd7-bb14-b17b9760795b	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f8a7ee52-9de8-4061-bd79-e9d135a5525d	2026-02-23 15:38:14.501128+00	886c9056-eb44-4ccc-8cfc-d0b33b50e218	ed3a44cb-388f-431a-bf56-2d35af78ea8a	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
765ee9e0-9235-430a-aeb5-3b29a32bb3d3	2026-02-23 15:38:15.494998+00	a5ba1f81-de78-4de0-bf9d-c8d2a728eab2	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	8d1e0213-3958-4a1a-8d8a-473cd765cebf	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
86199fbf-d18d-4ea4-80ab-45c06b1a14c7	2026-02-23 15:38:15.494998+00	a5ba1f81-de78-4de0-bf9d-c8d2a728eab2	7374ef8e-c3b3-40aa-b6b4-7ae7159a7ce6	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b008b327-b84e-46a7-9263-af45da40e0d9	2026-02-23 15:38:15.494998+00	a5ba1f81-de78-4de0-bf9d-c8d2a728eab2	d2566406-84dd-4204-a6c7-31a91107623a	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4102c0c7-adb6-4332-a3e5-fc5cd2be0d2b	2026-02-23 15:38:13.027754+00	9dbdc39c-c7d7-44b5-9030-95a55121370d	9430b606-42b0-45c9-aca3-c56c6d23d11b	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
24d5a200-4c6b-46d7-b7e2-3f0bd9edccb7	2026-02-24 09:13:11.996323+00	69f5290b-889e-40e1-abf8-258e2e7946f7	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
685bace3-f1d2-45fd-a3d0-27cff68c747a	2026-03-31 13:35:18.325692+00	bd080027-1aa2-4c42-8f8c-0bdc23ab9887	3cbd32b1-84a7-4596-92d0-903d6ea1f631	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
614ea133-6a55-495c-90f8-d7026adfb34f	2026-03-31 16:57:02.058784+00	bde71879-d3eb-4b30-b86a-ef3448f7d9ca	7fb3adc8-4473-43a4-84a8-c76a60e2665f	c6bc37d8-7c43-4ae3-9c95-4f6488a42f09	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
d5e79494-0fc5-40a0-88c8-c39d84ad29e5	2026-02-24 16:59:02.633857+00	c60af7bc-c422-4aea-b727-7f1a27d6c0db	9430b606-42b0-45c9-aca3-c56c6d23d11b	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e516f207-9890-4062-beae-ebec45d4455a	2026-02-24 16:59:02.633857+00	c60af7bc-c422-4aea-b727-7f1a27d6c0db	86c197e6-24db-4d82-8572-d86b5ca15b2f	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b853a755-3f7c-4960-b81d-97814dc5a34d	2026-02-24 16:59:02.633857+00	c60af7bc-c422-4aea-b727-7f1a27d6c0db	00ef1cb1-a558-407b-8798-c0db3f382cb8	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
54b7d5da-22a9-46f0-afd0-c2ed1278f8d3	2026-02-24 16:59:02.633857+00	c60af7bc-c422-4aea-b727-7f1a27d6c0db	a3f3ccb1-7c00-4b52-9837-dc69331b521c	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
752b4f29-2345-46e6-8847-6d7244848947	2026-02-24 16:59:03.230979+00	9e1d97de-66fe-4106-8134-9bff1bdb994b	f6b2c3bc-2197-44c1-a848-d18a66e3fdf5	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0420e3d3-a27b-432c-9deb-0e9651e64125	2026-02-24 16:59:03.230979+00	9e1d97de-66fe-4106-8134-9bff1bdb994b	b0054d27-f377-41ad-a026-a2893c27692a	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6d82f457-fba6-4395-b8e6-12032ebaa835	2026-02-24 16:59:03.230979+00	9e1d97de-66fe-4106-8134-9bff1bdb994b	1d2c9275-719e-452b-9298-ec476ac53155	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
afc0e0ac-48d2-4382-b843-3defd28ab210	2026-02-24 16:59:03.230979+00	9e1d97de-66fe-4106-8134-9bff1bdb994b	7c879cb9-b214-4851-9fb7-cd84b0698bb7	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9307b71c-3ae8-4e6b-a004-ee2dda96224b	2026-02-24 17:00:49.364075+00	9e1d97de-66fe-4106-8134-9bff1bdb994b	ceb5bad4-3051-4086-ac9c-a67e6c124aee	\N	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4da7554a-645e-45bb-aad4-51d579b8ca4d	2026-02-24 16:59:03.937437+00	35249ef6-88b6-4194-9367-81ed3a996ca9	70610b82-10ea-46b2-a99b-59c187db69da	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d53d60ed-6494-482e-8909-1bf1f8b05943	2026-02-24 16:59:03.937437+00	35249ef6-88b6-4194-9367-81ed3a996ca9	7851fd12-1e6f-4a02-b957-c2120bc0ac83	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
df883d8e-e74d-4a5f-a711-306cb0a4b089	2026-02-24 16:59:03.937437+00	35249ef6-88b6-4194-9367-81ed3a996ca9	a41687b8-6f23-46d2-abbb-285d71a1331c	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1a07b1be-4c3b-4d00-bc0d-a817c4c2366b	2026-02-24 16:59:03.937437+00	35249ef6-88b6-4194-9367-81ed3a996ca9	8b2745aa-d94a-48b9-be06-1aa87aac12d0	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
274aaab4-8e44-489a-868a-104eacba5877	2026-02-24 16:59:03.937437+00	35249ef6-88b6-4194-9367-81ed3a996ca9	386cac04-cc49-4dd7-bb14-b17b9760795b	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5d727c1d-d445-455f-a650-cc8159f2d095	2026-02-24 16:59:03.937437+00	35249ef6-88b6-4194-9367-81ed3a996ca9	ed3a44cb-388f-431a-bf56-2d35af78ea8a	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
729fe48e-13c4-4109-b8ee-3be4b823b849	2026-02-24 16:59:04.546466+00	78505970-8d66-492b-a67d-f9182ff09def	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	\N	t	SCOUBIDOU	f	2025-12-13	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
a6a06c47-cb29-4788-a82a-d3bdce859906	2026-02-24 16:59:04.546466+00	78505970-8d66-492b-a67d-f9182ff09def	e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
12a58dde-6ef5-4ade-a7cb-8829aa99942b	2026-02-24 16:59:04.546466+00	78505970-8d66-492b-a67d-f9182ff09def	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
47ffff9d-a2dd-4ddc-bbc8-eef8c789cab2	2026-02-24 16:59:04.546466+00	78505970-8d66-492b-a67d-f9182ff09def	7374ef8e-c3b3-40aa-b6b4-7ae7159a7ce6	\N	t	ANR	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9ba58212-52f7-4c9f-98cd-cfeb1e676673	2026-02-25 09:03:48.893136+00	d2799fab-ea30-4eb6-97cd-3ccfa7c1b027	9c87739b-74ad-47b9-a70f-6efc26c93f00	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
eee9ce35-090b-41f9-a5f9-c2946f9324f6	2026-02-26 08:37:01.969451+00	d6b999bc-6737-4453-aaf6-7a9d66f8c9dc	\N	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Anwen	\N	t	Virement	\N	\N	f
26f7ca97-86ec-49dc-938e-c14fc8352e2c	2026-02-25 09:03:48.893136+00	d2799fab-ea30-4eb6-97cd-3ccfa7c1b027	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	\N	t	AND	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ac25af5a-a5d0-4882-b2f0-4edec67fb98f	2026-02-25 09:03:48.893136+00	d2799fab-ea30-4eb6-97cd-3ccfa7c1b027	ce4184ad-5144-4b9b-8276-0111197e0885	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
23155607-2910-4b1f-998f-be655ee1b508	2026-02-25 09:03:49.551971+00	2602a1d7-dc0b-4414-a01c-5b2939663a91	9aa72019-ede1-4b37-a63b-400a20a683a7	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5d91bc79-6c32-4112-b154-1042af7e3d0f	2026-02-25 09:03:50.243522+00	2abc05ce-021c-4af4-92d1-104b190787d6	13e202ee-272d-415f-8d66-f7669b85afb8	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
80a43cfc-0948-4044-b3fc-05404ee31243	2026-02-24 16:59:04.546466+00	78505970-8d66-492b-a67d-f9182ff09def	d2566406-84dd-4204-a6c7-31a91107623a	\N	t	\N	f	2026-02-28	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
10939412-95d6-4216-8785-79f6f61a24c1	2026-02-25 09:03:49.551971+00	2602a1d7-dc0b-4414-a01c-5b2939663a91	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d930243f-6ed5-40ca-8845-91218cb4da1d	2026-02-25 09:03:49.551971+00	2602a1d7-dc0b-4414-a01c-5b2939663a91	01fdbddd-ee76-4200-a153-47cc61d67398	\N	t	🅰️	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d58b8f5f-c4d5-41e8-a253-73004d38d9c8	2026-02-25 09:03:48.893136+00	d2799fab-ea30-4eb6-97cd-3ccfa7c1b027	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7dc872b1-d74f-406a-bb58-a7bc215af418	2026-02-25 09:03:50.243522+00	2abc05ce-021c-4af4-92d1-104b190787d6	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4a7801eb-b87f-46a8-994d-18dc07ab0234	2026-02-25 09:03:50.243522+00	2abc05ce-021c-4af4-92d1-104b190787d6	97a3f8b8-caff-4988-b24a-2b7e54d155ee	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
dcfc3815-658f-4d93-a139-c3e12bc52f01	2026-02-25 09:03:50.243522+00	2abc05ce-021c-4af4-92d1-104b190787d6	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5d3ef56d-3e10-4afe-8fa8-223a6651a7b8	2026-02-25 09:03:50.243522+00	2abc05ce-021c-4af4-92d1-104b190787d6	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
fb8a84e5-c830-4438-983a-2e41d62bc356	2026-02-25 09:03:50.243522+00	2abc05ce-021c-4af4-92d1-104b190787d6	6c379005-03bc-478f-aabd-ad3f75f6477a	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b932282a-97b9-4d63-b262-fbd66d3250ed	2026-02-25 09:03:50.243522+00	2abc05ce-021c-4af4-92d1-104b190787d6	2d98b2aa-9762-4798-8e28-fcb15c380bf5	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e7431a40-6c49-4fe9-a0fc-e32ba412dd99	2026-02-25 09:03:50.777334+00	d9085b1e-da5e-4534-a55c-00abbe7ba7b7	8b6e4db3-9332-457c-8e1a-ad88af0c40be	b6d87440-e59a-402a-81f1-4d996a9a9300	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8e9727c1-be67-4573-8309-e6811308a206	2026-02-26 08:21:06.160641+00	0a179855-5d26-4308-bfe1-84828334239f	8b2745aa-d94a-48b9-be06-1aa87aac12d0	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0a2c135c-3fd4-44f4-8843-69faed299903	2026-02-26 08:21:06.160641+00	0a179855-5d26-4308-bfe1-84828334239f	386cac04-cc49-4dd7-bb14-b17b9760795b	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
087ca5f7-df9e-4f2a-ad6a-0ea93013e862	2026-02-26 08:21:06.160641+00	0a179855-5d26-4308-bfe1-84828334239f	ed3a44cb-388f-431a-bf56-2d35af78ea8a	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
cabd1893-c521-4c7b-84d7-231141fcdd58	2026-02-26 08:21:06.160641+00	0a179855-5d26-4308-bfe1-84828334239f	70610b82-10ea-46b2-a99b-59c187db69da	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
00d54022-975a-4ccd-96f5-3102467167d3	2026-02-26 08:21:06.160641+00	0a179855-5d26-4308-bfe1-84828334239f	7851fd12-1e6f-4a02-b957-c2120bc0ac83	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5b4a70fd-3b12-42b3-940f-cc93b7b7d01f	2026-02-26 08:21:06.160641+00	0a179855-5d26-4308-bfe1-84828334239f	a41687b8-6f23-46d2-abbb-285d71a1331c	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
336a00c9-9b67-46eb-b6ed-80f5d84f8744	2026-02-26 08:58:17.888614+00	4866e879-864f-4aa7-b021-3599ff90a516	9430b606-42b0-45c9-aca3-c56c6d23d11b	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
88bdf2a3-7302-4b97-8acd-818dcbce9f22	2026-02-26 08:58:17.888614+00	4866e879-864f-4aa7-b021-3599ff90a516	86c197e6-24db-4d82-8572-d86b5ca15b2f	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
52ec7a8b-635e-4b69-aafc-701d621d6e73	2026-02-26 08:58:17.888614+00	4866e879-864f-4aa7-b021-3599ff90a516	00ef1cb1-a558-407b-8798-c0db3f382cb8	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
dbb77b95-4824-4a63-8dd9-60d30d994218	2026-02-26 08:58:17.888614+00	4866e879-864f-4aa7-b021-3599ff90a516	a3f3ccb1-7c00-4b52-9837-dc69331b521c	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1d3f5db8-cfdc-473f-8765-d7a8e91cd617	2026-02-26 08:58:19.504501+00	da0b805c-72f5-4d2c-bb1c-60a759dca349	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7f335b70-fb08-4474-8c58-9edcd648c225	2026-02-26 08:58:19.504501+00	da0b805c-72f5-4d2c-bb1c-60a759dca349	e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5c834c33-2e52-42e9-a271-5acefe194a9d	2026-02-26 08:58:19.504501+00	da0b805c-72f5-4d2c-bb1c-60a759dca349	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7049aa31-2fea-43ed-a54f-4f4cfccb84d9	2026-02-26 08:58:19.504501+00	da0b805c-72f5-4d2c-bb1c-60a759dca349	7374ef8e-c3b3-40aa-b6b4-7ae7159a7ce6	c6bc37d8-7c43-4ae3-9c95-4f6488a42f09	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9d1375d8-8766-49c4-9f17-754e108024b5	2026-02-25 09:03:49.551971+00	2602a1d7-dc0b-4414-a01c-5b2939663a91	7dd68452-30ed-4829-857d-bebc61aff9c1	\N	t	VENOM	f	2025-10-11	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
543c463b-df36-4b8f-b506-f31fb3a1371a	2026-03-31 16:57:02.773362+00	bde71879-d3eb-4b30-b86a-ef3448f7d9ca	\N	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Naomi	\N	f	\N	\N	\N	f
bc7570ab-76f9-4ec0-b713-a728c7c0b4a2	2026-03-31 16:57:03.421893+00	bde71879-d3eb-4b30-b86a-ef3448f7d9ca	893bb307-08a3-4af2-ba54-6c5da32206ad	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
3cc93fa9-484f-4971-abb5-75eca8036c9c	2026-02-25 09:03:50.777334+00	d9085b1e-da5e-4534-a55c-00abbe7ba7b7	ddbca8c2-9bfd-4ab2-90d1-8c8127be9331	03331a64-cbca-4ae6-b260-80308e787efc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
25286853-0f27-4280-84b3-63c81c936de8	2026-02-25 09:03:50.777334+00	d9085b1e-da5e-4534-a55c-00abbe7ba7b7	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
52f5298a-e36d-46c8-bdc0-3c33871b0cde	2026-02-25 09:03:50.777334+00	d9085b1e-da5e-4534-a55c-00abbe7ba7b7	7e7447f5-56a1-4513-9606-978058d389d5	c48c89f9-082b-4835-9a9f-e3ee05ed3476	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e0fc85e7-550d-48ba-aee8-691d4648357f	2026-03-31 13:35:19.109809+00	bd080027-1aa2-4c42-8f8c-0bdc23ab9887	080111ef-d8d7-4662-ba20-cd5ff1bfa389	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
1fce79bb-a91f-40fb-a68f-c4a39b8f637a	2026-02-26 08:41:56.711443+00	051c478e-2200-40c0-92dd-edf238b84016	70610b82-10ea-46b2-a99b-59c187db69da	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0b8eae7e-014e-4b4c-9d8a-5327a016dea4	2026-02-26 08:41:56.711443+00	051c478e-2200-40c0-92dd-edf238b84016	7851fd12-1e6f-4a02-b957-c2120bc0ac83	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5fd11a39-ab45-4549-88d9-31b66b1f7132	2026-02-26 08:41:56.711443+00	051c478e-2200-40c0-92dd-edf238b84016	8b2745aa-d94a-48b9-be06-1aa87aac12d0	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
13475257-8db7-4494-a27e-04ce3300fa4d	2026-02-26 08:41:56.711443+00	051c478e-2200-40c0-92dd-edf238b84016	386cac04-cc49-4dd7-bb14-b17b9760795b	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e56c54cc-36dd-4ad6-ba34-9f5afdafb6e7	2026-02-26 08:41:56.711443+00	051c478e-2200-40c0-92dd-edf238b84016	ed3a44cb-388f-431a-bf56-2d35af78ea8a	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
64701bfd-f7d4-4fc5-94c4-67a390939f7c	2026-03-31 16:57:02.401097+00	bde71879-d3eb-4b30-b86a-ef3448f7d9ca	19dfcd2c-5aaf-4e09-ac63-9856393cfb3c	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
b6e0bd70-19ce-48c5-b85f-7584f6e37445	2026-02-26 08:41:56.711443+00	051c478e-2200-40c0-92dd-edf238b84016	a41687b8-6f23-46d2-abbb-285d71a1331c	\N	t	RATTRAPAGE	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6fd4e0f2-1001-4776-9842-cb02dc963492	2026-02-26 08:58:18.419912+00	f58d4582-80ff-485e-ab32-2b15fc7ed606	f6b2c3bc-2197-44c1-a848-d18a66e3fdf5	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5c03ebfa-c67e-474c-a609-4e35f569f19e	2026-02-26 08:58:18.419912+00	f58d4582-80ff-485e-ab32-2b15fc7ed606	b0054d27-f377-41ad-a026-a2893c27692a	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
923de98a-4838-4f16-9ffa-fcf556bcf820	2026-02-26 08:58:18.419912+00	f58d4582-80ff-485e-ab32-2b15fc7ed606	1d2c9275-719e-452b-9298-ec476ac53155	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
cc4273ee-faa2-4125-a264-410cad372164	2026-02-26 08:58:18.419912+00	f58d4582-80ff-485e-ab32-2b15fc7ed606	7c879cb9-b214-4851-9fb7-cd84b0698bb7	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
585c51f5-8a01-4fc1-b2bb-29272c5f40c9	2026-02-26 09:13:09.414249+00	de9f9356-1fd2-4d2a-aea9-584ad5b0f1ad	1d2c9275-719e-452b-9298-ec476ac53155	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-01-07	f
106988b8-e6f1-4a14-83f5-c1290a4e50e1	2026-03-31 16:57:03.097934+00	bde71879-d3eb-4b30-b86a-ef3448f7d9ca	\N	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Meriem	\N	f	\N	\N	\N	f
756d0d61-920c-4003-a8f4-cdae97e7681c	2026-03-31 16:57:03.7453+00	bde71879-d3eb-4b30-b86a-ef3448f7d9ca	8dab5312-dbee-4f86-83dd-0874ffc99c46	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
50d9004a-1f17-4a4f-b072-126219e7c6e0	2026-03-31 17:36:49.530029+00	d8fff579-5fa0-41f3-a4ff-a19a05f36a67	\N	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Cassandre ALLANCHE	\N	f	\N	\N	\N	f
13063e20-1c09-434d-b9db-e0f3134a6f9e	2026-04-01 18:24:17.401419+00	c2318c52-cea8-4607-a677-9e14bd2183b9	aaedc900-37ff-4b01-88cb-82c36deffca8	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
208a9399-dc1a-4cc4-a660-ce5949c21b87	2026-04-01 18:24:18.487591+00	c2318c52-cea8-4607-a677-9e14bd2183b9	893bb307-08a3-4af2-ba54-6c5da32206ad	835b104d-b18b-4876-ba72-ffea56c43563	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
b1f454b0-eabe-4c24-bfcd-ba8113235e8f	2026-04-02 10:32:06.475494+00	11527b8f-faf1-4400-baea-63574f55633b	3cbd32b1-84a7-4596-92d0-903d6ea1f631	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
a301560d-6f86-4c6b-bcbf-f767a497048f	2026-02-26 09:24:11.235898+00	4251bd3e-a2bd-4ae4-bd66-667c5d4d4ce8	f6b2c3bc-2197-44c1-a848-d18a66e3fdf5	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c90fd106-2f84-401b-a56d-c763a02ac6f7	2026-02-26 09:24:11.235898+00	4251bd3e-a2bd-4ae4-bd66-667c5d4d4ce8	b0054d27-f377-41ad-a026-a2893c27692a	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d7af7077-bedc-4f8a-9bc6-6c772a30b1be	2026-02-26 09:24:11.235898+00	4251bd3e-a2bd-4ae4-bd66-667c5d4d4ce8	1d2c9275-719e-452b-9298-ec476ac53155	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b167ea07-7c03-4fe3-975c-6c5dc48cf1d6	2026-02-26 09:24:11.235898+00	4251bd3e-a2bd-4ae4-bd66-667c5d4d4ce8	7c879cb9-b214-4851-9fb7-cd84b0698bb7	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
85aecad0-41e3-48a5-95a5-de0bb9f7e35d	2026-02-26 09:24:12.295836+00	8d411ccd-4c4a-460d-a469-0b90f961ac3b	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7af2ddc1-a98a-437c-9ead-5c835267047d	2026-02-26 09:24:12.295836+00	8d411ccd-4c4a-460d-a469-0b90f961ac3b	e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
59ae8e93-cab1-4b08-a1b6-79372a7b4cf0	2026-02-26 09:24:12.295836+00	8d411ccd-4c4a-460d-a469-0b90f961ac3b	01fdbddd-ee76-4200-a153-47cc61d67398	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7ba1bc24-c599-4e19-b038-ac0fbffedfc2	2026-02-26 09:24:12.295836+00	8d411ccd-4c4a-460d-a469-0b90f961ac3b	7374ef8e-c3b3-40aa-b6b4-7ae7159a7ce6	c6bc37d8-7c43-4ae3-9c95-4f6488a42f09	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
32e604b4-5280-442a-94b3-44eb1c828a48	2026-02-26 09:24:12.295836+00	8d411ccd-4c4a-460d-a469-0b90f961ac3b	d2566406-84dd-4204-a6c7-31a91107623a	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
eb2a79e4-1bb4-477e-bbc9-371000654942	2026-04-02 10:32:06.969284+00	11527b8f-faf1-4400-baea-63574f55633b	080111ef-d8d7-4662-ba20-cd5ff1bfa389	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
f460beb6-3022-4c10-8b84-4b082f56388b	2026-04-03 06:06:47.471266+00	f67bbea7-6b82-4f66-a99e-a40559dd54de	9c87739b-74ad-47b9-a70f-6efc26c93f00	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-04-04	f
d3cfc8d8-d640-4b5b-b193-e7c94c9eb5ff	2026-04-03 08:27:25.640672+00	d2799fab-ea30-4eb6-97cd-3ccfa7c1b027	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	059512a2-d080-480d-b201-84c5179e56ed	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2025-10-11	f
57a19fd7-beaa-4bb3-ba6c-878581e18f90	2026-03-23 09:51:45.12461+00	87618f27-0efc-4904-bce7-e6fc6e7afcdb	7e7447f5-56a1-4513-9606-978058d389d5	\N	t	WA20260403. 17:19	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ebb79fcf-bdf6-4c50-b1ff-93159876d95e	2026-04-03 17:52:28.962455+00	aad629e6-7ea6-4628-b260-dd5ff6a4f5ea	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2025-12-20	f
ce104228-6ba4-42b9-872f-bfc8fb6176a9	2026-02-26 09:36:20.209206+00	163bae16-36c5-4bbd-aabd-ebb45f89d1f5	f6b2c3bc-2197-44c1-a848-d18a66e3fdf5	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
99f554d5-454e-4b3d-a5db-83d8a18728a6	2026-02-26 09:36:20.209206+00	163bae16-36c5-4bbd-aabd-ebb45f89d1f5	b0054d27-f377-41ad-a026-a2893c27692a	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
40bf7545-3ed9-4267-ab79-ffb5d3016e02	2026-02-26 09:36:20.209206+00	163bae16-36c5-4bbd-aabd-ebb45f89d1f5	1d2c9275-719e-452b-9298-ec476ac53155	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4428b670-0502-46d1-ae7e-48d23b454d62	2026-03-23 09:51:45.12461+00	87618f27-0efc-4904-bce7-e6fc6e7afcdb	ceb5bad4-3051-4086-ac9c-a67e6c124aee	b6d87440-e59a-402a-81f1-4d996a9a9300	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
cae9124e-e82c-47a5-93e2-e825644a6c88	2026-03-23 09:51:45.12461+00	87618f27-0efc-4904-bce7-e6fc6e7afcdb	33600627-aea8-4768-8be4-eadb5152e41f	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
31eccb96-ce89-44a2-bfcc-5fc7bc847613	2026-02-23 15:12:54.105163+00	f43a68a1-59b5-4e19-bbb9-5ca90c669e27	1c9e7097-df1c-4540-b79b-35055f8f080f	\N	t	AND ⛔️	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5e4fd183-f6cb-4570-b363-bb26cede0f0b	2026-04-04 06:12:50.398561+00	604fb666-c6f4-4edc-94e5-9c5ff12b979d	7851fd12-1e6f-4a02-b957-c2120bc0ac83	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d0dd9cb4-5d90-4721-beba-115d623bdf31	2026-04-04 06:12:50.398561+00	604fb666-c6f4-4edc-94e5-9c5ff12b979d	a41687b8-6f23-46d2-abbb-285d71a1331c	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6debe563-b172-4379-b08a-67f29ea692af	2026-04-04 06:12:50.398561+00	604fb666-c6f4-4edc-94e5-9c5ff12b979d	8b2745aa-d94a-48b9-be06-1aa87aac12d0	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8aca768f-a27b-4f92-809a-59e49f0d4b06	2026-04-04 06:12:50.398561+00	604fb666-c6f4-4edc-94e5-9c5ff12b979d	386cac04-cc49-4dd7-bb14-b17b9760795b	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
35e58f8b-b791-4bfe-9ef0-2aaaa714562c	2026-04-04 06:12:50.398561+00	604fb666-c6f4-4edc-94e5-9c5ff12b979d	ed3a44cb-388f-431a-bf56-2d35af78ea8a	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2a05955a-1400-485e-969e-e39444e6f6e6	2026-02-23 15:38:15.494998+00	a5ba1f81-de78-4de0-bf9d-c8d2a728eab2	e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b9ad8d89-86df-4a46-8231-3c9911cec32e	2026-03-16 12:19:12.543414+00	e1152792-c321-4a78-ae79-d40328c02cef	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d074dfc9-dd51-469e-977f-2acda7096606	2026-04-25 05:02:21.075893+00	0795889d-4ce9-4789-ba2a-7fb8895aa95a	9c87739b-74ad-47b9-a70f-6efc26c93f00	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b27ea7ce-31c0-42f3-8c91-4a35102374df	2026-04-25 05:02:21.075893+00	0795889d-4ce9-4789-ba2a-7fb8895aa95a	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7a0b4994-14aa-4baa-a040-90f93c3d6020	2026-04-25 05:02:21.075893+00	0795889d-4ce9-4789-ba2a-7fb8895aa95a	ce4184ad-5144-4b9b-8276-0111197e0885	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2dfa16b7-bdf2-40f3-a46c-593dd6fff4e9	2026-04-25 05:02:21.075893+00	0795889d-4ce9-4789-ba2a-7fb8895aa95a	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d2dda475-7667-43ba-9954-606286dd7d91	2026-03-27 09:19:35.081691+00	74914a88-5ef1-446f-80d4-7a87209eeaec	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-03-28	f
c02fb5f9-b5fb-4ff7-a66f-4b060323d7b5	2026-02-25 09:03:50.777334+00	d9085b1e-da5e-4534-a55c-00abbe7ba7b7	ceb5bad4-3051-4086-ac9c-a67e6c124aee	\N	t	KOOKOO	f	2025-10-01	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
504428c4-937c-4efc-86a4-3fe030cb4ac5	2026-02-25 09:06:11.984941+00	d2799fab-ea30-4eb6-97cd-3ccfa7c1b027	9aa72019-ede1-4b37-a63b-400a20a683a7	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
98d83d28-ac53-4c18-a54c-f4d10f5286d1	2026-02-25 09:15:18.442765+00	2602a1d7-dc0b-4414-a01c-5b2939663a91	13e202ee-272d-415f-8d66-f7669b85afb8	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
24de77c4-bfcd-4fb1-a82a-eea36ba5397f	2026-02-25 09:03:51.316808+00	bbce2c38-8d9f-4ee3-afee-336a39644982	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
496d72ce-a96a-494b-b762-48c057fc4f2d	2026-02-25 09:03:51.316808+00	bbce2c38-8d9f-4ee3-afee-336a39644982	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c341dc70-4df5-4b11-a594-19f874646be9	2026-02-25 09:03:51.316808+00	bbce2c38-8d9f-4ee3-afee-336a39644982	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7385407e-cf14-42f3-bcce-b4cf059beb8a	2026-02-25 09:28:37.581796+00	d78941c0-235d-4d26-a02f-40c0e0e3025b	8b6e4db3-9332-457c-8e1a-ad88af0c40be	\N	t	1s/2. S.P.	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
16a6b72a-036b-4742-8083-6c7fa72c401d	2026-02-25 09:28:37.581796+00	d78941c0-235d-4d26-a02f-40c0e0e3025b	ddbca8c2-9bfd-4ab2-90d1-8c8127be9331	\N	t	1s/2. S.P.	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9a853b91-97c5-4804-ab1a-a130a8f7cbb5	2026-03-31 13:35:19.873136+00	bd080027-1aa2-4c42-8f8c-0bdc23ab9887	322417b3-f05a-488c-b3b6-8956e7e4413a	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
747bd767-738a-42e1-b793-5c8006bf4046	2026-02-25 09:19:09.498349+00	b4c7a69d-5bb3-4302-9ac0-02c8efdbf66a	9430b606-42b0-45c9-aca3-c56c6d23d11b	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
88dbd141-a13a-48c2-853e-43220547ca5c	2026-02-25 09:19:09.498349+00	b4c7a69d-5bb3-4302-9ac0-02c8efdbf66a	86c197e6-24db-4d82-8572-d86b5ca15b2f	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
69372ee4-c678-4962-a322-c61357762abe	2026-02-25 09:19:09.498349+00	b4c7a69d-5bb3-4302-9ac0-02c8efdbf66a	00ef1cb1-a558-407b-8798-c0db3f382cb8	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
73a10d23-9721-4065-b8cc-621100de15ad	2026-02-25 09:19:09.498349+00	b4c7a69d-5bb3-4302-9ac0-02c8efdbf66a	a3f3ccb1-7c00-4b52-9837-dc69331b521c	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
59bc033a-628e-4ecc-bfe6-b39791f2a2f1	2026-02-25 09:19:10.002049+00	658dd892-42b6-4691-bb71-6a8c20082919	f6b2c3bc-2197-44c1-a848-d18a66e3fdf5	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
aac8c323-5b06-4c7a-b941-c5b82997b737	2026-02-25 09:19:10.002049+00	658dd892-42b6-4691-bb71-6a8c20082919	b0054d27-f377-41ad-a026-a2893c27692a	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
bcf9298c-be8a-4d89-9841-1da5cb69be14	2026-02-25 09:19:10.002049+00	658dd892-42b6-4691-bb71-6a8c20082919	1d2c9275-719e-452b-9298-ec476ac53155	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
196cb43b-417a-4e0d-9c0c-cf6dffb6d5a0	2026-02-25 09:19:10.002049+00	658dd892-42b6-4691-bb71-6a8c20082919	7c879cb9-b214-4851-9fb7-cd84b0698bb7	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d6837833-37e4-4a61-8b8d-adadc422b9cc	2026-03-31 17:00:36.871456+00	a4552dd6-0b7e-4ebd-b69e-92ee204c9904	893bb307-08a3-4af2-ba54-6c5da32206ad	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
e50521e5-7bf5-4c77-b531-5271bab27bb7	2026-03-31 17:00:37.690473+00	a4552dd6-0b7e-4ebd-b69e-92ee204c9904	322417b3-f05a-488c-b3b6-8956e7e4413a	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
89144e10-66b7-4612-965d-0f94bb62f6a6	2026-02-25 09:19:10.502594+00	341d524a-37e2-45c7-941a-9aff26f1641c	70610b82-10ea-46b2-a99b-59c187db69da	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0942f934-087a-4ac3-8b90-d504d64b7887	2026-02-25 09:28:35.972365+00	a5d169f0-06e0-4bbc-9132-ff13f70ffe2a	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
43eb004c-67ae-497d-96d4-81b54c24f107	2026-02-25 09:15:35.234927+00	2602a1d7-dc0b-4414-a01c-5b2939663a91	\N	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Anwen	30.00	t	Virement	\N	\N	f
0231af1b-0f98-47e4-bd9c-6886a38dc451	2026-02-25 09:19:10.502594+00	341d524a-37e2-45c7-941a-9aff26f1641c	8b2745aa-d94a-48b9-be06-1aa87aac12d0	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d6755a40-4374-4391-9eb0-e91d327dfe4e	2026-02-25 09:19:10.502594+00	341d524a-37e2-45c7-941a-9aff26f1641c	386cac04-cc49-4dd7-bb14-b17b9760795b	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ebe06719-29ee-4079-bceb-6b9965c6e570	2026-02-25 09:19:10.502594+00	341d524a-37e2-45c7-941a-9aff26f1641c	ed3a44cb-388f-431a-bf56-2d35af78ea8a	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c823789b-aadf-48b0-aded-6b41d258f008	2026-02-25 09:19:11.028004+00	d767fd2e-d527-4eeb-b9b6-55432538a59c	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e93adda1-ccdd-473e-89fc-6d4aede2af6a	2026-02-25 09:19:11.028004+00	d767fd2e-d527-4eeb-b9b6-55432538a59c	e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
77a99611-da95-4a34-96fe-635ad43e9a4f	2026-02-25 09:19:10.502594+00	341d524a-37e2-45c7-941a-9aff26f1641c	7851fd12-1e6f-4a02-b957-c2120bc0ac83	\N	t	TYPE TOP	f	2026-01-10	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
8f052f0b-1358-4e30-aaf7-fb0edff27ebc	2026-02-25 09:19:11.028004+00	d767fd2e-d527-4eeb-b9b6-55432538a59c	7374ef8e-c3b3-40aa-b6b4-7ae7159a7ce6	\N	t	ANR	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d8a91e48-10f2-43a8-8989-6b73203fe3f4	2026-02-25 09:19:11.028004+00	d767fd2e-d527-4eeb-b9b6-55432538a59c	d2566406-84dd-4204-a6c7-31a91107623a	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
fbbb0485-c407-40a9-a399-428a07923d70	2026-02-26 08:21:05.032937+00	d5913a3d-10e7-48e3-9ca4-0efeae5f9711	9430b606-42b0-45c9-aca3-c56c6d23d11b	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1c16bdf9-b949-4eb7-83c5-dea573442100	2026-02-25 09:28:35.972365+00	a5d169f0-06e0-4bbc-9132-ff13f70ffe2a	9c87739b-74ad-47b9-a70f-6efc26c93f00	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
68e9f908-5fb4-4d1c-b8c9-91af74c26890	2026-03-31 17:43:54.841423+00	f2e2785b-4254-4382-8901-03f73320dc4d	9430b606-42b0-45c9-aca3-c56c6d23d11b	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-04-01	f
72f86013-2ef0-4698-92c6-1d28b3fd576c	2026-02-25 09:28:35.972365+00	a5d169f0-06e0-4bbc-9132-ff13f70ffe2a	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
560e7f91-056c-4699-856f-94aa6c76e827	2026-02-25 09:28:35.972365+00	a5d169f0-06e0-4bbc-9132-ff13f70ffe2a	ce4184ad-5144-4b9b-8276-0111197e0885	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
dbb77195-d8ad-4f44-9773-ad747418baee	2026-02-25 09:29:20.921561+00	a5d169f0-06e0-4bbc-9132-ff13f70ffe2a	7dd68452-30ed-4829-857d-bebc61aff9c1	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
36efeade-fa34-497b-b4a6-3f0d509513e2	2026-02-25 09:28:36.4793+00	1e2b6f64-09fc-4ab9-8967-bc0a47eafb44	9aa72019-ede1-4b37-a63b-400a20a683a7	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7b26466e-b705-45be-81e2-0b31d31358a1	2026-02-25 09:19:11.028004+00	d767fd2e-d527-4eeb-b9b6-55432538a59c	01fdbddd-ee76-4200-a153-47cc61d67398	\N	t	ALYSSON	f	2025-11-08	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
c3e37aaa-ac98-41af-a3e6-cfffd30ffab9	2026-04-01 18:30:22.227273+00	c170a167-f63d-4d0c-95a4-1bffb638607e	322417b3-f05a-488c-b3b6-8956e7e4413a	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
d04ad51a-77e8-4761-8ffa-0c71d81f8a43	2026-02-25 09:28:36.4793+00	1e2b6f64-09fc-4ab9-8967-bc0a47eafb44	7dd68452-30ed-4829-857d-bebc61aff9c1	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
74fa130a-ad0c-4cde-88f2-490e148273e5	2026-02-25 09:28:37.060663+00	32ad6772-1db0-47ec-a562-5d9d8a92dc5a	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2dcaa11e-0ba9-407e-b130-a2b70ddd0e75	2026-02-25 09:28:37.060663+00	32ad6772-1db0-47ec-a562-5d9d8a92dc5a	97a3f8b8-caff-4988-b24a-2b7e54d155ee	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1947c888-3a13-447a-adda-bba7da469fa7	2026-02-25 09:28:37.060663+00	32ad6772-1db0-47ec-a562-5d9d8a92dc5a	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ecc40cf3-f556-4d93-aa02-51c46a8e16e5	2026-02-25 09:28:37.060663+00	32ad6772-1db0-47ec-a562-5d9d8a92dc5a	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
42279a67-abf9-4833-9d8d-a3c1a79c77a4	2026-02-25 09:28:37.060663+00	32ad6772-1db0-47ec-a562-5d9d8a92dc5a	13e202ee-272d-415f-8d66-f7669b85afb8	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0c18e18d-4386-4d42-aa46-95de7a42fcd4	2026-02-25 09:28:37.060663+00	32ad6772-1db0-47ec-a562-5d9d8a92dc5a	6c379005-03bc-478f-aabd-ad3f75f6477a	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
53441eab-7e15-4339-9b77-4d95a7f32efd	2026-02-25 09:28:37.060663+00	32ad6772-1db0-47ec-a562-5d9d8a92dc5a	2d98b2aa-9762-4798-8e28-fcb15c380bf5	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a749372a-d8fd-4ad5-b8fe-ec22400484e3	2026-04-01 18:30:22.983674+00	c170a167-f63d-4d0c-95a4-1bffb638607e	466a4031-fc42-48c9-88c5-1a1925e19912	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
c978104b-d440-4f90-a860-6164136fe298	2026-03-23 09:51:45.635759+00	321845a3-8385-4489-8fbb-2725f312d8e5	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
3c5e9f00-48fa-412d-a021-5dde82f7045d	2026-02-25 09:28:37.581796+00	d78941c0-235d-4d26-a02f-40c0e0e3025b	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
bde5574c-89e3-49b6-9255-02b7603ad68f	2026-02-25 09:28:37.581796+00	d78941c0-235d-4d26-a02f-40c0e0e3025b	7e7447f5-56a1-4513-9606-978058d389d5	c48c89f9-082b-4835-9a9f-e3ee05ed3476	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
bb243f50-dbf1-416f-bd79-f2533b087c9a	2026-02-25 09:28:37.581796+00	d78941c0-235d-4d26-a02f-40c0e0e3025b	ceb5bad4-3051-4086-ac9c-a67e6c124aee	d532c50a-26f4-4491-bcb3-e8fe9bb5105d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
72e55b5d-89be-4da7-92e4-a4344786d8e2	2026-02-25 09:28:38.064307+00	0fc9c76f-c564-441a-a665-f014eb877f06	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8ec58ae0-3451-4b16-9f96-1e2b5944e804	2026-02-25 09:28:38.064307+00	0fc9c76f-c564-441a-a665-f014eb877f06	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f60b7e7c-f933-41c7-b401-ed97699107a5	2026-02-25 09:28:36.4793+00	1e2b6f64-09fc-4ab9-8967-bc0a47eafb44	01fdbddd-ee76-4200-a153-47cc61d67398	\N	t	🅰️	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5383e944-b7c7-4ea8-8529-d70e4f9b6a35	2026-03-23 09:51:45.635759+00	321845a3-8385-4489-8fbb-2725f312d8e5	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
2d9e1c8e-3466-43e5-aed1-9599ecdcb318	2026-02-25 09:28:38.064307+00	0fc9c76f-c564-441a-a665-f014eb877f06	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1b1dab36-5347-4241-b004-679300c7d97e	2026-02-25 09:35:21.302135+00	4813087b-e9d9-4bb7-81ea-9a0918d58c05	b0054d27-f377-41ad-a026-a2893c27692a	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
fd52ee66-b8a2-4952-b7dd-78b3b04bb937	2026-02-25 09:35:21.302135+00	4813087b-e9d9-4bb7-81ea-9a0918d58c05	1d2c9275-719e-452b-9298-ec476ac53155	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
91e9d98a-0577-44f1-aee6-33bd3c854c37	2026-02-25 09:35:21.302135+00	4813087b-e9d9-4bb7-81ea-9a0918d58c05	7c879cb9-b214-4851-9fb7-cd84b0698bb7	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5ca9534a-66af-4ce6-9ee0-371132f4d038	2026-03-31 13:35:20.502655+00	bd080027-1aa2-4c42-8f8c-0bdc23ab9887	8dab5312-dbee-4f86-83dd-0874ffc99c46	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
9e92c109-1785-4418-b8e8-dfdc81420895	2026-03-31 17:00:37.139176+00	a4552dd6-0b7e-4ebd-b69e-92ee204c9904	8dab5312-dbee-4f86-83dd-0874ffc99c46	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
d763bac4-30bd-4ec0-8849-264cbdd62f9e	2026-03-31 17:00:37.986585+00	a4552dd6-0b7e-4ebd-b69e-92ee204c9904	466a4031-fc42-48c9-88c5-1a1925e19912	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
c9325793-3d12-4259-acf6-fd20ec8d0279	2026-02-25 09:35:20.782252+00	5b9f22de-846f-47b0-ac93-1b274e2e17e9	9430b606-42b0-45c9-aca3-c56c6d23d11b	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
3e95de89-aac0-4afa-82ad-825eff1aa7c4	2026-02-25 09:35:20.782252+00	5b9f22de-846f-47b0-ac93-1b274e2e17e9	00ef1cb1-a558-407b-8798-c0db3f382cb8	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
eb769fd8-e953-4686-a7cb-9a90bb2d9511	2026-02-25 09:35:20.782252+00	5b9f22de-846f-47b0-ac93-1b274e2e17e9	86c197e6-24db-4d82-8572-d86b5ca15b2f	\N	t	AND	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
92787a9f-b76d-402e-bc21-7f46fa0bad47	2026-02-25 09:35:20.782252+00	5b9f22de-846f-47b0-ac93-1b274e2e17e9	a3f3ccb1-7c00-4b52-9837-dc69331b521c	\N	t	AND	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
82af56ba-ed11-496a-9b03-fb9e69258c69	2026-02-25 09:35:21.302135+00	4813087b-e9d9-4bb7-81ea-9a0918d58c05	f6b2c3bc-2197-44c1-a848-d18a66e3fdf5	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
00eeb10c-1c81-4f6a-b49a-984431f955a0	2026-02-25 09:35:21.801743+00	8568df07-8697-4698-a91f-bab066a24501	70610b82-10ea-46b2-a99b-59c187db69da	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ad527f16-97e7-4e43-b2e5-202a0a5c4e92	2026-02-25 09:35:21.801743+00	8568df07-8697-4698-a91f-bab066a24501	7851fd12-1e6f-4a02-b957-c2120bc0ac83	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6df51d9a-146a-4904-97a4-378f43e6b2c8	2026-02-25 09:35:21.801743+00	8568df07-8697-4698-a91f-bab066a24501	a41687b8-6f23-46d2-abbb-285d71a1331c	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f4cf500d-8b23-4cf2-9c98-67a69a9a5bd8	2026-02-25 09:35:21.801743+00	8568df07-8697-4698-a91f-bab066a24501	8b2745aa-d94a-48b9-be06-1aa87aac12d0	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
08d9f696-fb25-4082-accc-cb560591706e	2026-02-25 09:35:21.801743+00	8568df07-8697-4698-a91f-bab066a24501	386cac04-cc49-4dd7-bb14-b17b9760795b	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a49f3cc3-1e7e-45d8-9400-9cc5291709eb	2026-02-25 09:35:21.801743+00	8568df07-8697-4698-a91f-bab066a24501	ed3a44cb-388f-431a-bf56-2d35af78ea8a	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
212477df-b9f9-4f73-9685-87a74dab3d43	2026-02-25 09:35:22.328616+00	1bbc1288-e5ad-4a1d-9b92-e9c17c1cbb39	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a7e2b30d-223f-4ec8-8380-4125dc8fc6ee	2026-02-25 09:35:22.328616+00	1bbc1288-e5ad-4a1d-9b92-e9c17c1cbb39	e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e8ce8d95-9528-4a3e-b9f7-6d8f0eb2aa58	2026-02-25 09:35:22.328616+00	1bbc1288-e5ad-4a1d-9b92-e9c17c1cbb39	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7fa791bd-cec7-4245-9648-fecba47c0ff3	2026-02-25 09:35:22.328616+00	1bbc1288-e5ad-4a1d-9b92-e9c17c1cbb39	7374ef8e-c3b3-40aa-b6b4-7ae7159a7ce6	\N	t	ANR	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
13f7c6c7-cb54-4b50-b5d2-a5db3ae76c11	2026-02-25 09:35:22.328616+00	1bbc1288-e5ad-4a1d-9b92-e9c17c1cbb39	d2566406-84dd-4204-a6c7-31a91107623a	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
374e710f-a5cf-40cd-9d4b-4361aab7cd86	2026-02-25 09:39:27.558029+00	260e2537-ea44-4fe1-9e17-b0f19e419a1b	9c87739b-74ad-47b9-a70f-6efc26c93f00	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d73acfaf-1dfd-40ec-b081-d5af97bdea39	2026-02-26 08:41:57.227984+00	5d280258-202f-42cd-a2ba-a0158a383d4f	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	\N	t	VENT	f	2026-04-26	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2869b964-3f46-47a9-9153-9bc8e46b3bd4	2026-02-25 09:39:27.558029+00	260e2537-ea44-4fe1-9e17-b0f19e419a1b	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
142e6867-c438-4a57-a4ad-ef431643bbb4	2026-02-25 09:39:27.558029+00	260e2537-ea44-4fe1-9e17-b0f19e419a1b	ce4184ad-5144-4b9b-8276-0111197e0885	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5e6d82e6-a029-47e6-89b5-4a659baa0be6	2026-02-25 09:39:28.082254+00	e736e97f-7c81-47ed-b7bf-c49714bc2a2f	9aa72019-ede1-4b37-a63b-400a20a683a7	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d07444cc-12ce-468f-af95-9a7a30677d91	2026-02-26 08:41:57.227984+00	5d280258-202f-42cd-a2ba-a0158a383d4f	d2566406-84dd-4204-a6c7-31a91107623a	\N	t	VENT	f	2026-04-26	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
9b2b30b9-b743-41b9-a5e4-0865d84d6984	2026-02-25 09:39:28.082254+00	e736e97f-7c81-47ed-b7bf-c49714bc2a2f	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5706edc8-f2dd-4ca5-ac17-6ed25a35037e	2026-02-25 09:39:28.082254+00	e736e97f-7c81-47ed-b7bf-c49714bc2a2f	01fdbddd-ee76-4200-a153-47cc61d67398	\N	t	🅰️	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ecd18231-f396-484b-bda8-fe72d25d15ba	2026-02-25 09:39:28.082254+00	e736e97f-7c81-47ed-b7bf-c49714bc2a2f	7dd68452-30ed-4829-857d-bebc61aff9c1	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
15c933f6-b4dc-456f-be71-5b05236d3089	2026-02-25 09:39:28.574983+00	ff398855-d610-4ae2-bf36-bb519a828237	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2ae0b611-ea6d-49d6-8219-f393ce1d246a	2026-02-25 09:39:28.574983+00	ff398855-d610-4ae2-bf36-bb519a828237	97a3f8b8-caff-4988-b24a-2b7e54d155ee	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
eaf0dc99-ce42-4f93-9f6a-dc32f8fcaf01	2026-02-25 09:39:28.574983+00	ff398855-d610-4ae2-bf36-bb519a828237	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
84ff03ff-e99b-473b-912f-4ffe9e694c26	2026-02-25 09:39:28.574983+00	ff398855-d610-4ae2-bf36-bb519a828237	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
3b5e845c-ddea-4e8d-8cf0-f5ab5d6f1163	2026-02-25 09:39:28.574983+00	ff398855-d610-4ae2-bf36-bb519a828237	13e202ee-272d-415f-8d66-f7669b85afb8	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
45f43b74-8a2d-4333-ac32-eba12a762b7a	2026-02-25 09:39:28.574983+00	ff398855-d610-4ae2-bf36-bb519a828237	6c379005-03bc-478f-aabd-ad3f75f6477a	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
503edda4-550f-4190-8b93-8eef8fe639f5	2026-02-25 09:39:28.574983+00	ff398855-d610-4ae2-bf36-bb519a828237	2d98b2aa-9762-4798-8e28-fcb15c380bf5	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c8b7a49c-e6a9-406a-aee8-751f68bdd5e8	2026-02-25 09:39:29.2456+00	1861c9ab-7d30-40c9-a501-e23095777a19	8b6e4db3-9332-457c-8e1a-ad88af0c40be	c48c89f9-082b-4835-9a9f-e3ee05ed3476	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7876124a-fed5-4030-a3a2-22875838321f	2026-02-25 09:39:29.2456+00	1861c9ab-7d30-40c9-a501-e23095777a19	ddbca8c2-9bfd-4ab2-90d1-8c8127be9331	b6d87440-e59a-402a-81f1-4d996a9a9300	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
968aada7-8ab7-4632-bde4-ab8103f98a10	2026-02-25 09:39:29.2456+00	1861c9ab-7d30-40c9-a501-e23095777a19	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
69cf8551-a088-4e0d-8f0d-92141c002263	2026-02-25 09:39:29.2456+00	1861c9ab-7d30-40c9-a501-e23095777a19	7e7447f5-56a1-4513-9606-978058d389d5	d532c50a-26f4-4491-bcb3-e8fe9bb5105d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
dff61a8c-0c2f-4b1a-a19f-ff41a4bc598c	2026-02-25 09:39:29.2456+00	1861c9ab-7d30-40c9-a501-e23095777a19	ceb5bad4-3051-4086-ac9c-a67e6c124aee	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e102af84-b5a4-44f7-b49b-ae5b531824c6	2026-02-26 08:21:05.530989+00	555ccb27-8d80-4e2b-b5b9-aea2ed283984	f6b2c3bc-2197-44c1-a848-d18a66e3fdf5	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ec207515-716d-4741-86e7-2c1deb4db5ef	2026-02-26 08:41:55.700248+00	40c750a6-5e68-4fd3-8fed-25b5204f9c03	86c197e6-24db-4d82-8572-d86b5ca15b2f	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
263e2892-45b8-4012-884a-bb2c2374c2b4	2026-02-26 08:41:55.700248+00	40c750a6-5e68-4fd3-8fed-25b5204f9c03	a3f3ccb1-7c00-4b52-9837-dc69331b521c	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
165d7dc8-8c00-4b4c-8fb9-88b9339c90a3	2026-02-26 08:41:55.700248+00	40c750a6-5e68-4fd3-8fed-25b5204f9c03	00ef1cb1-a558-407b-8798-c0db3f382cb8	\N	t	ANR	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1f8f8245-e5bd-4602-9736-e50576f90a4f	2026-02-26 08:41:57.227984+00	5d280258-202f-42cd-a2ba-a0158a383d4f	e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	\N	t	VENT	f	2026-04-26	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
01dfae5e-de27-4a32-b698-694bc50f3fbb	2026-02-26 08:41:57.227984+00	5d280258-202f-42cd-a2ba-a0158a383d4f	7374ef8e-c3b3-40aa-b6b4-7ae7159a7ce6	\N	t	VENT	f	2026-04-26	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
376c85c0-24e6-4d32-9eec-c373f2073637	2026-02-26 08:41:57.227984+00	5d280258-202f-42cd-a2ba-a0158a383d4f	01fdbddd-ee76-4200-a153-47cc61d67398	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7807e138-f42a-4a60-a93f-fbd7fe07a9aa	2026-03-31 17:44:17.294448+00	f2e2785b-4254-4382-8901-03f73320dc4d	86c197e6-24db-4d82-8572-d86b5ca15b2f	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-04-01	f
86d1ec76-97b5-4eac-8187-33f6fc76b9b2	2026-02-26 08:58:19.504501+00	da0b805c-72f5-4d2c-bb1c-60a759dca349	d2566406-84dd-4204-a6c7-31a91107623a	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
debd4992-a5a4-4e1d-b254-10e1dbe8c796	2026-02-26 09:13:22.551191+00	de9f9356-1fd2-4d2a-aea9-584ad5b0f1ad	7c879cb9-b214-4851-9fb7-cd84b0698bb7	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5d730c7b-75ef-4011-9867-ff3871f18750	2026-02-25 09:39:27.558029+00	260e2537-ea44-4fe1-9e17-b0f19e419a1b	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8998d3cf-0112-4c62-b972-42be35d3a07e	2026-02-26 08:41:55.700248+00	40c750a6-5e68-4fd3-8fed-25b5204f9c03	9430b606-42b0-45c9-aca3-c56c6d23d11b	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d7d5cd28-5d69-4473-bd00-d9c7d8127b20	2026-02-25 09:39:29.740867+00	db348560-d2b8-487c-b78c-09f5a442bd02	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
510aae06-0fce-49d3-8335-6fd5a44590cf	2026-02-25 09:39:29.740867+00	db348560-d2b8-487c-b78c-09f5a442bd02	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
779c4f5b-01aa-4f69-b65d-3fcd1626f6ad	2026-02-25 09:39:29.740867+00	db348560-d2b8-487c-b78c-09f5a442bd02	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8f3c74ff-579b-4e18-89c9-3baf43905b48	2026-03-31 13:35:21.025402+00	bd080027-1aa2-4c42-8f8c-0bdc23ab9887	8a158331-8983-4d93-8d27-616394540f3d	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
5df49766-ce34-464a-bee8-b3e52bc2b375	2026-03-31 17:00:37.419557+00	a4552dd6-0b7e-4ebd-b69e-92ee204c9904	aaedc900-37ff-4b01-88cb-82c36deffca8	c6bc37d8-7c43-4ae3-9c95-4f6488a42f09	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
7e6ee58e-4dc6-486d-ad78-3f4923cf8a10	2026-02-25 09:43:19.568135+00	e0639365-a3d0-4b61-95b9-e088cca4f90e	9430b606-42b0-45c9-aca3-c56c6d23d11b	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
bfcd7d83-8dd0-40df-8982-88c3fbd3de54	2026-02-25 09:43:19.568135+00	e0639365-a3d0-4b61-95b9-e088cca4f90e	86c197e6-24db-4d82-8572-d86b5ca15b2f	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f13befe9-0e90-4323-91a1-9863a6e90eaf	2026-02-25 09:43:19.568135+00	e0639365-a3d0-4b61-95b9-e088cca4f90e	00ef1cb1-a558-407b-8798-c0db3f382cb8	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
40a8d33e-84e1-4a1d-9f8f-15409ca570db	2026-02-25 09:43:19.568135+00	e0639365-a3d0-4b61-95b9-e088cca4f90e	a3f3ccb1-7c00-4b52-9837-dc69331b521c	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
26526794-eea0-4759-825f-6d84cde6cbc9	2026-02-25 09:43:20.309517+00	c7263cb1-3be8-44fd-b534-08bc314b3e99	f6b2c3bc-2197-44c1-a848-d18a66e3fdf5	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ed12f757-9551-429b-b8b7-025802305919	2026-02-25 09:43:20.309517+00	c7263cb1-3be8-44fd-b534-08bc314b3e99	b0054d27-f377-41ad-a026-a2893c27692a	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1c31b4b2-3a82-427f-a5d2-252f16d64674	2026-02-25 09:43:20.309517+00	c7263cb1-3be8-44fd-b534-08bc314b3e99	1d2c9275-719e-452b-9298-ec476ac53155	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5d8ca89e-b03f-456c-9711-065b8e1cce95	2026-02-25 09:43:20.309517+00	c7263cb1-3be8-44fd-b534-08bc314b3e99	7c879cb9-b214-4851-9fb7-cd84b0698bb7	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f04e512c-4f08-4b28-aaf0-5a3791cbe066	2026-02-25 09:43:21.044332+00	d7c14e1a-4268-445f-ba82-6375e72c0885	70610b82-10ea-46b2-a99b-59c187db69da	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a5d9aff0-ef55-434f-b22e-eb4977a2d0c9	2026-02-25 09:43:21.044332+00	d7c14e1a-4268-445f-ba82-6375e72c0885	7851fd12-1e6f-4a02-b957-c2120bc0ac83	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
05e1af09-5334-4685-9196-3fd7be709228	2026-02-25 09:43:21.044332+00	d7c14e1a-4268-445f-ba82-6375e72c0885	a41687b8-6f23-46d2-abbb-285d71a1331c	\N	t	AND	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2356f8d7-94ae-46b1-935c-1096b9dabb1f	2026-02-25 09:43:21.044332+00	d7c14e1a-4268-445f-ba82-6375e72c0885	8b2745aa-d94a-48b9-be06-1aa87aac12d0	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
66fab322-c43e-4a70-b59b-0c2a76611bea	2026-02-25 09:43:21.044332+00	d7c14e1a-4268-445f-ba82-6375e72c0885	386cac04-cc49-4dd7-bb14-b17b9760795b	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d607f903-da7a-4845-b227-417d6a59f3fc	2026-02-25 09:43:21.044332+00	d7c14e1a-4268-445f-ba82-6375e72c0885	ed3a44cb-388f-431a-bf56-2d35af78ea8a	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f8af898b-18bc-4bcc-a022-b71ee92b605e	2026-02-25 09:43:21.756836+00	3af5bc97-0b0a-4f4d-8644-75ccf58e1069	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f3377dd0-329b-4c59-aaab-b22b1bdb29cc	2026-02-25 09:43:21.756836+00	3af5bc97-0b0a-4f4d-8644-75ccf58e1069	e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
14dd1825-cd4c-408a-9cb8-6dbf5f944b75	2026-02-25 09:43:21.756836+00	3af5bc97-0b0a-4f4d-8644-75ccf58e1069	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e2870231-52c6-4467-ae4a-c576c99c0df9	2026-02-25 09:43:21.756836+00	3af5bc97-0b0a-4f4d-8644-75ccf58e1069	7374ef8e-c3b3-40aa-b6b4-7ae7159a7ce6	\N	t	ANR	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
3cbc8507-cbf2-4009-9c2c-d0b2fab70fed	2026-02-25 09:43:21.756836+00	3af5bc97-0b0a-4f4d-8644-75ccf58e1069	d2566406-84dd-4204-a6c7-31a91107623a	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d83a381b-fe58-4265-bff0-cb1a7daea732	2026-02-26 08:21:05.530989+00	555ccb27-8d80-4e2b-b5b9-aea2ed283984	7c879cb9-b214-4851-9fb7-cd84b0698bb7	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
60001102-a78c-49bc-a17a-0719cf459fff	2026-02-25 09:48:11.146497+00	426ba16b-4754-4009-8fbb-4c60751166b8	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	\N	t	SCOUBIDOU	f	2025-11-19	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
abbe44f7-a305-4bd8-a4c3-4a6d40a679ef	2026-02-25 09:48:09.549819+00	f0860785-fe45-4b7d-90d3-ecf45fcf770f	13e202ee-272d-415f-8d66-f7669b85afb8	\N	t	HIAOU	f	2025-11-22	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
2db8b202-cdca-4f08-a03e-87c823493890	2026-02-25 09:48:09.549819+00	f0860785-fe45-4b7d-90d3-ecf45fcf770f	97a3f8b8-caff-4988-b24a-2b7e54d155ee	\N	t	CHARLY	f	2025-11-22	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
ae4b625d-9091-437c-8809-7f8271f7108d	2026-02-25 09:47:43.623137+00	3be3fde7-d79c-4406-b134-ab753ba7c9e6	9c87739b-74ad-47b9-a70f-6efc26c93f00	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b664e5d4-ee46-41ee-9131-d28ad3b2b606	2026-02-25 09:48:09.549819+00	f0860785-fe45-4b7d-90d3-ecf45fcf770f	6c379005-03bc-478f-aabd-ad3f75f6477a	\N	t	\N	f	2026-01-31	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
1ed1ce35-f917-43c9-a768-9df3b7cbc4c9	2026-02-25 09:47:43.623137+00	3be3fde7-d79c-4406-b134-ab753ba7c9e6	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e2a6fedd-5756-4333-8382-fec95539931f	2026-02-25 09:47:43.623137+00	3be3fde7-d79c-4406-b134-ab753ba7c9e6	ce4184ad-5144-4b9b-8276-0111197e0885	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6e2531c3-b1d8-4b9c-bcd5-1ef869cf3f0a	2026-02-25 09:47:44.131667+00	45492e65-17c7-4458-9dbf-29b31fa36051	9aa72019-ede1-4b37-a63b-400a20a683a7	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f868611c-5786-4deb-8427-6a7486b6bff0	2026-02-25 09:47:44.131667+00	45492e65-17c7-4458-9dbf-29b31fa36051	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
84239ff5-b10f-40d3-83a2-c6e2d5d154c5	2026-02-25 09:47:44.131667+00	45492e65-17c7-4458-9dbf-29b31fa36051	1c9e7097-df1c-4540-b79b-35055f8f080f	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
93560fdc-04c8-41ef-9b30-72f390b87172	2026-02-25 09:47:44.131667+00	45492e65-17c7-4458-9dbf-29b31fa36051	7dd68452-30ed-4829-857d-bebc61aff9c1	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
875e21c4-0346-4dd0-a10d-f502bc491e56	2026-02-25 09:48:09.549819+00	f0860785-fe45-4b7d-90d3-ecf45fcf770f	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	\N	t	EM'N'EMS	f	2025-12-06	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
10f1d307-51ee-45e8-9860-9acfd28df364	2026-02-25 09:47:44.645874+00	913d6fe9-f265-4282-a42f-799317153e00	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
60eb79f0-f8fc-424f-b415-b438b5182331	2026-02-25 09:47:44.645874+00	913d6fe9-f265-4282-a42f-799317153e00	13e202ee-272d-415f-8d66-f7669b85afb8	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
458a4a61-3a2d-47b3-a6aa-959d6ee5191c	2026-02-25 09:47:44.645874+00	913d6fe9-f265-4282-a42f-799317153e00	6c379005-03bc-478f-aabd-ad3f75f6477a	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d1d6778e-f170-40c1-ba63-7b5d35b39f40	2026-02-25 09:47:44.645874+00	913d6fe9-f265-4282-a42f-799317153e00	2d98b2aa-9762-4798-8e28-fcb15c380bf5	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a09b341a-322c-431d-8187-19c0949658b7	2026-02-25 09:47:56.240192+00	19471820-fbbf-43d1-ab22-635c5a352858	70610b82-10ea-46b2-a99b-59c187db69da	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
77da9b7e-eed8-4154-a809-b2445d770a73	2026-02-25 09:47:56.240192+00	19471820-fbbf-43d1-ab22-635c5a352858	7851fd12-1e6f-4a02-b957-c2120bc0ac83	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
82e2fcbf-8fed-4020-bfe0-0145b534d085	2026-02-25 09:47:56.240192+00	19471820-fbbf-43d1-ab22-635c5a352858	8b2745aa-d94a-48b9-be06-1aa87aac12d0	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5cf118fb-b9ba-4283-a992-38dd2a1e4294	2026-02-25 09:47:56.240192+00	19471820-fbbf-43d1-ab22-635c5a352858	386cac04-cc49-4dd7-bb14-b17b9760795b	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
fb2fc14f-bcd5-4903-8543-323f50cf5283	2026-02-25 09:47:56.240192+00	19471820-fbbf-43d1-ab22-635c5a352858	ed3a44cb-388f-431a-bf56-2d35af78ea8a	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
eecf461b-13c2-4065-8efc-1976b95432b9	2026-02-25 09:47:43.623137+00	3be3fde7-d79c-4406-b134-ab753ba7c9e6	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a7cd4312-4102-472c-9fd7-4dbe84615132	2026-02-25 09:47:44.645874+00	913d6fe9-f265-4282-a42f-799317153e00	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	\N	t	EXKY	f	2025-11-22	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
08b16ff0-a58f-4ff1-a325-399cb01538ef	2026-04-01 18:30:23.70305+00	c170a167-f63d-4d0c-95a4-1bffb638607e	8a158331-8983-4d93-8d27-616394540f3d	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
5171d202-c2a5-4b60-86be-4e696c5ec1a4	2026-04-01 18:30:24.2204+00	c170a167-f63d-4d0c-95a4-1bffb638607e	7fb3adc8-4473-43a4-84a8-c76a60e2665f	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
e3828a7b-915b-4f5a-af52-92c1763115d8	2026-02-25 09:48:09.549819+00	f0860785-fe45-4b7d-90d3-ecf45fcf770f	2d98b2aa-9762-4798-8e28-fcb15c380bf5	\N	t	ANR	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
254260c0-f803-4270-bca5-21608f74ee92	2026-02-25 09:48:11.146497+00	426ba16b-4754-4009-8fbb-4c60751166b8	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ab7a4b04-000f-4345-98c5-ab5aa80e130b	2026-02-25 09:48:11.146497+00	426ba16b-4754-4009-8fbb-4c60751166b8	97a3f8b8-caff-4988-b24a-2b7e54d155ee	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5274d605-c9d8-44d8-8502-3a11ca3d3bd7	2026-02-25 09:48:11.146497+00	426ba16b-4754-4009-8fbb-4c60751166b8	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
348580e0-49ba-4c31-99ca-644f9c62c9bd	2026-02-25 09:48:11.146497+00	426ba16b-4754-4009-8fbb-4c60751166b8	6c379005-03bc-478f-aabd-ad3f75f6477a	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
bf3b0d60-f1e7-4506-aa5f-db10b137b41d	2026-02-25 09:48:11.146497+00	426ba16b-4754-4009-8fbb-4c60751166b8	2d98b2aa-9762-4798-8e28-fcb15c380bf5	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
36db92d8-5aea-48ba-a9d0-f71a63a2d9b4	2026-02-25 09:47:55.729109+00	3c4953cb-3a8b-48df-80c4-92eed60e1ac6	b0054d27-f377-41ad-a026-a2893c27692a	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
821692e6-7226-4b37-a588-15551e5d1e0d	2026-02-25 09:47:55.729109+00	3c4953cb-3a8b-48df-80c4-92eed60e1ac6	1d2c9275-719e-452b-9298-ec476ac53155	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
700e5591-6747-4001-b548-55b9390aae68	2026-02-25 09:47:55.729109+00	3c4953cb-3a8b-48df-80c4-92eed60e1ac6	7c879cb9-b214-4851-9fb7-cd84b0698bb7	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a42e1218-d269-473f-8337-ea959959f042	2026-02-25 09:47:44.645874+00	913d6fe9-f265-4282-a42f-799317153e00	97a3f8b8-caff-4988-b24a-2b7e54d155ee	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
05aba46e-f7f9-406f-a951-c567c59a8afb	2026-02-25 09:47:55.729109+00	3c4953cb-3a8b-48df-80c4-92eed60e1ac6	f6b2c3bc-2197-44c1-a848-d18a66e3fdf5	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e49ac622-bc43-4c91-b2bf-ecb2cc557eb3	2026-02-25 09:48:10.669215+00	03d86523-24e9-49e6-b1db-63425d157c49	9aa72019-ede1-4b37-a63b-400a20a683a7	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
17a0231b-f967-431f-a0ae-5e7c543a667b	2026-02-25 09:48:10.669215+00	03d86523-24e9-49e6-b1db-63425d157c49	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
02392bfd-55fd-4a76-a0f6-5188172e7cc2	2026-02-25 09:48:10.669215+00	03d86523-24e9-49e6-b1db-63425d157c49	1c9e7097-df1c-4540-b79b-35055f8f080f	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2507224c-c252-447c-b065-484c96162eaa	2026-02-25 09:48:10.669215+00	03d86523-24e9-49e6-b1db-63425d157c49	7dd68452-30ed-4829-857d-bebc61aff9c1	\N	t	\N	f	2026-03-21	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
9229bdf7-a416-4c3f-b174-49d4ea3e38af	2026-02-25 09:48:14.443959+00	ce4d876d-77a0-4e3f-9aea-4e51915f8737	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	\N	t	EM'N'EMS	f	2025-12-17	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
232ea07f-6a37-43b6-99f1-af2aa93f236c	2026-02-25 09:48:14.443959+00	ce4d876d-77a0-4e3f-9aea-4e51915f8737	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
bb8ceee6-ab13-47b0-9ad1-c22c25b1a558	2026-02-25 09:48:14.443959+00	ce4d876d-77a0-4e3f-9aea-4e51915f8737	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
34650a73-4134-4103-9213-afefa9b25cc9	2026-03-07 14:48:06.095201+00	e6990c20-c4c3-40a8-88d5-16516c13629f	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-03-07	f
9bed5189-9323-4538-97db-6ec899b1005e	2026-02-26 09:15:53.447433+00	ea74d0d7-d1cf-496c-8150-d7b452655885	7c879cb9-b214-4851-9fb7-cd84b0698bb7	\N	t	QUININE	f	2026-01-24	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
a0fcae25-aaf1-4d0a-9e85-631bc1388190	2026-03-31 13:46:27.647959+00	09e83f94-7344-42a1-a8c4-893bae272b51	aaedc900-37ff-4b01-88cb-82c36deffca8	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
acdd1fb2-d0c9-4b5f-8b50-275cd70a86d7	2026-02-26 09:15:53.447433+00	ea74d0d7-d1cf-496c-8150-d7b452655885	b0054d27-f377-41ad-a026-a2893c27692a	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d3353edf-9537-41c4-a03c-1f9e54a8a6a6	2026-02-26 09:15:53.447433+00	ea74d0d7-d1cf-496c-8150-d7b452655885	1d2c9275-719e-452b-9298-ec476ac53155	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
fa2480ae-c276-475c-a612-21f984df6faf	2026-03-31 17:13:46.158719+00	0163f795-7b5b-40b2-b8de-6853ebec9bb7	893bb307-08a3-4af2-ba54-6c5da32206ad	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
e79f8f0a-e72e-4500-b9b9-ba4463fd9189	2026-03-31 17:45:18.115773+00	f2e2785b-4254-4382-8901-03f73320dc4d	a3f3ccb1-7c00-4b52-9837-dc69331b521c	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-04-01	f
db5b9481-088a-4792-983a-06a769c4851c	2026-02-26 09:15:53.447433+00	ea74d0d7-d1cf-496c-8150-d7b452655885	f6b2c3bc-2197-44c1-a848-d18a66e3fdf5	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
381fa9c2-c6a9-4ab2-8502-005d0507b73a	2026-02-23 14:52:23.56165+00	cd6e72e3-0a96-41bb-be86-0aa459db0c20	d2566406-84dd-4204-a6c7-31a91107623a	\N	t	BALKAN	f	2026-01-24	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
fc0430fa-71fb-4e49-95a1-38e029cbd373	2026-02-26 09:15:54.484676+00	67967bb4-b0ec-462b-9d85-6824afaf3002	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e2cecd7f-65bc-4ed5-918e-0196f23b6ab8	2026-02-26 09:15:54.484676+00	67967bb4-b0ec-462b-9d85-6824afaf3002	e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
255f963f-156c-4045-ad6c-2943294e52d4	2026-02-26 09:15:54.484676+00	67967bb4-b0ec-462b-9d85-6824afaf3002	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
db397bc7-ed16-4e66-a8f3-f3236cfc10ab	2026-02-26 09:15:54.484676+00	67967bb4-b0ec-462b-9d85-6824afaf3002	7374ef8e-c3b3-40aa-b6b4-7ae7159a7ce6	c6bc37d8-7c43-4ae3-9c95-4f6488a42f09	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4129a3bc-5d30-4e6f-9c7e-4177ef487320	2026-02-26 09:15:54.484676+00	67967bb4-b0ec-462b-9d85-6824afaf3002	d2566406-84dd-4204-a6c7-31a91107623a	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6f08b6a3-782d-437f-8bb5-270061bf775e	2026-02-26 09:26:45.581351+00	4251bd3e-a2bd-4ae4-bd66-667c5d4d4ce8	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-01-31	f
03f4c79c-7aa5-4de8-b2bd-90eaadc24115	2026-02-26 09:36:19.576052+00	f39916f5-209f-4ec0-9101-7cb792c57390	9430b606-42b0-45c9-aca3-c56c6d23d11b	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ba906a0d-46fc-4e9c-9637-0d1641e2607d	2026-02-26 09:36:19.576052+00	f39916f5-209f-4ec0-9101-7cb792c57390	86c197e6-24db-4d82-8572-d86b5ca15b2f	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
3258720f-e102-4335-a101-ceb8875c6ac4	2026-02-26 09:36:19.576052+00	f39916f5-209f-4ec0-9101-7cb792c57390	00ef1cb1-a558-407b-8798-c0db3f382cb8	\N	t	RATTRAPAGE	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
437114ca-2f87-4292-b8e6-00680a15a484	2026-02-26 09:36:19.576052+00	f39916f5-209f-4ec0-9101-7cb792c57390	a3f3ccb1-7c00-4b52-9837-dc69331b521c	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
32b339dd-26d1-4be3-8949-88b793add89c	2026-02-26 09:36:20.860157+00	9b32720f-f5ea-47bf-9cc5-c6b620330159	70610b82-10ea-46b2-a99b-59c187db69da	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b2ffb7c4-64fb-4a9f-b67d-0d70a95e35ac	2026-02-26 09:36:20.860157+00	9b32720f-f5ea-47bf-9cc5-c6b620330159	7851fd12-1e6f-4a02-b957-c2120bc0ac83	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7dab12ad-f9cd-43ea-b3cd-8f8f2ff96498	2026-02-26 09:36:20.860157+00	9b32720f-f5ea-47bf-9cc5-c6b620330159	a41687b8-6f23-46d2-abbb-285d71a1331c	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
bd399395-6be5-4050-a4c2-1415a9124089	2026-02-26 09:36:20.860157+00	9b32720f-f5ea-47bf-9cc5-c6b620330159	8b2745aa-d94a-48b9-be06-1aa87aac12d0	\N	t	ANR	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
57400a2f-3eca-41ec-a882-938a73c8db2e	2026-02-26 09:36:20.860157+00	9b32720f-f5ea-47bf-9cc5-c6b620330159	386cac04-cc49-4dd7-bb14-b17b9760795b	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
40444d62-4160-443a-84a5-e7081ffa04cf	2026-02-26 09:36:20.860157+00	9b32720f-f5ea-47bf-9cc5-c6b620330159	ed3a44cb-388f-431a-bf56-2d35af78ea8a	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f246131e-340c-42d7-ace0-2ac92605d28a	2026-02-26 08:41:56.211914+00	3727bd2b-ae09-4060-bfb1-4392298f4ff9	f6b2c3bc-2197-44c1-a848-d18a66e3fdf5	\N	t	DIAOUL	f	2026-01-14	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
5c8a8f28-81de-49bf-99cf-865c511de460	2026-02-26 08:41:56.211914+00	3727bd2b-ae09-4060-bfb1-4392298f4ff9	7c879cb9-b214-4851-9fb7-cd84b0698bb7	\N	t	QUININE	f	2026-01-14	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
d5bcc721-ea19-4e29-91e5-b0eedf186422	2026-02-26 08:41:56.211914+00	3727bd2b-ae09-4060-bfb1-4392298f4ff9	1d2c9275-719e-452b-9298-ec476ac53155	\N	t	EXKY	f	2026-01-17	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
afd799f3-2acb-426c-a3b5-a70d1231e130	2026-03-06 08:56:13.504386+00	6283ef1c-cddd-4198-8bb2-4b7d7b06ca03	9430b606-42b0-45c9-aca3-c56c6d23d11b	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a4264794-acea-4dcc-ade3-c0aebdcba7a2	2026-03-06 08:56:13.504386+00	6283ef1c-cddd-4198-8bb2-4b7d7b06ca03	86c197e6-24db-4d82-8572-d86b5ca15b2f	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
17dbb4d0-9605-49e0-9b21-125fd2e3bfed	2026-02-26 08:41:56.211914+00	3727bd2b-ae09-4060-bfb1-4392298f4ff9	b0054d27-f377-41ad-a026-a2893c27692a	\N	t	RATTRAPAGE	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
04bf78d7-fbee-47eb-a9ec-73fbba60ece1	2026-03-06 08:56:13.504386+00	6283ef1c-cddd-4198-8bb2-4b7d7b06ca03	a3f3ccb1-7c00-4b52-9837-dc69331b521c	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ed33316b-ffff-40ca-9c21-8c88ad0f4b42	2026-03-06 08:56:15.041062+00	a8500ea8-9372-4659-b4d4-a284be7110b1	7374ef8e-c3b3-40aa-b6b4-7ae7159a7ce6	c6bc37d8-7c43-4ae3-9c95-4f6488a42f09	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
83c9fba8-b6a3-4a9e-bc3c-8c4e853eaa51	2026-03-06 08:56:15.041062+00	a8500ea8-9372-4659-b4d4-a284be7110b1	e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
043e73d4-b8d4-4189-b49f-3b6d53af9904	2026-03-06 08:56:15.041062+00	a8500ea8-9372-4659-b4d4-a284be7110b1	01fdbddd-ee76-4200-a153-47cc61d67398	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
34331992-8cf8-4f67-9130-a10af878ad2c	2026-03-06 08:56:15.041062+00	a8500ea8-9372-4659-b4d4-a284be7110b1	d2566406-84dd-4204-a6c7-31a91107623a	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f82487eb-eb52-4b9e-b60c-8952868e2893	2026-03-06 08:56:15.041062+00	a8500ea8-9372-4659-b4d4-a284be7110b1	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	\N	t	Entorse	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2fca347b-bf4e-4740-8470-4e8c46e76679	2026-02-25 09:48:10.669215+00	03d86523-24e9-49e6-b1db-63425d157c49	01fdbddd-ee76-4200-a153-47cc61d67398	\N	t	🅰️	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ba93f30c-16c5-4cd0-bba5-5d2d093ad3b3	2026-02-26 08:23:06.752155+00	555ccb27-8d80-4e2b-b5b9-aea2ed283984	ceb5bad4-3051-4086-ac9c-a67e6c124aee	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2025-12-13	f
73287973-96fe-4d0e-9f04-1b32cd24b6e5	2026-02-26 09:41:07.531068+00	b1caa34e-dffe-4deb-90f5-516d18244bc6	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-02-07	f
1c23b61b-c095-46c8-a3ab-3bf58618d244	2026-03-06 08:56:13.504386+00	6283ef1c-cddd-4198-8bb2-4b7d7b06ca03	00ef1cb1-a558-407b-8798-c0db3f382cb8	\N	t	AND ⛔️	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7defe23e-fe94-4be2-9e65-4e837d02e8c1	2026-02-26 08:59:31.552857+00	4866e879-864f-4aa7-b021-3599ff90a516	f6b2c3bc-2197-44c1-a848-d18a66e3fdf5	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-01-07	f
0f2aa8b7-0dc7-4f01-be86-f8cdc005d3aa	2026-02-25 09:47:45.154978+00	d7f30622-ad01-4a54-975e-1102decb39de	ddbca8c2-9bfd-4ab2-90d1-8c8127be9331	\N	t	1s/2. S.P.	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
15141a00-d368-4ccb-9b2c-a13d5260f8bd	2026-03-31 12:59:14.946206+00	3be3fde7-d79c-4406-b134-ab753ba7c9e6	3cbd32b1-84a7-4596-92d0-903d6ea1f631	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
8f9a4ad9-a3c5-4c0a-b85d-801f914f5638	2026-03-31 12:59:38.986649+00	3be3fde7-d79c-4406-b134-ab753ba7c9e6	080111ef-d8d7-4662-ba20-cd5ff1bfa389	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
cfff61b1-32af-4938-ad94-4e75fcb865e9	2026-03-31 13:46:28.455844+00	09e83f94-7344-42a1-a8c4-893bae272b51	466a4031-fc42-48c9-88c5-1a1925e19912	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
3ecb7c02-b7de-4180-b0dc-b9fd25e15270	2026-03-31 17:13:46.966506+00	0163f795-7b5b-40b2-b8de-6853ebec9bb7	3cbd32b1-84a7-4596-92d0-903d6ea1f631	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
0668ceaa-86b6-4d64-9dec-27547bffb436	2026-02-25 09:47:56.74836+00	beb9ca03-4d63-4f32-a4d0-deb4e597e044	01fdbddd-ee76-4200-a153-47cc61d67398	\N	t	ALYSSON	f	2025-11-22	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
e9b2af49-8d82-4991-89b0-9a6a70f70db2	2026-02-25 09:48:05.629161+00	0ce7ec21-608e-46b1-b81f-6c26e2bc4f76	ed3a44cb-388f-431a-bf56-2d35af78ea8a	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9727a565-7bbf-4e76-9546-3a459e9f4086	2026-02-25 09:47:56.74836+00	beb9ca03-4d63-4f32-a4d0-deb4e597e044	7374ef8e-c3b3-40aa-b6b4-7ae7159a7ce6	\N	t	ANR ⛔️	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
72033341-a3f6-4df4-8593-d2b47124db4f	2026-04-02 10:36:12.1636+00	fa2fb244-570c-418f-b2b1-93236d860438	aaedc900-37ff-4b01-88cb-82c36deffca8	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
957438d5-31d9-4acc-a804-c50954e8cf39	2026-04-02 10:36:12.769751+00	fa2fb244-570c-418f-b2b1-93236d860438	8a158331-8983-4d93-8d27-616394540f3d	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
4a8293b8-ea5c-479c-83a8-92e29ce53670	2026-04-02 10:36:13.334698+00	fa2fb244-570c-418f-b2b1-93236d860438	466a4031-fc42-48c9-88c5-1a1925e19912	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
0882bc48-f1cf-47c5-bc68-7b5fd49beba7	2026-02-25 09:48:06.155993+00	361a8041-3e45-44bd-8efb-7e4ae1d445f6	e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d36a130e-179d-4f0c-bf22-bcacd14ceaec	2026-04-02 10:36:13.859237+00	fa2fb244-570c-418f-b2b1-93236d860438	0328157c-5422-4fea-94a7-87f84d287645	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
0c684849-afe1-4611-b7ed-fc2d6d006373	2026-02-25 09:48:06.155993+00	361a8041-3e45-44bd-8efb-7e4ae1d445f6	d2566406-84dd-4204-a6c7-31a91107623a	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6515f14a-4aa4-4aee-a1a4-c84fe99dab8b	2026-04-02 10:36:14.364183+00	fa2fb244-570c-418f-b2b1-93236d860438	322417b3-f05a-488c-b3b6-8956e7e4413a	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
99bed944-9ef8-49c5-9bc3-fd0cb8b3a6dc	2026-02-25 09:47:45.154978+00	d7f30622-ad01-4a54-975e-1102decb39de	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
57297d90-d86c-4fbb-a6e4-b22d2d7a3929	2026-02-25 09:47:45.154978+00	d7f30622-ad01-4a54-975e-1102decb39de	7e7447f5-56a1-4513-9606-978058d389d5	b6d87440-e59a-402a-81f1-4d996a9a9300	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
60f68666-a99c-4193-8262-abbd276c737b	2026-02-25 09:47:45.154978+00	d7f30622-ad01-4a54-975e-1102decb39de	ceb5bad4-3051-4086-ac9c-a67e6c124aee	d532c50a-26f4-4491-bcb3-e8fe9bb5105d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
eaba4806-3c03-4795-b190-5384cf131ccc	2026-02-25 09:47:45.653654+00	ed090252-a1a7-4d94-88b2-1960f956f38e	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
facacdbd-3296-439f-9127-de8d8efae20a	2026-02-25 09:47:45.653654+00	ed090252-a1a7-4d94-88b2-1960f956f38e	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
65c11b88-328b-48f5-bc78-473112da26da	2026-02-25 09:47:56.74836+00	beb9ca03-4d63-4f32-a4d0-deb4e597e044	e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	\N	t	ANR ⛔️	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
d2e52452-48da-494a-b81a-5ee06c9c7892	2026-02-25 09:47:55.156063+00	9a07f6b9-15bf-47b5-a175-d6e80d60b1e5	9430b606-42b0-45c9-aca3-c56c6d23d11b	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1a0374a3-4178-4af6-afbb-7b218d9d9a78	2026-02-25 09:47:55.156063+00	9a07f6b9-15bf-47b5-a175-d6e80d60b1e5	86c197e6-24db-4d82-8572-d86b5ca15b2f	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
63b04241-77b1-4328-8027-3e4e87a2ac72	2026-02-25 09:47:55.156063+00	9a07f6b9-15bf-47b5-a175-d6e80d60b1e5	00ef1cb1-a558-407b-8798-c0db3f382cb8	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f0aa2dba-fe46-46d4-9ac2-e304b68997e3	2026-02-25 09:47:55.156063+00	9a07f6b9-15bf-47b5-a175-d6e80d60b1e5	a3f3ccb1-7c00-4b52-9837-dc69331b521c	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
08abf0b3-2cb7-4a0c-97bb-59af57e10c9f	2026-02-25 09:47:56.74836+00	beb9ca03-4d63-4f32-a4d0-deb4e597e044	d2566406-84dd-4204-a6c7-31a91107623a	\N	t	\N	f	2026-03-07	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6eef1b30-b456-43d2-a77a-399ea33b9f65	2026-02-25 09:48:08.575875+00	a30358b7-9ec5-4b46-8373-ad6ff7d3812a	9c87739b-74ad-47b9-a70f-6efc26c93f00	\N	t	RATTRAPAGE	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b020e086-070f-4d11-bf11-cdae045232f4	2026-02-25 09:47:56.937515+00	8630ca85-a482-4220-b9ce-ad9c53e3641e	86c197e6-24db-4d82-8572-d86b5ca15b2f	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a56719d7-b62e-46cb-8cb1-64f3d0b99a2c	2026-02-25 09:47:56.937515+00	8630ca85-a482-4220-b9ce-ad9c53e3641e	00ef1cb1-a558-407b-8798-c0db3f382cb8	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
072a0869-3ee6-4329-a053-9a2f20fb9777	2026-02-25 09:47:56.937515+00	8630ca85-a482-4220-b9ce-ad9c53e3641e	a3f3ccb1-7c00-4b52-9837-dc69331b521c	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
516b3f40-df01-4c9a-a68d-2ebacdb899f1	2026-02-25 09:47:57.449235+00	4b9050ae-9cb6-47ff-8aaa-d4a50da170eb	f6b2c3bc-2197-44c1-a848-d18a66e3fdf5	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
bd12e961-763d-4f75-83a4-623b0f1c3f3d	2026-02-25 09:47:57.449235+00	4b9050ae-9cb6-47ff-8aaa-d4a50da170eb	b0054d27-f377-41ad-a026-a2893c27692a	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
3f5a4129-5246-4636-8459-1567d4a80f12	2026-02-25 09:47:57.449235+00	4b9050ae-9cb6-47ff-8aaa-d4a50da170eb	1d2c9275-719e-452b-9298-ec476ac53155	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9ae3550d-0ca5-4d03-817f-a131f804b431	2026-02-25 09:47:58.05576+00	444a7e78-34b0-4d7e-b1f9-f6c063f21b0b	70610b82-10ea-46b2-a99b-59c187db69da	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
bdd47375-639d-437e-b0de-be689972f905	2026-02-25 09:47:58.05576+00	444a7e78-34b0-4d7e-b1f9-f6c063f21b0b	7851fd12-1e6f-4a02-b957-c2120bc0ac83	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8691132f-ba88-4059-bde5-df1bc608639c	2026-02-25 09:47:58.05576+00	444a7e78-34b0-4d7e-b1f9-f6c063f21b0b	a41687b8-6f23-46d2-abbb-285d71a1331c	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
96b39a14-389c-4b95-9533-9444a01102ea	2026-02-25 09:47:58.05576+00	444a7e78-34b0-4d7e-b1f9-f6c063f21b0b	8b2745aa-d94a-48b9-be06-1aa87aac12d0	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
cbdbe05c-77d8-4317-a1a0-2ec4d648464a	2026-02-25 09:47:58.05576+00	444a7e78-34b0-4d7e-b1f9-f6c063f21b0b	386cac04-cc49-4dd7-bb14-b17b9760795b	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4e79063b-2279-41a0-936c-e9ef823e0d6e	2026-02-25 09:47:58.05576+00	444a7e78-34b0-4d7e-b1f9-f6c063f21b0b	ed3a44cb-388f-431a-bf56-2d35af78ea8a	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
bda3b4ff-96d6-41cc-8649-7966fac59e13	2026-02-25 09:47:58.644282+00	bcd47ff5-5a64-4898-aa4f-d4c4b64d95ef	e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
48f066de-e8d3-4c8d-8768-0122c2a47f41	2026-02-25 09:47:58.644282+00	bcd47ff5-5a64-4898-aa4f-d4c4b64d95ef	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
beb5869b-3e14-4f50-90b9-6fce7e980dfa	2026-02-25 09:47:58.644282+00	bcd47ff5-5a64-4898-aa4f-d4c4b64d95ef	7374ef8e-c3b3-40aa-b6b4-7ae7159a7ce6	\N	t	ANR	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
41e35365-4b24-409c-8699-d305b83cbf1f	2026-02-25 09:47:58.644282+00	bcd47ff5-5a64-4898-aa4f-d4c4b64d95ef	d2566406-84dd-4204-a6c7-31a91107623a	\N	t	RATTRAPAGE	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0f9a95fb-cc61-4680-bbda-103bfcbf9139	2026-02-25 09:48:04.597417+00	b794c2ea-fab2-43ab-a5a1-2b9f463d5166	9430b606-42b0-45c9-aca3-c56c6d23d11b	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
72840b45-8cd9-4ff6-a48b-56ada864252a	2026-02-25 09:48:04.597417+00	b794c2ea-fab2-43ab-a5a1-2b9f463d5166	00ef1cb1-a558-407b-8798-c0db3f382cb8	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
3c42fd90-c27f-4e7b-b4e0-9c1cf96b8f9e	2026-02-25 09:48:04.597417+00	b794c2ea-fab2-43ab-a5a1-2b9f463d5166	a3f3ccb1-7c00-4b52-9837-dc69331b521c	\N	t	DIAOUL	f	2026-01-28	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0dc04b4d-52ab-41fc-9bd6-a6e106c6cf16	2026-02-25 09:48:05.098254+00	ef6ab570-95dd-43ce-9ddf-c74b11bc1c38	f6b2c3bc-2197-44c1-a848-d18a66e3fdf5	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c442303e-6092-42de-b350-9d156b8c8288	2026-02-25 09:48:05.098254+00	ef6ab570-95dd-43ce-9ddf-c74b11bc1c38	b0054d27-f377-41ad-a026-a2893c27692a	d532c50a-26f4-4491-bcb3-e8fe9bb5105d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e05f07e5-56cf-4caa-9a10-463519b13e75	2026-02-25 09:48:05.098254+00	ef6ab570-95dd-43ce-9ddf-c74b11bc1c38	1d2c9275-719e-452b-9298-ec476ac53155	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
30c2ffc2-26a0-456d-9722-a7a24e2e9c0b	2026-02-25 09:48:05.098254+00	ef6ab570-95dd-43ce-9ddf-c74b11bc1c38	7c879cb9-b214-4851-9fb7-cd84b0698bb7	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5f0314c9-cea4-4366-aaeb-ff249b44518e	2026-02-25 09:48:05.629161+00	0ce7ec21-608e-46b1-b81f-6c26e2bc4f76	70610b82-10ea-46b2-a99b-59c187db69da	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ad0db607-ba4b-4cbe-82c5-5e1f47b29f41	2026-02-25 09:48:05.629161+00	0ce7ec21-608e-46b1-b81f-6c26e2bc4f76	a41687b8-6f23-46d2-abbb-285d71a1331c	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2a62fbfa-0c25-4bad-be80-cae24ab7f8a6	2026-02-25 09:48:05.629161+00	0ce7ec21-608e-46b1-b81f-6c26e2bc4f76	8b2745aa-d94a-48b9-be06-1aa87aac12d0	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ad10e66c-50a9-4803-9785-13018b4cc42f	2026-02-25 09:48:05.629161+00	0ce7ec21-608e-46b1-b81f-6c26e2bc4f76	386cac04-cc49-4dd7-bb14-b17b9760795b	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
76d8ec78-241f-4175-bbfc-f7786312848f	2026-02-25 09:48:06.155993+00	361a8041-3e45-44bd-8efb-7e4ae1d445f6	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5413f10a-c4b5-4e8f-9c1f-0d61a5fff3d4	2026-02-25 09:48:06.155993+00	361a8041-3e45-44bd-8efb-7e4ae1d445f6	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2cc9b3a9-76f0-4f84-a1b0-ca695d74833a	2026-02-25 09:48:12.110257+00	e5b02c6a-bb0c-424d-80b0-ca0123725715	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
09d1c065-45b6-4dea-9610-eba773d8d62b	2026-02-25 09:48:12.110257+00	e5b02c6a-bb0c-424d-80b0-ca0123725715	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
935f77b6-35c9-435f-9376-5c53986f8675	2026-02-25 09:48:08.575875+00	a30358b7-9ec5-4b46-8373-ad6ff7d3812a	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	\N	t	RATTRAPAGE	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
cd3f7097-9f6b-4c49-90a9-b3500fcfe78b	2026-02-25 09:48:08.575875+00	a30358b7-9ec5-4b46-8373-ad6ff7d3812a	ce4184ad-5144-4b9b-8276-0111197e0885	\N	t	RATTRAPAGE	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f6a0ae94-181b-4834-bfd8-6ad2890efc35	2026-02-25 09:48:12.110257+00	e5b02c6a-bb0c-424d-80b0-ca0123725715	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a253e12b-52f5-4d24-9342-32b0fe848ad5	2026-02-25 09:48:12.981326+00	2a33e3b2-becf-48b8-b1e8-b078ab60023d	9aa72019-ede1-4b37-a63b-400a20a683a7	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d01c4cf6-7f27-4ff6-a331-7c6d5a97814f	2026-02-25 09:48:12.981326+00	2a33e3b2-becf-48b8-b1e8-b078ab60023d	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
43f38ee3-29aa-4168-af86-666e4508d0af	2026-02-25 09:48:12.981326+00	2a33e3b2-becf-48b8-b1e8-b078ab60023d	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c075f002-2741-40a0-b03e-465ba748a1e0	2026-02-25 09:48:12.981326+00	2a33e3b2-becf-48b8-b1e8-b078ab60023d	7dd68452-30ed-4829-857d-bebc61aff9c1	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
09b5f02d-b768-4394-b233-55294b9233ea	2026-02-25 09:48:08.575875+00	a30358b7-9ec5-4b46-8373-ad6ff7d3812a	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	\N	t	🅰️	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0e4d1b29-c173-4991-828c-8d6ae691da43	2026-02-26 08:27:26.95992+00	b1b53a5f-50e8-4416-a05a-dad1c3395ea2	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
186c3664-63a4-43c1-baa5-f5738640f7bf	2026-02-26 08:27:26.95992+00	b1b53a5f-50e8-4416-a05a-dad1c3395ea2	ce4184ad-5144-4b9b-8276-0111197e0885	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a36bbb0f-0c30-4b52-a480-a0cbf3996892	2026-02-26 08:28:37.206749+00	b1b53a5f-50e8-4416-a05a-dad1c3395ea2	7dd68452-30ed-4829-857d-bebc61aff9c1	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d1565f15-87d4-47fd-b745-33107a52312b	2026-02-26 08:27:28.560681+00	2386035f-3114-40c5-852f-dddbdb4ae8a3	8b6e4db3-9332-457c-8e1a-ad88af0c40be	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
61511a9c-26c3-47c8-bbaa-562495d32d12	2026-02-26 08:27:28.560681+00	2386035f-3114-40c5-852f-dddbdb4ae8a3	ddbca8c2-9bfd-4ab2-90d1-8c8127be9331	\N	t	BOUD'ZAN	f	2025-12-20	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
84b82f9b-f9d4-4d07-8a77-027231cc3396	2026-02-26 08:27:28.560681+00	2386035f-3114-40c5-852f-dddbdb4ae8a3	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c07028ba-2add-4866-819e-03de3cc73675	2026-02-26 08:27:28.560681+00	2386035f-3114-40c5-852f-dddbdb4ae8a3	7e7447f5-56a1-4513-9606-978058d389d5	d532c50a-26f4-4491-bcb3-e8fe9bb5105d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
55794c17-4a13-469b-8af8-37f4a2d3b99f	2026-02-26 08:27:28.560681+00	2386035f-3114-40c5-852f-dddbdb4ae8a3	ceb5bad4-3051-4086-ac9c-a67e6c124aee	\N	t	EM'N'EMS	f	2025-12-10	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
ed0edc0e-3a45-4092-80b2-ddebf48a86a4	2026-03-27 16:21:49.489764+00	4056c417-8a23-4ca3-a5c1-3d613149057e	\N	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Gizem KAYA	\N	f	\N	\N	\N	f
efa9d386-f1b9-424c-b572-c5a0d80537d7	2026-02-26 08:47:37.111364+00	310632f0-f85f-4cb5-bdf3-d9901192a21f	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
be37ec58-1885-45a8-bdb8-a800199d68c9	2026-02-26 08:47:37.111364+00	310632f0-f85f-4cb5-bdf3-d9901192a21f	7e7447f5-56a1-4513-9606-978058d389d5	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7a4698cd-093b-4da7-8917-55aceb65f2eb	2026-02-26 08:47:37.111364+00	310632f0-f85f-4cb5-bdf3-d9901192a21f	ceb5bad4-3051-4086-ac9c-a67e6c124aee	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0d926791-f6dd-4aa1-837b-a6b6b3f3becb	2026-02-26 08:47:35.22926+00	a716377a-2088-458f-aa9b-30d8095e77f0	9c87739b-74ad-47b9-a70f-6efc26c93f00	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
3cd5030e-613f-4720-b324-bc53e2ab981f	2026-02-26 08:47:35.22926+00	a716377a-2088-458f-aa9b-30d8095e77f0	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	\N	t	ANR	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4438c20c-c53a-4876-9fc1-f75b802e336d	2026-02-26 08:47:35.22926+00	a716377a-2088-458f-aa9b-30d8095e77f0	ce4184ad-5144-4b9b-8276-0111197e0885	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a24e0df5-7183-40d6-8442-5a82ce41ce1c	2026-02-26 08:47:37.111364+00	310632f0-f85f-4cb5-bdf3-d9901192a21f	8b6e4db3-9332-457c-8e1a-ad88af0c40be	\N	t	ANR	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
276ddf12-7632-4654-8f61-5be8bac1e7c4	2026-02-26 08:47:37.111364+00	310632f0-f85f-4cb5-bdf3-d9901192a21f	ddbca8c2-9bfd-4ab2-90d1-8c8127be9331	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
3b7ad470-78f3-43e4-a7b4-69413e89a306	2026-02-26 09:15:52.920602+00	2d76669f-07dd-41ba-b0e8-0b7b98ba8487	9430b606-42b0-45c9-aca3-c56c6d23d11b	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
fd115784-d865-4357-9f32-d16928c716fa	2026-02-26 09:15:52.920602+00	2d76669f-07dd-41ba-b0e8-0b7b98ba8487	86c197e6-24db-4d82-8572-d86b5ca15b2f	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9f7eff25-ed0c-4fe2-b3bc-0e32ebf89687	2026-02-26 09:15:52.920602+00	2d76669f-07dd-41ba-b0e8-0b7b98ba8487	00ef1cb1-a558-407b-8798-c0db3f382cb8	\N	t	ANR	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f10da999-53b6-4731-8724-1279220f58bb	2026-02-26 09:15:52.920602+00	2d76669f-07dd-41ba-b0e8-0b7b98ba8487	a3f3ccb1-7c00-4b52-9837-dc69331b521c	\N	t	ANR	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8a76947a-b29f-461b-9ebb-139dbce782aa	2026-02-26 09:15:53.961952+00	32505e7a-c50a-4f7e-8153-9953ea108b9a	70610b82-10ea-46b2-a99b-59c187db69da	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
11613c32-8427-452f-94fb-af7d1f70a61d	2026-02-26 09:15:53.961952+00	32505e7a-c50a-4f7e-8153-9953ea108b9a	7851fd12-1e6f-4a02-b957-c2120bc0ac83	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0bb6dd8b-7703-4e0c-bfed-07880484e357	2026-02-26 09:15:53.961952+00	32505e7a-c50a-4f7e-8153-9953ea108b9a	a41687b8-6f23-46d2-abbb-285d71a1331c	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
aa307eaf-3926-476e-a446-c56f301729e9	2026-02-26 09:27:50.666234+00	3447bd6b-755e-48df-be3e-81551e4aff05	9c87739b-74ad-47b9-a70f-6efc26c93f00	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8bbea398-2d60-42db-ae3d-222dc0339a43	2026-02-26 09:15:53.961952+00	32505e7a-c50a-4f7e-8153-9953ea108b9a	8b2745aa-d94a-48b9-be06-1aa87aac12d0	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
dd7cbb0c-cfd4-4a70-a292-b12b0efecd97	2026-02-26 09:15:53.961952+00	32505e7a-c50a-4f7e-8153-9953ea108b9a	386cac04-cc49-4dd7-bb14-b17b9760795b	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
95d26216-d87b-4a01-b984-3844a1d89c70	2026-02-26 09:15:53.961952+00	32505e7a-c50a-4f7e-8153-9953ea108b9a	ed3a44cb-388f-431a-bf56-2d35af78ea8a	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
79667ec7-3f74-4972-9338-0d22079ff453	2026-03-27 16:21:57.146338+00	55037829-053a-4c3e-abeb-942745cebae0	8dab5312-dbee-4f86-83dd-0874ffc99c46	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
197c05bd-a3de-468a-92cf-804034c07473	2026-02-26 09:27:51.659254+00	707ed250-b1a1-45f0-b4d8-26a77989a4e9	13e202ee-272d-415f-8d66-f7669b85afb8	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
215dd66b-b0ae-4d29-9129-c9d15a883a62	2026-02-26 09:27:51.659254+00	707ed250-b1a1-45f0-b4d8-26a77989a4e9	6c379005-03bc-478f-aabd-ad3f75f6477a	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0705dace-ca14-4473-bc92-a23e40c92d80	2026-02-26 09:27:52.60914+00	94bc355c-365a-4b76-9468-e0a4b7dd6437	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	\N	t	QUININE	f	2026-01-28	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
acd99bb4-331d-404c-a424-38edac156896	2026-02-26 09:27:50.666234+00	3447bd6b-755e-48df-be3e-81551e4aff05	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6b5f112e-ff70-4862-a957-c86fb9766426	2026-02-26 09:27:50.666234+00	3447bd6b-755e-48df-be3e-81551e4aff05	ce4184ad-5144-4b9b-8276-0111197e0885	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
53fefd49-1e75-4c4d-b411-711d4a6b5339	2026-02-26 09:28:35.345617+00	3447bd6b-755e-48df-be3e-81551e4aff05	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-02-07	f
15b71dab-6cce-4b95-a4a9-58faba18a659	2026-02-26 09:27:51.659254+00	707ed250-b1a1-45f0-b4d8-26a77989a4e9	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f1234ee3-7beb-4113-90a0-e8ebaba38a4c	2026-02-26 09:27:51.659254+00	707ed250-b1a1-45f0-b4d8-26a77989a4e9	97a3f8b8-caff-4988-b24a-2b7e54d155ee	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
08ec7baa-d922-499c-9608-802cc769d015	2026-02-26 09:27:51.659254+00	707ed250-b1a1-45f0-b4d8-26a77989a4e9	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	\N	t	ANR	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b9884ed7-eba6-48e9-996c-71dad791b67f	2026-02-26 09:27:51.659254+00	707ed250-b1a1-45f0-b4d8-26a77989a4e9	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
40f370d8-ca12-479c-b8ed-84a5aeab846f	2026-02-26 09:27:51.659254+00	707ed250-b1a1-45f0-b4d8-26a77989a4e9	2d98b2aa-9762-4798-8e28-fcb15c380bf5	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5b5f1df3-27f9-4dbd-90df-c5f8f94aefb5	2026-02-26 08:59:39.634972+00	4866e879-864f-4aa7-b021-3599ff90a516	7c879cb9-b214-4851-9fb7-cd84b0698bb7	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-01-07	f
647b02af-0a6f-44e8-b752-8003f3541d7a	2026-02-26 09:27:52.60914+00	94bc355c-365a-4b76-9468-e0a4b7dd6437	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a962a751-d410-4861-88a5-d022f44c6fcb	2026-02-26 09:27:52.60914+00	94bc355c-365a-4b76-9468-e0a4b7dd6437	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8df6caad-3b4f-4063-8aa3-8c38d34c6850	2026-03-31 13:05:37.034435+00	e08f664a-a285-449e-ad59-9d5346b59d38	893bb307-08a3-4af2-ba54-6c5da32206ad	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
dec64704-6c98-4b23-be73-be1ca4d8bcd0	2026-02-26 09:36:21.367335+00	3d18a280-48c7-4a3b-95a7-1a3b3504d907	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	8d1e0213-3958-4a1a-8d8a-473cd765cebf	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c0da3116-3ab8-4468-acc2-532c8c401ec4	2026-02-26 09:36:21.367335+00	3d18a280-48c7-4a3b-95a7-1a3b3504d907	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d639b78f-3639-4a04-ada5-9cb92e861a12	2026-02-26 09:36:21.367335+00	3d18a280-48c7-4a3b-95a7-1a3b3504d907	7374ef8e-c3b3-40aa-b6b4-7ae7159a7ce6	c6bc37d8-7c43-4ae3-9c95-4f6488a42f09	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2f78a87d-bb3e-4abb-9343-e2118e5ce90e	2026-03-04 14:09:09.562215+00	e6990c20-c4c3-40a8-88d5-16516c13629f	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
3a204683-69af-48fa-930b-8806d42e4da6	2026-02-26 08:27:27.466531+00	89611d83-acca-4477-955d-c1d1610f79ce	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	\N	t	VENOM	f	2026-01-10	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
47148e56-0d3b-4afb-ba8c-d323227c30a8	2026-02-26 09:27:51.132129+00	79bfb15d-03f1-4264-8f14-67ea3bf69834	1c9e7097-df1c-4540-b79b-35055f8f080f	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
14d14239-61f0-450e-bbcf-4f2bbdbf674d	2026-02-26 09:27:51.132129+00	79bfb15d-03f1-4264-8f14-67ea3bf69834	7dd68452-30ed-4829-857d-bebc61aff9c1	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
8477f5c8-a6d5-4153-bc31-22112df1efc9	2026-02-25 09:48:13.454294+00	446aec95-8636-450c-b2ea-15e7c4f29792	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	\N	t	EM'N'EMS	f	2026-01-10	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
bf031c8f-c770-4bd6-8f11-b7c9d8e737ab	2026-03-04 14:09:11.367707+00	b721e3e0-3ab4-47f0-a5dd-a156f7f6f41e	8b6e4db3-9332-457c-8e1a-ad88af0c40be	c48c89f9-082b-4835-9a9f-e3ee05ed3476	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
60d53888-4067-4e23-ab83-4038cfa32b5e	2026-02-26 08:27:27.466531+00	89611d83-acca-4477-955d-c1d1610f79ce	01fdbddd-ee76-4200-a153-47cc61d67398	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c8c486ed-6331-488a-9389-0101c45ebd79	2026-02-25 09:48:13.454294+00	446aec95-8636-450c-b2ea-15e7c4f29792	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	\N	t	EM'N'EMS	f	2026-01-17	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
74429113-f837-499c-9e17-31e0d3fb9ad7	2026-03-04 14:09:09.562215+00	e6990c20-c4c3-40a8-88d5-16516c13629f	ce4184ad-5144-4b9b-8276-0111197e0885	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a1e8dcf7-9fa5-4046-8bcb-2a3df8e12263	2026-02-25 09:48:13.454294+00	446aec95-8636-450c-b2ea-15e7c4f29792	97a3f8b8-caff-4988-b24a-2b7e54d155ee	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6005f88a-fe45-495e-8c19-eb5976851df1	2026-02-25 09:48:13.454294+00	446aec95-8636-450c-b2ea-15e7c4f29792	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	\N	t	\N	f	2025-12-06	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8a4af016-eafc-4062-9dd9-fe33baea998a	2026-03-04 14:09:09.562215+00	e6990c20-c4c3-40a8-88d5-16516c13629f	9c87739b-74ad-47b9-a70f-6efc26c93f00	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4482ad76-c3b9-411c-952f-4f5f1b65ae4a	2026-02-25 09:48:13.454294+00	446aec95-8636-450c-b2ea-15e7c4f29792	13e202ee-272d-415f-8d66-f7669b85afb8	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7bb12105-a980-47f5-937c-9a6dce3faaa6	2026-02-25 09:48:13.454294+00	446aec95-8636-450c-b2ea-15e7c4f29792	6c379005-03bc-478f-aabd-ad3f75f6477a	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2b1aa6ef-39d0-4310-ac65-a9367d98697a	2026-02-25 09:48:13.454294+00	446aec95-8636-450c-b2ea-15e7c4f29792	2d98b2aa-9762-4798-8e28-fcb15c380bf5	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a85a1ccc-57ea-4703-8e58-09a71cb13f47	2026-02-26 08:27:27.466531+00	89611d83-acca-4477-955d-c1d1610f79ce	9aa72019-ede1-4b37-a63b-400a20a683a7	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0ed49320-c1e0-4eaa-83e8-4c5624b75d73	2026-02-26 08:27:27.466531+00	89611d83-acca-4477-955d-c1d1610f79ce	1c9e7097-df1c-4540-b79b-35055f8f080f	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
3e4a9df8-eb82-4cb1-b0aa-38671d62fdcf	2026-02-26 08:27:27.466531+00	89611d83-acca-4477-955d-c1d1610f79ce	7dd68452-30ed-4829-857d-bebc61aff9c1	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7895ec60-1b7f-49dd-8b4a-6e0849c1fd22	2026-03-04 14:09:11.367707+00	b721e3e0-3ab4-47f0-a5dd-a156f7f6f41e	ddbca8c2-9bfd-4ab2-90d1-8c8127be9331	03331a64-cbca-4ae6-b260-80308e787efc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
3717b3cd-bfbd-44fc-9e21-1d971b044b52	2026-02-26 08:27:29.049568+00	4147745a-4b17-47b9-9629-24abf134f88e	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
90f2aad4-be06-4786-b29b-09d45c1599b4	2026-02-26 08:27:29.049568+00	4147745a-4b17-47b9-9629-24abf134f88e	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
41afd664-41aa-436f-a56d-c774f722e6ca	2026-02-26 08:27:29.049568+00	4147745a-4b17-47b9-9629-24abf134f88e	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0cf17466-070d-436e-9f55-b5c90a743a4b	2026-02-26 08:47:36.104189+00	e25e7b46-4f82-4794-9be5-4bfecb733da4	9aa72019-ede1-4b37-a63b-400a20a683a7	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e93b69f0-4fbe-40a0-aeea-a4d1f9ece25a	2026-02-26 08:47:36.104189+00	e25e7b46-4f82-4794-9be5-4bfecb733da4	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f0f2f86a-04f0-4d0f-ae9d-a1e910c7bcc7	2026-02-26 08:47:36.104189+00	e25e7b46-4f82-4794-9be5-4bfecb733da4	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
984fd68c-4e60-4ac5-bfaa-38dac99182ac	2026-02-26 08:47:36.104189+00	e25e7b46-4f82-4794-9be5-4bfecb733da4	1c9e7097-df1c-4540-b79b-35055f8f080f	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0f4a1299-0ef7-4b44-9156-62a47bb8f6e7	2026-02-26 08:47:36.104189+00	e25e7b46-4f82-4794-9be5-4bfecb733da4	7dd68452-30ed-4829-857d-bebc61aff9c1	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
bf388544-f7bf-437c-b380-b7da76064830	2026-02-26 08:47:37.633518+00	1bc4ac24-436c-4792-aff6-5182aba42a0a	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
721798c1-978e-4bc5-9a4e-febd961f9e1e	2026-02-26 08:47:37.633518+00	1bc4ac24-436c-4792-aff6-5182aba42a0a	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
30320a95-b68b-4341-b920-6bb51eabbce5	2026-02-26 08:47:37.633518+00	1bc4ac24-436c-4792-aff6-5182aba42a0a	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
69990b81-c834-446d-8dce-33ebe3d2e01d	2026-02-26 09:05:35.714516+00	f58d4582-80ff-485e-ab32-2b15fc7ed606	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
52c0a156-4e4e-4eab-9bc5-543d402fb339	2026-02-26 09:27:51.132129+00	79bfb15d-03f1-4264-8f14-67ea3bf69834	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1c3d487f-adf0-422f-bb37-ab9cf20fd45e	2026-02-26 09:27:51.132129+00	79bfb15d-03f1-4264-8f14-67ea3bf69834	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
442daf46-22c6-4da9-92ed-d1c3475d82f4	2026-03-31 13:05:37.59201+00	e08f664a-a285-449e-ad59-9d5346b59d38	322417b3-f05a-488c-b3b6-8956e7e4413a	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
79a534dc-4e07-4986-a958-62c5c51a7487	2026-03-27 16:21:49.758274+00	4056c417-8a23-4ca3-a5c1-3d613149057e	\N	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Amina	\N	f	\N	\N	\N	f
94c91243-b00d-4a9f-b43d-57f6feae5c53	2026-02-25 09:48:09.04898+00	f3cd3208-63a6-4b95-aced-5e12764cb669	01fdbddd-ee76-4200-a153-47cc61d67398	\N	t	🅰️	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
762c0d9b-7aa3-40d8-94f7-88337bb32986	2026-02-26 09:27:52.127099+00	301f761c-911e-458d-9e09-b9869a3b5a2b	ddbca8c2-9bfd-4ab2-90d1-8c8127be9331	\N	t	ANR	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d198fbf3-0161-4be3-80c7-e4dc089d9a5f	2026-02-26 09:27:52.127099+00	301f761c-911e-458d-9e09-b9869a3b5a2b	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
85247b84-57eb-4158-8503-b230f94d159a	2026-02-26 09:27:52.127099+00	301f761c-911e-458d-9e09-b9869a3b5a2b	7e7447f5-56a1-4513-9606-978058d389d5	b6d87440-e59a-402a-81f1-4d996a9a9300	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d4c2582e-7fa5-452f-8a51-f9bc5044b865	2026-02-26 09:27:52.127099+00	301f761c-911e-458d-9e09-b9869a3b5a2b	ceb5bad4-3051-4086-ac9c-a67e6c124aee	d532c50a-26f4-4491-bcb3-e8fe9bb5105d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
28d5900f-7513-4e0c-910a-c088a571e952	2026-02-26 09:36:21.367335+00	3d18a280-48c7-4a3b-95a7-1a3b3504d907	d2566406-84dd-4204-a6c7-31a91107623a	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
daaacd3d-fb5c-48d5-a8ab-14b6c01944b3	2026-02-26 09:41:23.920207+00	b1caa34e-dffe-4deb-90f5-516d18244bc6	7c879cb9-b214-4851-9fb7-cd84b0698bb7	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-01-21	f
23e4221a-6cad-4e33-a14b-50c3e430c06d	2026-02-25 09:48:09.04898+00	f3cd3208-63a6-4b95-aced-5e12764cb669	1c9e7097-df1c-4540-b79b-35055f8f080f	\N	t	RATTRAPAGE	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
211a6fc4-2c46-4eba-9e4e-06685300d959	2026-02-25 09:48:09.04898+00	f3cd3208-63a6-4b95-aced-5e12764cb669	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	\N	t	VENOM	f	2025-11-29	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
5620fb6a-364c-4580-a0f4-25c8387d3aa8	2026-02-25 09:48:09.04898+00	f3cd3208-63a6-4b95-aced-5e12764cb669	9aa72019-ede1-4b37-a63b-400a20a683a7	\N	t	DIAOUL	f	2025-11-29	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
4230c192-8532-4d74-93e4-b8da54c8f52e	2026-02-25 09:48:10.678233+00	1b06f56d-05cc-4891-beca-e4babde61556	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	\N	t	PETITON'R	f	2025-12-06	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
3232f007-a0f0-4361-bca2-2692ec56e48b	2026-02-25 09:48:10.678233+00	1b06f56d-05cc-4891-beca-e4babde61556	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	\N	t	BE WIZE	f	2025-12-06	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
294f6437-2f79-4ce3-ad28-b0cce5ce6aa2	2026-02-25 09:48:09.04898+00	f3cd3208-63a6-4b95-aced-5e12764cb669	7dd68452-30ed-4829-857d-bebc61aff9c1	\N	t	EXKY	f	2025-12-13	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
21640823-fca1-45a6-99e1-8687aae3b41c	2026-03-04 14:09:09.562215+00	e6990c20-c4c3-40a8-88d5-16516c13629f	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7233430c-8564-4927-a67f-b81a65a0981c	2026-03-27 16:21:50.989755+00	4056c417-8a23-4ca3-a5c1-3d613149057e	\N	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Kubra DEMIR	\N	f	\N	\N	\N	f
a695ceb6-c006-4545-811c-cb1de0674ccb	2026-03-27 16:21:56.647817+00	55037829-053a-4c3e-abeb-942745cebae0	893bb307-08a3-4af2-ba54-6c5da32206ad	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
9eaef477-d5db-4245-b373-c8bb2ea4d7a8	2026-03-27 16:21:58.317547+00	55037829-053a-4c3e-abeb-942745cebae0	080111ef-d8d7-4662-ba20-cd5ff1bfa389	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
9e1f36e7-e0a6-485f-8fd8-7c59560942ab	2026-02-26 09:06:34.231436+00	51dd6893-2456-4c8d-a80c-2db452619567	a3f3ccb1-7c00-4b52-9837-dc69331b521c	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2025-09-24	f
1a2697d3-fda2-4a44-9bd8-2caa8bdeb94b	2026-02-26 09:27:52.127099+00	301f761c-911e-458d-9e09-b9869a3b5a2b	8b6e4db3-9332-457c-8e1a-ad88af0c40be	\N	t	MALADE	f	2026-03-07	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
9e2561cb-9c8b-404a-8f9f-ac44fae5b1d0	2026-03-31 13:46:29.083015+00	09e83f94-7344-42a1-a8c4-893bae272b51	\N	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Naomi	\N	f	\N	\N	\N	f
3682f79f-4f95-4258-b9dc-bc00e35dd798	2026-02-25 09:48:11.636775+00	138d43d0-1c89-46cc-aaa7-43ef52418145	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d5699d49-7659-4742-94e3-c6b95a0d2997	2026-02-25 09:48:11.636775+00	138d43d0-1c89-46cc-aaa7-43ef52418145	7e7447f5-56a1-4513-9606-978058d389d5	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
3c92f070-a4a5-4a9e-ba1b-8486fdb9966b	2026-02-25 09:48:11.636775+00	138d43d0-1c89-46cc-aaa7-43ef52418145	ceb5bad4-3051-4086-ac9c-a67e6c124aee	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
bccaca0c-cb2e-4df3-8921-13a4b8df9c24	2026-03-27 16:21:50.012592+00	4056c417-8a23-4ca3-a5c1-3d613149057e	466a4031-fc42-48c9-88c5-1a1925e19912	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
c69d390a-3e1a-4584-bc25-cb497d1b7d40	2026-02-25 09:48:12.500027+00	ce6506b4-3400-4b57-b684-5ebd3add6900	9c87739b-74ad-47b9-a70f-6efc26c93f00	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
811a3e20-0b5f-4f3e-854d-cbd105220072	2026-02-25 09:48:10.187011+00	2e1b56fc-f0c7-44ba-9f10-a398c4dbde04	9c87739b-74ad-47b9-a70f-6efc26c93f00	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a5c9cc92-2f67-4ed0-8d52-8ba93137d275	2026-02-25 09:48:10.187011+00	2e1b56fc-f0c7-44ba-9f10-a398c4dbde04	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a85f4653-6aaa-4c57-9325-bc92919610ad	2026-02-25 09:48:10.187011+00	2e1b56fc-f0c7-44ba-9f10-a398c4dbde04	ce4184ad-5144-4b9b-8276-0111197e0885	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e7853c71-6c2f-4988-b303-7cfa56a0d596	2026-02-25 09:48:11.636775+00	138d43d0-1c89-46cc-aaa7-43ef52418145	8b6e4db3-9332-457c-8e1a-ad88af0c40be	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5c542263-c6b6-45a3-99bc-cf41f3254eb3	2026-03-31 13:05:38.160725+00	e08f664a-a285-449e-ad59-9d5346b59d38	8dab5312-dbee-4f86-83dd-0874ffc99c46	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
e27f29e0-f6f1-4657-8986-2974e586f645	2026-03-27 16:21:57.810721+00	55037829-053a-4c3e-abeb-942745cebae0	3cbd32b1-84a7-4596-92d0-903d6ea1f631	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
ad836f00-2781-4b20-807c-d02d9abe8177	2026-02-25 09:48:12.500027+00	ce6506b4-3400-4b57-b684-5ebd3add6900	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
abc638c5-a5f0-49bb-8520-39261f2668ba	2026-02-25 09:48:12.500027+00	ce6506b4-3400-4b57-b684-5ebd3add6900	ce4184ad-5144-4b9b-8276-0111197e0885	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0b9097df-31a1-4442-9815-2418e2192f0d	2026-02-26 08:27:27.973186+00	6dc1e3dd-4f11-4f87-a2c0-f4c86a79a454	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7b8b88dd-d9ef-4e53-8b4c-76c8f4c20f52	2026-02-26 08:27:27.973186+00	6dc1e3dd-4f11-4f87-a2c0-f4c86a79a454	97a3f8b8-caff-4988-b24a-2b7e54d155ee	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5ded0661-f6cc-4a1a-a9f9-979e0bcce61b	2026-02-26 08:27:27.973186+00	6dc1e3dd-4f11-4f87-a2c0-f4c86a79a454	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	\N	t	\N	f	2026-01-03	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6f94a760-15da-4965-8d6a-87836dfa611f	2026-02-26 08:27:27.973186+00	6dc1e3dd-4f11-4f87-a2c0-f4c86a79a454	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
54d10a76-e211-45f0-a744-267de3558f36	2026-02-26 08:27:27.973186+00	6dc1e3dd-4f11-4f87-a2c0-f4c86a79a454	13e202ee-272d-415f-8d66-f7669b85afb8	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f6084095-1232-449a-9722-7aa94635e04e	2026-02-26 08:27:27.973186+00	6dc1e3dd-4f11-4f87-a2c0-f4c86a79a454	6c379005-03bc-478f-aabd-ad3f75f6477a	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ff1f3df4-ca43-473b-ad30-ccd3884e20be	2026-02-26 08:27:27.973186+00	6dc1e3dd-4f11-4f87-a2c0-f4c86a79a454	2d98b2aa-9762-4798-8e28-fcb15c380bf5	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e35888a6-1cc2-481e-95d4-e70a7426e44b	2026-02-26 08:48:34.218229+00	a716377a-2088-458f-aa9b-30d8095e77f0	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ce003267-a3d8-49a0-a21e-a1a472056e26	2026-02-26 08:47:36.602985+00	336510ae-27fd-4bc5-82f5-011ced18ff09	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
288bd352-5310-4326-a3f2-8542cc15f008	2026-02-26 08:47:36.602985+00	336510ae-27fd-4bc5-82f5-011ced18ff09	97a3f8b8-caff-4988-b24a-2b7e54d155ee	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
70cbd89f-38e9-4130-8f5d-290dcaa442c9	2026-02-26 08:47:36.602985+00	336510ae-27fd-4bc5-82f5-011ced18ff09	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	\N	t	ANR	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
762dad38-9dda-47da-abc4-0c3708bfafa7	2026-02-26 08:47:36.602985+00	336510ae-27fd-4bc5-82f5-011ced18ff09	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5655d4d1-22f3-42ed-a3b4-dd7adda9f666	2026-02-26 08:47:36.602985+00	336510ae-27fd-4bc5-82f5-011ced18ff09	13e202ee-272d-415f-8d66-f7669b85afb8	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
60e68f4e-8508-42e8-9685-56a0902811c3	2026-02-26 08:47:36.602985+00	336510ae-27fd-4bc5-82f5-011ced18ff09	6c379005-03bc-478f-aabd-ad3f75f6477a	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ece0fe15-daee-4aaf-9f61-91dc4ab5207b	2026-02-26 08:47:36.602985+00	336510ae-27fd-4bc5-82f5-011ced18ff09	2d98b2aa-9762-4798-8e28-fcb15c380bf5	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0c632979-5678-45c5-bb50-acc9d7394094	2026-02-25 09:48:11.636775+00	138d43d0-1c89-46cc-aaa7-43ef52418145	ddbca8c2-9bfd-4ab2-90d1-8c8127be9331	\N	t	1s/2. S.P.	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
96ea102d-7520-4643-9938-476d2d1694f3	2026-02-26 09:08:20.539272+00	0ad8eb46-6bb4-4808-a050-5b90fef3b9fd	9c87739b-74ad-47b9-a70f-6efc26c93f00	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9080f462-aa65-448d-aad4-c08a39e476a4	2026-03-31 13:46:29.36111+00	09e83f94-7344-42a1-a8c4-893bae272b51	\N	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Kubra DEMIR	\N	f	\N	\N	\N	f
9b5b90e6-37d2-41d8-8a57-58f8776a64d2	2026-02-26 09:08:20.539272+00	0ad8eb46-6bb4-4808-a050-5b90fef3b9fd	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	\N	t	ANR	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a6e5fdf6-123d-4415-9c4a-198512a7cfc8	2026-02-26 09:08:20.539272+00	0ad8eb46-6bb4-4808-a050-5b90fef3b9fd	ce4184ad-5144-4b9b-8276-0111197e0885	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4a260849-c8e5-4eba-ab6a-31227c42dfe5	2026-02-26 09:08:21.4947+00	736eced2-c4c1-4312-a240-34c716fdd731	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6f0618fe-8485-480d-8d9d-5cc7603c6cd9	2026-02-26 09:08:21.4947+00	736eced2-c4c1-4312-a240-34c716fdd731	97a3f8b8-caff-4988-b24a-2b7e54d155ee	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9e761e78-064d-464a-b843-de9b04220d27	2026-02-26 09:08:21.4947+00	736eced2-c4c1-4312-a240-34c716fdd731	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
58a796d6-502d-4147-8d71-22b2efefecd1	2026-02-26 09:08:21.4947+00	736eced2-c4c1-4312-a240-34c716fdd731	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e899cb83-6f64-4e7e-9733-5b05c729d6b8	2026-02-26 09:08:21.4947+00	736eced2-c4c1-4312-a240-34c716fdd731	13e202ee-272d-415f-8d66-f7669b85afb8	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0a6e9ad3-4fa8-4c11-b04a-6a0af488427d	2026-02-26 09:08:21.4947+00	736eced2-c4c1-4312-a240-34c716fdd731	6c379005-03bc-478f-aabd-ad3f75f6477a	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
29f59ac2-7a3b-4e8b-98c4-03e83ae24828	2026-02-26 09:08:21.4947+00	736eced2-c4c1-4312-a240-34c716fdd731	2d98b2aa-9762-4798-8e28-fcb15c380bf5	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9b6cd7d8-2085-47bd-9ef9-dfd27fd648ef	2026-02-26 09:08:22.515337+00	de9f9356-1fd2-4d2a-aea9-584ad5b0f1ad	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
604e6d03-5d13-437d-a742-b70018fc9474	2026-02-26 09:08:22.515337+00	de9f9356-1fd2-4d2a-aea9-584ad5b0f1ad	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c80b0af8-e720-4b91-b203-4e6c9289eccb	2026-02-26 09:19:08.958489+00	355c7448-e956-498c-a1cc-df3a7dca7790	9c87739b-74ad-47b9-a70f-6efc26c93f00	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
3b3d24a8-1615-46fc-adeb-8d116e284eb0	2026-02-26 09:19:08.958489+00	355c7448-e956-498c-a1cc-df3a7dca7790	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f5aa523c-77d8-48a6-b88a-55c2952ce424	2026-02-26 09:19:08.958489+00	355c7448-e956-498c-a1cc-df3a7dca7790	ce4184ad-5144-4b9b-8276-0111197e0885	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6e45b38c-fb14-45b0-a979-262e314b9eac	2026-02-26 09:19:09.902874+00	a672c76d-049d-409d-bdbc-e9e01c165b5a	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
41cf42dd-2802-4fb2-834e-8eb15768edcf	2026-02-26 09:19:09.902874+00	a672c76d-049d-409d-bdbc-e9e01c165b5a	97a3f8b8-caff-4988-b24a-2b7e54d155ee	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f54b943b-6d7e-47fe-b625-4cd2e7c70c5a	2026-02-26 09:19:09.902874+00	a672c76d-049d-409d-bdbc-e9e01c165b5a	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8c3715be-b123-45cd-b5c8-e8fb839cf222	2026-02-26 09:19:09.902874+00	a672c76d-049d-409d-bdbc-e9e01c165b5a	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6f484f85-e77f-4426-b667-907dbdab4d27	2026-02-26 09:19:09.902874+00	a672c76d-049d-409d-bdbc-e9e01c165b5a	13e202ee-272d-415f-8d66-f7669b85afb8	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
3d4254e4-909b-4c35-8542-ef5f93e31964	2026-02-26 09:19:09.902874+00	a672c76d-049d-409d-bdbc-e9e01c165b5a	6c379005-03bc-478f-aabd-ad3f75f6477a	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
284cad4c-2a47-4867-97b8-9c6e9107d60c	2026-02-26 09:19:09.902874+00	a672c76d-049d-409d-bdbc-e9e01c165b5a	2d98b2aa-9762-4798-8e28-fcb15c380bf5	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
02fbaed8-f15f-4afd-b92d-9e919c88e92e	2026-02-26 09:19:10.842711+00	fd63b4dd-4165-4092-8cdf-2f1d33994c71	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
3fb462b4-8cf3-4c57-aa75-dfac0f16e5b7	2026-02-26 09:19:10.842711+00	fd63b4dd-4165-4092-8cdf-2f1d33994c71	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1b6c95bf-f8ed-4fb3-aa30-61604b95bb8b	2026-02-26 09:19:10.842711+00	fd63b4dd-4165-4092-8cdf-2f1d33994c71	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0e42a299-ce5a-4de3-a785-890f083af9c7	2026-02-26 09:29:32.875004+00	3447bd6b-755e-48df-be3e-81551e4aff05	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-02-07	f
6481e56f-99af-4d69-bb84-9c12401b4504	2026-02-25 09:47:44.645874+00	913d6fe9-f265-4282-a42f-799317153e00	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8c4dc18a-0d7f-46f4-902d-735871a8d7e8	2026-02-25 09:53:26.588791+00	913d6fe9-f265-4282-a42f-799317153e00	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0b89d1de-6c6c-419f-bcec-af5e565ae30d	2026-02-25 09:47:45.154978+00	d7f30622-ad01-4a54-975e-1102decb39de	8b6e4db3-9332-457c-8e1a-ad88af0c40be	c48c89f9-082b-4835-9a9f-e3ee05ed3476	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0fab4102-4ae5-439f-b4f7-104d74a3385e	2026-02-25 09:47:45.653654+00	ed090252-a1a7-4d94-88b2-1960f956f38e	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c79f1ff9-5ae4-4d53-a4fb-eb23c15234a3	2026-02-25 09:47:56.240192+00	19471820-fbbf-43d1-ab22-635c5a352858	a41687b8-6f23-46d2-abbb-285d71a1331c	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
3c55c453-a472-4baf-9d76-129aaf2c2036	2026-02-25 10:00:59.222353+00	19471820-fbbf-43d1-ab22-635c5a352858	a3f3ccb1-7c00-4b52-9837-dc69331b521c	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f49535e4-4d3d-4a59-a8f2-1d652afaa164	2026-02-25 09:48:13.962676+00	76b18aaf-0eb0-492e-a1f6-29016d34e4d5	8b6e4db3-9332-457c-8e1a-ad88af0c40be	\N	t	1s/2. S.I.	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e2bdf9a0-4294-4bac-8b38-9f80620ed15f	2026-02-25 09:48:10.193295+00	ef3928d4-6ae1-4f40-a022-a2fa805b4d04	ddbca8c2-9bfd-4ab2-90d1-8c8127be9331	\N	t	BOUD'ZAN	f	2025-12-06	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
aec25af6-8f5b-468a-8c20-d1ca856d5916	2026-02-25 09:48:05.629161+00	0ce7ec21-608e-46b1-b81f-6c26e2bc4f76	7851fd12-1e6f-4a02-b957-c2120bc0ac83	\N	t	TYPE TOP	f	2026-01-17	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
2cff3c8e-e644-49f3-b815-c21d3372a89e	2026-02-25 09:48:10.193295+00	ef3928d4-6ae1-4f40-a022-a2fa805b4d04	7e7447f5-56a1-4513-9606-978058d389d5	\N	t	PETITON'R	f	2026-01-10	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
ebc0eae9-2993-4eae-9cf6-761323f96b05	2026-02-25 09:48:10.193295+00	ef3928d4-6ae1-4f40-a022-a2fa805b4d04	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	\N	t	PETITON'R	f	2026-01-14	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
5209375b-4019-4d5e-b304-c53b2fc7d637	2026-02-25 09:47:56.937515+00	8630ca85-a482-4220-b9ce-ad9c53e3641e	9430b606-42b0-45c9-aca3-c56c6d23d11b	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f8c65079-220d-4431-a053-c97f8852c220	2026-02-25 09:47:57.449235+00	4b9050ae-9cb6-47ff-8aaa-d4a50da170eb	7c879cb9-b214-4851-9fb7-cd84b0698bb7	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c469ee2d-0c34-40b2-8b6b-ede740674b23	2026-02-25 09:47:58.644282+00	bcd47ff5-5a64-4898-aa4f-d4c4b64d95ef	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2b96fe34-b667-43b9-bb2f-1d28195b1d28	2026-02-25 10:27:50.486139+00	03d86523-24e9-49e6-b1db-63425d157c49	13e202ee-272d-415f-8d66-f7669b85afb8	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
31340871-339b-4afb-a53e-f22ba4985c9c	2026-02-25 10:27:59.409074+00	03d86523-24e9-49e6-b1db-63425d157c49	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
41647087-5fa3-4551-bbed-492562c23bf1	2026-02-25 09:48:10.193295+00	ef3928d4-6ae1-4f40-a022-a2fa805b4d04	8b6e4db3-9332-457c-8e1a-ad88af0c40be	\N	t	1s/2. S.I.	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7ac0e4a8-ae5f-4605-866f-620676aca8d2	2026-02-25 09:48:11.146497+00	426ba16b-4754-4009-8fbb-4c60751166b8	13e202ee-272d-415f-8d66-f7669b85afb8	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
33e1020f-af01-40f3-9b1a-a1a278657e91	2026-02-25 10:30:22.5373+00	426ba16b-4754-4009-8fbb-4c60751166b8	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1e1a7b27-1401-47cb-a94d-655add2e29ff	2026-02-26 08:27:26.95992+00	b1b53a5f-50e8-4416-a05a-dad1c3395ea2	9c87739b-74ad-47b9-a70f-6efc26c93f00	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
120d2e12-04ea-4ed6-a14c-0e402c578875	2026-02-25 09:48:04.597417+00	b794c2ea-fab2-43ab-a5a1-2b9f463d5166	86c197e6-24db-4d82-8572-d86b5ca15b2f	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
372daf30-367d-4e07-bdbb-ba2458366df8	2026-02-25 09:48:06.155993+00	361a8041-3e45-44bd-8efb-7e4ae1d445f6	7374ef8e-c3b3-40aa-b6b4-7ae7159a7ce6	\N	t	ANR	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
15e978db-1f15-404b-a50c-1ac5ddce1149	2026-02-25 17:00:37.727141+00	ce6506b4-3400-4b57-b684-5ebd3add6900	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4c9d6af8-3b69-491c-ba7b-bbb9634d5cf1	2026-02-25 17:00:47.846311+00	ce6506b4-3400-4b57-b684-5ebd3add6900	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
17abcff5-aafc-4678-8935-5b97ad75c2f7	2026-02-25 17:00:57.665764+00	ce6506b4-3400-4b57-b684-5ebd3add6900	9aa72019-ede1-4b37-a63b-400a20a683a7	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1cf1b124-c4e5-462b-b711-5bf3c45e6421	2026-03-31 13:05:38.702859+00	e08f664a-a285-449e-ad59-9d5346b59d38	8a158331-8983-4d93-8d27-616394540f3d	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
6e8f1e15-0c2e-42d7-88e4-a90d2a5004ec	2026-02-25 09:48:13.962676+00	76b18aaf-0eb0-492e-a1f6-29016d34e4d5	ddbca8c2-9bfd-4ab2-90d1-8c8127be9331	c48c89f9-082b-4835-9a9f-e3ee05ed3476	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7c412ff7-7476-4095-8513-7e70dd37f872	2026-02-25 09:48:13.962676+00	76b18aaf-0eb0-492e-a1f6-29016d34e4d5	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	\N	t	ANR	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0bd95a4d-1594-424e-89a7-942809a0c236	2026-02-25 09:48:13.962676+00	76b18aaf-0eb0-492e-a1f6-29016d34e4d5	7e7447f5-56a1-4513-9606-978058d389d5	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
460a1c9d-86e4-42a9-9801-d1b558d9c3db	2026-02-25 09:48:13.962676+00	76b18aaf-0eb0-492e-a1f6-29016d34e4d5	ceb5bad4-3051-4086-ac9c-a67e6c124aee	b6d87440-e59a-402a-81f1-4d996a9a9300	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
3d1ae72f-19cb-453b-88b5-eb5d3d58003d	2026-03-31 14:44:12.197967+00	4def5e4c-53fb-4af7-81ed-aab2b7f3132e	aaedc900-37ff-4b01-88cb-82c36deffca8	c6bc37d8-7c43-4ae3-9c95-4f6488a42f09	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
9c2df569-8487-4dac-904b-7d5b78320786	2026-03-31 17:13:47.507695+00	0163f795-7b5b-40b2-b8de-6853ebec9bb7	080111ef-d8d7-4662-ba20-cd5ff1bfa389	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
14211d99-910c-4f1d-b64b-710d454d6917	2026-02-26 09:08:21.008008+00	85967229-e0e1-4902-9062-86c70e0fc505	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
33241cfe-b567-488c-b19c-833c1c7439a2	2026-02-26 08:08:14.252988+00	b9e1d6e9-7032-4f64-b9a8-36a0c14a5d5b	9430b606-42b0-45c9-aca3-c56c6d23d11b	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1377f936-ed7c-41b8-9c93-00d17e9e75cb	2026-02-26 08:08:14.252988+00	b9e1d6e9-7032-4f64-b9a8-36a0c14a5d5b	86c197e6-24db-4d82-8572-d86b5ca15b2f	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f98e13eb-21a0-4654-8944-033c09227b5b	2026-02-26 08:08:14.252988+00	b9e1d6e9-7032-4f64-b9a8-36a0c14a5d5b	00ef1cb1-a558-407b-8798-c0db3f382cb8	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
fe4e5f66-9383-45de-b863-21de7e9db7cc	2026-02-26 08:08:14.252988+00	b9e1d6e9-7032-4f64-b9a8-36a0c14a5d5b	a3f3ccb1-7c00-4b52-9837-dc69331b521c	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9f30601f-d6a6-4cc7-a28d-118d16ad3baa	2026-02-26 08:48:21.946346+00	a716377a-2088-458f-aa9b-30d8095e77f0	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1625b5e3-a25a-4868-b698-0db5fe33667b	2026-02-26 08:48:51.26661+00	a716377a-2088-458f-aa9b-30d8095e77f0	9aa72019-ede1-4b37-a63b-400a20a683a7	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
16bf531b-33ce-49be-b4c0-9cd19c109dc4	2026-04-01 18:35:32.529717+00	e544070e-62af-4da4-983a-e3e4f4c8e44a	322417b3-f05a-488c-b3b6-8956e7e4413a	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
775a34c6-f17d-4163-9c7b-286773bbc592	2026-02-25 09:47:56.74836+00	beb9ca03-4d63-4f32-a4d0-deb4e597e044	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	\N	t	EXKY	f	2026-01-10	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
39efca3c-b24b-415d-b731-a4f241300a42	2026-02-26 09:08:21.008008+00	85967229-e0e1-4902-9062-86c70e0fc505	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
255a15f2-b48a-48e6-bf17-a46ad9cdf3d6	2026-02-26 09:08:21.008008+00	85967229-e0e1-4902-9062-86c70e0fc505	1c9e7097-df1c-4540-b79b-35055f8f080f	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
d484aa9a-da31-4ca7-bb88-432040880567	2026-03-16 11:33:31.654038+00	1de1c71c-97a6-4a19-9b53-8e5c15114e5f	7c879cb9-b214-4851-9fb7-cd84b0698bb7	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
2155f86c-646f-4805-9d49-dd18f4c6fe72	2026-02-26 09:08:21.008008+00	85967229-e0e1-4902-9062-86c70e0fc505	7dd68452-30ed-4829-857d-bebc61aff9c1	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c1c5a31b-51f1-4543-9d2e-773a45ad9dd2	2026-02-26 09:08:21.995857+00	287cb5c5-9f6f-418b-9d73-7a4c8137126b	8b6e4db3-9332-457c-8e1a-ad88af0c40be	c48c89f9-082b-4835-9a9f-e3ee05ed3476	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
44a27ec6-ab63-4ecc-bead-f836719e82f3	2026-02-26 09:08:21.995857+00	287cb5c5-9f6f-418b-9d73-7a4c8137126b	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
56601a7c-a547-453f-8119-e067a6ad24e9	2026-02-26 09:08:21.995857+00	287cb5c5-9f6f-418b-9d73-7a4c8137126b	7e7447f5-56a1-4513-9606-978058d389d5	d532c50a-26f4-4491-bcb3-e8fe9bb5105d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2bb5f14d-fa97-4316-95f3-4481647036f9	2026-02-25 09:48:09.549819+00	f0860785-fe45-4b7d-90d3-ecf45fcf770f	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	\N	t	EM'N'EMS	f	2025-11-22	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
958afa33-25c4-4e1b-8477-2dd6b0b71ac4	2026-02-25 14:58:49.901841+00	ef6ab570-95dd-43ce-9ddf-c74b11bc1c38	ceb5bad4-3051-4086-ac9c-a67e6c124aee	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2025-11-15	f
38bdb195-e4af-40b3-901f-3344b651ff51	2026-02-25 09:48:10.193295+00	ef3928d4-6ae1-4f40-a022-a2fa805b4d04	ceb5bad4-3051-4086-ac9c-a67e6c124aee	\N	t	PETITON'R	f	2025-11-26	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
38b72b39-ab55-4a45-b42d-990c69fd5ccd	2026-02-25 10:21:11.894003+00	444a7e78-34b0-4d7e-b1f9-f6c063f21b0b	a3f3ccb1-7c00-4b52-9837-dc69331b521c	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2025-09-10	f
b928320a-6798-4c64-8266-5fe9f741b341	2026-02-25 09:57:50.407996+00	9a07f6b9-15bf-47b5-a175-d6e80d60b1e5	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2025-11-15	f
328c2a61-5f1f-4431-a37a-7be9ee368e61	2026-04-01 18:35:33.065746+00	e544070e-62af-4da4-983a-e3e4f4c8e44a	8a158331-8983-4d93-8d27-616394540f3d	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
25b60426-9d97-4951-940f-2f071a36993f	2026-02-25 10:28:31.2205+00	03d86523-24e9-49e6-b1db-63425d157c49	97a3f8b8-caff-4988-b24a-2b7e54d155ee	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2025-11-15	f
7e19b3d7-ad54-4b9a-8aff-ee41de2c68ec	2026-02-25 10:27:14.739537+00	03d86523-24e9-49e6-b1db-63425d157c49	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2025-11-08	f
01348c44-087a-4567-8864-75bf931ac995	2026-02-26 08:08:14.784966+00	175c558b-0573-4bb5-9521-f8f766a5c69e	f6b2c3bc-2197-44c1-a848-d18a66e3fdf5	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f012dd21-aad6-45ea-82d5-7560ad5f5e5e	2026-02-26 08:08:14.784966+00	175c558b-0573-4bb5-9521-f8f766a5c69e	b0054d27-f377-41ad-a026-a2893c27692a	\N	t	AND	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5f7e1154-7fbe-4501-9abb-27194c219e09	2026-02-26 08:08:14.784966+00	175c558b-0573-4bb5-9521-f8f766a5c69e	1d2c9275-719e-452b-9298-ec476ac53155	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
eb5ee1a9-40bd-4d6e-ad20-81d21a86e7a9	2026-02-26 08:08:14.784966+00	175c558b-0573-4bb5-9521-f8f766a5c69e	7c879cb9-b214-4851-9fb7-cd84b0698bb7	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d49c6787-d8be-4921-9ab1-4b710600c6c4	2026-02-26 08:28:26.36728+00	b1b53a5f-50e8-4416-a05a-dad1c3395ea2	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5b54724e-816a-4ed2-b532-9e0b699ea35a	2026-02-26 09:09:08.347689+00	0ad8eb46-6bb4-4808-a050-5b90fef3b9fd	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2025-12-03	f
cf64390a-0795-44a9-9263-be9940c0f908	2026-02-26 09:08:21.995857+00	287cb5c5-9f6f-418b-9d73-7a4c8137126b	ceb5bad4-3051-4086-ac9c-a67e6c124aee	b6d87440-e59a-402a-81f1-4d996a9a9300	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b9d5d20d-17ae-44ff-b6c3-6a9c6d493a7d	2026-02-26 09:19:09.424361+00	d2ccada8-904b-4149-828d-79adbd475c54	9aa72019-ede1-4b37-a63b-400a20a683a7	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9c5f61e8-6198-4aba-bb03-a286399e7a05	2026-02-26 09:19:09.424361+00	d2ccada8-904b-4149-828d-79adbd475c54	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f7df6305-2c24-4dc9-b771-5d1153c5ae46	2026-02-26 09:19:09.424361+00	d2ccada8-904b-4149-828d-79adbd475c54	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	\N	t	\N	f	2026-01-31	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
176bd355-92e4-4420-aa93-f89e6bc89591	2026-02-26 09:19:09.424361+00	d2ccada8-904b-4149-828d-79adbd475c54	1c9e7097-df1c-4540-b79b-35055f8f080f	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1718d8e0-d7fd-4d33-bc43-7db11831fdf4	2026-02-26 09:19:09.424361+00	d2ccada8-904b-4149-828d-79adbd475c54	7dd68452-30ed-4829-857d-bebc61aff9c1	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
703e7adb-27e5-491f-b79c-26e937746811	2026-03-31 13:05:39.270348+00	e08f664a-a285-449e-ad59-9d5346b59d38	f056b2e2-8510-45d1-b81a-a1d06ab18dd1	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
eda9f8e4-76e3-4150-a76d-9d25fca311b8	2026-02-26 09:19:10.372883+00	4cc0a4a1-eec2-41a3-92bd-1deae5ea7a25	ddbca8c2-9bfd-4ab2-90d1-8c8127be9331	c48c89f9-082b-4835-9a9f-e3ee05ed3476	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2513c4c6-5123-40c6-88fd-a30301ac85ae	2026-02-26 09:19:10.372883+00	4cc0a4a1-eec2-41a3-92bd-1deae5ea7a25	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
56baac86-f0d6-4c8e-8369-fe6c3b55a35e	2026-02-26 09:19:10.372883+00	4cc0a4a1-eec2-41a3-92bd-1deae5ea7a25	7e7447f5-56a1-4513-9606-978058d389d5	d532c50a-26f4-4491-bcb3-e8fe9bb5105d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2aa52ad4-f6d9-42b5-a01f-ad4d4be6fcb3	2026-02-26 09:19:10.372883+00	4cc0a4a1-eec2-41a3-92bd-1deae5ea7a25	ceb5bad4-3051-4086-ac9c-a67e6c124aee	\N	t	\N	f	2026-03-25	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
460e1877-fedf-44b6-962d-ba803bc1b8c5	2026-02-26 09:36:20.209206+00	163bae16-36c5-4bbd-aabd-ebb45f89d1f5	7c879cb9-b214-4851-9fb7-cd84b0698bb7	\N	t	ANR	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d7c8bda6-8e73-4fac-b366-c544e6361820	2026-02-26 09:39:50.801942+00	b1caa34e-dffe-4deb-90f5-516d18244bc6	9c87739b-74ad-47b9-a70f-6efc26c93f00	\N	t	RATTRAPAGE	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5d6af56f-9a08-41b3-81a5-2cccd1bf6c55	2026-03-04 14:09:11.952258+00	d37660c4-9ae7-42ac-8c7d-97bf2619e70f	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	\N	t	8:30	f	2026-03-07	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
ba41da14-8a1d-44e3-942a-44dbb2586c92	2026-02-26 09:39:50.801942+00	b1caa34e-dffe-4deb-90f5-516d18244bc6	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
83e884f0-bbf0-479e-a2f4-0abc026ff45a	2026-02-26 09:39:50.801942+00	b1caa34e-dffe-4deb-90f5-516d18244bc6	ce4184ad-5144-4b9b-8276-0111197e0885	\N	t	RATTRAPAGE	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1cec49ea-a54a-4984-8b53-5fbf0cf71a20	2026-02-26 09:39:51.74802+00	c3bed883-05dd-49c8-9225-106ce39b50db	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8b80ccac-c6ad-4773-a802-486e323660f5	2026-02-26 09:39:51.74802+00	c3bed883-05dd-49c8-9225-106ce39b50db	97a3f8b8-caff-4988-b24a-2b7e54d155ee	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7339a550-4cf5-4b4e-a7ac-6e139314dc4d	2026-02-26 09:39:51.74802+00	c3bed883-05dd-49c8-9225-106ce39b50db	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	\N	t	ANR	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2b1de37d-4cc0-4df0-a05d-613c90488ce8	2026-02-26 09:39:51.74802+00	c3bed883-05dd-49c8-9225-106ce39b50db	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
cf86acdf-5541-4c93-8935-ceb80d648056	2026-02-26 09:39:51.74802+00	c3bed883-05dd-49c8-9225-106ce39b50db	13e202ee-272d-415f-8d66-f7669b85afb8	\N	t	EM'N'EMS	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7dff4f12-fedd-4747-951d-5b1f7d5a21e0	2026-02-26 09:39:51.74802+00	c3bed883-05dd-49c8-9225-106ce39b50db	6c379005-03bc-478f-aabd-ad3f75f6477a	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a803adaf-e0e2-4d86-a7d6-8d355cf74f59	2026-02-26 09:39:51.74802+00	c3bed883-05dd-49c8-9225-106ce39b50db	2d98b2aa-9762-4798-8e28-fcb15c380bf5	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c55022b7-798d-4203-88b4-b7b00b90a67c	2026-02-26 09:39:52.707908+00	5fb2327b-7286-48aa-8827-1e2cab55fff1	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	\N	t	\N	f	2026-02-04	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
c403dc91-3c31-4257-bba7-d0af83651a02	2026-02-26 09:31:38.899408+00	79bfb15d-03f1-4264-8f14-67ea3bf69834	6c379005-03bc-478f-aabd-ad3f75f6477a	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2025-11-15	f
7f810f6e-43fc-4cfc-a78a-885fbccdf0f5	2026-02-23 15:12:54.105163+00	f43a68a1-59b5-4e19-bbb9-5ca90c669e27	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	\N	t	ORIANTE	f	2025-09-27	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
43fb3b27-5c95-46a1-bc40-0f66c1a3ba4b	2026-03-06 08:56:14.01443+00	dcd11b42-5a1f-4213-b441-afafd4b16f06	f6b2c3bc-2197-44c1-a848-d18a66e3fdf5	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6687da08-860d-4aef-b051-ee4a796ef8cc	2026-03-04 14:09:10.221996+00	805ea7df-f291-4405-8c62-8d357660fb00	1c9e7097-df1c-4540-b79b-35055f8f080f	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f645cab4-6d46-4361-977b-00fc3e6bd860	2026-03-04 14:09:10.221996+00	805ea7df-f291-4405-8c62-8d357660fb00	9aa72019-ede1-4b37-a63b-400a20a683a7	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
fc3e75d3-49f0-4dd9-b0bd-362503c9b4f0	2026-02-26 09:19:10.372883+00	4cc0a4a1-eec2-41a3-92bd-1deae5ea7a25	8b6e4db3-9332-457c-8e1a-ad88af0c40be	b6d87440-e59a-402a-81f1-4d996a9a9300	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
cc429139-119d-4260-a943-42d323ff2418	2026-03-04 14:09:10.221996+00	805ea7df-f291-4405-8c62-8d357660fb00	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0a18d0c4-3d4f-4bbd-9f0a-f32127151487	2026-03-06 08:56:14.01443+00	dcd11b42-5a1f-4213-b441-afafd4b16f06	b0054d27-f377-41ad-a026-a2893c27692a	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
bb3dc5e1-a6e2-43a4-ac25-e52b0b8df9e0	2026-03-04 14:09:10.221996+00	805ea7df-f291-4405-8c62-8d357660fb00	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4fb6c39b-dfd8-413b-815a-0d357d5ba4c4	2026-02-26 08:27:26.95992+00	b1b53a5f-50e8-4416-a05a-dad1c3395ea2	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4443a65b-7e7d-4eba-9fb6-0bc7f88e88ed	2026-02-26 09:39:50.801942+00	b1caa34e-dffe-4deb-90f5-516d18244bc6	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d63a0fcc-aeb3-487f-8fae-07ff92071290	2026-03-10 09:19:30.721195+00	e6990c20-c4c3-40a8-88d5-16516c13629f	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-03-07	f
cde6d0bd-a820-4a49-9747-4a9d7eedde42	2026-03-04 14:09:11.952258+00	d37660c4-9ae7-42ac-8c7d-97bf2619e70f	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	\N	t	8:30	f	2026-03-07	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
6d4c23da-9962-4ca1-a0d0-83bd4dbd8b31	2026-02-26 08:49:08.758663+00	a716377a-2088-458f-aa9b-30d8095e77f0	\N	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Nathan	\N	t	Offert	\N	\N	f
46bbcafc-3052-4277-9b5a-5d8c21e23458	2026-03-31 14:44:12.931396+00	4def5e4c-53fb-4af7-81ed-aab2b7f3132e	7fb3adc8-4473-43a4-84a8-c76a60e2665f	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
4e0e36ff-40e9-4d1c-8f0b-40243c707325	2026-03-06 08:56:14.01443+00	dcd11b42-5a1f-4213-b441-afafd4b16f06	7c879cb9-b214-4851-9fb7-cd84b0698bb7	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7ed10024-67b0-4c5a-bba1-918c342f85f4	2026-03-06 08:56:14.01443+00	dcd11b42-5a1f-4213-b441-afafd4b16f06	1d2c9275-719e-452b-9298-ec476ac53155	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a86a0948-1e91-4434-82a7-887271a9b806	2026-03-31 17:18:26.367448+00	b176fc38-62f1-4551-acad-1cac0d34fc6e	aaedc900-37ff-4b01-88cb-82c36deffca8	c6bc37d8-7c43-4ae3-9c95-4f6488a42f09	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
e6292ad3-2623-4555-a2ea-515aac5abbf7	2026-04-01 18:35:32.81633+00	e544070e-62af-4da4-983a-e3e4f4c8e44a	466a4031-fc42-48c9-88c5-1a1925e19912	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
63f65399-8778-41c2-b8a7-ddc4f3972dd5	2026-04-01 18:35:33.334796+00	e544070e-62af-4da4-983a-e3e4f4c8e44a	0328157c-5422-4fea-94a7-87f84d287645	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
9c9b3706-88d4-4172-8e2f-e2108b65eeaf	2026-03-04 14:09:10.221996+00	805ea7df-f291-4405-8c62-8d357660fb00	7dd68452-30ed-4829-857d-bebc61aff9c1	\N	t	\N	f	2026-05-02	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
621e9a71-3bd6-45ed-901c-2dccc2ca9d81	2026-03-04 14:09:11.952258+00	d37660c4-9ae7-42ac-8c7d-97bf2619e70f	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	\N	t	\N	f	2026-03-25	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
055538e8-3b77-43f8-8ad7-35fed1928cf8	2026-02-26 09:39:52.707908+00	5fb2327b-7286-48aa-8827-1e2cab55fff1	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	\N	t	09:30	f	2026-02-07	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
2de46ac0-8501-4cbc-bbc5-8cad51be56fb	2026-02-26 09:39:52.707908+00	5fb2327b-7286-48aa-8827-1e2cab55fff1	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	\N	t	09:30	f	2026-02-07	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
566e10af-60a8-479e-bbf3-08121e3b01da	2026-02-26 08:08:15.31524+00	9940ffc8-c4ee-4336-be1e-f0f872681115	70610b82-10ea-46b2-a99b-59c187db69da	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
bf2aea6e-62f2-453d-b710-eb199fa4fa57	2026-02-26 08:08:15.31524+00	9940ffc8-c4ee-4336-be1e-f0f872681115	7851fd12-1e6f-4a02-b957-c2120bc0ac83	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
74f7e979-9cf4-43ac-854c-b696b87857ad	2026-02-26 08:08:15.31524+00	9940ffc8-c4ee-4336-be1e-f0f872681115	a41687b8-6f23-46d2-abbb-285d71a1331c	\N	t	AND	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b6f8e124-5fc8-41ce-942c-0d354d1e5c6b	2026-02-26 08:08:15.31524+00	9940ffc8-c4ee-4336-be1e-f0f872681115	8b2745aa-d94a-48b9-be06-1aa87aac12d0	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
dd825b46-e70f-49f4-b788-515a8543d0a7	2026-02-26 08:08:15.31524+00	9940ffc8-c4ee-4336-be1e-f0f872681115	386cac04-cc49-4dd7-bb14-b17b9760795b	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6fd77d9d-1da8-4c92-b1bf-5bf8671cf139	2026-02-26 08:08:15.31524+00	9940ffc8-c4ee-4336-be1e-f0f872681115	ed3a44cb-388f-431a-bf56-2d35af78ea8a	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b6d6bf91-8c63-46ed-a878-79d885ada246	2026-03-27 17:07:39.079996+00	d2799fab-ea30-4eb6-97cd-3ccfa7c1b027	3cbd32b1-84a7-4596-92d0-903d6ea1f631	76876dd9-f4c0-455c-9b22-08799cc72af0	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
03211886-eeea-408d-80b6-5660497fbbc0	2026-03-31 13:26:25.602594+00	54888d72-6043-4268-99c5-a27194874ddf	aaedc900-37ff-4b01-88cb-82c36deffca8	c6bc37d8-7c43-4ae3-9c95-4f6488a42f09	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
378d2181-1e1b-4ac7-aad1-7c8823e723bd	2026-03-31 17:18:27.022673+00	b176fc38-62f1-4551-acad-1cac0d34fc6e	8a158331-8983-4d93-8d27-616394540f3d	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
29f52260-0eb8-4564-b701-145fc9e98ba4	2026-02-26 08:32:19.160806+00	1f71c89d-44eb-4e9e-9902-d41a6e77faf6	70610b82-10ea-46b2-a99b-59c187db69da	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4dcb01ac-43bb-4565-b147-4c6c49b674d9	2026-02-26 08:32:19.160806+00	1f71c89d-44eb-4e9e-9902-d41a6e77faf6	7851fd12-1e6f-4a02-b957-c2120bc0ac83	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a997ec4f-825e-4e00-a406-946781e09969	2026-02-26 08:32:19.160806+00	1f71c89d-44eb-4e9e-9902-d41a6e77faf6	a41687b8-6f23-46d2-abbb-285d71a1331c	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b2a04f99-b0a6-47f5-a68d-fa9376febe99	2026-02-26 08:32:19.160806+00	1f71c89d-44eb-4e9e-9902-d41a6e77faf6	8b2745aa-d94a-48b9-be06-1aa87aac12d0	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9e1051f9-b703-49ea-abf4-f3e1dc583588	2026-03-04 14:09:10.796241+00	5be512c2-b802-4db0-89b2-c62aea0ad82a	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	\N	t	RATTRAPAGE À PREVOIR	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
37d49191-3914-4ee8-851d-db6cffd33c41	2026-02-26 08:32:19.160806+00	1f71c89d-44eb-4e9e-9902-d41a6e77faf6	ed3a44cb-388f-431a-bf56-2d35af78ea8a	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5957de0d-4cdc-46b2-8724-d374b0f07793	2026-03-04 14:09:10.796241+00	5be512c2-b802-4db0-89b2-c62aea0ad82a	97a3f8b8-caff-4988-b24a-2b7e54d155ee	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
68133aa7-2767-41bd-b5cc-5cda86fd2d90	2026-02-26 08:35:20.011217+00	d6b999bc-6737-4453-aaf6-7a9d66f8c9dc	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
beac63b2-0142-4270-9ba7-5bada469bb9b	2026-02-26 08:35:20.011217+00	d6b999bc-6737-4453-aaf6-7a9d66f8c9dc	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
679e653c-0ed5-437c-9084-92155f32aab9	2026-02-26 08:35:20.011217+00	d6b999bc-6737-4453-aaf6-7a9d66f8c9dc	1c9e7097-df1c-4540-b79b-35055f8f080f	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
43a7510b-0896-4e9d-9ffe-2c72520bb083	2026-02-26 08:35:20.011217+00	d6b999bc-6737-4453-aaf6-7a9d66f8c9dc	7dd68452-30ed-4829-857d-bebc61aff9c1	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4ae208f2-c487-4579-a1bd-e66f56313e75	2026-03-04 14:09:10.796241+00	5be512c2-b802-4db0-89b2-c62aea0ad82a	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	\N	t	GENOU	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2c3eb8ac-ce3d-471c-b91a-cb613d12d412	2026-03-04 14:09:10.796241+00	5be512c2-b802-4db0-89b2-c62aea0ad82a	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7f6674e9-e785-4595-978b-785e7d9042c3	2026-02-26 08:35:21.678598+00	da0eeb8b-8c50-479f-811c-319febdc41c9	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	\N	t	EM'N'EMS	f	2025-12-20	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
86b5d69e-f1e4-4cfb-b7a0-043ab2d441bb	2026-02-26 08:52:48.805362+00	e25e7b46-4f82-4794-9be5-4bfecb733da4	7851fd12-1e6f-4a02-b957-c2120bc0ac83	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
41cbc0ba-dfc5-4754-94c9-4f4c8d01bb30	2026-02-26 08:53:13.545656+00	e25e7b46-4f82-4794-9be5-4bfecb733da4	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5cdc55dc-9bc2-41bb-ab87-9af0d5769914	2026-02-26 09:10:08.466225+00	85967229-e0e1-4902-9062-86c70e0fc505	7851fd12-1e6f-4a02-b957-c2120bc0ac83	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2025-11-26	f
3aadd790-8d5f-4c47-8273-f919cb2049a7	2026-02-26 09:12:42.781865+00	de9f9356-1fd2-4d2a-aea9-584ad5b0f1ad	7e7447f5-56a1-4513-9606-978058d389d5	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2025-12-06	f
003a6f39-34ee-4494-9bfb-369d05271578	2026-02-26 09:30:14.327279+00	3447bd6b-755e-48df-be3e-81551e4aff05	9aa72019-ede1-4b37-a63b-400a20a683a7	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-02-07	f
93f6daa6-e79e-4ddc-a7c3-5dbc84feebaa	2026-02-25 09:28:36.4793+00	1e2b6f64-09fc-4ab9-8967-bc0a47eafb44	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	\N	t	ALYSSON	f	2025-10-04	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
03205d22-72d4-48a0-b9b9-3baa51354219	2026-03-04 14:09:10.796241+00	5be512c2-b802-4db0-89b2-c62aea0ad82a	13e202ee-272d-415f-8d66-f7669b85afb8	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
57462e78-5d66-449b-b2dd-735f27911361	2026-02-26 08:35:21.678598+00	da0eeb8b-8c50-479f-811c-319febdc41c9	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	\N	t	API	f	2025-12-17	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
d501d520-b97f-4c2b-a7b8-ce26cb24494d	2026-02-26 08:35:20.011217+00	d6b999bc-6737-4453-aaf6-7a9d66f8c9dc	9aa72019-ede1-4b37-a63b-400a20a683a7	\N	t	JALOUSE	f	2026-01-10	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
5c70fb99-2a4a-4503-8d56-3a15b6badb30	2026-02-26 08:35:21.678598+00	da0eeb8b-8c50-479f-811c-319febdc41c9	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	\N	t	BE WIZE	f	2025-12-20	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
5faa9bd5-bbc9-497a-ac37-dd95323ecaff	2026-03-04 14:09:10.796241+00	5be512c2-b802-4db0-89b2-c62aea0ad82a	6c379005-03bc-478f-aabd-ad3f75f6477a	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
507be934-1865-47e8-a4e4-30e516f4e96f	2026-02-26 08:32:19.160806+00	1f71c89d-44eb-4e9e-9902-d41a6e77faf6	386cac04-cc49-4dd7-bb14-b17b9760795b	\N	t	CHARLY	f	2026-01-10	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
7d7c7ac8-9d3c-431f-a864-80bc739bae90	2026-03-04 14:09:10.796241+00	5be512c2-b802-4db0-89b2-c62aea0ad82a	2d98b2aa-9762-4798-8e28-fcb15c380bf5	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8c2b5622-91cf-41f8-967a-0b99ce15e696	2026-04-02 09:22:02.291064+00	305879cc-2e3f-4bef-9fae-ae3f4ba59939	893bb307-08a3-4af2-ba54-6c5da32206ad	835b104d-b18b-4876-ba72-ffea56c43563	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
7dae7fbf-6946-48cd-bdee-e9a65b60b0ea	2026-02-26 09:20:31.517474+00	355c7448-e956-498c-a1cc-df3a7dca7790	\N	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Nathan	\N	t	Offert	\N	\N	f
800cbfde-4d22-4ac6-b8d4-bded0e24f365	2026-02-26 09:09:18.180704+00	0ad8eb46-6bb4-4808-a050-5b90fef3b9fd	\N	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Nathan	\N	t	Offert	\N	\N	f
55e34904-7d51-464b-bc6b-bb0e195ffec7	2026-02-26 09:37:59.282022+00	163bae16-36c5-4bbd-aabd-ebb45f89d1f5	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-02-07	f
c292ac56-0beb-4737-8549-d06f0b53ea5a	2026-03-06 08:56:14.527598+00	bacdb2e9-0db8-4cca-8aad-3920c22e2cb5	ed3a44cb-388f-431a-bf56-2d35af78ea8a	\N	t	AD	f	2026-03-14	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
779fd084-ba9f-4ad9-823f-a91c592e12a8	2026-03-06 08:56:14.527598+00	bacdb2e9-0db8-4cca-8aad-3920c22e2cb5	386cac04-cc49-4dd7-bb14-b17b9760795b	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a00323a5-98af-4ee8-a43d-358c16e509c3	2026-02-25 09:48:10.678233+00	1b06f56d-05cc-4891-beca-e4babde61556	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
5a6c3414-9532-4bd2-8d4d-2921d61b527d	2026-04-03 17:55:40.880277+00	ef6ab570-95dd-43ce-9ddf-c74b11bc1c38	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2025-11-15	f
0fcb0935-c6a5-48ca-8516-88b70228a1e3	2026-02-25 09:39:28.082254+00	e736e97f-7c81-47ed-b7bf-c49714bc2a2f	1c9e7097-df1c-4540-b79b-35055f8f080f	\N	t	AND ⛔️	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
858bc9ca-609a-43ab-82c1-c3d813d3bdc2	2026-04-04 06:13:27.320821+00	604fb666-c6f4-4edc-94e5-9c5ff12b979d	1c9e7097-df1c-4540-b79b-35055f8f080f	5e250204-ceee-4813-b935-df2600156009	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-03-28	f
d17fa62a-5b32-4f77-9ce4-28fdcfebdcef	2026-04-04 06:14:20.607687+00	f1677714-9bee-4c08-b109-0a0dafee7603	70610b82-10ea-46b2-a99b-59c187db69da	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
fd343f69-0a88-4f60-b027-c9c949659110	2026-04-04 06:14:20.607687+00	f1677714-9bee-4c08-b109-0a0dafee7603	7851fd12-1e6f-4a02-b957-c2120bc0ac83	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2799a393-63c4-44e5-af18-c7428414308e	2026-04-04 06:14:20.607687+00	f1677714-9bee-4c08-b109-0a0dafee7603	a41687b8-6f23-46d2-abbb-285d71a1331c	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d59f851b-f9c7-4f25-a60b-ffd3a77356f6	2026-04-04 06:14:20.607687+00	f1677714-9bee-4c08-b109-0a0dafee7603	8b2745aa-d94a-48b9-be06-1aa87aac12d0	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
be6b732a-d83a-4732-ac33-841f5a21e50a	2026-04-04 06:14:20.607687+00	f1677714-9bee-4c08-b109-0a0dafee7603	386cac04-cc49-4dd7-bb14-b17b9760795b	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
300536ec-0c79-4779-becd-ec8ec3b35178	2026-03-27 10:06:10.807905+00	482be4a2-d367-4cac-9a56-91ee714fe333	7dd68452-30ed-4829-857d-bebc61aff9c1	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2025-12-06	f
58012475-95fd-4e79-be3b-7262d5a7628d	2026-04-04 06:14:20.607687+00	f1677714-9bee-4c08-b109-0a0dafee7603	ed3a44cb-388f-431a-bf56-2d35af78ea8a	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f23c907e-3aea-456d-bc83-82361b5fa2cf	2026-04-04 06:14:41.46913+00	f1677714-9bee-4c08-b109-0a0dafee7603	1c9e7097-df1c-4540-b79b-35055f8f080f	5e250204-ceee-4813-b935-df2600156009	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-05-16	f
48699523-0fc8-4d70-ad8c-2550ed13e777	2026-04-05 08:23:07.265667+00	ac9e2ac7-b88d-427f-b83b-2b20d22a219c	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-04-04	f
c8ae0479-ab52-42d4-85d0-ded2c8bad0c6	2026-03-25 10:19:44.790823+00	f48d3948-b170-45a9-9ccb-65a43c8a269c	9430b606-42b0-45c9-aca3-c56c6d23d11b	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a0779ac1-80b2-4968-9f04-562284e27f89	2026-03-24 17:28:39.763682+00	900f74cf-2f09-47c3-a9c8-4fe5d2dc4684	e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f12012c1-b17a-4c80-adb3-7f923cc19781	2026-02-26 08:10:07.177224+00	175c558b-0573-4bb5-9521-f8f766a5c69e	ceb5bad4-3051-4086-ac9c-a67e6c124aee	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1a34e9b0-17f1-4671-b5a8-f9902bfc7f0b	2026-02-26 08:08:15.86388+00	97f8edec-a6e7-46e8-97a3-86bc4a0070b7	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	\N	t	JALOUSE	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
3c1e80fa-55c0-4c57-806b-7940af636b25	2026-02-26 08:08:15.86388+00	97f8edec-a6e7-46e8-97a3-86bc4a0070b7	e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6e0d5c10-9d22-4688-9570-04dd13484f42	2026-02-26 08:08:15.86388+00	97f8edec-a6e7-46e8-97a3-86bc4a0070b7	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
cddccacc-559f-46b1-91f6-a018748c1cd7	2026-02-26 08:08:15.86388+00	97f8edec-a6e7-46e8-97a3-86bc4a0070b7	7374ef8e-c3b3-40aa-b6b4-7ae7159a7ce6	c6bc37d8-7c43-4ae3-9c95-4f6488a42f09	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a5e32f01-72a9-4c6a-a224-ae91bd1b043e	2026-02-26 08:08:15.86388+00	97f8edec-a6e7-46e8-97a3-86bc4a0070b7	d2566406-84dd-4204-a6c7-31a91107623a	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9ae93d94-eee2-4104-8b67-3df5a7f4f4c0	2026-02-26 08:15:09.917767+00	2cc7c0c8-d762-444c-b2e0-6d01264a89c0	9c87739b-74ad-47b9-a70f-6efc26c93f00	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b97147a9-7214-4885-8b53-2dcd6a69c0b1	2026-03-27 15:43:39.303777+00	8e2c3967-a1d6-439c-b9df-556c99a59740	3cbd32b1-84a7-4596-92d0-903d6ea1f631	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
74c69115-1c88-4acd-a167-94d36eddfb99	2026-02-26 08:15:09.917767+00	2cc7c0c8-d762-444c-b2e0-6d01264a89c0	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
27eceb29-0153-4bb8-af72-f8d5f5648fe7	2026-02-26 08:15:09.917767+00	2cc7c0c8-d762-444c-b2e0-6d01264a89c0	ce4184ad-5144-4b9b-8276-0111197e0885	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
56674a66-f642-4038-9e22-02b42f200a95	2026-02-26 08:16:01.682714+00	2cc7c0c8-d762-444c-b2e0-6d01264a89c0	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b77d8c44-2ed1-4afb-89d1-214e564b29fb	2026-02-26 08:16:11.674672+00	2cc7c0c8-d762-444c-b2e0-6d01264a89c0	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
20f7b010-3366-4797-8bc1-a785aad37881	2026-02-26 08:16:22.270804+00	2cc7c0c8-d762-444c-b2e0-6d01264a89c0	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
bd1599fb-67eb-48fa-bbc4-387cb1b75d2a	2026-02-26 08:15:10.443177+00	5c82a8f9-39eb-488d-ac29-c1668c07b3f9	9aa72019-ede1-4b37-a63b-400a20a683a7	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
65f89664-335f-44ed-9ea9-33d2908d3d50	2026-02-26 08:15:10.443177+00	5c82a8f9-39eb-488d-ac29-c1668c07b3f9	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7a2df24d-acae-4fa6-95ed-0fc63580b472	2026-02-26 08:15:10.443177+00	5c82a8f9-39eb-488d-ac29-c1668c07b3f9	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	c6bc37d8-7c43-4ae3-9c95-4f6488a42f09	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
69e83720-4a86-4c7f-a7fd-2f3165567e74	2026-02-26 08:15:10.443177+00	5c82a8f9-39eb-488d-ac29-c1668c07b3f9	1c9e7097-df1c-4540-b79b-35055f8f080f	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d3357a45-7786-416e-91f1-9ffabb280c6e	2026-03-27 17:08:01.978683+00	d2799fab-ea30-4eb6-97cd-3ccfa7c1b027	080111ef-d8d7-4662-ba20-cd5ff1bfa389	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
9815caa1-9a71-4c43-84d2-461b9352af4c	2026-02-26 08:15:10.962464+00	d7127d22-656e-451e-bbea-0683ac2e5c93	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f92cdd23-a546-46e7-b7ec-aaf7423fc06e	2026-02-26 08:15:10.962464+00	d7127d22-656e-451e-bbea-0683ac2e5c93	97a3f8b8-caff-4988-b24a-2b7e54d155ee	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b902a700-7a29-41d2-8db1-3c6089a33daa	2026-02-26 08:15:10.962464+00	d7127d22-656e-451e-bbea-0683ac2e5c93	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e2b9ee05-f38e-4766-bbba-fb1d71cfd391	2026-02-26 08:15:10.962464+00	d7127d22-656e-451e-bbea-0683ac2e5c93	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2183b599-f815-4381-892a-bf0c534b1a16	2026-02-26 08:15:10.962464+00	d7127d22-656e-451e-bbea-0683ac2e5c93	13e202ee-272d-415f-8d66-f7669b85afb8	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2e645390-6213-44aa-b66c-3e8eee992379	2026-02-26 08:15:10.962464+00	d7127d22-656e-451e-bbea-0683ac2e5c93	6c379005-03bc-478f-aabd-ad3f75f6477a	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
becbff80-e66e-44b4-bf9c-fbc92a1be418	2026-02-26 08:15:10.962464+00	d7127d22-656e-451e-bbea-0683ac2e5c93	2d98b2aa-9762-4798-8e28-fcb15c380bf5	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7ba42c5d-572c-45ef-b189-cfdd9d068c64	2026-02-26 08:15:09.917767+00	2cc7c0c8-d762-444c-b2e0-6d01264a89c0	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
af937f58-e545-4843-9687-b67615a36bd5	2026-02-26 08:15:11.495451+00	f1d77798-f5c6-4c6a-aadc-99b2951316b6	ddbca8c2-9bfd-4ab2-90d1-8c8127be9331	b6d87440-e59a-402a-81f1-4d996a9a9300	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c17c969e-1c00-4005-b90e-d20ceaa7b3ec	2026-02-26 08:15:11.495451+00	f1d77798-f5c6-4c6a-aadc-99b2951316b6	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
741b81cb-56d8-4c4b-aeca-f6876269641c	2026-03-31 13:26:26.517826+00	54888d72-6043-4268-99c5-a27194874ddf	466a4031-fc42-48c9-88c5-1a1925e19912	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
8eda9817-8138-4dd8-be3a-1565f29eae77	2026-02-26 08:15:11.495451+00	f1d77798-f5c6-4c6a-aadc-99b2951316b6	ceb5bad4-3051-4086-ac9c-a67e6c124aee	d532c50a-26f4-4491-bcb3-e8fe9bb5105d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4e7220a2-ef24-4a51-aa9f-5cbd0a19cabb	2026-02-26 08:15:12.012149+00	ea150542-0aad-4ba3-be58-f8430e13be19	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d4f2997e-565d-4ba0-8906-af2aba5310f5	2026-02-26 08:15:12.012149+00	ea150542-0aad-4ba3-be58-f8430e13be19	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2bec4b96-4c60-41f0-a305-c7ade35375a3	2026-02-26 08:15:12.012149+00	ea150542-0aad-4ba3-be58-f8430e13be19	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6d35fba9-04a3-4be9-a42a-f06a281bcb47	2026-02-26 08:32:18.089056+00	9be7787c-72e8-4afc-b145-a5c6ba08378b	9430b606-42b0-45c9-aca3-c56c6d23d11b	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0189f192-dbaf-4e61-bf20-453f86ec7c1a	2026-02-26 08:32:18.089056+00	9be7787c-72e8-4afc-b145-a5c6ba08378b	86c197e6-24db-4d82-8572-d86b5ca15b2f	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b106ec73-c45c-4427-8402-aa8738f1a6f6	2026-02-26 08:32:18.089056+00	9be7787c-72e8-4afc-b145-a5c6ba08378b	00ef1cb1-a558-407b-8798-c0db3f382cb8	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
30ca5a82-fc1a-4f27-b244-ab19f130607f	2026-02-26 08:32:18.089056+00	9be7787c-72e8-4afc-b145-a5c6ba08378b	a3f3ccb1-7c00-4b52-9837-dc69331b521c	\N	t	AND	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
55a7f496-f63e-401c-9837-7162d5c7cb7f	2026-02-26 08:32:19.763339+00	e358c5ee-23df-422e-9cd2-6350a1c367bc	e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
bb32809b-86fa-4692-8c1a-c702848c49f5	2026-02-26 08:32:19.763339+00	e358c5ee-23df-422e-9cd2-6350a1c367bc	d2566406-84dd-4204-a6c7-31a91107623a	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1df265b3-0d91-49af-9a68-27d0f8acf96d	2026-02-26 08:32:19.763339+00	e358c5ee-23df-422e-9cd2-6350a1c367bc	7374ef8e-c3b3-40aa-b6b4-7ae7159a7ce6	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0e9a8c31-e291-4a35-9047-48978a04ef12	2026-02-26 08:35:20.574832+00	b57de755-f67c-4031-af22-277377011cf7	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2496602b-df6d-42c5-8758-30232ac47a36	2026-02-26 08:35:20.574832+00	b57de755-f67c-4031-af22-277377011cf7	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b46e46e8-7c72-42a2-8d70-13f1e86a08a9	2026-02-26 08:35:20.574832+00	b57de755-f67c-4031-af22-277377011cf7	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	\N	t	ANR	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c3fd105a-94a4-4e7a-a3a3-b8784dd2c780	2026-02-26 08:35:20.574832+00	b57de755-f67c-4031-af22-277377011cf7	13e202ee-272d-415f-8d66-f7669b85afb8	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f9b783d1-17db-403f-8c66-0ddd50ce2d83	2026-02-26 08:35:20.574832+00	b57de755-f67c-4031-af22-277377011cf7	6c379005-03bc-478f-aabd-ad3f75f6477a	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e0ae9fdd-a2dd-4abd-beb9-ec5cdd404e2c	2026-02-26 08:35:20.574832+00	b57de755-f67c-4031-af22-277377011cf7	2d98b2aa-9762-4798-8e28-fcb15c380bf5	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
96098d81-66f2-45c4-b94e-89f92a7cde6b	2026-02-26 08:15:11.495451+00	f1d77798-f5c6-4c6a-aadc-99b2951316b6	7e7447f5-56a1-4513-9606-978058d389d5	\N	t	PETITON'R	f	2026-01-17	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
d671ae1d-2bf0-4224-8871-ea8c3ce59ca4	2026-02-26 08:15:11.495451+00	f1d77798-f5c6-4c6a-aadc-99b2951316b6	8b6e4db3-9332-457c-8e1a-ad88af0c40be	\N	t	CANNELLE	f	2025-12-13	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
184a21a9-060c-4b68-af85-8297ef1d976d	2026-03-31 17:18:27.685026+00	b176fc38-62f1-4551-acad-1cac0d34fc6e	7fb3adc8-4473-43a4-84a8-c76a60e2665f	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
ce026f5a-ed69-4cbb-960b-45d28eef15de	2026-02-26 08:32:19.763339+00	e358c5ee-23df-422e-9cd2-6350a1c367bc	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
69870956-400a-4b71-af71-93c1543a9da2	2026-04-02 09:22:02.982366+00	305879cc-2e3f-4bef-9fae-ae3f4ba59939	3cbd32b1-84a7-4596-92d0-903d6ea1f631	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
15fd1de3-3274-4579-a727-cf26701ef9c7	2026-02-26 08:13:24.896168+00	9940ffc8-c4ee-4336-be1e-f0f872681115	a3f3ccb1-7c00-4b52-9837-dc69331b521c	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2025-09-17	f
8bce3d94-f389-4e70-bbd1-9ca914b81388	2026-02-26 08:33:57.088491+00	f0712d2b-f503-40c3-b90e-df6fe70edacb	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2025-11-29	f
8a522bd7-8678-42fc-8ecb-bd73473a3b29	2026-02-26 08:15:10.443177+00	5c82a8f9-39eb-488d-ac29-c1668c07b3f9	7dd68452-30ed-4829-857d-bebc61aff9c1	\N	t	\N	f	2026-03-28	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
e8727cc1-d055-4f4b-9e61-285a88f4ccd2	2026-02-26 08:32:19.763339+00	e358c5ee-23df-422e-9cd2-6350a1c367bc	01fdbddd-ee76-4200-a153-47cc61d67398	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
33bd63b0-75e9-46ad-a564-a0fbcb6d2d70	2026-03-27 15:43:39.618187+00	8e2c3967-a1d6-439c-b9df-556c99a59740	8dab5312-dbee-4f86-83dd-0874ffc99c46	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
bb6e5ba9-9656-43ee-8fd0-117620cfb4fa	2026-03-24 16:28:45.737107+00	9c8442a1-78c2-48c6-896b-c33d34857bb7	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-03-07	f
48e29713-4243-49a2-9dd8-7f9d468225cc	2026-03-27 15:24:38.611939+00	56b0d021-a032-4fd8-8b64-b129fc01022d	893bb307-08a3-4af2-ba54-6c5da32206ad	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
f5c4a3e3-4da1-46db-9628-ba994bae4de2	2026-03-27 15:24:39.862099+00	56b0d021-a032-4fd8-8b64-b129fc01022d	19dfcd2c-5aaf-4e09-ac63-9856393cfb3c	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
b24006cc-a394-434f-b302-6c6737da852f	2026-03-27 15:25:21.402446+00	77471b49-c614-41d6-8dfe-2e5b1f6cc28d	3cbd32b1-84a7-4596-92d0-903d6ea1f631	76876dd9-f4c0-455c-9b22-08799cc72af0	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
305220e2-552a-4b6f-928a-c1218aec3130	2026-03-27 15:25:22.755189+00	77471b49-c614-41d6-8dfe-2e5b1f6cc28d	080111ef-d8d7-4662-ba20-cd5ff1bfa389	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
c36b70e0-1713-4343-8867-66d8a3e7914b	2026-03-29 08:58:47.957303+00	d167c565-1ed1-49a2-837e-1d3d7b9f4502	9c87739b-74ad-47b9-a70f-6efc26c93f00	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
df95e2f8-984d-4cc3-97c0-9e8f9ce602c6	2026-03-29 08:58:47.957303+00	d167c565-1ed1-49a2-837e-1d3d7b9f4502	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0073cac4-a896-43a6-ab41-61c102a77052	2026-03-29 08:58:47.957303+00	d167c565-1ed1-49a2-837e-1d3d7b9f4502	ce4184ad-5144-4b9b-8276-0111197e0885	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
01dd6ce2-7491-4872-ac38-78f39cbb4841	2026-03-31 13:26:27.158681+00	54888d72-6043-4268-99c5-a27194874ddf	7fb3adc8-4473-43a4-84a8-c76a60e2665f	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
689e2f25-3945-4f25-8188-4ddf14fa19a4	2026-03-31 17:22:13.116346+00	f7cfa1e9-8345-46db-832d-a470747f1fca	893bb307-08a3-4af2-ba54-6c5da32206ad	c6bc37d8-7c43-4ae3-9c95-4f6488a42f09	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
9b5c8000-aec7-4bd0-9736-b47954992fdd	2026-03-31 17:22:14.956341+00	f7cfa1e9-8345-46db-832d-a470747f1fca	322417b3-f05a-488c-b3b6-8956e7e4413a	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
619eba5b-5465-4815-806d-4a73193b73eb	2026-04-01 12:50:13.878028+00	cba5eb52-034b-40dc-8faa-d623420d7a53	3cbd32b1-84a7-4596-92d0-903d6ea1f631	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
b53ae6c4-03f3-42eb-ae70-7fe237807b99	2026-04-02 09:22:03.81184+00	305879cc-2e3f-4bef-9fae-ae3f4ba59939	080111ef-d8d7-4662-ba20-cd5ff1bfa389	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
b96ab193-862c-4638-8be9-60f64712a883	2026-03-23 09:51:45.12461+00	87618f27-0efc-4904-bce7-e6fc6e7afcdb	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
abef6751-5d7d-487d-a38c-aa73c1581660	2026-04-03 06:07:32.923066+00	f67bbea7-6b82-4f66-a99e-a40559dd54de	ce4184ad-5144-4b9b-8276-0111197e0885	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-04-04	f
5093ae15-cdd8-456d-b975-7c6f1c3ab156	2026-03-23 09:51:44.598945+00	ac9e2ac7-b88d-427f-b83b-2b20d22a219c	13e202ee-272d-415f-8d66-f7669b85afb8	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2cb5a7a9-015e-4611-9fc1-75b70007674a	2026-03-29 08:58:47.957303+00	d167c565-1ed1-49a2-837e-1d3d7b9f4502	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	\N	t	🅰️	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
89e8f241-b7ec-48f2-a5d2-cc3e3a800765	2026-04-05 08:26:59.427671+00	5be512c2-b802-4db0-89b2-c62aea0ad82a	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	059512a2-d080-480d-b201-84c5179e56ed	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-02-28	f
6315bc43-5203-4f8f-9734-b98bc1d39a5d	2026-04-05 10:14:11.503474+00	dcd11b42-5a1f-4213-b441-afafd4b16f06	9430b606-42b0-45c9-aca3-c56c6d23d11b	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-02-25	f
1b502861-8212-4723-8ce6-2f92b901cc00	2026-03-16 12:19:13.059885+00	5a4c855f-a5f6-4a9d-8df6-4a7652e0aded	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5a5d37e0-adf4-4a2e-9479-196fcd80e173	2026-04-25 05:02:21.559809+00	57acfb30-beff-4231-ae3f-d276a560e310	9aa72019-ede1-4b37-a63b-400a20a683a7	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c5436aa4-75c1-464d-acf4-af2439ce396f	2026-04-25 05:02:21.559809+00	57acfb30-beff-4231-ae3f-d276a560e310	01fdbddd-ee76-4200-a153-47cc61d67398	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2191c1ef-8470-4d7a-a697-e5b4f8d0114d	2026-04-25 05:02:21.559809+00	57acfb30-beff-4231-ae3f-d276a560e310	1c9e7097-df1c-4540-b79b-35055f8f080f	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5f91f247-9b01-414f-b703-36e0b8a78c46	2026-04-25 05:02:21.559809+00	57acfb30-beff-4231-ae3f-d276a560e310	7dd68452-30ed-4829-857d-bebc61aff9c1	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0773b021-9274-49a5-9111-4ab46d7f9b5c	2026-04-25 05:02:21.559809+00	57acfb30-beff-4231-ae3f-d276a560e310	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
eb76f279-5ea5-4adc-95a7-162d571fbf1b	2026-04-25 05:02:22.014604+00	e97e4a9d-eb65-472f-ac6f-4572841a2e02	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
28b4343c-486d-4cd9-adb7-21b3c28c422b	2026-03-27 15:43:39.885451+00	8e2c3967-a1d6-439c-b9df-556c99a59740	893bb307-08a3-4af2-ba54-6c5da32206ad	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d551af14-d19c-46f1-94ce-4623f183ce48	2026-03-29 08:58:48.45453+00	ab8fd60b-d7dc-4a1b-91b8-8647ef335aaf	9aa72019-ede1-4b37-a63b-400a20a683a7	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5be35b28-1471-4ab0-ac2d-46b7119cac27	2026-03-13 14:33:24.671428+00	d9b1cb06-e452-4f66-8dd5-781d1af83b6a	9c87739b-74ad-47b9-a70f-6efc26c93f00	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
3c8ad26a-4c3a-4f97-8566-50ef46b64bb8	2026-03-16 07:57:58.323573+00	6016166e-932a-4979-8790-03a0c26c99ba	9430b606-42b0-45c9-aca3-c56c6d23d11b	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5f1ef868-00fc-4903-9614-e70431f91c85	2026-03-13 14:33:24.671428+00	d9b1cb06-e452-4f66-8dd5-781d1af83b6a	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
16294d8d-3421-4a44-94d1-4c109607ef75	2026-03-13 14:33:24.671428+00	d9b1cb06-e452-4f66-8dd5-781d1af83b6a	ce4184ad-5144-4b9b-8276-0111197e0885	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
df33d8c1-b415-4c7f-9dc4-f725b8b45d5c	2026-02-25 09:19:10.502594+00	341d524a-37e2-45c7-941a-9aff26f1641c	a41687b8-6f23-46d2-abbb-285d71a1331c	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1d7ae828-d958-474f-b965-6873b72a730d	2026-02-25 09:28:36.4793+00	1e2b6f64-09fc-4ab9-8967-bc0a47eafb44	1c9e7097-df1c-4540-b79b-35055f8f080f	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
861b098c-05ad-4393-9883-59bda6087ace	2026-03-16 07:57:58.323573+00	6016166e-932a-4979-8790-03a0c26c99ba	00ef1cb1-a558-407b-8798-c0db3f382cb8	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ceaab415-cffa-4fd8-862e-e64295ad204e	2026-03-13 14:33:25.316953+00	f6f9d485-aa8a-42f1-9a02-e19856e5c921	9aa72019-ede1-4b37-a63b-400a20a683a7	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a695ea20-9fad-4f29-83d4-c4dd13bbe7d4	2026-03-13 14:33:25.316953+00	f6f9d485-aa8a-42f1-9a02-e19856e5c921	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5de89a74-3ffe-4760-b232-25cc5f2fb195	2026-03-29 08:58:48.45453+00	ab8fd60b-d7dc-4a1b-91b8-8647ef335aaf	01fdbddd-ee76-4200-a153-47cc61d67398	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1bb9c8ee-573d-4d43-bef5-aab3638ea96a	2026-03-16 07:57:58.820334+00	4613dd55-48eb-47d6-af52-4f6fe4acd2ce	7c879cb9-b214-4851-9fb7-cd84b0698bb7	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8acfef4f-1f6f-4c38-be8b-8563a1ed00d5	2026-03-13 14:33:25.316953+00	f6f9d485-aa8a-42f1-9a02-e19856e5c921	7dd68452-30ed-4829-857d-bebc61aff9c1	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8e5fff61-4dc3-4d10-8f45-acbcf6889590	2026-03-13 16:04:56.829085+00	f6f9d485-aa8a-42f1-9a02-e19856e5c921	ed3a44cb-388f-431a-bf56-2d35af78ea8a	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-03-11	f
b7910d19-1db0-4f2a-84a3-c6febaa508b3	2026-03-13 14:33:25.896166+00	1b9da96a-4aad-45be-bff7-a96f594f2455	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
dce04c93-4285-499a-9f03-7ab0a33ec8e4	2026-03-13 14:33:25.896166+00	1b9da96a-4aad-45be-bff7-a96f594f2455	97a3f8b8-caff-4988-b24a-2b7e54d155ee	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d307d38e-6772-435c-ac99-7eb1691a1d4d	2026-03-13 14:33:25.896166+00	1b9da96a-4aad-45be-bff7-a96f594f2455	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c61bf5e9-d829-4c8d-a642-9a6e3a2f819f	2026-03-13 14:33:25.896166+00	1b9da96a-4aad-45be-bff7-a96f594f2455	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
22900414-f7d7-495f-ac3a-2f00ff173696	2026-03-13 14:33:25.896166+00	1b9da96a-4aad-45be-bff7-a96f594f2455	13e202ee-272d-415f-8d66-f7669b85afb8	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
849e3f4d-096b-42cb-a3b6-3f80c3bbc020	2026-03-13 14:33:25.896166+00	1b9da96a-4aad-45be-bff7-a96f594f2455	6c379005-03bc-478f-aabd-ad3f75f6477a	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
03d813f2-b00d-48c9-802f-d72dd3984392	2026-03-13 14:33:25.896166+00	1b9da96a-4aad-45be-bff7-a96f594f2455	2d98b2aa-9762-4798-8e28-fcb15c380bf5	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6f69c366-0aea-4572-8152-47972dc2b896	2026-03-13 14:33:26.475227+00	f088291c-c6e4-478e-a637-5a6200191a7e	8b6e4db3-9332-457c-8e1a-ad88af0c40be	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
147fece1-7e13-4580-954f-63ea5c842ffb	2026-03-13 14:33:26.475227+00	f088291c-c6e4-478e-a637-5a6200191a7e	ddbca8c2-9bfd-4ab2-90d1-8c8127be9331	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b33c1347-0dc7-4d13-a692-e08478b737b4	2026-03-13 14:33:26.475227+00	f088291c-c6e4-478e-a637-5a6200191a7e	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f965215b-b763-4d2a-8a0e-811e556c62f2	2026-03-13 14:33:26.475227+00	f088291c-c6e4-478e-a637-5a6200191a7e	ceb5bad4-3051-4086-ac9c-a67e6c124aee	b6d87440-e59a-402a-81f1-4d996a9a9300	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8648000b-d3e0-414f-b6db-763b1c6d21b5	2026-03-13 14:33:26.475227+00	f088291c-c6e4-478e-a637-5a6200191a7e	7e7447f5-56a1-4513-9606-978058d389d5	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
76c47b84-533a-4ec4-81fe-446f32d23892	2026-03-13 14:33:27.046422+00	1d8743d0-47a0-40de-bbbb-ec5b32493315	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c763c388-31bb-496c-b462-c0dbd8e797bb	2026-03-13 14:33:27.046422+00	1d8743d0-47a0-40de-bbbb-ec5b32493315	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6fdbc48c-d007-469b-8c47-0bc960c0f5cf	2026-03-13 14:33:27.046422+00	1d8743d0-47a0-40de-bbbb-ec5b32493315	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d6c05fd5-26cd-489a-8089-a1b66f4c1515	2026-03-16 07:57:58.323573+00	6016166e-932a-4979-8790-03a0c26c99ba	a3f3ccb1-7c00-4b52-9837-dc69331b521c	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
dfadcb0e-6b53-4272-92a2-71eb5abf0014	2026-03-29 08:58:48.45453+00	ab8fd60b-d7dc-4a1b-91b8-8647ef335aaf	1c9e7097-df1c-4540-b79b-35055f8f080f	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1c30c111-520b-4225-baf6-d21b498749e7	2026-03-13 16:26:22.670974+00	f088291c-c6e4-478e-a637-5a6200191a7e	33600627-aea8-4768-8be4-eadb5152e41f	d532c50a-26f4-4491-bcb3-e8fe9bb5105d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
03474d46-1f60-4b7d-9c29-bd1325380538	2026-03-13 14:33:25.316953+00	f6f9d485-aa8a-42f1-9a02-e19856e5c921	1c9e7097-df1c-4540-b79b-35055f8f080f	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c98b55e4-1c07-4606-a2c8-2fbea1f89f25	2026-03-13 14:33:24.671428+00	d9b1cb06-e452-4f66-8dd5-781d1af83b6a	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	\N	t	🅰️	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
89af3dca-38ff-410f-84dd-7da50d683247	2026-03-29 08:58:48.45453+00	ab8fd60b-d7dc-4a1b-91b8-8647ef335aaf	7dd68452-30ed-4829-857d-bebc61aff9c1	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c6a149ad-1fc7-4637-bc7c-cb5ea6a8022b	2026-03-29 08:58:48.45453+00	ab8fd60b-d7dc-4a1b-91b8-8647ef335aaf	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f5496c0e-0278-4ea2-a49b-5bc65dd82126	2026-03-29 08:58:50.022619+00	230391cb-f41c-4520-998d-0a04dae98e88	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ab34d341-12e7-49fc-b647-c4e3427643a5	2026-03-16 07:57:58.820334+00	4613dd55-48eb-47d6-af52-4f6fe4acd2ce	f6b2c3bc-2197-44c1-a848-d18a66e3fdf5	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
bd9635a3-597d-46aa-a81b-ec6345789073	2026-03-16 07:57:58.820334+00	4613dd55-48eb-47d6-af52-4f6fe4acd2ce	b0054d27-f377-41ad-a026-a2893c27692a	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9506f206-1f15-4d08-a3c7-7c02c113bc59	2026-03-16 07:57:58.820334+00	4613dd55-48eb-47d6-af52-4f6fe4acd2ce	1d2c9275-719e-452b-9298-ec476ac53155	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
25f7c8db-c4bc-4785-b268-39afb3072673	2026-03-16 11:21:55.909781+00	4613dd55-48eb-47d6-af52-4f6fe4acd2ce	\N	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Giulia	30.00	t	Espèces	2026-03-18	\N	f
c55c96ff-2470-4875-becf-fb118f21869c	2026-03-16 07:57:59.337486+00	e007f4c1-6593-4895-a128-9e826aa045be	70610b82-10ea-46b2-a99b-59c187db69da	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8905647d-61e6-4645-9ec5-424ec41f43b3	2026-03-16 07:57:59.337486+00	e007f4c1-6593-4895-a128-9e826aa045be	7851fd12-1e6f-4a02-b957-c2120bc0ac83	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
102d78ac-e0aa-4c19-a0b6-8b3fcf1bb249	2026-03-16 07:57:59.807974+00	5d922c15-82c5-40aa-ba29-14569b485b6e	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
45f6f56f-ed9d-4a05-9192-9465867c706b	2026-03-16 07:57:59.337486+00	e007f4c1-6593-4895-a128-9e826aa045be	8b2745aa-d94a-48b9-be06-1aa87aac12d0	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
99fda680-2e89-4e82-a3c9-ba027d82e24b	2026-03-16 07:57:59.337486+00	e007f4c1-6593-4895-a128-9e826aa045be	386cac04-cc49-4dd7-bb14-b17b9760795b	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0629d98d-91f2-4f2d-b5c5-bbf45b315848	2026-03-16 07:57:59.337486+00	e007f4c1-6593-4895-a128-9e826aa045be	ed3a44cb-388f-431a-bf56-2d35af78ea8a	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d0c1912c-ee5e-42ef-b1b7-a7fba297a533	2026-03-16 07:57:59.337486+00	e007f4c1-6593-4895-a128-9e826aa045be	a41687b8-6f23-46d2-abbb-285d71a1331c	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
dec6d5a3-64e1-4157-a1ab-dc145bc8a24a	2026-03-16 07:57:59.807974+00	5d922c15-82c5-40aa-ba29-14569b485b6e	e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
fc88248a-ad0a-488f-b548-61e33a318b1f	2026-03-16 07:57:59.807974+00	5d922c15-82c5-40aa-ba29-14569b485b6e	d2566406-84dd-4204-a6c7-31a91107623a	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2995bae0-9904-43d6-b7fa-67892bc75f1b	2026-03-16 07:57:59.807974+00	5d922c15-82c5-40aa-ba29-14569b485b6e	7374ef8e-c3b3-40aa-b6b4-7ae7159a7ce6	c6bc37d8-7c43-4ae3-9c95-4f6488a42f09	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f715ce14-cb75-488e-a140-b99e32336a97	2026-03-16 07:57:59.807974+00	5d922c15-82c5-40aa-ba29-14569b485b6e	01fdbddd-ee76-4200-a153-47cc61d67398	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
85d7e729-e1d2-41bb-98e1-0cd15f01bc04	2026-03-16 07:57:58.323573+00	6016166e-932a-4979-8790-03a0c26c99ba	86c197e6-24db-4d82-8572-d86b5ca15b2f	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9bb36593-ccf3-43df-ab29-be1e76ecb5ed	2026-03-13 14:33:25.316953+00	f6f9d485-aa8a-42f1-9a02-e19856e5c921	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	\N	t	\N	f	2026-03-21	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
35670aef-6148-4264-85e0-354c3f0b1fdb	2026-03-16 11:28:16.620234+00	a3c9c2b2-460a-402d-8e27-89d9804d47b4	70610b82-10ea-46b2-a99b-59c187db69da	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f2e5c8cf-dcb2-4119-b339-afe457fc817b	2026-03-16 11:28:16.620234+00	a3c9c2b2-460a-402d-8e27-89d9804d47b4	a41687b8-6f23-46d2-abbb-285d71a1331c	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6ba117c6-a350-4643-a05d-33dcae9c49ea	2026-03-16 11:28:16.620234+00	a3c9c2b2-460a-402d-8e27-89d9804d47b4	7851fd12-1e6f-4a02-b957-c2120bc0ac83	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
611f2caf-808f-4364-bf04-1b11d0d90f28	2026-03-16 11:28:16.620234+00	a3c9c2b2-460a-402d-8e27-89d9804d47b4	386cac04-cc49-4dd7-bb14-b17b9760795b	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
aafb4cd6-84d8-4ac8-8d05-cd00ecdecaef	2026-03-16 11:28:16.620234+00	a3c9c2b2-460a-402d-8e27-89d9804d47b4	ed3a44cb-388f-431a-bf56-2d35af78ea8a	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
00771fad-2ef0-4146-8dca-a980a6be3ebf	2026-03-16 11:28:16.114847+00	9c8442a1-78c2-48c6-896b-c33d34857bb7	f6b2c3bc-2197-44c1-a848-d18a66e3fdf5	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
62d3ef09-510f-4469-904e-6c8cf5ff6c6d	2026-03-27 15:43:40.149007+00	8e2c3967-a1d6-439c-b9df-556c99a59740	080111ef-d8d7-4662-ba20-cd5ff1bfa389	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f4dee80f-9153-4e4e-a885-4d75716ed1c8	2026-03-16 11:28:17.161273+00	928d33f9-8ab5-4d55-825a-2112cc604d5d	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d67fedd1-eddf-4e11-87fd-c966674acc9e	2026-03-16 11:33:31.654038+00	1de1c71c-97a6-4a19-9b53-8e5c15114e5f	f6b2c3bc-2197-44c1-a848-d18a66e3fdf5	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
34c2e6a8-a634-4dd1-a318-4c0865814433	2026-03-16 11:28:17.161273+00	928d33f9-8ab5-4d55-825a-2112cc604d5d	7374ef8e-c3b3-40aa-b6b4-7ae7159a7ce6	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
24c17096-f76b-4aca-9225-7a1506dea0a6	2026-03-16 11:28:17.161273+00	928d33f9-8ab5-4d55-825a-2112cc604d5d	d2566406-84dd-4204-a6c7-31a91107623a	c6bc37d8-7c43-4ae3-9c95-4f6488a42f09	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
14cb9e71-cff5-44ee-b909-76c7ea2ae346	2026-03-16 12:19:12.01639+00	e0b89ef3-cc1e-45cf-97bc-cec607b939cd	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
3486fecf-98f8-4fa4-ba62-92b5902f3f92	2026-03-16 11:33:31.167578+00	4a93e21d-51a7-4441-a423-d01947503525	86c197e6-24db-4d82-8572-d86b5ca15b2f	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
3335b7cd-54a7-45ab-9508-8badee1b003b	2026-03-29 08:58:48.949587+00	bf589032-8b02-42cb-9f13-17c84cd4a7e6	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ec807f56-4bc2-4fb2-b9f2-5c0d7d906a17	2026-03-29 08:58:48.949587+00	bf589032-8b02-42cb-9f13-17c84cd4a7e6	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
10f878a1-fb07-4a2f-9be2-33bd1acaf31b	2026-03-29 08:58:48.949587+00	bf589032-8b02-42cb-9f13-17c84cd4a7e6	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
3edd0994-7099-4e35-b8e7-26193e82149d	2026-03-29 08:58:48.949587+00	bf589032-8b02-42cb-9f13-17c84cd4a7e6	13e202ee-272d-415f-8d66-f7669b85afb8	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
632a6d21-bb69-4531-acf6-d6deb7c8d213	2026-03-16 11:33:31.167578+00	4a93e21d-51a7-4441-a423-d01947503525	00ef1cb1-a558-407b-8798-c0db3f382cb8	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
b4684d05-e600-4e66-becf-b40d7152706f	2026-03-16 11:33:31.167578+00	4a93e21d-51a7-4441-a423-d01947503525	a3f3ccb1-7c00-4b52-9837-dc69331b521c	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
2260c66c-eb2b-4046-91f4-53703424ab15	2026-03-16 11:33:32.147572+00	f2e2785b-4254-4382-8901-03f73320dc4d	386cac04-cc49-4dd7-bb14-b17b9760795b	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
64722ee6-f964-4424-a58d-dade0eff4168	2026-03-16 11:33:31.654038+00	1de1c71c-97a6-4a19-9b53-8e5c15114e5f	b0054d27-f377-41ad-a026-a2893c27692a	d532c50a-26f4-4491-bcb3-e8fe9bb5105d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1131b9aa-6767-4acf-ab83-e0fba0f0e013	2026-03-16 11:28:15.618563+00	903da260-bfef-4020-aff1-9966758aefe2	9430b606-42b0-45c9-aca3-c56c6d23d11b	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
b62d39f4-fe56-455a-8c7e-d37465519884	2026-03-16 11:28:16.114847+00	9c8442a1-78c2-48c6-896b-c33d34857bb7	b0054d27-f377-41ad-a026-a2893c27692a	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5e8f1393-d2ec-44d0-9b77-82cafffed86e	2026-03-16 11:28:15.618563+00	903da260-bfef-4020-aff1-9966758aefe2	86c197e6-24db-4d82-8572-d86b5ca15b2f	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7a9dcc7e-ed6e-42f1-920d-0e5301a315c9	2026-03-16 11:28:17.161273+00	928d33f9-8ab5-4d55-825a-2112cc604d5d	e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9a482a11-6f3c-46b6-9485-683da98908ff	2026-03-16 12:19:07.779026+00	9c805a1c-17ed-41b8-a4d2-fe99b3827867	9c87739b-74ad-47b9-a70f-6efc26c93f00	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
78232b16-0cd9-45d0-8a17-2e597b952069	2026-03-16 12:19:07.779026+00	9c805a1c-17ed-41b8-a4d2-fe99b3827867	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
70e3679f-377e-49b1-a6b4-eb7fa0d82671	2026-03-16 12:19:07.779026+00	9c805a1c-17ed-41b8-a4d2-fe99b3827867	ce4184ad-5144-4b9b-8276-0111197e0885	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7e9b43c0-a255-48e7-ba2f-6b70825a1bef	2026-03-16 12:19:07.779026+00	9c805a1c-17ed-41b8-a4d2-fe99b3827867	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f856d682-697c-404c-8b89-fabf6d635d44	2026-03-16 12:19:08.317478+00	ff04be4d-98ac-46ea-89f1-0d5124b93f6d	9aa72019-ede1-4b37-a63b-400a20a683a7	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
970351e5-506d-4ce8-96c2-f80effbc590d	2026-03-16 12:19:08.317478+00	ff04be4d-98ac-46ea-89f1-0d5124b93f6d	01fdbddd-ee76-4200-a153-47cc61d67398	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
753a4337-49f2-417a-8833-2bcb9cc93471	2026-03-16 12:19:08.317478+00	ff04be4d-98ac-46ea-89f1-0d5124b93f6d	1c9e7097-df1c-4540-b79b-35055f8f080f	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ee176dc0-407e-4f45-9b8f-fe4376ab7f86	2026-03-16 12:19:08.317478+00	ff04be4d-98ac-46ea-89f1-0d5124b93f6d	7dd68452-30ed-4829-857d-bebc61aff9c1	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
bf300c7d-d4ac-417f-a53a-9a92aa8a2129	2026-03-16 12:19:08.317478+00	ff04be4d-98ac-46ea-89f1-0d5124b93f6d	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
79e231b6-3387-4158-8843-4fe0b652403a	2026-03-16 12:19:08.836116+00	f2268971-eef5-4eec-bba6-f4b4434b5415	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7b480c28-b66d-4bb8-8961-c65e71f8ee04	2026-03-16 12:19:08.836116+00	f2268971-eef5-4eec-bba6-f4b4434b5415	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d42ffb32-45b7-4361-980f-c3dd83175475	2026-03-16 11:33:31.167578+00	4a93e21d-51a7-4441-a423-d01947503525	9430b606-42b0-45c9-aca3-c56c6d23d11b	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
71b0cd1e-63ed-4cb2-a4fc-b1dca355ea9d	2026-03-16 11:28:16.620234+00	a3c9c2b2-460a-402d-8e27-89d9804d47b4	8b2745aa-d94a-48b9-be06-1aa87aac12d0	\N	t	AD 25/03 12:30	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f7afc68e-f80c-4f57-ac7b-50aa8c71c947	2026-03-24 16:30:28.74827+00	1de1c71c-97a6-4a19-9b53-8e5c15114e5f	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-03-21	f
803d9ec2-cab4-48f5-92a1-469833936d64	2026-03-16 11:33:32.883976+00	d4d3b5ac-e99f-46de-a0cf-aa1fe4177d74	7374ef8e-c3b3-40aa-b6b4-7ae7159a7ce6	c6bc37d8-7c43-4ae3-9c95-4f6488a42f09	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f3620ebb-b7c9-4bf2-ae32-eae83f40afea	2026-03-16 11:33:32.147572+00	f2e2785b-4254-4382-8901-03f73320dc4d	70610b82-10ea-46b2-a99b-59c187db69da	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
857f68f2-b8a1-415f-86f8-7220477b2b51	2026-03-16 11:33:32.147572+00	f2e2785b-4254-4382-8901-03f73320dc4d	ed3a44cb-388f-431a-bf56-2d35af78ea8a	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c3d1dc8b-ed39-4360-b585-5258108d23f8	2026-03-16 11:33:32.883976+00	d4d3b5ac-e99f-46de-a0cf-aa1fe4177d74	e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5a59407f-a363-4d5a-b652-e81f34af5c53	2026-03-16 11:33:32.883976+00	d4d3b5ac-e99f-46de-a0cf-aa1fe4177d74	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
19ea0be0-ef03-4c10-bb5c-8188b916c57a	2026-03-16 11:33:32.883976+00	d4d3b5ac-e99f-46de-a0cf-aa1fe4177d74	d2566406-84dd-4204-a6c7-31a91107623a	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7cef9639-6814-4c24-83c9-bae485cdf793	2026-03-16 11:33:32.883976+00	d4d3b5ac-e99f-46de-a0cf-aa1fe4177d74	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4e2dabeb-2cf8-4a19-8c6a-e9aa1e3b0e0e	2026-03-16 11:33:31.654038+00	1de1c71c-97a6-4a19-9b53-8e5c15114e5f	1d2c9275-719e-452b-9298-ec476ac53155	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d2eec2cb-7e44-4121-83a9-ee04ab7d0359	2026-03-16 12:19:12.01639+00	e0b89ef3-cc1e-45cf-97bc-cec607b939cd	9c87739b-74ad-47b9-a70f-6efc26c93f00	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d7e28ef0-8d2c-4c24-8b47-efe2912722fe	2026-03-16 11:33:32.147572+00	f2e2785b-4254-4382-8901-03f73320dc4d	7851fd12-1e6f-4a02-b957-c2120bc0ac83	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
50b2d1d1-93cb-4e2f-82df-b3a07bbc9552	2026-03-16 11:33:32.147572+00	f2e2785b-4254-4382-8901-03f73320dc4d	a41687b8-6f23-46d2-abbb-285d71a1331c	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6d4cbea2-ed4e-4b2c-944b-f348591db26b	2026-03-16 11:33:32.147572+00	f2e2785b-4254-4382-8901-03f73320dc4d	8b2745aa-d94a-48b9-be06-1aa87aac12d0	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b6ecb021-7f11-480c-a58a-48f87afedd46	2026-03-16 11:28:15.618563+00	903da260-bfef-4020-aff1-9966758aefe2	00ef1cb1-a558-407b-8798-c0db3f382cb8	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b9f9a705-b5b2-41cb-8408-5e3d185f00fb	2026-03-16 11:28:16.114847+00	9c8442a1-78c2-48c6-896b-c33d34857bb7	1d2c9275-719e-452b-9298-ec476ac53155	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b5cb85b1-e215-4933-9c4e-71b944581a37	2026-03-16 11:28:15.618563+00	903da260-bfef-4020-aff1-9966758aefe2	a3f3ccb1-7c00-4b52-9837-dc69331b521c	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
08312a03-a32c-485d-826d-5618da5631ae	2026-03-16 11:28:16.114847+00	9c8442a1-78c2-48c6-896b-c33d34857bb7	7c879cb9-b214-4851-9fb7-cd84b0698bb7	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
add7ff76-c0ce-4cab-910c-690fcc683568	2026-03-16 11:28:17.161273+00	928d33f9-8ab5-4d55-825a-2112cc604d5d	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
07914d50-7f0a-42fc-966e-08fc8b139bd8	2026-03-16 12:19:12.01639+00	e0b89ef3-cc1e-45cf-97bc-cec607b939cd	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6866ab03-4b04-477b-ab5c-d5e5c7a76b6b	2026-03-16 12:19:12.01639+00	e0b89ef3-cc1e-45cf-97bc-cec607b939cd	ce4184ad-5144-4b9b-8276-0111197e0885	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
87d8d04c-b91a-4329-8c48-60b43eedcd47	2026-03-16 12:19:08.836116+00	f2268971-eef5-4eec-bba6-f4b4434b5415	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d5590c65-ed48-48f5-b255-1c7d66ac46bd	2026-03-16 12:19:08.836116+00	f2268971-eef5-4eec-bba6-f4b4434b5415	13e202ee-272d-415f-8d66-f7669b85afb8	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
af8dda2f-53b0-4483-ad8e-23f017038d29	2026-03-16 12:19:08.836116+00	f2268971-eef5-4eec-bba6-f4b4434b5415	6c379005-03bc-478f-aabd-ad3f75f6477a	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6f0d18d7-e0f5-47ee-96b8-541abad96f44	2026-03-16 12:19:08.836116+00	f2268971-eef5-4eec-bba6-f4b4434b5415	2d98b2aa-9762-4798-8e28-fcb15c380bf5	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2c0613aa-89aa-4f95-87a7-43275339a217	2026-03-16 12:19:08.836116+00	f2268971-eef5-4eec-bba6-f4b4434b5415	97a3f8b8-caff-4988-b24a-2b7e54d155ee	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
fc346d68-acc0-44f9-b326-7dcd54afce78	2026-03-16 12:19:09.36066+00	8533848b-f6f9-440b-800f-59780e56d718	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
fd794001-90a3-412d-8926-f00b0905520c	2026-03-16 12:19:09.36066+00	8533848b-f6f9-440b-800f-59780e56d718	7e7447f5-56a1-4513-9606-978058d389d5	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
175d48e7-857c-468d-9576-9f68b16618a8	2026-03-16 12:19:09.36066+00	8533848b-f6f9-440b-800f-59780e56d718	ceb5bad4-3051-4086-ac9c-a67e6c124aee	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
de730609-2e1e-446b-8466-b7460cafa3ff	2026-03-16 12:19:09.36066+00	8533848b-f6f9-440b-800f-59780e56d718	33600627-aea8-4768-8be4-eadb5152e41f	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f27c2f43-4cfa-4e9e-a112-19ef755d597d	2026-03-16 12:19:09.924289+00	48196dd6-c4df-45cf-99d0-59591873a586	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0a77047a-cd21-4b7d-aa31-26293f17fd96	2026-03-16 12:19:09.924289+00	48196dd6-c4df-45cf-99d0-59591873a586	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
bf059356-91c7-4916-8c34-37dcdf2f0c4d	2026-03-16 12:19:09.924289+00	48196dd6-c4df-45cf-99d0-59591873a586	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
fb6974ef-6c7a-4097-add0-64794d75720d	2026-03-27 15:43:40.397195+00	8e2c3967-a1d6-439c-b9df-556c99a59740	19dfcd2c-5aaf-4e09-ac63-9856393cfb3c	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2acbbb71-78cf-4818-939f-da45ef38a548	2026-03-29 08:58:48.949587+00	bf589032-8b02-42cb-9f13-17c84cd4a7e6	6c379005-03bc-478f-aabd-ad3f75f6477a	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4ea42344-7ec0-47f0-95ae-18bbbbf695d4	2026-03-29 08:58:48.949587+00	bf589032-8b02-42cb-9f13-17c84cd4a7e6	2d98b2aa-9762-4798-8e28-fcb15c380bf5	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
71a28fd5-1497-4048-bab6-3c96375b42d8	2026-03-24 17:25:31.168309+00	9c8442a1-78c2-48c6-896b-c33d34857bb7	ceb5bad4-3051-4086-ac9c-a67e6c124aee	d532c50a-26f4-4491-bcb3-e8fe9bb5105d	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-01-24	f
37455b09-d5c4-4f9b-9f80-8cd39720cb33	2026-03-29 08:58:48.949587+00	bf589032-8b02-42cb-9f13-17c84cd4a7e6	97a3f8b8-caff-4988-b24a-2b7e54d155ee	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
cf3cb1a8-f382-4af9-be84-ae009f6a97fa	2026-03-27 15:24:39.326754+00	56b0d021-a032-4fd8-8b64-b129fc01022d	8dab5312-dbee-4f86-83dd-0874ffc99c46	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
f377c8d4-3c03-4dcd-a4d3-1b5e3893f5ee	2026-03-31 13:26:27.816544+00	54888d72-6043-4268-99c5-a27194874ddf	19dfcd2c-5aaf-4e09-ac63-9856393cfb3c	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
9466cf7f-3396-4465-9ecf-e21fc303f6d6	2026-03-31 17:22:13.86121+00	f7cfa1e9-8345-46db-832d-a470747f1fca	3cbd32b1-84a7-4596-92d0-903d6ea1f631	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
0f23917a-81ab-4f4e-a246-0210ef189c4a	2026-04-01 12:50:14.521584+00	cba5eb52-034b-40dc-8faa-d623420d7a53	080111ef-d8d7-4662-ba20-cd5ff1bfa389	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
9c7d6691-e371-4edf-9026-078f20860899	2026-04-02 09:24:56.29582+00	6b63bbe9-b509-4424-9377-6b1b6d9e0ca7	aaedc900-37ff-4b01-88cb-82c36deffca8	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
41e7f04e-68ae-4235-b903-197a038556c3	2026-04-02 10:40:25.548317+00	a6b9e5ca-a51d-4783-b694-714f34b697ea	893bb307-08a3-4af2-ba54-6c5da32206ad	835b104d-b18b-4876-ba72-ffea56c43563	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
ab22dd20-2ba2-476c-a743-28626f311a27	2026-04-02 10:40:26.080264+00	a6b9e5ca-a51d-4783-b694-714f34b697ea	3cbd32b1-84a7-4596-92d0-903d6ea1f631	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
f08bf85d-1b3c-4841-99a6-d0d981251d7c	2026-03-16 12:19:13.059885+00	5a4c855f-a5f6-4a9d-8df6-4a7652e0aded	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d664bd0c-e3b9-4282-ae38-0dc1115f7872	2026-03-16 12:19:12.543414+00	e1152792-c321-4a78-ae79-d40328c02cef	9aa72019-ede1-4b37-a63b-400a20a683a7	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d0871477-9fd7-451f-bc30-cd0cdce302b6	2026-03-16 12:19:12.543414+00	e1152792-c321-4a78-ae79-d40328c02cef	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
3f1a8047-4e9c-4957-be9a-f2e19805fce1	2026-03-16 12:19:14.143183+00	d45da5ae-adc3-49d3-b1e1-10487adabf4a	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
03be607e-d73b-4e1a-811d-81a6503f2529	2026-03-16 12:19:12.543414+00	e1152792-c321-4a78-ae79-d40328c02cef	7dd68452-30ed-4829-857d-bebc61aff9c1	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5ebf3996-e59c-4671-a234-e55200d04d06	2026-03-16 12:19:13.059885+00	5a4c855f-a5f6-4a9d-8df6-4a7652e0aded	13e202ee-272d-415f-8d66-f7669b85afb8	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
cbd68107-8359-4d97-9ab7-aff6aa5e035b	2026-03-16 12:19:13.059885+00	5a4c855f-a5f6-4a9d-8df6-4a7652e0aded	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
28a40f07-8baa-4f4d-81c1-6bb232322bf9	2026-03-16 12:19:13.059885+00	5a4c855f-a5f6-4a9d-8df6-4a7652e0aded	2d98b2aa-9762-4798-8e28-fcb15c380bf5	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
158270e2-5b63-4673-9734-415623d42e71	2026-03-16 12:19:13.059885+00	5a4c855f-a5f6-4a9d-8df6-4a7652e0aded	6c379005-03bc-478f-aabd-ad3f75f6477a	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
483583e9-e5c3-42ef-938e-a23b8efe0f4f	2026-03-16 12:19:13.059885+00	5a4c855f-a5f6-4a9d-8df6-4a7652e0aded	97a3f8b8-caff-4988-b24a-2b7e54d155ee	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1e43942a-a09e-49a6-9660-614a530eecee	2026-03-16 12:19:12.543414+00	e1152792-c321-4a78-ae79-d40328c02cef	1c9e7097-df1c-4540-b79b-35055f8f080f	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
625edc97-6bc6-4999-963a-d8db6060a78a	2026-03-16 12:19:14.143183+00	d45da5ae-adc3-49d3-b1e1-10487adabf4a	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
62fc27c0-4759-47b2-8b42-47c5b33fcd02	2026-03-16 12:19:13.585231+00	251a8ed4-80cf-4fad-8e03-63f60917d1c1	7e7447f5-56a1-4513-9606-978058d389d5	b6d87440-e59a-402a-81f1-4d996a9a9300	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d19afce7-013c-42d6-a4b6-052266911f77	2026-03-16 12:19:13.585231+00	251a8ed4-80cf-4fad-8e03-63f60917d1c1	33600627-aea8-4768-8be4-eadb5152e41f	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
97478265-0526-4217-b98f-6a2509c27c27	2026-03-17 10:51:35.851079+00	cf880d3b-3b63-4120-9e70-a83be892b0d1	\N	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Yasmine	\N	f	\N	\N	\N	f
c5de6dc8-6490-459e-a2c3-6ce3c5c030ac	2026-03-17 10:51:36.108583+00	cf880d3b-3b63-4120-9e70-a83be892b0d1	\N	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Mélanie SYSSAU	\N	f	\N	\N	\N	f
b096d4f1-a2f1-4f51-b13f-f2d63234da92	2026-03-17 10:51:36.366046+00	cf880d3b-3b63-4120-9e70-a83be892b0d1	\N	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Kahina BEZAOU	\N	f	\N	\N	\N	f
b1227e64-61f5-4da7-afd9-166f58b26159	2026-03-17 10:51:36.640303+00	cf880d3b-3b63-4120-9e70-a83be892b0d1	\N	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Pauline CHETAIL SYSSAU	\N	f	\N	\N	\N	f
b8fa6a9c-a92e-4ed0-ae20-e5dec55d078a	2026-03-16 12:19:13.585231+00	251a8ed4-80cf-4fad-8e03-63f60917d1c1	ceb5bad4-3051-4086-ac9c-a67e6c124aee	d532c50a-26f4-4491-bcb3-e8fe9bb5105d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6678d691-9b2e-4eba-9a53-f01c97d37146	2026-03-16 12:19:14.143183+00	d45da5ae-adc3-49d3-b1e1-10487adabf4a	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
374a94f2-cbc9-4c5b-85fb-f9a5654d7a9d	2026-03-20 14:24:48.976806+00	d50c78c2-032b-4101-bf1e-f3e9b7718ad1	9c87739b-74ad-47b9-a70f-6efc26c93f00	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
67ade98b-44cd-428b-95b3-c895e4c53074	2026-03-20 14:24:48.976806+00	d50c78c2-032b-4101-bf1e-f3e9b7718ad1	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
afc8005f-0a1c-47f0-b037-a0f7547317e7	2026-03-20 14:24:48.976806+00	d50c78c2-032b-4101-bf1e-f3e9b7718ad1	ce4184ad-5144-4b9b-8276-0111197e0885	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
cd1e454d-94ab-4efc-9d0e-b07fcc2b8c05	2026-03-20 14:24:49.59234+00	5bd1052c-82ae-46f8-a706-c12c8a46f85f	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0231e3dc-6303-4925-a109-e58e6bcde3c6	2026-03-20 14:24:49.59234+00	5bd1052c-82ae-46f8-a706-c12c8a46f85f	9aa72019-ede1-4b37-a63b-400a20a683a7	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e5581db7-a77c-4cf0-af40-f646f24a6422	2026-03-20 14:24:48.976806+00	d50c78c2-032b-4101-bf1e-f3e9b7718ad1	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2f4fe4df-f07c-4850-8e3f-96e551eb323e	2026-03-20 14:24:49.59234+00	5bd1052c-82ae-46f8-a706-c12c8a46f85f	1c9e7097-df1c-4540-b79b-35055f8f080f	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a8677c40-0249-4bc3-a2da-2baf634c02a1	2026-03-20 14:24:49.59234+00	5bd1052c-82ae-46f8-a706-c12c8a46f85f	7dd68452-30ed-4829-857d-bebc61aff9c1	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b7fec796-4392-4c41-a147-6dc20e572674	2026-03-20 14:24:50.147211+00	2ef4436e-dad9-491c-aad8-35cc84ecdca4	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9965ec51-a4af-42c1-86d5-d668a2a1e080	2026-03-20 14:24:50.147211+00	2ef4436e-dad9-491c-aad8-35cc84ecdca4	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
bb20326b-580d-4a21-8f8a-a8c79318cff8	2026-03-20 14:24:50.147211+00	2ef4436e-dad9-491c-aad8-35cc84ecdca4	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
de3970cb-d227-4045-9953-78f36ab8bcf7	2026-03-20 14:24:50.147211+00	2ef4436e-dad9-491c-aad8-35cc84ecdca4	6c379005-03bc-478f-aabd-ad3f75f6477a	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
3fe933ec-3b7a-45f5-bcd2-49e4be04eabc	2026-03-20 14:24:50.147211+00	2ef4436e-dad9-491c-aad8-35cc84ecdca4	2d98b2aa-9762-4798-8e28-fcb15c380bf5	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2c6c6b2b-369f-4bfc-9fe0-f1d8338b4dfe	2026-03-20 14:24:50.147211+00	2ef4436e-dad9-491c-aad8-35cc84ecdca4	97a3f8b8-caff-4988-b24a-2b7e54d155ee	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a0b71d69-2f26-496e-ac7c-8b3e6e6e2d95	2026-03-27 16:00:23.523722+00	f0d233e4-061e-4088-bc3d-0f8d30df0ea4	aaedc900-37ff-4b01-88cb-82c36deffca8	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
9761e10c-d285-4eeb-9dfe-3fba0a02b706	2026-03-24 09:33:01.940697+00	50a9aa4f-16ab-4dc3-bba7-5789b72e6504	\N	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Cassandre ALLANCHE	50.00	t	Virement	2025-09-17	\N	f
37f992ae-e187-4fea-95ac-3f2e0fdcdc14	2026-03-24 08:19:41.75811+00	23351651-d1d7-4c32-be83-2a2ec568f7d8	\N	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Cassandre ALLANCHE	50.00	t	Chèque	2025-09-03	\N	f
c87efa16-140d-4745-a56e-2e5c0eee2fe4	2026-03-24 17:28:39.219662+00	273777e2-b113-4184-8e98-cd147a948004	ed3a44cb-388f-431a-bf56-2d35af78ea8a	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
3a593003-7a95-4ab2-935c-0f69c3a9fa25	2026-04-24 08:37:29.097799+00	d45da5ae-adc3-49d3-b1e1-10487adabf4a	7c879cb9-b214-4851-9fb7-cd84b0698bb7	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-03-04	f
909a916a-073f-4205-85fd-240a19ee37b7	2026-03-27 15:24:45.94639+00	c2af00a3-32f2-4c63-a1c1-955471e939f4	3cbd32b1-84a7-4596-92d0-903d6ea1f631	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
131b70ab-7eba-4753-be9d-6d746bc51b0f	2026-03-29 08:58:50.022619+00	230391cb-f41c-4520-998d-0a04dae98e88	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
27147b78-c359-4c81-a3bb-7a7ce65f8285	2026-03-29 08:58:50.022619+00	230391cb-f41c-4520-998d-0a04dae98e88	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e0a519a1-67d0-425c-af57-273eb7ec601a	2026-03-31 13:30:33.837587+00	fa0274f2-55e2-424a-be15-f8f050991b0e	893bb307-08a3-4af2-ba54-6c5da32206ad	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
3a0284c4-8585-4b14-9450-5029894effee	2026-03-31 17:22:14.361612+00	f7cfa1e9-8345-46db-832d-a470747f1fca	080111ef-d8d7-4662-ba20-cd5ff1bfa389	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
13d14c38-6f71-43ee-a521-78609743cefe	2026-04-25 05:02:22.014604+00	e97e4a9d-eb65-472f-ac6f-4572841a2e02	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b151cffc-858d-4188-8f9b-ddef81cf3122	2026-03-24 17:27:31.640779+00	1de1c71c-97a6-4a19-9b53-8e5c15114e5f	ceb5bad4-3051-4086-ac9c-a67e6c124aee	b6d87440-e59a-402a-81f1-4d996a9a9300	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-03-21	f
950bfebe-0dc2-4e37-8e6b-fdaa2ab973be	2026-04-01 15:47:24.745575+00	d4d3b5ac-e99f-46de-a0cf-aa1fe4177d74	\N	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Clémence	\N	f	\N	\N	\N	f
92f954c8-e137-4def-86f7-684e9a1665dc	2026-04-02 09:24:56.82388+00	6b63bbe9-b509-4424-9377-6b1b6d9e0ca7	322417b3-f05a-488c-b3b6-8956e7e4413a	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
4b302ab5-0481-4c9c-960a-35a7316a51ae	2026-04-02 10:40:26.551385+00	a6b9e5ca-a51d-4783-b694-714f34b697ea	080111ef-d8d7-4662-ba20-cd5ff1bfa389	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
0a2122ca-10a3-46fb-8bfe-d466b602d5b0	2026-04-02 10:40:27.048666+00	a6b9e5ca-a51d-4783-b694-714f34b697ea	322417b3-f05a-488c-b3b6-8956e7e4413a	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
5a080497-0e9e-40b0-a583-aee72ae9276c	2026-04-03 17:34:35.386012+00	c9cc8969-baa9-4708-89a7-ca489ca526c4	9c87739b-74ad-47b9-a70f-6efc26c93f00	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
fc8b419b-a7b3-4bc4-a84e-c3a96f230c00	2026-04-03 17:34:35.386012+00	c9cc8969-baa9-4708-89a7-ca489ca526c4	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a3200821-0b00-4f91-b735-a3448e9a0df8	2026-04-03 17:34:35.386012+00	c9cc8969-baa9-4708-89a7-ca489ca526c4	ce4184ad-5144-4b9b-8276-0111197e0885	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
428a53f7-ca20-4264-9818-372dd4584b54	2026-04-03 17:34:35.386012+00	c9cc8969-baa9-4708-89a7-ca489ca526c4	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ed4351cc-c546-45a1-adb0-c57c25f6b78e	2026-04-03 17:34:35.895663+00	c8790fc9-0b35-44e1-a196-f3b8e9f1d0de	9aa72019-ede1-4b37-a63b-400a20a683a7	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
bdaa78d5-70c6-4bde-ae13-2a3c9129f019	2026-04-03 17:34:35.895663+00	c8790fc9-0b35-44e1-a196-f3b8e9f1d0de	01fdbddd-ee76-4200-a153-47cc61d67398	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f4c0df28-301a-4ad0-945a-2a9eecbfeac2	2026-04-03 17:34:35.895663+00	c8790fc9-0b35-44e1-a196-f3b8e9f1d0de	7dd68452-30ed-4829-857d-bebc61aff9c1	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8861df58-5b1f-4b32-ac26-92de143592ef	2026-04-03 17:34:35.895663+00	c8790fc9-0b35-44e1-a196-f3b8e9f1d0de	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
46191e6c-3693-4153-90f7-fd2284c144d2	2026-04-03 17:34:36.410285+00	a0c4a5e4-4555-4c13-ac80-06f363ec880c	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7a1092ed-9b22-409b-984e-a1bae160707c	2026-04-03 17:34:36.410285+00	a0c4a5e4-4555-4c13-ac80-06f363ec880c	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
80ea7c18-4779-4256-a4a2-a7267d1c5599	2026-04-03 17:34:36.410285+00	a0c4a5e4-4555-4c13-ac80-06f363ec880c	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1890d3c4-2f6d-4134-8644-f7f69396a6a6	2026-04-03 17:34:36.410285+00	a0c4a5e4-4555-4c13-ac80-06f363ec880c	13e202ee-272d-415f-8d66-f7669b85afb8	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
06a44f6d-b714-49e5-9bcc-96a154bf21c4	2026-04-03 17:34:36.410285+00	a0c4a5e4-4555-4c13-ac80-06f363ec880c	6c379005-03bc-478f-aabd-ad3f75f6477a	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0f78de48-4e3e-481e-b94e-eb782e60934e	2026-04-03 17:34:36.410285+00	a0c4a5e4-4555-4c13-ac80-06f363ec880c	2d98b2aa-9762-4798-8e28-fcb15c380bf5	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
92e502e5-d5ec-460f-9c79-f86bbd15868c	2026-04-03 17:34:36.941053+00	309829a0-882a-488a-8769-2dc3d406e6ce	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
47aef87b-956b-4b5b-a62b-9378862abb90	2026-04-03 17:34:36.941053+00	309829a0-882a-488a-8769-2dc3d406e6ce	ceb5bad4-3051-4086-ac9c-a67e6c124aee	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
37240950-90ce-4773-a758-3494d3864ec3	2026-04-03 17:34:36.941053+00	309829a0-882a-488a-8769-2dc3d406e6ce	33600627-aea8-4768-8be4-eadb5152e41f	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
76c58cad-a2e9-4257-b6f9-be06ce62e14a	2026-04-03 17:34:36.941053+00	309829a0-882a-488a-8769-2dc3d406e6ce	8b6e4db3-9332-457c-8e1a-ad88af0c40be	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b981b538-aab8-4d23-b06d-8589ca50c3ec	2026-04-03 17:34:36.941053+00	309829a0-882a-488a-8769-2dc3d406e6ce	ddbca8c2-9bfd-4ab2-90d1-8c8127be9331	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1d31a955-915a-417a-8b63-1b96091e7c41	2026-04-03 17:34:37.460029+00	032d7dc8-689b-4a61-b278-29be8bbda84a	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
48a0ff0f-3921-482c-a004-9b3fc1660509	2026-04-03 17:34:37.460029+00	032d7dc8-689b-4a61-b278-29be8bbda84a	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
be9762db-3a73-4373-b156-177b682986f2	2026-04-03 17:34:37.460029+00	032d7dc8-689b-4a61-b278-29be8bbda84a	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b73dd9ef-341b-4068-9fc5-28f7ee6102e7	2026-04-03 17:34:36.941053+00	309829a0-882a-488a-8769-2dc3d406e6ce	7e7447f5-56a1-4513-9606-978058d389d5	\N	t	WA20260308. 10:50	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
db4b55f6-7b26-42e2-bd9a-c42f16b6e52e	2026-04-03 18:03:21.503962+00	f67bbea7-6b82-4f66-a99e-a40559dd54de	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-04-04	f
8f675a7d-91eb-4c38-bba8-1aacd4b051e1	2026-04-04 06:02:36.482935+00	f2e2785b-4254-4382-8901-03f73320dc4d	1c9e7097-df1c-4540-b79b-35055f8f080f	5e250204-ceee-4813-b935-df2600156009	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2025-11-29	f
edb5c792-f2f0-4fda-b5e7-78d4f02db0bc	2026-02-25 09:48:12.981326+00	2a33e3b2-becf-48b8-b1e8-b078ab60023d	1c9e7097-df1c-4540-b79b-35055f8f080f	\N	t	RATTRAPAGE	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
ff3bf22c-a161-4707-b69c-b1ad72faa154	2026-04-25 05:02:22.014604+00	e97e4a9d-eb65-472f-ac6f-4572841a2e02	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
551ccb0b-53d6-4332-a0d6-516e5c35bfc5	2026-04-03 17:34:35.895663+00	c8790fc9-0b35-44e1-a196-f3b8e9f1d0de	1c9e7097-df1c-4540-b79b-35055f8f080f	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
8657f81d-475a-4bc3-9671-cd78b2020412	2026-04-04 06:20:12.06244+00	d50c78c2-032b-4101-bf1e-f3e9b7718ad1	7dd68452-30ed-4829-857d-bebc61aff9c1	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2025-11-22	f
e3279ccf-e198-4239-a98a-4e050777e077	2026-04-05 08:50:03.618849+00	3447bd6b-755e-48df-be3e-81551e4aff05	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	059512a2-d080-480d-b201-84c5179e56ed	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-01-24	f
adb72dcc-2baa-48ac-bea0-15f807d46db8	2026-04-25 05:02:22.014604+00	e97e4a9d-eb65-472f-ac6f-4572841a2e02	13e202ee-272d-415f-8d66-f7669b85afb8	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
30972196-ad82-44c5-af5a-b65292fe71a6	2026-04-25 05:02:22.014604+00	e97e4a9d-eb65-472f-ac6f-4572841a2e02	6c379005-03bc-478f-aabd-ad3f75f6477a	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
12ee3f90-f06d-4ef9-80a9-71917b364960	2026-04-25 05:02:22.014604+00	e97e4a9d-eb65-472f-ac6f-4572841a2e02	2d98b2aa-9762-4798-8e28-fcb15c380bf5	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f704343c-cf3a-4853-bb43-fa5c061dea52	2026-04-25 05:02:22.014604+00	e97e4a9d-eb65-472f-ac6f-4572841a2e02	97a3f8b8-caff-4988-b24a-2b7e54d155ee	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4d5c6b68-e0db-4580-986e-a86e19eab4ba	2026-04-25 05:02:22.468403+00	277536e7-07a3-4402-89a9-9cf39d67335e	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
283c43c9-957b-4c86-adba-1c48ff06e306	2026-04-25 05:02:22.468403+00	277536e7-07a3-4402-89a9-9cf39d67335e	7e7447f5-56a1-4513-9606-978058d389d5	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ecab2101-55d0-493f-8064-f2eeb0aa449f	2026-04-25 05:02:22.468403+00	277536e7-07a3-4402-89a9-9cf39d67335e	ceb5bad4-3051-4086-ac9c-a67e6c124aee	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
94dd77c8-957c-4854-8118-5bafd3e8ec60	2026-04-25 05:02:22.468403+00	277536e7-07a3-4402-89a9-9cf39d67335e	33600627-aea8-4768-8be4-eadb5152e41f	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0bcefdaa-c615-47bf-a4e0-6fdb4787f071	2026-04-25 05:02:22.468403+00	277536e7-07a3-4402-89a9-9cf39d67335e	8b6e4db3-9332-457c-8e1a-ad88af0c40be	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0a4068b3-93a7-4062-a866-52c04b112510	2026-04-25 05:02:22.468403+00	277536e7-07a3-4402-89a9-9cf39d67335e	ddbca8c2-9bfd-4ab2-90d1-8c8127be9331	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
912e36cc-9bf9-4ae5-9995-41fe659c350c	2026-04-25 05:02:22.916266+00	093a770f-ec17-4967-9b0b-c006e0a8a834	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0696a282-898e-4390-823b-356384b42fe8	2026-04-25 05:02:22.916266+00	093a770f-ec17-4967-9b0b-c006e0a8a834	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e2437281-1a4e-4ce4-a0af-f40e8a9329b6	2026-04-25 05:02:22.916266+00	093a770f-ec17-4967-9b0b-c006e0a8a834	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ea5e8acc-3549-4a29-a83e-899a356ca281	2026-04-03 17:34:36.410285+00	a0c4a5e4-4555-4c13-ac80-06f363ec880c	97a3f8b8-caff-4988-b24a-2b7e54d155ee	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
c7a92cb4-c4b6-4cdb-8b00-893f021ebd00	2026-03-20 14:24:50.953637+00	bd42e1ed-fda2-43c6-8f27-93f2b00e8b34	ddbca8c2-9bfd-4ab2-90d1-8c8127be9331	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a5387444-7f77-40c5-925e-cd7dff86b842	2026-03-20 14:24:50.953637+00	bd42e1ed-fda2-43c6-8f27-93f2b00e8b34	7e7447f5-56a1-4513-9606-978058d389d5	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
02853844-4dcf-4408-867f-cf8443526f81	2026-03-20 14:24:50.953637+00	bd42e1ed-fda2-43c6-8f27-93f2b00e8b34	33600627-aea8-4768-8be4-eadb5152e41f	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8e033194-9ef7-4949-90d4-2e1887a2e21c	2026-03-27 16:00:24.403121+00	f0d233e4-061e-4088-bc3d-0f8d30df0ea4	8a158331-8983-4d93-8d27-616394540f3d	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
afbc4567-6e47-4580-b50a-4658f95de6cc	2026-03-27 16:00:24.934366+00	f0d233e4-061e-4088-bc3d-0f8d30df0ea4	322417b3-f05a-488c-b3b6-8956e7e4413a	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
7fa33a4e-a21f-418d-a2c5-2578c2c2b6c5	2026-03-24 10:07:43.284224+00	3c10efdb-4333-41ba-bba2-d456a8c61c5b	\N	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Cassandre ALLANCHE	50.00	t	Virement	2025-09-24	\N	f
ed95ba88-e7e0-40bf-957d-3cf250413493	2026-03-20 14:24:51.544073+00	3a983f94-c153-422c-88fb-f799cbbd2073	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	\N	t	\N	f	2026-04-01	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
a3d0e3e8-d620-474f-8c13-a5620d4fc7ba	2026-03-20 18:26:38.565784+00	880e381f-e9c9-4ffa-ae24-0fd9c2735e11	ceb5bad4-3051-4086-ac9c-a67e6c124aee	\N	t	\N	f	2026-04-22	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
e21ec511-932b-4a57-977d-4d506c4b730a	2026-03-20 14:24:50.953637+00	bd42e1ed-fda2-43c6-8f27-93f2b00e8b34	ceb5bad4-3051-4086-ac9c-a67e6c124aee	\N	t	\N	f	2026-04-01	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
10e5b08e-d70a-4157-8023-f2d222b92426	2026-03-20 14:24:50.953637+00	bd42e1ed-fda2-43c6-8f27-93f2b00e8b34	8b6e4db3-9332-457c-8e1a-ad88af0c40be	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
74662413-ab86-48c2-9c34-fb95f92f4bd7	2026-03-27 16:00:25.443927+00	f0d233e4-061e-4088-bc3d-0f8d30df0ea4	7fb3adc8-4473-43a4-84a8-c76a60e2665f	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
f14df7cf-9d71-4335-a7a7-a100b9d3d3ec	2026-03-20 18:26:37.544145+00	332cfdb6-53cf-495b-8436-fea3bcf76670	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
bf934e2d-a01f-4c38-8fa2-9bd1a060916a	2026-03-24 17:28:38.190206+00	c8fc849e-53d4-44cc-9074-07ec087875da	9430b606-42b0-45c9-aca3-c56c6d23d11b	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b6f91863-22f7-4ed9-9ef3-43fa427b200f	2026-03-20 18:26:37.544145+00	332cfdb6-53cf-495b-8436-fea3bcf76670	9aa72019-ede1-4b37-a63b-400a20a683a7	\N	t	\N	f	2026-03-21	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
74b2dc26-6b7f-44cf-b6c4-46fe2db323cd	2026-03-20 14:24:49.59234+00	5bd1052c-82ae-46f8-a706-c12c8a46f85f	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
56a9fc63-4716-4fe8-8ce7-528662890079	2026-03-20 18:26:36.826888+00	74914a88-5ef1-446f-80d4-7a87209eeaec	ce4184ad-5144-4b9b-8276-0111197e0885	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a9c66920-2809-41f5-8551-bce0826b2f6e	2026-03-20 18:26:36.826888+00	74914a88-5ef1-446f-80d4-7a87209eeaec	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	\N	t	🅰️	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9be37015-ed69-470d-bcf3-430eec1bb39a	2026-03-20 17:59:52.352155+00	d50c78c2-032b-4101-bf1e-f3e9b7718ad1	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-03-14	f
08d383df-7869-4cdf-a5da-2522a325f927	2026-03-20 14:24:51.544073+00	3a983f94-c153-422c-88fb-f799cbbd2073	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
aa53e1ed-9644-4894-8c5f-b62827946d26	2026-03-29 09:30:01.993717+00	87618f27-0efc-4904-bce7-e6fc6e7afcdb	8b6e4db3-9332-457c-8e1a-ad88af0c40be	c48c89f9-082b-4835-9a9f-e3ee05ed3476	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2dffb49f-48a2-4f23-8568-9600c852990b	2026-03-20 14:24:50.147211+00	2ef4436e-dad9-491c-aad8-35cc84ecdca4	13e202ee-272d-415f-8d66-f7669b85afb8	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a1140a9a-450d-47f4-80c9-3bf7836bbb63	2026-03-29 09:30:01.254208+00	8533848b-f6f9-440b-800f-59780e56d718	8b6e4db3-9332-457c-8e1a-ad88af0c40be	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8cc1dab2-b484-43c8-8fad-42c7550aad63	2026-03-20 18:26:36.826888+00	74914a88-5ef1-446f-80d4-7a87209eeaec	9c87739b-74ad-47b9-a70f-6efc26c93f00	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
307dd593-5612-4889-9308-a7aa7bf5226f	2026-03-20 18:26:37.544145+00	332cfdb6-53cf-495b-8436-fea3bcf76670	7dd68452-30ed-4829-857d-bebc61aff9c1	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
147043b5-de6f-4cdc-8713-6d7b8f4fe37e	2026-03-20 18:26:36.826888+00	74914a88-5ef1-446f-80d4-7a87209eeaec	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
abc0a529-03a6-45e7-8772-baa7734682e0	2026-03-20 18:26:38.053325+00	482be4a2-d367-4cac-9a56-91ee714fe333	13e202ee-272d-415f-8d66-f7669b85afb8	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c2f3cb46-242a-4ea7-87eb-df068974d3a2	2026-03-20 18:26:38.053325+00	482be4a2-d367-4cac-9a56-91ee714fe333	2d98b2aa-9762-4798-8e28-fcb15c380bf5	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
61ea6005-1cf4-4184-bf15-157207b608ab	2026-03-20 18:26:38.053325+00	482be4a2-d367-4cac-9a56-91ee714fe333	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8d055c8a-1702-4e1a-9db5-ef71678a16a7	2026-03-20 18:26:39.082903+00	fa3ac3fb-9253-40d9-b58e-5267ae4e6c40	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
b2cbd411-3d2c-4ff0-8caf-51d5e1b253b3	2026-03-20 18:26:39.082903+00	fa3ac3fb-9253-40d9-b58e-5267ae4e6c40	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
20cedb97-afb7-4f82-b94c-e9d4e20fb9e0	2026-03-20 18:26:39.082903+00	fa3ac3fb-9253-40d9-b58e-5267ae4e6c40	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
375749ca-fd0e-4d04-8672-7bbf4bef56f5	2026-03-20 18:26:37.544145+00	332cfdb6-53cf-495b-8436-fea3bcf76670	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f77d5729-1097-4fc1-bc62-e4a8f6b8fb89	2026-03-20 18:26:38.053325+00	482be4a2-d367-4cac-9a56-91ee714fe333	97a3f8b8-caff-4988-b24a-2b7e54d155ee	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7c4b8cfa-4c17-4a55-b037-d3778bc824c1	2026-03-20 18:26:38.053325+00	482be4a2-d367-4cac-9a56-91ee714fe333	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ae74ab64-68ec-4d72-a8c9-e73b1e3e4f21	2026-03-20 18:26:38.053325+00	482be4a2-d367-4cac-9a56-91ee714fe333	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
91f632f9-1fc9-42e8-9660-ba285652faeb	2026-03-20 18:26:38.565784+00	880e381f-e9c9-4ffa-ae24-0fd9c2735e11	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
76833791-8327-47dc-a878-038274edc19e	2026-03-20 18:26:38.053325+00	482be4a2-d367-4cac-9a56-91ee714fe333	6c379005-03bc-478f-aabd-ad3f75f6477a	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b4c6f2f2-612d-4cca-9f44-f97527be5dc5	2026-03-20 18:26:38.565784+00	880e381f-e9c9-4ffa-ae24-0fd9c2735e11	8b6e4db3-9332-457c-8e1a-ad88af0c40be	\N	t	ANR ⛔️ WA20260328. 12:45	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
207bdbaa-1bb6-4866-b20b-aaaea20335ff	2026-03-20 18:26:38.565784+00	880e381f-e9c9-4ffa-ae24-0fd9c2735e11	ddbca8c2-9bfd-4ab2-90d1-8c8127be9331	\N	t	1s/2. Paires.	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0f25ad34-24a1-4e0f-8ce8-25d08c702698	2026-03-20 14:24:50.953637+00	bd42e1ed-fda2-43c6-8f27-93f2b00e8b34	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	\N	t	ANR. SMS 20260321. 11:58.	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2d8f144c-fa65-4bc9-abe5-b2b3453482d4	2026-03-20 18:26:38.565784+00	880e381f-e9c9-4ffa-ae24-0fd9c2735e11	7e7447f5-56a1-4513-9606-978058d389d5	b6d87440-e59a-402a-81f1-4d996a9a9300	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
27d8bd1a-ebde-4d91-b876-8fd9fad02024	2026-03-20 18:26:38.565784+00	880e381f-e9c9-4ffa-ae24-0fd9c2735e11	33600627-aea8-4768-8be4-eadb5152e41f	d532c50a-26f4-4491-bcb3-e8fe9bb5105d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4e04e756-bebc-4a94-8259-e2f78e522a5c	2026-03-31 13:30:34.121995+00	fa0274f2-55e2-424a-be15-f8f050991b0e	3cbd32b1-84a7-4596-92d0-903d6ea1f631	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
75a631a1-978d-4af3-9635-2fdcf725242d	2026-03-20 18:26:37.544145+00	332cfdb6-53cf-495b-8436-fea3bcf76670	1c9e7097-df1c-4540-b79b-35055f8f080f	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
cf54fd85-8e58-455b-abc6-16dd1b3371e0	2026-03-24 17:28:38.704271+00	1c11e732-ee21-48bf-ae67-f1d17a201f74	f6b2c3bc-2197-44c1-a848-d18a66e3fdf5	03331a64-cbca-4ae6-b260-80308e787efc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
52144ddc-afb3-4c67-840f-28f81c1a4b75	2026-03-24 17:28:38.190206+00	c8fc849e-53d4-44cc-9074-07ec087875da	86c197e6-24db-4d82-8572-d86b5ca15b2f	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d3d33fc0-b8a5-4fee-8198-3cd7bb9d88a0	2026-03-24 17:28:38.190206+00	c8fc849e-53d4-44cc-9074-07ec087875da	a3f3ccb1-7c00-4b52-9837-dc69331b521c	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5daf6ad2-5297-4286-8c71-cdc93b96bd31	2026-03-24 17:28:38.704271+00	1c11e732-ee21-48bf-ae67-f1d17a201f74	7c879cb9-b214-4851-9fb7-cd84b0698bb7	c48c89f9-082b-4835-9a9f-e3ee05ed3476	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
3788dfd5-911e-422d-b9fa-e399185a1b65	2026-03-24 17:28:38.190206+00	c8fc849e-53d4-44cc-9074-07ec087875da	00ef1cb1-a558-407b-8798-c0db3f382cb8	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f5ec1d65-721d-4b26-96a8-36df6059ecb9	2026-03-24 17:28:38.704271+00	1c11e732-ee21-48bf-ae67-f1d17a201f74	b0054d27-f377-41ad-a026-a2893c27692a	682763a9-a5bb-4985-aa6e-83bd5f935b2a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
eb7b4fb8-ec15-44e0-b3df-c91649fec0a5	2026-03-24 17:28:39.219662+00	273777e2-b113-4184-8e98-cd147a948004	70610b82-10ea-46b2-a99b-59c187db69da	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d252bbd8-d6e1-43f4-bbcd-e2a28556fc86	2026-03-24 17:28:38.704271+00	1c11e732-ee21-48bf-ae67-f1d17a201f74	1d2c9275-719e-452b-9298-ec476ac53155	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
32f5dae3-e907-4a79-9cce-be0407385c8f	2026-03-27 16:01:58.246102+00	cbf19fc6-413d-41ce-bdbe-95aa6f03657a	893bb307-08a3-4af2-ba54-6c5da32206ad	76876dd9-f4c0-455c-9b22-08799cc72af0	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
462791b6-8670-4b89-b865-e24478d4e556	2026-03-27 16:01:58.999219+00	cbf19fc6-413d-41ce-bdbe-95aa6f03657a	8dab5312-dbee-4f86-83dd-0874ffc99c46	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
ced44636-ed85-4f40-9e79-22f3b826ff99	2026-03-27 16:01:59.693759+00	cbf19fc6-413d-41ce-bdbe-95aa6f03657a	aaedc900-37ff-4b01-88cb-82c36deffca8	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
218af199-931c-4e03-9103-c8e988ea3db5	2026-03-27 16:02:00.329267+00	cbf19fc6-413d-41ce-bdbe-95aa6f03657a	8a158331-8983-4d93-8d27-616394540f3d	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
8fbd2e20-98d1-4c82-943f-e3373d6e3d96	2026-03-29 09:30:02.957881+00	8533848b-f6f9-440b-800f-59780e56d718	ddbca8c2-9bfd-4ab2-90d1-8c8127be9331	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6c31665f-84d6-4058-8979-25510289b11b	2026-03-31 13:30:34.409668+00	fa0274f2-55e2-424a-be15-f8f050991b0e	aaedc900-37ff-4b01-88cb-82c36deffca8	c6bc37d8-7c43-4ae3-9c95-4f6488a42f09	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
05abf122-59ad-4f4d-9042-dd50937f5cff	2026-03-31 17:27:06.599923+00	02fd8130-b58b-4132-b3ee-8de854c3c212	8dab5312-dbee-4f86-83dd-0874ffc99c46	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
a3a95b6e-fbd2-4688-9897-e09bf7bf90a9	2026-03-31 17:27:08.969012+00	02fd8130-b58b-4132-b3ee-8de854c3c212	f056b2e2-8510-45d1-b81a-a1d06ab18dd1	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
92099537-568c-47cd-99a0-0ea018b56bd6	2026-04-01 16:53:17.523943+00	bc36503e-6ca8-4345-b7e7-e8eb0e8c553b	893bb307-08a3-4af2-ba54-6c5da32206ad	835b104d-b18b-4876-ba72-ffea56c43563	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
5622eb68-79a4-4d53-88ba-e25e39022fc1	2026-04-01 16:53:18.303048+00	bc36503e-6ca8-4345-b7e7-e8eb0e8c553b	322417b3-f05a-488c-b3b6-8956e7e4413a	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
11bfe03e-6010-4f08-beb5-0b3d4cdf9778	2026-04-01 16:53:18.848508+00	bc36503e-6ca8-4345-b7e7-e8eb0e8c553b	19dfcd2c-5aaf-4e09-ac63-9856393cfb3c	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
8ad5add6-e0e9-4fbf-bc04-dcd64595f267	2026-04-01 16:53:19.377083+00	bc36503e-6ca8-4345-b7e7-e8eb0e8c553b	8a158331-8983-4d93-8d27-616394540f3d	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
a6742d67-3015-4e18-9e8c-81ee3362e66c	2026-04-01 16:53:19.888599+00	bc36503e-6ca8-4345-b7e7-e8eb0e8c553b	aaedc900-37ff-4b01-88cb-82c36deffca8	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
05ddcde6-a517-4af8-a6f6-cbf39044e64e	2026-04-01 16:53:20.436305+00	bc36503e-6ca8-4345-b7e7-e8eb0e8c553b	466a4031-fc42-48c9-88c5-1a1925e19912	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
86850ed1-50f2-4df9-b64d-6fff6eca6870	2026-04-02 09:24:57.34874+00	6b63bbe9-b509-4424-9377-6b1b6d9e0ca7	8dab5312-dbee-4f86-83dd-0874ffc99c46	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
6e64d351-1e68-4a43-a533-8d6fe1bfe471	2026-04-02 10:41:35.197657+00	9fe9a90c-9c86-4b08-8257-70228926c0f1	19dfcd2c-5aaf-4e09-ac63-9856393cfb3c	d532c50a-26f4-4491-bcb3-e8fe9bb5105d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
fc56cb79-7ced-4d27-9632-8d0637b40f07	2026-04-02 10:41:35.704374+00	9fe9a90c-9c86-4b08-8257-70228926c0f1	8dab5312-dbee-4f86-83dd-0874ffc99c46	c48c89f9-082b-4835-9a9f-e3ee05ed3476	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
10e89358-ba7e-4d72-aae2-abc5294203af	2026-04-02 10:41:36.196914+00	9fe9a90c-9c86-4b08-8257-70228926c0f1	7fb3adc8-4473-43a4-84a8-c76a60e2665f	b6d87440-e59a-402a-81f1-4d996a9a9300	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
62194a80-a6a7-4cc5-afc3-f078207bd194	2026-03-29 09:30:03.672808+00	87618f27-0efc-4904-bce7-e6fc6e7afcdb	ddbca8c2-9bfd-4ab2-90d1-8c8127be9331	d532c50a-26f4-4491-bcb3-e8fe9bb5105d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
37594bc8-9eb4-41b9-baf6-1db124af4f44	2026-04-03 17:38:29.92953+00	8b30c4cb-5033-4226-9b1a-c85c05fdccb6	9c87739b-74ad-47b9-a70f-6efc26c93f00	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
33a2eeb2-7743-4f1b-aa3d-0449198a2330	2026-03-27 15:24:46.476738+00	c2af00a3-32f2-4c63-a1c1-955471e939f4	080111ef-d8d7-4662-ba20-cd5ff1bfa389	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
6f79084f-1c92-44bc-b04a-c1e40aa1cf39	2026-03-27 15:25:21.983661+00	77471b49-c614-41d6-8dfe-2e5b1f6cc28d	322417b3-f05a-488c-b3b6-8956e7e4413a	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
c26a2bae-6515-40ff-b469-bedb2eef356d	2026-04-03 17:38:29.92953+00	8b30c4cb-5033-4226-9b1a-c85c05fdccb6	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
22f695de-b72a-40c4-b25d-0b54f2729834	2026-04-03 17:38:29.92953+00	8b30c4cb-5033-4226-9b1a-c85c05fdccb6	ce4184ad-5144-4b9b-8276-0111197e0885	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
fd21f6ce-9405-4ca1-a08d-c6204988fa66	2026-04-03 17:38:29.92953+00	8b30c4cb-5033-4226-9b1a-c85c05fdccb6	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
df863451-43d2-4530-8f2e-67455ae2f840	2026-04-03 17:38:30.458175+00	910ff1f2-8a1c-400f-973f-245b3f3ff740	9aa72019-ede1-4b37-a63b-400a20a683a7	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e6e8f5a8-b3c0-47c7-bf49-9406eb789069	2026-04-03 17:38:30.458175+00	910ff1f2-8a1c-400f-973f-245b3f3ff740	01fdbddd-ee76-4200-a153-47cc61d67398	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
424c51ef-a1a1-4bda-8c06-d9e57c66d936	2026-04-03 17:38:30.458175+00	910ff1f2-8a1c-400f-973f-245b3f3ff740	1c9e7097-df1c-4540-b79b-35055f8f080f	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f0c70264-3249-4c51-ac66-76e0c53aec74	2026-04-03 17:38:30.458175+00	910ff1f2-8a1c-400f-973f-245b3f3ff740	7dd68452-30ed-4829-857d-bebc61aff9c1	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
aae88f6d-022f-4ad6-9a6e-16efbeffd706	2026-04-03 17:38:30.458175+00	910ff1f2-8a1c-400f-973f-245b3f3ff740	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e060eaee-0972-4756-9e20-37163edff671	2026-04-03 17:38:30.982485+00	6ac5e4e0-740d-4e05-8458-5a9a00bfff17	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e8ffee09-582b-423d-afec-6be7951339c2	2026-04-03 17:38:30.982485+00	6ac5e4e0-740d-4e05-8458-5a9a00bfff17	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
76885599-4830-4598-95ea-a08b66d5e028	2026-04-03 17:38:30.982485+00	6ac5e4e0-740d-4e05-8458-5a9a00bfff17	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
33944f04-ee97-4928-9037-3033c83bc6ab	2026-04-03 17:38:30.982485+00	6ac5e4e0-740d-4e05-8458-5a9a00bfff17	13e202ee-272d-415f-8d66-f7669b85afb8	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
176c3fbd-4c49-4368-99ec-13e15f2bf6e2	2026-04-03 17:38:30.982485+00	6ac5e4e0-740d-4e05-8458-5a9a00bfff17	6c379005-03bc-478f-aabd-ad3f75f6477a	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
01e2bd39-9c8b-422b-b549-abd7d015828c	2026-04-03 17:38:30.982485+00	6ac5e4e0-740d-4e05-8458-5a9a00bfff17	2d98b2aa-9762-4798-8e28-fcb15c380bf5	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
dada7062-15eb-459b-b95f-cec879ba2709	2026-04-03 17:38:30.982485+00	6ac5e4e0-740d-4e05-8458-5a9a00bfff17	97a3f8b8-caff-4988-b24a-2b7e54d155ee	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
52f43f74-a171-4cf5-86f0-2eaf6d2186a9	2026-04-03 17:38:31.462839+00	2fd3044a-7e16-4d4d-9923-60897eb85e93	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f794d649-e716-4ad2-ad54-b23d4a519584	2026-04-03 06:27:47.470857+00	f67bbea7-6b82-4f66-a99e-a40559dd54de	7c879cb9-b214-4851-9fb7-cd84b0698bb7	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-04-01	f
feaf40e7-b9d4-4512-b186-bf7fea9efce2	2026-03-25 10:19:45.81005+00	6335a5b8-1338-4788-a8ca-5a360b4621cc	ed3a44cb-388f-431a-bf56-2d35af78ea8a	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d7a807be-6af3-4798-b426-ec937662f029	2026-03-25 10:19:45.81005+00	6335a5b8-1338-4788-a8ca-5a360b4621cc	7851fd12-1e6f-4a02-b957-c2120bc0ac83	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d7e0b4f1-4a8f-4714-a068-a9a77c1b980a	2026-03-25 10:19:45.81005+00	6335a5b8-1338-4788-a8ca-5a360b4621cc	70610b82-10ea-46b2-a99b-59c187db69da	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7eb21239-8a87-4c4b-98d9-cf1a465855b5	2026-03-25 10:19:45.81005+00	6335a5b8-1338-4788-a8ca-5a360b4621cc	a41687b8-6f23-46d2-abbb-285d71a1331c	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
401cf5c1-b0b4-4d7f-a0c9-2082e4725b02	2026-03-25 10:19:45.81005+00	6335a5b8-1338-4788-a8ca-5a360b4621cc	8b2745aa-d94a-48b9-be06-1aa87aac12d0	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
abad69fa-c77b-4bbe-ac41-59f737cc5f5a	2026-03-25 10:19:45.81005+00	6335a5b8-1338-4788-a8ca-5a360b4621cc	386cac04-cc49-4dd7-bb14-b17b9760795b	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
35110599-709b-48fa-b3c8-586795acb9f3	2026-03-25 10:19:44.790823+00	f48d3948-b170-45a9-9ccb-65a43c8a269c	86c197e6-24db-4d82-8572-d86b5ca15b2f	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
468486e0-f734-4d80-afd9-5f6f04c88e8b	2026-03-25 10:19:44.790823+00	f48d3948-b170-45a9-9ccb-65a43c8a269c	00ef1cb1-a558-407b-8798-c0db3f382cb8	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
cf23b47b-65c0-4612-a0a1-61e399d6fe34	2026-03-25 10:19:44.790823+00	f48d3948-b170-45a9-9ccb-65a43c8a269c	a3f3ccb1-7c00-4b52-9837-dc69331b521c	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4315f85f-a91a-4817-bb35-7ec4481220e4	2026-03-29 09:30:01.509316+00	251a8ed4-80cf-4fad-8e03-63f60917d1c1	8b6e4db3-9332-457c-8e1a-ad88af0c40be	c48c89f9-082b-4835-9a9f-e3ee05ed3476	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
61111b84-5f1e-4d6c-97b1-1eb6f41fade6	2026-03-24 17:28:39.219662+00	273777e2-b113-4184-8e98-cd147a948004	386cac04-cc49-4dd7-bb14-b17b9760795b	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
45cca6e1-8773-40eb-8fff-05f7440a8ccb	2026-03-24 17:28:39.763682+00	900f74cf-2f09-47c3-a9c8-4fe5d2dc4684	01fdbddd-ee76-4200-a153-47cc61d67398	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
06fcb81f-b686-4e9c-b7a2-78695ca2bcf7	2026-03-24 17:28:39.763682+00	900f74cf-2f09-47c3-a9c8-4fe5d2dc4684	d2566406-84dd-4204-a6c7-31a91107623a	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
60e0027a-3fbb-45ae-8809-5f2b787c3414	2026-03-24 17:28:59.078512+00	1c11e732-ee21-48bf-ae67-f1d17a201f74	ceb5bad4-3051-4086-ac9c-a67e6c124aee	b6d87440-e59a-402a-81f1-4d996a9a9300	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-03-28	f
65836b90-22a3-45e1-af23-3630ffa8b3bf	2026-03-24 17:28:39.219662+00	273777e2-b113-4184-8e98-cd147a948004	7851fd12-1e6f-4a02-b957-c2120bc0ac83	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6f4d2f43-9428-41f5-9e3f-09ac4a0e78a1	2026-03-24 17:28:39.219662+00	273777e2-b113-4184-8e98-cd147a948004	8b2745aa-d94a-48b9-be06-1aa87aac12d0	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4d475480-f7ba-44c1-8f47-ca92fc844b83	2026-03-24 17:28:39.763682+00	900f74cf-2f09-47c3-a9c8-4fe5d2dc4684	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1aa51bca-d65c-417a-a315-7351c7f1fd11	2026-03-24 17:28:39.219662+00	273777e2-b113-4184-8e98-cd147a948004	a41687b8-6f23-46d2-abbb-285d71a1331c	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0e7d6f89-a480-4539-8cd2-6085d7888958	2026-03-24 17:28:39.763682+00	900f74cf-2f09-47c3-a9c8-4fe5d2dc4684	7374ef8e-c3b3-40aa-b6b4-7ae7159a7ce6	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
36ab7e78-bb78-4837-8b3a-82a9adb4b332	2026-03-27 16:03:53.978371+00	d9781f82-0ab6-4ec2-a4b7-ba43bc7ad223	8dab5312-dbee-4f86-83dd-0874ffc99c46	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
1010c905-8f41-459c-a7e9-1ffe93d5f261	2026-03-31 13:30:34.689422+00	fa0274f2-55e2-424a-be15-f8f050991b0e	080111ef-d8d7-4662-ba20-cd5ff1bfa389	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
5ee1a9d9-19f0-4714-909b-bc5f163b574f	2026-03-31 15:26:53.947787+00	355c7448-e956-498c-a1cc-df3a7dca7790	3cbd32b1-84a7-4596-92d0-903d6ea1f631	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
26255d56-d0c4-48c8-97c0-39f2e88b1814	2026-03-31 17:27:07.482854+00	02fd8130-b58b-4132-b3ee-8de854c3c212	466a4031-fc42-48c9-88c5-1a1925e19912	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
2acbaa61-0e49-49be-9752-cc915d4329ce	2026-04-01 17:19:58.271536+00	f902b687-d691-4eab-bd0a-55ea83a02a5e	3cbd32b1-84a7-4596-92d0-903d6ea1f631	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
124fb728-c621-4194-b916-0bb910769968	2026-04-01 17:19:59.02856+00	f902b687-d691-4eab-bd0a-55ea83a02a5e	080111ef-d8d7-4662-ba20-cd5ff1bfa389	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
9f8b43c7-22b7-46ec-a7ca-3bf0350458b6	2026-04-01 17:19:59.773481+00	f902b687-d691-4eab-bd0a-55ea83a02a5e	8dab5312-dbee-4f86-83dd-0874ffc99c46	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
648814dc-2695-46b9-bd86-d1d6770956e5	2026-04-01 17:20:00.502157+00	f902b687-d691-4eab-bd0a-55ea83a02a5e	466a4031-fc42-48c9-88c5-1a1925e19912	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
7f402ed9-0bbc-455d-8424-95b74e569e6d	2026-04-01 17:20:01.014432+00	f902b687-d691-4eab-bd0a-55ea83a02a5e	8a158331-8983-4d93-8d27-616394540f3d	c48c89f9-082b-4835-9a9f-e3ee05ed3476	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
73948684-2265-4fac-80c1-50ddd65f4249	2026-04-01 17:20:01.583302+00	f902b687-d691-4eab-bd0a-55ea83a02a5e	7fb3adc8-4473-43a4-84a8-c76a60e2665f	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
6ca5c7cf-c02d-4f0f-8583-6c0ef728d320	2026-04-02 09:24:57.898279+00	6b63bbe9-b509-4424-9377-6b1b6d9e0ca7	466a4031-fc42-48c9-88c5-1a1925e19912	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
4a1c484e-0b9d-4129-9e2f-f58db2739991	2026-04-02 10:43:19.384497+00	d9b1cb06-e452-4f66-8dd5-781d1af83b6a	3cbd32b1-84a7-4596-92d0-903d6ea1f631	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
7615370c-6d48-4093-b5fc-3bb3d60f0e2f	2026-04-02 10:43:39.388635+00	d9b1cb06-e452-4f66-8dd5-781d1af83b6a	080111ef-d8d7-4662-ba20-cd5ff1bfa389	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
330594e2-07d7-4105-a735-b7950305f0ae	2026-04-03 17:38:31.462839+00	2fd3044a-7e16-4d4d-9923-60897eb85e93	7e7447f5-56a1-4513-9606-978058d389d5	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f05c0917-ade8-4760-9442-e4d8d9483b44	2026-04-03 17:38:31.462839+00	2fd3044a-7e16-4d4d-9923-60897eb85e93	ceb5bad4-3051-4086-ac9c-a67e6c124aee	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ae2c554b-be28-4ed5-b060-69d147850236	2026-04-03 17:38:31.462839+00	2fd3044a-7e16-4d4d-9923-60897eb85e93	33600627-aea8-4768-8be4-eadb5152e41f	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
62cc7d64-a4a1-4755-bef5-561ee7709118	2026-04-03 17:38:31.462839+00	2fd3044a-7e16-4d4d-9923-60897eb85e93	ddbca8c2-9bfd-4ab2-90d1-8c8127be9331	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a56e8f59-70b6-4a72-a5df-2548c4282737	2026-04-03 17:38:31.954188+00	68f541e9-8f52-4816-bfb6-0eb076090d8d	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b4a0f20a-8197-4aec-863b-d3ec727baea0	2026-04-03 17:38:31.954188+00	68f541e9-8f52-4816-bfb6-0eb076090d8d	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e216a2ab-170b-4426-a95d-d1b07a027a6e	2026-04-03 17:38:31.954188+00	68f541e9-8f52-4816-bfb6-0eb076090d8d	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
745e023a-066a-4466-b9c0-8f996d713158	2026-04-03 17:38:31.462839+00	2fd3044a-7e16-4d4d-9923-60897eb85e93	8b6e4db3-9332-457c-8e1a-ad88af0c40be	\N	t	WA20260312. 18:42	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
fb4ba609-769c-4f1c-a2e2-c2fcedc68b9a	2026-03-23 09:51:44.598945+00	ac9e2ac7-b88d-427f-b83b-2b20d22a219c	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
84522893-1af6-49df-a430-7e4533757fba	2026-02-25 09:03:49.551971+00	2602a1d7-dc0b-4414-a01c-5b2939663a91	1c9e7097-df1c-4540-b79b-35055f8f080f	\N	t	AND ⛔️	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e4b5be1d-568e-44ca-8a7c-f03994716aa1	2026-04-04 06:23:06.262751+00	e0b89ef3-cc1e-45cf-97bc-cec607b939cd	7dd68452-30ed-4829-857d-bebc61aff9c1	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-01-31	f
2bc96d6e-d0b8-42f0-98a1-683d17b6b6d4	2026-04-05 08:56:56.792677+00	6335a5b8-1338-4788-a8ca-5a360b4621cc	1c9e7097-df1c-4540-b79b-35055f8f080f	5e250204-ceee-4813-b935-df2600156009	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2025-11-15	f
b1668b59-1a28-423e-8906-9e42437d2b4c	2026-03-25 10:19:46.357178+00	563c3372-d926-4127-8703-eb8f5ac1409f	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
14c93c1a-7ccf-4294-b698-c9e404e18bbd	2026-03-25 10:19:46.357178+00	563c3372-d926-4127-8703-eb8f5ac1409f	e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f99a43be-ffdd-445f-88fb-a3c639d62a68	2026-03-25 10:19:46.357178+00	563c3372-d926-4127-8703-eb8f5ac1409f	01fdbddd-ee76-4200-a153-47cc61d67398	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2ffc57b5-75b7-41e7-bd8f-36fcb100200e	2026-03-25 10:19:46.357178+00	563c3372-d926-4127-8703-eb8f5ac1409f	d2566406-84dd-4204-a6c7-31a91107623a	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ced2342c-783c-48fe-a685-c3a966680537	2026-03-25 10:19:46.357178+00	563c3372-d926-4127-8703-eb8f5ac1409f	7374ef8e-c3b3-40aa-b6b4-7ae7159a7ce6	c6bc37d8-7c43-4ae3-9c95-4f6488a42f09	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5421713b-7ef3-40e7-8f8a-0e0e710fcc7c	2026-04-05 10:38:46.39753+00	4613dd55-48eb-47d6-af52-4f6fe4acd2ce	9430b606-42b0-45c9-aca3-c56c6d23d11b	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-03-25	f
e25e4054-883d-46b4-96ea-a5008f412db2	2026-04-22 12:25:03.89208+00	273777e2-b113-4184-8e98-cd147a948004	\N	c6bc37d8-7c43-4ae3-9c95-4f6488a42f09	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Marine	\N	t	Offert	\N	\N	f
ed279cac-d79b-41d4-8bb8-47046ffb7fac	2026-04-24 08:38:52.760922+00	d45da5ae-adc3-49d3-b1e1-10487adabf4a	\N	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Hannah	45.00	f	\N	\N	\N	f
3c11a915-57eb-498c-af64-7babeec09c6f	2026-04-03 06:30:57.545837+00	e0b89ef3-cc1e-45cf-97bc-cec607b939cd	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-03-21	f
da60d608-0b40-4aab-ae08-2ab174328cc1	2026-03-25 10:19:45.303531+00	c2959acd-9c17-40c1-9410-0ab154658b83	7c879cb9-b214-4851-9fb7-cd84b0698bb7	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
8161f702-9427-4faf-9eff-6a81887175c3	2026-03-29 09:30:03.196948+00	251a8ed4-80cf-4fad-8e03-63f60917d1c1	ddbca8c2-9bfd-4ab2-90d1-8c8127be9331	\N	t	SP 👍 - SI 👎	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
07655409-9f8e-40fe-a88b-7320950c95d9	2026-03-24 17:29:36.962185+00	dd083fee-fec5-4f59-9c58-331ccf1f61bf	00ef1cb1-a558-407b-8798-c0db3f382cb8	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
13d511f4-09fe-4818-bb90-e04de769b1ec	2026-03-24 17:29:36.962185+00	dd083fee-fec5-4f59-9c58-331ccf1f61bf	86c197e6-24db-4d82-8572-d86b5ca15b2f	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7521aacb-a887-448f-8161-295dbe70eac7	2026-03-24 17:29:36.962185+00	dd083fee-fec5-4f59-9c58-331ccf1f61bf	9430b606-42b0-45c9-aca3-c56c6d23d11b	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
263ba5c4-849a-49bf-a916-3ddd7b036dda	2026-03-24 17:29:36.962185+00	dd083fee-fec5-4f59-9c58-331ccf1f61bf	a3f3ccb1-7c00-4b52-9837-dc69331b521c	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d4768b32-d3f3-43a4-a850-51ca86d3f28d	2026-03-24 17:29:37.483006+00	02512bcc-cc3e-4d8a-ae5b-8f34f8da922f	f6b2c3bc-2197-44c1-a848-d18a66e3fdf5	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
788c2081-bc14-4c5b-be67-49eb84107f00	2026-03-24 17:29:37.483006+00	02512bcc-cc3e-4d8a-ae5b-8f34f8da922f	b0054d27-f377-41ad-a026-a2893c27692a	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c32f8321-a302-4a4a-a28c-161b8bc5c74c	2026-03-24 17:29:37.483006+00	02512bcc-cc3e-4d8a-ae5b-8f34f8da922f	1d2c9275-719e-452b-9298-ec476ac53155	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c0b752b4-8d50-459c-8198-89f9ae7ebbf5	2026-03-24 17:29:37.483006+00	02512bcc-cc3e-4d8a-ae5b-8f34f8da922f	7c879cb9-b214-4851-9fb7-cd84b0698bb7	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f24ac984-cd33-401f-9597-7c202b970654	2026-03-25 10:19:45.303531+00	c2959acd-9c17-40c1-9410-0ab154658b83	f6b2c3bc-2197-44c1-a848-d18a66e3fdf5	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b76ffc44-f6bb-4a2f-b358-c9a9ed83cddf	2026-03-25 10:19:45.303531+00	c2959acd-9c17-40c1-9410-0ab154658b83	b0054d27-f377-41ad-a026-a2893c27692a	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
72b52078-7b49-4b93-84ba-8bd898542a0a	2026-03-25 10:19:45.303531+00	c2959acd-9c17-40c1-9410-0ab154658b83	1d2c9275-719e-452b-9298-ec476ac53155	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1a858774-535f-4986-a420-ed95b80c3408	2026-03-24 17:29:38.207457+00	d45b5ec4-f6a0-459d-af25-aba52669b686	70610b82-10ea-46b2-a99b-59c187db69da	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
82431843-8439-4b7c-94f9-fba6ef0cf931	2026-03-24 17:29:38.827984+00	b4a80331-0099-449d-b8f1-685f4630d67b	e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
327f7235-64cf-43f9-afed-b8b18d6beba2	2026-03-24 17:29:38.207457+00	d45b5ec4-f6a0-459d-af25-aba52669b686	8b2745aa-d94a-48b9-be06-1aa87aac12d0	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7f393e7b-1fd4-49e4-8fa8-ce4a14aa0516	2026-03-24 17:29:38.207457+00	d45b5ec4-f6a0-459d-af25-aba52669b686	7851fd12-1e6f-4a02-b957-c2120bc0ac83	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
08c9a0dd-0fd1-4e2f-b7d9-ee3339155704	2026-03-24 17:29:38.207457+00	d45b5ec4-f6a0-459d-af25-aba52669b686	ed3a44cb-388f-431a-bf56-2d35af78ea8a	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
64089bd7-fb0f-411b-ace5-b866dc50193a	2026-03-24 17:29:38.207457+00	d45b5ec4-f6a0-459d-af25-aba52669b686	386cac04-cc49-4dd7-bb14-b17b9760795b	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1d727aee-abd8-4c24-bf02-00ebd318fa11	2026-03-24 17:29:38.827984+00	b4a80331-0099-449d-b8f1-685f4630d67b	7374ef8e-c3b3-40aa-b6b4-7ae7159a7ce6	c6bc37d8-7c43-4ae3-9c95-4f6488a42f09	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0d18e561-9a32-4a77-854a-a4d539d2bc13	2026-03-24 17:29:38.827984+00	b4a80331-0099-449d-b8f1-685f4630d67b	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6e6969a9-b43b-4661-a1c4-2bdb9a856f99	2026-03-24 17:29:38.827984+00	b4a80331-0099-449d-b8f1-685f4630d67b	d2566406-84dd-4204-a6c7-31a91107623a	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4965a893-a882-4e47-a08b-8c12a8075755	2026-03-27 16:03:54.545413+00	d9781f82-0ab6-4ec2-a4b7-ba43bc7ad223	7fb3adc8-4473-43a4-84a8-c76a60e2665f	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
ab305a57-5c80-4e1e-8305-0b396abae11f	2026-02-25 09:20:57.515521+00	658dd892-42b6-4691-bb71-6a8c20082919	\N	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Thaïssa	\N	t	Offert	\N	\N	f
356f4804-dd1a-4e0a-a512-b6707cd39be8	2026-03-31 13:30:34.96518+00	fa0274f2-55e2-424a-be15-f8f050991b0e	322417b3-f05a-488c-b3b6-8956e7e4413a	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
19730ef5-1aa0-44f6-9f77-4c758a5f3576	2026-03-31 15:27:12.564024+00	355c7448-e956-498c-a1cc-df3a7dca7790	080111ef-d8d7-4662-ba20-cd5ff1bfa389	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
32642292-f023-483d-9cd4-5362a2f923f8	2026-03-31 17:27:08.139815+00	02fd8130-b58b-4132-b3ee-8de854c3c212	8a158331-8983-4d93-8d27-616394540f3d	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
3fd2015c-70f7-4497-9f2b-5905005dc57f	2026-03-31 17:27:09.274693+00	02fd8130-b58b-4132-b3ee-8de854c3c212	19dfcd2c-5aaf-4e09-ac63-9856393cfb3c	c6bc37d8-7c43-4ae3-9c95-4f6488a42f09	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
c5886031-8765-445d-bf8b-3a2be3bfb47d	2026-04-01 17:26:28.769549+00	986e73bb-eacf-4244-b653-e5ec780e6ad1	893bb307-08a3-4af2-ba54-6c5da32206ad	835b104d-b18b-4876-ba72-ffea56c43563	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
a6e1be2a-cd08-40ac-ba74-74ec365a1f12	2026-04-01 17:26:29.508046+00	986e73bb-eacf-4244-b653-e5ec780e6ad1	3cbd32b1-84a7-4596-92d0-903d6ea1f631	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
c01d71ff-8c5b-40e8-8d49-f19de4b0cd8a	2026-04-01 17:26:30.045747+00	986e73bb-eacf-4244-b653-e5ec780e6ad1	080111ef-d8d7-4662-ba20-cd5ff1bfa389	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
29f27c38-448f-4bfa-b171-5a7592ff1cf2	2026-04-01 17:26:30.856979+00	986e73bb-eacf-4244-b653-e5ec780e6ad1	aaedc900-37ff-4b01-88cb-82c36deffca8	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
77f4f499-fbce-4899-921c-3c6ddcafecf9	2026-04-01 17:26:31.343584+00	986e73bb-eacf-4244-b653-e5ec780e6ad1	322417b3-f05a-488c-b3b6-8956e7e4413a	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
0f6567b1-b927-40ef-b35c-bb254ffc3b72	2026-04-02 09:24:58.423078+00	6b63bbe9-b509-4424-9377-6b1b6d9e0ca7	0328157c-5422-4fea-94a7-87f84d287645	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
67e1c838-b4e6-45d8-a425-21dd294adfd6	2026-04-02 10:47:12.072513+00	5ba4da73-bf41-45d4-bdc2-b810d550c9ed	466a4031-fc42-48c9-88c5-1a1925e19912	d532c50a-26f4-4491-bcb3-e8fe9bb5105d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
7e28d6ae-5136-4eb7-a86b-1bf446f1407e	2026-04-02 10:47:12.552066+00	5ba4da73-bf41-45d4-bdc2-b810d550c9ed	0328157c-5422-4fea-94a7-87f84d287645	b6d87440-e59a-402a-81f1-4d996a9a9300	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
dc85d97f-1486-403b-aef0-9f0419256e08	2026-04-02 10:47:13.078691+00	5ba4da73-bf41-45d4-bdc2-b810d550c9ed	8a158331-8983-4d93-8d27-616394540f3d	c48c89f9-082b-4835-9a9f-e3ee05ed3476	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
9a04707d-1e73-455e-9345-1b1a82572e4d	2026-04-02 10:47:13.537327+00	5ba4da73-bf41-45d4-bdc2-b810d550c9ed	322417b3-f05a-488c-b3b6-8956e7e4413a	03331a64-cbca-4ae6-b260-80308e787efc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
f6c64b17-9601-4def-8b38-beb4d5f95f33	2026-03-20 14:24:51.544073+00	3a983f94-c153-422c-88fb-f799cbbd2073	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
9fd18981-cc32-44ae-a6d4-6f5d4b469b10	2026-04-03 17:40:24.863303+00	612a94b5-04d0-4f36-95eb-65d82c7d276f	ddbca8c2-9bfd-4ab2-90d1-8c8127be9331	\N	t	WA20260316. 12:04	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d358223a-244c-4044-a6e2-be5b02f80a98	2026-04-04 05:12:17.428243+00	ac9e2ac7-b88d-427f-b83b-2b20d22a219c	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-04-04	f
5da0f8eb-ad81-4bae-97c4-189ea20c183c	2026-02-26 09:10:30.990033+00	85967229-e0e1-4902-9062-86c70e0fc505	ed3a44cb-388f-431a-bf56-2d35af78ea8a	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2025-09-24	f
f787063f-5eba-4d81-bbce-ebfe2f2244f0	2026-02-25 09:47:44.131667+00	45492e65-17c7-4458-9dbf-29b31fa36051	01fdbddd-ee76-4200-a153-47cc61d67398	\N	t	🅰️	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
83a8c00c-3e60-49d5-b3a9-7b8f93c59e62	2026-04-05 09:04:12.344158+00	ac9e2ac7-b88d-427f-b83b-2b20d22a219c	1c9e7097-df1c-4540-b79b-35055f8f080f	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-04-04	f
2375a622-cba8-472c-bdc8-938d19824f11	2026-04-22 14:37:03.794444+00	10951fef-c57d-4bf9-8369-31baf9026572	b0054d27-f377-41ad-a026-a2893c27692a	\N	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-01-07	f
26e4c3aa-662f-4e3a-867c-68ec50dcef35	2026-03-16 12:19:13.585231+00	251a8ed4-80cf-4fad-8e03-63f60917d1c1	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
beb9dad4-da50-4e99-a863-3c897b881790	2026-04-26 07:51:14.571597+00	e305f328-b6fb-42a4-acb5-66d6ba4fb0cb	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	8d1e0213-3958-4a1a-8d8a-473cd765cebf	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
2d460047-07ef-432d-a4ec-4f0825dc1bb6	2026-04-26 07:51:15.242867+00	e305f328-b6fb-42a4-acb5-66d6ba4fb0cb	\N	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Annie	\N	f	\N	\N	\N	f
30ec0632-c970-488a-8d22-bf3e7952457c	2026-04-26 08:01:58.726299+00	2b5196f1-f7af-47c7-88ab-5e13fb08243a	d2566406-84dd-4204-a6c7-31a91107623a	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e65c56a3-f17f-4312-9056-4ff6132e697e	2026-04-29 13:18:17.096499+00	eef18837-1d71-4ed8-95f4-6abe11afb462	f04390c1-2a8d-406c-bf99-41d94e160925	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
44c3b400-1f6c-449f-836d-06f0d7dda110	2026-04-26 08:01:58.027006+00	2b5196f1-f7af-47c7-88ab-5e13fb08243a	e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
981ba3cc-3170-4027-8a04-e5555eded311	2026-04-29 11:36:19.499834+00	02512bcc-cc3e-4d8a-ae5b-8f34f8da922f	9430b606-42b0-45c9-aca3-c56c6d23d11b	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
533aa58e-c447-4503-8293-1656679c1b50	2026-03-24 17:29:38.827984+00	b4a80331-0099-449d-b8f1-685f4630d67b	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a9d82884-ff5f-4578-a4b6-4dd0a53cafbd	2026-04-30 07:06:01.017844+00	06292f37-cb07-4aaf-9132-5e59d714defe	f056b2e2-8510-45d1-b81a-a1d06ab18dd1	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1aca34c8-3c9a-4661-94aa-ee3a79021a65	2026-04-30 07:05:57.809106+00	06292f37-cb07-4aaf-9132-5e59d714defe	322417b3-f05a-488c-b3b6-8956e7e4413a	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
5219be37-acd7-42d1-9b42-e672f3de6cee	2026-04-03 17:40:24.359597+00	2d2b77a4-539b-4ada-b69f-2b4bb2f092f3	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
bb278341-3407-45f1-9f2b-a5a58fabacea	2026-04-30 07:03:42.071385+00	6eb7b7d3-940d-4cff-932e-83b08f574c69	466a4031-fc42-48c9-88c5-1a1925e19912	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
9df65ccb-ced1-4cc3-9158-185aa0d41365	2026-04-03 17:40:24.359597+00	2d2b77a4-539b-4ada-b69f-2b4bb2f092f3	13e202ee-272d-415f-8d66-f7669b85afb8	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9d875e19-b675-44ef-a62a-b1af01c763e6	2026-04-30 16:59:48.55496+00	2d2b77a4-539b-4ada-b69f-2b4bb2f092f3	7dd68452-30ed-4829-857d-bebc61aff9c1	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-03-07	f
bc98cf0c-5a82-4dfb-8d6b-2b16a73868dc	2026-04-03 17:40:23.289467+00	103d8f2b-d328-4df6-aed0-a7b1538ba9f1	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1fbf6ccf-13d2-4dc1-82f4-43cf48fe163d	2026-04-03 17:40:23.289467+00	103d8f2b-d328-4df6-aed0-a7b1538ba9f1	ce4184ad-5144-4b9b-8276-0111197e0885	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a7c20c51-5601-4e10-bcbb-89d2da275ecb	2026-04-03 17:40:23.849479+00	40977b9e-1d07-47f0-8a4c-6f7a1a548211	9aa72019-ede1-4b37-a63b-400a20a683a7	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ad39abac-e30f-41c8-924b-275bf798a82b	2026-04-03 17:40:23.849479+00	40977b9e-1d07-47f0-8a4c-6f7a1a548211	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e1664a2d-37c4-4778-9bfd-156134625a5d	2026-04-03 17:40:23.849479+00	40977b9e-1d07-47f0-8a4c-6f7a1a548211	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
79fc09a7-fb7c-44fe-9e25-bb17a0a3dcff	2026-04-03 17:40:24.359597+00	2d2b77a4-539b-4ada-b69f-2b4bb2f092f3	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e5005fb4-0f9b-4b30-9c2a-28bcb283a492	2026-04-03 17:40:24.359597+00	2d2b77a4-539b-4ada-b69f-2b4bb2f092f3	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
97629e08-36cd-4a23-9a56-bddd68409123	2026-04-03 17:40:24.359597+00	2d2b77a4-539b-4ada-b69f-2b4bb2f092f3	6c379005-03bc-478f-aabd-ad3f75f6477a	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0d6d28e9-c4c2-40a4-95b2-4fca71483d56	2026-04-03 17:40:24.359597+00	2d2b77a4-539b-4ada-b69f-2b4bb2f092f3	2d98b2aa-9762-4798-8e28-fcb15c380bf5	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6a8cdf40-eea9-472e-814e-ff0e8f800529	2026-04-03 17:40:24.863303+00	612a94b5-04d0-4f36-95eb-65d82c7d276f	7e7447f5-56a1-4513-9606-978058d389d5	d532c50a-26f4-4491-bcb3-e8fe9bb5105d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c43ea403-cba9-410c-bf73-8ee632fb60d0	2026-04-03 17:40:24.863303+00	612a94b5-04d0-4f36-95eb-65d82c7d276f	8b6e4db3-9332-457c-8e1a-ad88af0c40be	\N	t	❌ ANR. Semaines Impaires	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
bc23e2e5-fed6-4267-b755-d8db34681392	2026-04-03 17:40:24.863303+00	612a94b5-04d0-4f36-95eb-65d82c7d276f	ceb5bad4-3051-4086-ac9c-a67e6c124aee	b6d87440-e59a-402a-81f1-4d996a9a9300	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
cd0eb4d7-9d4c-4e82-84e6-5f621dc04c16	2026-04-03 17:40:24.863303+00	612a94b5-04d0-4f36-95eb-65d82c7d276f	33600627-aea8-4768-8be4-eadb5152e41f	c48c89f9-082b-4835-9a9f-e3ee05ed3476	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
9f19cad4-15cd-4969-a052-c08730e9c9f2	2026-04-03 17:40:25.39324+00	d927e43a-7c30-467d-9b57-4b163f280104	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
abd0b31e-1d57-4480-b530-38da7c32173e	2026-04-03 17:40:25.39324+00	d927e43a-7c30-467d-9b57-4b163f280104	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e650bd07-6bc4-4d16-b6c9-e81188b7d1ff	2026-04-03 17:40:25.39324+00	d927e43a-7c30-467d-9b57-4b163f280104	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b0dfa2be-e1cb-4415-ad2e-0ffae68dc2ad	2026-04-03 17:40:23.289467+00	103d8f2b-d328-4df6-aed0-a7b1538ba9f1	9c87739b-74ad-47b9-a70f-6efc26c93f00	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0d0035c2-4dee-42ec-b8ff-50526159ec63	2026-04-03 17:40:23.289467+00	103d8f2b-d328-4df6-aed0-a7b1538ba9f1	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
078434dd-5cda-496b-a837-fe3e340ae34c	2026-04-03 17:40:23.849479+00	40977b9e-1d07-47f0-8a4c-6f7a1a548211	7dd68452-30ed-4829-857d-bebc61aff9c1	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1a71c15f-e82d-4495-a4d7-8bc4873205f5	2026-03-27 16:03:55.05774+00	d9781f82-0ab6-4ec2-a4b7-ba43bc7ad223	19dfcd2c-5aaf-4e09-ac63-9856393cfb3c	76876dd9-f4c0-455c-9b22-08799cc72af0	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
debcbec1-0050-465d-9bff-56f4d5e6b41a	2026-02-25 10:18:41.290745+00	8630ca85-a482-4220-b9ce-ad9c53e3641e	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2025-11-22	f
c36136c1-4305-4a84-98ea-1ff6e493bb7d	2026-03-31 13:30:35.225282+00	fa0274f2-55e2-424a-be15-f8f050991b0e	8dab5312-dbee-4f86-83dd-0874ffc99c46	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
9388f3bf-e3f8-42a6-bf1a-517a10d176bc	2026-03-31 15:42:52.931967+00	4cb6bb35-e1a5-4482-96d0-b332197766a7	893bb307-08a3-4af2-ba54-6c5da32206ad	c6bc37d8-7c43-4ae3-9c95-4f6488a42f09	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
cde81b35-42b0-4cd7-966b-5ace88ed57a9	2026-03-31 15:42:55.948279+00	4cb6bb35-e1a5-4482-96d0-b332197766a7	19dfcd2c-5aaf-4e09-ac63-9856393cfb3c	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
03f557a8-1c5c-432b-8a91-4544200e4f28	2026-03-31 17:31:46.823223+00	7eaed77e-0be6-41d2-af22-e3124a2a7458	893bb307-08a3-4af2-ba54-6c5da32206ad	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
aa247981-f64f-4bb3-b4c3-849f76fab1db	2026-03-31 17:31:49.12753+00	7eaed77e-0be6-41d2-af22-e3124a2a7458	8dab5312-dbee-4f86-83dd-0874ffc99c46	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
185490d5-203e-4f02-a54b-e1b2a2d6bb28	2026-04-01 17:29:17.092755+00	f6f911c4-b299-4d58-be3c-95f60feda870	8dab5312-dbee-4f86-83dd-0874ffc99c46	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
880a3514-57d9-4dcf-aaae-730552225741	2026-04-01 17:29:17.621749+00	f6f911c4-b299-4d58-be3c-95f60feda870	466a4031-fc42-48c9-88c5-1a1925e19912	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
136eb641-65bf-44fe-b66c-bf8d9337f9cf	2026-04-01 17:29:18.152797+00	f6f911c4-b299-4d58-be3c-95f60feda870	7fb3adc8-4473-43a4-84a8-c76a60e2665f	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
5d7aa8ce-a4dc-456b-addb-57966154706c	2026-04-02 10:08:26.503961+00	b37e7b09-37b0-4532-8f54-49487d400fcc	893bb307-08a3-4af2-ba54-6c5da32206ad	835b104d-b18b-4876-ba72-ffea56c43563	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
52145f5b-7f6a-4e9c-aee0-adb573cddb38	2026-04-02 10:08:27.313042+00	b37e7b09-37b0-4532-8f54-49487d400fcc	3cbd32b1-84a7-4596-92d0-903d6ea1f631	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
3d1509f8-1b97-46d9-8f58-7a5520f76888	2026-04-02 10:08:27.906706+00	b37e7b09-37b0-4532-8f54-49487d400fcc	080111ef-d8d7-4662-ba20-cd5ff1bfa389	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
7a037cb2-9d38-41eb-90e3-2d7ce4a98d65	2026-04-02 10:08:28.449822+00	b37e7b09-37b0-4532-8f54-49487d400fcc	aaedc900-37ff-4b01-88cb-82c36deffca8	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
4182b7c0-52ea-4a3f-aef0-eeed155759b5	2026-04-02 10:08:28.983278+00	b37e7b09-37b0-4532-8f54-49487d400fcc	322417b3-f05a-488c-b3b6-8956e7e4413a	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
6ba7b1b6-7d3b-42a7-9069-5fb035ac2276	2026-04-03 17:47:43.280504+00	f67bbea7-6b82-4f66-a99e-a40559dd54de	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-04-04	f
337fcb87-ee9b-4bb5-804b-598c9319e9e5	2026-04-04 06:12:49.355976+00	10951fef-c57d-4bf9-8369-31baf9026572	9430b606-42b0-45c9-aca3-c56c6d23d11b	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
70000eba-2329-4ee0-9b2b-0557a71d318e	2026-04-04 06:12:49.355976+00	10951fef-c57d-4bf9-8369-31baf9026572	86c197e6-24db-4d82-8572-d86b5ca15b2f	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
82dafdca-151d-4df9-b533-a636e2f76f32	2026-04-04 06:12:49.355976+00	10951fef-c57d-4bf9-8369-31baf9026572	00ef1cb1-a558-407b-8798-c0db3f382cb8	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
835abbf0-e6fc-4519-95b0-7460c39bb230	2026-04-04 06:12:49.355976+00	10951fef-c57d-4bf9-8369-31baf9026572	a3f3ccb1-7c00-4b52-9837-dc69331b521c	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d87c2a1c-44bb-4462-9d35-9b5688c6a699	2026-04-04 06:12:50.920558+00	fdbd21d2-cb77-416a-b08b-078d6bdeeb92	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
48b5d50a-d9ab-426c-98fe-db16a4b8f4dc	2026-04-04 06:12:50.920558+00	fdbd21d2-cb77-416a-b08b-078d6bdeeb92	e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
42dcc10f-3730-4f9b-b77a-4b16710d9774	2026-04-04 06:12:50.920558+00	fdbd21d2-cb77-416a-b08b-078d6bdeeb92	01fdbddd-ee76-4200-a153-47cc61d67398	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
f4c1d1d8-d740-4769-9996-aac2786e0062	2026-04-04 06:12:50.920558+00	fdbd21d2-cb77-416a-b08b-078d6bdeeb92	7374ef8e-c3b3-40aa-b6b4-7ae7159a7ce6	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
259103f9-b479-48e3-a4d3-6d871bc2c8f1	2026-04-04 06:12:50.920558+00	fdbd21d2-cb77-416a-b08b-078d6bdeeb92	d2566406-84dd-4204-a6c7-31a91107623a	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7545731d-7ed0-4619-bc92-7706a8c16a62	2026-04-04 06:14:20.127951+00	eef18837-1d71-4ed8-95f4-6abe11afb462	f6b2c3bc-2197-44c1-a848-d18a66e3fdf5	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
250020ca-4125-41e7-9a90-ec4cfb673888	2026-04-04 06:14:20.127951+00	eef18837-1d71-4ed8-95f4-6abe11afb462	b0054d27-f377-41ad-a026-a2893c27692a	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
378ef157-d0a4-41a9-80ef-d6cd40818575	2026-04-04 06:14:20.127951+00	eef18837-1d71-4ed8-95f4-6abe11afb462	1d2c9275-719e-452b-9298-ec476ac53155	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
45cc05f3-8f2e-44e8-8dfd-b540563f8bbc	2026-04-04 06:14:20.127951+00	eef18837-1d71-4ed8-95f4-6abe11afb462	7c879cb9-b214-4851-9fb7-cd84b0698bb7	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4b4214a6-c19f-4536-8a8f-4d5e7f36f7f1	2026-04-05 10:43:37.900089+00	1de1c71c-97a6-4a19-9b53-8e5c15114e5f	9430b606-42b0-45c9-aca3-c56c6d23d11b	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
be0bd922-b0b5-4ccb-afa5-386c5447537f	2026-03-23 09:51:43.442773+00	bcfa1cdb-f190-48cc-82db-b2131505cb9f	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	\N	t	🅰️	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d210d3ec-88d9-4340-b0a4-bc0a617ddf21	2026-04-02 11:00:13.630769+00	220d309c-02d7-40d8-be2d-e19f10ecd4c9	0328157c-5422-4fea-94a7-87f84d287645	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
354cb359-d835-48da-a130-fe1e3710cdb3	2026-04-02 11:00:12.549852+00	220d309c-02d7-40d8-be2d-e19f10ecd4c9	893bb307-08a3-4af2-ba54-6c5da32206ad	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
bf5081d6-982b-4f06-9afd-68170c76045f	2026-04-02 11:00:14.1703+00	220d309c-02d7-40d8-be2d-e19f10ecd4c9	7fb3adc8-4473-43a4-84a8-c76a60e2665f	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
5a419668-dc62-48f8-b6e1-ff37774026e8	2026-04-02 11:00:14.700765+00	220d309c-02d7-40d8-be2d-e19f10ecd4c9	19dfcd2c-5aaf-4e09-ac63-9856393cfb3c	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
439bbe1b-c946-40d7-86de-f3c0eea70794	2026-04-02 11:00:15.296758+00	220d309c-02d7-40d8-be2d-e19f10ecd4c9	8dab5312-dbee-4f86-83dd-0874ffc99c46	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
95a3642e-fe1f-4361-ad22-f4e13d09adf6	2026-04-02 11:00:13.111689+00	220d309c-02d7-40d8-be2d-e19f10ecd4c9	466a4031-fc42-48c9-88c5-1a1925e19912	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
82fe8161-54c5-4152-a4af-e1355589d58a	2026-04-30 07:03:40.912883+00	6eb7b7d3-940d-4cff-932e-83b08f574c69	19dfcd2c-5aaf-4e09-ac63-9856393cfb3c	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
606b7219-f872-4c12-854e-39ad0e1a29c2	2026-04-03 06:31:16.743987+00	e0b89ef3-cc1e-45cf-97bc-cec607b939cd	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-03-21	f
54db6be4-3239-4317-b917-20d416c0549b	2026-04-24 08:55:49.39759+00	98b0b557-b729-4a26-b50b-852c70e3f9a4	\N	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Nina	\N	f	\N	\N	\N	f
3914921d-47e0-4482-adde-132601173c10	2026-04-26 07:51:14.795701+00	e305f328-b6fb-42a4-acb5-66d6ba4fb0cb	2d98b2aa-9762-4798-8e28-fcb15c380bf5	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
cd54c323-40ff-4c7f-87b6-7bbd6913feeb	2026-04-26 08:01:57.333779+00	2b5196f1-f7af-47c7-88ab-5e13fb08243a	01fdbddd-ee76-4200-a153-47cc61d67398	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
de6aaf0c-6c0d-434b-a958-945dcd988e12	2026-04-26 08:01:58.271007+00	2b5196f1-f7af-47c7-88ab-5e13fb08243a	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
61a75d18-89e3-4bd8-a703-509eba7ba680	2026-04-29 13:21:14.522682+00	02512bcc-cc3e-4d8a-ae5b-8f34f8da922f	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-04-25	f
7c9ecd2a-77f5-4a7c-a228-528d894c02d6	2026-04-30 07:05:58.397115+00	06292f37-cb07-4aaf-9132-5e59d714defe	466a4031-fc42-48c9-88c5-1a1925e19912	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
5bb6cbf8-8d9e-463a-b9c7-d2b3c3b4eb18	2026-04-30 07:03:42.714326+00	6eb7b7d3-940d-4cff-932e-83b08f574c69	0328157c-5422-4fea-94a7-87f84d287645	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
7fd29c00-ab2c-4595-85e5-b68285ba28c2	2026-04-30 07:05:59.497267+00	06292f37-cb07-4aaf-9132-5e59d714defe	19dfcd2c-5aaf-4e09-ac63-9856393cfb3c	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
1484c89a-85a2-4aed-8dd4-6328221c2905	2026-04-30 17:01:08.483545+00	2d2b77a4-539b-4ada-b69f-2b4bb2f092f3	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-03-28	f
90cd13c4-f2bd-41af-9199-3edc50b65f35	2026-05-01 08:04:46.002116+00	910ff1f2-8a1c-400f-973f-245b3f3ff740	97a3f8b8-caff-4988-b24a-2b7e54d155ee	\N	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-05-16	f
dc0a4e73-8eac-449a-b069-f99f470e56b5	2026-04-03 17:40:24.359597+00	2d2b77a4-539b-4ada-b69f-2b4bb2f092f3	97a3f8b8-caff-4988-b24a-2b7e54d155ee	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
059ff8e3-7a7d-4e36-832c-b458a22c9584	2026-04-03 17:40:24.863303+00	612a94b5-04d0-4f36-95eb-65d82c7d276f	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
207a406a-aa32-4c2e-bab4-02fe248ce6ad	2026-05-02 06:52:43.759746+00	612a94b5-04d0-4f36-95eb-65d82c7d276f	\N	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Hannah	\N	f	\N	\N	\N	f
de5f4c21-33a5-4f36-bcb3-f2fdd7463d60	2026-05-02 12:00:52.871+00	612a94b5-04d0-4f36-95eb-65d82c7d276f	\N	682763a9-a5bb-4985-aa6e-83bd5f935b2a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	KOYCU Alissya	\N	f	\N	\N	\N	f
aa907f21-17f7-4a2d-8829-8f1dfb99108c	2026-05-02 12:01:23.003292+00	612a94b5-04d0-4f36-95eb-65d82c7d276f	\N	03331a64-cbca-4ae6-b260-80308e787efc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	SEFSAF Louis	\N	f	\N	\N	\N	f
8bb1061a-5789-4327-8663-148015ceefdc	2026-04-30 07:06:00.020524+00	06292f37-cb07-4aaf-9132-5e59d714defe	8dab5312-dbee-4f86-83dd-0874ffc99c46	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
0f7c98f2-0fcd-4d56-a254-307642f7d859	2026-05-05 08:44:53.094286+00	6ab9e0f0-0d33-41ec-ac07-26dcbb9cf689	a3f3ccb1-7c00-4b52-9837-dc69331b521c	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ecbfdd61-618b-4bcf-afbf-615d07ed6c8e	2026-05-05 08:44:53.746837+00	2dad5daa-3224-4053-93da-c40fa6a78ffb	f6b2c3bc-2197-44c1-a848-d18a66e3fdf5	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7a7dbca3-fca2-4756-b851-795a13ae2dd0	2026-05-05 08:44:53.746837+00	2dad5daa-3224-4053-93da-c40fa6a78ffb	b0054d27-f377-41ad-a026-a2893c27692a	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4656ab0a-413c-4d1d-998b-73a4bf72f5a5	2026-03-27 16:08:41.266497+00	47ce8225-99a7-44c7-8153-b17a84a2df9f	893bb307-08a3-4af2-ba54-6c5da32206ad	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
e01bf3e2-0700-48f0-b93a-10b45931bb4b	2026-03-27 16:08:42.818063+00	47ce8225-99a7-44c7-8153-b17a84a2df9f	322417b3-f05a-488c-b3b6-8956e7e4413a	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
939c9b88-baec-4d1e-90e3-3197a3c83d90	2026-03-25 07:04:57.381489+00	9c8442a1-78c2-48c6-896b-c33d34857bb7	\N	b6d87440-e59a-402a-81f1-4d996a9a9300	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Giulia	30.00	f	\N	\N	\N	f
dc90e2ce-ac06-41d4-b4dd-0cd880cc23b7	2026-03-27 09:17:54.945224+00	74914a88-5ef1-446f-80d4-7a87209eeaec	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-03-28	f
83ddeddb-4ee1-49ae-afa6-032ab7b5f567	2026-03-31 13:30:35.485793+00	fa0274f2-55e2-424a-be15-f8f050991b0e	8a158331-8983-4d93-8d27-616394540f3d	4d9a337d-9e43-47f4-bfad-2fdef8b387d9	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
139fb5e1-1df6-4f27-b82c-52b47d30783a	2026-03-31 15:42:53.863409+00	4cb6bb35-e1a5-4482-96d0-b332197766a7	3cbd32b1-84a7-4596-92d0-903d6ea1f631	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
61e79b8b-bb19-4573-94fa-bbdf8a05fb39	2026-03-31 17:31:47.587803+00	7eaed77e-0be6-41d2-af22-e3124a2a7458	aaedc900-37ff-4b01-88cb-82c36deffca8	c6bc37d8-7c43-4ae3-9c95-4f6488a42f09	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
594a939b-408c-44db-ad27-f509f4e17474	2026-03-31 17:31:49.689566+00	7eaed77e-0be6-41d2-af22-e3124a2a7458	7fb3adc8-4473-43a4-84a8-c76a60e2665f	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
2db1434b-c024-4aef-8827-fbeb9cc78043	2026-04-01 17:32:43.104599+00	73b17b0a-e750-4f39-9de7-cc4bfe1efbc8	893bb307-08a3-4af2-ba54-6c5da32206ad	835b104d-b18b-4876-ba72-ffea56c43563	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
47f2f25f-4731-4aee-86de-d9633b72cdff	2026-04-01 17:32:43.743403+00	73b17b0a-e750-4f39-9de7-cc4bfe1efbc8	322417b3-f05a-488c-b3b6-8956e7e4413a	8d3424d3-cb4a-404c-a849-b823220466fc	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
87f9bed3-8b30-4197-949a-ead5047b7cd8	2026-04-02 10:12:57.744208+00	a7f48b70-6678-4e7d-9700-70b0501a5a1c	8dab5312-dbee-4f86-83dd-0874ffc99c46	2da77f56-359d-42fd-83ed-9e50cf2e6d39	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
04dd5d40-1889-4f54-b896-61e2622c25c2	2026-04-02 10:12:58.250124+00	a7f48b70-6678-4e7d-9700-70b0501a5a1c	466a4031-fc42-48c9-88c5-1a1925e19912	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
61322005-57b8-43ce-ab49-ba554ca552ef	2026-04-02 10:12:58.746536+00	a7f48b70-6678-4e7d-9700-70b0501a5a1c	0328157c-5422-4fea-94a7-87f84d287645	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
e5ecd9b4-c75f-4853-9e1a-4c9fcbfb26b9	2026-04-02 10:12:59.425724+00	a7f48b70-6678-4e7d-9700-70b0501a5a1c	8a158331-8983-4d93-8d27-616394540f3d	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
2e9dd968-bac5-4271-934d-88b5037d8a17	2026-04-02 10:12:59.931868+00	a7f48b70-6678-4e7d-9700-70b0501a5a1c	7fb3adc8-4473-43a4-84a8-c76a60e2665f	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
58f3c6fc-7015-4ec0-9581-8b0990cccc7f	2026-04-02 10:13:00.423586+00	a7f48b70-6678-4e7d-9700-70b0501a5a1c	19dfcd2c-5aaf-4e09-ac63-9856393cfb3c	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
06a7354b-3b43-460a-a3dc-212465399432	2026-04-03 08:15:10.107646+00	d50c78c2-032b-4101-bf1e-f3e9b7718ad1	9aa72019-ede1-4b37-a63b-400a20a683a7	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-03-28	f
e05528c3-f765-46f6-9586-635cd239c1da	2026-04-03 17:48:10.581481+00	f67bbea7-6b82-4f66-a99e-a40559dd54de	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-04-04	f
1faa9848-398b-43e2-88f9-5d88a160d9f3	2026-03-23 09:51:45.635759+00	321845a3-8385-4489-8fbb-2725f312d8e5	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	\N	t	\N	f	\N	CLE_SECRETE_FRONTOFFICE	t	f	\N	\N	f	\N	\N	\N	f
c2735488-5403-4892-9d40-c1008a0d67d0	2026-04-03 17:48:32.196533+00	f67bbea7-6b82-4f66-a99e-a40559dd54de	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-04-04	f
92c4bce6-2939-4e5d-b319-8105c5180c0d	2026-04-04 06:12:49.879562+00	8d71eca8-6e71-4dfc-ae58-951a70a7e53e	f6b2c3bc-2197-44c1-a848-d18a66e3fdf5	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
af4e5665-a149-4518-adb6-6f0958827b05	2026-04-04 06:12:49.879562+00	8d71eca8-6e71-4dfc-ae58-951a70a7e53e	b0054d27-f377-41ad-a026-a2893c27692a	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
43b6c00d-0c5a-48a0-978d-0d1fa68dbe7c	2026-04-04 06:12:49.879562+00	8d71eca8-6e71-4dfc-ae58-951a70a7e53e	1d2c9275-719e-452b-9298-ec476ac53155	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0f9d0445-07bf-45be-b597-f2f7885173f2	2026-04-04 06:12:49.879562+00	8d71eca8-6e71-4dfc-ae58-951a70a7e53e	7c879cb9-b214-4851-9fb7-cd84b0698bb7	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5c1d84fc-4a63-40e1-8ab6-cd18d6ca7d8a	2026-04-04 06:14:19.659185+00	fdd1141d-f20d-406a-af84-15b5b3a531e7	9430b606-42b0-45c9-aca3-c56c6d23d11b	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6417c967-317a-477c-b4ca-5e4b7e27913d	2026-04-04 06:14:19.659185+00	fdd1141d-f20d-406a-af84-15b5b3a531e7	86c197e6-24db-4d82-8572-d86b5ca15b2f	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
125f648c-2045-44c5-aee3-7f41aac9f777	2026-04-04 06:14:19.659185+00	fdd1141d-f20d-406a-af84-15b5b3a531e7	00ef1cb1-a558-407b-8798-c0db3f382cb8	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
235f90a6-cbdd-4c98-9531-05595546fd78	2026-04-04 06:14:19.659185+00	fdd1141d-f20d-406a-af84-15b5b3a531e7	a3f3ccb1-7c00-4b52-9837-dc69331b521c	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
431689ca-039c-4975-9097-fb50c9714169	2026-04-04 06:14:21.084404+00	dd5a2c33-2d42-42e3-9a68-a4d0c46e176e	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c3c0da76-2ab1-45ea-aaa2-b0e297a08bfe	2026-04-04 06:14:21.084404+00	dd5a2c33-2d42-42e3-9a68-a4d0c46e176e	e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c4841f32-8904-4c30-bd9d-4b6602b88129	2026-04-04 06:14:21.084404+00	dd5a2c33-2d42-42e3-9a68-a4d0c46e176e	01fdbddd-ee76-4200-a153-47cc61d67398	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
64abc796-cda3-4073-b341-c828b042badc	2026-04-04 06:14:21.084404+00	dd5a2c33-2d42-42e3-9a68-a4d0c46e176e	7374ef8e-c3b3-40aa-b6b4-7ae7159a7ce6	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
26eda6c6-838f-4aff-af58-4b3aa0cfa1d6	2026-04-04 06:14:21.084404+00	dd5a2c33-2d42-42e3-9a68-a4d0c46e176e	d2566406-84dd-4204-a6c7-31a91107623a	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
01b6ab4c-d772-41bc-b276-7e16d3c9c84f	2026-04-04 08:45:16.548054+00	f67bbea7-6b82-4f66-a99e-a40559dd54de	d2566406-84dd-4204-a6c7-31a91107623a	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-01-07	f
4deaa5cb-20d4-4e4c-aae1-30a25cb00c13	2026-04-05 10:00:51.319822+00	f58d4582-80ff-485e-ab32-2b15fc7ed606	9430b606-42b0-45c9-aca3-c56c6d23d11b	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
5d1ce5f1-096b-43cc-a4b9-e7c1f9662339	2026-04-05 10:01:27.692477+00	4251bd3e-a2bd-4ae4-bd66-667c5d4d4ce8	9430b606-42b0-45c9-aca3-c56c6d23d11b	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
b26225c8-c9d9-4c1b-ad01-ceb2ed7efd1b	2026-04-05 10:01:56.418541+00	163bae16-36c5-4bbd-aabd-ebb45f89d1f5	9430b606-42b0-45c9-aca3-c56c6d23d11b	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
e24d2992-deaa-462d-818b-35b71c299827	2026-04-24 06:37:28.147901+00	e1152792-c321-4a78-ae79-d40328c02cef	d2566406-84dd-4204-a6c7-31a91107623a	5e250204-ceee-4813-b935-df2600156009	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2025-10-01	f
27bb7af1-7078-4a63-9512-9f3fddfa23ca	2026-04-26 07:51:15.019796+00	e305f328-b6fb-42a4-acb5-66d6ba4fb0cb	e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c410b55f-9104-4c33-9457-005abe8e89fa	2026-04-26 07:51:15.492283+00	e305f328-b6fb-42a4-acb5-66d6ba4fb0cb	01fdbddd-ee76-4200-a153-47cc61d67398	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4c49af17-4f6a-447c-b798-e5939a24866c	2026-04-29 13:18:16.586298+00	8d71eca8-6e71-4dfc-ae58-951a70a7e53e	f04390c1-2a8d-406c-bf99-41d94e160925	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
91285633-203d-485b-97dd-ce38b93aaf73	2026-04-29 13:18:17.591103+00	02512bcc-cc3e-4d8a-ae5b-8f34f8da922f	f04390c1-2a8d-406c-bf99-41d94e160925	c4b8378c-7955-452f-b3e3-d22ad430c4a7	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
bd7cb03c-7a9e-4190-a693-5bba44bb289e	2026-04-26 08:01:57.782839+00	2b5196f1-f7af-47c7-88ab-5e13fb08243a	2d98b2aa-9762-4798-8e28-fcb15c380bf5	b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
eef11422-cfee-4af6-a7cd-7e00c2515f9c	2026-04-26 08:01:58.499192+00	2b5196f1-f7af-47c7-88ab-5e13fb08243a	386cac04-cc49-4dd7-bb14-b17b9760795b	d4808db9-9fe2-41cf-8606-8f9187a1eb1f	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
6e200a5c-3bba-4e04-b3a9-4475d3f317a0	2026-03-24 17:29:38.207457+00	d45b5ec4-f6a0-459d-af25-aba52669b686	a41687b8-6f23-46d2-abbb-285d71a1331c	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d5f9148f-f569-4109-a0b6-8aca5ddb2728	2026-04-30 07:05:57.169075+00	06292f37-cb07-4aaf-9132-5e59d714defe	aaedc900-37ff-4b01-88cb-82c36deffca8	70eda733-90e8-42ac-b50f-b8f50474214a	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
64d43b97-f750-48f3-ac4b-1b6d51d3e041	2026-04-30 07:03:41.588189+00	6eb7b7d3-940d-4cff-932e-83b08f574c69	8dab5312-dbee-4f86-83dd-0874ffc99c46	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
786a9275-d1fe-4817-b0d2-15c132826e57	2026-04-30 07:03:39.71768+00	6eb7b7d3-940d-4cff-932e-83b08f574c69	893bb307-08a3-4af2-ba54-6c5da32206ad	8f14fcef-19a1-40ed-8762-97b21c4c08ff	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
fea80ee4-db7d-4e2b-b165-b1e6f879b170	2026-04-30 07:03:40.412189+00	6eb7b7d3-940d-4cff-932e-83b08f574c69	322417b3-f05a-488c-b3b6-8956e7e4413a	\N	t	RATTRAPAGE À PREVOIR	f	2026-05-03	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
aa665e91-ec52-440f-b8d3-baf24d3bd432	2026-04-30 07:06:00.520512+00	06292f37-cb07-4aaf-9132-5e59d714defe	8a158331-8983-4d93-8d27-616394540f3d	059512a2-d080-480d-b201-84c5179e56ed	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
89859ddc-ae92-4511-9beb-6faa32a59bb0	2026-04-03 17:40:23.849479+00	40977b9e-1d07-47f0-8a4c-6f7a1a548211	1c9e7097-df1c-4540-b79b-35055f8f080f	5e250204-ceee-4813-b935-df2600156009	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
710790aa-5599-4da0-a783-9526f2b3b93f	2026-05-01 08:02:20.964526+00	40977b9e-1d07-47f0-8a4c-6f7a1a548211	97a3f8b8-caff-4988-b24a-2b7e54d155ee	73ee9ff1-680b-437e-95cd-9e79cae66d3a	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2025-12-20	f
91357b4a-4e2a-4a82-b1c2-f08aaaef3dee	2026-04-30 17:01:40.771573+00	2d2b77a4-539b-4ada-b69f-2b4bb2f092f3	9aa72019-ede1-4b37-a63b-400a20a683a7	25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	f	\N	t	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	2026-04-04	f
c95170c4-6fd1-47a1-9187-1e4b8e3e8bfd	2026-04-24 08:55:49.83846+00	98b0b557-b729-4a26-b50b-852c70e3f9a4	\N	dd17c985-0e39-48b8-8558-b6e76ec6c09c	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	t	Iris 5a	\N	f	\N	\N	\N	f
0cc440ab-58cf-4dc6-8fc8-ce42b9dacd75	2026-04-30 07:05:58.968815+00	06292f37-cb07-4aaf-9132-5e59d714defe	0328157c-5422-4fea-94a7-87f84d287645	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	t
0a7af5ab-8e51-49d8-a95b-fd39f1fb997f	2026-05-05 08:44:53.094286+00	6ab9e0f0-0d33-41ec-ac07-26dcbb9cf689	9430b606-42b0-45c9-aca3-c56c6d23d11b	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
ef5d3524-2a47-4759-a09d-b8961c01f59f	2026-05-05 08:44:53.094286+00	6ab9e0f0-0d33-41ec-ac07-26dcbb9cf689	86c197e6-24db-4d82-8572-d86b5ca15b2f	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
cc760f81-6ba3-43fa-8003-ae0ead683f1f	2026-05-05 08:44:53.094286+00	6ab9e0f0-0d33-41ec-ac07-26dcbb9cf689	00ef1cb1-a558-407b-8798-c0db3f382cb8	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
78c77f71-18b6-4bf3-9e93-f241e6f27fea	2026-05-05 08:44:53.746837+00	2dad5daa-3224-4053-93da-c40fa6a78ffb	1d2c9275-719e-452b-9298-ec476ac53155	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0ca319fd-1cd5-482f-87d2-cf2ec0e3171b	2026-05-05 08:44:53.746837+00	2dad5daa-3224-4053-93da-c40fa6a78ffb	7c879cb9-b214-4851-9fb7-cd84b0698bb7	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
c62d4028-91c6-46b6-ac3b-b2b22c5fa90a	2026-05-05 08:44:53.746837+00	2dad5daa-3224-4053-93da-c40fa6a78ffb	f04390c1-2a8d-406c-bf99-41d94e160925	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
0fbe2777-dd90-42ad-9d5e-bce254322b0c	2026-05-05 08:44:55.037797+00	e465b1a5-09cc-4311-bff0-24d55567df0a	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
8eb86043-fa31-4618-a4a3-73d5e1ce69d7	2026-05-05 08:44:55.037797+00	e465b1a5-09cc-4311-bff0-24d55567df0a	e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4f0f853a-0f75-41fe-bfa7-028d5ae1b5e6	2026-05-05 08:44:55.037797+00	e465b1a5-09cc-4311-bff0-24d55567df0a	01fdbddd-ee76-4200-a153-47cc61d67398	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
16c557fc-72e5-439b-ace2-8942b7db0e35	2026-05-05 08:44:55.037797+00	e465b1a5-09cc-4311-bff0-24d55567df0a	7374ef8e-c3b3-40aa-b6b4-7ae7159a7ce6	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
aea00db9-5bc1-4fd6-b28f-98d102bee1d4	2026-05-05 08:44:55.037797+00	e465b1a5-09cc-4311-bff0-24d55567df0a	d2566406-84dd-4204-a6c7-31a91107623a	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
a50c1d1a-4ffc-4ecb-9241-08525e893198	2026-05-05 08:44:54.445854+00	88d3b87c-68df-4fe0-9d9c-5e27bf5a3f1f	70610b82-10ea-46b2-a99b-59c187db69da	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
7d2f9819-b5a5-478f-afb7-d71d0f80f14c	2026-05-05 08:44:54.445854+00	88d3b87c-68df-4fe0-9d9c-5e27bf5a3f1f	7851fd12-1e6f-4a02-b957-c2120bc0ac83	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
5dba9268-e86a-4044-ba51-962892a6d0c2	2026-05-05 08:44:54.445854+00	88d3b87c-68df-4fe0-9d9c-5e27bf5a3f1f	a41687b8-6f23-46d2-abbb-285d71a1331c	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
1117a8d6-c489-42c0-a8f7-540ba1cc71e5	2026-05-05 08:44:54.445854+00	88d3b87c-68df-4fe0-9d9c-5e27bf5a3f1f	8b2745aa-d94a-48b9-be06-1aa87aac12d0	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
588800f6-d424-4b2b-b786-bbb0c56cee7a	2026-05-05 08:44:54.445854+00	88d3b87c-68df-4fe0-9d9c-5e27bf5a3f1f	386cac04-cc49-4dd7-bb14-b17b9760795b	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4d5e0177-0414-4161-bd70-de02933c2821	2026-05-05 08:44:54.445854+00	88d3b87c-68df-4fe0-9d9c-5e27bf5a3f1f	ed3a44cb-388f-431a-bf56-2d35af78ea8a	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
e59f10f7-845e-4268-baf7-f268c9c490e0	2026-05-05 08:48:18.879349+00	870888a9-da10-42bb-a778-f0363da3d929	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
b2e8db78-1263-40c4-af9a-dab771769380	2026-05-05 08:48:18.879349+00	870888a9-da10-42bb-a778-f0363da3d929	7e7447f5-56a1-4513-9606-978058d389d5	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
4cebfa02-e380-45aa-b3f0-728d2bdd5c74	2026-05-05 08:48:18.879349+00	870888a9-da10-42bb-a778-f0363da3d929	ceb5bad4-3051-4086-ac9c-a67e6c124aee	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
d5a740f5-2208-4099-968b-94866d6bac7f	2026-05-05 08:48:18.879349+00	870888a9-da10-42bb-a778-f0363da3d929	33600627-aea8-4768-8be4-eadb5152e41f	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
34a87072-7015-42b8-a5f9-376c2f893578	2026-05-05 08:48:18.879349+00	870888a9-da10-42bb-a778-f0363da3d929	8b6e4db3-9332-457c-8e1a-ad88af0c40be	\N	f	\N	f	\N	CLE_SECRETE_FRONTOFFICE	f	f	\N	\N	f	\N	\N	\N	f
\.


--
-- TOC entry 4021 (class 0 OID 67241)
-- Dependencies: 405
-- Data for Name: app_params; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.app_params (key, value, updated_at, app_key) FROM stdin;
rattrap_mode	semaines	2026-04-29 14:33:58.620062+00	\N
rattrap_semaines	8	2026-04-29 14:33:58.620062+00	\N
\.


--
-- TOC entry 4018 (class 0 OID 51502)
-- Dependencies: 402
-- Data for Name: app_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.app_settings (key, value, app_key) FROM stdin;
prix_heure_carte	0	CLE_SECRETE_FRONTOFFICE
\.


--
-- TOC entry 4025 (class 0 OID 67430)
-- Dependencies: 409
-- Data for Name: balade_participants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.balade_participants (id, created_at, balade_id, prenom, equide_id, note, app_key) FROM stdin;
\.


--
-- TOC entry 4024 (class 0 OID 67421)
-- Dependencies: 408
-- Data for Name: balades; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.balades (id, created_at, titre, date, heure, nb_places, note, app_key) FROM stdin;
\.


--
-- TOC entry 4017 (class 0 OID 51473)
-- Dependencies: 401
-- Data for Name: cartes_heures; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cartes_heures (id, cavalier_id, nb_heures, heures_utilisees, date_expiration, created_at, app_key, prix_heure, prix_total, regle, methode_paiement, date_reglement) FROM stdin;
18781044-c173-4948-976b-2bf6638e04e1	9430b606-42b0-45c9-aca3-c56c6d23d11b	10.0	5.0	\N	2026-04-05 10:00:23.112719+00	CLE_SECRETE_FRONTOFFICE	\N	\N	t	Espèces	\N
f9ba6c60-36a5-4269-b7e6-1ca01007affd	f04390c1-2a8d-406c-bf99-41d94e160925	6.0	0.0	2026-06-28	2026-04-29 13:18:18.285125+00	CLE_SECRETE_FRONTOFFICE	\N	145.00	f	\N	\N
0c3ec3f8-037e-45a1-bf97-403c0769ade8	893bb307-08a3-4af2-ba54-6c5da32206ad	35.0	26.0	2026-06-30	2026-03-27 07:59:34.410395+00	CLE_SECRETE_FRONTOFFICE	\N	715.00	t	Chèque	2025-09-01
a5997923-a6e2-488e-b1f1-34ce53cbb8c5	aaedc900-37ff-4b01-88cb-82c36deffca8	35.0	18.0	2026-06-30	2026-03-27 14:18:32.952059+00	CLE_SECRETE_FRONTOFFICE	\N	715.00	t	Chèque	2025-09-01
fab8678f-7937-4841-a39c-2d45a3ddc27f	322417b3-f05a-488c-b3b6-8956e7e4413a	35.0	23.0	2026-06-30	2026-03-27 14:20:29.248537+00	CLE_SECRETE_FRONTOFFICE	\N	715.00	t	Chèque	2025-09-01
5fccdffc-b62c-47ef-8d6e-cef93d58a744	466a4031-fc42-48c9-88c5-1a1925e19912	28.0	18.0	2026-06-30	2026-03-27 14:35:14.022283+00	CLE_SECRETE_FRONTOFFICE	\N	600.00	t	Chèque	2026-06-30
21b93b11-1f42-4009-bc85-6e178cf5cd90	0328157c-5422-4fea-94a7-87f84d287645	17.0	8.0	2026-06-30	2026-04-01 18:33:46.431958+00	CLE_SECRETE_FRONTOFFICE	\N	\N	t	\N	\N
b74a4029-5f7c-4436-87bf-554b196eb830	19dfcd2c-5aaf-4e09-ac63-9856393cfb3c	18.0	14.0	2026-06-30	2026-03-27 14:42:48.181038+00	CLE_SECRETE_FRONTOFFICE	\N	500.00	t	Chèque	2025-09-01
d02294d4-87f4-412f-906c-d5b4dfc65e94	8dab5312-dbee-4f86-83dd-0874ffc99c46	35.0	23.0	2026-06-30	2026-03-27 14:21:03.846039+00	CLE_SECRETE_FRONTOFFICE	\N	715.00	t	Chèque	2025-09-01
94cb445e-33a6-4f24-98ed-f9b494b85ae8	3cbd32b1-84a7-4596-92d0-903d6ea1f631	35.0	24.0	2026-06-30	2026-03-27 14:17:47.033794+00	CLE_SECRETE_FRONTOFFICE	\N	715.00	t	Chèque	2025-09-01
1a471bd8-e6dc-4b14-806c-ed82098fdec2	080111ef-d8d7-4662-ba20-cd5ff1bfa389	35.0	24.0	2026-06-30	2026-03-27 14:19:06.871049+00	CLE_SECRETE_FRONTOFFICE	\N	715.00	t	Chèque	2025-09-01
3695a364-f7fe-4f8a-ac87-d7b09616ecf8	8a158331-8983-4d93-8d27-616394540f3d	35.0	18.0	2026-06-30	2026-03-27 14:36:22.001937+00	CLE_SECRETE_FRONTOFFICE	\N	715.00	t	Chèque	2025-09-01
61d5458d-854e-4f4d-a07d-550cd37b28dd	7fb3adc8-4473-43a4-84a8-c76a60e2665f	18.0	15.0	2026-06-30	2026-03-27 14:42:09.257384+00	CLE_SECRETE_FRONTOFFICE	\N	500.00	t	Chèque	2025-09-01
76b37fdf-aeb6-4672-8944-d09029388f3b	36a719ea-eaed-49cd-90a2-9bdd63680f2e	10.0	0.0	\N	2026-03-27 15:28:11.524101+00	CLE_SECRETE_FRONTOFFICE	\N	\N	t	Pass	\N
934de872-dadf-4d27-8eb4-152a29fef3bf	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	22.0	0.0	2026-06-30	2026-04-04 07:34:11.332969+00	CLE_SECRETE_FRONTOFFICE	\N	\N	t	Chèque	\N
\.


--
-- TOC entry 4007 (class 0 OID 22364)
-- Dependencies: 388
-- Data for Name: cavalier_groupes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cavalier_groupes (id, cavalier_id, groupe_id, app_key) FROM stdin;
3e58d7cd-cac1-48ba-adb0-c57c6d60e165	9430b606-42b0-45c9-aca3-c56c6d23d11b	5527fa09-42da-4b9f-b771-4de9e20434f2	CLE_SECRETE_FRONTOFFICE
3d5c9e4b-6893-4bd0-9fc0-e9634d344505	86c197e6-24db-4d82-8572-d86b5ca15b2f	5527fa09-42da-4b9f-b771-4de9e20434f2	CLE_SECRETE_FRONTOFFICE
f07a9fe2-85a3-4ba4-b72d-acd5aa4d8c48	00ef1cb1-a558-407b-8798-c0db3f382cb8	5527fa09-42da-4b9f-b771-4de9e20434f2	CLE_SECRETE_FRONTOFFICE
85a13b3b-748a-47f0-8681-13ea04b2b6bf	a3f3ccb1-7c00-4b52-9837-dc69331b521c	5527fa09-42da-4b9f-b771-4de9e20434f2	CLE_SECRETE_FRONTOFFICE
c659fb90-9821-4b49-9474-91bc21b26970	f6b2c3bc-2197-44c1-a848-d18a66e3fdf5	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	CLE_SECRETE_FRONTOFFICE
6dfb2f87-e032-4137-866f-3680c22bcdcf	b0054d27-f377-41ad-a026-a2893c27692a	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	CLE_SECRETE_FRONTOFFICE
3cb9cc1d-3547-4187-9916-b53f833b77c7	1d2c9275-719e-452b-9298-ec476ac53155	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	CLE_SECRETE_FRONTOFFICE
bb3a7af6-fa08-4ece-9c02-540110b9806b	7c879cb9-b214-4851-9fb7-cd84b0698bb7	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	CLE_SECRETE_FRONTOFFICE
fe9e617c-68a9-428b-8336-c82c63e7537c	70610b82-10ea-46b2-a99b-59c187db69da	d1d6dfcd-90a7-4870-b8d6-a993a8897810	CLE_SECRETE_FRONTOFFICE
c51b1e7c-8b27-4e1d-bb8c-158b1b9fddd5	7851fd12-1e6f-4a02-b957-c2120bc0ac83	d1d6dfcd-90a7-4870-b8d6-a993a8897810	CLE_SECRETE_FRONTOFFICE
9396eaa3-368a-446e-b523-215b5d86e952	a41687b8-6f23-46d2-abbb-285d71a1331c	d1d6dfcd-90a7-4870-b8d6-a993a8897810	CLE_SECRETE_FRONTOFFICE
644c5064-1186-4cd6-bdbe-34338908efe1	8b2745aa-d94a-48b9-be06-1aa87aac12d0	d1d6dfcd-90a7-4870-b8d6-a993a8897810	CLE_SECRETE_FRONTOFFICE
bd9c182e-956f-493a-a854-1001fcff9d9e	386cac04-cc49-4dd7-bb14-b17b9760795b	d1d6dfcd-90a7-4870-b8d6-a993a8897810	CLE_SECRETE_FRONTOFFICE
206c34b1-9241-4678-9b56-8d2ceefec4f6	ed3a44cb-388f-431a-bf56-2d35af78ea8a	d1d6dfcd-90a7-4870-b8d6-a993a8897810	CLE_SECRETE_FRONTOFFICE
9ab275dd-7581-49b0-b958-1164bd0ad686	e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	c1625acc-f295-448e-8020-1a5ca3bfd564	CLE_SECRETE_FRONTOFFICE
3364a142-4916-4305-9549-9a29e3c1b697	e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	c1625acc-f295-448e-8020-1a5ca3bfd564	CLE_SECRETE_FRONTOFFICE
5889a61f-5713-4e1e-a34b-d3317e3b5a95	01fdbddd-ee76-4200-a153-47cc61d67398	c1625acc-f295-448e-8020-1a5ca3bfd564	CLE_SECRETE_FRONTOFFICE
244dbde9-d8e1-4326-b474-15c7f8a416e4	7374ef8e-c3b3-40aa-b6b4-7ae7159a7ce6	c1625acc-f295-448e-8020-1a5ca3bfd564	CLE_SECRETE_FRONTOFFICE
7919b53d-6e15-48f7-9d21-d43373179a47	d2566406-84dd-4204-a6c7-31a91107623a	c1625acc-f295-448e-8020-1a5ca3bfd564	CLE_SECRETE_FRONTOFFICE
2c9a45a8-2f70-4a7d-804f-730ebc0b78d9	9c87739b-74ad-47b9-a70f-6efc26c93f00	9a893581-9a76-4bb2-a519-a9aa764ae4ff	CLE_SECRETE_FRONTOFFICE
7d56bedc-d977-4b0e-9548-64022b78ecc4	f9ae7eae-fb53-4793-91d7-598ef0c5ea29	9a893581-9a76-4bb2-a519-a9aa764ae4ff	CLE_SECRETE_FRONTOFFICE
ed0ada8e-6887-4d85-85e8-820deb31c9ea	ce4184ad-5144-4b9b-8276-0111197e0885	9a893581-9a76-4bb2-a519-a9aa764ae4ff	CLE_SECRETE_FRONTOFFICE
06c63940-1393-4b7c-82b7-89602508b340	9aa72019-ede1-4b37-a63b-400a20a683a7	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	CLE_SECRETE_FRONTOFFICE
edbf8637-462a-471b-9202-d55f98500ab0	01fdbddd-ee76-4200-a153-47cc61d67398	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	CLE_SECRETE_FRONTOFFICE
9481fc35-4126-4235-bbc8-8cb21766979d	1c9e7097-df1c-4540-b79b-35055f8f080f	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	CLE_SECRETE_FRONTOFFICE
fbf4f7a7-82fa-4496-affa-8707b8da4d6b	7dd68452-30ed-4829-857d-bebc61aff9c1	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	CLE_SECRETE_FRONTOFFICE
789d37cf-5f73-43a1-b76b-252382f003f6	b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	CLE_SECRETE_FRONTOFFICE
18a7ded1-742e-4092-b941-eb57f407ebf6	909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	38f2a4bd-910d-4595-bb77-34c92b353749	CLE_SECRETE_FRONTOFFICE
771377b8-0634-4bcb-af9e-6594c4fae7ff	3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	38f2a4bd-910d-4595-bb77-34c92b353749	CLE_SECRETE_FRONTOFFICE
22cf2608-86b3-4d52-ab91-b98656c75c7d	7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	38f2a4bd-910d-4595-bb77-34c92b353749	CLE_SECRETE_FRONTOFFICE
cc4f52c4-b03d-4de7-8b26-0930e1ae5eb2	13e202ee-272d-415f-8d66-f7669b85afb8	38f2a4bd-910d-4595-bb77-34c92b353749	CLE_SECRETE_FRONTOFFICE
13bd4ba3-9fb1-401c-a2b0-6e9ed154a2c6	6c379005-03bc-478f-aabd-ad3f75f6477a	38f2a4bd-910d-4595-bb77-34c92b353749	CLE_SECRETE_FRONTOFFICE
0e4f1c9e-7afc-4b68-a44d-2e9834969f18	2d98b2aa-9762-4798-8e28-fcb15c380bf5	38f2a4bd-910d-4595-bb77-34c92b353749	CLE_SECRETE_FRONTOFFICE
5648bb78-80b1-4e11-8fc1-4763eb2c635f	97a3f8b8-caff-4988-b24a-2b7e54d155ee	38f2a4bd-910d-4595-bb77-34c92b353749	CLE_SECRETE_FRONTOFFICE
59c0606d-fcee-44ab-bd46-2ec10b7994c2	bbe34f6d-840a-4ac6-b7e4-c133aa6df224	e835851b-18fd-46da-9c66-8bbd99f8690c	CLE_SECRETE_FRONTOFFICE
63258af5-71f6-4745-973b-cdeb3f53d6de	7e7447f5-56a1-4513-9606-978058d389d5	e835851b-18fd-46da-9c66-8bbd99f8690c	CLE_SECRETE_FRONTOFFICE
bda98580-9d0b-4598-93cc-4512a26f5749	ceb5bad4-3051-4086-ac9c-a67e6c124aee	e835851b-18fd-46da-9c66-8bbd99f8690c	CLE_SECRETE_FRONTOFFICE
c30df812-91ee-4468-a63e-8469dcc3fbc7	eae152a0-23cd-43ab-bdad-5f8d729f4bd7	97fd116b-b25f-459e-b8d7-a08052916748	CLE_SECRETE_FRONTOFFICE
cf081c5a-15e7-46f5-a0a1-c6513b120b0b	8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	97fd116b-b25f-459e-b8d7-a08052916748	CLE_SECRETE_FRONTOFFICE
5771fe5c-4469-4073-bd0c-945a053447fd	888cdaa5-6b9e-4ea8-a263-587ceaf742cc	97fd116b-b25f-459e-b8d7-a08052916748	CLE_SECRETE_FRONTOFFICE
8658ee95-c990-4b82-a138-52d0431270a5	bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	9a893581-9a76-4bb2-a519-a9aa764ae4ff	CLE_SECRETE_FRONTOFFICE
e7dac77c-c34d-444c-83ae-3a332f27c34c	33600627-aea8-4768-8be4-eadb5152e41f	e835851b-18fd-46da-9c66-8bbd99f8690c	CLE_SECRETE_FRONTOFFICE
4abdfb46-b2d3-4be2-b28c-dc87b41814d6	8b6e4db3-9332-457c-8e1a-ad88af0c40be	e835851b-18fd-46da-9c66-8bbd99f8690c	CLE_SECRETE_FRONTOFFICE
868285a9-c7bb-4a22-b00c-673f02e3756f	ddbca8c2-9bfd-4ab2-90d1-8c8127be9331	e835851b-18fd-46da-9c66-8bbd99f8690c	CLE_SECRETE_FRONTOFFICE
93adc4c8-6264-4454-af26-865a08b11c0a	f04390c1-2a8d-406c-bf99-41d94e160925	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	CLE_SECRETE_FRONTOFFICE
\.


--
-- TOC entry 4006 (class 0 OID 22355)
-- Dependencies: 387
-- Data for Name: cavaliers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cavaliers (id, created_at, prenom, telephone, app_key, nom, semaine_type) FROM stdin;
86563425-d0cb-4c79-a35b-3a7863eb7751	2026-02-23 13:55:37.502954+00	Eden	\N	CLE_SECRETE_FRONTOFFICE	\N	toutes
9b9517c0-f208-4a69-b40e-5aeac1c5b3d6	2026-02-23 13:55:43.48146+00	Loan	\N	CLE_SECRETE_FRONTOFFICE	\N	toutes
81a862b9-8d89-413e-b37c-a0b7bcea5f8f	2026-02-23 13:55:47.595048+00	Giulia	\N	CLE_SECRETE_FRONTOFFICE	\N	toutes
7fe12d3a-e32d-4265-af1a-ce89e1d1a4b7	2026-02-23 13:58:45.383222+00	Fantine	\N	CLE_SECRETE_FRONTOFFICE	BOIX VERICEL	toutes
bbe34f6d-840a-4ac6-b7e4-c133aa6df224	2026-02-23 13:59:39.112724+00	Hugo	\N	CLE_SECRETE_FRONTOFFICE	PATRICK BOUVIER	toutes
01fdbddd-ee76-4200-a153-47cc61d67398	2026-02-23 13:57:15.054501+00	Laurence	\N	CLE_SECRETE_FRONTOFFICE	DECLERCY	toutes
b7f14ad3-98a4-46b3-9bf0-3d9ff1224f58	2026-02-23 14:06:30.386377+00	Laurine	\N	CLE_SECRETE_FRONTOFFICE	SEON	toutes
13e202ee-272d-415f-8d66-f7669b85afb8	2026-02-23 13:58:50.798682+00	Léa	\N	CLE_SECRETE_FRONTOFFICE	SCHMID	toutes
9c87739b-74ad-47b9-a70f-6efc26c93f00	2026-02-23 13:57:31.088663+00	Alexandra	\N	CLE_SECRETE_FRONTOFFICE	BRUNET RAS	toutes
909b1f8b-ec6d-4cf1-b72a-27c2e21a0058	2026-02-23 13:58:09.150305+00	Ambre	\N	CLE_SECRETE_FRONTOFFICE	DE SOUSA	toutes
e2a2dffe-c82f-4cb9-872c-cb82574e8e6b	2026-02-23 13:57:05.337982+00	Anne-Sophie	\N	CLE_SECRETE_FRONTOFFICE	SAUNIER	toutes
f6b2c3bc-2197-44c1-a848-d18a66e3fdf5	2026-02-23 13:56:15.614918+00	Arthur	\N	CLE_SECRETE_FRONTOFFICE	HERVIER	toutes
70610b82-10ea-46b2-a99b-59c187db69da	2026-02-23 13:56:37.817502+00	Célina	\N	CLE_SECRETE_FRONTOFFICE	BOUZOUIK	toutes
e3f117d1-0e2e-4ba2-ab0b-1e4235587c21	2026-02-23 13:57:37.658812+00	Céline	\N	CLE_SECRETE_FRONTOFFICE	RENAULT D'ARRAS	toutes
bc4551a7-5ab1-4b28-9fca-53ca62e4abc7	2026-03-09 13:29:17.261687+00	Céline	\N	CLE_SECRETE_FRONTOFFICE	TROMPETTA	toutes
9aa72019-ede1-4b37-a63b-400a20a683a7	2026-02-23 13:57:48.665759+00	Charlotte	\N	CLE_SECRETE_FRONTOFFICE	MUSY	toutes
eae152a0-23cd-43ab-bdad-5f8d729f4bd7	2026-02-23 14:00:05.425004+00	Chloé	\N	CLE_SECRETE_FRONTOFFICE	VANEL	toutes
97a3f8b8-caff-4988-b24a-2b7e54d155ee	2026-02-23 13:56:41.882908+00	Clémence	\N	CLE_SECRETE_FRONTOFFICE	MATHEVET	toutes
7851fd12-1e6f-4a02-b957-c2120bc0ac83	2026-02-23 13:58:22.601372+00	Clémence	\N	CLE_SECRETE_FRONTOFFICE	PAILLARD	toutes
9430b606-42b0-45c9-aca3-c56c6d23d11b	2026-02-23 13:55:52.258419+00	Clémentine	\N	CLE_SECRETE_FRONTOFFICE	RENAULT D'ARRAS	toutes
8ba0dc88-11b8-476f-b18d-d89cb1b42ebb	2026-02-23 14:00:09.688011+00	Éloïse	\N	CLE_SECRETE_FRONTOFFICE	NICOLAS VERNET	toutes
a41687b8-6f23-46d2-abbb-285d71a1331c	2026-02-23 13:56:44.872528+00	Elyssa	\N	CLE_SECRETE_FRONTOFFICE	DI MEMBRO	toutes
3842b89a-d6b4-4ccd-9f4e-2715ecbb497d	2026-02-23 13:58:42.381232+00	Émily	\N	CLE_SECRETE_FRONTOFFICE	MATHEVET	toutes
8b2745aa-d94a-48b9-be06-1aa87aac12d0	2026-02-23 13:56:47.621944+00	Emma	\N	CLE_SECRETE_FRONTOFFICE	GIMMENO	toutes
7e7447f5-56a1-4513-9606-978058d389d5	2026-02-23 13:59:17.689599+00	Léana	\N	CLE_SECRETE_FRONTOFFICE	CHAPON	toutes
386cac04-cc49-4dd7-bb14-b17b9760795b	2026-02-23 13:56:53.575193+00	Léna	\N	CLE_SECRETE_FRONTOFFICE	CAPUANO	toutes
86c197e6-24db-4d82-8572-d86b5ca15b2f	2026-02-23 13:55:59.99871+00	Leyna	\N	CLE_SECRETE_FRONTOFFICE	ROUSSET	toutes
00ef1cb1-a558-407b-8798-c0db3f382cb8	2026-02-23 13:56:06.042338+00	Liza	\N	CLE_SECRETE_FRONTOFFICE	TARDY	toutes
b0054d27-f377-41ad-a026-a2893c27692a	2026-02-23 13:56:20.922398+00	Lou-Rose	\N	CLE_SECRETE_FRONTOFFICE	DIMIER	toutes
6c379005-03bc-478f-aabd-ad3f75f6477a	2026-02-23 13:58:56.600616+00	Louise	\N	CLE_SECRETE_FRONTOFFICE	BOUILHOL	toutes
33600627-aea8-4768-8be4-eadb5152e41f	2026-03-13 16:26:21.564387+00	Romy	\N	CLE_SECRETE_FRONTOFFICE	BRUYAS	toutes
ed3a44cb-388f-431a-bf56-2d35af78ea8a	2026-02-23 13:56:57.962919+00	Mathilde	\N	CLE_SECRETE_FRONTOFFICE	PERROT	toutes
888cdaa5-6b9e-4ea8-a263-587ceaf742cc	2026-02-23 14:00:14.666342+00	Mélina	\N	CLE_SECRETE_FRONTOFFICE	NICOLAS VERNET	toutes
1c9e7097-df1c-4540-b79b-35055f8f080f	2026-02-23 13:57:57.530969+00	Mélinée	\N	CLE_SECRETE_FRONTOFFICE	YEGUIAYAN	toutes
ceb5bad4-3051-4086-ac9c-a67e6c124aee	2026-02-23 13:59:31.564156+00	Mila	\N	CLE_SECRETE_FRONTOFFICE	OLLER CERVELLERA	toutes
a3f3ccb1-7c00-4b52-9837-dc69331b521c	2026-02-23 13:56:09.881544+00	Mila	\N	CLE_SECRETE_FRONTOFFICE	VAVRO	toutes
1d2c9275-719e-452b-9298-ec476ac53155	2026-02-23 13:56:26.017137+00	Milo	\N	CLE_SECRETE_FRONTOFFICE	RIOU PICCO	toutes
2d98b2aa-9762-4798-8e28-fcb15c380bf5	2026-02-23 13:58:59.615121+00	Nathan	\N	CLE_SECRETE_FRONTOFFICE	MATHEVET	toutes
7dd68452-30ed-4829-857d-bebc61aff9c1	2026-02-23 13:58:00.523066+00	Ophélie	\N	CLE_SECRETE_FRONTOFFICE	DODEY	toutes
f9ae7eae-fb53-4793-91d7-598ef0c5ea29	2026-02-23 13:57:40.985834+00	Sarah	\N	CLE_SECRETE_FRONTOFFICE	MATHIOTTE	toutes
7c879cb9-b214-4851-9fb7-cd84b0698bb7	2026-02-23 13:56:29.590673+00	Soumaya	\N	CLE_SECRETE_FRONTOFFICE	ANGOSTON	toutes
ce4184ad-5144-4b9b-8276-0111197e0885	2026-02-23 13:57:43.665546+00	Valérian	\N	CLE_SECRETE_FRONTOFFICE	RAS	toutes
893bb307-08a3-4af2-ba54-6c5da32206ad	2026-03-16 16:13:55.048517+00	Angélique	\N	CLE_SECRETE_FRONTOFFICE	DELANGLE	toutes
3cbd32b1-84a7-4596-92d0-903d6ea1f631	2026-03-16 16:14:13.147233+00	Bob	\N	CLE_SECRETE_FRONTOFFICE	BA	toutes
d2566406-84dd-4204-a6c7-31a91107623a	2026-02-23 13:57:19.898039+00	Marine	\N	CLE_SECRETE_FRONTOFFICE	MARION-WUILLEMIN	toutes
7374ef8e-c3b3-40aa-b6b4-7ae7159a7ce6	2026-02-23 13:57:25.827285+00	Marine	\N	CLE_SECRETE_FRONTOFFICE	BLONDELLE	toutes
080111ef-d8d7-4662-ba20-cd5ff1bfa389	2026-03-16 16:14:44.169271+00	Florence	\N	CLE_SECRETE_FRONTOFFICE	BA	toutes
322417b3-f05a-488c-b3b6-8956e7e4413a	2026-03-16 16:16:48.168408+00	Océane	\N	CLE_SECRETE_FRONTOFFICE	MATTIATO	toutes
8dab5312-dbee-4f86-83dd-0874ffc99c46	2026-03-16 16:17:23.834563+00	Pauline	\N	CLE_SECRETE_FRONTOFFICE	CHETAIL SYSSAU	toutes
aaedc900-37ff-4b01-88cb-82c36deffca8	2026-03-16 16:17:42.265954+00	Clémence	\N	CLE_SECRETE_FRONTOFFICE	GESSE-ENTRESSANGLE	toutes
8a158331-8983-4d93-8d27-616394540f3d	2026-03-16 16:17:53.839539+00	Vénitia	\N	CLE_SECRETE_FRONTOFFICE	VAUGON RIFFE	toutes
f056b2e2-8510-45d1-b81a-a1d06ab18dd1	2026-03-16 16:18:14.111794+00	Audette	\N	CLE_SECRETE_FRONTOFFICE	VAUGON RIFFE	toutes
7fb3adc8-4473-43a4-84a8-c76a60e2665f	2026-03-16 16:18:50.308937+00	Kahina	\N	CLE_SECRETE_FRONTOFFICE	BEZAOU	toutes
19dfcd2c-5aaf-4e09-ac63-9856393cfb3c	2026-03-16 16:19:18.049928+00	Mélanie	\N	CLE_SECRETE_FRONTOFFICE	SYSSAU	toutes
466a4031-fc42-48c9-88c5-1a1925e19912	2026-03-16 16:19:43.825499+00	Saffiya	\N	CLE_SECRETE_FRONTOFFICE	CHAHED	toutes
0328157c-5422-4fea-94a7-87f84d287645	2026-03-16 16:19:56.692178+00	Amira	\N	CLE_SECRETE_FRONTOFFICE	CHAHED	toutes
f04390c1-2a8d-406c-bf99-41d94e160925	2026-04-29 13:18:14.22943+00	Giulia	0625607857	CLE_SECRETE_FRONTOFFICE	BANDE	toutes
8b6e4db3-9332-457c-8e1a-ad88af0c40be	2026-02-23 13:59:07.815614+00	Augustine	\N	CLE_SECRETE_FRONTOFFICE	MATHEVET	impaire
ddbca8c2-9bfd-4ab2-90d1-8c8127be9331	2026-02-23 13:59:12.725582+00	Clarisse	\N	CLE_SECRETE_FRONTOFFICE	RODRIGUES LARANJEIRA	paire
36a719ea-eaed-49cd-90a2-9bdd63680f2e	2026-03-27 15:28:11.251606+00	test	\N	CLE_SECRETE_FRONTOFFICE	test	toutes
\.


--
-- TOC entry 4015 (class 0 OID 38092)
-- Dependencies: 397
-- Data for Name: discipline_icons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.discipline_icons (id, created_at, discipline, icon_url, app_key) FROM stdin;
3114b25a-d59b-436f-90f3-6dd657efa8ee	2026-03-10 08:20:31.702205+00	OBSTACLE	https://sruaalaxmjdbaehjfrch.supabase.co/storage/v1/object/public/discipline-icons/obstacle.png	CLE_SECRETE_FRONTOFFICE
375ef49a-58bf-4707-b2e4-aa9ebe5f152f	2026-03-10 08:27:39.892138+00	EQUIFEEL	https://sruaalaxmjdbaehjfrch.supabase.co/storage/v1/object/public/discipline-icons/equifeel.png	CLE_SECRETE_FRONTOFFICE
dadeac9a-1fc4-487c-a28e-a33e35c34c5f	2026-03-10 08:27:46.462859+00	EQUIFUN	https://sruaalaxmjdbaehjfrch.supabase.co/storage/v1/object/public/discipline-icons/equifun.png	CLE_SECRETE_FRONTOFFICE
1fe1f953-ed1d-4303-a7cd-e514d2169967	2026-03-10 08:27:50.812373+00	HORSEBALL	https://sruaalaxmjdbaehjfrch.supabase.co/storage/v1/object/public/discipline-icons/horseball.png	CLE_SECRETE_FRONTOFFICE
cc680895-189a-48f2-ab76-5f8b2bb09ad6	2026-03-10 08:28:04.377867+00	VOLTIGE	https://sruaalaxmjdbaehjfrch.supabase.co/storage/v1/object/public/discipline-icons/voltige.png	CLE_SECRETE_FRONTOFFICE
0c929797-3903-4a91-8788-e9b1b7b6ba26	2026-03-10 08:28:20.554311+00	LONGE	https://sruaalaxmjdbaehjfrch.supabase.co/storage/v1/object/public/discipline-icons/longe.png	CLE_SECRETE_FRONTOFFICE
4283cac5-bcca-41db-9d36-cea1594604d1	2026-03-10 08:27:36.105209+00	DRESSAGE	https://sruaalaxmjdbaehjfrch.supabase.co/storage/v1/object/public/discipline-icons/dressage.png	CLE_SECRETE_FRONTOFFICE
4a3f2f45-7c07-4b9f-a6b3-ff58754083bf	2026-03-11 13:53:16.495779+00	LONGUES-RÊNES	https://sruaalaxmjdbaehjfrch.supabase.co/storage/v1/object/public/discipline-icons/longues-renes.png	CLE_SECRETE_FRONTOFFICE
ed80b679-f0aa-4f7e-a8dc-1c4691f40036	2026-03-11 13:55:02.847326+00	SPRING GARDEN	https://sruaalaxmjdbaehjfrch.supabase.co/storage/v1/object/public/discipline-icons/spring-garden.png	CLE_SECRETE_FRONTOFFICE
bd0dca15-eaef-426a-b1d7-8e22cf3f831c	2026-03-11 13:58:18.173311+00	BALADE	https://sruaalaxmjdbaehjfrch.supabase.co/storage/v1/object/public/discipline-icons/balade.png	CLE_SECRETE_FRONTOFFICE
d50be117-fa32-46fc-b6f8-563c22d23a7a	2026-03-24 08:42:41.731815+00	SOINS	https://sruaalaxmjdbaehjfrch.supabase.co/storage/v1/object/public/discipline-icons/soins.png	CLE_SECRETE_FRONTOFFICE
ccafbc8e-37d5-43cd-b6b6-bffd7ea4c0be	2026-03-10 08:29:16.967118+00	JEUX	https://sruaalaxmjdbaehjfrch.supabase.co/storage/v1/object/public/discipline-icons/jeux.png	CLE_SECRETE_FRONTOFFICE
578ed131-f4e7-4cab-abe9-6c0d81e21e30	2026-03-11 13:55:18.065983+00	THÉORIE	https://sruaalaxmjdbaehjfrch.supabase.co/storage/v1/object/public/discipline-icons/theorie.png	CLE_SECRETE_FRONTOFFICE
ccc5fc30-4045-4ed7-ae72-a1ee00a53083	2026-03-24 18:41:19.05032+00	- PAS COURS	https://sruaalaxmjdbaehjfrch.supabase.co/storage/v1/object/public/discipline-icons/.png	CLE_SECRETE_FRONTOFFICE
c2464827-4189-4a4c-b581-7e90806f6246	2026-03-25 10:08:14.561589+00	MISE EN ROUTE	https://sruaalaxmjdbaehjfrch.supabase.co/storage/v1/object/public/discipline-icons/mise-en-route.jpg	CLE_SECRETE_FRONTOFFICE
2f318bf4-95db-4596-8388-3c4aa029d9d2	2026-04-24 06:09:37.19909+00	CROSS	https://sruaalaxmjdbaehjfrch.supabase.co/storage/v1/object/public/discipline-icons/cross.png	CLE_SECRETE_FRONTOFFICE
0005b07d-2723-4822-abed-13bda0ae7d39	2026-03-10 08:26:16.221521+00	OBSTACLE MES	https://sruaalaxmjdbaehjfrch.supabase.co/storage/v1/object/public/discipline-icons/mes-obstacle.png	CLE_SECRETE_FRONTOFFICE
b810c951-29f2-44f4-ab2d-6a2634d2a2b9	2026-03-11 13:54:19.241113+00	DRESSAGE MES	https://sruaalaxmjdbaehjfrch.supabase.co/storage/v1/object/public/discipline-icons/mes-plat.png	CLE_SECRETE_FRONTOFFICE
4e100eb2-2501-4acd-a2f7-07325599a4b5	2026-03-11 13:58:46.174473+00	OBSTACLE BAS	https://sruaalaxmjdbaehjfrch.supabase.co/storage/v1/object/public/discipline-icons/bas.png	CLE_SECRETE_FRONTOFFICE
5e8d1f93-ca2d-4522-91b0-d45de2db544b	2026-04-26 06:07:19.079389+00	ATTELAGE	https://sruaalaxmjdbaehjfrch.supabase.co/storage/v1/object/public/discipline-icons/attelage.png	CLE_SECRETE_FRONTOFFICE
\.


--
-- TOC entry 4016 (class 0 OID 38111)
-- Dependencies: 398
-- Data for Name: disciplines; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.disciplines (id, nom, created_at) FROM stdin;
4f984f99-b5b0-4dcc-a446-a7c2d3ee7ab8	BALADE	2026-03-10 09:35:54.02273+00
f88e7187-cc55-4c14-b237-8e01510c2cc9	DRESSAGE	2026-03-10 09:35:54.02273+00
4ba0e316-52e4-4cde-91bf-bdc4633493f1	EQUIFEEL	2026-03-10 09:35:54.02273+00
570c6848-1fa3-4132-86c6-023f6e015689	EQUIFUN	2026-03-10 09:35:54.02273+00
c34bb516-54cd-4bb1-ad4c-ec4581752598	HORSEBALL	2026-03-10 09:35:54.02273+00
cd850870-eeb4-48d0-a697-ab40cc8dd294	JEUX	2026-03-10 09:35:54.02273+00
1c13ed9f-63c1-4ad4-bc12-34846ae29706	LONGE	2026-03-10 09:35:54.02273+00
d8ae762d-96d1-4529-bc2e-8229c4d3aebf	MISE EN ROUTE	2026-03-10 09:35:54.02273+00
43b50fee-57dc-499c-9dee-0de5ac1907b6	OBSTACLE	2026-03-10 09:35:54.02273+00
8fd16e78-cb5b-4568-aa59-977c5214ab3e	SOINS	2026-03-10 09:35:54.02273+00
3e378522-ba40-47cd-baa9-f6d15eba96bd	SPRING GARDEN	2026-03-10 09:35:54.02273+00
94786861-29a2-4250-a2bf-66c58a2ec006	THÉORIE	2026-03-10 09:35:54.02273+00
efe52b29-0374-4fdf-9404-9eab6b584f28	VOLTIGE	2026-03-10 09:35:54.02273+00
a6cfd67e-3a8c-4c21-bc19-509c4d41d3e1	LONGUES-RÊNES	2026-03-11 13:53:15.245707+00
def53ebf-03e6-4027-882e-213beae83eed	- PAS COURS	2026-03-24 18:40:36.861701+00
c969719c-ea31-40e2-9b1a-a3cc00902791	CROSS	2026-04-24 06:09:35.669933+00
1646353a-8835-4707-b573-48e542fa1515	OBSTACLE MES	2026-03-10 09:35:54.02273+00
fcd31ff8-b486-459f-bf25-1135daa6056e	DRESSAGE MES	2026-03-10 09:35:54.02273+00
46eeea1e-75e9-4fa4-b599-d51326e390a6	OBSTACLE BAS	2026-03-10 09:35:54.02273+00
0d56c715-b7f8-4362-aa9b-e9f5f6e550ba	ATTELAGE	2026-04-26 06:06:42.702211+00
\.


--
-- TOC entry 4009 (class 0 OID 22396)
-- Dependencies: 390
-- Data for Name: equide_statuts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.equide_statuts (id, created_at, equide_id, type, date, date_fin, heure_debut, heure_fin, note, app_key) FROM stdin;
\.


--
-- TOC entry 4008 (class 0 OID 22384)
-- Dependencies: 389
-- Data for Name: equides; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.equides (id, created_at, nom, categorie, annee_naissance, heures_prev, hors_cours, app_key, note, heures_reel) FROM stdin;
76876dd9-f4c0-455c-9b22-08799cc72af0	2026-03-16 14:22:52.684349+00	ORIANTE	ZePROPRIO	2002	0.00	f	CLE_SECRETE_FRONTOFFICE	\N	0
73ee9ff1-680b-437e-95cd-9e79cae66d3a	2026-02-23 14:12:26.357887+00	CHARLY	Cheval	2012	9.00	f	CLE_SECRETE_FRONTOFFICE	\N	10
8d1e0213-3958-4a1a-8d8a-473cd765cebf	2026-02-23 14:32:40.478866+00	JAKAR	ZePROPRIO	2019	5.00	f	CLE_SECRETE_FRONTOFFICE	\N	0
835b104d-b18b-4876-ba72-ffea56c43563	2026-02-23 14:32:52.364394+00	LOW RIDER	ZePROPRIO	2021	5.00	f	CLE_SECRETE_FRONTOFFICE	\N	0
8f14fcef-19a1-40ed-8762-97b21c4c08ff	2026-02-23 14:11:47.752773+00	SCOUBIDOU	Cheval	2006	9.00	f	CLE_SECRETE_FRONTOFFICE	\N	13
0eb305fa-16fe-477a-ada1-be2770088837	2026-03-24 09:18:25.402809+00	-	ZePROPRIO	2000	0.00	f	CLE_SECRETE_FRONTOFFICE	\N	0
59d10619-f4b1-4f0a-8b2c-29c0062fdfda	2026-02-23 14:31:20.507028+00	IAM	ZePROPRIO	2018	5.00	f	CLE_SECRETE_FRONTOFFICE	\N	0
3fd8c3d0-2eab-49de-a420-54db31395cfe	2026-04-24 09:45:42.013897+00	J’IMAGINE	ZePROPRIO	2019	0.00	f	CLE_SECRETE_FRONTOFFICE	\N	0
c612d60c-afab-4a1f-b8fc-28ab60c826f4	2026-04-24 09:47:08.672217+00	FOR US	ZePROPRIO	2015	0.00	f	CLE_SECRETE_FRONTOFFICE	\N	0
b2f4257c-58ea-44c4-95cb-ddb08cb8ff7d	2026-02-23 14:27:00.785568+00	EXKY	PONEY	2014	9.00	f	CLE_SECRETE_FRONTOFFICE	\N	4
4d9a337d-9e43-47f4-bfad-2fdef8b387d9	2026-02-23 14:16:50.814749+00	TYPE TOP	PONEY	2007	9.00	f	CLE_SECRETE_FRONTOFFICE	\N	1
66479d9e-ab80-4303-9232-6d72ef203b91	2026-03-24 09:15:54.97158+00	-	PONEY	2000	0.00	f	CLE_SECRETE_FRONTOFFICE	\N	0
059512a2-d080-480d-b201-84c5179e56ed	2026-02-23 14:12:00.64915+00	ALYSSON	Cheval	2010	9.00	f	CLE_SECRETE_FRONTOFFICE	\N	23
539ea9e5-8e6c-40f6-b81c-193f39a7e6d6	2026-02-23 14:26:08.930534+00	BE WIZE	PONEY	2011	9.00	f	CLE_SECRETE_FRONTOFFICE	\N	3
c4b8378c-7955-452f-b3e3-d22ad430c4a7	2026-02-23 14:15:55.11454+00	PETITON'R	PONEY	2003	9.00	f	CLE_SECRETE_FRONTOFFICE	\N	4
d532c50a-26f4-4491-bcb3-e8fe9bb5105d	2026-02-23 14:28:14.465681+00	API	SHETLAND	2010	9.00	f	CLE_SECRETE_FRONTOFFICE	\N	1
b6d87440-e59a-402a-81f1-4d996a9a9300	2026-02-23 14:28:46.100113+00	BOUD'ZAN	SHETLAND	2011	9.00	f	CLE_SECRETE_FRONTOFFICE	\N	2
c48c89f9-082b-4835-9a9f-e3ee05ed3476	2026-02-23 14:29:13.491819+00	CANNELLE	SHETLAND	2012	9.00	f	CLE_SECRETE_FRONTOFFICE	\N	2
dd17c985-0e39-48b8-8558-b6e76ec6c09c	2026-02-23 14:27:30.418612+00	KOOKOO	PONEY	2020	9.00	f	CLE_SECRETE_FRONTOFFICE	\N	1
682763a9-a5bb-4985-aa6e-83bd5f935b2a	2026-02-23 14:29:50.267502+00	KIMONO	SHETLAND	1998	3.00	f	CLE_SECRETE_FRONTOFFICE	\N	1
03331a64-cbca-4ae6-b260-80308e787efc	2026-02-23 14:30:52.760821+00	KINDER	SHETLAND	1998	5.00	f	CLE_SECRETE_FRONTOFFICE	\N	1
26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	2026-02-23 14:27:18.319376+00	HIAOU	PONEY	2017	9.00	f	CLE_SECRETE_FRONTOFFICE	\N	2
c6bc37d8-7c43-4ae3-9c95-4f6488a42f09	2026-02-23 14:13:35.700429+00	IDÉAL	ZePROPRIO	2018	5.00	f	CLE_SECRETE_FRONTOFFICE	\N	1
8d3424d3-cb4a-404c-a849-b823220466fc	2026-02-23 14:26:45.079111+00	EM'N'EMS	PONEY	2014	9.00	f	CLE_SECRETE_FRONTOFFICE	\N	3
2da77f56-359d-42fd-83ed-9e50cf2e6d39	2026-02-23 14:16:14.87228+00	QUININE	PONEY	2004	9.00	f	CLE_SECRETE_FRONTOFFICE	\N	1
25dc4ec4-1027-434c-8fd6-5a8c4a3a182b	2026-02-23 14:26:21.277268+00	DIAOUL	PONEY	2013	9.00	f	CLE_SECRETE_FRONTOFFICE	\N	6
43d6cc20-4656-4b83-869d-68c44bd0b15d	2026-03-20 18:57:00.145534+00	-	SHETLAND	1998	0.00	f	CLE_SECRETE_FRONTOFFICE	\N	0
d4808db9-9fe2-41cf-8606-8f9187a1eb1f	2026-02-23 14:25:43.096049+00	VENOM	PONEY	2009	9.00	f	CLE_SECRETE_FRONTOFFICE	\N	4
70eda733-90e8-42ac-b50f-b8f50474214a	2026-02-23 14:13:54.978537+00	JALOUSE	Cheval	2019	9.00	f	CLE_SECRETE_FRONTOFFICE	\N	18
5e250204-ceee-4813-b935-df2600156009	2026-02-23 14:12:17.429058+00	BALKAN	Cheval	2011	9.00	f	CLE_SECRETE_FRONTOFFICE	\N	22
\.


--
-- TOC entry 4005 (class 0 OID 22335)
-- Dependencies: 386
-- Data for Name: groupes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.groupes (id, created_at, nom, jour, heure, moniteur_id, eleve_moniteur_id, couleur, note, app_key, icone_niveau) FROM stdin;
9a893581-9a76-4bb2-a519-a9aa764ae4ff	2026-02-23 14:05:17.356663+00	Samedi 08:30 - 10:00	6	09:00:00	db44fd23-0251-41bc-a21c-95b9707eac57	\N	#9437ff	\N	CLE_SECRETE_FRONTOFFICE	\N
5527fa09-42da-4b9f-b771-4de9e20434f2	2026-02-23 14:01:53.438606+00	Mercredi 13:30 - 15:00	3	14:00:00	db44fd23-0251-41bc-a21c-95b9707eac57	5ba83076-9e31-4bb0-a468-d293239080da	#ed7d31	\N	CLE_SECRETE_FRONTOFFICE	🏅
e835851b-18fd-46da-9c66-8bbd99f8690c	2026-02-23 14:08:37.292509+00	Samedi 14:00 - 15:00	6	14:00:00	db44fd23-0251-41bc-a21c-95b9707eac57	\N	#ff2f92	\N	CLE_SECRETE_FRONTOFFICE	\N
97fd116b-b25f-459e-b8d7-a08052916748	2026-02-23 14:09:37.218782+00	Samedi 15:00 - 16:30	6	15:00:00	db44fd23-0251-41bc-a21c-95b9707eac57	\N	#ffc000	\N	CLE_SECRETE_FRONTOFFICE	\N
c1625acc-f295-448e-8020-1a5ca3bfd564	2026-02-23 14:04:35.340305+00	Mercredi 18:30 - 20:00	3	19:00:00	db44fd23-0251-41bc-a21c-95b9707eac57	\N	#114788	\N	CLE_SECRETE_FRONTOFFICE	\N
6bf651bc-d740-4598-b6fe-98b4bb7c0f41	2026-02-23 14:02:44.688423+00	Mercredi 15:00 - 16:30	3	15:30:00	db44fd23-0251-41bc-a21c-95b9707eac57	5ba83076-9e31-4bb0-a468-d293239080da	#ffc000	\N	CLE_SECRETE_FRONTOFFICE	\N
d1d6dfcd-90a7-4870-b8d6-a993a8897810	2026-02-23 14:03:37.421534+00	Mercredi 16:00 - 17:30	3	16:30:00	db44fd23-0251-41bc-a21c-95b9707eac57	\N	#00b050	\N	CLE_SECRETE_FRONTOFFICE	\N
49eb08b4-b534-4aa6-a087-5b3a16d74f9e	2026-02-23 14:06:18.534456+00	Samedi 09:30 - 11:00	6	10:00:00	db44fd23-0251-41bc-a21c-95b9707eac57	\N	#941651	\N	CLE_SECRETE_FRONTOFFICE	\N
38f2a4bd-910d-4595-bb77-34c92b353749	2026-02-23 14:07:15.32092+00	Samedi 10:30 - 12:00	6	11:00:00	db44fd23-0251-41bc-a21c-95b9707eac57	\N	#ed7d31	\N	CLE_SECRETE_FRONTOFFICE	\N
606859bb-d236-473a-b69b-6b50dd7b6787	2026-03-25 10:01:20.867074+00	Essai Shets	3	10:30:00	db44fd23-0251-41bc-a21c-95b9707eac57	5ba83076-9e31-4bb0-a468-d293239080da	#f83592	\N	CLE_SECRETE_FRONTOFFICE	\N
\.


--
-- TOC entry 4004 (class 0 OID 22324)
-- Dependencies: 385
-- Data for Name: moniteurs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.moniteurs (id, created_at, prenom, disponible, est_eleve_moniteur, app_key, contact_stages) FROM stdin;
5ba83076-9e31-4bb0-a468-d293239080da	2026-02-23 13:55:27.118066+00	Cassie	t	t	CLE_SECRETE_FRONTOFFICE	f
3ee431a5-4c6f-415d-812d-4a77f7ac0f01	2026-02-23 14:41:33.057487+00	Camille	f	f	CLE_SECRETE_FRONTOFFICE	f
5107fbb0-7334-4378-9bbb-a1730f2a6e06	2026-03-11 13:51:14.050233+00	Tom	f	f	CLE_SECRETE_FRONTOFFICE	f
db44fd23-0251-41bc-a21c-95b9707eac57	2026-02-23 13:54:46.234592+00	Claire	t	f	CLE_SECRETE_FRONTOFFICE	t
44bb5822-25eb-495b-ac00-8ffa81153695	2026-03-24 10:30:01.110169+00	Marine	t	f	CLE_SECRETE_FRONTOFFICE	f
\.


--
-- TOC entry 4010 (class 0 OID 22410)
-- Dependencies: 391
-- Data for Name: seances; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.seances (id, created_at, groupe_id, date, heure, discipline, moniteur_id, moniteur2_id, moniteur2_cheval_id, app_key, nom_ponctuel, couleur_ponctuel, heure_fin, note_seance) FROM stdin;
f85eecc5-ceb9-49c0-be70-7a525cc60aab	2026-03-25 10:01:48.88725+00	606859bb-d236-473a-b69b-6b50dd7b6787	2026-03-25	10:30:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
30694148-ec94-4f41-b1d9-b1773bfed8ce	2026-02-23 14:09:54.744617+00	5527fa09-42da-4b9f-b771-4de9e20434f2	2025-09-03	14:00:00	MES PLAT	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
b258389e-bcbd-4667-a455-a81878116055	2026-02-23 14:09:55.835104+00	d1d6dfcd-90a7-4870-b8d6-a993a8897810	2025-09-03	16:30:00	EQUIFEEL	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
bcbea96f-86b9-451f-b811-f6fd1044247f	2026-02-23 14:09:55.31446+00	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	2025-09-03	15:30:00	MISE EN ROUTE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
2e38fe25-d5f7-4ff8-a88b-1c730cddfd7b	2026-02-23 14:09:56.338451+00	c1625acc-f295-448e-8020-1a5ca3bfd564	2025-09-03	19:00:00	MES PLAT	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
8fa7160a-ebf4-4286-b6a8-0cd9b83f7cd3	2026-02-23 15:06:40.886938+00	d1d6dfcd-90a7-4870-b8d6-a993a8897810	2025-09-17	16:30:00	MES PLAT	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
de69ecf6-d7bc-44e8-a539-cdb518a5a14c	2026-02-23 14:40:46.029406+00	9a893581-9a76-4bb2-a519-a9aa764ae4ff	2025-09-06	09:00:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
de5d0847-82cf-4e66-84d5-f7b1825b3274	2026-02-23 14:40:47.25107+00	38f2a4bd-910d-4595-bb77-34c92b353749	2025-09-06	11:00:00	MeS PLAT	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
fdf2c631-a3fe-434f-9319-6cc2d7c862bd	2026-02-23 14:40:47.883239+00	e835851b-18fd-46da-9c66-8bbd99f8690c	2025-09-06	14:00:00	SPRING GARDEN	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
e51eea33-8a16-4702-9aaa-5ff0e3be42e6	2026-02-23 15:06:41.432939+00	c1625acc-f295-448e-8020-1a5ca3bfd564	2025-09-17	19:00:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
886c9056-eb44-4ccc-8cfc-d0b33b50e218	2026-02-23 15:38:14.234603+00	d1d6dfcd-90a7-4870-b8d6-a993a8897810	2026-02-25	16:30:00	PLAT	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
c60af7bc-c422-4aea-b727-7f1a27d6c0db	2026-02-24 16:59:02.232479+00	5527fa09-42da-4b9f-b771-4de9e20434f2	2025-10-01	14:00:00	JEUX	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
56352309-68cf-4232-b801-c1896cfa74ed	2026-02-23 14:52:21.698268+00	5527fa09-42da-4b9f-b771-4de9e20434f2	2025-09-10	14:00:00	MeS OBSTACLE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
acee9400-ff93-4167-a857-1b5d520eeaf7	2026-02-23 14:52:22.260645+00	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	2025-09-10	15:30:00	PLAT	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
ec1f31a3-7b63-44a9-a59e-c8e0dc2f9282	2026-02-23 14:52:22.789061+00	d1d6dfcd-90a7-4870-b8d6-a993a8897810	2025-09-10	16:30:00	MeS OBSTACLE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
cd6e72e3-0a96-41bb-be86-0aa459db0c20	2026-02-23 14:52:23.303554+00	c1625acc-f295-448e-8020-1a5ca3bfd564	2025-09-10	19:00:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
44ade6df-3050-47aa-a672-24d01f7c0cd8	2026-02-23 15:01:50.171236+00	9a893581-9a76-4bb2-a519-a9aa764ae4ff	2025-09-13	09:00:00	BALADE	db44fd23-0251-41bc-a21c-95b9707eac57	3ee431a5-4c6f-415d-812d-4a77f7ac0f01	059512a2-d080-480d-b201-84c5179e56ed	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
e8559a96-f5e8-4945-a5b1-01bfc6ae6b82	2026-02-23 15:01:50.962724+00	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	2025-09-13	10:00:00	MeS PLAT	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
b9293e91-2051-430b-95f2-df07d543a35d	2026-02-23 15:01:51.484907+00	38f2a4bd-910d-4595-bb77-34c92b353749	2025-09-13	11:00:00	BALADE	db44fd23-0251-41bc-a21c-95b9707eac57	3ee431a5-4c6f-415d-812d-4a77f7ac0f01	059512a2-d080-480d-b201-84c5179e56ed	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
4479c828-5699-4868-9190-ea2d1636bff0	2026-02-23 15:01:52.030406+00	e835851b-18fd-46da-9c66-8bbd99f8690c	2025-09-13	14:00:00	HORSEBALL	db44fd23-0251-41bc-a21c-95b9707eac57	3ee431a5-4c6f-415d-812d-4a77f7ac0f01	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
31385a7f-e740-4fe4-96b8-7f6d6e8efa64	2026-02-23 15:01:52.602186+00	97fd116b-b25f-459e-b8d7-a08052916748	2025-09-13	15:30:00	MISE EN ROUTE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
35249ef6-88b6-4194-9367-81ed3a996ca9	2026-02-24 16:59:03.635906+00	d1d6dfcd-90a7-4870-b8d6-a993a8897810	2025-10-01	16:30:00	JEUX	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
5b667016-ca2a-4a5b-b3c8-db5f5d9a131d	2026-02-23 15:06:39.746873+00	5527fa09-42da-4b9f-b771-4de9e20434f2	2025-09-17	14:00:00	BAS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
3ce5a94a-c352-4869-a6be-b6ac0f2cb940	2026-02-23 14:40:48.404492+00	97fd116b-b25f-459e-b8d7-a08052916748	2025-09-06	15:30:00	MISE EN ROUTE	db44fd23-0251-41bc-a21c-95b9707eac57	3ee431a5-4c6f-415d-812d-4a77f7ac0f01	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
f32a983b-eeae-44f6-a9f0-c2decfcc7abf	2026-02-23 15:06:40.363773+00	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	2025-09-17	15:30:00	EQUIFUN	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
78505970-8d66-492b-a67d-f9182ff09def	2026-02-24 16:59:04.24944+00	c1625acc-f295-448e-8020-1a5ca3bfd564	2025-10-01	19:00:00	EQUIFEEL	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
b1f5a2d3-034f-4e34-9f65-ddf845270a5c	2026-02-23 15:12:54.992284+00	e835851b-18fd-46da-9c66-8bbd99f8690c	2025-09-20	14:00:00	BALADE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
0c71fea4-6237-4d2d-b593-b7bbe71bef03	2026-02-23 15:12:53.266033+00	9a893581-9a76-4bb2-a519-a9aa764ae4ff	2025-09-20	09:00:00	PLAT	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
f43a68a1-59b5-4e19-bbb9-5ca90c669e27	2026-02-23 15:12:53.840239+00	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	2025-09-20	10:00:00	BaS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
b635ab3b-ad01-46e5-8088-1636e5e60a34	2026-02-23 15:12:54.478119+00	38f2a4bd-910d-4595-bb77-34c92b353749	2025-09-20	11:00:00	MeS OBSTACLE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
f1f53439-b535-4cfe-9289-a14fd665a064	2026-02-23 15:12:55.542212+00	97fd116b-b25f-459e-b8d7-a08052916748	2025-09-20	15:30:00	MISE EN ROUTE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
a5ba1f81-de78-4de0-bf9d-c8d2a728eab2	2026-02-23 15:38:15.018322+00	c1625acc-f295-448e-8020-1a5ca3bfd564	2026-02-25	19:00:00	EQUIFEEL	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
bc9e084a-ebac-4afa-a2d7-83398edfedeb	2026-02-23 15:25:48.096228+00	5527fa09-42da-4b9f-b771-4de9e20434f2	2025-09-24	14:00:00	OBSTACLE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
026c203e-89d8-452f-9325-9d4141a6c008	2026-02-23 15:25:48.623233+00	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	2025-09-24	15:30:00	PLAT	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
66ef7a72-791c-4da0-a7cb-6f38fc602989	2026-02-23 15:25:49.201544+00	d1d6dfcd-90a7-4870-b8d6-a993a8897810	2025-09-24	16:30:00	LONGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
696c75c2-7d03-4d19-8823-a1f1d2e8647c	2026-02-23 15:25:49.759595+00	c1625acc-f295-448e-8020-1a5ca3bfd564	2025-09-24	19:00:00	EQUIFEEL	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
82a8c06b-8f4f-44b1-8491-4504fc06bb56	2026-02-23 15:30:22.248663+00	9a893581-9a76-4bb2-a519-a9aa764ae4ff	2025-09-27	09:00:00	PLAT	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
25a1e016-96c3-48d9-826a-445ce02d1374	2026-02-23 15:30:22.78068+00	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	2025-09-27	10:00:00	HORSEBALL	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
5e9e8a31-d32e-467b-978d-bcab5c9b8628	2026-02-23 15:30:23.305055+00	38f2a4bd-910d-4595-bb77-34c92b353749	2025-09-27	11:00:00	PLAT	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
e0f938e9-769a-4090-95bc-c24b78c5bb0b	2026-02-23 15:30:23.861569+00	e835851b-18fd-46da-9c66-8bbd99f8690c	2025-09-27	14:00:00	SPRING GARDEN	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
c301dd0c-0478-4fec-afae-99f2ed6778ab	2026-02-23 15:30:24.382714+00	97fd116b-b25f-459e-b8d7-a08052916748	2025-09-27	15:30:00	BALADE & MES OBS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
9dbdc39c-c7d7-44b5-9030-95a55121370d	2026-02-23 15:38:12.569135+00	5527fa09-42da-4b9f-b771-4de9e20434f2	2026-02-25	14:00:00	BALADE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
48a6221e-76aa-44dc-bed5-ce24bc3c584b	2026-02-23 14:40:46.628732+00	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	2025-09-06	10:00:00	BALADE	db44fd23-0251-41bc-a21c-95b9707eac57	3ee431a5-4c6f-415d-812d-4a77f7ac0f01	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
77471b49-c614-41d6-8dfe-2e5b1f6cc28d	2026-03-27 15:05:49.23394+00	\N	2025-09-09	18:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	20:00:00	\N
5c6f79e8-04b1-4e75-8e11-b3796d2ded92	2026-02-23 15:38:13.485239+00	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	2026-02-25	15:30:00	BALADE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
ab8fd60b-d7dc-4a1b-91b8-8647ef335aaf	2026-03-29 08:58:48.211395+00	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	2026-05-09	10:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
230391cb-f41c-4520-998d-0a04dae98e88	2026-03-29 08:58:49.773157+00	97fd116b-b25f-459e-b8d7-a08052916748	2026-05-09	15:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
a4552dd6-0b7e-4ebd-b69e-92ee204c9904	2026-03-31 14:56:08.55649+00	\N	2025-11-23	10:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	12:00:00	\N
cba5eb52-034b-40dc-8faa-d623420d7a53	2026-04-01 12:50:13.580561+00	\N	2026-01-29	18:30:00	MeS OBSTACLE	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	20:00:00	\N
7a8b218d-0f7d-4c19-a8e2-921d5515f4d9	2026-02-24 09:13:09.59322+00	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	2026-02-28	10:00:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
e42487f9-0eed-4e72-ba57-7d45bfb144f4	2026-02-24 09:13:10.394009+00	38f2a4bd-910d-4595-bb77-34c92b353749	2026-02-28	11:00:00	LONGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
ca4b5db9-b467-4c20-b575-f0ca3bf1642b	2026-02-24 09:13:11.054112+00	e835851b-18fd-46da-9c66-8bbd99f8690c	2026-02-28	14:00:00	EQUIFUN	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
69f5290b-889e-40e1-abf8-258e2e7946f7	2026-02-24 09:13:11.656299+00	97fd116b-b25f-459e-b8d7-a08052916748	2026-02-28	15:30:00	EQUIFUN	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
e4edc2d5-cb4d-4767-b1cc-22b3d247c698	2026-03-25 10:09:49.764828+00	606859bb-d236-473a-b69b-6b50dd7b6787	2025-09-17	10:30:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
d9085b1e-da5e-4534-a55c-00abbe7ba7b7	2026-02-25 09:03:50.493502+00	e835851b-18fd-46da-9c66-8bbd99f8690c	2025-10-04	14:00:00	BALADE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
d2799fab-ea30-4eb6-97cd-3ccfa7c1b027	2026-02-25 09:03:48.5431+00	9a893581-9a76-4bb2-a519-a9aa764ae4ff	2025-10-04	09:00:00	PLAT	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
2602a1d7-dc0b-4414-a01c-5b2939663a91	2026-02-25 09:03:49.206865+00	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	2025-10-04	10:00:00	OBSTACLE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
2abc05ce-021c-4af4-92d1-104b190787d6	2026-02-25 09:03:49.823674+00	38f2a4bd-910d-4595-bb77-34c92b353749	2025-10-04	11:00:00	PLAT	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
bbce2c38-8d9f-4ee3-afee-336a39644982	2026-02-25 09:03:51.051574+00	97fd116b-b25f-459e-b8d7-a08052916748	2025-10-04	15:30:00	OBSTACLE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
b4c7a69d-5bb3-4302-9ac0-02c8efdbf66a	2026-02-25 09:19:09.210187+00	5527fa09-42da-4b9f-b771-4de9e20434f2	2025-10-08	14:00:00	EQUIFEEL	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
341d524a-37e2-45c7-941a-9aff26f1641c	2026-02-25 09:19:10.249876+00	d1d6dfcd-90a7-4870-b8d6-a993a8897810	2025-10-08	16:30:00	OBSTACLE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
d767fd2e-d527-4eeb-b9b6-55432538a59c	2026-02-25 09:19:10.766283+00	c1625acc-f295-448e-8020-1a5ca3bfd564	2025-10-08	19:00:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
658dd892-42b6-4691-bb71-6a8c20082919	2026-02-25 09:19:09.742572+00	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	2025-10-08	15:30:00	PLAT	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
0fc9c76f-c564-441a-a665-f014eb877f06	2026-02-25 09:28:37.821003+00	97fd116b-b25f-459e-b8d7-a08052916748	2025-10-11	15:30:00	BALADE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
a5d169f0-06e0-4bbc-9132-ff13f70ffe2a	2026-02-25 09:28:35.702875+00	9a893581-9a76-4bb2-a519-a9aa764ae4ff	2025-10-11	09:00:00	PLAT	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
3be3fde7-d79c-4406-b134-ab753ba7c9e6	2026-02-25 09:47:43.348706+00	9a893581-9a76-4bb2-a519-a9aa764ae4ff	2025-11-08	09:00:00	PLAT	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
32ad6772-1db0-47ec-a562-5d9d8a92dc5a	2026-02-25 09:28:36.715275+00	38f2a4bd-910d-4595-bb77-34c92b353749	2025-10-11	11:00:00	OBSTACLE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
d78941c0-235d-4d26-a02f-40c0e0e3025b	2026-02-25 09:28:37.319735+00	e835851b-18fd-46da-9c66-8bbd99f8690c	2025-10-11	14:00:00	SPRING GARDEN	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
9e1d97de-66fe-4106-8134-9bff1bdb994b	2026-02-24 16:59:02.910809+00	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	2025-10-01	15:30:00	VOLTIGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
1bbc1288-e5ad-4a1d-9b92-e9c17c1cbb39	2026-02-25 09:35:22.052912+00	c1625acc-f295-448e-8020-1a5ca3bfd564	2025-10-15	19:00:00	BALADE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
d7c14e1a-4268-445f-ba82-6375e72c0885	2026-02-25 09:43:20.793996+00	d1d6dfcd-90a7-4870-b8d6-a993a8897810	2025-11-05	16:30:00	BAS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
5b9f22de-846f-47b0-ac93-1b274e2e17e9	2026-02-25 09:35:20.544263+00	5527fa09-42da-4b9f-b771-4de9e20434f2	2025-10-15	14:00:00	JEUX	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
4813087b-e9d9-4bb7-81ea-9a0918d58c05	2026-02-25 09:35:21.024437+00	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	2025-10-15	15:30:00	VOLTIGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
8568df07-8697-4698-a91f-bab066a24501	2026-02-25 09:35:21.551913+00	d1d6dfcd-90a7-4870-b8d6-a993a8897810	2025-10-15	16:30:00	JEUX	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
260e2537-ea44-4fe1-9e17-b0f19e419a1b	2026-02-25 09:39:27.310803+00	9a893581-9a76-4bb2-a519-a9aa764ae4ff	2025-10-18	09:00:00	EQUIFEEL	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
e736e97f-7c81-47ed-b7bf-c49714bc2a2f	2026-02-25 09:39:27.806315+00	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	2025-10-18	10:00:00	JEUX	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
ff398855-d610-4ae2-bf36-bb519a828237	2026-02-25 09:39:28.331756+00	38f2a4bd-910d-4595-bb77-34c92b353749	2025-10-18	11:00:00	JEUX	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
1861c9ab-7d30-40c9-a501-e23095777a19	2026-02-25 09:39:28.825608+00	e835851b-18fd-46da-9c66-8bbd99f8690c	2025-10-18	14:00:00	PIED & JEUX	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
db348560-d2b8-487c-b78c-09f5a442bd02	2026-02-25 09:39:29.483395+00	97fd116b-b25f-459e-b8d7-a08052916748	2025-10-18	15:30:00	VOLTIGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
3af5bc97-0b0a-4f4d-8644-75ccf58e1069	2026-02-25 09:43:21.496424+00	c1625acc-f295-448e-8020-1a5ca3bfd564	2025-11-05	19:00:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
19471820-fbbf-43d1-ab22-635c5a352858	2026-02-25 09:47:55.985432+00	d1d6dfcd-90a7-4870-b8d6-a993a8897810	2025-11-12	16:30:00	OBSTACLE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
e0639365-a3d0-4b61-95b9-e088cca4f90e	2026-02-25 09:43:19.114715+00	5527fa09-42da-4b9f-b771-4de9e20434f2	2025-11-05	14:00:00	MeS OBSTACLE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
c7263cb1-3be8-44fd-b534-08bc314b3e99	2026-02-25 09:43:20.031347+00	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	2025-11-05	15:30:00	PLAT	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
444a7e78-34b0-4d7e-b1f9-f6c063f21b0b	2026-02-25 09:47:57.78323+00	d1d6dfcd-90a7-4870-b8d6-a993a8897810	2025-11-19	16:30:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
bcd47ff5-5a64-4898-aa4f-d4c4b64d95ef	2026-02-25 09:47:58.370335+00	c1625acc-f295-448e-8020-1a5ca3bfd564	2025-11-19	19:00:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
b794c2ea-fab2-43ab-a5a1-2b9f463d5166	2026-02-25 09:48:04.150666+00	5527fa09-42da-4b9f-b771-4de9e20434f2	2025-11-26	14:00:00	MES PLAT	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
0ce7ec21-608e-46b1-b81f-6c26e2bc4f76	2026-02-25 09:48:05.377317+00	d1d6dfcd-90a7-4870-b8d6-a993a8897810	2025-11-26	16:30:00	EQUIFEEL	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
1e2b6f64-09fc-4ab9-8967-bc0a47eafb44	2026-02-25 09:28:36.233603+00	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	2025-10-11	10:00:00	EQUIFEEL	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
913d6fe9-f265-4282-a42f-799317153e00	2026-02-25 09:47:44.409177+00	38f2a4bd-910d-4595-bb77-34c92b353749	2025-11-08	11:00:00	PLAT	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
d7f30622-ad01-4a54-975e-1102decb39de	2026-02-25 09:47:44.891345+00	e835851b-18fd-46da-9c66-8bbd99f8690c	2025-11-08	14:00:00	JEUX	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
ed090252-a1a7-4d94-88b2-1960f956f38e	2026-02-25 09:47:45.40553+00	97fd116b-b25f-459e-b8d7-a08052916748	2025-11-08	15:30:00	MeS OBSTACLE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
bf589032-8b02-42cb-9f13-17c84cd4a7e6	2026-03-29 08:58:48.701057+00	38f2a4bd-910d-4595-bb77-34c92b353749	2026-05-09	11:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
f0860785-fe45-4b7d-90d3-ecf45fcf770f	2026-02-25 09:48:09.297675+00	38f2a4bd-910d-4595-bb77-34c92b353749	2025-11-15	11:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
3c4953cb-3a8b-48df-80c4-92eed60e1ac6	2026-02-25 09:47:55.443788+00	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	2025-11-12	15:30:00	VOLTIGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
9a07f6b9-15bf-47b5-a175-d6e80d60b1e5	2026-02-25 09:47:54.899434+00	5527fa09-42da-4b9f-b771-4de9e20434f2	2025-11-12	14:00:00	OBSTACLE BAS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
f3cd3208-63a6-4b95-aced-5e12764cb669	2026-02-25 09:48:08.815073+00	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	2025-11-15	10:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
ef3928d4-6ae1-4f40-a022-a2fa805b4d04	2026-02-25 09:48:09.851357+00	e835851b-18fd-46da-9c66-8bbd99f8690c	2025-11-15	14:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
a30358b7-9ec5-4b46-8373-ad6ff7d3812a	2026-02-25 09:48:08.140741+00	9a893581-9a76-4bb2-a519-a9aa764ae4ff	2025-11-15	09:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
8630ca85-a482-4220-b9ce-ad9c53e3641e	2026-02-25 09:47:56.682722+00	5527fa09-42da-4b9f-b771-4de9e20434f2	2025-11-19	14:00:00	OBSTACLE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
bde71879-d3eb-4b30-b86a-ef3448f7d9ca	2026-03-31 15:12:40.571465+00	\N	2025-11-21	18:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	20:00:00	\N
ef6ab570-95dd-43ce-9ddf-c74b11bc1c38	2026-02-25 09:48:04.848348+00	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	2025-11-26	15:30:00	PLAT	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
361a8041-3e45-44bd-8efb-7e4ae1d445f6	2026-02-25 09:48:05.884065+00	c1625acc-f295-448e-8020-1a5ca3bfd564	2025-11-26	19:00:00	LONGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
bc36503e-6ca8-4345-b7e7-e8eb0e8c553b	2026-04-01 16:53:17.111824+00	\N	2026-02-01	10:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	12:00:00	\N
6b63bbe9-b509-4424-9377-6b1b6d9e0ca7	2026-04-02 09:24:55.983382+00	\N	2026-03-01	10:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	12:00:00	\N
7665c054-298a-4e8c-b24e-1e73732beb7d	2026-02-24 09:13:08.956283+00	9a893581-9a76-4bb2-a519-a9aa764ae4ff	2026-02-28	09:00:00	LONGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
beb9ca03-4d63-4f32-a4d0-deb4e597e044	2026-02-25 09:47:56.47508+00	c1625acc-f295-448e-8020-1a5ca3bfd564	2025-11-12	19:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
138d43d0-1c89-46cc-aaa7-43ef52418145	2026-02-25 09:48:11.377785+00	e835851b-18fd-46da-9c66-8bbd99f8690c	2025-11-22	14:00:00	VOLTIGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
cd9be75e-0da9-4aa1-8085-b67d72a38088	2026-03-25 10:19:46.603053+00	606859bb-d236-473a-b69b-6b50dd7b6787	2026-03-04	10:30:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
6335a5b8-1338-4788-a8ca-5a360b4621cc	2026-03-25 10:19:45.552457+00	d1d6dfcd-90a7-4870-b8d6-a993a8897810	2026-03-04	16:30:00	OBSTACLE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
cbf19fc6-413d-41ce-bdbe-95aa6f03657a	2026-03-27 15:12:42.114645+00	\N	2025-09-14	10:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	12:00:00	\N
4cb6bb35-e1a5-4482-96d0-b332197766a7	2026-03-31 15:42:52.489879+00	\N	2025-11-28	18:30:00	EQUIFUN	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	20:00:00	\N
f902b687-d691-4eab-bd0a-55ea83a02a5e	2026-04-01 17:19:57.931484+00	\N	2026-01-18	10:30:00	EQUIFEEL	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	12:00:00	\N
b37e7b09-37b0-4532-8f54-49487d400fcc	2026-04-02 10:08:25.883385+00	\N	2026-03-06	18:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	20:00:00	\N
c9cc8969-baa9-4708-89a7-ca489ca526c4	2026-04-03 17:34:35.115224+00	9a893581-9a76-4bb2-a519-a9aa764ae4ff	2026-05-16	09:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
c8790fc9-0b35-44e1-a196-f3b8e9f1d0de	2026-04-03 17:34:35.642902+00	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	2026-05-16	10:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
a0c4a5e4-4555-4c13-ac80-06f363ec880c	2026-04-03 17:34:36.146596+00	38f2a4bd-910d-4595-bb77-34c92b353749	2026-05-16	11:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
309829a0-882a-488a-8769-2dc3d406e6ce	2026-04-03 17:34:36.674784+00	e835851b-18fd-46da-9c66-8bbd99f8690c	2026-05-16	14:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
032d7dc8-689b-4a61-b278-29be8bbda84a	2026-04-03 17:34:37.212526+00	97fd116b-b25f-459e-b8d7-a08052916748	2026-05-16	15:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
f48d3948-b170-45a9-9ccb-65a43c8a269c	2026-03-25 10:19:44.524364+00	5527fa09-42da-4b9f-b771-4de9e20434f2	2026-03-04	14:00:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
2e1b56fc-f0c7-44ba-9f10-a398c4dbde04	2026-02-25 09:48:09.938062+00	9a893581-9a76-4bb2-a519-a9aa764ae4ff	2025-11-22	09:00:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
2a33e3b2-becf-48b8-b1e8-b078ab60023d	2026-02-25 09:48:12.74002+00	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	2025-11-29	10:00:00	OBSTACLE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
ce4d876d-77a0-4e3f-9aea-4e51915f8737	2026-02-25 09:48:14.196498+00	97fd116b-b25f-459e-b8d7-a08052916748	2025-11-29	15:30:00	EQUIFUN	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
563c3372-d926-4127-8703-eb8f5ac1409f	2026-03-25 10:19:46.108261+00	c1625acc-f295-448e-8020-1a5ca3bfd564	2026-03-04	19:00:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
d9781f82-0ab6-4ec2-a4b7-ba43bc7ad223	2026-03-27 15:17:31.584157+00	\N	2025-09-19	18:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	20:00:00	\N
9c5c0078-03e0-43c0-8b4f-468f202e6fb4	2026-03-31 06:34:16.073101+00	\N	2025-10-26	10:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine. Récup 05/10 Vacances	#5b9bd5	12:00:00	\N
bf7dc421-1745-4455-a7b3-5abc17d0a3e1	2026-03-31 16:49:00.093505+00	\N	2025-11-30	10:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	12:00:00	\N
986e73bb-eacf-4244-b653-e5ec780e6ad1	2026-04-01 17:26:28.463092+00	\N	2026-01-23	18:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	20:00:00	\N
a7f48b70-6678-4e7d-9700-70b0501a5a1c	2026-04-02 10:12:57.271408+00	\N	2026-03-08	10:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	12:00:00	\N
8b30c4cb-5033-4226-9b1a-c85c05fdccb6	2026-04-03 17:38:29.687026+00	9a893581-9a76-4bb2-a519-a9aa764ae4ff	2026-05-23	09:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
910ff1f2-8a1c-400f-973f-245b3f3ff740	2026-04-03 17:38:30.210761+00	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	2026-05-23	10:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
6ac5e4e0-740d-4e05-8458-5a9a00bfff17	2026-04-03 17:38:30.726858+00	38f2a4bd-910d-4595-bb77-34c92b353749	2026-05-23	11:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
2fd3044a-7e16-4d4d-9923-60897eb85e93	2026-04-03 17:38:31.216004+00	e835851b-18fd-46da-9c66-8bbd99f8690c	2026-05-23	14:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
68f541e9-8f52-4816-bfb6-0eb076090d8d	2026-04-03 17:38:31.711341+00	97fd116b-b25f-459e-b8d7-a08052916748	2026-05-23	15:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
6eb7b7d3-940d-4cff-932e-83b08f574c69	2026-04-30 07:03:39.435374+00	\N	2026-05-01	18:30:00	DRESSAGE	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	20:00:00	\N
03d86523-24e9-49e6-b1db-63425d157c49	2026-02-25 09:48:10.426977+00	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	2025-11-22	10:00:00	EQUIFEEL	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
c2959acd-9c17-40c1-9410-0ab154658b83	2026-03-25 10:19:45.046114+00	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	2026-03-04	15:30:00	VOLTIGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	8d3424d3-cb4a-404c-a849-b823220466fc	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
fa0274f2-55e2-424a-be15-f8f050991b0e	2026-03-31 12:57:44.548779+00	\N	2025-11-02	09:00:00	EQUIFEEL	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine. Récup 12/10 Vacances	#5b9bd5	10:30:00	\N
0163f795-7b5b-40b2-b8de-6853ebec9bb7	2026-03-31 17:13:45.666325+00	\N	2025-12-04	18:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	20:00:00	\N
f6f911c4-b299-4d58-be3c-95f60feda870	2026-04-01 17:29:16.766086+00	\N	2026-01-25	15:00:00	EQUIFEEL	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	16:30:00	\N
11527b8f-faf1-4400-baea-63574f55633b	2026-04-02 10:32:04.256818+00	\N	2026-03-13	18:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	20:00:00	\N
d927e43a-7c30-467d-9b57-4b163f280104	2026-04-03 17:40:25.129899+00	97fd116b-b25f-459e-b8d7-a08052916748	2026-05-02	15:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
98b0b557-b729-4a26-b50b-852c70e3f9a4	2026-04-24 08:55:49.116438+00	\N	2026-04-24	15:00:00	BALADE	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Balade	#f83592	15:30:00	\N
40977b9e-1d07-47f0-8a4c-6f7a1a548211	2026-04-03 17:40:23.591195+00	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	2026-05-02	10:00:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
06292f37-cb07-4aaf-9132-5e59d714defe	2026-04-30 07:05:56.443341+00	\N	2026-05-03	10:30:00	DRESSAGE	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	12:00:00	\N
103d8f2b-d328-4df6-aed0-a7b1538ba9f1	2026-04-03 17:40:22.827247+00	9a893581-9a76-4bb2-a519-a9aa764ae4ff	2026-05-02	09:00:00	EQUIFEEL	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
2d2b77a4-539b-4ada-b69f-2b4bb2f092f3	2026-04-03 17:40:24.110774+00	38f2a4bd-910d-4595-bb77-34c92b353749	2026-05-02	11:00:00	CROSS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
1b06f56d-05cc-4891-beca-e4babde61556	2026-02-25 09:48:10.443708+00	97fd116b-b25f-459e-b8d7-a08052916748	2025-11-15	15:30:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
612a94b5-04d0-4f36-95eb-65d82c7d276f	2026-04-03 17:40:24.608778+00	e835851b-18fd-46da-9c66-8bbd99f8690c	2026-05-02	14:00:00	ATTELAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	ATTELAGE. PT. API. BOU. KOO.
426ba16b-4754-4009-8fbb-4c60751166b8	2026-02-25 09:48:10.904507+00	38f2a4bd-910d-4595-bb77-34c92b353749	2025-11-22	11:00:00	BALADE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
76b18aaf-0eb0-492e-a1f6-29016d34e4d5	2026-02-25 09:48:13.694786+00	e835851b-18fd-46da-9c66-8bbd99f8690c	2025-11-29	14:00:00	BALADE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
e08f664a-a285-449e-ad59-9d5346b59d38	2026-03-31 13:05:36.648942+00	\N	2025-10-17	18:30:00	EQUIFEEL	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	20:00:00	\N
b176fc38-62f1-4551-acad-1cac0d34fc6e	2026-03-31 17:18:26.068732+00	\N	2025-12-07	13:00:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	14:30:00	\N
73b17b0a-e750-4f39-9de7-cc4bfe1efbc8	2026-04-01 17:32:42.466113+00	\N	2026-01-27	18:30:00	LONGE	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	20:00:00	\N
fa2fb244-570c-418f-b2b1-93236d860438	2026-04-02 10:36:11.588658+00	\N	2026-03-15	10:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	12:00:00	\N
f1677714-9bee-4c08-b109-0a0dafee7603	2026-04-04 06:14:20.368921+00	d1d6dfcd-90a7-4870-b8d6-a993a8897810	2026-05-13	16:30:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
10951fef-c57d-4bf9-8369-31baf9026572	2026-04-04 06:12:49.051717+00	5527fa09-42da-4b9f-b771-4de9e20434f2	2026-05-06	14:00:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
fdbd21d2-cb77-416a-b08b-078d6bdeeb92	2026-04-04 06:12:50.660304+00	c1625acc-f295-448e-8020-1a5ca3bfd564	2026-05-06	19:00:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
0795889d-4ce9-4789-ba2a-7fb8895aa95a	2026-04-25 05:02:20.602969+00	9a893581-9a76-4bb2-a519-a9aa764ae4ff	2026-06-13	09:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
57acfb30-beff-4231-ae3f-d276a560e310	2026-04-25 05:02:21.332303+00	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	2026-06-13	10:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
e97e4a9d-eb65-472f-ac6f-4572841a2e02	2026-04-25 05:02:21.788074+00	38f2a4bd-910d-4595-bb77-34c92b353749	2026-06-13	11:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
277536e7-07a3-4402-89a9-9cf39d67335e	2026-04-25 05:02:22.24134+00	e835851b-18fd-46da-9c66-8bbd99f8690c	2026-06-13	14:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
093a770f-ec17-4967-9b0b-c006e0a8a834	2026-04-25 05:02:22.695113+00	97fd116b-b25f-459e-b8d7-a08052916748	2026-06-13	15:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
e5b02c6a-bb0c-424d-80b0-ca0123725715	2026-02-25 09:48:11.876708+00	97fd116b-b25f-459e-b8d7-a08052916748	2025-11-22	15:30:00	VOLTIGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
f0d233e4-061e-4088-bc3d-0f8d30df0ea4	2026-03-27 14:47:18.449807+00	\N	2025-09-02	18:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	20:00:00	\N
47ce8225-99a7-44c7-8153-b17a84a2df9f	2026-03-27 16:08:40.980192+00	\N	2025-09-21	10:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	12:00:00	\N
54888d72-6043-4268-99c5-a27194874ddf	2026-03-31 13:26:25.195155+00	\N	2025-10-19	18:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	20:00:00	\N
f7cfa1e9-8345-46db-832d-a470747f1fca	2026-03-31 17:22:12.581054+00	\N	2025-12-12	18:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	20:00:00	\N
28501d06-1151-454b-a3bc-ff30c768509a	2026-04-01 17:36:12.610789+00	\N	2026-02-05	18:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	20:00:00	\N
8d71eca8-6e71-4dfc-ae58-951a70a7e53e	2026-04-04 06:12:49.622478+00	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	2026-05-06	15:30:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
e305f328-b6fb-42a4-acb5-66d6ba4fb0cb	2026-04-26 07:32:34.936078+00	\N	2026-04-26	09:30:00	EQUIFEEL	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	EQUIFEEL	#5d014a	12:00:00	\N
e93ccd74-f1ea-4e20-a512-b91b46112ed7	2026-04-04 06:12:51.171419+00	606859bb-d236-473a-b69b-6b50dd7b6787	2026-05-06	10:30:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
6ab9e0f0-0d33-41ec-ac07-26dcbb9cf689	2026-05-05 08:44:52.816487+00	5527fa09-42da-4b9f-b771-4de9e20434f2	2026-05-20	14:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
88d3b87c-68df-4fe0-9d9c-5e27bf5a3f1f	2026-05-05 08:44:54.137932+00	d1d6dfcd-90a7-4870-b8d6-a993a8897810	2026-05-20	16:30:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
5b5fc371-a036-4006-93b1-40e75487af42	2026-05-05 08:44:55.380469+00	606859bb-d236-473a-b69b-6b50dd7b6787	2026-05-20	10:30:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
4b9050ae-9cb6-47ff-8aaa-d4a50da170eb	2026-02-25 09:47:57.186699+00	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	2025-11-19	15:30:00	MeS OBSTACLE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
97f8edec-a6e7-46e8-97a3-86bc4a0070b7	2026-02-26 08:08:15.588213+00	c1625acc-f295-448e-8020-1a5ca3bfd564	2025-12-03	19:00:00	BAS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
ce6506b4-3400-4b57-b684-5ebd3add6900	2026-02-25 09:48:12.252859+00	9a893581-9a76-4bb2-a519-a9aa764ae4ff	2025-11-29	09:00:00	EQUIFEEL	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
446aec95-8636-450c-b2ea-15e7c4f29792	2026-02-25 09:48:13.214612+00	38f2a4bd-910d-4595-bb77-34c92b353749	2025-11-29	11:00:00	PLAT	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
604fb666-c6f4-4edc-94e5-9c5ff12b979d	2026-04-04 06:12:50.147193+00	d1d6dfcd-90a7-4870-b8d6-a993a8897810	2026-05-06	16:30:00	OBSTACLE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
e358c5ee-23df-422e-9cd2-6350a1c367bc	2026-02-26 08:32:19.488161+00	c1625acc-f295-448e-8020-1a5ca3bfd564	2025-12-17	19:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
b9e1d6e9-7032-4f64-b9a8-36a0c14a5d5b	2026-02-26 08:08:13.995869+00	5527fa09-42da-4b9f-b771-4de9e20434f2	2025-12-03	14:00:00	OBSTACLE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
175c558b-0573-4bb5-9521-f8f766a5c69e	2026-02-26 08:08:14.515926+00	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	2025-12-03	15:30:00	PLAT	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
9940ffc8-c4ee-4336-be1e-f0f872681115	2026-02-26 08:08:15.058995+00	d1d6dfcd-90a7-4870-b8d6-a993a8897810	2025-12-03	16:30:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
5d280258-202f-42cd-a2ba-a0158a383d4f	2026-02-26 08:41:56.984081+00	c1625acc-f295-448e-8020-1a5ca3bfd564	2026-01-07	19:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
2cc7c0c8-d762-444c-b2e0-6d01264a89c0	2026-02-26 08:15:09.663883+00	9a893581-9a76-4bb2-a519-a9aa764ae4ff	2025-12-06	09:00:00	BaS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
5c82a8f9-39eb-488d-ac29-c1668c07b3f9	2026-02-26 08:15:10.175804+00	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	2025-12-06	10:00:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
d7127d22-656e-451e-bbea-0683ac2e5c93	2026-02-26 08:15:10.687287+00	38f2a4bd-910d-4595-bb77-34c92b353749	2025-12-06	11:00:00	OBSTACLE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
f1d77798-f5c6-4c6a-aadc-99b2951316b6	2026-02-26 08:15:11.232587+00	e835851b-18fd-46da-9c66-8bbd99f8690c	2025-12-06	14:00:00	EQUIFUN	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
ea150542-0aad-4ba3-be58-f8430e13be19	2026-02-26 08:15:11.756332+00	97fd116b-b25f-459e-b8d7-a08052916748	2025-12-06	15:30:00	EQUIFEEL	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
f9032505-6437-443d-afba-7fd48f7e424d	2026-03-27 16:10:54.579118+00	\N	2025-09-21	13:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	15:00:00	\N
45492e65-17c7-4458-9dbf-29b31fa36051	2026-02-25 09:47:43.870518+00	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	2025-11-08	10:00:00	BAS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
d5913a3d-10e7-48e3-9ca4-0efeae5f9711	2026-02-26 08:21:04.756651+00	5527fa09-42da-4b9f-b771-4de9e20434f2	2025-12-10	14:00:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
555ccb27-8d80-4e2b-b5b9-aea2ed283984	2026-02-26 08:21:05.277419+00	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	2025-12-10	15:30:00	EQUIFUN	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
0a179855-5d26-4308-bfe1-84828334239f	2026-02-26 08:21:05.826261+00	d1d6dfcd-90a7-4870-b8d6-a993a8897810	2025-12-10	16:30:00	LONGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
9d0ea650-77ef-42b3-8366-6d941bd82594	2026-02-26 08:21:06.3443+00	c1625acc-f295-448e-8020-1a5ca3bfd564	2025-12-10	19:00:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
2386035f-3114-40c5-852f-dddbdb4ae8a3	2026-02-26 08:27:28.276079+00	e835851b-18fd-46da-9c66-8bbd99f8690c	2025-12-13	14:00:00	BALADE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
b1b53a5f-50e8-4416-a05a-dad1c3395ea2	2026-02-26 08:27:26.681191+00	9a893581-9a76-4bb2-a519-a9aa764ae4ff	2025-12-13	09:00:00	PLAT	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
89611d83-acca-4477-955d-c1d1610f79ce	2026-02-26 08:27:27.205762+00	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	2025-12-13	10:00:00	LONGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
6dc1e3dd-4f11-4f87-a2c0-f4c86a79a454	2026-02-26 08:27:27.732101+00	38f2a4bd-910d-4595-bb77-34c92b353749	2025-12-13	11:00:00	EQUIFEEL+Cord	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
4147745a-4b17-47b9-9629-24abf134f88e	2026-02-26 08:27:28.803374+00	97fd116b-b25f-459e-b8d7-a08052916748	2025-12-13	15:30:00	PLAT	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
bd080027-1aa2-4c42-8f8c-0bdc23ab9887	2026-03-31 13:35:17.15548+00	\N	2025-11-07	18:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	20:00:00	\N
9be7787c-72e8-4afc-b145-a5c6ba08378b	2026-02-26 08:32:17.826422+00	5527fa09-42da-4b9f-b771-4de9e20434f2	2025-12-17	14:00:00	JEUX	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
f0712d2b-f503-40c3-b90e-df6fe70edacb	2026-02-26 08:32:18.342611+00	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	2025-12-17	15:30:00	JEUX	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
1f71c89d-44eb-4e9e-9902-d41a6e77faf6	2026-02-26 08:32:18.893219+00	d1d6dfcd-90a7-4870-b8d6-a993a8897810	2025-12-17	16:30:00	JEUX	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
aad629e6-7ea6-4628-b260-dd5ff6a4f5ea	2026-02-26 08:35:19.230481+00	9a893581-9a76-4bb2-a519-a9aa764ae4ff	2025-12-20	09:00:00	JEUX	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
d6b999bc-6737-4453-aaf6-7a9d66f8c9dc	2026-02-26 08:35:19.73272+00	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	2025-12-20	10:00:00	JEUX	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
b57de755-f67c-4031-af22-277377011cf7	2026-02-26 08:35:20.29896+00	38f2a4bd-910d-4595-bb77-34c92b353749	2025-12-20	11:00:00	JEUX	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
1cdde4ac-7a64-4550-9508-bac0092cc67a	2026-02-26 08:35:20.8347+00	e835851b-18fd-46da-9c66-8bbd99f8690c	2025-12-20	14:00:00	JEUX	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
da0eeb8b-8c50-479f-811c-319febdc41c9	2026-02-26 08:35:21.348855+00	97fd116b-b25f-459e-b8d7-a08052916748	2025-12-20	15:30:00	JEUX	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
02fd8130-b58b-4132-b3ee-8de854c3c212	2026-03-31 17:27:06.073486+00	\N	2025-12-14	10:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	12:00:00	\N
c2318c52-cea8-4607-a677-9e14bd2183b9	2026-04-01 18:24:16.971114+00	\N	2026-02-08	10:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	12:00:00	\N
a6b9e5ca-a51d-4783-b694-714f34b697ea	2026-04-02 10:40:25.295082+00	\N	2026-03-20	18:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	20:00:00	\N
051c478e-2200-40c0-92dd-edf238b84016	2026-02-26 08:41:56.47002+00	d1d6dfcd-90a7-4870-b8d6-a993a8897810	2026-01-07	16:30:00	SOINS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
a716377a-2088-458f-aa9b-30d8095e77f0	2026-02-26 08:47:34.976846+00	9a893581-9a76-4bb2-a519-a9aa764ae4ff	2026-01-10	09:00:00	EQUIFEEL	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
e25e7b46-4f82-4794-9be5-4bfecb733da4	2026-02-26 08:47:35.482072+00	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	2026-01-10	10:00:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
336510ae-27fd-4bc5-82f5-011ced18ff09	2026-02-26 08:47:36.354678+00	38f2a4bd-910d-4595-bb77-34c92b353749	2026-01-10	11:00:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
310632f0-f85f-4cb5-bdf3-d9901192a21f	2026-02-26 08:47:36.858705+00	e835851b-18fd-46da-9c66-8bbd99f8690c	2026-01-10	14:00:00	VOLTIGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
1bc4ac24-436c-4792-aff6-5182aba42a0a	2026-02-26 08:47:37.380225+00	97fd116b-b25f-459e-b8d7-a08052916748	2026-01-10	15:30:00	PLAT	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
4866e879-864f-4aa7-b021-3599ff90a516	2026-02-26 08:58:17.629816+00	5527fa09-42da-4b9f-b771-4de9e20434f2	2026-01-14	14:00:00	PLAT	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
51dd6893-2456-4c8d-a80c-2db452619567	2026-02-26 08:58:18.670806+00	d1d6dfcd-90a7-4870-b8d6-a993a8897810	2026-01-14	16:30:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
f58d4582-80ff-485e-ab32-2b15fc7ed606	2026-02-26 08:58:18.144999+00	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	2026-01-14	15:30:00	PLAT	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
da0b805c-72f5-4d2c-bb1c-60a759dca349	2026-02-26 08:58:19.196551+00	c1625acc-f295-448e-8020-1a5ca3bfd564	2026-01-14	19:00:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
85967229-e0e1-4902-9062-86c70e0fc505	2026-02-26 09:08:20.775659+00	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	2026-01-17	10:00:00	EQUIFEEL	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
0ad8eb46-6bb4-4808-a050-5b90fef3b9fd	2026-02-26 09:08:20.285397+00	9a893581-9a76-4bb2-a519-a9aa764ae4ff	2026-01-17	09:00:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
736eced2-c4c1-4312-a240-34c716fdd731	2026-02-26 09:08:21.239823+00	38f2a4bd-910d-4595-bb77-34c92b353749	2026-01-17	11:00:00	OBSTACLE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
287cb5c5-9f6f-418b-9d73-7a4c8137126b	2026-02-26 09:08:21.765957+00	e835851b-18fd-46da-9c66-8bbd99f8690c	2026-01-17	14:00:00	PLAT	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
de9f9356-1fd2-4d2a-aea9-584ad5b0f1ad	2026-02-26 09:08:22.260771+00	97fd116b-b25f-459e-b8d7-a08052916748	2026-01-17	15:30:00	PLAT	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
40c750a6-5e68-4fd3-8fed-25b5204f9c03	2026-02-26 08:41:55.437461+00	5527fa09-42da-4b9f-b771-4de9e20434f2	2026-01-07	14:00:00	THÉORIE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
56b0d021-a032-4fd8-8b64-b129fc01022d	2026-03-27 14:54:50.585976+00	\N	2025-09-07	09:00:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	10:30:00	\N
55037829-053a-4c3e-abeb-942745cebae0	2026-03-27 16:17:08.356501+00	\N	2025-09-28	09:00:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	10:30:00	\N
09e83f94-7344-42a1-a8c4-893bae272b51	2026-03-31 13:46:27.112114+00	\N	2025-11-04	15:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	17:00:00	\N
7eaed77e-0be6-41d2-af22-e3124a2a7458	2026-03-31 17:31:46.50488+00	\N	2025-12-21	10:30:00	JEUX	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	12:00:00	\N
c170a167-f63d-4d0c-95a4-1bffb638607e	2026-04-01 18:30:21.938865+00	\N	2026-02-09	10:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	12:00:00	\N
9fe9a90c-9c86-4b08-8257-70228926c0f1	2026-04-02 10:41:34.933674+00	\N	2026-03-22	10:30:00	EQUIFEEL	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	12:00:00	\N
fdd1141d-f20d-406a-af84-15b5b3a531e7	2026-04-04 06:14:19.416492+00	5527fa09-42da-4b9f-b771-4de9e20434f2	2026-05-13	14:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
dd5a2c33-2d42-42e3-9a68-a4d0c46e176e	2026-04-04 06:14:20.84933+00	c1625acc-f295-448e-8020-1a5ca3bfd564	2026-05-13	19:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
32505e7a-c50a-4f7e-8153-9953ea108b9a	2026-02-26 09:15:53.707354+00	d1d6dfcd-90a7-4870-b8d6-a993a8897810	2026-01-21	16:30:00	MES OBSTACLE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
2dad5daa-3224-4053-93da-c40fa6a78ffb	2026-05-05 08:44:53.423261+00	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	2026-05-20	15:30:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
e465b1a5-09cc-4311-bff0-24d55567df0a	2026-05-05 08:44:54.754794+00	c1625acc-f295-448e-8020-1a5ca3bfd564	2026-05-20	19:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
2d76669f-07dd-41ba-b0e8-0b7b98ba8487	2026-02-26 09:15:52.666426+00	5527fa09-42da-4b9f-b771-4de9e20434f2	2026-01-21	14:00:00	BALADE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	26dde1eb-d3ac-47b1-a14e-cf5f6b01cd18	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
e007f4c1-6593-4895-a128-9e826aa045be	2026-03-16 07:57:59.076094+00	d1d6dfcd-90a7-4870-b8d6-a993a8897810	2026-03-18	16:30:00	OBSTACLE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
ea74d0d7-d1cf-496c-8150-d7b452655885	2026-02-26 09:15:53.193962+00	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	2026-01-21	15:30:00	VOLTIGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
67967bb4-b0ec-462b-9d85-6824afaf3002	2026-02-26 09:15:54.222013+00	c1625acc-f295-448e-8020-1a5ca3bfd564	2026-01-21	19:00:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
fd63b4dd-4165-4092-8cdf-2f1d33994c71	2026-02-26 09:19:10.607042+00	97fd116b-b25f-459e-b8d7-a08052916748	2026-01-24	15:30:00	BAS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
d2ccada8-904b-4149-828d-79adbd475c54	2026-02-26 09:19:09.188096+00	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	2026-01-24	10:00:00	OBSTACLE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
4cc0a4a1-eec2-41a3-92bd-1deae5ea7a25	2026-02-26 09:19:10.140998+00	e835851b-18fd-46da-9c66-8bbd99f8690c	2026-01-24	14:00:00	EQUIFUN	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
c48eefd6-ffc9-418e-817c-ef860de8f966	2026-03-31 17:34:27.210106+00	\N	2025-12-18	16:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	18:00:00	\N
caaafdef-03ae-40c7-be51-4b842d2d14b7	2026-02-26 09:24:10.483194+00	5527fa09-42da-4b9f-b771-4de9e20434f2	2026-01-28	14:00:00	EQUIFEEL	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
4251bd3e-a2bd-4ae4-bd66-667c5d4d4ce8	2026-02-26 09:24:11.002027+00	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	2026-01-28	15:30:00	EQUIFUN	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
86deb28f-b6ef-464e-89db-9a89ac6282b1	2026-02-26 09:24:11.505748+00	d1d6dfcd-90a7-4870-b8d6-a993a8897810	2026-01-28	16:30:00	EQUIFEEL	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
301f761c-911e-458d-9e09-b9869a3b5a2b	2026-02-26 09:27:51.896991+00	e835851b-18fd-46da-9c66-8bbd99f8690c	2026-01-31	14:00:00	BALADE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
3447bd6b-755e-48df-be3e-81551e4aff05	2026-02-26 09:27:50.435909+00	9a893581-9a76-4bb2-a519-a9aa764ae4ff	2026-01-31	09:00:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
79bfb15d-03f1-4264-8f14-67ea3bf69834	2026-02-26 09:27:50.89564+00	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	2026-01-31	10:00:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
707ed250-b1a1-45f0-b4d8-26a77989a4e9	2026-02-26 09:27:51.428647+00	38f2a4bd-910d-4595-bb77-34c92b353749	2026-01-31	11:00:00	LONGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
94bc355c-365a-4b76-9468-e0a4b7dd6437	2026-02-26 09:27:52.365539+00	97fd116b-b25f-459e-b8d7-a08052916748	2026-01-31	15:30:00	PLAT	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
a672c76d-049d-409d-bdbc-e9e01c165b5a	2026-02-26 09:19:09.662461+00	38f2a4bd-910d-4595-bb77-34c92b353749	2026-01-24	11:00:00	EQUIFEEL	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
163bae16-36c5-4bbd-aabd-ebb45f89d1f5	2026-02-26 09:36:19.837025+00	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	2026-02-04	15:30:00	BALADE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
f39916f5-209f-4ec0-9101-7cb792c57390	2026-02-26 09:36:19.315161+00	5527fa09-42da-4b9f-b771-4de9e20434f2	2026-02-04	14:00:00	JEUX	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
9b32720f-f5ea-47bf-9cc5-c6b620330159	2026-02-26 09:36:20.607328+00	d1d6dfcd-90a7-4870-b8d6-a993a8897810	2026-02-04	16:30:00	JEUX	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
3d18a280-48c7-4a3b-95a7-1a3b3504d907	2026-02-26 09:36:21.105378+00	c1625acc-f295-448e-8020-1a5ca3bfd564	2026-02-04	19:00:00	EQUIFEEL	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
b1caa34e-dffe-4deb-90f5-516d18244bc6	2026-02-26 09:39:50.53796+00	9a893581-9a76-4bb2-a519-a9aa764ae4ff	2026-02-07	09:00:00	JEUX	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
c2dcf1fe-b4ad-478d-b2a7-f1918bacee42	2026-02-26 09:39:51.039555+00	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	2026-02-07	10:00:00	JEUX	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
c3bed883-05dd-49c8-9225-106ce39b50db	2026-02-26 09:39:51.516146+00	38f2a4bd-910d-4595-bb77-34c92b353749	2026-02-07	11:00:00	JEUX	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
0d31b9de-8b27-4329-bdf0-50a3ab3fcf6d	2026-02-26 09:39:51.97864+00	e835851b-18fd-46da-9c66-8bbd99f8690c	2026-02-07	14:00:00	JEUX	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
5fb2327b-7286-48aa-8827-1e2cab55fff1	2026-02-26 09:39:52.470234+00	97fd116b-b25f-459e-b8d7-a08052916748	2026-02-07	15:30:00	JEUX	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
b721e3e0-3ab4-47f0-a5dd-a156f7f6f41e	2026-03-04 14:09:11.061643+00	e835851b-18fd-46da-9c66-8bbd99f8690c	2026-03-07	14:00:00	BALADE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
d37660c4-9ae7-42ac-8c7d-97bf2619e70f	2026-03-04 14:09:11.66966+00	97fd116b-b25f-459e-b8d7-a08052916748	2026-03-07	15:30:00	BALADE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
e6990c20-c4c3-40a8-88d5-16516c13629f	2026-03-04 14:09:09.236281+00	9a893581-9a76-4bb2-a519-a9aa764ae4ff	2026-03-07	09:00:00	PLAT	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
355c7448-e956-498c-a1cc-df3a7dca7790	2026-02-26 09:19:08.733487+00	9a893581-9a76-4bb2-a519-a9aa764ae4ff	2026-01-24	09:00:00	BAS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
805ea7df-f291-4405-8c62-8d357660fb00	2026-03-04 14:09:09.904524+00	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	2026-03-07	10:00:00	OBSTACLE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
e544070e-62af-4da4-983a-e3e4f4c8e44a	2026-04-01 18:32:50.931357+00	\N	2026-02-13	15:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	17:00:00	\N
5be512c2-b802-4db0-89b2-c62aea0ad82a	2026-03-04 14:09:10.527654+00	38f2a4bd-910d-4595-bb77-34c92b353749	2026-03-07	11:00:00	PLAT	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
6283ef1c-cddd-4198-8bb2-4b7d7b06ca03	2026-03-06 08:56:13.228499+00	5527fa09-42da-4b9f-b771-4de9e20434f2	2026-03-11	14:00:00	EQUIFUN	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
5ba4da73-bf41-45d4-bdc2-b810d550c9ed	2026-04-02 10:47:11.786724+00	\N	2026-03-29	10:30:00	EQUIFEEL	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	12:00:00	\N
dcd11b42-5a1f-4213-b441-afafd4b16f06	2026-03-06 08:56:13.761176+00	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	2026-03-11	15:30:00	EQUIFUN	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
bacdb2e9-0db8-4cca-8aad-3920c22e2cb5	2026-03-06 08:56:14.264063+00	d1d6dfcd-90a7-4870-b8d6-a993a8897810	2026-03-11	16:30:00	EQUIFUN	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
a8500ea8-9372-4659-b4d4-a284be7110b1	2026-03-06 08:56:14.785859+00	c1625acc-f295-448e-8020-1a5ca3bfd564	2026-03-11	19:00:00	EQUIFUN	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
eef18837-1d71-4ed8-95f4-6abe11afb462	2026-04-04 06:14:19.893031+00	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	2026-05-13	15:30:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
d7c2be84-0141-4de9-bf44-8ce686abecb3	2026-04-04 06:14:21.321387+00	606859bb-d236-473a-b69b-6b50dd7b6787	2026-05-13	10:30:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
8d411ccd-4c4a-460d-a469-0b90f961ac3b	2026-02-26 09:24:12.046722+00	c1625acc-f295-448e-8020-1a5ca3bfd564	2026-01-28	19:00:00	MES OBSTACLE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
870888a9-da10-42bb-a778-f0363da3d929	2026-05-05 08:48:18.633962+00	e835851b-18fd-46da-9c66-8bbd99f8690c	2026-05-09	14:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
d9b1cb06-e452-4f66-8dd5-781d1af83b6a	2026-03-13 14:33:24.313032+00	9a893581-9a76-4bb2-a519-a9aa764ae4ff	2026-03-14	09:00:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
f6f9d485-aa8a-42f1-9a02-e19856e5c921	2026-03-13 14:33:25.044916+00	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	2026-03-14	10:00:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
1b9da96a-4aad-45be-bff7-a96f594f2455	2026-03-13 14:33:25.604681+00	38f2a4bd-910d-4595-bb77-34c92b353749	2026-03-14	11:00:00	OBSTACLE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
f088291c-c6e4-478e-a637-5a6200191a7e	2026-03-13 14:33:26.181196+00	e835851b-18fd-46da-9c66-8bbd99f8690c	2026-03-14	14:00:00	JEUX	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
1d8743d0-47a0-40de-bbbb-ec5b32493315	2026-03-13 14:33:26.75393+00	97fd116b-b25f-459e-b8d7-a08052916748	2026-03-14	15:00:00	LONGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
9c8442a1-78c2-48c6-896b-c33d34857bb7	2026-03-16 11:28:15.871029+00	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	2026-03-25	15:30:00	EQUIFUN	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
4613dd55-48eb-47d6-af52-4f6fe4acd2ce	2026-03-16 07:57:58.58883+00	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	2026-03-18	15:30:00	PLAT	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
5d922c15-82c5-40aa-ba29-14569b485b6e	2026-03-16 07:57:59.571819+00	c1625acc-f295-448e-8020-1a5ca3bfd564	2026-03-18	19:00:00	OBSTACLE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
928d33f9-8ab5-4d55-825a-2112cc604d5d	2026-03-16 11:28:16.854128+00	c1625acc-f295-448e-8020-1a5ca3bfd564	2026-03-25	19:00:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
903da260-bfef-4020-aff1-9966758aefe2	2026-03-16 11:28:15.383093+00	5527fa09-42da-4b9f-b771-4de9e20434f2	2026-03-25	14:00:00	LONGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
6016166e-932a-4979-8790-03a0c26c99ba	2026-03-16 07:57:58.039306+00	5527fa09-42da-4b9f-b771-4de9e20434f2	2026-03-18	14:00:00	OBSTACLE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
a3c9c2b2-460a-402d-8e27-89d9804d47b4	2026-03-16 11:28:16.361009+00	d1d6dfcd-90a7-4870-b8d6-a993a8897810	2026-03-25	16:30:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
3a983f94-c153-422c-88fb-f799cbbd2073	2026-03-20 14:24:50.991139+00	97fd116b-b25f-459e-b8d7-a08052916748	2026-03-21	15:00:00	- RATTRAPÉ	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
4a93e21d-51a7-4441-a423-d01947503525	2026-03-16 11:33:30.929271+00	5527fa09-42da-4b9f-b771-4de9e20434f2	2026-04-01	14:00:00	JEUX	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
fa3ac3fb-9253-40d9-b58e-5267ae4e6c40	2026-03-20 18:26:38.83848+00	97fd116b-b25f-459e-b8d7-a08052916748	2026-03-28	15:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
74914a88-5ef1-446f-80d4-7a87209eeaec	2026-03-20 18:26:36.534328+00	9a893581-9a76-4bb2-a519-a9aa764ae4ff	2026-03-28	09:00:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
332cfdb6-53cf-495b-8436-fea3bcf76670	2026-03-20 18:26:37.2856+00	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	2026-03-28	10:00:00	LONGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
482be4a2-d367-4cac-9a56-91ee714fe333	2026-03-20 18:26:37.798252+00	38f2a4bd-910d-4595-bb77-34c92b353749	2026-03-28	11:00:00	OBSTACLE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
50a9aa4f-16ab-4dc3-bba7-5789b72e6504	2026-03-24 09:33:01.643366+00	\N	2025-09-17	10:00:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	11:00:00	\N
c2af00a3-32f2-4c63-a1c1-955471e939f4	2026-03-27 15:03:31.159566+00	\N	2025-09-07	10:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	12:00:00	\N
d8fff579-5fa0-41f3-a4ff-a19a05f36a67	2026-03-31 17:36:49.215078+00	\N	2025-12-17	10:00:00	EQUIFEEL	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	11:00:00	\N
8e2c3967-a1d6-439c-b9df-556c99a59740	2026-03-25 09:37:10.352746+00	\N	2026-03-27	18:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	20:00:00	\N
cf880d3b-3b63-4120-9e70-a83be892b0d1	2026-03-16 14:21:30.31831+00	\N	2026-03-16	18:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	20:00:00	\N
880e381f-e9c9-4ffa-ae24-0fd9c2735e11	2026-03-20 18:26:38.317665+00	e835851b-18fd-46da-9c66-8bbd99f8690c	2026-03-28	14:00:00	EQUIFUN	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
d167c565-1ed1-49a2-837e-1d3d7b9f4502	2026-03-29 08:58:47.700422+00	9a893581-9a76-4bb2-a519-a9aa764ae4ff	2026-05-09	09:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
4056c417-8a23-4ca3-a5c1-3d613149057e	2026-03-24 09:49:05.535601+00	\N	2025-09-28	10:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	12:00:00	\N
2b5196f1-f7af-47c7-88ab-5e13fb08243a	2026-03-20 14:51:15.180551+00	\N	2026-04-26	10:30:00	DRESSAGE	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	RATTRAPAGE 17/12/2026	#114788	12:00:00	\N
5bd1052c-82ae-46f8-a706-c12c8a46f85f	2026-03-20 14:24:49.326232+00	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	2026-03-21	10:00:00	OBSTACLE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
d50c78c2-032b-4101-bf1e-f3e9b7718ad1	2026-03-20 14:24:48.630127+00	9a893581-9a76-4bb2-a519-a9aa764ae4ff	2026-03-21	09:00:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
2ef4436e-dad9-491c-aad8-35cc84ecdca4	2026-03-20 14:24:49.870246+00	38f2a4bd-910d-4595-bb77-34c92b353749	2026-03-21	11:00:00	EQUIFEEL	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
4def5e4c-53fb-4af7-81ed-aab2b7f3132e	2026-03-31 14:44:11.639974+00	\N	2025-11-09	09:00:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	10:30:00	\N
305879cc-2e3f-4bef-9fae-ae3f4ba59939	2026-04-02 09:22:01.799465+00	\N	2026-02-27	18:30:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	\N	\N
220d309c-02d7-40d8-be2d-e19f10ecd4c9	2026-04-02 11:00:12.06236+00	\N	2026-04-05	10:30:00	JEUX	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	12:00:00	\N
bcfa1cdb-f190-48cc-82db-b2131505cb9f	2026-03-23 09:51:43.103738+00	9a893581-9a76-4bb2-a519-a9aa764ae4ff	2026-04-04	09:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
f67bbea7-6b82-4f66-a99e-a40559dd54de	2026-03-23 09:51:43.73176+00	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	2026-04-04	10:00:00	JEUX	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
321845a3-8385-4489-8fbb-2725f312d8e5	2026-03-23 09:51:45.373746+00	97fd116b-b25f-459e-b8d7-a08052916748	2026-04-04	15:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
ac9e2ac7-b88d-427f-b83b-2b20d22a219c	2026-03-23 09:51:44.308864+00	38f2a4bd-910d-4595-bb77-34c92b353749	2026-04-04	11:00:00	JEUX	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
d4d3b5ac-e99f-46de-a0cf-aa1fe4177d74	2026-03-16 11:33:32.62438+00	c1625acc-f295-448e-8020-1a5ca3bfd564	2026-04-01	19:00:00	JEUX	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
3727bd2b-ae09-4060-bfb1-4392298f4ff9	2026-02-26 08:41:55.966546+00	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	2026-01-07	15:30:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
e1152792-c321-4a78-ae79-d40328c02cef	2026-03-16 12:19:12.27593+00	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	2026-04-25	10:00:00	CROSS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
9c805a1c-17ed-41b8-a4d2-fe99b3827867	2026-03-16 12:19:07.50158+00	9a893581-9a76-4bb2-a519-a9aa764ae4ff	2026-04-18	09:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
ff04be4d-98ac-46ea-89f1-0d5124b93f6d	2026-03-16 12:19:08.036971+00	49eb08b4-b534-4aa6-a087-5b3a16d74f9e	2026-04-18	10:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
f2268971-eef5-4eec-bba6-f4b4434b5415	2026-03-16 12:19:08.581311+00	38f2a4bd-910d-4595-bb77-34c92b353749	2026-04-18	11:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
8533848b-f6f9-440b-800f-59780e56d718	2026-03-16 12:19:09.107017+00	e835851b-18fd-46da-9c66-8bbd99f8690c	2026-04-18	14:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
48196dd6-c4df-45cf-99d0-59591873a586	2026-03-16 12:19:09.634148+00	97fd116b-b25f-459e-b8d7-a08052916748	2026-04-18	15:00:00	- PAS COURS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
900f74cf-2f09-47c3-a9c8-4fe5d2dc4684	2026-03-24 17:28:39.486596+00	c1625acc-f295-448e-8020-1a5ca3bfd564	2026-04-22	19:00:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
e0b89ef3-cc1e-45cf-97bc-cec607b939cd	2026-03-16 12:19:11.722506+00	9a893581-9a76-4bb2-a519-a9aa764ae4ff	2026-04-25	09:00:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
c8fc849e-53d4-44cc-9074-07ec087875da	2026-03-24 17:28:37.924421+00	5527fa09-42da-4b9f-b771-4de9e20434f2	2026-04-22	14:00:00	EQUIFEEL	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
273777e2-b113-4184-8e98-cd147a948004	2026-03-24 17:28:38.962509+00	d1d6dfcd-90a7-4870-b8d6-a993a8897810	2026-04-22	16:30:00	CROSS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
1c11e732-ee21-48bf-ae67-f1d17a201f74	2026-03-24 17:28:38.451979+00	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	2026-04-22	15:30:00	EQUIFEEL	db44fd23-0251-41bc-a21c-95b9707eac57	44bb5822-25eb-495b-ac00-8ffa81153695	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
5a4c855f-a5f6-4a9d-8df6-4a7652e0aded	2026-03-16 12:19:12.803589+00	38f2a4bd-910d-4595-bb77-34c92b353749	2026-04-25	11:00:00	CROSS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
251a8ed4-80cf-4fad-8e03-63f60917d1c1	2026-03-16 12:19:13.312346+00	e835851b-18fd-46da-9c66-8bbd99f8690c	2026-04-25	14:00:00	SPRING GARDEN	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
d45da5ae-adc3-49d3-b1e1-10487adabf4a	2026-03-16 12:19:13.862856+00	97fd116b-b25f-459e-b8d7-a08052916748	2026-04-25	15:00:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
d45b5ec4-f6a0-459d-af25-aba52669b686	2026-03-24 17:29:37.744959+00	d1d6dfcd-90a7-4870-b8d6-a993a8897810	2026-04-29	16:30:00	CROSS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
b4a80331-0099-449d-b8f1-685f4630d67b	2026-03-24 17:29:38.478523+00	c1625acc-f295-448e-8020-1a5ca3bfd564	2026-04-29	19:00:00	CROSS	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
bd42e1ed-fda2-43c6-8f27-93f2b00e8b34	2026-03-20 14:24:50.665459+00	e835851b-18fd-46da-9c66-8bbd99f8690c	2026-03-21	14:00:00	VOLTIGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	c4b8378c-7955-452f-b3e3-d22ad430c4a7	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
02512bcc-cc3e-4d8a-ae5b-8f34f8da922f	2026-03-24 17:29:37.226284+00	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	2026-04-29	15:30:00	DRESSAGE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
87618f27-0efc-4904-bce7-e6fc6e7afcdb	2026-03-23 09:51:44.862018+00	e835851b-18fd-46da-9c66-8bbd99f8690c	2026-04-04	14:00:00	BALADE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
dd083fee-fec5-4f59-9c58-331ccf1f61bf	2026-03-24 17:29:36.670693+00	5527fa09-42da-4b9f-b771-4de9e20434f2	2026-04-29	14:00:00	OBSTACLE	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
23351651-d1d7-4c32-be83-2a2ec568f7d8	2026-03-24 08:19:41.294083+00	\N	2025-09-03	10:00:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	11:00:00	\N
f2e2785b-4254-4382-8901-03f73320dc4d	2026-03-16 11:33:31.899256+00	d1d6dfcd-90a7-4870-b8d6-a993a8897810	2026-04-01	16:30:00	JEUX	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
1de1c71c-97a6-4a19-9b53-8e5c15114e5f	2026-03-16 11:33:31.412159+00	6bf651bc-d740-4598-b6fe-98b4bb7c0f41	2026-04-01	15:30:00	JEUX	db44fd23-0251-41bc-a21c-95b9707eac57	\N	\N	CLE_SECRETE_FRONTOFFICE	\N	\N	\N	\N
3c10efdb-4333-41ba-bba2-d456a8c61c5b	2026-03-24 10:07:43.029239+00	\N	2025-09-24	10:00:00	PLAT	\N	\N	\N	CLE_SECRETE_FRONTOFFICE	Marine	#5b9bd5	11:00:00	\N
\.


--
-- TOC entry 4014 (class 0 OID 22494)
-- Dependencies: 395
-- Data for Name: stage_chevaux; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stage_chevaux (id, created_at, stage_id, equide_id, demi_journee, note, app_key) FROM stdin;
\.


--
-- TOC entry 4013 (class 0 OID 22474)
-- Dependencies: 394
-- Data for Name: stage_participants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stage_participants (id, created_at, stage_id, prenom, telephone, demi_journee, equide_id, note, app_key, regle, montant, methode_paiement, date_reglement) FROM stdin;
\.


--
-- TOC entry 4012 (class 0 OID 22465)
-- Dependencies: 393
-- Data for Name: stages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stages (id, created_at, titre, date_debut, date_fin, notes, app_key) FROM stdin;
cac1c879-2ca6-41f8-9f02-9a3c297c890d	2026-03-16 09:39:21.444478+00	Chasse aux Oeufs	2026-04-07	2026-04-07	25€	CLE_SECRETE_FRONTOFFICE
205d8714-f157-4c18-ae8d-e6c431d0b432	2026-03-16 09:40:09.021697+00	Cours particuliers	2026-04-07	2026-04-07	Galops 4 à 7\n30 minutes, 30€	CLE_SECRETE_FRONTOFFICE
d758e9c2-9484-441a-95c4-79aafc2630c8	2026-03-16 09:43:04.396362+00	Préparation & passage de galop poney ( Galop 1, 2, 3)	2026-04-09	2026-04-09		CLE_SECRETE_FRONTOFFICE
a24933db-cd9d-4c72-a9c8-78ee82e60296	2026-03-16 09:43:32.950185+00	Préparation & passage de galop poney ( Galop 1, 2, 3)	2026-04-10	2026-04-10		CLE_SECRETE_FRONTOFFICE
1b8dce76-1aa8-4854-a49d-4680393781a0	2026-03-16 09:44:09.532065+00	Tous âges, tous niveaux	2026-04-13	2026-04-13	Groupes en fonction des inscriptions	CLE_SECRETE_FRONTOFFICE
b32e27c7-a3ed-4d32-a874-ca6437f8e738	2026-03-16 09:44:25.620665+00	Tous âges, tous niveaux	2026-04-14	2026-04-14	Groupes en fonction des inscriptions	CLE_SECRETE_FRONTOFFICE
30e50d33-82c4-4a50-bfb2-8975243b86f0	2026-03-16 09:41:56.872358+00	Pony time	2026-04-08	2026-04-08	15€\n5 ans & moins de 10:30 à 12:00\n18€\n5 ans & plus de 14:00 à 16:00	CLE_SECRETE_FRONTOFFICE
f312d481-4fde-456e-a396-c97b5c9161c8	2026-03-16 09:44:38.985241+00	Pony time	2026-04-15	2026-04-15	15€\n5 ans & moins de 10:30 à 12:00\n18€\n5 ans & plus de 14:00 à 16:00	CLE_SECRETE_FRONTOFFICE
7db692f4-e517-4542-b66b-385ca246efac	2026-03-16 09:45:39.130492+00	Mon poney adoré	2026-04-16	2026-04-16	25€\nToilettage, balade et une suprise	CLE_SECRETE_FRONTOFFICE
86633c61-586a-413b-afb3-d6a53ac353d7	2026-03-16 09:46:00.831856+00	Cours particuliers	2026-04-16	2026-04-16	Galops 4 à 7 30 minutes, 30€	CLE_SECRETE_FRONTOFFICE
536eb68d-f81e-4ab5-979a-0513d40ffd8a	2026-03-16 09:47:31.335386+00	Préparation galop 4 à 6 ( Dressage & Obstacle ou Cross )	2026-04-17	2026-04-17	Dressage & Obstacle ou Cross, ...si le temps le permet	CLE_SECRETE_FRONTOFFICE
\.


--
-- TOC entry 4022 (class 0 OID 67267)
-- Dependencies: 406
-- Data for Name: taches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.taches (id, titre, description, frequence, jour_semaine, ordre, actif, created_at, app_key) FROM stdin;
3231191b-b5c6-46a3-b197-8da714dd66c8	MARCHEUR	ALYSSON. BALKAN. JAKAR. 	hebdo	1	1	t	2026-05-05 15:05:52.137238+00	CLE_SECRETE_FRONTOFFICE
6e9bd0d9-4cb9-4257-a45a-50cb9f9df52e	MARCHEUR	JAKAR. J’IMAGINE. JALOUSE.	hebdo	4	4	t	2026-05-05 15:06:58.588453+00	CLE_SECRETE_FRONTOFFICE
eadd8367-b09b-47d7-b5b3-f6f8238d57df	ENTRETIEN ABORDS	BALAYER :\n- dalles\n- selleries (Club, Propriétaires, Shets)\n- aires de pansage propriétaires\n- douches\n- ...	quotidien	\N	0	t	2026-05-05 15:12:40.096392+00	CLE_SECRETE_FRONTOFFICE
4c76325b-7c0b-48ce-b3a4-ac3fdfb9fcab	ABREUVOIRS & FILETS À FOIN	Vérifier la propreté et la nécessité de remplir.	hebdo	5	5	t	2026-05-05 15:09:58.470779+00	CLE_SECRETE_FRONTOFFICE
78bf1d2c-d128-46ae-b797-6aaf233208f7	ABREUVOIRS & FILETS À FOIN	Vérifier propreté et la nécessité de remplir	hebdo	1	1	t	2026-05-05 15:04:26.953413+00	CLE_SECRETE_FRONTOFFICE
\.


--
-- TOC entry 4023 (class 0 OID 67279)
-- Dependencies: 407
-- Data for Name: taches_completions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.taches_completions (id, tache_id, date, completee, completee_par, completed_at, app_key) FROM stdin;
\.


--
-- TOC entry 4020 (class 0 OID 67194)
-- Dependencies: 404
-- Data for Name: ticket_retours; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ticket_retours (id, ticket_id, auteur, message, lu, created_at, app_key) FROM stdin;
a9ecacfb-89f2-477e-bdf2-29c6f443f917	cf20797b-17a4-441f-8ff5-cc4f1d359aaf	Dev	Normalement elle devrait pouvoir avec le mdp LEO_Marine\nSi il faut le changer je peux	t	2026-04-28 09:35:42.267439+00	CLE_SECRETE_FRONTOFFICE
63b17dc1-7e1a-4f72-897b-d1772c030585	7aecd6d4-6c3f-4453-a531-e84b64a173ad	Admin	rafraichissement toutes les 5 minutes	f	2026-05-04 12:33:40.891058+00	CLE_SECRETE_FRONTOFFICE
39313e2a-eee8-4be8-a76e-aa9a647db1dc	8d843077-a47b-4d36-bc53-ee8b80663254	Dev	Le filtre actuel te convient ? si tu as 2 fois le même prénom, il ne faut pas faire espace mais chercher directement le nom sans le prénom	t	2026-04-28 09:40:26.164165+00	CLE_SECRETE_FRONTOFFICE
59e43d0b-6670-449e-95f2-7c168ec8c08e	8d843077-a47b-4d36-bc53-ee8b80663254	Dev	Mise à jour : maintenant tu peux faire prénom 'espace' nom et ça marche	t	2026-04-29 07:49:55.808431+00	CLE_SECRETE_FRONTOFFICE
27d77f4f-44c5-4884-9cf9-efc2b1e9c615	37c90a67-a569-4323-9c96-1daaba1c825e	Dev	possibilité de choisir entre x semaines et jusqu'au prochaine vacances dans la page paramètres	t	2026-04-29 15:58:59.425139+00	CLE_SECRETE_FRONTOFFICE
9f16e0b6-6f4f-49f7-8059-b01938fb218f	142aec46-118e-4760-8f33-f3971ba49e04	Dev	Tu voudrais que ce compte puisse créer des séances "balade en mains / réservations" ?	t	2026-04-28 09:42:26.303773+00	CLE_SECRETE_FRONTOFFICE
7bbeea7e-5357-47f1-b8a4-307a48d312ee	142aec46-118e-4760-8f33-f3971ba49e04	Admin	Une sorte d'onglet comme marine mais pour gérer les balade	t	2026-05-02 14:55:58.188796+00	CLE_SECRETE_FRONTOFFICE
\.


--
-- TOC entry 4019 (class 0 OID 59361)
-- Dependencies: 403
-- Data for Name: tickets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tickets (id, titre, description, type, priorite, statut, created_at, app_key, screenshot) FROM stdin;
209fff04-7d26-4737-8baf-67612ebb9fe3	Note COMMENTAIRE DE COURS	Peux-tu ajouter une note que les cavaliers peuvent consulter dans ma barre de leur cours (protection 4 membres, choisissez votre poney, ...).\ncomme je suis toute seule assez souvent, j'aime pouvoir mettre un commentaire quand je veux gagner du temps sur la préparation.	evolution	basse	termine	2026-04-24 06:20:11.305899+00	CLE_SECRETE_FRONTOFFICE	\N
fcc53095-460a-477f-815e-9a8f2b97f32e	EQUIFEEL 26/04	Séance créée le 26/04 n'apparait pas sur le planning en mode consultation.	bug	normale	nouveau	2026-04-26 08:09:23.644469+00	CLE_SECRETE_FRONTOFFICE	\N
142aec46-118e-4760-8f33-f3971ba49e04	MOT DE PASS	Créer un Mot de Passe : BaladMain_2026\npour que les élèves puissent consulter les reservation. Ceci me permettra de mettre directement dans le planning.	evolution	basse	en_cours	2026-04-24 08:58:36.599242+00	CLE_SECRETE_FRONTOFFICE	\N
04fce22b-f8ed-4aa6-a8f0-2b1a72d000c3	Rattrapages	👋 Ken,\n\nRegarde dans l'historique, les absence d'Ophélie.\nIl me semble avoir fait de la meme façon à chaque fois mais parfois le cheval ou la date de rattrapage n'apparait pas.\ncf 31/01.\nPour les rattrapages prévus à venir, je comprends mais j'ai déjà attribué le cheval. Ce n'es pas très grave mais pour les dates de rattrapages c'est moins pratique.\n🙏😘👋	bug	normale	nouveau	2026-04-04 06:30:38.176007+00	CLE_SECRETE_FRONTOFFICE	\N
f5f08b9b-11e9-440c-813b-e8e5ef12423d	Confort d'utilisation	Est-il possible de faire revenir l'appli sur la page sur laquelle je travaille, quand je rafraichis ?	evolution	basse	termine	2026-04-05 07:27:47.19347+00	CLE_SECRETE_FRONTOFFICE	\N
de658141-1ac7-401f-8ea4-7d6d6935b0aa	Général	Petite flèche de retour quand on a fait une connerie ?!	evolution	normale	en_cours	2026-04-05 10:42:30.583311+00	CLE_SECRETE_FRONTOFFICE	\N
d0e39f6c-c526-4f45-97e9-54e8b954ef60	Image dans les tickets	Pouvoir joindre une capture d'écran ou un fichier lors de la création d'un ticket pour mieux exprimer le besoin	evolution	basse	termine	2026-04-21 15:07:45.231073+00	CLE_SECRETE_FRONTOFFICE	\N
54d1d72d-4c16-43f9-8040-f406369ec340	niveau du cours	Je connais les niveaux via les couleurs mais si je pouvais ajouter une petite icône comme pour la discipline, ce serait cool.	evolution	basse	nouveau	2026-04-24 06:22:12.996668+00	CLE_SECRETE_FRONTOFFICE	\N
a3e787ef-4a21-4d8d-9884-d634e1789055	RATTRAPAGES	MARINE MARION LE 1/10/25 \nJ'ai piu selectionner le 01/10/2025 alors qu'il avait déjà été rattrapé en février.\nA regarder ensemble.	bug	haute	nouveau	2026-04-24 06:52:33.330539+00	CLE_SECRETE_FRONTOFFICE	\N
45d8c238-6dee-49fa-8845-9d2d57416b31	PAIEMENTS	Faire apparaitre le règlement sur le mode planning pour ne pas oublier de faire payer !\nSoit ça disparait quand c'est payé soit une icone 👍	evolution	normale	termine	2026-04-24 08:44:35.443479+00	CLE_SECRETE_FRONTOFFICE	\N
cf20797b-17a4-441f-8ff5-cc4f1d359aaf	ACCÈS	Ouvrir un accès à Marine, UNIQUEMENT sur les séances.	evolution	normale	termine	2026-04-24 08:40:24.45332+00	CLE_SECRETE_FRONTOFFICE	\N
8d843077-a47b-4d36-bc53-ee8b80663254	Filtre Client dans historique	J'ai deux Céline mais je ne peux pas en garder une seule (celle que je veux).\nQuand je rentre le prénom, les deux sont là, quand je fais l'espace pour mettre le nom de famille, elle disparaissent toutes les deux.	evolution	normale	termine	2026-04-04 07:38:59.084501+00	CLE_SECRETE_FRONTOFFICE	\N
37c90a67-a569-4323-9c96-1daaba1c825e	Rattrapage	Au bout de 8 semaines, le cours manqué n'est plus rattrapable	evolution	haute	termine	2026-04-28 09:49:18.422331+00	CLE_SECRETE_FRONTOFFICE	\N
6a780f5c-c574-4fbc-93e0-0cc8250f059d	Tâche a faire	Faire un onglet pour gérer les tâches par exemple les abreuvoirs etc	evolution	normale	termine	2026-05-02 15:00:28.180298+00	CLE_SECRETE_FRONTOFFICE	\N
7aecd6d4-6c3f-4453-a531-e84b64a173ad	Rafraichissement	Voir pour éviter d'avoir a faire f5 pour recharger les données	evolution	normale	termine	2026-05-02 08:06:17.433569+00	CLE_SECRETE_FRONTOFFICE	\N
f5bbf01e-dcdc-4725-8a24-8264dc215fa6	Semaine paire / impaire	Faire en sorte de pouvoir avoir des personnes qui montent une semaine sur deux	evolution	normale	termine	2026-05-02 12:34:36.055327+00	CLE_SECRETE_FRONTOFFICE	\N
\.


--
-- TOC entry 3756 (class 2606 OID 22449)
-- Name: affectations_seance affectations_seance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.affectations_seance
    ADD CONSTRAINT affectations_seance_pkey PRIMARY KEY (id);


--
-- TOC entry 3780 (class 2606 OID 67248)
-- Name: app_params app_params_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_params
    ADD CONSTRAINT app_params_pkey PRIMARY KEY (key);


--
-- TOC entry 3774 (class 2606 OID 51508)
-- Name: app_settings app_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_settings
    ADD CONSTRAINT app_settings_pkey PRIMARY KEY (key);


--
-- TOC entry 3790 (class 2606 OID 67438)
-- Name: balade_participants balade_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.balade_participants
    ADD CONSTRAINT balade_participants_pkey PRIMARY KEY (id);


--
-- TOC entry 3788 (class 2606 OID 67429)
-- Name: balades balades_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.balades
    ADD CONSTRAINT balades_pkey PRIMARY KEY (id);


--
-- TOC entry 3772 (class 2606 OID 51480)
-- Name: cartes_heures cartes_heures_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartes_heures
    ADD CONSTRAINT cartes_heures_pkey PRIMARY KEY (id);


--
-- TOC entry 3746 (class 2606 OID 22373)
-- Name: cavalier_groupes cavalier_groupes_cavalier_id_groupe_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cavalier_groupes
    ADD CONSTRAINT cavalier_groupes_cavalier_id_groupe_id_key UNIQUE (cavalier_id, groupe_id);


--
-- TOC entry 3748 (class 2606 OID 22371)
-- Name: cavalier_groupes cavalier_groupes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cavalier_groupes
    ADD CONSTRAINT cavalier_groupes_pkey PRIMARY KEY (id);


--
-- TOC entry 3744 (class 2606 OID 22363)
-- Name: cavaliers cavaliers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cavaliers
    ADD CONSTRAINT cavaliers_pkey PRIMARY KEY (id);


--
-- TOC entry 3764 (class 2606 OID 38102)
-- Name: discipline_icons discipline_icons_discipline_app_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discipline_icons
    ADD CONSTRAINT discipline_icons_discipline_app_key_key UNIQUE (discipline, app_key);


--
-- TOC entry 3766 (class 2606 OID 38100)
-- Name: discipline_icons discipline_icons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discipline_icons
    ADD CONSTRAINT discipline_icons_pkey PRIMARY KEY (id);


--
-- TOC entry 3768 (class 2606 OID 38121)
-- Name: disciplines disciplines_nom_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disciplines
    ADD CONSTRAINT disciplines_nom_key UNIQUE (nom);


--
-- TOC entry 3770 (class 2606 OID 38119)
-- Name: disciplines disciplines_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disciplines
    ADD CONSTRAINT disciplines_pkey PRIMARY KEY (id);


--
-- TOC entry 3752 (class 2606 OID 22404)
-- Name: equide_statuts equide_statuts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equide_statuts
    ADD CONSTRAINT equide_statuts_pkey PRIMARY KEY (id);


--
-- TOC entry 3750 (class 2606 OID 22395)
-- Name: equides equides_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equides
    ADD CONSTRAINT equides_pkey PRIMARY KEY (id);


--
-- TOC entry 3742 (class 2606 OID 22344)
-- Name: groupes groupes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groupes
    ADD CONSTRAINT groupes_pkey PRIMARY KEY (id);


--
-- TOC entry 3740 (class 2606 OID 22334)
-- Name: moniteurs moniteurs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moniteurs
    ADD CONSTRAINT moniteurs_pkey PRIMARY KEY (id);


--
-- TOC entry 3754 (class 2606 OID 22418)
-- Name: seances seances_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seances
    ADD CONSTRAINT seances_pkey PRIMARY KEY (id);


--
-- TOC entry 3762 (class 2606 OID 22503)
-- Name: stage_chevaux stage_chevaux_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stage_chevaux
    ADD CONSTRAINT stage_chevaux_pkey PRIMARY KEY (id);


--
-- TOC entry 3760 (class 2606 OID 22483)
-- Name: stage_participants stage_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stage_participants
    ADD CONSTRAINT stage_participants_pkey PRIMARY KEY (id);


--
-- TOC entry 3758 (class 2606 OID 22473)
-- Name: stages stages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stages
    ADD CONSTRAINT stages_pkey PRIMARY KEY (id);


--
-- TOC entry 3784 (class 2606 OID 67287)
-- Name: taches_completions taches_completions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taches_completions
    ADD CONSTRAINT taches_completions_pkey PRIMARY KEY (id);


--
-- TOC entry 3786 (class 2606 OID 67289)
-- Name: taches_completions taches_completions_tache_id_date_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taches_completions
    ADD CONSTRAINT taches_completions_tache_id_date_key UNIQUE (tache_id, date);


--
-- TOC entry 3782 (class 2606 OID 67278)
-- Name: taches taches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taches
    ADD CONSTRAINT taches_pkey PRIMARY KEY (id);


--
-- TOC entry 3778 (class 2606 OID 67204)
-- Name: ticket_retours ticket_retours_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket_retours
    ADD CONSTRAINT ticket_retours_pkey PRIMARY KEY (id);


--
-- TOC entry 3776 (class 2606 OID 59371)
-- Name: tickets tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (id);


--
-- TOC entry 3800 (class 2606 OID 22455)
-- Name: affectations_seance affectations_seance_cavalier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.affectations_seance
    ADD CONSTRAINT affectations_seance_cavalier_id_fkey FOREIGN KEY (cavalier_id) REFERENCES public.cavaliers(id) ON DELETE CASCADE;


--
-- TOC entry 3801 (class 2606 OID 22460)
-- Name: affectations_seance affectations_seance_equide_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.affectations_seance
    ADD CONSTRAINT affectations_seance_equide_id_fkey FOREIGN KEY (equide_id) REFERENCES public.equides(id) ON DELETE SET NULL;


--
-- TOC entry 3802 (class 2606 OID 22450)
-- Name: affectations_seance affectations_seance_seance_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.affectations_seance
    ADD CONSTRAINT affectations_seance_seance_id_fkey FOREIGN KEY (seance_id) REFERENCES public.seances(id) ON DELETE CASCADE;


--
-- TOC entry 3810 (class 2606 OID 67439)
-- Name: balade_participants balade_participants_balade_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.balade_participants
    ADD CONSTRAINT balade_participants_balade_id_fkey FOREIGN KEY (balade_id) REFERENCES public.balades(id);


--
-- TOC entry 3811 (class 2606 OID 67444)
-- Name: balade_participants balade_participants_equide_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.balade_participants
    ADD CONSTRAINT balade_participants_equide_id_fkey FOREIGN KEY (equide_id) REFERENCES public.equides(id);


--
-- TOC entry 3807 (class 2606 OID 51481)
-- Name: cartes_heures cartes_heures_cavalier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartes_heures
    ADD CONSTRAINT cartes_heures_cavalier_id_fkey FOREIGN KEY (cavalier_id) REFERENCES public.cavaliers(id) ON DELETE CASCADE;


--
-- TOC entry 3793 (class 2606 OID 22374)
-- Name: cavalier_groupes cavalier_groupes_cavalier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cavalier_groupes
    ADD CONSTRAINT cavalier_groupes_cavalier_id_fkey FOREIGN KEY (cavalier_id) REFERENCES public.cavaliers(id) ON DELETE CASCADE;


--
-- TOC entry 3794 (class 2606 OID 22379)
-- Name: cavalier_groupes cavalier_groupes_groupe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cavalier_groupes
    ADD CONSTRAINT cavalier_groupes_groupe_id_fkey FOREIGN KEY (groupe_id) REFERENCES public.groupes(id) ON DELETE CASCADE;


--
-- TOC entry 3795 (class 2606 OID 22405)
-- Name: equide_statuts equide_statuts_equide_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equide_statuts
    ADD CONSTRAINT equide_statuts_equide_id_fkey FOREIGN KEY (equide_id) REFERENCES public.equides(id) ON DELETE CASCADE;


--
-- TOC entry 3791 (class 2606 OID 22350)
-- Name: groupes groupes_eleve_moniteur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groupes
    ADD CONSTRAINT groupes_eleve_moniteur_id_fkey FOREIGN KEY (eleve_moniteur_id) REFERENCES public.moniteurs(id) ON DELETE SET NULL;


--
-- TOC entry 3792 (class 2606 OID 22345)
-- Name: groupes groupes_moniteur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groupes
    ADD CONSTRAINT groupes_moniteur_id_fkey FOREIGN KEY (moniteur_id) REFERENCES public.moniteurs(id) ON DELETE SET NULL;


--
-- TOC entry 3796 (class 2606 OID 22419)
-- Name: seances seances_groupe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seances
    ADD CONSTRAINT seances_groupe_id_fkey FOREIGN KEY (groupe_id) REFERENCES public.groupes(id) ON DELETE CASCADE;


--
-- TOC entry 3797 (class 2606 OID 22434)
-- Name: seances seances_moniteur2_cheval_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seances
    ADD CONSTRAINT seances_moniteur2_cheval_id_fkey FOREIGN KEY (moniteur2_cheval_id) REFERENCES public.equides(id) ON DELETE SET NULL;


--
-- TOC entry 3798 (class 2606 OID 22429)
-- Name: seances seances_moniteur2_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seances
    ADD CONSTRAINT seances_moniteur2_id_fkey FOREIGN KEY (moniteur2_id) REFERENCES public.moniteurs(id) ON DELETE SET NULL;


--
-- TOC entry 3799 (class 2606 OID 22424)
-- Name: seances seances_moniteur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seances
    ADD CONSTRAINT seances_moniteur_id_fkey FOREIGN KEY (moniteur_id) REFERENCES public.moniteurs(id) ON DELETE SET NULL;


--
-- TOC entry 3805 (class 2606 OID 22509)
-- Name: stage_chevaux stage_chevaux_equide_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stage_chevaux
    ADD CONSTRAINT stage_chevaux_equide_id_fkey FOREIGN KEY (equide_id) REFERENCES public.equides(id) ON DELETE CASCADE;


--
-- TOC entry 3806 (class 2606 OID 22504)
-- Name: stage_chevaux stage_chevaux_stage_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stage_chevaux
    ADD CONSTRAINT stage_chevaux_stage_id_fkey FOREIGN KEY (stage_id) REFERENCES public.stages(id) ON DELETE CASCADE;


--
-- TOC entry 3803 (class 2606 OID 22489)
-- Name: stage_participants stage_participants_equide_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stage_participants
    ADD CONSTRAINT stage_participants_equide_id_fkey FOREIGN KEY (equide_id) REFERENCES public.equides(id) ON DELETE SET NULL;


--
-- TOC entry 3804 (class 2606 OID 22484)
-- Name: stage_participants stage_participants_stage_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stage_participants
    ADD CONSTRAINT stage_participants_stage_id_fkey FOREIGN KEY (stage_id) REFERENCES public.stages(id) ON DELETE CASCADE;


--
-- TOC entry 3809 (class 2606 OID 67290)
-- Name: taches_completions taches_completions_tache_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taches_completions
    ADD CONSTRAINT taches_completions_tache_id_fkey FOREIGN KEY (tache_id) REFERENCES public.taches(id) ON DELETE CASCADE;


--
-- TOC entry 3808 (class 2606 OID 67205)
-- Name: ticket_retours ticket_retours_ticket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket_retours
    ADD CONSTRAINT ticket_retours_ticket_id_fkey FOREIGN KEY (ticket_id) REFERENCES public.tickets(id) ON DELETE CASCADE;


--
-- TOC entry 3967 (class 0 OID 22439)
-- Dependencies: 392
-- Name: affectations_seance; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.affectations_seance ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3990 (class 3256 OID 22521)
-- Name: affectations_seance app; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY app ON public.affectations_seance USING ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text)) WITH CHECK ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text));


--
-- TOC entry 3996 (class 3256 OID 67249)
-- Name: app_params app; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY app ON public.app_params USING ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text)) WITH CHECK ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text));


--
-- TOC entry 4002 (class 3256 OID 51509)
-- Name: app_settings app; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY app ON public.app_settings USING ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text)) WITH CHECK ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text));


--
-- TOC entry 4001 (class 3256 OID 51489)
-- Name: cartes_heures app; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY app ON public.cartes_heures USING ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text)) WITH CHECK ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text));


--
-- TOC entry 3986 (class 3256 OID 22517)
-- Name: cavalier_groupes app; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY app ON public.cavalier_groupes USING ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text)) WITH CHECK ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text));


--
-- TOC entry 3985 (class 3256 OID 22516)
-- Name: cavaliers app; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY app ON public.cavaliers USING ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text)) WITH CHECK ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text));


--
-- TOC entry 3995 (class 3256 OID 38103)
-- Name: discipline_icons app; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY app ON public.discipline_icons USING ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text)) WITH CHECK ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text));


--
-- TOC entry 3988 (class 3256 OID 22519)
-- Name: equide_statuts app; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY app ON public.equide_statuts USING ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text)) WITH CHECK ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text));


--
-- TOC entry 3987 (class 3256 OID 22518)
-- Name: equides app; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY app ON public.equides USING ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text)) WITH CHECK ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text));


--
-- TOC entry 3984 (class 3256 OID 22515)
-- Name: groupes app; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY app ON public.groupes USING ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text)) WITH CHECK ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text));


--
-- TOC entry 3983 (class 3256 OID 22514)
-- Name: moniteurs app; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY app ON public.moniteurs USING ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text)) WITH CHECK ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text));


--
-- TOC entry 3989 (class 3256 OID 22520)
-- Name: seances app; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY app ON public.seances USING ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text)) WITH CHECK ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text));


--
-- TOC entry 3993 (class 3256 OID 22524)
-- Name: stage_chevaux app; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY app ON public.stage_chevaux USING ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text)) WITH CHECK ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text));


--
-- TOC entry 3992 (class 3256 OID 22523)
-- Name: stage_participants app; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY app ON public.stage_participants USING ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text)) WITH CHECK ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text));


--
-- TOC entry 3991 (class 3256 OID 22522)
-- Name: stages app; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY app ON public.stages USING ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text)) WITH CHECK ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text));


--
-- TOC entry 3997 (class 3256 OID 67295)
-- Name: taches app; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY app ON public.taches USING ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text)) WITH CHECK ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text));


--
-- TOC entry 3998 (class 3256 OID 67296)
-- Name: taches_completions app; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY app ON public.taches_completions USING ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text)) WITH CHECK ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text));


--
-- TOC entry 3994 (class 3256 OID 67210)
-- Name: ticket_retours app; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY app ON public.ticket_retours USING ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text)) WITH CHECK ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text));


--
-- TOC entry 3982 (class 3256 OID 59372)
-- Name: tickets app; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY app ON public.tickets USING ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text)) WITH CHECK ((app_key = 'CLE_SECRETE_FRONTOFFICE'::text));


--
-- TOC entry 3977 (class 0 OID 67241)
-- Dependencies: 405
-- Name: app_params; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.app_params ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3974 (class 0 OID 51502)
-- Dependencies: 402
-- Name: app_settings; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.app_settings ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3981 (class 0 OID 67430)
-- Dependencies: 409
-- Name: balade_participants; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.balade_participants ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3980 (class 0 OID 67421)
-- Dependencies: 408
-- Name: balades; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.balades ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3973 (class 0 OID 51473)
-- Dependencies: 401
-- Name: cartes_heures; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.cartes_heures ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3963 (class 0 OID 22364)
-- Dependencies: 388
-- Name: cavalier_groupes; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.cavalier_groupes ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3962 (class 0 OID 22355)
-- Dependencies: 387
-- Name: cavaliers; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.cavaliers ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3971 (class 0 OID 38092)
-- Dependencies: 397
-- Name: discipline_icons; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.discipline_icons ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3972 (class 0 OID 38111)
-- Dependencies: 398
-- Name: disciplines; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.disciplines ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3999 (class 3256 OID 38122)
-- Name: disciplines disciplines_read; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY disciplines_read ON public.disciplines FOR SELECT USING (true);


--
-- TOC entry 4000 (class 3256 OID 38123)
-- Name: disciplines disciplines_write; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY disciplines_write ON public.disciplines USING (true) WITH CHECK (true);


--
-- TOC entry 3965 (class 0 OID 22396)
-- Dependencies: 390
-- Name: equide_statuts; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.equide_statuts ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3964 (class 0 OID 22384)
-- Dependencies: 389
-- Name: equides; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.equides ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3961 (class 0 OID 22335)
-- Dependencies: 386
-- Name: groupes; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.groupes ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3960 (class 0 OID 22324)
-- Dependencies: 385
-- Name: moniteurs; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.moniteurs ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3966 (class 0 OID 22410)
-- Dependencies: 391
-- Name: seances; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.seances ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3970 (class 0 OID 22494)
-- Dependencies: 395
-- Name: stage_chevaux; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.stage_chevaux ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3969 (class 0 OID 22474)
-- Dependencies: 394
-- Name: stage_participants; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.stage_participants ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3968 (class 0 OID 22465)
-- Dependencies: 393
-- Name: stages; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.stages ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3978 (class 0 OID 67267)
-- Dependencies: 406
-- Name: taches; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.taches ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3979 (class 0 OID 67279)
-- Dependencies: 407
-- Name: taches_completions; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.taches_completions ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3976 (class 0 OID 67194)
-- Dependencies: 404
-- Name: ticket_retours; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.ticket_retours ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3975 (class 0 OID 59361)
-- Dependencies: 403
-- Name: tickets; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.tickets ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4031 (class 0 OID 0)
-- Dependencies: 392
-- Name: TABLE affectations_seance; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.affectations_seance TO anon;
GRANT ALL ON TABLE public.affectations_seance TO authenticated;
GRANT ALL ON TABLE public.affectations_seance TO service_role;


--
-- TOC entry 4032 (class 0 OID 0)
-- Dependencies: 405
-- Name: TABLE app_params; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.app_params TO anon;
GRANT ALL ON TABLE public.app_params TO authenticated;
GRANT ALL ON TABLE public.app_params TO service_role;


--
-- TOC entry 4033 (class 0 OID 0)
-- Dependencies: 402
-- Name: TABLE app_settings; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.app_settings TO anon;
GRANT ALL ON TABLE public.app_settings TO authenticated;
GRANT ALL ON TABLE public.app_settings TO service_role;


--
-- TOC entry 4034 (class 0 OID 0)
-- Dependencies: 409
-- Name: TABLE balade_participants; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.balade_participants TO anon;
GRANT ALL ON TABLE public.balade_participants TO authenticated;
GRANT ALL ON TABLE public.balade_participants TO service_role;


--
-- TOC entry 4035 (class 0 OID 0)
-- Dependencies: 408
-- Name: TABLE balades; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.balades TO anon;
GRANT ALL ON TABLE public.balades TO authenticated;
GRANT ALL ON TABLE public.balades TO service_role;


--
-- TOC entry 4036 (class 0 OID 0)
-- Dependencies: 401
-- Name: TABLE cartes_heures; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.cartes_heures TO anon;
GRANT ALL ON TABLE public.cartes_heures TO authenticated;
GRANT ALL ON TABLE public.cartes_heures TO service_role;


--
-- TOC entry 4037 (class 0 OID 0)
-- Dependencies: 388
-- Name: TABLE cavalier_groupes; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.cavalier_groupes TO anon;
GRANT ALL ON TABLE public.cavalier_groupes TO authenticated;
GRANT ALL ON TABLE public.cavalier_groupes TO service_role;


--
-- TOC entry 4038 (class 0 OID 0)
-- Dependencies: 387
-- Name: TABLE cavaliers; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.cavaliers TO anon;
GRANT ALL ON TABLE public.cavaliers TO authenticated;
GRANT ALL ON TABLE public.cavaliers TO service_role;


--
-- TOC entry 4039 (class 0 OID 0)
-- Dependencies: 397
-- Name: TABLE discipline_icons; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.discipline_icons TO anon;
GRANT ALL ON TABLE public.discipline_icons TO authenticated;
GRANT ALL ON TABLE public.discipline_icons TO service_role;


--
-- TOC entry 4040 (class 0 OID 0)
-- Dependencies: 398
-- Name: TABLE disciplines; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.disciplines TO anon;
GRANT ALL ON TABLE public.disciplines TO authenticated;
GRANT ALL ON TABLE public.disciplines TO service_role;


--
-- TOC entry 4041 (class 0 OID 0)
-- Dependencies: 390
-- Name: TABLE equide_statuts; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.equide_statuts TO anon;
GRANT ALL ON TABLE public.equide_statuts TO authenticated;
GRANT ALL ON TABLE public.equide_statuts TO service_role;


--
-- TOC entry 4042 (class 0 OID 0)
-- Dependencies: 389
-- Name: TABLE equides; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.equides TO anon;
GRANT ALL ON TABLE public.equides TO authenticated;
GRANT ALL ON TABLE public.equides TO service_role;


--
-- TOC entry 4043 (class 0 OID 0)
-- Dependencies: 386
-- Name: TABLE groupes; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.groupes TO anon;
GRANT ALL ON TABLE public.groupes TO authenticated;
GRANT ALL ON TABLE public.groupes TO service_role;


--
-- TOC entry 4044 (class 0 OID 0)
-- Dependencies: 385
-- Name: TABLE moniteurs; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.moniteurs TO anon;
GRANT ALL ON TABLE public.moniteurs TO authenticated;
GRANT ALL ON TABLE public.moniteurs TO service_role;


--
-- TOC entry 4045 (class 0 OID 0)
-- Dependencies: 391
-- Name: TABLE seances; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.seances TO anon;
GRANT ALL ON TABLE public.seances TO authenticated;
GRANT ALL ON TABLE public.seances TO service_role;


--
-- TOC entry 4046 (class 0 OID 0)
-- Dependencies: 395
-- Name: TABLE stage_chevaux; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.stage_chevaux TO anon;
GRANT ALL ON TABLE public.stage_chevaux TO authenticated;
GRANT ALL ON TABLE public.stage_chevaux TO service_role;


--
-- TOC entry 4047 (class 0 OID 0)
-- Dependencies: 394
-- Name: TABLE stage_participants; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.stage_participants TO anon;
GRANT ALL ON TABLE public.stage_participants TO authenticated;
GRANT ALL ON TABLE public.stage_participants TO service_role;


--
-- TOC entry 4048 (class 0 OID 0)
-- Dependencies: 393
-- Name: TABLE stages; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.stages TO anon;
GRANT ALL ON TABLE public.stages TO authenticated;
GRANT ALL ON TABLE public.stages TO service_role;


--
-- TOC entry 4049 (class 0 OID 0)
-- Dependencies: 406
-- Name: TABLE taches; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.taches TO anon;
GRANT ALL ON TABLE public.taches TO authenticated;
GRANT ALL ON TABLE public.taches TO service_role;


--
-- TOC entry 4050 (class 0 OID 0)
-- Dependencies: 407
-- Name: TABLE taches_completions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.taches_completions TO anon;
GRANT ALL ON TABLE public.taches_completions TO authenticated;
GRANT ALL ON TABLE public.taches_completions TO service_role;


--
-- TOC entry 4051 (class 0 OID 0)
-- Dependencies: 404
-- Name: TABLE ticket_retours; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.ticket_retours TO anon;
GRANT ALL ON TABLE public.ticket_retours TO authenticated;
GRANT ALL ON TABLE public.ticket_retours TO service_role;


--
-- TOC entry 4052 (class 0 OID 0)
-- Dependencies: 403
-- Name: TABLE tickets; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.tickets TO anon;
GRANT ALL ON TABLE public.tickets TO authenticated;
GRANT ALL ON TABLE public.tickets TO service_role;


-- Completed on 2026-05-06 10:12:17

--
-- PostgreSQL database dump complete
--

\unrestrict XDoYUG7CUfuopJdRy4cW0LkP7SshXP8FCdyhWZRjiiwM4bOTnDyRrmjx6qh6j9N

