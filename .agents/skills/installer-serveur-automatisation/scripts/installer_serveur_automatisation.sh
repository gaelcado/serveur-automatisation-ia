#!/usr/bin/env bash
set -Eeuo pipefail

MODE=""
TARGET="auto"
WITH_CLAUDE=true
WITH_APP_SERVER=false
EMIT_DIR=""

NODE_VERSION="${NODE_VERSION:-22}"
NVM_VERSION="${NVM_VERSION:-v0.40.5}"
N8N_PORT="${N8N_PORT:-5678}"
CODEX_APP_SERVER_PORT="${CODEX_APP_SERVER_PORT:-4500}"
CODEX_TOKEN_FILE="${CODEX_TOKEN_FILE:-$HOME/.config/codex-app-server/ws-token}"

usage() {
  cat <<'USAGE'
Usage :
  installer_serveur_automatisation.sh --plan [--target auto|vps|home] [--no-claude] [--with-app-server]
  installer_serveur_automatisation.sh --apply [--target auto|vps|home] [--no-claude] [--with-app-server]
  installer_serveur_automatisation.sh --emit-service-templates DOSSIER [--with-app-server]

Variables :
  NODE_VERSION=22
  NVM_VERSION=v0.40.5
  N8N_PORT=5678
  CODEX_APP_SERVER_PORT=4500
  CODEX_TOKEN_FILE=$HOME/.config/codex-app-server/ws-token

Le mode --plan affiche les actions sans modifier la machine.
Le mode --apply installe des paquets, ecrit des services systemd utilisateur et peut utiliser sudo.
USAGE
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --plan) MODE="plan"; shift ;;
    --apply) MODE="apply"; shift ;;
    --target)
      TARGET="${2:-}"
      case "$TARGET" in auto|vps|home) ;; *) echo "--target doit valoir auto, vps ou home" >&2; exit 2 ;; esac
      shift 2
      ;;
    --with-claude) WITH_CLAUDE=true; shift ;;
    --no-claude) WITH_CLAUDE=false; shift ;;
    --with-app-server) WITH_APP_SERVER=true; shift ;;
    --emit-service-templates)
      EMIT_DIR="${2:-}"
      [ -n "$EMIT_DIR" ] || { echo "--emit-service-templates demande un dossier" >&2; exit 2; }
      MODE="emit"
      shift 2
      ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Argument inconnu : $1" >&2; usage >&2; exit 2 ;;
  esac
done

[ -n "$MODE" ] || { usage >&2; exit 2; }

log() {
  printf '==> %s\n' "$*"
}

warn() {
  printf 'attention: %s\n' "$*" >&2
}

have() {
  command -v "$1" >/dev/null 2>&1
}

run() {
  if [ "$MODE" = "plan" ]; then
    printf '[plan] %s\n' "$*"
  else
    printf '[run] %s\n' "$*"
    "$@"
  fi
}

run_shell() {
  if [ "$MODE" = "plan" ]; then
    printf '[plan] %s\n' "$*"
  else
    printf '[run] %s\n' "$*"
    bash -lc "$*"
  fi
}

need_debian_like() {
  if [ -r /etc/os-release ]; then
    . /etc/os-release
    case "${ID:-}" in
      ubuntu|debian) return 0 ;;
    esac
  fi
  warn "Script prevu pour Ubuntu/Debian. Adapter les commandes paquets sur une autre distribution."
}

explain_target() {
  log "Cible : $TARGET"
  case "$TARGET" in
    vps)
      echo "VPS : garder seulement SSH ouvert publiquement ; acceder a n8n par tunnel."
      ;;
    home)
      echo "Serveur maison : ne pas ouvrir le routeur par defaut ; privilegier reseau local, VPN ou tunnel."
      ;;
    auto)
      echo "Auto : appliquer une configuration prudente commune VPS/maison."
      ;;
  esac
}

