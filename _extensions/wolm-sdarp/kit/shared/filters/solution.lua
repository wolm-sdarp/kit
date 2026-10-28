--[[
  WoLM SDARP — сворачиваемые решения: ::: {.solution .folded}

  Только HTML. Блок .solution — встроенный в Quarto блок доказательства («Решение»);
  класс .folded — «свёрнуто по умолчанию». Фильтр подключён с `at: post-render`:
  к этому моменту Quarto уже превратил блок в Div.proof.solution с заголовком
  Span.proof-title в первом абзаце.

  Результат (рамка .proof сохраняется):
    <div class="folded proof solution">
      <details class="wolm-solution">
        <summary><em>Решение</em></summary>
        …содержимое…
      </details>
    </div>

  Подсказка «Развернуть/Свернуть» — CSS-переменные --wolm-solution-show/hide
  (задаёт wolm.lua из wolm.strings.solution-show/hide), стили — html/scss/partials/_elements.scss.
  Без .folded и в других форматах (будущий Typst) блок не меняется.
]]

-- Заголовок без хвостовой точки и пробела: «Решение. » → «Решение»
local function trim_title(inlines)
  local out = pandoc.Inlines(inlines)
  while #out > 0 do
    local last = out[#out]
    if last.t == "Space" or (last.t == "Str" and last.text:match("^[%.%s]*$")) then
      out:remove(#out)
    elseif last.t == "Str" and last.text:match("%.%s*$") then
      last.text = last.text:gsub("%.%s*$", "")
      break
    else
      break
    end
  end
  return out
end

-- Ищет Span.proof-title в первом абзаце блока, вынимает его и возвращает заголовок
local function take_title(blocks)
  local first = blocks[1]
  if not first or (first.t ~= "Para" and first.t ~= "Plain") then return nil end
  for i, el in ipairs(first.content) do
    if el.t == "Span" and el.classes:includes("proof-title") then
      first.content:remove(i)
      -- пробел сразу после заголовка тоже убираем
      if first.content[i] and first.content[i].t == "Space" then first.content:remove(i) end
      if #first.content == 0 then blocks:remove(1) end
      return trim_title(el.content)
    end
  end
  return nil
end

function Div(div)
  if not quarto.doc.is_format("html") then return nil end
  if not (div.classes:includes("solution") and div.classes:includes("folded")) then return nil end

  local blocks = pandoc.Blocks(div.content)
  local title = take_title(blocks)
  if title == nil then
    title = pandoc.Inlines({})   -- заголовка нет: в summary останется только подсказка и шеврон
  end

  local content = pandoc.Blocks({
    pandoc.RawBlock("html", '<details class="wolm-solution">\n<summary>'),
    pandoc.Plain(title),
    pandoc.RawBlock("html", "</summary>"),
  })
  content:extend(blocks)
  content:insert(pandoc.RawBlock("html", "</details>"))
  div.content = content
  return div
end
