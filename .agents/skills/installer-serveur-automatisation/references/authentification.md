# Authentification

## Politique

Ne jamais faire passer de secrets par le chat. Le rôle de l'agent est de diagnostiquer, imprimer des commandes, expliquer les écrans attendus, vérifier l'état final et redacter les rapports.

## SSH

Préférer une clé SSH publique ajoutée dans le panneau fournisseur ou dans `~/.ssh/authorized_keys`.

Commandes locales utiles :

```bash
ssh-keygen -t ed25519 -C "serveur-automation"
ssh-copy-id utilisateur@adresse-du-serveur
ssh utilisateur@adresse-du-serveur
```

Ne jamais copier `id_ed25519` dans un prompt. La clé publique `id_ed25519.pub` peut être partagée.

## GitHub

```bash
gh auth login
gh auth status
git config --global user.name "Votre Nom"
git config --global user.email "vous@example.com"
```

Le device-code affiché par `gh` est acceptable ; un token privé ne l'est pas.

## Codex / OpenAI

```bash
codex login
codex doctor --summary
```

Pour le chemin Codex App + SSH, `codex` doit être installé et disponible sur le `PATH` du serveur distant.

## Claude / Anthropic

```bash
claude
claude doctor
```

Claude Code est un chemin complet. Selon la surface utilisée, l'auth peut passer par CLI, IDE, web/mobile Remote Control ou GitHub Actions. Ne pas demander de token Anthropic dans le chat.

## n8n

Ouvrir n8n via tunnel :

```bash
ssh -N -L 5678:127.0.0.1:5678 utilisateur@adresse-du-serveur
```

Créer les credentials dans l'interface n8n. Pour OAuth, préférer mock/API-token au début. Une URL de callback publique demande HTTPS et domaine ou tunnel temporaire.