render_n8n_service() {
  cat <<EOF
[Unit]
Description=n8n local automation workbench
After=network-online.target

[Service]
Type=simple
WorkingDirectory=%h
Environment=N8N_DIAGNOSTICS_ENABLED=false
Environment=N8N_VERSION_NOTIFICATIONS_ENABLED=false
Environment=N8N_LISTEN_ADDRESS=127.0.0.1
Environment=N8N_PORT=$N8N_PORT
ExecStart=/bin/bash -lc 'export NVM_DIR="\$HOME/.nvm"; [ -s "\$NVM_DIR/nvm.sh" ] && . "\$NVM_DIR/nvm.sh"; exec n8n start'
Restart=on-failure
RestartSec=5

[Install]
WantedBy=default.target
EOF
}

render_codex_app_server_service() {
  cat <<EOF
[Unit]
Description=Codex app-server local endpoint
After=network-online.target

[Service]
Type=simple
WorkingDirectory=%h
ExecStart=/bin/bash -lc 'export NVM_DIR="\$HOME/.nvm"; [ -s "\$NVM_DIR/nvm.sh" ] && . "\$NVM_DIR/nvm.sh"; exec codex app-server --listen ws://127.0.0.1:$CODEX_APP_SERVER_PORT --ws-auth capability-token --ws-token-file "$CODEX_TOKEN_FILE"'
Restart=on-failure
RestartSec=5

[Install]
WantedBy=default.target
EOF
}

emit_templates() {
  mkdir -p "$EMIT_DIR"
  render_n8n_service > "$EMIT_DIR/n8n.service"
  if [ "$WITH_APP_SERVER" = true ]; then
    render_codex_app_server_service > "$EMIT_DIR/codex-app-server.service"
  fi
  log "Templates systemd ecrits dans $EMIT_DIR"
}

ensure_apt_packages() {
  log "Installer les paquets de base"
  run sudo apt-get update
  run sudo apt-get install -y ca-certificates curl git tmux ufw build-essential jq lsof

  if have gh; then
    log "GitHub CLI deja installe"
    return
  fi

  log "Installer GitHub CLI"
  run sudo install -m 0755 -d /etc/apt/keyrings
  run_shell 'curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null'
  run sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
  run_shell 'echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null'
  run sudo apt-get update
  run sudo apt-get install -y gh
}

ensure_firewall() {
  log "Configurer un pare-feu prudent"
  run sudo ufw allow OpenSSH
  if [ "$TARGET" = "home" ]; then
    echo "Serveur maison : le script n'ouvre aucun port routeur. UFW autorise seulement OpenSSH."
  fi
  run sudo ufw --force enable
}

ensure_nvm_node() {
  log "Installer nvm et Node"
  if [ ! -s "$HOME/.nvm/nvm.sh" ]; then
    run git clone --depth 1 --branch "$NVM_VERSION" https://github.com/nvm-sh/nvm.git "$HOME/.nvm"
  else
    log "nvm deja present"
  fi
  run_shell "export NVM_DIR=\"\$HOME/.nvm\"; . \"\$NVM_DIR/nvm.sh\"; nvm install $NODE_VERSION; nvm alias default $NODE_VERSION"
}

ensure_shell_profile() {
  log "Charger nvm dans Bash"
  if [ "$MODE" = "plan" ]; then
    printf '[plan] ajouter le loader nvm a ~/.bashrc si absent\n'
    return
  fi
  touch "$HOME/.bashrc"
  if ! grep -q 'NVM_DIR="\$HOME/.nvm"' "$HOME/.bashrc"; then
    {
      echo 'export NVM_DIR="$HOME/.nvm"'
      echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"'
    } >> "$HOME/.bashrc"
  fi
}

