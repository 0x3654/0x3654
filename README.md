# Hi, I'm Mihail (0x3654)

📍 **Moscow → Tbilisi** | Business Analyst (1C/ERP) by day, macOS & infra tinkerer by night
Dropped an AirPod in coffee once. ☕🎧

<p align="center">
  <a href="https://skillicons.dev">
    <img src="https://skillicons.dev/icons?i=py,bash,go,swift,fastapi,apple,ubuntu,debian,ansible,githubactions,git,docker,postgres,nginx,github,vim&perline=8" />
  </a>
</p>

---

## Current Projects

### 🚦 [zai-cursor-limit](https://github.com/0x3654/zai-cursor-limit)
Cursor/VSCode extension — Z.ai GLM Coding Plan quota traffic light.
- status bar `[:] NN%` for the bigger of the two windows (5h / weekly)
- green → yellow → red thresholds, optional title bar tint
- one-click install from GitHub Releases (CI-built vsix)

### 📺 lampa-plugins *(repo transmission-send, rename pending)*
Plugin pack for the [Lampa](https://lampa.mx) media player + the Go services behind it.
- **transmission-send.js** — copy/open magnet from the long-press menu
- **top.js** — «Top» screens: TMDB trends × torrent charts (NNM-Club, RUTOR) with quality/voice filters, junk filtering, dedup
- **t.js** — one-URL bootstrap: installs the plugins and applies settings on a fresh Lampa
- **tracker-top** (Go) — backend for the tops, scratch image 13.6 MB, multi-arch CI → ghcr
- **nnm-rss** (Go) — personal RSS feeds for NNM-Club, DHT .torrent resolver, ratings in cards

### 🔍 [GISP](https://github.com/0x3654/gisp)
Chat-style search over the Russian Ministry of Industry product register.
- hybrid search: strict filters + semantic mode (RAG, embeddings)
- nightly data pipeline: downloader → import → embeddings (Ansible/Semaphore, no in-container cron)
- ships with a 1C:Enterprise 8.2 integration — external data processor calling the API

### 🎮 [ChargeSense](https://github.com/0x3654/chargesense) — v1.0.0
DualSense battery in the macOS menu bar — and the controller itself becomes the indicator.
- HID reverse engineering: output report 0x31 (BT, CRC32) / 0x02 (USB) per the Linux hid-playstation driver
- lightbar color zones, breathing while charging, 5 player-LEDs as a charge gauge
- RU/EN localization, launch at login, demo mode with rumble; MIT, DMG release via CI

### 🎵 [Yandex Music notch player](https://github.com/0x3654/PulseSync-mod/tree/moro/dev120) — fork of [PulseSync-LLC/PulseSync-mod](https://github.com/PulseSync-LLC/PulseSync-mod)
Full player living in the MacBook notch. Branches: [dev119](https://github.com/0x3654/PulseSync-mod/tree/moro/dev119) · [dev120](https://github.com/0x3654/PulseSync-mod/tree/moro/dev120).
- capsule → hover panel: likes, shuffle/repeat, seek, volume wheel, search right in the notch
- native track menus, artist/track links, multi-display support
- one-curl installer with backup/uninstall; e2e-tested via CDP

### ⚙️ [lazy1c](https://github.com/0x3654/lazy1c) — v0.0.1
A lazygit-style TUI for 1C:Enterprise cluster administration.
- own transport for the RAS protocol — no working open implementation existed
- reverse-engineered the undocumented MMC protocol of ragent (8.2 and 8.3): sessions, terminate, cluster polling 2300 ms → 232 ms (10×)
- one-command install (curl / PowerShell), binaries for macOS/Linux/Windows via CI

### 🧰 [v8dock](https://github.com/0x3654/v8dock)
1C:Enterprise dev stack in Docker on Apple Silicon.
- PostgreSQL 18.4-1.1C (native arm64, tuned per Postgres Pro appendix) + 8.3/8.5 clusters, 8.2-era playground in `dev/82`
- community-license automation through the native platform API (a legal equivalent of a paid tool)
- base images on Docker Hub, `bootstrap.sh` one-liner

### 🖥️ [ansible](https://github.com/0x3654/ansible)
Everything as code: 4 VPS + homelab (26 TB, ~20 containers) + 2 Macs + router.
- Semaphore CI + GitHub Actions: push → auto-deploy by role
- nightly Mac-to-Mac rsync sync with disk guards and Telegram reports
- VPN stack (Xray/Reality, AmneziaWG), frp tunnel through CGNAT, Beszel + Watchtower

### 📱 [untilwall](https://github.com/0x3654/untilwall)
Auto-updating calendar lock screen wallpaper for phones and tablets.

---

## On the Workbench *(links pending — repos not public yet)*

### 📮 social-poster *(closed beta)*
Telegram-driven X posting pipeline: draft → preview card → post → metrics, with scheduling and digests (Bot API, containerized, 33 tests).

### 🪟 md-preview-fix
Cursor/VSCode fix for the markdown preview hijacking the chat tab — root cause traced in the upstream previewManager placement logic; packaged VSIX with the patch.

---

## Shipped

### 🍏 [better-osd](https://github.com/0x3654/better-osd) — v3.7.0
Classic volume/brightness OSD for macOS — fork of [zmlabs/better-osd](https://github.com/zmlabs/better-osd), 5 releases, Sparkle updates.
- keyboard backlight OSD (private CoreBrightness)
- DDC brightness for external monitors, real zero via gamma
- built-in display off with a hotkey (private SkyLight API)
- changes proposed upstream: PRs #16–#19 (see Open Source below)

### 🌙 [Nightfall](https://github.com/0x3654/Nightfall) — v1
Dark mode sync macOS → Parallels Windows VMs — fork of [r-thomson/Nightfall](https://github.com/r-thomson/Nightfall) (upstream inactive), own releases.

### 🤖 [telegram](https://github.com/0x3654/telegram)
MTProto → REST API & MCP server for LLMs.

---

## Open Source

PRs & reports:
- [lazydocker#839](https://github.com/jesseduffield/lazydocker/pull/839) + [gocui#107](https://github.com/jesseduffield/gocui/pull/107) — selected-line contrast
- [better-osd #16](https://github.com/zmlabs/better-osd/pull/16), [#17](https://github.com/zmlabs/better-osd/pull/17), [#18](https://github.com/zmlabs/better-osd/pull/18), [#19](https://github.com/zmlabs/better-osd/pull/19) — clamshell/DDC, keyboard backlight, volume sound, modifiers
- [PulseSync-mod #22](https://github.com/PulseSync-LLC/PulseSync-mod/pull/22), [#24](https://github.com/PulseSync-LLC/PulseSync-mod/pull/24) — Yandex Music mod, macOS fixes (closed upstream; lives on in the fork)
- [tailscale#17089](https://github.com/tailscale/tailscale/issues/17089) — cloned Mac identity: diagnosis + workaround

Reverse engineering for fun: undocumented 1C cluster protocols (RAS/MMC), Huawei ONT web login, X GraphQL.

---

## Currently Exploring

- 🔧 DevOps & CI/CD pipelines — automating everything that moves
- 🤖 AI agents and MCP servers
- 📦 Infrastructure as code

---

## Fun Facts

- ☕🎧 Dropped an AirPod in coffee. Once.
- 🐈 Cats are my pair programmers — they mostly sleep through the code reviews

---

## Philosophy

> "Impossible is temporary"! 😅

---

## GitHub Stats

![GitHub Contribution Graph](https://ghchart.rshah.org/0x3654)

---

## Connect with Me

- [X (Twitter)](https://x.com/0x3654) — let's chat about DevOps, AI, or cats!

---

[↑ Back to top](#hi-im-mihail-0x3654)
