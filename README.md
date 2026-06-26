# Serveur d'automatisation IA

Ce dépôt est un contexte de travail pour installer, comprendre et faire évoluer votre propre serveur d'automatisation IA avec un agent local comme Codex ou Claude.

Il est conçu pour une situation fréquente : vous avez déjà une app agentique sur votre ordinateur, mais vous n'avez pas encore de serveur, pas encore de connexion SSH, ou pas encore de pont fiable entre votre machine locale et la machine distante.

Le but n'est pas de tout confier à l'IA. Le but est d'assembler proprement :

```text
serveur Linux -> SSH -> Git -> Node -> n8n -> scripts -> agents IA -> validations humaines
```

## Point de départ agent-first

Ouvrez ce dépôt dans Codex ou Claude, puis copiez ce prompt :

```text
Lis README.md puis AGENTS.md. Guide-moi pas à pas avec docs/00-checklist-setup-agentique.md.

Je pars avec une app agentique locale, mais je ne suis pas sûr d'avoir un serveur prêt ni un accès SSH fiable.

Commence par identifier mon niveau, mon objectif, et le bon chemin : VPS, serveur maison, ou serveur déjà existant. Ne me demande jamais de coller un secret dans le chat. Pour chaque commande, dis-moi clairement si elle doit être lancée sur mon ordinateur local ou sur le serveur.
```

L'agent doit ensuite suivre la checklist, pas improviser un tunnel de commandes.

## Trois chemins

- **Je n'ai pas encore de serveur** : commencer par choisir VPS ou serveur maison avec [docs/01-choisir-son-serveur.md](docs/01-choisir-son-serveur.md).
- **J'ai un serveur mais pas de bridge** : établir SSH, vérifier l'utilisateur, puis cloner ce dépôt.
- **J'ai déjà SSH et le dépôt sur le serveur** : lancer diagnostic, plan, installation, authentifications, puis première automatisation.

## Courbe d'apprentissage

Le dépôt accepte trois niveaux. L'agent doit adapter ses explications :

- **Débutant** : peu de jargon, une commande à la fois, explication courte de chaque mot technique.
- **Curieux technique** : explication du pourquoi, schémas mentaux, liens vers le glossaire.
- **Dev** : commandes plus denses, hypothèses explicites, vérification rapide.

Le vocabulaire est centralisé dans [docs/glossaire.md](docs/glossaire.md).

## Séquence pratique

### Avant SSH

Si vous n'avez pas encore de serveur ou pas encore d'accès :

1. Choisir VPS, serveur maison, ou serveur déjà existant.
2. Créer ou trouver l'adresse du serveur.
3. Créer ou retrouver une clé SSH publique.
4. Configurer `~/.ssh/config` si possible.
5. Tester `ssh utilisateur@adresse-du-serveur`.

### Après SSH

Une fois connecté au serveur :

```bash
git clone https://github.com/gaelcado/serveur-automatisation-ia.git
cd serveur-automatisation-ia
.agents/skills/installer-serveur-automatisation/scripts/diagnostic_serveur.sh
.agents/skills/installer-serveur-automatisation/scripts/installer_serveur_automatisation.sh --plan --target auto
```

Quand le plan est compris et accepté :

```bash
.agents/skills/installer-serveur-automatisation/scripts/installer_serveur_automatisation.sh --apply --target auto
```

### Après installation

Authentifiez les services sans coller de secrets dans le chat :

```bash
gh auth login
codex login
claude
```

Ouvrez n8n depuis votre ordinateur local avec un tunnel :

```bash
ssh -N -L 5678:127.0.0.1:5678 utilisateur@adresse-du-serveur
```

Puis ouvrez :

```text
http://localhost:5678
```

## Ce que contient le dépôt

- `AGENTS.md` : mode d'emploi pour l'agent qui vous accompagne.
- `CLAUDE.md` : lien symbolique vers `AGENTS.md`, pour que Claude Code lise le même contexte.
- `docs/00-checklist-setup-agentique.md` : chemin principal agent-first.
- `docs/glossaire.md` : vocabulaire serveur, automation et agents IA.
- `.agents/skills/installer-serveur-automatisation/` : skill principale avec scripts de diagnostic et d'installation.
- `.agents/skills/grill-me/` et `.agents/skills/find-skills/` : skills complémentaires.

## Règles de sécurité

- Ne collez jamais de clé API, token OAuth, mot de passe, clé SSH privée ou secret client dans un prompt.
- Faites les authentifications dans votre navigateur habituel, dans un flux device-code officiel, dans un CLI officiel, ou dans n8n ouvert par tunnel SSH.
- Gardez les interfaces d'administration en `127.0.0.1` tant que vous n'avez pas volontairement configuré HTTPS, domaine, reverse proxy et authentification.
- Commencez avec des données fictives. Branchez les comptes réels seulement quand le flux est compris et validé.
