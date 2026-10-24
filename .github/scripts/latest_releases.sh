#!/usr/bin/env bash
# Refresh the <!-- latest-releases:start --> ... <!-- latest-releases:end --> block in a README
# with the latest release of each repo, newest first.
# Usage: latest_releases.sh [README.md]
set -euo pipefail

FILE="${1:-README.md}"
OWNER="0x3654"
REPOS=(chargesense lazy1c zai-cursor-limit better-osd Nightfall)

auth=()
if [ -n "${GITHUB_TOKEN:-}" ]; then auth=(-H "Authorization: Bearer ${GITHUB_TOKEN}"); fi

tmp="$(mktemp)"
for repo in "${REPOS[@]}"; do
  json="$(curl -sf "${auth[@]}" "https://api.github.com/repos/${OWNER}/${repo}/releases/latest" || true)"
  [ -n "$json" ] || continue
  tag="$(jq -r .tag_name <<<"$json")"
  date="$(jq -r .published_at <<<"$json" | cut -dT -f1)"
  echo "${date}|${repo}|${tag}" >>"$tmp"
done

block="$(mktemp)"
{
  echo "<!-- latest-releases:start -->"
  sort -r <"$tmp" | while IFS='|' read -r date repo tag; do
    echo "- [**${repo}** ${tag}](https://github.com/${OWNER}/${repo}/releases/tag/${tag}) — ${date}"
  done
  echo "<!-- latest-releases:end -->"
} >"$block"

awk -v blockfile="$block" '
  /<!-- latest-releases:start -->/ { while ((getline l < blockfile) > 0) print l; close(blockfile); skip=1; next }
  /<!-- latest-releases:end -->/   { skip=0; next }
  !skip { print }
' "$FILE" >"$FILE.new" && mv "$FILE.new" "$FILE"

echo "Updated ${FILE}:"
sed -n '/latest-releases:start/,/latest-releases:end/p' "$FILE"
