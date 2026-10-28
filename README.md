# WoLM SDARP Style Kit

Стилевой комплект проекта WoLM SDARP в виде Quarto extension `kit`. Плюс два тестовых стенда: книга `book-kit` и сайт `site-kit`.

> Quarto: **≥ 1.9.37** (проверено на 1.9.37).
> Статус: `0.1.0-dev`, только HTML. Typst зарезервирован (`_extensions/wolm-sdarp/kit/typst/README.md`).

## Подключение к книге или сайту

```bash
quarto add wolm-sdarp/kit@v0.1.0     # конкретный релиз (тег) — рекомендуется
quarto add wolm-sdarp/kit@master     # текущее состояние ветки master
```

Версию нужно указывать всегда:

- без `@…` Quarto 1.9.37 качает ветку `main`, а её в репозитории нет — основная ветка называется `master`;
- ветки с `/` в имени (`feature/…`) так поставить не получится: судя по коду Quarto, он ищет в архиве папку `kit-feature/…`, а GitHub называет её `kit-feature-…`.

Расширение установится в `_extensions/wolm-sdarp/kit/`: Quarto кладёт расширения из GitHub в `_extensions/<владелец>/<имя>`. В `_quarto.yml` проекта:

```yaml
# Бренд подключается здесь: в проектах-книгах Quarto 1.9.37 не применяет бренд из расширения
brand:
  light: _extensions/wolm-sdarp/kit/brand/light.yml
  dark: _extensions/wolm-sdarp/kit/brand/dark.yml

# Язык интерфейса и тексты kit (ru | rd)
language: _extensions/wolm-sdarp/kit/shared/lang/_lang-ru.yml
metadata-files:
  - _extensions/wolm-sdarp/kit/shared/lang/_meta-ru.yml

format:
  kit-html: default
```

Общие LaTeX-макросы для формул подключаются в главе:

```markdown
{{< include /_extensions/wolm-sdarp/kit/shared/math/math-symbols.qmd >}}
```

Обновление — тоже с версией: `quarto update wolm-sdarp/kit@v0.1.1`.

## Что даёт формат `kit-html`

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
| `wolm.capitalize-h1` | `true` | Заглавная первая буква в заголовках h1 и в `title`. Код, формулы и цифры в начале не трогаются; номер главы, кавычки и скобки пропускаются. Боковое меню и навигация книги берут заголовки глав прямо из исходников, до фильтров, — там регистр остаётся как в тексте |
| `wolm.labs.<уровень>` | `Novice` … `Expert` | Текст лейбла уровня (`_meta-rd.yml` — дореформенные названия) |
| `wolm.strings.solution-show`, `wolm.strings.solution-hide` | `Show`, `Hide` | Подсказка у свёрнутого решения (`.solution .folded`): «Развернуть» / «Свернуть» в `ru` и `rd` |
| `wolm.strings.level-filter-label` | `Filter sections by level` | `aria-label` группы кнопок фильтра |
| `wolm.strings.release-alpha`, `wolm.strings.release-beta` | английский текст | Текст баннера версии (см. ниже); `ru`, `rd`, `en` — в `_meta-*.yml` |

### Классы и блоки (контракт)

Этим списком пользуются авторы книг, и его же позже реализует формат Typst.

| Разметка | Результат |
|---|---|
| `## Заголовок {.lab-novice}` (`junior`, `middle`, `senior`, `expert`) | Лейбл уровня под заголовком h2–h3 |
| `:::{.callout-note .objectives}` | Колаут «цели» (также `.outcomes`, `.history`, `.person`, `.dataset`, `.myth`, `.case`) |
| `:::{.callout-none}` | Нейтральный колаут |
| `#mth-`, `#hst-`, `#prs-`, `#dts-`, `#cse-`, `#sch-`, `#vid-` | Нумеруемые кастомные float-блоки (миф, история, персона, датасет, кейс, схема, видео) |
| `::::{.intro}` | Введение к главе |
| `:::{.blockquote}` с подписью `> Имя Фамилия. [Источник, год]` в конце | Цитата с подписью: подпись справа, перед ней тире |
| `::: {.solution .folded}`, `::: {#sol-… .folded}` | Решение, свёрнутое по умолчанию: раскрывается кликом, Enter или пробелом (`<details>`, без JS). В других форматах — развёрнуто |
| `#thm-`, `#lem-`, `.proof` … | Теоремы и доказательства в рамке |

### Баннер версии (alpha/beta)

Под навбаром выводится предупреждение о версии. Это встроенный баннер Quarto (`website.announcement`), kit оформляет его в стиле колаутов. Баннер включается профилем Quarto: в стабильной сборке профиля нет, и баннера тоже нет.

`_quarto-alpha.yml` в корне книги или сайта:

```yaml
website:          # и в книгах тоже website:, а не book: — book.announcement Quarto 1.9.37 игнорирует
  announcement:
    content: "{{< meta wolm.strings.release-alpha >}}"
    type: warning               # beta: info; цвет берётся из колаутов (warning, note, tip, important…)
    icon: exclamation-triangle  # beta: info-circle; иконки Bootstrap Icons
    dismissable: false
    position: below-navbar
```

Сборка: `quarto render --profile alpha` (или `beta`). Профили можно совмещать с языковыми: `--profile alpha,ru`. Готовые профили — в `book-kit/_quarto-alpha.yml` и `_quarto-beta.yml`. Текст берётся из `wolm.strings.release-*` и переводится вместе с остальными строками kit. Ссылку на стабильную версию можно дописать прямо в `content`.

## Устройство расширения

```
_extensions/wolm-sdarp/kit/
├── _extension.yml        # формат kit-html (common + html), заготовка typst
├── brand/                # light.yml, dark.yml — палитра, фон/текст, шрифты (для HTML и Typst)
├── html/
│   ├── scss/             # light.scss, dark.scss — переменные тем; common.scss — общее
│   │   └── partials/     # только правила: labels, elements, callouts, level-filter
│   ├── includes/         # brackets-thickness-fix.html
│   └── js/               # level-filter.js
├── shared/
│   ├── filters/
│   │   ├── capitalize.lua  # заглавная буква в h1 и title (pre-quarto, все форматы)
│   │   ├── solution.lua    # HTML: свёрнутые решения .solution .folded (post-render)
│   │   └── wolm.lua        # HTML: шрифты, CSS-переменные с текстами, фильтр уровней
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
- `$gray-300`, `$gray-500`, `$gray-600`, `$gray-800` и `$border-color` задаются **без `!default`**. Quarto 1.9.37 объявляет их раньше наших файлов, поэтому значение с `!default` молча игнорируется.

## Работа со стендами

```bash
scripts/link-ext.sh          # один раз: book-kit/_extensions и site-kit/_extensions -> ../_extensions
cd book-kit && quarto preview   # порт 5051
cd site-kit && quarto preview   # порт 5052
```

Стендам нужны R-пакеты `tidyverse`, `psych`, `leaflet` (через `renv`).

## Лицензии

Код kit — MIT. Шрифты — SIL Open Font License 1.1 (`fonts/licenses/`). `apa.csl` — CC BY-SA 3.0 (Citation Style Language).
