# Serveur d'automatisation IA

Ce dépôt est un contexte de travail pour construire votre environnement d'automatisation avec un agent local comme Codex ou Claude.

Il sert à guider l'agent dans le bon ordre :

```text
comprendre votre besoin -> choisir local ou serveur -> établir l'accès -> installer les briques -> authentifier sans fuite -> créer une première automatisation -> faire évoluer le contexte
```

L'objectif n'est pas de tout rendre magique. L'objectif est de rendre chaque étape lisible : ce qui tourne sur votre ordinateur, ce qui tourne sur un serveur, ce qui doit rester privé, et ce que l'IA peut réellement faire à votre place.

## Comment utiliser ce dépôt

Ouvrez ce dossier avec Codex, Claude ou un autre agent de code, puis donnez-lui ce prompt de départ :

```text
Utilise ce dépôt comme contexte de travail.

Commence par comprendre mon objectif, mon niveau, et mon point de départ : local seulement, VPS, serveur maison, ou serveur déjà existant.

Guide-moi étape par étape. Dis toujours où lancer les commandes : ordinateur local ou serveur. Ne me demande jamais de coller un secret dans le chat.

Si USER.md n'existe pas, crée-le depuis USER.example.md. Mets-le ensuite à jour quand une décision durable est prise : niveau, machine choisie, accès validé, services installés, automatisations créées, limites à respecter. Nettoie aussi l'ancien contexte quand il devient faux ou inutile.
```

Si vous préparez une automatisation importante, demandez d'abord à votre agent de passer en mode planification. Vous pouvez aussi lui demander d'utiliser la skill `grill-me` pour challenger le brief avant de construire.

## Choisir son chemin

Le dépôt supporte quatre départs fréquents :

- **Local seulement** : vous voulez apprendre, prototyper ou lancer des automatisations manuelles sans serveur allumé en continu.
- **VPS** : vous louez une petite machine Linux accessible en SSH.
- **Serveur maison** : vous utilisez une machine chez vous, souvent derrière une box Internet.
- **Serveur existant** : vous avez déjà une machine Linux et vous voulez la rendre proprement utilisable.

Pour choisir, commencez par [docs/01-choisir-son-serveur.md](docs/01-choisir-son-serveur.md). Si vous ne voulez pas de serveur pour l'instant, utilisez [docs/06-chemin-local.md](docs/06-chemin-local.md).

## Parcours recommandé

1. Lire cette page.
2. Créer un carnet local depuis [USER.example.md](USER.example.md), ou laisser l'agent créer `USER.md` progressivement.
3. Suivre [docs/00-checklist-setup-agentique.md](docs/00-checklist-setup-agentique.md) si vous partez vers un serveur.
4. Utiliser [docs/06-chemin-local.md](docs/06-chemin-local.md) si vous restez en local.
5. Installer ou diagnostiquer avec la skill `installer-serveur-automatisation` quand une machine Linux est prête.
6. Créer une première automatisation minimale avec [docs/05-creer-des-automatisations.md](docs/05-creer-des-automatisations.md).
7. Nettoyer régulièrement le contexte avec [docs/07-cycle-de-vie-du-contexte.md](docs/07-cycle-de-vie-du-contexte.md).

Le vocabulaire technique est expliqué dans [docs/glossaire.md](docs/glossaire.md).

## Ce que le dépôt garde en mémoire

`USER.md` est le carnet de bord local du projet. Il est créé depuis `USER.example.md` et ignoré par git. Il peut être modifié par vous ou par l'agent pour noter :

- votre niveau et vos préférences d'explication ;
- le chemin choisi : local, VPS, serveur maison ou serveur existant ;
- les commandes validées ;
- les services installés ;
- les méthodes d'authentification choisies ;
- les automatisations en cours ;
- les règles personnelles de sécurité.

N'y mettez jamais de clé API, token, mot de passe, clé SSH privée, secret OAuth ou cookie de session.

Quand une piste devient obsolète, l'agent doit la supprimer, la condenser ou l'archiver localement au lieu de laisser plusieurs versions contradictoires dans le carnet.

## Règles de sécurité

- Les secrets se saisissent dans un navigateur habituel, un flux device-code officiel, un CLI officiel ou l'interface n8n ouverte par tunnel SSH.
- n8n reste en `127.0.0.1` par défaut. On y accède via un tunnel, pas en l'exposant publiquement pour aller plus vite.
- Les premières automatisations utilisent des données fictives ou locales.
- Toute action sensible doit prévoir une validation humaine : envoi externe, argent, suppression, données confidentielles, réputation.

## Références principales

- [Checklist setup agentique](docs/00-checklist-setup-agentique.md)
- [Choisir son serveur](docs/01-choisir-son-serveur.md)
- [Installation guidée](docs/02-installation-guidee.md)
- [Chemins Codex et Claude](docs/03-chemins-agentiques.md)
- [Secrets et authentification](docs/04-secrets-authentification.md)
- [Créer des automatisations](docs/05-creer-des-automatisations.md)
- [Chemin local sans serveur](docs/06-chemin-local.md)
- [Cycle de vie du contexte](docs/07-cycle-de-vie-du-contexte.md)
- [Glossaire](docs/glossaire.md)
