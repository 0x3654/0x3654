#!/usr/bin/env bash
# Sort the project cards between <!-- projects:start --> / <!-- projects:end -->
# markers by the target repo's last push in the cloud (newest first). A card is
# a "### ..." heading plus its body; the repo comes from the first
# github.com/<owner>/<repo> link in the card. The same repo (EN + RU sections)
# is looked up once.
# Usage: sort_projects.sh [README.md]
set -euo pipefail
export LANG=C.UTF-8 LC_ALL=C.UTF-8

FILE="${1:-README.md}"
OWNER="0x3654"
API="https://api.github.com"

auth=()
if [ -n "${GITHUB_TOKEN:-}" ]; then auth=(-H "Authorization: Bearer ${GITHUB_TOKEN}"); fi

declare -A PUSHED

pushed_for() { # $1 = repo -> pushed_at (epoch fallback if the lookup fails)
  local repo="$1"
  if [ -z "${PUSHED[$repo]+x}" ]; then
    PUSHED[$repo]="$(curl -sf "${auth[@]}" "$API/repos/$OWNER/$repo" | jq -r .pushed_at || true)"
    [ -n "${PUSHED[$repo]}" ] || PUSHED[$repo]="1970-01-01T00:00:00Z"
  fi
  echo "${PUSHED[$repo]}"
}

card_repo() { # $1 = card text -> repo name (empty if no repo link)
  grep -oE "github\.com/${OWNER}/[A-Za-z0-9_.-]+" <<<"$1" \
    | head -1 | sed "s|github\\.com/${OWNER}/||" || true
}

rtrim() { local s="$1"; while [ "${s: -1}" = $'\n' ]; do s="${s%$'\n'}"; done; printf '%s' "$s"; }

tmp_out="$(mktemp)"
order="$(mktemp)"
inblock=0
collect=()
cur=""

while IFS= read -r line || [ -n "$line" ]; do
  case "$line" in
    '<!-- projects:start -->')
      printf '%s\n' "$line" >>"$tmp_out"
      inblock=1; collect=(); cur=""
      ;;
    '<!-- projects:end -->')
      [ -n "$cur" ] && collect+=("$(rtrim "$cur")")
      # by last push, newest first (ties keep the original order)
      : >"$order"
      for i in "${!collect[@]}"; do
        printf '%s\t%s\n' "$(pushed_for "$(card_repo "${collect[$i]}")")" "$i" >>"$order"
      done
      sort -k1,1r -k2,2n "$order" | while IFS=$'\t' read -r _ i; do
        printf '%s\n\n' "${collect[$i]}" >>"$tmp_out"
      done
      printf '%s\n' "$line" >>"$tmp_out"
      inblock=0
      ;;
    '### '*)
      if [ "$inblock" -eq 1 ]; then
        [ -n "$cur" ] && collect+=("$(rtrim "$cur")")
        cur="$line"
      else
        printf '%s\n' "$line" >>"$tmp_out"
      fi
      ;;
    *)
      if [ "$inblock" -eq 1 ]; then
        # skip blank lines before the first card of a block
        if [ -n "$line" ] || [ -n "$cur" ]; then cur+=$'\n'"$line"; fi
      else
        printf '%s\n' "$line" >>"$tmp_out"
      fi
      ;;
  esac
done <"$FILE"

mv "$tmp_out" "$FILE"

echo "Sorted project cards in ${FILE}:"
sed -n '/<!-- projects:start -->/,/<!-- projects:end -->/p' "$FILE" | grep '^### '
