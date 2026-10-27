#!/usr/bin/env bash
# Подключает расширение kit к тестовым стендам: создаёт <стенд>/_extensions -> ../_extensions.
# Quarto ищет _extensions только внутри проекта, а стенды — самостоятельные проекты.
# В Windows (Git Bash без прав на симлинки) вместо ссылки делается копия: запускайте скрипт
# повторно после каждой правки расширения.
set -euo pipefail
cd "$(dirname "$0")/.."
for stand in book-kit site-kit; do
  target="$stand/_extensions"
  if [ -L "$target" ]; then
    echo "$target: ссылка уже есть"
    continue
  fi
  if [ -e "$target" ]; then
    echo "$target: существует и не является ссылкой — обновляю копию"
    rm -rf "$target"
  fi
  if ln -s ../_extensions "$target" 2>/dev/null && [ -d "$target/wolm-sdarp/kit" ]; then
    echo "$target -> ../_extensions"
  else
    rm -f "$target"
    cp -R _extensions "$target"
    echo "$target: симлинк недоступен, сделана копия"
  fi
done
