# Instructions agents

Ce dépôt est un kit public pour apprenants. Il ne contient pas le programme formateur, les fiches personnelles, ni la trame interne du cours. Optimiser chaque contribution pour des personnes qui découvrent le terminal, les serveurs, n8n, Codex et les agents IA.

## Langue et ton

- Écrire les explications destinées aux apprenants en français.
- Garder les noms techniques officiels en anglais quand c'est leur nom produit : `Codex`, `Claude Code`, `n8n`, `GitHub CLI`, `systemd`.
- Privilégier des phrases courtes, des commandes copiables, et des exemples sans secrets.

## Découverte progressive

Commencer par le minimum utile, puis charger le détail seulement si nécessaire :

1. Lire ce fichier.
2. Lire `README.md` pour l'objectif général.
3. Lire le guide `docs/` le plus proche de la demande.
4. Lire le skill pertinent dans `.agents/skills/<nom>/SKILL.md`.
5. Lire seulement les références explicitement indiquées par ce skill.
6. Exécuter les scripts en mode diagnostic ou `--plan` avant tout mode `--apply`.

## Sécurité

- Ne jamais demander de coller un token, une clé API, un secret OAuth, une clé SSH privée ou un fichier d'authentification dans le chat.
- Pour les authentifications, guider l'utilisateur vers son navigateur local, un flux device-code, le CLI officiel ou l'interface n8n ouverte par tunnel SSH.
- Garder n8n, Codex app-server et les panneaux d'administration en écoute locale (`127.0.0.1`) sauf demande explicite et mise en place HTTPS/auth.
- Utiliser des données fictives ou anonymisées dans les exemples publics.
- Ne pas réintroduire les fiches apprenants ni le dossier formateur dans le dépôt public.

## Vérifications attendues

Après modification :

```bash
python3 "${HOME}/.codex/skills/.system/skill-creator/scripts/quick_validate.py" .agents/skills/installer-serveur-automatisation
python3 "${HOME}/.codex/skills/.system/skill-creator/scripts/quick_validate.py" .agents/skills/grill-me
python3 "${HOME}/.codex/skills/.system/skill-creator/scripts/quick_validate.py" .agents/skills/find-skills
```

Pour les scripts shell :

```bash
bash -n .agents/skills/installer-serveur-automatisation/scripts/diagnostic_serveur.sh
bash -n .agents/skills/installer-serveur-automatisation/scripts/installer_serveur_automatisation.sh
.agents/skills/installer-serveur-automatisation/scripts/installer_serveur_automatisation.sh --plan --target auto
```

## Publication

Avant un push public, vérifier :

```bash
git status
git diff --cached
rg -n "<motifs sensibles propres au contexte>" .
```

Relire tout résultat avant publication.
