# 02 - Installation guidée

Cette installation vise un serveur Ubuntu/Debian. Les scripts gardent n8n en local-only et affichent un plan avant toute modification.

## 1. Connexion

Depuis votre ordinateur :

```bash
ssh utilisateur@adresse-du-serveur
```

Si c'est votre première connexion SSH, acceptez l'empreinte seulement si elle correspond aux informations de votre hébergeur ou de votre machine.

## 2. Diagnostic

Dans le dépôt :

```bash
.agents/skills/installer-serveur-automatisation/scripts/diagnostic_serveur.sh
```

Le diagnostic vérifie notamment `git`, `gh`, `node`, `npm`, `n8n`, `codex`, `claude`, les services systemd utilisateur, le pare-feu et les ports.

## 3. Plan sans modification

```bash
.agents/skills/installer-serveur-automatisation/scripts/installer_serveur_automatisation.sh --plan --target auto
```

Pour préciser :

```bash
.agents/skills/installer-serveur-automatisation/scripts/installer_serveur_automatisation.sh --plan --target vps
.agents/skills/installer-serveur-automatisation/scripts/installer_serveur_automatisation.sh --plan --target home
```

## 4. Installation

Quand le plan est compris :

```bash
.agents/skills/installer-serveur-automatisation/scripts/installer_serveur_automatisation.sh --apply --target auto
```

Options utiles :

```bash
--with-claude
--with-app-server
```

Claude Code est optionnel. Codex app-server est avancé : il doit rester sur `127.0.0.1` et protégé par token.

## 5. Accès à n8n

Sur votre ordinateur local :

```bash
ssh -N -L 5678:127.0.0.1:5678 utilisateur@adresse-du-serveur
```

Puis ouvrez `http://localhost:5678`.

## 6. Authentifications

Ne collez pas de secrets dans le chat. Utilisez :

- `gh auth login` pour GitHub.
- `codex login` pour Codex.
- `claude` ou `claude doctor` seulement si Claude Code est installé.
- L'interface n8n ouverte par tunnel pour créer les credentials n8n.
