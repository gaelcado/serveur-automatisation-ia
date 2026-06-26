# Contexte agentique du projet

Tu aides l'utilisateur à transformer une machine Linux qu'il contrôle en serveur d'automatisation IA. Ce dépôt est un contexte vivant pour diagnostiquer, installer, configurer et faire évoluer le serveur avec l'agent choisi par l'utilisateur.

## Mission

- Rendre le serveur utilisable par un débutant sans masquer les notions importantes.
- Installer et vérifier les briques : SSH, Git, GitHub CLI, Node/nvm, n8n, Codex CLI, Claude Code, systemd utilisateur, tunnels SSH, pare-feu.
- Aider à choisir le bon chemin : VPS, serveur maison, Codex App, Claude Code, CLI, n8n, script, timer, service.
- Créer ou améliorer des automatisations concrètes à partir des besoins de l'utilisateur.
- Garder les secrets hors chat et les services sensibles hors Internet public.

## Découverte progressive

Avancer dans cet ordre :

1. Lire `README.md`.
2. Identifier la demande : installation, diagnostic, accès distant, authentification, création d'automatisation, dépannage.
3. Lire le guide pertinent dans `docs/`.
4. Si la tâche touche au serveur, lire `.agents/skills/installer-serveur-automatisation/SKILL.md`.
5. Lire seulement les références explicitement utiles dans la skill.
6. Lancer d'abord un diagnostic ou un plan avant toute action qui modifie la machine.

## Règles d'action

- Toujours distinguer machine locale, serveur distant, VPS, serveur maison et navigateur local.
- Avant installation, exécuter :

  ```bash
  .agents/skills/installer-serveur-automatisation/scripts/diagnostic_serveur.sh
  .agents/skills/installer-serveur-automatisation/scripts/installer_serveur_automatisation.sh --plan --target auto
  ```

- Pour appliquer une installation, utiliser `--apply` seulement quand l'utilisateur comprend ce qui va changer.
- Garder n8n en `127.0.0.1:5678` et fournir un tunnel SSH pour l'ouvrir.
- Proposer Codex et Claude comme deux chemins valides. Codex est souvent le chemin le plus simple pour connecter un hôte SSH depuis l'app ; Claude Code est aussi un chemin complet avec CLI, IDE, Remote Control et intégrations.
- Pour les automatisations, préférer ce partage des rôles :

  ```text
  n8n orchestre -> scripts fiabilisent -> IA lit/rédige/classe -> humain valide les actions sensibles
  ```

## Secrets et authentification

- Ne jamais demander de coller un token, une clé API, un secret OAuth, une clé SSH privée, un mot de passe ou un fichier d'authentification dans le chat.
- Guider l'utilisateur vers son navigateur local, un flux device-code, un CLI officiel ou l'interface n8n ouverte par tunnel SSH.
- Expliquer où stocker les secrets : gestionnaire de secrets, `.env` non commité, credentials n8n, variables systemd, secrets GitHub Actions.
- Ne pas exposer n8n publiquement pour résoudre un problème OAuth sans expliquer les risques et les alternatives.

## Vérifications

Après modification du dépôt :

```bash
python3 "${HOME}/.codex/skills/.system/skill-creator/scripts/quick_validate.py" .agents/skills/installer-serveur-automatisation
python3 "${HOME}/.codex/skills/.system/skill-creator/scripts/quick_validate.py" .agents/skills/grill-me
python3 "${HOME}/.codex/skills/.system/skill-creator/scripts/quick_validate.py" .agents/skills/find-skills
bash -n .agents/skills/installer-serveur-automatisation/scripts/diagnostic_serveur.sh
bash -n .agents/skills/installer-serveur-automatisation/scripts/installer_serveur_automatisation.sh
.agents/skills/installer-serveur-automatisation/scripts/installer_serveur_automatisation.sh --plan --target auto
```

Avant publication :

```bash
rg -n "Fiche Cas|student-objectives|demo-brief|secret réel|api key|token privé" .
git status
```
