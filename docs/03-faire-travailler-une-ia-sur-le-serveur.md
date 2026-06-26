# 03 - Faire travailler une IA sur le serveur

"Spawner une IA" veut simplement dire lancer un agent ou un modèle depuis une commande, un workflow ou un service.

## Niveau 1 : commande manuelle

Vous vous connectez en SSH, puis vous lancez Codex dans le dossier du projet :

```bash
codex
```

C'est le mode le plus lisible pour apprendre.

## Niveau 2 : commande non interactive

Un script, un cron, un timer systemd ou n8n peut lancer une tâche courte :

```bash
codex exec --ask-for-approval never --sandbox workspace-write "Résume les fichiers modifiés et propose les tests."
```

Utilisez ce mode pour des tâches cadrées, pas pour donner un accès libre à tout le serveur.

## Niveau 3 : n8n appelle une brique programmée

n8n orchestre : réception d'un webhook, lecture d'un fichier, appel API, notification. Une brique programmée fait ce qui doit être reproductible : parser, valider, transformer, calculer.

Bon réflexe :

```text
n8n pour orchestrer -> script pour la logique déterministe -> IA pour lire/rédiger/classer -> humain pour valider les actions sensibles
```

## Niveau 4 : service supervisé

Pour une tâche récurrente, utilisez `systemd --user` :

- un service pour démarrer un worker ;
- un timer pour lancer une commande périodiquement ;
- des logs avec `journalctl --user`.

## Niveau 5 : surfaces avancées

Codex app-server peut servir de surface locale pour piloter Codex depuis une application. Gardez-le en `127.0.0.1`, avec token, et ouvrez-le par tunnel SSH seulement quand vous en avez besoin.

Claude Code peut être ajouté comme second agent, mais ce dépôt reste Codex-first. L'objectif pédagogique est de comprendre la logique : chaque agent est une commande, un SDK, une action GitHub, un service ou une API avec des permissions bornées.

## Question à se poser avant d'automatiser

- Est-ce que cette étape doit être déterministe ? Utilisez du code.
- Est-ce que cette étape demande lecture, synthèse, reformulation, hypothèses ? Utilisez une IA.
- Est-ce que cette étape peut avoir un impact externe, financier, juridique ou humain ? Ajoutez une validation humaine.
