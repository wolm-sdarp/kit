# WoLM SDARP Style Kit

Стилевой комплект проекта WoLM SDARP в виде Quarto extension `wolm-sdarp`. Плюс два тестовых стенда: книга `book-kit` и сайт `site-kit`.

> Quarto: **≥ 1.9.37** (проверено на 1.9.37).
> Статус: `0.1.0-dev`, только HTML. Typst зарезервирован (`_extensions/wolm-sdarp/wolm-sdarp/typst/README.md`).

## Подключение к книге или сайту

```bash
quarto add wolm-sdarp/kit            # позже — с тегом: wolm-sdarp/kit@v0.1.0
```

Расширение установится в `_extensions/wolm-sdarp/wolm-sdarp/`: Quarto кладёт расширения из GitHub в `_extensions/<владелец>/<имя>`. В `_quarto.yml` проекта:

```yaml
# Бренд подключается здесь: в проектах-книгах Quarto 1.9.37 не применяет бренд из расширения
brand:
  light: _extensions/wolm-sdarp/wolm-sdarp/brand/light.yml
  dark: _extensions/wolm-sdarp/wolm-sdarp/brand/dark.yml

# Язык интерфейса и тексты kit (ru | rd)
language: _extensions/wolm-sdarp/wolm-sdarp/shared/lang/_lang-ru.yml
metadata-files:
  - _extensions/wolm-sdarp/wolm-sdarp/shared/lang/_meta-ru.yml

format:
  wolm-sdarp-html: default
```

Общие LaTeX-макросы для формул подключаются в главе:

```markdown
{{< include /_extensions/wolm-sdarp/wolm-sdarp/shared/math/math-symbols.qmd >}}
```

Обновление: `quarto update wolm-sdarp/kit`.

## Что даёт формат `wolm-sdarp-html`

- Светлая и тёмная темы (палитра, серые, навбар, колауты, лейблы уровней).
- Шрифты: Montserrat (заголовки), Open Sans (текст), Source Code Pro (код).
- Кастомные колауты и crossref-типы, лейблы уровней, фильтр разделов по уровням.
- APA CSL, фикс толщины скобок в MathJax.
- Значения по умолчанию: `toc: true`, `toc-depth: 4`, `lightbox: true`, сетка страницы (`grid`).

### Настройки (метаданные `wolm`)

| Ключ | По умолчанию | Что делает |
|---|---|---|
| `wolm.fonts` | `google` | `google` — шрифты из Google Fonts, локальная копия как запасной вариант; `local` — только локальная копия, без запросов к Google |
| `wolm.level-filter` | `false` | `true` — кнопки фильтра разделов по уровням под заголовком страницы |
| `wolm.labs.<уровень>` | `Novice` … `Expert` | Текст лейбла уровня (`_meta-rd.yml` — дореформенные названия) |
| `wolm.strings.solution-toggle` | `Управляшка` | Подпись у свёрнутого решения (`.solution.folded`) |
| `wolm.strings.level-filter-label` | `Filter sections by level` | `aria-label` группы кнопок фильтра |

### Классы и блоки (контракт)

Этим списком пользуются авторы книг, и его же позже реализует формат Typst.

| Разметка | Результат |
|---|---|
| `## Заголовок {.lab-novice}` (`junior`, `middle`, `senior`, `expert`) | Лейбл уровня под заголовком h2–h3 |
| `:::{.callout-note .objectives}` | Колаут «цели» (также `.outcomes`, `.history`, `.person`, `.dataset`, `.myth`, `.case`) |
| `:::{.callout-none}` | Нейтральный колаут |
| `#mth-`, `#hst-`, `#prs-`, `#dts-`, `#cse-`, `#sch-`, `#vid-` | Нумеруемые кастомные float-блоки (миф, история, персона, датасет, кейс, схема, видео) |
| `::::{.intro}` | Введение к главе |
| `:::{.blockquote}` | Цитата с подписью |
| `.proof .solution .folded` | Свёрнутое решение с подписью `wolm.strings.solution-toggle` |
| `#thm-`, `#lem-`, `.proof` … | Теоремы и доказательства в рамке |

## Устройство расширения

```
_extensions/wolm-sdarp/wolm-sdarp/
├── _extension.yml        # формат wolm-sdarp-html (common + html), заготовка typst
├── brand/                # light.yml, dark.yml — палитра, фон/текст, шрифты (для HTML и Typst)
├── html/
│   ├── scss/             # light.scss, dark.scss — переменные тем; common.scss — общее
│   │   └── partials/     # только правила: labels, elements, callouts, level-filter
│   ├── includes/         # brackets-thickness-fix.html
│   └── js/               # level-filter.js
├── shared/
│   ├── filters/wolm.lua  # шрифты, CSS-переменные с текстами, фильтр уровней
│   ├── lang/             # _lang-ru/rd.yml (интерфейс Quarto), _meta-ru/rd.yml (тексты kit)
│   ├── math/             # math-symbols.qmd
│   └── refs/apa.csl
├── fonts/
│   ├── web/              # variable woff2 (latin, latin-ext, cyrillic, cyrillic-ext) + wolm-fonts.css
│   ├── ttf/              # полные variable ttf из google/fonts — для будущего Typst
│   └── licenses/         # SIL OFL 1.1
└── typst/README.md       # зарезервировано
```

Правила для правок:

- **Палитра лежит в двух местах**: `brand/<тема>.yml` и `html/scss/<тема>.scss`. После изменения цветов запусти `Rscript scripts/check-palette.R`.
- В `html/scss/partials/` только правила. Переменные объявляются в `light.scss`, `dark.scss` и `common.scss`, иначе Quarto выдаёт ложное предупреждение «variable used before declaration».
- В `theme:` внутри `_extension.yml` слово `brand` не пишется: в расширении Quarto считает его путём к файлу.

## Работа со стендами

```bash
scripts/link-ext.sh          # один раз: book-kit/_extensions и site-kit/_extensions -> ../_extensions
cd book-kit && quarto preview   # порт 5051
cd site-kit && quarto preview   # порт 5052
```

Стендам нужны R-пакеты `tidyverse`, `psych`, `leaflet` (через `renv`).

## Лицензии

Код kit — MIT. Шрифты — SIL Open Font License 1.1 (`fonts/licenses/`). `apa.csl` — CC BY-SA 3.0 (Citation Style Language).
