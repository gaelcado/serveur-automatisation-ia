# Contexte agentique

Tu aides l'utilisateur à installer, comprendre et faire évoluer un environnement d'automatisation IA. Ce dépôt est un contexte vivant : il doit guider l'installation, puis s'adapter aux machines, services et automatisations réellement créés.

## Principe de travail

- Commence par `README.md`, puis lis `USER.md` pour connaître l'état local du projet.
- Ne charge la documentation profonde que quand elle devient utile.
- Utilise `docs/00-checklist-setup-agentique.md` comme fil rouge pour un chemin serveur.
- Utilise `docs/06-chemin-local.md` si l'utilisateur veut rester en local sans serveur ni automatisations asynchrones.
- Utilise `docs/glossaire.md` pour traduire les termes techniques au bon niveau.
- Si la tâche touche une installation serveur, lis `.agents/skills/installer-serveur-automatisation/SKILL.md`.

## UX attendue

- Identifier ou demander le niveau : débutant, curieux technique, dev.
- Toujours dire où lancer une commande : ordinateur local, serveur, ou interface web.
- Avancer par checkpoints courts : état, preuve, prochain pas, blocage éventuel.
- Avant une action mutante, expliquer ce qui va changer et attendre validation quand l'impact est réel.
- Pour une demande sérieuse ou floue, proposer un mode planification avant l'exécution.
- Pour une automatisation à enjeu, proposer la skill `grill-me` afin de challenger le brief, les risques et les validations humaines.

## Mémoire évolutive

`USER.md` est le carnet de bord. Mets-le à jour quand une information durable est établie :

- niveau et préférences d'explication ;
- chemin choisi : local, VPS, serveur maison, serveur existant ;
- commandes ou accès validés ;
- services installés ;
- méthodes d'authentification terminées ;
- automatisations créées ;
- règles personnelles de sécurité.

Ne jamais écrire dans `USER.md` de token, clé API, mot de passe, clé SSH privée, cookie, secret OAuth ou contenu de credential.

Avant tout commit, relire `USER.md` : il doit rester publiable ou être volontairement exclu du commit si l'utilisateur y a mis du contexte personnel.

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
python3 "${HOME}/.codex/skills/.system/skill-creator/scripts/quick_validate.py" .agents/skills/grill-me
python3 "${HOME}/.codex/skills/.system/skill-creator/scripts/quick_validate.py" .agents/skills/find-skills
bash -n .agents/skills/installer-serveur-automatisation/scripts/diagnostic_serveur.sh
bash -n .agents/skills/installer-serveur-automatisation/scripts/installer_serveur_automatisation.sh
.agents/skills/installer-serveur-automatisation/scripts/installer_serveur_automatisation.sh --plan --target auto
git diff -- USER.md
git status
```
