#!/usr/bin/env bash
# Install the universal agent-kit into Claude Code (~/.claude) and Antigravity/Gemini (~/.gemini).
# Single source of truth: global/RULES.md and global/skills/. Re-run after editing either.
# Existing non-kit global rules files are backed up before being overwritten.
set -euo pipefail

kit="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
rules="$kit/global/RULES.md"
[ -f "$rules" ] || { echo "Cannot find $rules" >&2; exit 1; }

marker='GENERATED from agent-kit/global/RULES.md'
gen_note="<!-- $marker by the installer. Do not edit here; edit RULES.md and re-run. -->"

write_rules() {
  local target="$1"
  mkdir -p "$(dirname "$target")"
  if [ -f "$target" ] && ! grep -q "$marker" "$target"; then
    local bak="$target.bak.$(date +%Y%m%d-%H%M%S)"
    cp "$target" "$bak"
    echo "Backed up existing $target -> $bak"
  fi
  { printf '%s\n\n' "$gen_note"; cat "$rules"; } > "$target"
  echo "Wrote $target"
}

write_rules "$HOME/.claude/CLAUDE.md"
write_rules "$HOME/.gemini/GEMINI.md"

for base in "$HOME/.claude" "$HOME/.gemini"; do
  mkdir -p "$base/skills"
  for d in "$kit"/global/skills/*/; do
    name="$(basename "$d")"
    rm -rf "$base/skills/$name"
    cp -R "$d" "$base/skills/$name"
    echo "Installed skill '$name' -> $base/skills/$name"
  done
done

echo
echo "Done. Re-run after editing global/RULES.md or global/skills/."
