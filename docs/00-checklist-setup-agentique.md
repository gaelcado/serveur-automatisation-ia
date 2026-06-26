# 00 - Checklist setup agentique

Cette checklist est chargée par `$setup-projet-automatisation` quand le chemin serveur devient pertinent. Elle suppose que l'utilisateur a une app locale comme Codex ou Claude, mais pas forcément un serveur, SSH ou n8n.

Si l'utilisateur ne veut pas de serveur ni d'automatisation asynchrone pour l'instant, bifurquer vers `docs/06-chemin-local.md`.

## Mode d'emploi pour l'agent

- Passer par `$setup-projet-automatisation` pour créer ou nettoyer le contexte local.
- Identifier le niveau utilisateur : débutant, curieux technique, dev.
- Dire où lancer chaque commande : ordinateur local ou serveur.
- Ne jamais demander de secret dans le chat.
- Avancer par checkpoints.
- Produire après chaque phase un résumé : état, preuve, prochain pas.
- Créer `USER.md` depuis `USER.example.md` si le carnet local n'existe pas.
- Mettre à jour `USER.md` après une décision durable ou une preuve validée, sans secret.
- Nettoyer le vieux contexte avec `docs/07-cycle-de-vie-du-contexte.md` quand une hypothèse devient fausse.
- Utiliser `docs/glossaire.md` dès qu'un terme bloque.

## Phase 0 - Point de départ local

Objectif : savoir d'où part l'utilisateur.

À vérifier :

- L'utilisateur a Codex App, Claude, ou un autre agent local ouvert.
- Il sait ouvrir un terminal local, ou l'agent peut l'aider depuis l'app.
- Il a un objectif d'automatisation, même vague.
- Il connaît son niveau approximatif : débutant, curieux technique, dev.
- `USER.md` existe ou peut être créé depuis `USER.example.md`.

Questions utiles :

- Quel est le premier résultat utile que vous voulez obtenir ?
- Avez-vous déjà un serveur, une adresse IP ou un accès SSH ?
- Voulez-vous rester en local pour commencer, louer un VPS, utiliser une machine chez vous, ou partir d'un serveur existant ?

Checkpoint :

```text
Niveau:
Objectif:
Chemin: local seulement / VPS / serveur maison / serveur existant
Blocage principal: ...
```

Si `USER.md` manque :

```bash
cp USER.example.md USER.md
```

À lancer dans le dépôt où l'agent travaille.

## Phase 1 - Choisir le chemin

Objectif : choisir sans noyer l'utilisateur.

Chemins :

- **Local seulement** : recommandé si l'utilisateur veut apprendre, prototyper, manipuler des fichiers locaux ou lancer l'automatisation à la main.
- **VPS** : recommandé si l'utilisateur veut avancer vite avec une machine accessible en SSH depuis l'extérieur.
- **Serveur maison** : recommandé si l'utilisateur veut apprendre l'infrastructure personnelle ou utiliser une machine déjà disponible.
- **Serveur existant** : recommandé si l'utilisateur a déjà une machine Linux accessible.

Lire :

- `docs/06-chemin-local.md` si le chemin local suffit.
- `docs/01-choisir-son-serveur.md` si une machine distante ou maison est nécessaire.

Checkpoint :

```text
Chemin choisi: ...
Fournisseur ou machine: ...
OS prévu: Ubuntu/Debian/autre
Accès admin/sudo: oui/non/inconnu
```

Si le chemin choisi est **local seulement**, ne pas continuer vers les phases SSH/serveur. Utiliser `docs/06-chemin-local.md`, puis créer une première automatisation locale ou mock.

## Phase 2 - Créer ou identifier le serveur

Objectif : obtenir une machine Linux joignable.

Pour un VPS :

- Choisir Ubuntu LTS.
- Ajouter une clé SSH publique si le fournisseur le propose.
- Noter l'adresse IP, l'utilisateur initial, la région, la taille RAM.
- Activer snapshot/sauvegarde si disponible.

Pour un serveur maison :

- Trouver l'IP locale.
- Vérifier que SSH est installé et démarré.
- Éviter toute ouverture de port routeur au départ.
- Préférer réseau local, VPN ou tunnel sécurisé.

Checkpoint :

```text
Adresse serveur: ...
Utilisateur SSH: ...
Méthode d'accès: clé SSH / mot de passe temporaire / console fournisseur
```

## Phase 3 - Établir SSH

Objectif : obtenir une commande SSH qui fonctionne depuis l'ordinateur local.

Commandes à lancer sur l'ordinateur local :

```bash
ssh utilisateur@adresse-du-serveur
```

Option confortable : créer un alias dans `~/.ssh/config`.

