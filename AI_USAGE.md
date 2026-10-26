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
| 1 | 2026-10-26 | `_extensions/wolm-sdarp/wolm-sdarp/`: `_extension.yml`, `brand/*.yml`, `html/scss/**`, `html/js/level-filter.js`, `html/includes/*`, `shared/filters/wolm.lua`, `shared/lang/*`, `shared/math/*`, `shared/refs/*`, `typst/README.md` | I | Claude Opus 5.5 (`claude-opus-5-5`) | `code` | `generated` | Перенесено из `inbox/wlm-sdarp/shared` и `inbox/wlm-sdarp/bookI` проекта с изменениями (см. `CHANGELOG.md`). Автор пока не смотрел | `none`; ИИ собрал стенды и сравнил скриншоты светлой и тёмной тем | Архив `kit-0.1.0-dev.zip`; после распаковки — `feature/style-kit-migration` |
| 2 | 2026-10-26 | `_extensions/wolm-sdarp/wolm-sdarp/fonts/`: `web/*.woff2`, `web/wolm-fonts.css`, `ttf/*`, `licenses/*` | I | Claude Opus 5.5 (`claude-opus-5-5`) | `code` | `generated` | ttf и лицензии скачаны из `google/fonts` без изменений; woff2 получены из них `pyftsubset` (латиница и кириллица); CSS написан ИИ | `none`; наличие ё, ѣ, і, ѳ, ѵ проверено скриптом; загрузка шрифтов проверена в браузере с Google и без него | Как № 1 |
| 3 | 2026-10-26 | `scripts/link-ext.sh`, `scripts/check-palette.R`, `.gitignore` | I | Claude Opus 5.5 (`claude-opus-5-5`) | `code` | `generated` | Написаны ИИ; в `.gitignore` строка `_extensions` заменена на `/book-kit/_extensions` и `/site-kit/_extensions` | `none`; оба скрипта запущены в облачной среде ИИ | Как № 1 |
| 4 | 2026-10-26 | Стенды: `book-kit/_quarto.yml`, `book-kit/math.qmd`, `book-kit/code.qmd`, `site-kit/_quarto.yml`, `site-kit/components.qmd` | I | Claude Opus 5.5 (`claude-opus-5-5`) | `code` | `generated` | Правки ИИ в файлах автора: подключение формата и бренда, отступ `part`, путь `include`, `psych::kurtos` → `psych::kurtosi`; страница `components.qmd` создана ИИ | `none`; стенды собраны с выполнением R-чанков, кроме чанка с `leaflet` | Как № 1 |
| 5 | 2026-10-26 | `README.md`, `CHANGELOG.md`, `AI_USAGE.md` | T | Claude Opus 5.5 (`claude-opus-5-5`) | `docs` | `generated` | Принят как есть | `none`; выполнимость инструкций README человеком не проверена (§4.1.3) | Как № 1 |

## Пояснения к записям

Задача и ключевая часть запроса — для записей уровня `generated` (§5.1).

**№ 1–5.** Запрос автора: «собери на основе индекса inbox и плана первую версию wolm-sdarp extension, напиши log.md сборки, требуемые решения прими сам».

Исходные документы лежат вне репозитория:
- план — `documentation/drafts/style-kit-migration-plan.md`;
- индекс inbox — `documentation/drafts/inbox-index.md`;
- лог сборки — `claude/kit-0.1-build/log.md`.

Решения, принятые ИИ, перечислены в логе сборки (раздел 3), там же кандидаты на правки (раздел 6). Отступления от плана:
- палитра хранится и в brand.yml, и в SCSS: в `scss:defaults` переменные `$brand-*` недоступны;
- расширение лежит по пути `_extensions/wolm-sdarp/wolm-sdarp/`, как после `quarto add wolm-sdarp/kit`.

## Что нужно до слияния в `master`

- Записи № 1–4 (класс I) — ревью автора или мейнтейнера; затем `ai_review` ≥ `self` и заполнить столбец «Проверка» (§6.4).
- Запись № 5 (класс T) — пометка о генерации в `README.md` и `CHANGELOG.md` (§4.1.1); проверить выполнимость инструкций README (§4.1.3).
- Коммиты с этими материалами — trailer `Generated-by: Claude (Anthropic) Claude Opus 5.5` (§5.3, приложение F).
