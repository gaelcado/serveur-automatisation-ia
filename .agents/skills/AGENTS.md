# Instructions pour les skills du projet

Les skills de ce dossier sont embarqués dans un dépôt public pour utilisateurs.

## Format

- Garder un `SKILL.md` concis avec frontmatter `name` et `description`.
- Garder les détails longs dans `references/`.
- Garder le code déterministe dans `scripts/`.
- Mettre à jour `agents/openai.yaml` quand le rôle du skill change.
- Nommer les nouvelles skills en minuscules avec tirets, même si les contenus sont en français.
- Garder `.agents/skills` comme source de vérité. `.claude/skills` doit rester un lien vers ce dossier pour Claude Code.

## Découverte progressive

Chaque skill doit :

1. Expliquer le premier diagnostic ou la première commande sûre.
2. Indiquer quelles références lire selon le besoin.
3. Éviter de charger tous les détails d'un coup.
4. Distinguer clairement diagnostic, plan et exécution.
5. Adapter les explications aux niveaux débutant, curieux technique et dev quand la skill guide un humain.

## Langue

Écrire les instructions utilisateur en français. Conserver les noms de commandes et de produits en anglais lorsqu'ils sont officiels. Dire explicitement si une commande se lance sur l'ordinateur local ou sur le serveur.
