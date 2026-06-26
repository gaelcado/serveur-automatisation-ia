---
name: installer-serveur-automatisation
description: Diagnostiquer, installer et expliquer un serveur d'automatisation IA pour débutants, sur VPS Ubuntu ou serveur maison Linux. Utiliser quand Codex doit guider l'installation de SSH, Git, GitHub CLI, Node/nvm, n8n, Codex CLI, services systemd, tunnels SSH, authentifications sûres, ou expliquer comment lancer des agents IA côté serveur avec Codex d'abord et Claude Code en option.
---

# Installer un serveur d'automatisation

Utiliser ce skill pour transformer une machine Linux en laboratoire d'automatisation accessible depuis l'ordinateur local, sans exposer n8n ni les panneaux d'administration sur Internet.

## Workflow par défaut

1. Identifier le type de machine : VPS hébergé, serveur maison, machine fournie par l'atelier.
2. Lire `references/chemins-serveur.md` si le choix VPS/serveur maison est encore flou.
3. Lancer le diagnostic :

   ```bash
   .agents/skills/installer-serveur-automatisation/scripts/diagnostic_serveur.sh
   ```

4. Préparer un plan sans mutation :

   ```bash
   .agents/skills/installer-serveur-automatisation/scripts/installer_serveur_automatisation.sh --plan --target auto
   ```

5. Expliquer les actions prévues en langage simple avant tout `--apply`.
6. Installer si l'utilisateur confirme :

   ```bash
   .agents/skills/installer-serveur-automatisation/scripts/installer_serveur_automatisation.sh --apply --target auto
   ```

7. Guider les authentifications hors chat : navigateur local, device-code, CLI officiel ou n8n via tunnel SSH.
8. Relancer le diagnostic et donner les commandes de tunnel utiles.

## Cibles

- `--target vps` : machine louée chez OVHcloud, Hostinger ou équivalent. Le pare-feu serveur compte beaucoup ; le routeur ne vous appartient pas.
- `--target home` : serveur maison, mini-PC, NAS Linux ou vieille machine recyclée. Le routeur, le NAT, l'IP dynamique et les coupures électriques comptent beaucoup.
- `--target auto` : détecter au mieux et rester prudent.

## Règles de sécurité

- Ne jamais demander de coller une clé API, un token, une clé SSH privée, un mot de passe ou un secret OAuth dans le chat.
- Garder n8n sur `127.0.0.1:5678` par défaut et y accéder par tunnel SSH.
- Ne pas utiliser le navigateur intégré Codex pour des pages connectées ou des flows OAuth ; utiliser le navigateur local habituel ou le device-code.
- Présenter Codex app-server comme avancé et local-only. Ne l'activer que si l'utilisateur comprend le rôle du token et du tunnel.
- Installer Claude Code seulement avec `--with-claude`; Codex reste le chemin principal.
- Commencer par des données fictives et des credentials de test avant tout compte réel.

## Références à charger au besoin

- `references/chemins-serveur.md` : choisir et expliquer VPS France, serveur maison, Hostinger, OVHcloud.
- `references/authentification.md` : SSH, GitHub, OpenAI/Codex, Claude, n8n, OAuth et secrets.
- `references/spawner-ia.md` : façons de lancer Codex, Claude ou une autre IA depuis le serveur.
- `references/depannage.md` : `localhost`, tunnels, ports, systemd, firewall, DNS, OAuth callback.

## Scripts

- `scripts/diagnostic_serveur.sh` : lecture seule, rapport redacted.
- `scripts/installer_serveur_automatisation.sh` : installation idempotente Ubuntu/Debian avec `--plan`, `--apply`, `--target`, `--with-claude`, `--with-app-server`.

Toujours préférer diagnostic puis plan, puis exécution.
