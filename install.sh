#!/usr/bin/env sh
set -eu

BEGIN_MARKER="<!-- payback:begin -->"
END_MARKER="<!-- payback:end -->"
SOURCE_URL="${PAYBACK_SOURCE_URL:-https://raw.githubusercontent.com/flyrev/payback/main/PAYBACK.md}"

usage() {
  cat <<'EOF'
Payback — install an always-on conversational vibe mirror.

Usage:
  install.sh                 Install globally for supported agents
  install.sh --global        Same as above
  install.sh --project DIR   Install into a repository/project
  install.sh --help

Environment:
  PAYBACK_SOURCE_URL         Override the canonical PAYBACK.md URL
EOF
}

fetch_contract() {
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$SOURCE_URL"
  elif command -v wget >/dev/null 2>&1; then
    wget -qO- "$SOURCE_URL"
  else
    echo "Payback requires curl or wget." >&2
    exit 1
  fi
}

strip_existing_block() {
  file="$1"
  [ -f "$file" ] || return 0
  awk -v begin="$BEGIN_MARKER" -v end="$END_MARKER" '
    $0 == begin { skip=1; next }
    $0 == end   { skip=0; next }
    !skip       { print }
  ' "$file"
}

install_block() {
  file="$1"
  contract="$2"
  dir=$(dirname "$file")
  mkdir -p "$dir"

  tmp="${file}.payback.tmp.$$"
  {
    strip_existing_block "$file"
    printf '\n%s\n' "$BEGIN_MARKER"
    printf '%s\n' "$contract"
    printf '%s\n' "$END_MARKER"
  } > "$tmp"

  mv "$tmp" "$file"
  printf 'Payback -> %s\n' "$file"
}

install_global() {
  contract="$1"

  install_block "$HOME/.codex/AGENTS.md" "$contract"

  opencode_config="${XDG_CONFIG_HOME:-$HOME/.config}"
  install_block "$opencode_config/opencode/AGENTS.md" "$contract"

  install_block "$HOME/.copilot/copilot-instructions.md" "$contract"
  install_block "$HOME/.claude/CLAUDE.md" "$contract"
  install_block "$HOME/.gemini/GEMINI.md" "$contract"
}

install_project() {
  dir="$1"
  contract="$2"
  mkdir -p "$dir"

  # AGENTS.md is used by both Codex and OpenCode.
  install_block "$dir/AGENTS.md" "$contract"
  install_block "$dir/CLAUDE.md" "$contract"
  install_block "$dir/GEMINI.md" "$contract"
  install_block "$dir/.github/copilot-instructions.md" "$contract"
}

mode="global"
target=""

case "${1:-}" in
  ""|--global)
    ;;
  --project)
    [ "${2:-}" ] || { echo "--project requires a directory." >&2; exit 2; }
    mode="project"
    target="$2"
    ;;
  --help|-h)
    usage
    exit 0
    ;;
  *)
    echo "Unknown argument: $1" >&2
    usage >&2
    exit 2
    ;;
esac

contract=$(fetch_contract)

if [ "$mode" = "global" ]; then
  install_global "$contract"
else
  install_project "$target" "$contract"
fi

echo "Payback installed. Start a new agent session and change your tone whenever you feel like it."
