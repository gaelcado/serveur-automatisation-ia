---
name: reset-projet-automatisation
description: "Réinitialiser ce dépôt vers son upstream avec garde-fous. Utiliser quand l'utilisateur veut repartir d'un état propre, annuler des essais locaux, synchroniser avec origin/main, nettoyer les fichiers générés, ou choisir entre deux chemins de reset : conserver la configuration locale USER.md/.context-local/.sessions-local/.env ignorée par git, ou tout effacer et revenir à un dépôt sans contexte local."
---

# Reset projet automatisation

Skill pour opérations dangereuses. Toujours commencer par un plan, puis demander une validation explicite avant toute action destructive.

## Workflow

1. Lire `USER.md` s'il existe pour comprendre ce qui risque d'être perdu.
2. Demander le chemin voulu :
   - **keep-context** : revenir à l'upstream en gardant `USER.md`, `.context-local/`, `.sessions-local/`, `.env*` et les fichiers ignorés.
   - **wipe-all** : revenir à l'upstream puis supprimer le contexte local et les fichiers ignorés courants du dépôt.
3. Lancer un plan :

   ```bash
   .agents/skills/reset-projet-automatisation/scripts/reset_projet_automatisation.sh --plan --mode keep-context
   ```

   ou :

   ```bash
   .agents/skills/reset-projet-automatisation/scripts/reset_projet_automatisation.sh --plan --mode wipe-all
   ```

4. Expliquer ce qui sera conservé, supprimé, ou récupérable seulement via git.
5. N'exécuter qu'après accord clair :

   ```bash
   .agents/skills/reset-projet-automatisation/scripts/reset_projet_automatisation.sh --apply --mode keep-context --yes
   ```

   ou :

   ```bash
   .agents/skills/reset-projet-automatisation/scripts/reset_projet_automatisation.sh --apply --mode wipe-all --yes
   ```

6. Après reset, utiliser `$setup-projet-automatisation` pour reconstruire le contexte si nécessaire.

## Garde-fous

- Ne jamais lancer `--apply` sans confirmation utilisateur.
- Ne jamais masquer le mode choisi.
- Ne jamais promettre que les fichiers non commités seront récupérables après reset.
- Ne jamais supprimer des fichiers hors du dépôt.
- Si le dépôt n'a pas de remote `origin`, arrêter et expliquer.
- Si l'utilisateur veut garder son contexte, choisir `keep-context`.
- Si l'utilisateur veut un clone comme neuf, choisir `wipe-all`.

## Résumé attendu

Après chaque plan ou reset, produire :

```text
Mode:
Upstream:
Sera conservé:
Sera supprimé:
Risque:
Prochain pas:
```
