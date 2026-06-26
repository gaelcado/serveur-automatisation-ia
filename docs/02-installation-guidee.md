# 02 - Installation guidée

Cette installation vise un serveur Ubuntu/Debian que vous contrôlez. Les scripts gardent n8n en local-only et affichent un plan avant toute modification.

Le mode recommandé est agent-led : l'agent lit la checklist, vous indique où lancer chaque commande, puis résume les preuves avant de continuer.

Avant de commencer, créer le carnet local si besoin :

```bash
cp USER.example.md USER.md
```

À lancer dans le dépôt où l'agent travaille. `USER.md` est ignoré par git et doit rester sans secret.

## 1. Connexion

À lancer sur votre ordinateur local :

```bash
ssh utilisateur@adresse-du-serveur
```

Si c'est votre première connexion SSH, acceptez l'empreinte seulement si elle correspond aux informations de votre hébergeur ou de votre machine.

Checkpoint :

```text
Je peux ouvrir une session SSH: oui/non
Commande SSH validée: ...
```

## 2. Diagnostic

À lancer sur le serveur, dans le dépôt :

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

Avant de passer à `--apply`, l'agent doit expliquer :

- les paquets qui seront installés ;
- les services qui seront créés ;
- ce qui restera local-only ;
- ce qui demandera une authentification manuelle.

## 4. Installation

Quand le plan est compris :

```bash
.agents/skills/installer-serveur-automatisation/scripts/installer_serveur_automatisation.sh --apply --target auto
```

Par défaut, le chemin complet installe Codex CLI et Claude Code. Pour ne pas installer Claude Code :

```bash
.agents/skills/installer-serveur-automatisation/scripts/installer_serveur_automatisation.sh --apply --target auto --no-claude
```

Codex app-server est une brique avancée. Activez-la seulement si vous voulez construire ou connecter un client qui pilote Codex :

```bash
.agents/skills/installer-serveur-automatisation/scripts/installer_serveur_automatisation.sh --apply --target auto --with-app-server
```

Checkpoint :

```text
Installation terminée: oui/non
n8n service: actif/inactif
Codex CLI: présent/absent
Claude Code: présent/absent
```

## 5. Accès à n8n

À lancer sur votre ordinateur local :

```bash
ssh -N -L 5678:127.0.0.1:5678 utilisateur@adresse-du-serveur
```

Puis ouvrez `http://localhost:5678`.

## 6. Authentifications

Ne collez pas de secrets dans le chat. Utilisez :

- `gh auth login` pour GitHub.
- `codex login` pour Codex.
- `claude` ou `claude doctor` pour Claude Code.
- L'interface n8n ouverte par tunnel pour créer les credentials n8n.

Checkpoint final :

```text
GitHub: connecté/non
Codex: connecté/non
Claude: connecté/non
n8n: accessible/non
```
