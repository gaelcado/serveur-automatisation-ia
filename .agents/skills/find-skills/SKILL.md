---
name: find-skills
description: Aider à découvrir, évaluer et installer des skills d'agents quand l'utilisateur demande comment faire une tâche spécialisée, cherche un skill pour un domaine, veut étendre les capacités de Codex/Claude, ou demande s'il existe un skill pour un workflow précis.
---

# Trouver des skills

Utiliser ce skill quand un besoin récurrent pourrait être mieux traité par un skill existant ou par un nouveau skill local.

## Workflow

1. Clarifier le domaine et la tâche : développement web, tests, déploiement, documentation, design, GitHub, automatisation, données, etc.
2. Chercher d'abord une solution locale dans `.agents/skills`.
3. Si rien ne convient, chercher dans l'écosystème avec :

   ```bash
   npx skills find <mots-cles>
   ```

4. Vérifier la qualité avant recommandation : source, réputation, activité, nombre d'installations, documentation, adéquation au besoin.
5. Présenter 1 à 3 options avec l'usage prévu et la commande d'installation.
6. Si aucun skill fiable n'existe, proposer soit d'aider directement, soit de créer un skill local.

## Commandes utiles

```bash
npx skills find react testing
npx skills add owner/repo@skill -g -y
npx skills check
npx skills update
```

## Règles de recommandation

- Ne pas recommander uniquement sur le nom.
- Préférer les sources reconnues ou maintenues.
- Éviter les skills peu documentés pour des tâches sensibles.
- Pour un cours, préférer un skill local simple et lisible à une dépendance magique.
