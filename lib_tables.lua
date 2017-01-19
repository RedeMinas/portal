function ReadTable(pathFile)
  local file, erro = io.open( pathFile, "r")
  local tab = {}
  if file ~= nil then
    for l in file:lines() do
      if #l > 1 then
        tab[#tab+1]= l
      end
    end
    file:close()

    return tab

  else
    print( pathFile .. " not found.")
  end
end

function layoutPgmTable(table)
  local tab={}
  for i = 2, #table, 1 do
    tab[i-1]={}
    local w=1
    for regexp in table[i]:gmatch("[^\t\t]+") do
      if w == 1 then
        tab[i-1]["nome"] = regexp
      elseif w == 2 then
        tab[i-1]["grade"] = regexp
      elseif w == 3 then
        tab[i-1]["desc1"] = regexp
      elseif w == 4 then
        tab[i-1]["desc2"] = regexp
      elseif w == 5 then
        tab[i-1]["desc3"] = regexp
      elseif w == 6 then
        tab[i-1]["class"] = regexp
      elseif w == 7 then
        tab[i-1]["site"] = regexp
      elseif w == 8  then
        tab[i-1]["youtube"] = regexp
      elseif w == 9  then
        tab[i-1]["youtube"] = regexp
      elseif w == 10 then
        tab[i-1]["youtube"] = regexp
      end
      -- controle dos campos (rever???)
      if w < 13 then
        w=w+1
      else
        w=1
      end
    end
  end
  return tab
end
-- ex: local tab = layoutPgmTable(ReadTable("table.txt"))



function tabelaMulherese(tabela)
  local tab={}
  for i = 2, #tabela, 1 do
    tab[i-1]={}
    local w=1

    for regexp in tabela[i]:gmatch("[^\t]+") do
      if w == 1 then
        tab[i-1]["id"] = regexp
      elseif w == 2 then
        tab[i-1]["nome"] = regexp
      elseif w == 3 then
        tab[i-1]["url1"] = regexp
      elseif w == 4 then
        tab[i-1]["url2"] = regexp
      elseif w == 5 then
        tab[i-1]["desc1"] = regexp
      elseif w == 6 then
        tab[i-1]["desc2"] = regexp
      elseif w == 7 then
        tab[i-1]["exib"] = regexp
      elseif w == 8 then
        tab[i-1]["reap"] = regexp
      elseif w == 9 then
        tab[i-1]["rep"] = regexp
      end
      -- controle dos campos
      if w < 10 then
        w=w+1
      else
        w=1
      end
    end
  end
  return tab
end

-- exemplo: local tab = tabelaMulherese(ReadTable("table.txt"))
