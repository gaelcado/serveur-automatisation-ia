#!/usr/bin/env bash
set -u

section() {
  printf '\n== %s ==\n' "$1"
}

check_cmd() {
  if command -v "$1" >/dev/null 2>&1; then
    printf 'ok: %s -> %s\n' "$1" "$(command -v "$1")"
  else
    printf 'manquant: %s\n' "$1"
  fi
}

show_version() {
  if command -v "$1" >/dev/null 2>&1; then
    printf '%s: ' "$1"
    shift
    "$@" 2>&1 | sed -n '1p' | sed -E 's/(token|secret|password|api[_-]?key)[^ ]*/[redacted]/Ig'
  fi
}

service_state() {
  local service="$1"
  if systemctl --user list-unit-files "$service" >/dev/null 2>&1; then
    printf '%s: %s\n' "$service" "$(systemctl --user is-active "$service" 2>/dev/null || true)"
  else
    printf '%s: non installe\n' "$service"
  fi
}

section "Machine"
hostname 2>/dev/null || true
uname -a
if [ -r /etc/os-release ]; then
  . /etc/os-release
  printf 'os: %s %s\n' "${NAME:-inconnu}" "${VERSION_ID:-inconnu}"
fi
printf 'utilisateur: %s\n' "${USER:-inconnu}"
printf 'home: %s\n' "${HOME:-inconnu}"

section "Reseau"
printf 'ip locale(s): '
hostname -I 2>/dev/null || true
if command -v curl >/dev/null 2>&1; then
  public_ip="$(curl -fsS --max-time 3 https://ifconfig.me 2>/dev/null || true)"
  [ -n "$public_ip" ] && printf 'ip publique vue depuis internet: %s\n' "$public_ip" || printf 'ip publique: indisponible\n'
else
  echo "curl manquant, ip publique non testee"
fi

section "Commandes"
for cmd in ssh git gh curl tmux systemctl loginctl ss lsof node npm n8n codex claude ufw jq; do
  check_cmd "$cmd"
done

section "Versions"
show_version git git --version
show_version gh gh --version
show_version node node --version
show_version npm npm --version
show_version n8n n8n --version
show_version codex codex --version
show_version claude claude --version

section "Git"
git config --global --get user.name >/dev/null 2>&1 && echo "user.name: configure" || echo "user.name: manquant"
git config --global --get user.email >/dev/null 2>&1 && echo "user.email: configure" || echo "user.email: manquant"

section "GitHub CLI"
if command -v gh >/dev/null 2>&1; then
  gh auth status 2>&1 \
    | sed -E 's/gh[oprsu]_[A-Za-z0-9_*]+/[redacted]/g; s/(oauth_token|token|password|secret).*/[redacted]/Ig' || true
else
  echo "gh non installe"
fi

section "Codex"
if command -v codex >/dev/null 2>&1; then
  codex doctor --summary --ascii 2>&1 | sed -E 's/(api[_-]?key|access[_-]?token|refresh[_-]?token|secret)[^ ]*/[redacted]/Ig' || true
else
  echo "codex non installe"
fi

section "Claude Code"
if command -v claude >/dev/null 2>&1; then
  echo "claude: installe"
  echo "lancer 'claude doctor' manuellement si un diagnostic auth est necessaire"
else
  echo "claude: non installe"
fi

section "systemd utilisateur"
systemctl --user is-system-running 2>/dev/null || true
service_state n8n.service
service_state codex-app-server.service

section "Pare-feu"
if command -v ufw >/dev/null 2>&1; then
  sudo -n ufw status verbose 2>/dev/null || ufw status verbose 2>/dev/null || echo "statut ufw indisponible sans sudo"
else
  echo "ufw non installe"
fi

section "Ports utiles"
if command -v ss >/dev/null 2>&1; then
  ss -ltnp 2>/dev/null | awk '$4 ~ /:22$|:4500$|:5678$|:5679$|:3000$|:5173$|:8000$|:8080$/ {print}' || true
else
  echo "ss non installe"
fi

section "Tunnels a lancer depuis l'ordinateur local"
host_hint="$(hostname -I 2>/dev/null | awk '{print $1}')"
[ -n "$host_hint" ] || host_hint="adresse-du-serveur"
printf 'n8n: ssh -N -L 5678:127.0.0.1:5678 %s@%s\n' "${USER:-utilisateur}" "$host_hint"
printf 'codex app-server si active: ssh -N -L 4500:127.0.0.1:4500 %s@%s\n' "${USER:-utilisateur}" "$host_hint"
