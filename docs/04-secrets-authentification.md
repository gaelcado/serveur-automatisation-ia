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
- CLI officiel : `gh auth login`, `codex login`.
- Interface n8n ouverte par tunnel SSH.
- Fichier `.env` local non commité, avec permissions limitées.

## n8n et OAuth

Gardez n8n en local-only pour apprendre. Pour certains connecteurs OAuth, le service externe doit rappeler une URL publique. Dans ce cas, trois options existent :

- Mode mock ou API-token pendant l'atelier.
- Tunnel temporaire pour une démonstration courte.
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

Le navigateur intégré Codex n'est pas le bon endroit pour gérer des pages connectées ou des flows OAuth sensibles. Utilisez le navigateur local ou le flux CLI prévu.

## Claude optionnel

Installez Claude Code seulement si vous voulez comparer les surfaces :

```bash
claude
claude doctor
```

Gardez la même règle : pas de secrets dans le chat.
