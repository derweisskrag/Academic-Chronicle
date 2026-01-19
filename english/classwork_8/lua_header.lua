local first = true

function Header(el)
  if el.level == 2 then
    if first then
      first = false
      return el
    else
      return { pandoc.RawBlock("latex", "\\clearpage"), el }
    end
  end
end