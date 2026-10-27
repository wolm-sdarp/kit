--[[
  WoLM SDARP — фильтр расширения.

  Читает метаданные `wolm` (значения по умолчанию — в _extension.yml) и для HTML:
    * подключает Google Fonts (wolm.fonts: google) — или не подключает (local);
    * всегда подключает локальную копию шрифтов (fonts/web) как запасной вариант;
    * задаёт CSS-переменные с текстами лейблов уровней и служебных подписей
      (--wolm-lab-*, --wolm-solution-toggle, --wolm-level-filter-label);
    * подключает фильтр разделов по уровням (wolm.level-filter: true).

  Для Typst фильтр пока ничего не делает (формат зарезервирован).
]]

local GOOGLE_FONTS = [[
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,300..700;1,300..700&family=Open+Sans:ital,wght@0,300..800;1,300..800&family=Source+Code+Pro:ital,wght@0,400..700;1,400..700&display=swap">
]]

local LEVELS = { "novice", "junior", "middle", "senior", "expert" }

local function str(v, default)
  if v == nil then return default end
  local s = pandoc.utils.stringify(v)
  if s == "" then return default end
  return s
end

-- Строка для CSS: в кавычках, с экранированием
local function css_string(s)
  s = s:gsub("\\", "\\\\"):gsub('"', '\\"'):gsub("\n", " ")
  return '"' .. s .. '"'
end

local function html_escape(s)
  return (s:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
end

function Meta(meta)
  if not quarto.doc.is_format("html") then
    return meta
  end

  local w = meta.wolm or {}
  local labs = w.labs or {}
  local strings = w.strings or {}

  -- Шрифты
  local fonts = str(w.fonts, "google")
  if fonts ~= "google" and fonts ~= "local" then
    quarto.log.warning("wolm.fonts: unknown value '" .. fonts .. "', using 'google'")
    fonts = "google"
  end
  if fonts == "google" then
    quarto.doc.include_text("in-header", GOOGLE_FONTS)
  end
  quarto.doc.add_html_dependency({
    name = "wolm-fonts",
    version = "0.1.0",
    stylesheets = { "../../fonts/web/wolm-fonts.css" },
    resources = {
      "../../fonts/web/OpenSans.woff2",
      "../../fonts/web/OpenSans-Italic.woff2",
      "../../fonts/web/Montserrat.woff2",
      "../../fonts/web/Montserrat-Italic.woff2",
      "../../fonts/web/SourceCodePro.woff2",
      "../../fonts/web/SourceCodePro-Italic.woff2",
    },
  })

  -- Тексты для CSS
  local vars = {}
  for _, lvl in ipairs(LEVELS) do
    local default = lvl:sub(1, 1):upper() .. lvl:sub(2)
    table.insert(vars, "--wolm-lab-" .. lvl .. ": " .. css_string(str(labs[lvl], default)) .. ";")
  end
  table.insert(vars, "--wolm-solution-toggle: " .. css_string(str(strings["solution-toggle"], "")) .. ";")
  table.insert(vars, "--wolm-level-filter-label: " ..
    css_string(str(strings["level-filter-label"], "Filter sections by level")) .. ";")
  quarto.doc.include_text("in-header",
    "<style>\n:root {\n  " .. html_escape(table.concat(vars, "\n  ")) .. "\n}\n</style>")

  -- Фильтр разделов по уровням
  if w["level-filter"] == true or str(w["level-filter"], "false") == "true" then
    quarto.doc.add_html_dependency({
      name = "wolm-level-filter",
      version = "0.1.0",
      scripts = { { path = "../../html/js/level-filter.js", afterBody = true } },
    })
  end

  return meta
end
