# Serveur d'automatisation IA

Ce dépôt est un kit apprenant pour préparer une machine qui servira de laboratoire d'automatisation : un petit VPS, un serveur maison, ou une machine distante fournie pendant l'atelier.

Le but est simple : comprendre comment assembler des briques fiables (`SSH`, `Git`, `systemd`, `n8n`, scripts) avec des agents IA (`Codex` d'abord, Claude Code en option) sans exposer ses secrets ni publier un panneau d'administration sur Internet.

## Parcours recommandé

1. Lire [docs/01-choisir-son-serveur.md](docs/01-choisir-son-serveur.md) pour choisir entre VPS et serveur maison.
2. Lire [docs/02-installation-guidee.md](docs/02-installation-guidee.md) pour installer les briques de base.
3. Lire [docs/03-faire-travailler-une-ia-sur-le-serveur.md](docs/03-faire-travailler-une-ia-sur-le-serveur.md) pour comprendre les facons de lancer une IA depuis le serveur.
4. Lire [docs/04-secrets-authentification.md](docs/04-secrets-authentification.md) avant toute connexion a Google, Microsoft, Airtable, Twilio, GitHub ou OpenAI.

## Demarrage rapide

Depuis votre ordinateur local :

```bash
ssh utilisateur@adresse-du-serveur
```

Dans le depot, lancez un diagnostic sans rien modifier :

```bash
.agents/skills/installer-serveur-automatisation/scripts/diagnostic_serveur.sh
```

Preparez ensuite un plan d'installation :

```bash
.agents/skills/installer-serveur-automatisation/scripts/installer_serveur_automatisation.sh --plan --target auto
```

Quand le plan est compris et accepte, appliquez-le :

```bash
.agents/skills/installer-serveur-automatisation/scripts/installer_serveur_automatisation.sh --apply --target auto
```

## Acceder a n8n depuis son navigateur local

Par defaut, n8n doit rester en ecoute locale sur le serveur (`127.0.0.1:5678`). Pour l'ouvrir sur votre ordinateur :

```bash
ssh -N -L 5678:127.0.0.1:5678 utilisateur@adresse-du-serveur
```

Puis ouvrez :

```text
http://localhost:5678
```

Si le port `5678` est deja occupe sur votre ordinateur :

```bash
ssh -N -L 15678:127.0.0.1:5678 utilisateur@adresse-du-serveur
```

Puis ouvrez :

```text
http://localhost:15678
```

## Ce que contient le depot

- `README.md` : point d'entree apprenant.
- `AGENTS.md` : contexte commun pour Codex, Claude Code et autres agents.
- `CLAUDE.md` : lien symbolique vers `AGENTS.md`.
- `docs/` : guides progressifs pour choisir, installer, securiser et exploiter le serveur.
- `.agents/skills/installer-serveur-automatisation/` : skill principale avec scripts de diagnostic et d'installation.
- `.agents/skills/grill-me/` : skill de questionnement critique.
- `.agents/skills/find-skills/` : skill de recherche de capabilities.

## Regles de securite

- Ne collez jamais de cle API, token OAuth, mot de passe, cle SSH privee ou secret client dans un prompt.
- Faites les authentifications dans votre navigateur habituel, dans un flux device-code officiel, dans un CLI officiel, ou dans n8n ouvert par tunnel SSH.
- Gardez les interfaces d'administration en `127.0.0.1` tant que vous n'avez pas volontairement configure HTTPS, domaine, reverse proxy et authentification.
- Commencez avec des donnees fictives. Branchez les comptes reels seulement quand le flux est compris et valide.
