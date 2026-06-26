# 05 - Créer des automatisations

Une fois le serveur prêt, utilisez ce dépôt comme contexte pour demander à votre agent de construire des automatisations.

## Demande minimale utile

Donnez à l'agent :

- le résultat attendu ;
- les sources de données ;
- les actions autorisées ;
- les actions interdites ;
- les secrets déjà configurés, sans les révéler ;
- la fréquence souhaitée ;
- la validation humaine nécessaire.

Exemple :

```text
Utilise ce dépôt comme contexte. Je veux une automatisation n8n qui lit un fichier CSV local, détecte les lignes incomplètes avec un script Python, puis prépare un brouillon de message. Aucun envoi externe sans validation humaine.
```

## Pattern recommandé

```text
Entrée -> validation -> transformation -> brouillon IA -> revue humaine -> action -> log
```

## Où mettre quoi

- n8n : déclencheurs, orchestration, credentials, appels entre services.
- Scripts : parsing, schéma, validation, calcul, déduplication, logs.
- Codex ou Claude : génération de script, explication, rédaction, classification, amélioration du workflow.
- Git : versionner le contexte, les scripts, les exports de workflows et les docs.
- systemd : faire tourner les services et jobs récurrents côté serveur.

## Prompts utiles

```text
Lis AGENTS.md puis aide-moi à créer une automatisation. Commence par me poser les questions nécessaires sur l'entrée, la sortie, les secrets et les validations humaines.
```

```text
Diagnostique ce serveur avec la skill installer-serveur-automatisation, puis propose le plus petit plan pour rendre n8n accessible par tunnel SSH.
```

```text
Transforme cette idée en workflow n8n + script déterministe. Ne crée pas de credentials réels et ne demande aucun secret dans le chat.
```
