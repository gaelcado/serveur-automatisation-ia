# 03 - Chemins agentiques

Un serveur d'automatisation peut être piloté par plusieurs surfaces. Ce dépôt considère Codex et Claude comme deux chemins de premier rang.

## Chemin Codex

Codex offre un chemin confortable pour travailler sur une machine distante depuis l'application :

1. Ajouter l'hôte dans `~/.ssh/config` sur la machine où tourne Codex App.
2. Vérifier que `ssh alias-du-serveur` fonctionne.
3. Installer et authentifier `codex` sur le serveur.
4. Dans Codex App, ouvrir `Settings > Connections`, ajouter l'hôte SSH, puis choisir le dossier de projet distant.

Codex App peut alors lancer des threads sur le système de fichiers et le shell du serveur distant. Le serveur fournit les fichiers, commandes, credentials, plugins, MCP, skills et outils disponibles.

Référence : https://developers.openai.com/codex/remote-connections

Checklist Codex :

```text
Alias SSH local: ...
ssh alias fonctionne: oui/non
codex sur le serveur: oui/non
codex login fait: oui/non
projet distant ouvert dans Codex App: oui/non
```

## Chemin Claude

Claude Code est aussi un chemin complet. Il peut être utilisé :

- en CLI sur le serveur ;
- dans VS Code / JetBrains ;
- via GitHub Actions ;
- via SDK ;
- avec Remote Control depuis `claude.ai/code` ou les apps mobiles Claude, quand votre compte et votre version le permettent.

Remote Control permet de suivre et piloter des sessions Claude Code depuis le web ou mobile, sans rester collé au terminal. Le serveur doit quand même être correctement configuré : projet, permissions, auth, outils, logs et secrets.

Référence : https://docs.anthropic.com/en/docs/claude-code/remote-control

Claude Code lit aussi des skills de projet dans `.claude/skills/<nom>/SKILL.md`. Dans ce dépôt, `.claude/skills` est un lien vers `.agents/skills` pour garder une seule source de vérité.

Référence skills : https://docs.anthropic.com/en/docs/claude-code/skills

Checklist Claude :

```text
claude sur le serveur: oui/non
auth Claude faite: oui/non
surface choisie: CLI / IDE / Remote Control / Actions
projet ouvert: oui/non
```

## CLI, app ou orchestration ?

Choisissez selon le besoin :

- App Codex ou Claude Remote Control : bon chemin pour guider, suivre, approuver, reprendre.
- CLI interactive : bon chemin pour apprendre et corriger en direct.
- `codex exec` ou commandes Claude non interactives : bon chemin pour scripts, rapports, jobs cadrés.
- n8n : bon chemin pour orchestrer plusieurs services et déclencher les bonnes briques.
- systemd timer ou cron : bon chemin pour répéter une tâche serveur simple.

## Rôle de l'IA

"Spawner une IA" veut dire lancer un agent ou un modèle depuis une commande, une app, un workflow, un SDK ou un service.

Bon partage :

```text
n8n orchestre -> script vérifie/transforme -> IA lit/rédige/classe -> humain valide
```

Utilisez du code quand la répétabilité compte. Utilisez l'IA quand il faut comprendre du langage, synthétiser ou produire un brouillon. Gardez une validation humaine pour argent, envoi externe, santé/sécurité, données confidentielles ou réputation.

Si vous hésitez, demandez à l'agent de choisir la plus petite surface suffisante. Exemple : CLI interactive pour comprendre, n8n pour orchestrer, app distante pour suivre dans le confort.
