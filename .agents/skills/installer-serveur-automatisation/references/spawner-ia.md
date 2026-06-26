# Spawner une IA sur le serveur

## Surfaces Codex

- `codex` : session interactive dans le terminal.
- `codex exec` : tâche non interactive, adaptée aux scripts et timers.
- Codex app-server : surface avancée locale, à garder sur `127.0.0.1` avec token.

Exemple non interactif :

```bash
codex exec --ask-for-approval never --sandbox workspace-write "Vérifie le repo et propose les prochaines commandes de test."
```

## Orchestration

Commencer simple :

1. Script shell ou Python.
2. Commande manuelle.
3. Timer systemd ou cron.
4. n8n pour l'orchestration visuelle.
5. App-server ou SDK seulement si une application doit piloter l'agent.

## Claude optionnel

Claude Code peut être installé comme second agent CLI. Le raisonnement pédagogique reste identique : l'agent doit avoir un dossier de travail, des permissions, un objectif borné, des logs et une stratégie de secrets.

## Frontières utiles

- Code : parsing, calcul, validation, appels API répétables.
- IA : synthèse, classement, extraction approximative, rédaction.
- Humain : validation finale des actions externes ou sensibles.
