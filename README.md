
# Hi, I'm Mihail (0x3654)

<p align="center"><b><a href="#привет-я-михаил-0x3654">🇷🇺 Русская версия</a></b></p>

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="assets/octo-dark.gif">
    <img width="140" src="assets/octo-light.gif" alt="octocat typing">
  </picture>
</p>

📍 **Moscow → Tbilisi** | Business Analyst (1C/ERP) by day, macOS & infra tinkerer by night
Dropped an AirPod in coffee once. ☕🎧

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="assets/typing-dark.gif">
    <img width="540" src="assets/typing-light.gif" alt="typewriter: 16 фраз RU/EN — 1С, docker, реверс протоколов, коты, первая звезда">
  </picture>
</p>

<p align="center">
  <a href="https://github.com/0x3654/gisp"><img src="https://img.shields.io/badge/first_%E2%AD%90-25.05.2026-ff69b4?style=for-the-badge" alt="first star — gisp, 25.05.2026"></a>
  <a href="https://github.com/0x3654/v8dock"><img src="https://img.shields.io/github/stars/0x3654/v8dock?style=for-the-badge&label=v8dock" alt="v8dock stars (live)"></a>
  <img src="https://komarev.com/ghpvc/?username=0x3654&style=for-the-badge&color=ff69b4" alt="profile views">
</p>

<p align="center">
  <img src="assets/first-star-comic-en.png" width="640" alt="comic: a star arrives → for gisp → a gov registry → what a shame, 9 of 9 stars for 1C">
</p>

<h3 align="center">🌟 First star — and it's for 1C. What a shame. 🤦</h3>

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

