# 07 - Cycle de vie du contexte

Ce dépôt doit rester utile pendant plusieurs étapes : choix du chemin, installation, authentification, première automatisation, puis amélioration. Pour cela, le contexte doit évoluer sans devenir un journal confus.

En usage normal, ce cycle est piloté par `$setup-projet-automatisation`. La documentation explique le modèle mental ; la skill décide quoi lire et quels scripts lancer.

## Les trois niveaux de contexte

1. **Contexte public du dépôt** : `README.md`, `AGENTS.md`, `CLAUDE.md`, `docs/`, `.agents/skills/`.
2. **Contexte local utilisateur** : `USER.md`, ignoré par git, créé depuis `USER.example.md`.
3. **Archives locales optionnelles** : `.context-local/` ou `.sessions-local/`, ignorés par git.

Le contexte public explique la méthode. Le contexte local décrit votre situation réelle. Les archives locales gardent le détail quand il n'est plus utile dans le fil principal.

## Démarrage

Si `USER.md` n'existe pas, l'agent doit proposer :

```bash
cp USER.example.md USER.md
```

À lancer dans le dépôt, sur l'ordinateur où l'agent travaille.

Commande skill équivalente :

```bash
.agents/skills/setup-projet-automatisation/scripts/setup_contexte_projet.sh --apply
```

Ensuite, l'agent remplit seulement ce qui est connu :

```text
Niveau:
Chemin:
Objectif:
Phase actuelle:
Prochain checkpoint:
```

## Mise à jour progressive

Mettre à jour `USER.md` quand une information devient durable :

- niveau utilisateur confirmé ;
- chemin choisi : local, VPS, serveur maison, serveur existant ;
- SSH validé ;
- service installé et vérifié ;
- authentification terminée ;
- automatisation créée ;
- règle de sécurité ou d'autonomie décidée.

Ne pas mettre à jour `USER.md` pour chaque commande essayée. Garder seulement les preuves utiles.

## Entrée de phase

Avant de commencer une nouvelle phase, l'agent doit comparer `USER.md` avec le chemin actuel :

```text
Le chemin indiqué est-il encore vrai ?
Le prochain checkpoint correspond-il à la demande actuelle ?
Une ancienne machine, un ancien port ou un ancien service risque-t-il de tromper l'agent ?
Y a-t-il un choix local/VPS/serveur maison/serveur existant à reformuler ?
```

Si la réponse n'est pas claire, l'agent doit demander une confirmation courte avant de modifier la machine.

## Fin de phase

À la fin de chaque phase, l'agent doit produire puis noter un checkpoint court :

```text
État:
Preuve:
Décision durable:
Prochain pas:
À oublier:
```

Si une hypothèse devient fausse, elle doit être supprimée ou déplacée dans `Contexte à oublier ou archiver`.

## Changement de chemin

Un changement de chemin doit réécrire l'état courant, pas ajouter une couche de plus.

Exemples :

- local seulement -> VPS : garder l'automatisation prototype, ajouter le besoin serveur, supprimer les phrases qui disent "pas de serveur prévu".
- VPS -> serveur maison : garder les objectifs, remplacer les notes fournisseur par les contraintes réseau local, NAT, VPN ou tunnel.
- serveur maison -> serveur existant : garder les accès validés, supprimer les pistes routeur si elles ne s'appliquent plus.
- Codex -> Claude ou Claude -> Codex : garder le besoin, changer la surface agentique choisie, vérifier les auths nécessaires.

## Pruning

Demander à l'agent de nettoyer le contexte quand :

- `USER.md` contient plusieurs chemins contradictoires ;
- le journal de décisions dépasse ce qui est lisible en une minute ;
- une installation a remplacé une ancienne méthode ;
- une automatisation a changé de nom, de fréquence ou de compte connecté ;
- un service a été abandonné.

Prompt utile :

```text
Nettoie le contexte local. Lis USER.md, garde seulement l'état actuel, transforme l'historique utile en décisions actives, et liste ce qui doit être supprimé ou archivé. Ne supprime rien sans me montrer le résumé.
```

## Archives locales

Si le détail d'une session reste utile mais trop long pour `USER.md`, créer un fichier ignoré par git :

```text
.context-local/AAAA-MM-JJ-sujet.md
```

Ce fichier peut contenir des notes, mais toujours sans secret. Si un secret apparaît par erreur, le supprimer immédiatement et considérer qu'il doit être révoqué côté fournisseur.

## Avant publication

Avant de pousser ou partager le dépôt :

```bash
git status --short
git diff -- . ':(exclude)USER.md'
```

`USER.md`, `.context-local/` et `.sessions-local/` ne doivent pas être dans le commit.

Si l'utilisateur veut publier un retour d'expérience, créer un document anonymisé séparé, sans IP privée, adresse email personnelle, token, nom de machine sensible ou détail d'accès.

Pour revenir à l'état public du dépôt, utiliser `$reset-projet-automatisation` et choisir `keep-context` ou `wipe-all`.
