#!/usr/bin/env bash
# Refresh the <!-- popular-repos:start --> ... <!-- popular-repos:end --> blocks in a README
# with a top-5 table of own public repos, ranked by stars -> forks -> unique clones (14d).
# Traffic API needs a token with push access (GITHUB_TOKEN in Actions; locally: gh auth token).
# Usage: popular_repos.sh [README.md]
set -euo pipefail

FILE="${1:-README.md}"
OWNER="0x3654"

auth=()
# traffic API needs push access: GITHUB_TOKEN in Actions lacks it — use TRAFFIC_TOKEN (PAT) when present
if [ -n "${TRAFFIC_TOKEN:-}" ]; then auth=(-H "Authorization: Bearer ${TRAFFIC_TOKEN}")
elif [ -n "${GITHUB_TOKEN:-}" ]; then auth=(-H "Authorization: Bearer ${GITHUB_TOKEN}")
fi

tmp="$(mktemp)"
repos="$(curl -sf "${auth[@]}" "https://api.github.com/users/${OWNER}/repos?per_page=100&type=owner" \
  | jq -r '.[] | select((.fork or .private or .archived or .name == "0x3654") | not)
           | .name + "\t" + (.stargazers_count|tostring) + "\t" + (.forks_count|tostring)
             + "\t" + ((.description // "") | gsub("[\\r\\n\\t]"; " ") | gsub("[|]"; "/") | .[0:70])')"

while IFS=$'\t' read -r name stars forks desc; do
  [ -n "${name:-}" ] || continue
  uniq=0
  tc="$(curl -sf "${auth[@]}" "https://api.github.com/repos/${OWNER}/${name}/traffic/clones" 2>/dev/null | jq -r '.uniques // 0' || true)"
  [ -n "${tc:-}" ] && [ "$tc" != "null" ] && uniq="$tc"
  printf '%s\t%s\t%s\t%s\t%s\n' "$stars" "$forks" "$uniq" "$name" "$desc" >>"$tmp"
done <<<"$repos"

block="$(mktemp)"
{
  echo "<!-- popular-repos:start -->"
  echo "| Repo | ⭐ | ⑂ | clones/14d | about |"
  echo "|---|---|---|---|---|"
  sort -t$'\t' -k1,1nr -k2,2nr -k3,3nr "$tmp" | head -5 | while IFS=$'\t' read -r s f c n d; do
    echo "| [${n}](https://github.com/${OWNER}/${n}) | ${s} | ${f} | ${c} | ${d} |"
  done
  echo "<!-- popular-repos:end -->"
} >"$block"

awk -v blockfile="$block" '
  /<!-- popular-repos:start -->/ { while ((getline l < blockfile) > 0) print l; close(blockfile); skip=1; next }
  /<!-- popular-repos:end -->/   { skip=0; next }
  !skip { print }
' "$FILE" >"$FILE.new" && mv "$FILE.new" "$FILE"

echo "Updated ${FILE}:"
sed -n '/popular-repos:start/,/popular-repos:end/p' "$FILE"
