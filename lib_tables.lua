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
        if regexp == "TRUE" then
          tab[i-1]["info"] = true
        else
          tab[i-1]["info"] = false
        end
      elseif w == 8  then
        if regexp == "TRUE" then
          tab[i-1]["site"] = true
        else
          tab[i-1]["site"] = false
        end
      elseif w == 9  then
        if regexp == "TRUE" then
          tab[i-1]["youtube"] = true
        else
          tab[i-1]["youtube"] = false
        end
      elseif w == 10 then
        if regexp == "TRUE" then
          tab[i-1]["facebook"] = true
        else
          tab[i-1]["facebook"] = false
        end
      elseif w == 11 then
        if regexp == "TRUE" then
          print(regexp)
          tab[i-1]["twitter"] = true
        else
          tab[i-1]["twitter"] = false
        end
      elseif w == 12 then
        if regexp == "TRUE" then
          tab[i-1]["spotify"] = true
        else
          tab[i-1]["spotify"] = false
        end
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

function layoutPgmMulherese(table)
  local tab={}
  for i = 2, #table, 1 do
    tab[i-1]={}
    local w=1

    for regexp in table[i]:gmatch("[^\t\t]+") do
      if w == 1 then
        tab[i-1]["id"] = regexp
      elseif w == 2 then
        tab[i-1]["page1"] = regexp
      elseif w == 3 then
        tab[i-1]["page2"] = regexp
      elseif w == 4 then
        tab[i-1]["page3"] = regexp
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

-- exemplo: local tab = layoutPgmMulherese(ReadTable("table.txt"))
