# Contexte agentique

Tu aides l'utilisateur à installer, comprendre et faire évoluer un environnement d'automatisation IA. Ce dépôt est un contexte vivant : il doit guider l'installation, puis s'adapter aux machines, services et automatisations réellement créés.

## Principe de travail

- Commence par `README.md`.
- Pour tout démarrage, reprise de setup, choix de chemin ou cleanup de contexte, utilise `.agents/skills/setup-projet-automatisation/SKILL.md`.
- Si `USER.md` existe, lis-le pour connaître l'état local du projet.
- Si `USER.md` n'existe pas, lis `USER.example.md` et propose de créer `USER.md` avant de personnaliser le parcours.
- Ne charge la documentation profonde que quand elle devient utile.
- Utilise `docs/00-checklist-setup-agentique.md` comme fil rouge pour un chemin serveur.
- Utilise `docs/06-chemin-local.md` si l'utilisateur veut rester en local sans serveur ni automatisations asynchrones.
- Utilise `docs/07-cycle-de-vie-du-contexte.md` quand le contexte local doit être créé, condensé, nettoyé ou archivé.
- Utilise `docs/glossaire.md` pour traduire les termes techniques au bon niveau.
- Si la tâche touche une installation serveur, lis `.agents/skills/installer-serveur-automatisation/SKILL.md`.
- Si l'utilisateur veut repartir d'un état propre, revenir à l'upstream ou effacer le contexte local, lis `.agents/skills/reset-projet-automatisation/SKILL.md`.

## UX attendue

- Identifier ou demander le niveau : débutant, curieux technique, dev.
- Toujours dire où lancer une commande : ordinateur local, serveur, ou interface web.
- Avancer par checkpoints courts : état, preuve, prochain pas, blocage éventuel.
- Avant une action mutante, expliquer ce qui va changer et attendre validation quand l'impact est réel.
- Pour une demande sérieuse ou floue, proposer un mode planification avant l'exécution.
- Pour une automatisation à enjeu, proposer la skill `grill-me` afin de challenger le brief, les risques et les validations humaines.

## Mémoire évolutive

`USER.md` est le carnet de bord local et ignoré par git. S'il manque, proposer :

```bash
cp USER.example.md USER.md
```

Mets-le à jour quand une information durable est établie :

- niveau et préférences d'explication ;
- chemin choisi : local, VPS, serveur maison, serveur existant ;
- commandes ou accès validés ;
- services installés ;
- méthodes d'authentification terminées ;
- automatisations créées ;
- règles personnelles de sécurité.

Ne jamais écrire dans `USER.md` de token, clé API, mot de passe, clé SSH privée, cookie, secret OAuth ou contenu de credential.

À la fin d'une phase, condenser `USER.md` autour de l'état actuel : état, preuve, décision durable, prochain pas, ancien contexte à oublier. Supprimer ou archiver localement les pistes qui ne sont plus vraies.

Avant tout commit, vérifier que `USER.md`, `.context-local/` et `.sessions-local/` ne sont pas suivis par git.

## Sécurité

- Ne jamais demander de secret dans le chat.
- Guider les authentifications vers navigateur local, device-code, CLI officiel, gestionnaire de secrets ou interface n8n ouverte par tunnel SSH.
- Garder n8n et les interfaces d'administration en `127.0.0.1` tant qu'un vrai HTTPS, domaine, reverse proxy et contrôle d'accès ne sont pas explicitement choisis.
- Commencer par des données fictives ou locales avant de connecter des comptes réels.
- Prévoir validation humaine pour envoi externe, argent, suppression, données confidentielles, santé/sécurité ou réputation.

## Installation serveur

Si le dépôt est présent sur une machine Linux à configurer, commencer par :

```bash
.agents/skills/installer-serveur-automatisation/scripts/diagnostic_serveur.sh
.agents/skills/installer-serveur-automatisation/scripts/installer_serveur_automatisation.sh --plan --target auto
```

N'utiliser `--apply` qu'après avoir expliqué le plan à l'utilisateur.

## Reset projet

Pour revenir à l'upstream, ne pas improviser de commandes destructrices. Utiliser :

```bash
.agents/skills/reset-projet-automatisation/scripts/reset_projet_automatisation.sh --plan --mode keep-context
```

Puis choisir explicitement `keep-context` ou `wipe-all` avec l'utilisateur.

## Automatisations

Avant de construire, extraire un mini brief :

```text
Objectif:
Entrée:
Transformation déterministe:
Rôle IA:
Sortie:
Validation humaine:
Fréquence:
Secrets nécessaires:
Logs:
```

Pattern par défaut :

```text
données fictives/locales -> script fiable -> IA pour langage ou décision souple -> validation humaine -> action ou journal
```

## Vérifications avant publication

```bash
python3 "${HOME}/.codex/skills/.system/skill-creator/scripts/quick_validate.py" .agents/skills/installer-serveur-automatisation
python3 "${HOME}/.codex/skills/.system/skill-creator/scripts/quick_validate.py" .agents/skills/setup-projet-automatisation
python3 "${HOME}/.codex/skills/.system/skill-creator/scripts/quick_validate.py" .agents/skills/reset-projet-automatisation
python3 "${HOME}/.codex/skills/.system/skill-creator/scripts/quick_validate.py" .agents/skills/grill-me
python3 "${HOME}/.codex/skills/.system/skill-creator/scripts/quick_validate.py" .agents/skills/find-skills
bash -n .agents/skills/installer-serveur-automatisation/scripts/diagnostic_serveur.sh
bash -n .agents/skills/installer-serveur-automatisation/scripts/installer_serveur_automatisation.sh
bash -n .agents/skills/setup-projet-automatisation/scripts/setup_contexte_projet.sh
bash -n .agents/skills/reset-projet-automatisation/scripts/reset_projet_automatisation.sh
.agents/skills/installer-serveur-automatisation/scripts/installer_serveur_automatisation.sh --plan --target auto
.agents/skills/setup-projet-automatisation/scripts/setup_contexte_projet.sh --plan
.agents/skills/reset-projet-automatisation/scripts/reset_projet_automatisation.sh --plan --mode keep-context
git status --short
```
