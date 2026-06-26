---
name: installer-serveur-automatisation
description: Diagnostiquer, installer et expliquer un serveur d'automatisation IA pour débutants, sur VPS Ubuntu/Debian ou serveur maison Linux. Utiliser quand Codex doit guider un utilisateur sans serveur prêt, sans bridge SSH, ou avec une machine à configurer pour SSH, Git, GitHub CLI, Node/nvm, n8n, Codex CLI, Claude Code, services systemd, tunnels SSH, authentifications sûres, accès distant via app/CLI, ou création d'automatisations agentiques avec n8n, scripts et validations humaines.
---

# Installer un serveur d'automatisation

Utiliser ce skill pour transformer une machine Linux contrôlée par l'utilisateur en laboratoire d'automatisation accessible depuis son ordinateur local, sans exposer n8n ni les panneaux d'administration sur Internet.

## Workflow par défaut

1. Identifier le contexte : pas de serveur, VPS à créer, serveur maison, serveur existant, SSH cassé, OS, droits sudo.
2. Identifier le niveau utilisateur : débutant, curieux technique, dev. Adapter la densité des explications.
3. Si l'utilisateur n'a pas encore de serveur ou de bridge SSH fiable, lire `docs/00-checklist-setup-agentique.md` à la racine du dépôt et suivre ses phases.
4. Lire `references/chemins-serveur.md` si le choix VPS/serveur maison est encore flou.
5. Une fois dans le dépôt sur le serveur, lancer le diagnostic :

   ```bash
   .agents/skills/installer-serveur-automatisation/scripts/diagnostic_serveur.sh
   ```

6. Préparer un plan sans mutation :

   ```bash
   .agents/skills/installer-serveur-automatisation/scripts/installer_serveur_automatisation.sh --plan --target auto
   ```

7. Expliquer les actions prévues en langage simple avant tout `--apply`.
8. Installer si l'utilisateur confirme :

   ```bash
   .agents/skills/installer-serveur-automatisation/scripts/installer_serveur_automatisation.sh --apply --target auto
   ```

9. Guider les authentifications hors chat : navigateur local, device-code, CLI officiel ou n8n via tunnel SSH.
10. Relancer le diagnostic, vérifier n8n local-only, puis proposer les chemins Codex et Claude adaptés.

Après chaque grande étape, rendre un résumé :

```text
État:
Preuve:
Prochain pas:
Blocage éventuel:
```

## Cibles

- `--target vps` : machine louée chez OVHcloud, Hostinger ou équivalent. Le pare-feu serveur compte beaucoup ; le routeur ne vous appartient pas.
- `--target home` : serveur maison, mini-PC, NAS Linux ou vieille machine recyclée. Le routeur, le NAT, l'IP dynamique et les coupures électriques comptent beaucoup.
- `--target auto` : détecter au mieux et rester prudent.

## Chemins agentiques

- Codex : CLI, Codex App avec connexion SSH, `codex exec`, app-server avancé.
- Claude : Claude Code CLI, IDE, Remote Control web/mobile, SDK et GitHub Actions.
- n8n : orchestrer les services ; ne pas lui faire porter seul la logique critique.
- Scripts : valider, transformer, calculer, journaliser.

Ne traiter ni Codex ni Claude comme simple bonus. Choisir le chemin selon la machine, le confort UX, les droits, les besoins de supervision et les services à connecter.

## Règles de sécurité

- Ne jamais demander de coller une clé API, un token, une clé SSH privée, un mot de passe ou un secret OAuth dans le chat.
- Garder n8n sur `127.0.0.1:5678` par défaut et y accéder par tunnel SSH.
- Ne pas utiliser le navigateur intégré Codex pour des pages connectées ou des flows OAuth ; utiliser le navigateur local habituel ou le device-code.
- Présenter Codex app-server comme avancé et local-only. Ne l'activer que si l'utilisateur comprend le rôle du token et du tunnel.
- Installer Claude Code par défaut dans le chemin complet ; utiliser `--no-claude` seulement si l'utilisateur veut l'exclure.
- Commencer par des données fictives et des credentials de test avant tout compte réel.

## Courbe d'explication

- Débutant : une commande à la fois, dire local ou serveur, définir les mots avec `docs/glossaire.md`.
- Curieux technique : expliquer le pourquoi et le modèle mental.
- Dev : donner commandes groupées, préconditions et vérifications.

## Références à charger au besoin

- `../../../docs/00-checklist-setup-agentique.md` : parcours complet quand il manque le serveur ou le bridge.
- `../../../docs/glossaire.md` : définitions françaises pour vulgariser sans perdre la précision.
- `references/chemins-serveur.md` : choisir et expliquer VPS France, serveur maison, Hostinger, OVHcloud.
- `references/authentification.md` : SSH, GitHub, OpenAI/Codex, Claude, n8n, OAuth et secrets.
- `references/chemins-agentiques.md` : surfaces Codex et Claude, app/CLI/remote/app-server.
- `references/depannage.md` : `localhost`, tunnels, ports, systemd, firewall, DNS, OAuth callback.

## Scripts

- `scripts/diagnostic_serveur.sh` : lecture seule, rapport redacted.
- `scripts/installer_serveur_automatisation.sh` : installation idempotente Ubuntu/Debian avec `--plan`, `--apply`, `--target`, `--no-claude`, `--with-app-server`.

Toujours préférer diagnostic puis plan, puis exécution.
