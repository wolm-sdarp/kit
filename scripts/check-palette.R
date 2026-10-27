#!/usr/bin/env Rscript
# Проверяет, что палитра в brand/<тема>.yml совпадает с html/scss/<тема>.scss.
# Палитра хранится в двух местах: SCSS нужен Bootstrap (в scss:defaults переменные $brand-*
# недоступны), brand.yml — Typst и шорткоду {{< brand color … >}}. См. log.md.
# Запуск из корня kit: Rscript scripts/check-palette.R

ext <- file.path("_extensions", "wolm-sdarp", "kit")

read_brand_palette <- function(path) {
  x <- readLines(path, warn = FALSE, encoding = "UTF-8")
  start <- grep("^\\s*palette:\\s*$", x)
  if (length(start) != 1) stop("palette: не найдена в ", path)
  out <- character()
  for (line in x[(start + 1):length(x)]) {
    if (!grepl("^\\s{4,}", line)) break
    m <- regmatches(line, regexec('^\\s+([a-z0-9-]+):\\s*"?(#[0-9a-fA-F]{3,8})"?', line))[[1]]
    if (length(m) == 3) out[m[2]] <- tolower(m[3])
  }
  out
}

read_scss_palette <- function(path, names) {
  x <- readLines(path, warn = FALSE, encoding = "UTF-8")
  out <- character()
  for (n in names) {
    re <- paste0("^\\$", n, ":\\s*(#[0-9a-fA-F]{3,8})")
    hit <- regmatches(x, regexec(re, x))
    hit <- Filter(function(h) length(h) == 2, hit)
    out[n] <- if (length(hit)) tolower(hit[[1]][2]) else NA_character_
  }
  out
}

ok <- TRUE
for (theme in c("light", "dark")) {
  b <- read_brand_palette(file.path(ext, "brand", paste0(theme, ".yml")))
  s <- read_scss_palette(file.path(ext, "html", "scss", paste0(theme, ".scss")), names(b))
  bad <- names(b)[is.na(s) | s != b]
  if (length(bad)) {
    ok <- FALSE
    cat(sprintf("[%s] расхождения:\n", theme))
    for (n in bad) cat(sprintf("  %-12s brand %s  scss %s\n", n, b[n], s[n]))
  } else {
    cat(sprintf("[%s] палитра совпадает (%d цветов)\n", theme, length(b)))
  }
}
if (!ok) quit(status = 1)
