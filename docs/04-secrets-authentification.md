# 04 - Secrets et authentification

Une automatisation utile finit presque toujours par se connecter à des services. Le danger est de mettre les secrets au mauvais endroit.

## Ne jamais mettre dans un prompt

- Clé API.
- Token OAuth.
- Mot de passe.
- Clé SSH privée.
- Secret client OAuth.
- Fichier de session ou cookie.

## Bons chemins

- Navigateur local habituel pour les comptes web.
- Device-code officiel quand un CLI l'affiche.
- CLI officiel : `gh auth login`, `codex login`, `claude`.
- Interface n8n ouverte par tunnel SSH.
- Fichier `.env` local non commité, avec permissions limitées.
- Secrets GitHub Actions pour les workflows GitHub.
- Variables ou fichiers d'environnement systemd quand un service serveur en a besoin.

## Navigateurs

Le navigateur intégré Codex sert à prévisualiser et tester des pages sans connexion sensible. Pour les pages connectées, OAuth, comptes Google/Microsoft ou sessions personnelles, utilisez votre navigateur local habituel, une extension officielle ou le flux device-code du CLI.

## n8n et OAuth

Gardez n8n en local-only pour apprendre. Pour certains connecteurs OAuth, le service externe doit rappeler une URL publique. Dans ce cas, trois options existent :

- Mode mock ou API-token pendant la construction.
- Tunnel temporaire pour un test court et maîtrisé.
- Vrai domaine HTTPS avec reverse proxy et authentification.

Ne publiez pas n8n sur Internet "juste pour tester".

## GitHub

```bash
gh auth login
gh auth status
```

Si le flux ouvre un navigateur, utilisez votre navigateur local. Si le CLI donne un code, copiez uniquement le code public de validation, pas un token privé.

## Codex

```bash
codex login
codex doctor --summary
```

Le chemin app distant demande aussi que `codex` soit disponible sur le `PATH` du serveur distant.

## Claude

```bash
claude
claude doctor
```

Si vous utilisez Remote Control, gardez en tête que la surface web/mobile pilote une session configurée ailleurs. Les fichiers, credentials et outils viennent de l'environnement Claude Code connecté.
