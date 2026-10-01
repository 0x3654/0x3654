#!/usr/bin/env bash
# Weekly GitHub digest: collect the past week's events across my public repos
# (new stars, forks, issues, comments by others, incoming PRs) plus my own
# PRs/issues in other repos (opened/merged/closed/activity), and send an HTML
# summary to Telegram.
# Invoked by .github/workflows/weekly-digest.yml (Fridays). Without
# TG_BOT_TOKEN/TG_CHAT_ID set, prints the message to stdout (dry run).
set -euo pipefail
export LANG=C.UTF-8 LC_ALL=C.UTF-8

OWNER="0x3654"
WEB="https://github.com"
API="https://api.github.com"
SINCE_TS="$(date -u -d '7 days ago' +%Y-%m-%dT%H:%M:%SZ)"
SINCE_DATE="${SINCE_TS%%T*}"
TODAY="$(date -u +%F)"

auth=()
if [ -n "${GITHUB_TOKEN:-}" ]; then auth=(-H "Authorization: Bearer ${GITHUB_TOKEN}"); fi

esc() { sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g' <<<"$1"; }
repo_link() { echo "<a href=\"${WEB}/${OWNER}/$1\">$(esc "$1")</a>"; }

# ------------------------------------------------------------------ my repos --
repos_tmp="$(mktemp)"
page=1
while :; do
  chunk="$(curl -sf "${auth[@]}" "$API/users/$OWNER/repos?type=owner&sort=full_name&per_page=100&page=$page" || true)"
  [ -n "$chunk" ] || break
  jq -c '.[] | select(.fork == false) | {name, stars: .stargazers_count}' <<<"$chunk" >>"$repos_tmp"
  [ "$(jq 'length' <<<"$chunk")" -lt 100 ] && break
  page=$((page + 1))
done
mapfile -t REPOS < <(jq -r '.name' "$repos_tmp")
TOTAL_STARS="$(jq -s '[.[].stars] | add // 0' "$repos_tmp")"

# ---------------------------------------------------------------- new stars --
# REST stargazers are not sortable by starredAt, so query GraphQL in chunks of
# 20 repos; up to 100 new stars per repo per week (edges are capped at 100).
stars_tmp="$(mktemp)"
names=("${REPOS[@]}")
while [ "${#names[@]}" -gt 0 ]; do
  chunk_names=("${names[@]:0:20}")
  names=("${names[@]:20}")
  body="query {"
  i=0
  for name in "${chunk_names[@]}"; do
    body+=" r${i}: repository(owner: \"${OWNER}\", name: \"${name}\")"
    body+=" { name stargazers(first: 100, orderBy: {field: STARRED_AT, direction: DESC})"
    body+=" { edges { starredAt node { login } } } }"
    i=$((i + 1))
  done
  body+=" }"
  curl -sf "${auth[@]}" -H 'Content-Type: application/json' \
    -d "$(jq -nc --arg q "$body" '{query: $q}')" "$API/graphql" \
    | jq -r --arg since "$SINCE_TS" '
        .data // {} | to_entries[] | .value as $r
        | [$r.name, ($r.stargazers.edges // [] | map(select(.starredAt >= $since) | .node.login))]
        | select(.[1] | length > 0) | @json' >>"$stars_tmp" || true
done

stars_section=""; new_stars_total=0
while IFS= read -r row; do
  repo="$(jq -r '.[0]' <<<"$row")"
  mapfile -t logins < <(jq -r '.[1][]' <<<"$row")
  n="${#logins[@]}"
  new_stars_total=$((new_stars_total + n))
  shown="${logins[*]:0:5}"
  extra=$((n - 5))
  [ "$extra" -gt 0 ] && shown+=", +${extra} ещё"
  stars_section+=$'\n'"⭐ $(repo_link "$repo") +${n} — $(esc "$shown")"
done <"$stars_tmp"

# ------------------------------------- per-repo: issues/comments/PRs/forks ----
issues_section=""; comments_section=""; incoming_section=""; forks_section=""
comments_count=0
for repo in "${REPOS[@]}"; do
  base="$API/repos/$OWNER/$repo"

  # new issues by others (PRs excluded)
  while IFS=$'\t' read -r num title login; do
    issues_section+=$'\n'"🐛 <a href=\"${WEB}/${OWNER}/${repo}/issues/${num}\">${repo}#${num}</a> «$(esc "$title")» — от $(esc "$login")"
  done < <(curl -sf "${auth[@]}" "$base/issues?state=all&sort=created&direction=desc&per_page=20" \
    | jq -r --arg since "$SINCE_TS" --arg me "$OWNER" '
        .[] | select(.created_at >= $since and (has("pull_request") | not) and .user.login != $me)
        | [.number, .title, .user.login] | @tsv' || true)

  # new comments by others on my issues and PRs (rendered: first 20)
  while IFS=$'\t' read -r num login; do
    comments_count=$((comments_count + 1))
    [ "$comments_count" -le 20 ] || continue
    comments_section+=$'\n'"💬 <a href=\"${WEB}/${OWNER}/${repo}/issues/${num}\">${repo}#${num}</a> — $(esc "$login")"
  done < <(curl -sf "${auth[@]}" "$base/issues/comments?sort=created&direction=desc&per_page=30" \
    | jq -r --arg since "$SINCE_TS" --arg me "$OWNER" '
        .[] | select(.created_at >= $since and .user.login != $me)
        | [(.issue_url | split("/") | last), .user.login] | @tsv' || true)

  # incoming PRs by others
  while IFS=$'\t' read -r num title login state merged; do
    marker="открыт"
    [ "$merged" = "true" ] && marker="смержен"
    { [ "$state" = "closed" ] && [ "$merged" != "true" ]; } && marker="закрыт"
    incoming_section+=$'\n'"🔀 <a href=\"${WEB}/${OWNER}/${repo}/pull/${num}\">${repo}#${num}</a> «$(esc "$title")» — ${marker} ($(esc "$login"))"
  done < <(curl -sf "${auth[@]}" "$base/pulls?state=all&sort=created&direction=desc&per_page=20" \
    | jq -r --arg since "$SINCE_TS" --arg me "$OWNER" '
        .[] | select(.created_at >= $since and .user.login != $me)
        | [.number, .title, .user.login, .state, (.merged_at != null)] | @tsv' || true)

  # new forks
  while IFS=$'\t' read -r login; do
    forks_section+=$'\n'"🍴 $(repo_link "$repo") ← $(esc "$login")"
  done < <(curl -sf "${auth[@]}" "$base/forks?sort=newest&per_page=30" \
    | jq -r --arg since "$SINCE_TS" '.[] | select(.created_at >= $since) | .owner.login' || true)
done
[ "$comments_count" -gt 20 ] && comments_section+=$'\n'"… и ещё $((comments_count - 20))"

# ------------------------------------------------- my PRs / issues elsewhere --
mine_pr_section=""
while IFS=$'\t' read -r full num title ev; do
  case "$ev" in
    opened) icon="🟢"; word="открыт" ;;
    merged) icon="🟣"; word="смержен" ;;
    closed) icon="🔴"; word="закрыт" ;;
    *) icon="💬"; word="активность" ;;
  esac
  mine_pr_section+=$'\n'"${icon} <a href=\"${WEB}/${full}/pull/${num}\">${full}#${num}</a> «$(esc "$title")» — ${word}"
done < <(curl -sfG "${auth[@]}" "$API/search/issues" \
  --data-urlencode "q=is:pr author:${OWNER} -user:${OWNER} updated:>=${SINCE_DATE}" \
  --data-urlencode 'per_page=100' --data-urlencode 'sort=updated' \
  | jq -r --arg since "$SINCE_TS" '
      .items[] | [(.repository_url | sub("^https://api\\.github\\.com/repos/"; "")), .number, .title,
        (if .created_at >= $since then "opened"
         elif (.pull_request.merged_at // "") >= $since then "merged"
         elif (.closed_at // "") >= $since then "closed"
         else "activity" end)] | @tsv' || true)

mine_issue_section=""
while IFS=$'\t' read -r full num title ev; do
  case "$ev" in
    opened) icon="📝"; word="открыт" ;;
    closed) icon="🔴"; word="закрыт" ;;
    *) icon="💬"; word="активность" ;;
  esac
  mine_issue_section+=$'\n'"${icon} <a href=\"${WEB}/${full}/issues/${num}\">${full}#${num}</a> «$(esc "$title")» — ${word}"
done < <(curl -sfG "${auth[@]}" "$API/search/issues" \
  --data-urlencode "q=is:issue author:${OWNER} -user:${OWNER} updated:>=${SINCE_DATE}" \
  --data-urlencode 'per_page=100' --data-urlencode 'sort=updated' \
  | jq -r --arg since "$SINCE_TS" '
      .items[] | [(.repository_url | sub("^https://api\\.github\\.com/repos/"; "")), .number, .title,
        (if .created_at >= $since then "opened"
         elif (.closed_at // "") >= $since then "closed"
         else "activity" end)] | @tsv' || true)

# ----------------------------------------------------------------- compose ----
section() { # $1 = heading, $2 = body lines
  [ -n "$2" ] || return 0
  MSG+=$'\n\n'"$1"$'\n'"$2"
}

MSG="📊 <b>GitHub · сводка недели</b> ${SINCE_DATE} → ${TODAY}
⭐ всего звёзд: ${TOTAL_STARS} · репо: ${#REPOS[@]}"
[ "$new_stars_total" -gt 0 ] && MSG+=$'\n'"⭐ новых за неделю: ${new_stars_total}"

section "⭐ <b>Новые звёзды</b>" "$stars_section"
section "🍴 <b>Новые форки</b>" "$forks_section"
section "🐛 <b>Issues в моих репо</b>" "$issues_section"
section "💬 <b>Комменты в моих репо</b>" "$comments_section"
section "🔀 <b>Входящие PR</b>" "$incoming_section"
section "🧑‍💻 <b>Мои PR в чужих репо</b>" "$mine_pr_section"
section "📝 <b>Мои issues в чужих репо</b>" "$mine_issue_section"

if [ -z "$stars_section$forks_section$issues_section$comments_section$incoming_section$mine_pr_section$mine_issue_section" ]; then
  MSG+=$'\n\n'"😴 Тихая неделя — событий не было."
fi

# -------------------------------------------------------------------- send ----
send_tg() {
  local text="$1" part
  if [ -z "${TG_BOT_TOKEN:-}" ] || [ -z "${TG_CHAT_ID:-}" ]; then
    echo "=== DRY RUN: TG_BOT_TOKEN/TG_CHAT_ID not set, message not sent ==="
    printf '%s\n' "$text"
    return 0
  fi
  while [ -n "$text" ]; do
    part="${text:0:3500}"
    if [ "${#text}" -gt 3500 ]; then part="${part%$'\n'*}"; fi
    text="${text:${#part}}"
    text="${text#$'\n'}"
    curl -sf "https://api.telegram.org/bot${TG_BOT_TOKEN}/sendMessage" \
      --data-urlencode "chat_id=${TG_CHAT_ID}" \
      --data-urlencode "text=${part}" \
      --data-urlencode "parse_mode=HTML" \
      --data-urlencode "link_preview_options={\"is_disabled\":true}" >/dev/null
  done
}

send_tg "$MSG"
