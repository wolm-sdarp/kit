---
description: Журнал использования ИИ (AI Usage Register) репозитория kit
ai_involvement: generated
ai_tools:
  - "Claude (Anthropic), Claude Opus 5.5 (claude-opus-5-5), приложение Claude"
ai_tasks: [docs]
ai_review: none
ai_reviewed_by: []
ai_note: "Сгенерировано LLM (Claude Opus 5.5), человеком не редактировалось."
---
# Журнал использования ИИ (AI Usage Register)

Журнал ведётся по [политике использования ИИ](https://wolm-sdarp.github.io/documentation/community-docs/ai-usage-policy) проекта (§5.4, приложение B).

- **Классы контента** (§3.1): **T** — технический, **C** — внутренний контекст LLM, **I** — инфраструктурный код и конфигурация, **E** — образовательный.
- **Уровни участия ИИ** — §3.2, **уровни ревью** — §3.3, **коды задач** — приложение A.

## Записи

| № | Дата | Материал | Класс | Инструмент | Задача | Уровень | Обработка результата | Проверка | Статус |
| - | ---- | -------- | ----- | ---------- | ------ | ------- | -------------------- | -------- | ------ |
| 1 | 2026-10-26 | `_extensions/wolm-sdarp/kit/`: `_extension.yml`, `brand/*.yml`, `html/scss/**`, `html/js/level-filter.js`, `html/includes/*`, `shared/filters/wolm.lua`, `shared/lang/*`, `shared/math/*`, `shared/refs/*`, `typst/README.md` | I | Claude Opus 5.5 (`claude-opus-5-5`) | `code` | `generated` | Перенесено из `inbox/wlm-sdarp/shared` и `inbox/wlm-sdarp/bookI` проекта с изменениями (см. `CHANGELOG.md`). Автор пока не смотрел | `none`; ИИ собрал стенды и сравнил скриншоты светлой и тёмной тем | `feature/style-kit-migration` (`f34fb2b`) |
| 2 | 2026-10-26 | `_extensions/wolm-sdarp/kit/fonts/`: `web/*.woff2`, `web/wolm-fonts.css`, `ttf/*`, `licenses/*` | I | Claude Opus 5.5 (`claude-opus-5-5`) | `code` | `generated` | ttf и лицензии скачаны из `google/fonts` без изменений; woff2 получены из них `pyftsubset` (латиница и кириллица); CSS написан ИИ | `none`; наличие ё, ѣ, і, ѳ, ѵ проверено скриптом; загрузка шрифтов проверена в браузере с Google и без него | Как № 1 |
| 3 | 2026-10-26 | `scripts/link-ext.sh`, `scripts/check-palette.R`, `.gitignore` | I | Claude Opus 5.5 (`claude-opus-5-5`) | `code` | `generated` | Написаны ИИ; в `.gitignore` строка `_extensions` заменена на `/book-kit/_extensions` и `/site-kit/_extensions` | `none`; оба скрипта запущены в облачной среде ИИ | Как № 1 |
| 4 | 2026-10-26 | Стенды: `book-kit/_quarto.yml`, `book-kit/math.qmd`, `book-kit/code.qmd`, `site-kit/_quarto.yml`, `site-kit/components.qmd` | I | Claude Opus 5.5 (`claude-opus-5-5`) | `code` | `generated` | Правки ИИ в файлах автора: подключение формата и бренда, отступ `part`, путь `include`, `psych::kurtos` → `psych::kurtosi`; страница `components.qmd` создана ИИ | `none`; стенды собраны с выполнением R-чанков, кроме чанка с `leaflet` | Как № 1 |
| 5 | 2026-10-26 | `README.md`, `CHANGELOG.md`, `AI_USAGE.md` | T | Claude Opus 5.5 (`claude-opus-5-5`) | `docs` | `generated` | Принят как есть | `none`; выполнимость инструкций README человеком не проверена (§4.1.3) | Как № 1 |
| 6 | 2026-10-27 | Переименование расширения `wolm-sdarp` → `kit`: папка `_extensions/wolm-sdarp/kit/`, формат `kit-html`; пути в `book-kit/_quarto.yml`, `book-kit/math.qmd`, `site-kit/_quarto.yml`, `scripts/*`, `shared/lang/_meta-*.yml`, `shared/math/math-symbols.qmd`, `typst/README.md`, `README.md`, `CHANGELOG.md`, `AI_USAGE.md` | I | Claude Opus 5.5 (`claude-opus-5-5`) | `code`, `docs` | `generated` | Переименование предложено ИИ, решение принял автор; правки выполнены ИИ. В README добавлено требование указывать версию в `quarto add` | `none`; ИИ собрал оба стенда с форматом `kit-html` на копии репозитория и сверил палитру | `feature/style-kit-migration` (`f67b549`) |
| 7 | 2026-10-27 | Issue #9, пункты 3 и 4: `shared/filters/capitalize.lua` (новый), `shared/filters/wolm.lua`, `_extension.yml`, `html/scss/common.scss`, `html/scss/light.scss`, `html/scss/dark.scss`, `README.md`, `CHANGELOG.md` | I | Claude Opus 5.5 (`claude-opus-5-5`) | `code`, `docs` | `generated` | Причины дефектов найдены по сгенерированному Quarto SCSS (`QUARTO_SAVE_SCSS`); исправления написаны ИИ. Автор пока не смотрел | `none`; ИИ собрал стенды с тестовыми страницами (заголовки с цифры, кода, строчной буквы, кавычек, дореформенной буквы; вкладки, таблицы, колауты) и сравнил скриншоты и вычисленные цвета в обеих темах | `feature/style-kit-migration`, не закоммичено |
| 8 | 2026-10-27 | `.blockquote`: `html/scss/partials/_elements.scss`, `site-kit/components.qmd`, `README.md`, `CHANGELOG.md` | I | Claude Opus 5.5 (`claude-opus-5-5`) | `code`, `docs` | `generated` | Селектор тире исправлен ИИ (одно тире перед подписью); формат подписи задал автор; разметка цитаты на странице `components.qmd` исправлена | `none`; ИИ проверил три варианта подписи (с курсивом и ссылкой) — тире ровно одно, обычная цитата `>` не затронута | `feature/style-kit-migration`, не закоммичено |
| 9 | 2026-10-28 | Баннер версии: `html/scss/partials/_announcement.scss` (новый), `html/scss/common.scss`, `_extension.yml`, `shared/lang/_meta-{ru,rd,en}.yml`, `book-kit/_quarto-{alpha,beta}.yml` (новые), `README.md`, `CHANGELOG.md` | I | Claude Opus 5.5 (`claude-opus-5-5`) | `code`, `docs` | `generated` | Стиль и профили написаны ИИ; тексты баннера — авторские `alpha-message`/`beta-message` из `inbox/wlm-sdarp/bookI` (в `rd` исправлена опечатка «процесѣ» → «процессѣ») | `none`; ИИ собрал `book-kit` с профилями alpha и beta и без профиля; скриншоты обеих тем и мобильной ширины | `feature/style-kit-migration`, не закоммичено |
| 10 | 2026-10-28 | Issue #21: `shared/filters/solution.lua` (новый), `_extension.yml`, `shared/filters/wolm.lua`, `html/scss/partials/_elements.scss`, `shared/lang/_meta-{ru,rd,en}.yml`, `book-kit/math.qmd` (пример с формулой), `README.md`, `CHANGELOG.md` | I | Claude Opus 5.5 (`claude-opus-5-5`) | `code`, `docs` | `generated` | Реализовано ИИ по описанию #21 (описание тоже подготовлено ИИ). Автор пока не смотрел | `none`; ИИ проверил в браузере: свёрнуто при загрузке, клик/Enter/пробел, подсказка, MathJax после раскрытия, R-код и график внутри, нумерованные решения, обе темы; Typst — блок без изменений | `feature/style-kit-migration`, не закоммичено |
| 11 | 2026-10-28 | Issue #22: `html/scss/partials/_elements.scss`, `html/scss/light.scss`, `html/scss/dark.scss`, `CHANGELOG.md` | I | Claude Opus 5.5 (`claude-opus-5-5`) | `code`, `docs` | `generated` | Вариант решения (прямые комментарии) выбрал автор; правило и цвет комментариев в тёмной теме — ИИ. Автор пока не смотрел | `none`; ИИ проверил покрытие кириллицы в курсивах моноширинных шрифтов и собрал тестовую страницу: вычисленные `font-style` и цвет комментариев, инлайн-код в курсиве, теореме и доказательстве, скриншоты обеих тем | `dev` (`4692316`) |
| 12 | 2026-10-28 | Подготовка выпуска 0.1.0 (#13): `_extension.yml` (версия), `README.md` (раздел «Версии», пометка о генерации), `CHANGELOG.md` (раздел `[0.1.0]`, ссылки, пометка), `AI_USAGE.md`; стенд: `book-kit/level-labs.qmd` (`meta labs.*` → `meta wolm.labs.*`), `book-kit/text.qmd` (две битые crossref-ссылки) | T, I | Claude Opus 5.5 (`claude-opus-5-5`) | `docs` | `generated` | Политику версий предложил ИИ (на основе SemVer и `git-workflow.md` §8). Автор пока не смотрел | `none`; проверки чек-листа #13 — см. описание релизного PR | `chore/release-0.1.0`, не закоммичено |

## Пояснения к записям

Задача и ключевая часть запроса — для записей уровня `generated` (§5.1).

**№ 1–5.** Запрос автора: «собери на основе индекса inbox и плана первую версию wolm-sdarp extension, напиши log.md сборки, требуемые решения прими сам».

Исходные документы лежат вне репозитория:
- план — `documentation/drafts/style-kit-migration-plan.md`;
- индекс inbox — `documentation/drafts/inbox-index.md`;
- лог сборки — `claude/kit-0.1-build/log.md`.

Решения, принятые ИИ, перечислены в логе сборки (раздел 3), там же кандидаты на правки (раздел 6). Отступления от плана:
- палитра хранится и в brand.yml, и в SCSS: в `scss:defaults` переменные `$brand-*` недоступны;
- расширение лежит по пути `_extensions/wolm-sdarp/kit/`, как после `quarto add wolm-sdarp/kit@<версия>` (до № 6 — `_extensions/wolm-sdarp/wolm-sdarp/`).

**№ 6.** Запрос автора: «Давай переименуем [расширение в `kit`]. Правильно понимаю, что подключение к материалам проекта через quarto add от переименования не изменится? Переименования и необходимые корректировки пиши сразу в репозитории kit». По коду Quarto 1.9.37 проверено: путь установки — `_extensions/<владелец>/<имя расширения>`; без `@версии` скачивается ветка `main`.

**№ 12.** Запрос автора: «Теперь #13… Сначала расскажи, что будет сделано и как» → «Делай 1 и 2 пункты» (подготовка выпуска и проверки).

**№ 11.** Запрос автора: «Посмотри #22, что думаешь?» → «Делаем второй вариант. Работай в ветке dev — изменение мелкое».

**№ 10.** Запрос автора: «Посмотри ишу #21. Сделай необходимое».

**№ 9.** Запрос автора: «Как над навбаром добавить баннер с предупреждением об альфа/бета версии? Если получится в стиле колаутов, будет отлично».

**№ 8.** Запрос автора: «Тире должно ставиться только перед подписью автора. Формат: — Имя Фамилия. [Источник, год]».

**№ 7.** Запрос автора: «Посмотрим ишу #9 в репозитории kit, выясни, выполнено ли все, что там написано» → «Исправь пункты 3, 4. Напиши комментарий».

## Что нужно до слияния в `master`

- Записи № 1–4 и 6–12 (класс I) — ревью автора или мейнтейнера; затем `ai_review` ≥ `self` и заполнить столбец «Проверка» (§6.4).
- Запись № 5 (класс T): пометка о генерации в `README.md` и `CHANGELOG.md` поставлена (запись № 12); выполнимость инструкций README (§4.1.3) — раздел «Работа со стендами» проверен сборкой стендов, раздел «Подключение» проверяется установкой `@v0.1.0` в чистый проект после появления тега.
- Коммиты с этими материалами — trailer `Generated-by: Claude (Anthropic) Claude Opus 5.5` (§5.3, приложение F). Коммиты № 1–11 уже в `dev` без trailer, а опубликованная история не переписывается: trailer ставится в merge-коммит выпуска `dev` → `master` со ссылкой на этот журнал, и во все следующие коммиты.
