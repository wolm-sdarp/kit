# Changelog

Формат — [Keep a Changelog](https://keepachangelog.com/ru/1.1.0/), версии — [SemVer](https://semver.org/lang/ru/).

## [Unreleased] — 0.1.0-dev

### Added

- Расширение `wolm-sdarp` (`_extensions/wolm-sdarp/wolm-sdarp/`) с форматом `wolm-sdarp-html` для книг и сайтов.
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

- Стенды `book-kit` и `site-kit` переведены на формат `wolm-sdarp-html`. Настройки, которые теперь даёт расширение (CSL, crossref, тема), из `_quarto.yml` стендов убраны.
- `level-filter.js`: добавлен уровень Middle; подписи кнопок берутся из `wolm.labs`; работает только если на странице есть разделы с лейблами.

### Fixed

- Кастомные колауты без заголовка теряли иконку: селектор повторял `.callout-titled` вместо `:not(.callout-titled)`.
- `book-kit/_quarto.yml`: неверный отступ у `chapters:` внутри `part:`.
- `book-kit/math.qmd`: путь к `math-symbols.qmd`.
- `book-kit/code.qmd`: `psych::kurtos` → `psych::kurtosi` (такой функции в `psych` нет).
- `.gitignore`: исключал каталог `_extensions` целиком, вместе с самим расширением.

### Removed

- Ключ `math-macros` из конфигурации книг: Quarto его не поддерживает. Макросы `\setN`, `\setNo`, `\setZp` есть в `math-symbols.qmd`.
