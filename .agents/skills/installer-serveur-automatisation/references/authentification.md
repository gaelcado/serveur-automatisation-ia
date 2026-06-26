# Authentification

## Politique

Ne jamais faire passer de secrets par le chat. Le rôle de Codex est de diagnostiquer, imprimer des commandes, expliquer les écrans attendus, vérifier l'état final et redacter les rapports.

## SSH

Préférer une clé SSH publique ajoutée dans le panneau fournisseur ou dans `~/.ssh/authorized_keys`.

Commandes locales utiles :

```bash
ssh-keygen -t ed25519 -C "atelier-automation"
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

Faire l'authentification via le flux officiel CLI ou navigateur local. Le navigateur intégré Codex ne doit pas servir de navigateur connecté principal.

## n8n

Ouvrir n8n via tunnel :

```bash
ssh -N -L 5678:127.0.0.1:5678 utilisateur@adresse-du-serveur
```

Créer les credentials dans l'interface n8n. Pour OAuth, préférer mock/API-token au début. Une URL de callback publique demande HTTPS et domaine ou tunnel temporaire.

## Claude optionnel

Installer seulement si besoin :

```bash
npm install -g @anthropic-ai/claude-code
claude
```

Conserver Claude comme surface optionnelle ; ne pas mélanger les credentials Codex et Claude.
