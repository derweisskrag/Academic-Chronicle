function Header(elem)
  elem.content = {pandoc.Str("🔥 " .. pandoc.utils.stringify(elem))}
  return elem
end
