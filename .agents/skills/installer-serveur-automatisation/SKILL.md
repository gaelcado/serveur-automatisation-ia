---
name: installer-serveur-automatisation
description: Diagnostiquer, installer et expliquer une machine Linux d'automatisation IA Ubuntu/Debian pour débutants. Utiliser quand le chemin serveur est choisi ou qu'une machine VPS, serveur maison ou serveur existant doit être configurée pour SSH, Git, GitHub CLI, Node/nvm, n8n, Codex CLI, Claude Code, services systemd, tunnels SSH, authentifications sûres et accès distant via app/CLI.
---

# Installer un serveur d'automatisation

Utiliser ce skill seulement après le choix d'un chemin serveur. Transformer une machine Linux en laboratoire d'automatisation accessible depuis l'ordinateur local, sans exposer n8n ni les panneaux d'administration sur Internet.

## Workflow par défaut

1. Vérifier que le chemin serveur est choisi : VPS, serveur maison ou serveur existant.
2. Identifier le niveau utilisateur : débutant, curieux technique, dev. Adapter la densité des explications.
3. Lire `USER.md` à la racine du dépôt si présent pour connaître l'état local, sans en faire la source du setup projet.
4. Si l'utilisateur veut rester en local, ou si le choix local/VPS/maison/existant est flou, revenir à `$setup-projet-automatisation`.
5. Lire `references/chemins-serveur.md` seulement si le choix VPS/serveur maison doit être expliqué.
6. Une fois dans le dépôt sur le serveur, lancer le diagnostic :

   ```bash
   .agents/skills/installer-serveur-automatisation/scripts/diagnostic_serveur.sh
   ```

7. Préparer un plan sans mutation :

   ```bash
   .agents/skills/installer-serveur-automatisation/scripts/installer_serveur_automatisation.sh --plan --target auto
   ```

8. Expliquer les actions prévues en langage simple avant tout `--apply`.
9. Installer si l'utilisateur confirme :

   ```bash
   .agents/skills/installer-serveur-automatisation/scripts/installer_serveur_automatisation.sh --apply --target auto
   ```

10. Guider les authentifications hors chat : navigateur local, device-code, CLI officiel ou n8n via tunnel SSH.
11. Relancer le diagnostic, vérifier n8n local-only, puis proposer les chemins Codex et Claude adaptés.
12. Mettre à jour `USER.md` avec les statuts serveur, sans secret, puis revenir à `$setup-projet-automatisation` pour le cleanup de fin de phase.

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

- `../../../.agents/skills/setup-projet-automatisation/SKILL.md` : setup projet si le chemin utilisateur ou le contexte local ne sont pas encore clairs.
- `../../../docs/07-cycle-de-vie-du-contexte.md` : création, mise à jour, condensation et pruning du contexte local.
- `../../../USER.example.md` : modèle de carnet local quand `USER.md` n'existe pas.
- `../../../USER.md` : carnet de bord local à lire et mettre à jour sans secrets, s'il existe.
- `../../../docs/glossaire.md` : définitions françaises pour vulgariser sans perdre la précision.
- `references/chemins-serveur.md` : choisir et expliquer VPS France, serveur maison, Hostinger, OVHcloud.
- `references/authentification.md` : SSH, GitHub, OpenAI/Codex, Claude, n8n, OAuth et secrets.
- `references/chemins-agentiques.md` : surfaces Codex et Claude, app/CLI/remote/app-server.
- `references/depannage.md` : `localhost`, tunnels, ports, systemd, firewall, DNS, OAuth callback.

## Scripts

- `scripts/diagnostic_serveur.sh` : lecture seule, rapport redacted.
- `scripts/installer_serveur_automatisation.sh` : installation idempotente Ubuntu/Debian avec `--plan`, `--apply`, `--target`, `--no-claude`, `--with-app-server`.

Toujours préférer diagnostic puis plan, puis exécution.