ensure_node_packages() {
  log "Installer les CLI npm"
  run_shell 'export NVM_DIR="$HOME/.nvm"; . "$NVM_DIR/nvm.sh"; npm install -g n8n'
  if have codex; then
    log "Codex CLI deja installe : $(command -v codex)"
  else
    run_shell 'export NVM_DIR="$HOME/.nvm"; . "$NVM_DIR/nvm.sh"; npm install -g @openai/codex'
  fi
  if [ "$WITH_CLAUDE" = true ]; then
    run_shell 'export NVM_DIR="$HOME/.nvm"; . "$NVM_DIR/nvm.sh"; npm install -g @anthropic-ai/claude-code'
  else
    log "Claude Code ignore a la demande ; retirer --no-claude pour l'installer"
  fi
}

ensure_token() {
  [ "$WITH_APP_SERVER" = true ] || return 0
  log "Creer le fichier token Codex app-server"
  if [ "$MODE" = "plan" ]; then
    printf '[plan] creer %s en mode 600 si absent ; valeur jamais affichee\n' "$CODEX_TOKEN_FILE"
    return
  fi
  mkdir -p "$(dirname "$CODEX_TOKEN_FILE")"
  if [ ! -s "$CODEX_TOKEN_FILE" ]; then
    if have openssl; then
      openssl rand -hex 32 > "$CODEX_TOKEN_FILE"
    else
      python3 -c 'import secrets; print(secrets.token_hex(32))' > "$CODEX_TOKEN_FILE"
    fi
  fi
  chmod 600 "$CODEX_TOKEN_FILE"
}

install_user_services() {
  log "Installer les services utilisateur en localhost"
  if [ "$MODE" = "plan" ]; then
    printf '[plan] ecrire ~/.config/systemd/user/n8n.service\n'
    if [ "$WITH_APP_SERVER" = true ]; then
      printf '[plan] ecrire ~/.config/systemd/user/codex-app-server.service\n'
    fi
    printf '[plan] systemctl --user daemon-reload && enable --now n8n.service\n'
    [ "$WITH_APP_SERVER" = true ] && printf '[plan] systemctl --user enable --now codex-app-server.service\n'
    printf '[plan] loginctl enable-linger %s\n' "$USER"
    return
  fi
  mkdir -p "$HOME/.config/systemd/user"
  render_n8n_service > "$HOME/.config/systemd/user/n8n.service"
  systemctl --user daemon-reload
  systemctl --user enable --now n8n.service
  if [ "$WITH_APP_SERVER" = true ]; then
    render_codex_app_server_service > "$HOME/.config/systemd/user/codex-app-server.service"
    systemctl --user daemon-reload
    systemctl --user enable --now codex-app-server.service
  fi
  loginctl enable-linger "$USER" || warn "Impossible d'activer linger ; le service peut s'arreter apres deconnexion"
}

print_next_steps() {
  local host_hint
  host_hint="$(hostname -I 2>/dev/null | awk '{print $1}' || true)"
  [ -n "$host_hint" ] || host_hint="adresse-du-serveur"
  cat <<EOF

== Prochaines etapes ==
Authentifications a lancer interactivement. Ne collez aucun secret dans le chat.

GitHub :
  gh auth login
  gh auth status

Codex :
  codex login
  codex doctor --summary

Claude :
  claude
  claude doctor

n8n depuis l'ordinateur local :
  ssh -N -L 5678:127.0.0.1:5678 $USER@$host_hint
  ouvrir http://localhost:5678
EOF
  if [ "$WITH_APP_SERVER" = true ]; then
    cat <<EOF

Codex app-server avance, depuis l'ordinateur local :
  ssh -N -L 4500:127.0.0.1:4500 $USER@$host_hint
  token sur le serveur : $CODEX_TOKEN_FILE (ne pas l'afficher dans le chat)
EOF
  fi
}

if [ "$MODE" = "emit" ]; then
  emit_templates
  exit 0
fi

need_debian_like
explain_target
ensure_apt_packages
ensure_firewall
ensure_nvm_node
ensure_shell_profile
ensure_node_packages
ensure_token
install_user_services
print_next_steps
