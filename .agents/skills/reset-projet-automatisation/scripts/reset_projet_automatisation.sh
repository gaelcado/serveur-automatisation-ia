#!/usr/bin/env bash
set -Eeuo pipefail

MODE=""
RESET_MODE=""
UPSTREAM="origin/main"
YES=false

usage() {
  cat <<'USAGE'
Usage :
  reset_projet_automatisation.sh --plan --mode keep-context|wipe-all [--upstream origin/main]
  reset_projet_automatisation.sh --apply --mode keep-context|wipe-all --yes [--upstream origin/main]

Modes :
  keep-context  Reset git vers l'upstream en gardant les fichiers ignores locaux.
  wipe-all      Reset git vers l'upstream puis supprime le contexte local ignore courant.

Ce script ne supprime jamais de fichier hors du depot.
USAGE
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --plan) MODE="plan"; shift ;;
    --apply) MODE="apply"; shift ;;
    --mode)
      RESET_MODE="${2:-}"
      case "$RESET_MODE" in keep-context|wipe-all) ;; *) echo "--mode doit valoir keep-context ou wipe-all" >&2; exit 2 ;; esac
      shift 2
      ;;
    --upstream)
      UPSTREAM="${2:-}"
      [ -n "$UPSTREAM" ] || { echo "--upstream demande une ref" >&2; exit 2; }
      shift 2
      ;;
    --yes) YES=true; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Argument inconnu : $1" >&2; usage >&2; exit 2 ;;
  esac
done

[ -n "$MODE" ] || { usage >&2; exit 2; }
[ -n "$RESET_MODE" ] || { usage >&2; exit 2; }

root="$(git rev-parse --show-toplevel 2>/dev/null || true)"
[ -n "$root" ] || { echo "Ce dossier n'est pas un depot git" >&2; exit 1; }
cd "$root"

if ! git remote get-url origin >/dev/null 2>&1; then
  echo "Remote origin manquant : impossible de definir l'upstream automatiquement" >&2
  exit 1
fi

ignored_context=(
  "USER.md"
  ".context-local"
  ".sessions-local"
  ".env"
  "auth.json"
  "ws-token"
  ".cache"
  "tmp"
  "node_modules"
)

say() {
  printf '==> %s\n' "$*"
}

print_plan() {
  say "Plan de reset"
  printf 'racine: %s\n' "$root"
  printf 'mode: %s\n' "$RESET_MODE"
  printf 'upstream: %s\n' "$UPSTREAM"
  printf '\nEtat git actuel:\n'
  git status --short || true

  cat <<EOF

Actions prevues :
1. git fetch origin
2. verifier que $UPSTREAM existe
3. git reset --hard $UPSTREAM
4. git clean -fd
EOF

  if [ "$RESET_MODE" = "keep-context" ]; then
    cat <<'EOF'
5. garder les fichiers ignores locaux : USER.md, .context-local/, .sessions-local/, .env*, caches ignores.
EOF
  else
    cat <<'EOF'
5. supprimer les fichiers ignores locaux courants du depot :
EOF
    printf '   - %s\n' "${ignored_context[@]}"
    printf '   - %s\n' ".env.* sauf .env.example"
  fi

  cat <<'EOF'

Risque :
- Les modifications non commitees sur des fichiers suivis seront perdues.
- Les fichiers non suivis et non ignores seront supprimes par git clean -fd.
- En mode wipe-all, le contexte local ignore sera aussi supprime.
EOF
}

wipe_ignored_context() {
  local path
  for path in "${ignored_context[@]}"; do
    if [ -e "$path" ] || [ -L "$path" ]; then
      rm -rf -- "$path"
      printf '[wipe] %s\n' "$path"
    fi
  done

  find . -maxdepth 1 -type f -name '.env.*' ! -name '.env.example' -print -delete \
    | sed 's#^\./#[wipe] #'
}

if [ "$MODE" = "plan" ]; then
  print_plan
  exit 0
fi

if [ "$YES" != true ]; then
  echo "Refus : --apply demande --yes apres confirmation utilisateur explicite" >&2
  exit 2
fi

print_plan
say "Execution"
git fetch origin
git rev-parse --verify "$UPSTREAM^{commit}" >/dev/null
git reset --hard "$UPSTREAM"
git clean -fd

if [ "$RESET_MODE" = "wipe-all" ]; then
  wipe_ignored_context
fi

say "Etat final"
git status --short
