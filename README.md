# Serveur d'automatisation IA

Ce dépôt est un contexte de travail pour installer, comprendre et faire évoluer votre propre serveur d'automatisation IA.

Il sert à guider un agent comme Codex ou Claude Code pendant qu'il vous aide à préparer une machine Linux : VPS, serveur maison, mini-PC, NAS Linux ou machine de développement distante que vous contrôlez.

Le but n'est pas de tout confier à l'IA. Le but est d'assembler proprement :

```text
serveur Linux -> SSH -> Git -> Node -> n8n -> scripts -> agents IA -> validations humaines
```

## Ce que ce dépôt permet

- Diagnostiquer une machine Linux sans rien modifier.
- Installer les briques de base : `git`, `gh`, `tmux`, `ufw`, `nvm`, Node, `n8n`, Codex CLI et Claude Code.
- Garder n8n en local-only et l'ouvrir par tunnel SSH.
- Comprendre deux chemins agentiques de premier rang : Codex et Claude.
- Préparer des automatisations où n8n orchestre, le code fiabilise, et l'IA aide à lire, classer, rédiger ou piloter.
- Mettre les secrets au bon endroit, sans les coller dans le chat.

## Parcours recommandé

1. Lire [docs/01-choisir-son-serveur.md](docs/01-choisir-son-serveur.md) pour choisir entre VPS et serveur maison.
2. Lire [docs/02-installation-guidee.md](docs/02-installation-guidee.md) pour installer les briques de base.
3. Lire [docs/03-chemins-agentiques.md](docs/03-chemins-agentiques.md) pour choisir comment piloter le serveur avec Codex ou Claude.
4. Lire [docs/04-secrets-authentification.md](docs/04-secrets-authentification.md) avant toute connexion à Google, Microsoft, Airtable, Twilio, GitHub, OpenAI ou Anthropic.
5. Lire [docs/05-creer-des-automatisations.md](docs/05-creer-des-automatisations.md) pour passer d'un serveur prêt à des automatisations utiles.

## Démarrage rapide

Depuis votre ordinateur local :

```bash
ssh utilisateur@adresse-du-serveur
```

Dans le dépôt, lancez un diagnostic sans rien modifier :

```bash
.agents/skills/installer-serveur-automatisation/scripts/diagnostic_serveur.sh
```

Préparez ensuite un plan d'installation :

```bash
.agents/skills/installer-serveur-automatisation/scripts/installer_serveur_automatisation.sh --plan --target auto
```

Quand le plan est compris et accepté, appliquez-le :

```bash
.agents/skills/installer-serveur-automatisation/scripts/installer_serveur_automatisation.sh --apply --target auto
```

## Accéder à n8n depuis son navigateur local

Par défaut, n8n doit rester en écoute locale sur le serveur (`127.0.0.1:5678`). Pour l'ouvrir sur votre ordinateur :

```bash
ssh -N -L 5678:127.0.0.1:5678 utilisateur@adresse-du-serveur
```

Puis ouvrez :

```text
http://localhost:5678
```

Si le port `5678` est déjà occupé sur votre ordinateur :

```bash
ssh -N -L 15678:127.0.0.1:5678 utilisateur@adresse-du-serveur
```

Puis ouvrez :

```text
http://localhost:15678
```

## Ce que contient le dépôt

- `AGENTS.md` : instructions vivantes pour l'agent qui vous accompagne.
- `CLAUDE.md` : lien symbolique vers `AGENTS.md`, pour que Claude Code lise le même contexte.
- `docs/` : guides progressifs pour choisir, installer, connecter, sécuriser et automatiser.
- `.agents/skills/installer-serveur-automatisation/` : skill principale avec scripts de diagnostic et d'installation.
- `.agents/skills/grill-me/` : skill de questionnement critique.
- `.agents/skills/find-skills/` : skill de recherche de capabilities.

## Règles de sécurité

- Ne collez jamais de clé API, token OAuth, mot de passe, clé SSH privée ou secret client dans un prompt.
- Faites les authentifications dans votre navigateur habituel, dans un flux device-code officiel, dans un CLI officiel, ou dans n8n ouvert par tunnel SSH.
- Gardez les interfaces d'administration en `127.0.0.1` tant que vous n'avez pas volontairement configuré HTTPS, domaine, reverse proxy et authentification.
- Commencez avec des données fictives. Branchez les comptes réels seulement quand le flux est compris et validé.
