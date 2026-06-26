# Chemins agentiques

## Codex

Surfaces utiles :

- Codex App avec hôte SSH : chemin UX le plus confortable pour travailler dans un dossier distant.
- `codex` : session interactive dans le terminal.
- `codex exec` : tâche non interactive, adaptée aux scripts et timers.
- Codex app-server : surface avancée locale, à garder sur `127.0.0.1` avec token.
- Codex GitHub Action ou SDK : pour CI/CD ou intégrations programmatiques.

Préparation SSH App :

1. Ajouter un alias dans `~/.ssh/config` sur la machine où tourne Codex App.
2. Vérifier `ssh alias`.
3. Installer et authentifier Codex sur le serveur.
4. Ajouter l'hôte dans `Settings > Connections` de Codex App.

Référence : https://developers.openai.com/codex/remote-connections

## Claude

Surfaces utiles :

- Claude Code CLI sur le serveur.
- Extensions IDE.
- Remote Control depuis `claude.ai/code` ou mobile si disponible sur le compte.
- Claude Code GitHub Actions.
- Claude Agent SDK.

Remote Control est le chemin app/web/mobile à documenter pour les utilisateurs qui ne veulent pas rester dans un terminal. Il ne remplace pas la configuration serveur : le projet, les outils, les permissions et secrets restent dans l'environnement connecté.

Référence : https://docs.anthropic.com/en/docs/claude-code/remote-control

## Orchestration

Commencer simple :

1. Script shell ou Python.
2. Commande manuelle.
3. Timer systemd ou cron.
4. n8n pour l'orchestration visuelle.
5. App-server, SDK ou GitHub Actions seulement si une application ou CI doit piloter l'agent.

## Frontières utiles

- Code : parsing, calcul, validation, appels API répétables.
- IA : synthèse, classement, extraction approximative, rédaction.
- Humain : validation finale des actions externes ou sensibles.
