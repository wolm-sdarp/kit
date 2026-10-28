# Changelog

Формат — [Keep a Changelog](https://keepachangelog.com/ru/1.1.0/), версии — [SemVer](https://semver.org/lang/ru/).

## [Unreleased] — 0.1.0-dev

### Added

- Сворачиваемые решения `::: {.solution .folded}` (и нумерованные `#sol-… .folded`): фильтр `shared/filters/solution.lua` (`at: post-render`) оборачивает содержимое в `<details>` — работает без JS, с клавиатуры; подсказка `wolm.strings.solution-show/hide`; в других форматах блок не меняется (#21).
- Баннер версии alpha/beta под навбаром в стиле колаутов: оформление `website.announcement` (`html/scss/partials/_announcement.scss`), тексты `wolm.strings.release-alpha/beta` для `en`, `ru`, `rd`, профили `book-kit/_quarto-alpha.yml` и `_quarto-beta.yml`.
- Расширение `kit` (`_extensions/wolm-sdarp/kit/`) с форматом `kit-html` для книг и сайтов.
- Бренд `brand/light.yml` и `brand/dark.yml`: палитра из 28 цветов, фон и текст, семантические цвета, назначение шрифтов.
- Темы `html/scss/light.scss` и `dark.scss`, общая часть `common.scss`, частичные файлы `labels`, `elements`, `callouts`, `level-filter`.
- Lua-фильтр `shared/filters/wolm.lua`:
  - подключает Google Fonts или работает без них (`wolm.fonts: google | local`);
  - всегда подключает локальную копию шрифтов как запасной вариант;
  - задаёт CSS-переменные с текстами лейблов и подписей (`wolm.labs`, `wolm.strings`);
  - включает фильтр уровней (`wolm.level-filter`).
- Локальные шрифты Montserrat, Open Sans, Source Code Pro: variable woff2 для веба (латиница + кириллица, включая дореформенные буквы) и ttf для будущего Typst. Лицензии OFL.
- Языковые файлы `ru` и `rd`: интерфейс Quarto (`_lang-*.yml`) и тексты kit (`_meta-*.yml`).
- `shared/math/math-symbols.qmd`, `shared/refs/apa.csl`, `html/includes/brackets-thickness-fix.html`.
- Кастомные crossref-типы `mth`, `hst`, `prs`, `dts`, `cse`, `sch`, `vid` в формате.
- Скрипты `scripts/link-ext.sh` (подключение расширения к стендам) и `scripts/check-palette.R` (сверка палитры brand ↔ SCSS).
- Стенд `site-kit`: страница `components.qmd`.

### Changed

- Заглавная первая буква в h1 и в `title` — Lua-фильтр `shared/filters/capitalize.lua` (`at: pre-quarto`, ключ `wolm.capitalize-h1`) вместо CSS `h1::first-letter`. Код и формулы в начале заголовка не трогаются, номер главы пропускается; работает и для будущего Typst (#9).
- Расширение переименовано до релиза: `wolm-sdarp` → `kit`. Путь установки `_extensions/wolm-sdarp/wolm-sdarp/` → `_extensions/wolm-sdarp/kit/`, формат `wolm-sdarp-html` → `kit-html`. Команда установки не изменилась: `quarto add wolm-sdarp/kit@<версия>`.
- Стенды `book-kit` и `site-kit` переведены на формат `kit-html`. Настройки, которые теперь даёт расширение (CSL, crossref, тема), из `_quarto.yml` стендов убраны.
- `level-filter.js`: добавлен уровень Middle; подписи кнопок берутся из `wolm.labs`; работает только если на странице есть разделы с лейблами.

### Fixed

- Код всегда прямой: в Source Code Pro Italic нет кириллицы, и курсивные комментарии в коде (а также инлайн-код внутри курсива) набирались двумя шрифтами. В тёмной теме комментарии теперь выделены серым (`$code-comment-color`), раньше их отличал от кода только курсив (#22).
- `.blockquote`: тире ставилось перед каждым элементом подписи (курсив, ссылка) — теперь одно, в начале подписи. Формат подписи: `> Имя Фамилия. [Источник, год]`.
- Тёмная тема: рамки колаутов, таблиц и вкладок были светлыми (`#dee2e6`), текст активной вкладки — тёмным на тёмном фоне. Причина: Quarto 1.9.37 задаёт `$gray-300`, `$gray-500`, `$gray-600`, `$gray-800` и `$border-color` раньше наших defaults, и значения с `!default` не применялись. Теперь они заданы явно; для тёмной темы добавлены `$border-color`, `$emphasis-color` и цвета вкладок (#9).
- `h1::first-letter` делал заглавной первую букву кода в начале заголовка (`lm()` → `Lm()`) (#9).
- Кастомные колауты без заголовка теряли иконку: селектор повторял `.callout-titled` вместо `:not(.callout-titled)`.
- `book-kit/_quarto.yml`: неверный отступ у `chapters:` внутри `part:`.
- `book-kit/math.qmd`: путь к `math-symbols.qmd`.
- `book-kit/code.qmd`: `psych::kurtos` → `psych::kurtosi` (такой функции в `psych` нет).
- `.gitignore`: исключал каталог `_extensions` целиком, вместе с самим расширением.

### Removed

- `wolm.strings.solution-toggle` («Управляшка»), CSS-переменная `--wolm-solution-toggle` и правило `.solution.folded p:first-child::after` — заменены сворачиваемыми решениями (#21).
- Ключ `math-macros` из конфигурации книг: Quarto его не поддерживает. Макросы `\setN`, `\setNo`, `\setZp` есть в `math-symbols.qmd`.
