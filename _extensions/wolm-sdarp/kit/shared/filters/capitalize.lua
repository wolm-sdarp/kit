--[[
  WoLM SDARP — заглавная первая буква в заголовках h1 и в заголовке документа.

  Работает для всех форматов (HTML, будущий Typst). Подключён с `at: pre-quarto`:
  в книгах Quarto берёт заголовок главы до пользовательских фильтров.
  Код, формулы и цифры в начале заголовка не трогаются; кавычки и скобки пропускаются.
  Отключение: wolm.capitalize-h1: false.
]]

-- Знаки, которые пропускаются перед первой буквой: «Кавычки», (скобки), неразрывные пробелы
local CAP_SKIP = {
  ["«"] = true, ["„"] = true, ["“"] = true, ["‘"] = true, ["‹"] = true,
  ['"'] = true, ["'"] = true, ["("] = true, ["["] = true, ["¿"] = true, ["¡"] = true,
  ["\u{A0}"] = true, ["\u{202F}"] = true, ["\u{2009}"] = true,   -- неразрывный и тонкие пробелы
}

-- Возвращает (новая строка, найдено_ли_начало_слова)
local function cap_str(s)
  local n = pandoc.text.len(s)
  for i = 1, n do
    local ch = pandoc.text.sub(s, i, i)
    local up = pandoc.text.upper(ch)
    if up ~= ch then                                  -- строчная буква → заглавная
      return pandoc.text.sub(s, 1, i - 1) .. up .. pandoc.text.sub(s, i + 1), true
    end
    if not CAP_SKIP[ch] then                          -- заглавная, цифра, прочее — стоп
      return s, true
    end
  end
  return s, false                                     -- только кавычки/скобки — ищем дальше
end

local CONTAINERS = {
  Emph = true, Strong = true, Span = true, Link = true, SmallCaps = true,
  Underline = true, Strikeout = true, Quoted = true,
}

-- Меняет список инлайнов на месте; true — начало заголовка найдено (дальше не ищем)
local function cap_inlines(inls)
  for _, el in ipairs(inls) do
    if el.t == "Str" then
      local s, done = cap_str(el.text)
      el.text = s
      if done then return true end
    elseif el.t == "Space" or el.t == "SoftBreak" then
      -- пропускаем
    elseif el.t == "Span" and el.classes:includes("chapter-number") then
      -- номер главы в книге («4 код…») — пропускаем, ищем начало заголовка дальше
    elseif CONTAINERS[el.t] then
      if cap_inlines(el.content) then return true end
    else
      return true                                     -- Code, Math, Image… — не трогаем
    end
  end
  return false
end

local capitalize_h1 = true

local function read_settings(meta)
  local w = meta.wolm or {}
  local v = w["capitalize-h1"]
  if v ~= nil then
    capitalize_h1 = not (v == false or pandoc.utils.stringify(v) == "false")
  end
end

local function cap_header(h)
  if capitalize_h1 and h.level == 1 then
    cap_inlines(h.content)
    return h
  end
end

local function cap_title(meta)
  if not capitalize_h1 or meta.title == nil then return nil end
  local t = pandoc.utils.type(meta.title)
  if t == "Inlines" then
    cap_inlines(meta.title)
  elseif t == "string" then
    -- в книгах Quarto передаёт заголовок главы строкой с разметкой Markdown:
    -- если он начинается с `кода` или $формулы$, cap_str остановится на ` или $
    meta.title = (cap_str(meta.title))
  else
    return nil
  end
  return meta
end

return {
  { Meta = read_settings },
  { Header = cap_header },
  { Meta = cap_title },
}