### 📺 [lampa-plugins](https://github.com/0x3654/lampa-plugins)
Plugin pack for the [Lampa](https://lampa.mx) media player + the Go services behind it — deployed as a self-hosted player clone that configures itself from one URL.
- **Torrent Send** — copy/open magnet from the long-press menu, one-off releases straight into the auto-feed (→ Plex library)
- **top.js** — «Top» screens: TMDB trends × torrent charts (NNM-Club, RUTOR, Jackett) with quality/voice filters, junk filtering, dedup; Go backend (scratch image, multi-arch CI → ghcr)
- **plex-sync** — watch-state sync Lampa ↔ Plex account: OAuth PIN, QR activation, background re-sync; 348 films / 672 episodes imported on day one
- **t.js** — one-URL bootstrap: installs the plugins and applies settings on a fresh Lampa

### 📡 [nnm-rss](https://github.com/0x3654/nnm-rss)
Personal RSS feeds for NNM-Club (spun off from lampa-plugins).
- 4 feeds per profile: auto / sections / top-14, with dedup and quality-upgrade memory
- DHT .torrent resolver, release pages with posters and ratings (Кинопоиск/IMDb/TMDB/MAL), bcrypt auth

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

### 🎵 [Yandex Music notch player](https://github.com/0x3654/PulseSync-mod/tree/moro/dev121) — fork of [PulseSync-LLC/PulseSync-mod](https://github.com/PulseSync-LLC/PulseSync-mod)
Full player living in the MacBook notch. Branches: [dev119](https://github.com/0x3654/PulseSync-mod/tree/moro/dev119) · [dev120](https://github.com/0x3654/PulseSync-mod/tree/moro/dev120) · [dev121](https://github.com/0x3654/PulseSync-mod/tree/moro/dev121) (5.121.2, real port — not the upstream version spoof).
- capsule → hover panel: likes, shuffle/repeat, seek, volume wheel, search right in the notch
- native track menus, artist/track links, multi-display support
- macOS **and Windows**: one-command installers (curl / PowerShell), taskbar thumbnails, wasapi output
- e2e-tested via CDP; real-port branches for three client versions at once

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

## Latest Releases

<!-- latest-releases:start -->
- [**lazy1c** v0.0.2](https://github.com/0x3654/lazy1c/releases/tag/v0.0.2) — 2026-09-29
- [**chargesense** v1.0.2](https://github.com/0x3654/chargesense/releases/tag/v1.0.2) — 2026-09-22
- [**zai-cursor-limit** v1.0.2](https://github.com/0x3654/zai-cursor-limit/releases/tag/v1.0.2) — 2026-09-16
- [**better-osd** v3.7.0](https://github.com/0x3654/better-osd/releases/tag/v3.7.0) — 2026-09-14
- [**Nightfall** v1](https://github.com/0x3654/Nightfall/releases/tag/v1) — 2026-09-14
<!-- latest-releases:end -->

*auto-updated by a GitHub Action — the freshest tags land here on their own*

---

## Shipped

### 🍏 [better-osd](https://github.com/0x3654/better-osd) — v3.7.0
Classic volume/brightness OSD for macOS — fork of [zmlabs/better-osd](https://github.com/zmlabs/better-osd), 5 releases, Sparkle updates.
- keyboard backlight OSD (private CoreBrightness)
- DDC brightness for external monitors, real zero via gamma
- built-in display off with a hotkey (private SkyLight API)
- **merged upstream**: all four PRs (#16–#19) landed in [zmlabs/better-osd v3.3.0](https://github.com/zmlabs/better-osd/releases/tag/v3.3.0) 🎉

### 🌙 [Nightfall](https://github.com/0x3654/Nightfall) — v1
Dark mode sync macOS → Parallels Windows VMs — fork of [r-thomson/Nightfall](https://github.com/r-thomson/Nightfall) (upstream inactive), own releases.

### 🤖 [telegram](https://github.com/0x3654/telegram)
MTProto → REST API & MCP server for LLMs.

---

## Open Source

PRs & reports:
- [lazydocker#839](https://github.com/jesseduffield/lazydocker/pull/839) + [gocui#107](https://github.com/jesseduffield/gocui/pull/107) — selected-line contrast
- [better-osd #16](https://github.com/zmlabs/better-osd/pull/16), [#17](https://github.com/zmlabs/better-osd/pull/17), [#18](https://github.com/zmlabs/better-osd/pull/18), [#19](https://github.com/zmlabs/better-osd/pull/19) — clamshell/DDC, keyboard backlight, volume sound, modifiers · **merged** into upstream v3.3.0 🎉
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

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://github-readme-stats.vercel.app/api/top-langs/?username=0x3654&layout=compact&hide_border=true&langs_count=8&theme=dark">
    <img src="https://github-readme-stats.vercel.app/api/top-langs/?username=0x3654&layout=compact&hide_border=true&langs_count=8" alt="top languages">
  </picture>
</p>
<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://streak-stats.demolab.com?user=0x3654&hide_border=true&theme=dark">
    <img src="https://streak-stats.demolab.com?user=0x3654&hide_border=true" alt="streak stats">
  </picture>
</p>

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/0x3654/0x3654/snake-output/dist/snake_dark.gif">
    <img src="https://raw.githubusercontent.com/0x3654/0x3654/snake-output/dist/snake.gif" alt="snake eating contributions">
  </picture>
</p>

---

## Connect with Me

- [X (Twitter)](https://x.com/0x3654) — let's chat about DevOps, AI, or cats!

---

[↑ Back to top](#hi-im-mihail-0x3654)

---

# Привет, я Михаил (0x3654)

<p align="center"><b><a href="#hi-im-mihail-0x3654">🇬🇧 English version</a></b></p>

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="assets/octo-dark.gif">
    <img width="140" src="assets/octo-light.gif" alt="октакот печатает">
  </picture>
</p>

📍 **Москва → Тбилиси** | днём — бизнес-аналитик 1С/ERP, ночью — маковод и инфра-тинкерер
Однажды утопил AirPod в кофе. ☕🎧

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="assets/typing-dark.gif">
    <img width="540" src="assets/typing-light.gif" alt="печатная машинка: 16 фраз RU/EN — 1С, docker, реверс протоколов, коты, первая звезда">
  </picture>
</p>

<p align="center">
  <a href="https://github.com/0x3654/gisp"><img src="https://img.shields.io/badge/%D0%BF%D0%B5%D1%80%D0%B2%D0%B0%D1%8F_%E2%AD%90-25.05.2026-ff69b4?style=for-the-badge" alt="первая звезда — gisp, 25.05.2026"></a>
  <a href="https://github.com/0x3654/v8dock"><img src="https://img.shields.io/github/stars/0x3654/v8dock?style=for-the-badge&label=v8dock" alt="звёзды v8dock (живой счётчик)"></a>
  <img src="https://komarev.com/ghpvc/?username=0x3654&style=for-the-badge&color=ff69b4" alt="просмотры профиля">
</p>

<p align="center">
  <img src="assets/first-star-comic.png" width="640" alt="комикс: звезда прилетела → за gisp → реестр Минпромторга → какой позор, 9 из 9 звёзд за 1С">
</p>

<h3 align="center">🌟 Первая звезда — и та из-за 1С. Какой позор. 🤦</h3>

<p align="center">
  <a href="https://skillicons.dev">
    <img src="https://skillicons.dev/icons?i=py,bash,go,swift,fastapi,apple,ubuntu,debian,ansible,githubactions,git,docker,postgres,nginx,github,vim&perline=8" />
  </a>
</p>

---

## Текущие проекты

### 🚦 [zai-cursor-limit](https://github.com/0x3654/zai-cursor-limit)
Расширение Cursor/VSCode — светофор квот Z.ai GLM Coding Plan.
- статус-бар `[:] NN%` — большее из двух окон (5ч / неделя)
- пороги зелёный → жёлтый → красный, опциональный тинт тайтл-бара
- установка в один клик из GitHub Releases (CI-сборка vsix)

### 📺 [lampa-plugins](https://github.com/0x3654/lampa-plugins)
Пакет плагинов для плеера [Lampa](https://lampa.mx) + Go-сервисы — развёрнут как собственный клон плеера, настраивающийся одной ссылкой.
- **Torrent Send** — копировать/открыть магнет из меню долгого нажатия, разовые раздачи сразу в авто-ленту (→ библиотека Plex)
- **top.js** — экраны «Топ»: тренды TMDB × топы трекеров (NNM-Club, RUTOR, Jackett), фильтры качества/озвучки, отсев мусора, дедуп; Go-бэкенд (scratch-образ, multi-arch CI → ghcr)
- **plex-sync** — синк статуса просмотра Lampa ↔ аккаунт Plex: OAuth PIN, QR-активация, фоновая досинхронизация; 348 фильмов / 672 серии импортировано в первый день
- **t.js** — бутстрап одной ссылкой: ставит плагины и применяет настройки на чистой Lampa

### 📡 [nnm-rss](https://github.com/0x3654/nnm-rss)
Персональные RSS-ленты NNM-Club (выделен из lampa-plugins).
- 4 ленты на профиль: авто / разделы / топ-14, дедуп и память апгрейдов качества
- DHT-резолвер .torrent, страницы раздач с постерами и рейтингами (КП/IMDb/TMDB/MAL), bcrypt-аутентификация

### 🔍 [GISP](https://github.com/0x3654/gisp)
Чат-поиск по реестру промышленной продукции Минпромторга.
- гибридный поиск: строгие фильтры + семантический режим (RAG, эмбеддинги)
- ночной пайплайн данных: downloader → import → embeddings (Ansible/Semaphore, без cron в контейнерах)
- в комплекте интеграция с 1С:Предприятие 8.2 — внешняя обработка поверх API

### 🎮 [ChargeSense](https://github.com/0x3654/chargesense) — v1.0.0
Заряд DualSense в меню-баре macOS — и сам контроллер становится индикатором.
- реверс HID: output-отчёт 0x31 (BT, CRC32) / 0x02 (USB) по раскладке драйвера hid-playstation
- цветовые зоны подсветки, «дыхание» на зарядке, 5 player-LED как шкала заряда
- RU/EN-локализация, автозапуск, демо-режим с вибрацией; MIT, DMG-релиз через CI

### 🎵 [Нотч-плеер Яндекс Музыки](https://github.com/0x3654/PulseSync-mod/tree/moro/dev121) — форк [PulseSync-LLC/PulseSync-mod](https://github.com/PulseSync-LLC/PulseSync-mod)
Полноценный плеер в вырезе MacBook. Ветки: [dev119](https://github.com/0x3654/PulseSync-mod/tree/moro/dev119) · [dev120](https://github.com/0x3654/PulseSync-mod/tree/moro/dev120) · [dev121](https://github.com/0x3654/PulseSync-mod/tree/moro/dev121) (5.121.2, настоящий порт — не спуф версии апстрима).
- капсула → панель по ховеру: лайки, шаффл/повтор, перемотка, громкость колесом, поиск прямо в нотче
- родные меню трека, ссылки на артиста/трек, мульти-мониторы
- macOS **и Windows**: установка одной командой (curl / PowerShell), таскбар-превью, вывод wasapi
- e2e-тесты через CDP; реальные порты под три версии клиента сразу

### ⚙️ [lazy1c](https://github.com/0x3654/lazy1c) — v0.0.1
TUI-консоль администрирования кластеров 1С в духе lazygit.
- собственный транспорт протокола RAS — рабочих открытых реализаций не существовало
- реверс недокументированного MMC-протокола ragent (8.2 и 8.3): сеансы, terminate, опрос кластера 2300 мс → 232 мс (10×)
- установка одной командой (curl / PowerShell), бинарники macOS/Linux/Windows через CI

### 🧰 [v8dock](https://github.com/0x3654/v8dock)
Дев-стек 1С в Docker на Apple Silicon.
- PostgreSQL 18.4-1.1C (нативный arm64, тюнинг по Приложению K Postgres Pro) + кластеры 8.3/8.5, полигон 8.2 в `dev/82`
- автоматизация комьюнити-лицензий через штатный API платформы (легальный аналог платной обработки)
- базовые образы на Docker Hub, `bootstrap.sh` одной командой

### 🖥️ [ansible](https://github.com/0x3654/ansible)
Всё как код: 4 VPS + homelab (26 ТБ, ~20 контейнеров) + 2 мака + роутер.
- Semaphore CI + GitHub Actions: пуш → авто-деплой по ролям
- ночной rsync-синк маков с гвардиями диска и Telegram-отчётами
- VPN-стек (Xray/Reality, AmneziaWG), frp-туннель через CGNAT, Beszel + Watchtower

### 📱 [untilwall](https://github.com/0x3654/untilwall)
Автообновляемые обои-календарь для локскрина телефонов и планшетов.

---

## Последние релизы

<!-- latest-releases:start -->
- [**lazy1c** v0.0.2](https://github.com/0x3654/lazy1c/releases/tag/v0.0.2) — 2026-09-29
- [**chargesense** v1.0.2](https://github.com/0x3654/chargesense/releases/tag/v1.0.2) — 2026-09-22
- [**zai-cursor-limit** v1.0.2](https://github.com/0x3654/zai-cursor-limit/releases/tag/v1.0.2) — 2026-09-16
- [**better-osd** v3.7.0](https://github.com/0x3654/better-osd/releases/tag/v3.7.0) — 2026-09-14
- [**Nightfall** v1](https://github.com/0x3654/Nightfall/releases/tag/v1) — 2026-09-14
<!-- latest-releases:end -->

*блок обновляется автоматически GitHub Action'ом*

---

## В работе *(ссылки — после публикации)*

### 📮 social-poster *(закрытая бета)*
Пайплайн постинга в X из Telegram: черновик → карточка-превью → пост → метрики, отложенные и дайджесты (Bot API, контейнер, 33 теста).

### 🪟 md-preview-fix
Фикс Cursor/VSCode: markdown-превью угоняет вкладку чата — первопричина найдена в логике placement апстрим-previewManager; запакован VSIX с патчем.

---

## Выпущено

### 🍏 [better-osd](https://github.com/0x3654/better-osd) — v3.7.0
Классический OSD громкости/яркости для macOS — форк [zmlabs/better-osd](https://github.com/zmlabs/better-osd), 5 релизов, Sparkle-обновления.
- OSD подсветки клавиатуры (приватный CoreBrightness)
- DDC-яркость внешних мониторов, настоящий ноль через гамму
- выключение встроенного дисплея по хоткею (приватный SkyLight API)
- **влито в апстрим**: все четыре PR (#16–#19) вошли в [zmlabs/better-osd v3.3.0](https://github.com/zmlabs/better-osd/releases/tag/v3.3.0) 🎉

### 🌙 [Nightfall](https://github.com/0x3654/Nightfall) — v1
Синк тёмной темы macOS → Windows-VM Parallels — форк [r-thomson/Nightfall](https://github.com/r-thomson/Nightfall) (апстрим неактивен), свои релизы.

### 🤖 [telegram](https://github.com/0x3654/telegram)
MTProto → REST API и MCP-сервер для LLM.

---

## Опенсорс

PR и репорты:
- [lazydocker#839](https://github.com/jesseduffield/lazydocker/pull/839) + [gocui#107](https://github.com/jesseduffield/gocui/pull/107) — читаемость выбранной строки
- [better-osd #16](https://github.com/zmlabs/better-osd/pull/16), [#17](https://github.com/zmlabs/better-osd/pull/17), [#18](https://github.com/zmlabs/better-osd/pull/18), [#19](https://github.com/zmlabs/better-osd/pull/19) — clamshell/DDC, подсветка клавиатуры, звук громкости, модификаторы · **влито** в апстрим v3.3.0 🎉
- [PulseSync-mod #22](https://github.com/PulseSync-LLC/PulseSync-mod/pull/22), [#24](https://github.com/PulseSync-LLC/PulseSync-mod/pull/24) — мод Яндекс Музыки, фиксы macOS (закрыты апстримом; живёт в форке)
- [tailscale#17089](https://github.com/tailscale/tailscale/issues/17089) — клон личности Mac: диагностика + воркаэраунд

Реверс-инжиниринг для удовольствия: недокументированные протоколы кластеров 1С (RAS/MMC), веб-логин Huawei ONT, X GraphQL.

---

## Копаю сейчас

- 🔧 DevOps и CI/CD — автоматизация всего, что движется
- 🤖 AI-агенты и MCP-серверы
- 📦 Инфраструктура как код

---

## Факты

- ☕🎧 Утопил AirPod в кофе. Один раз.
- 🐈 Коты — мои парные программисты: код-ревью проходят во сне

---

## Философия

> «Невозможно — это временно»! 😅

---

## Статистика GitHub

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://github-readme-stats.vercel.app/api/top-langs/?username=0x3654&layout=compact&hide_border=true&langs_count=8&theme=dark">
    <img src="https://github-readme-stats.vercel.app/api/top-langs/?username=0x3654&layout=compact&hide_border=true&langs_count=8" alt="языки">
  </picture>
</p>
<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://streak-stats.demolab.com?user=0x3654&hide_border=true&theme=dark">
    <img src="https://streak-stats.demolab.com?user=0x3654&hide_border=true" alt="серия дней">
  </picture>
</p>

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/0x3654/0x3654/snake-output/dist/snake_dark.gif">
    <img src="https://raw.githubusercontent.com/0x3654/0x3654/snake-output/dist/snake.gif" alt="змейка поедает контрибуции">
  </picture>
</p>

---

## Связь

- [X (Twitter)](https://x.com/0x3654) — поговорим про DevOps, ИИ или котов!

---

[↑ К началу](#привет-я-михаил-0x3654)