```text
Host automation
  HostName adresse-du-serveur
  User utilisateur
  IdentityFile ~/.ssh/id_ed25519
```

Puis tester :

```bash
ssh automation
```

Checkpoint :

```text
SSH fonctionne: oui/non
Commande validée: ...
Alias SSH: ...
```

## Phase 4 - Installer le contexte sur le serveur

Objectif : placer ce dépôt sur le serveur.

Commandes à lancer sur le serveur :

```bash
git clone https://github.com/gaelcado/serveur-automatisation-ia.git
cd serveur-automatisation-ia
```

Si `git` manque, installer le minimum selon l'OS ou utiliser le panneau/console fournisseur pour débloquer.

Checkpoint :

```text
Dépôt présent sur le serveur: oui/non
Chemin: ...
```

## Phase 5 - Diagnostic et plan

Objectif : comprendre l'état avant modification.

Commandes à lancer sur le serveur, dans le dépôt :

```bash
.agents/skills/installer-serveur-automatisation/scripts/diagnostic_serveur.sh
.agents/skills/installer-serveur-automatisation/scripts/installer_serveur_automatisation.sh --plan --target auto
```

L'agent doit expliquer le plan avant `--apply`.

Checkpoint :

```text
Diagnostic lu: oui/non
Plan compris: oui/non
Risque ou question: ...
```

## Phase 6 - Installation des briques

Objectif : installer le socle serveur.

Briques attendues :

- Git et GitHub CLI.
- Node via nvm.
- n8n en service local.
- Codex CLI.
- Claude Code.
- systemd utilisateur.
- Pare-feu prudent.

Commande à lancer sur le serveur, seulement après validation :

```bash
.agents/skills/installer-serveur-automatisation/scripts/installer_serveur_automatisation.sh --apply --target auto
```

Checkpoint :

```text
n8n actif: oui/non
Codex CLI: oui/non
Claude Code: oui/non
GitHub CLI: oui/non
```

## Phase 7 - Authentifications

Objectif : connecter les outils sans exposer de secrets.

Commandes interactives à lancer sur le serveur :

```bash
gh auth login
codex login
claude
```

n8n se configure dans son interface, ouverte par tunnel SSH depuis l'ordinateur local.

Interdits :

- Coller une clé privée SSH dans le chat.
- Coller un token OAuth ou API dans le chat.
- Publier n8n sur Internet pour aller plus vite.

Checkpoint :

```text
GitHub auth: ok/non
Codex auth: ok/non
Claude auth: ok/non
n8n owner setup: ok/non
```

## Phase 8 - Connecter les chemins agentiques

Objectif : rendre le serveur pilotable.

Codex App :

- Ajouter le serveur dans `~/.ssh/config` sur l'ordinateur local.
- Vérifier `ssh alias`.
- Vérifier que `codex` existe sur le serveur.
- Ouvrir Codex App > Settings > Connections > SSH.
- Ajouter l'hôte, puis ouvrir le dossier du dépôt distant.

Claude :

- Vérifier Claude Code CLI sur le serveur.
- Utiliser CLI, IDE ou Remote Control selon le compte et l'environnement.
- Garder en tête que la surface web/mobile pilote une session configurée ailleurs.

Checkpoint :

```text
Chemin Codex choisi: app SSH / CLI / exec / autre
Chemin Claude choisi: Remote Control / CLI / IDE / Actions / autre
```

## Phase 9 - Ouvrir n8n localement

Objectif : accéder à n8n sans l'exposer publiquement.

Commande à lancer sur l'ordinateur local :

```bash
ssh -N -L 5678:127.0.0.1:5678 utilisateur@adresse-du-serveur
```

Puis ouvrir :

```text
http://localhost:5678
```

Checkpoint :

```text
n8n visible dans le navigateur local: oui/non
Port local utilisé: 5678 ou autre
```

## Phase 10 - Première automatisation minimale

Objectif : créer un flux utile sans connecter tout de suite les vrais comptes.

Mini brief :

```text
Objectif:
Entrée:
Transformation déterministe:
Rôle IA:
Validation humaine:
Sortie:
Fréquence:
Logs:
Secrets nécessaires:
```

Pattern recommandé :

```text
entrée fictive -> validation script -> brouillon IA -> validation humaine -> action/log
```

Checkpoint final :

```text
Serveur prêt: oui/non
n8n accessible: oui/non
Agent distant prêt: oui/non
Première automatisation mock: oui/non
Prochaine vraie intégration: ...
```

Fin de parcours :

- condenser `USER.md` autour de l'état actuel ;
- supprimer les hypothèses fausses ou chemins abandonnés ;
- archiver le détail localement seulement si utile ;
- relancer `$setup-projet-automatisation` en cleanup avant de continuer vers plusieurs automatisations.
