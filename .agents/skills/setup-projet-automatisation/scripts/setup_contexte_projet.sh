#!/usr/bin/env bash
set -Eeuo pipefail

MODE=""

usage() {
  cat <<'USAGE'
Usage :
  setup_contexte_projet.sh --plan
  setup_contexte_projet.sh --apply
  setup_contexte_projet.sh --cleanup

--plan    Affiche l'etat et les actions possibles sans rien modifier.
--apply   Cree le contexte local manquant et repare les liens simples.
--cleanup Verifie la fin de setup et imprime les points a condenser.
USAGE
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --plan) MODE="plan"; shift ;;
    --apply) MODE="apply"; shift ;;
    --cleanup) MODE="cleanup"; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Argument inconnu : $1" >&2; usage >&2; exit 2 ;;
  esac
done

[ -n "$MODE" ] || { usage >&2; exit 2; }

root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$root"

say() {
  printf '==> %s\n' "$*"
}

status_file() {
  local path="$1"
  if [ -e "$path" ] || [ -L "$path" ]; then
    printf 'ok: %s\n' "$path"
  else
    printf 'manquant: %s\n' "$path"
  fi
}

ensure_user_md() {
  if [ -e USER.md ]; then
    say "USER.md existe deja"
    return
  fi

  if [ "$MODE" = "plan" ]; then
    printf '[plan] cp USER.example.md USER.md\n'
    return
  fi

  cp USER.example.md USER.md
  say "USER.md cree depuis USER.example.md"
}

ensure_claude_link() {
  if [ -L CLAUDE.md ] && [ "$(readlink CLAUDE.md)" = "AGENTS.md" ]; then
    say "CLAUDE.md pointe vers AGENTS.md"
  elif [ -e CLAUDE.md ]; then
    printf 'attention: CLAUDE.md existe mais ce n est pas le lien attendu\n' >&2
  elif [ "$MODE" = "plan" ]; then
    printf '[plan] ln -s AGENTS.md CLAUDE.md\n'
  else
    ln -s AGENTS.md CLAUDE.md
    say "CLAUDE.md cree comme lien vers AGENTS.md"
  fi
}

ensure_claude_skills_link() {
  if [ -L .claude/skills ] && [ "$(readlink .claude/skills)" = "../.agents/skills" ]; then
    say ".claude/skills pointe vers ../.agents/skills"
  elif [ -e .claude/skills ]; then
    printf 'attention: .claude/skills existe mais ce n est pas le lien attendu\n' >&2
  elif [ "$MODE" = "plan" ]; then
    printf '[plan] mkdir -p .claude && ln -s ../.agents/skills .claude/skills\n'
  else
    mkdir -p .claude
    ln -s ../.agents/skills .claude/skills
    say ".claude/skills cree comme lien vers ../.agents/skills"
  fi
}

print_state() {
  say "Etat du depot"
  printf 'racine: %s\n' "$root"
  status_file README.md
  status_file AGENTS.md
  status_file CLAUDE.md
  status_file USER.example.md
  status_file USER.md
  status_file docs/00-checklist-setup-agentique.md
  status_file docs/07-cycle-de-vie-du-contexte.md
  status_file .agents/skills/setup-projet-automatisation/SKILL.md
  status_file .agents/skills/installer-serveur-automatisation/SKILL.md
  status_file .agents/skills/reset-projet-automatisation/SKILL.md

  say "Liens"
  if [ -L CLAUDE.md ]; then
    printf 'CLAUDE.md -> %s\n' "$(readlink CLAUDE.md)"
  else
    printf 'CLAUDE.md: pas un lien symbolique\n'
  fi
  if [ -L .claude/skills ]; then
    printf '.claude/skills -> %s\n' "$(readlink .claude/skills)"
  else
    printf '.claude/skills: pas un lien symbolique\n'
  fi

  say "Git"
  git status --short || true
}

print_next_steps() {
  cat <<'EOF'

== Prochain checkpoint humain/agent ==
1. Noter dans USER.md : niveau, objectif, chemin choisi, prochain checkpoint.
2. Choisir la suite :
   - local seulement : docs/06-chemin-local.md
   - serveur : docs/00-checklist-setup-agentique.md
   - machine Linux prete : $installer-serveur-automatisation
3. En fin de phase, relancer :
   .agents/skills/setup-projet-automatisation/scripts/setup_contexte_projet.sh --cleanup
EOF
}

cleanup_report() {
  print_state
  cat <<'EOF'

== Cleanup de fin de setup ==
Verifier USER.md :
- Etat courant rempli et court.
- Chemin choisi unique : local / VPS / serveur maison / serveur existant.
- Prochain checkpoint explicite.
- Anciennes pistes supprimees, condensees, ou notees dans "Contexte a oublier ou archiver".
- Aucun secret, token, mot de passe, cle privee, cookie ou credential.

Verifier git :
- USER.md doit rester ignore.
- .context-local/ et .sessions-local/ doivent rester ignores.
- Les changements publics doivent concerner seulement docs, skills, scripts ou contexte partageable.
EOF
}

case "$MODE" in
  plan)
    print_state
    ensure_user_md
    ensure_claude_link
    ensure_claude_skills_link
    print_next_steps
    ;;
  apply)
    ensure_user_md
    ensure_claude_link
    ensure_claude_skills_link
    print_state
    print_next_steps
    ;;
  cleanup)
    cleanup_report
    ;;
esac
