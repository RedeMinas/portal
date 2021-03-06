function ReadTable(pathFile)
  local file, erro = io.open( pathFile, "r")
  local tab = {}
  teste=1
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
  local id = 0
  --linha a linha
  for i = 2, #table, 1 do
    local w=1
    --campo a campo

    for regexp in table[i]:gmatch("[^\t\t]+") do
      if w == 1 then
        id = tonumber(regexp)
        tab[id]={}
        tab[id]["img"] = i-1
      elseif w == 2 then
        tab[id]["nome"] = regexp
      elseif w == 3 then
        tab[id]["grade"] = regexp
      elseif w == 4 then
        tab[id]["desc1"] = regexp
      elseif w == 5 then
        tab[id]["desc2"] = regexp
      elseif w == 6 then
        tab[id]["desc3"] = regexp
      elseif w == 7 then
        tab[id]["desc4"] = regexp
      elseif w == 8 then
        tab[id]["class"] = regexp
      elseif w == 9 then
        if regexp == "TRUE" then
          tab[id]["info"] = true
        else
          tab[id]["info"] = false
        end
      elseif w == 10 then
        if regexp == "TRUE" then
          tab[id]["site"] = true
        else
          tab[id]["site"] = false
        end
      elseif w == 11 then
        if regexp == "TRUE" then
          tab[id]["youtube"] = true
        else
          tab[id]["youtube"] = false
        end
      elseif w == 12 then
        if regexp == "TRUE" then
          tab[id]["facebook"] = true
        else
          tab[id]["facebook"] = false
        end
      elseif w == 13 then
        if regexp == "TRUE" then
          tab[id]["twitter"] = true
        else
          tab[id]["twitter"] = false
        end
      elseif w == 14 then
        if regexp == "TRUE" then
          tab[id]["spotify"] = true
        else
          tab[id]["spotify"] = false
        end
      end
      -- controle dos campos (rever???)
      if w < 15
      then
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
  for i = 1, #table, 1 do
    tab[i]={}
    local w=1

    for regexp in table[i]:gmatch("[^\t\t\t]+") do
      if w == 1 then
        tab[i]["id"] = regexp
      elseif w == 2 then
        tab[i]["cat"] = regexp
      elseif w == 3 then
        tab[i]["page"] = regexp
      end
      -- controle dos campos
      if w < 4  then
        w=w+1
      else
        w=1
      end
    end
  end
  return tab
end
-- ex: local tab = layoutPgmMulherese(ReadTable("table.txt"))



function layoutPgmHarmoniaRep(table)
  local tab={}

  local id = 0
  for i = 2, #table, 1 do
    local w=1
    for regexp in table[i]:gmatch("[^\t\t]+") do
      id = i-1
      if w == 1 then
        tab[id]={}
        tab[id]["img"] = regexp
      elseif w == 2 then
        tab[id]["evento"] = regexp
      elseif w == 3 then
        tab[id]["regente"] = regexp
      elseif w == 4 then
        tab[id]["programa"] = regexp
      elseif w == 5 then
        tab[id]["data"] = regexp
      elseif w == 6 then
        tab[id]["horario"] = regexp
      elseif w == 7 then
        tab[id]["local"] = regexp
      elseif w == 8 then
        tab[id]["ingresso"] = regexp
      elseif w == 9 then
        if regexp == "TRUE" then
          tab[id]["info"] = true
        else
          tab[id]["info"] = false
        end
      end
      -- controle dos campos
      if w < 9
      then
        w=w+1
      else
        w=1
      end
    end
  end
  return tab
end
-- ex: local tab = layoutPgmHarmoniaRep(ReadTable("table.txt"))

function layoutPgmHarmoniaExtra(table)
  local tab={}
  local id = 0
  for i = 1, #table, 1 do
    local w=1
    for regexp in table[i]:gmatch("[^\t\t]+") do
      if w == 1 then
        tab[i]={}
        tab[i]["episodio"] = regexp
      elseif w == 2 then
        tab[i]["especial"] = regexp
      end
      -- controle dos campos
      if w < 3
      then
        w=w+1
      else
        w=1
      end
    end
  end
  return tab
end
-- ex: local tab = layoutPgmHarmoniaExtra(ReadTable("table.txt"))

function layoutPgmAgendaEvt(table)
  local tab={}
  local id = 0
  for i = 2, #table, 1 do
    local w=1
    for regexp in table[i]:gmatch("[^\t\t]+") do
      if w == 1 then
        id = tonumber(regexp)
        tab[id]={}
        tab[id]["img"] = i-1
        print(regexp)
      elseif w == 2 then
        tab[id]["nome"] = regexp
        print(regexp)
      elseif w == 3 then
        tab[id]["data"] = regexp
        print(regexp)
      elseif w == 4 then
        tab[id]["cat"] = regexp
      elseif w == 6 then
        tab[id]["desc"] = regexp
      elseif w == 7 then
        tab[id]["hora"] = regexp
      elseif w == 8 then
        tab[id]["valor"] = regexp
      elseif w == 9 then
        tab[id]["local"] = regexp
      elseif w == 10 then
        tab[id]["segunda"] = regexp
      elseif w == 11 then
        if regexp == "TRUE" then
          tab[id]["info"] = true
        else
          tab[id]["info"] = false
        end
      end
      if w < 11
      then
        w=w+1
      else
        w=1
      end
    end
  end
  
  return tab
end
-- ex: local tab = layoutPgmAgendaEvt(ReadTable("table.txt"))

function layoutPgmAgendaCc(table)
  local tab={}
  local id = 0
  for i = 2, #table, 1 do
    local w=1
    for regexp in table[i]:gmatch("[^\t\t]+") do
      if w == 1 then
        id = tonumber(regexp)
        tab[id]={}
        tab[id]["img"] = i-1
      elseif w == 2 then
        tab[id]["nome"] = regexp
      elseif w == 3 then
        tab[id]["valor"] = regexp
      elseif w == 4 then
        tab[id]["cat"] = regexp
      elseif w == 6 then
        tab[id]["reg"]= regexp
      elseif w == 8 then
        tab[id]["desc"] = regexp
      elseif w == 9 then
        tab[id]["end"] = regexp
      elseif w == 10 then
        tab[id]["func"] = regexp
      elseif w == 11 then
        tab[id]["contato"] = regexp
      elseif w == 12 then
        if regexp == "TRUE" then
          tab[id]["info"] = true
        else
          tab[id]["info"] = false
        end
      end
      if w < 12
      then
        w=w+1
      else
        w=1
      end
    end
  end
  return tab
end
-- ex: local tab = layoutPgmAgenda(ReadTable("table.txt"))

function layoutPgmAltofalanteAlbuns(table)
  local tab={}
  local id = 0
  for i = 2, #table, 1 do
    local w=1
    for regexp in table[i]:gmatch("[^\t\t]+") do
      if w == 1 then
        id = tonumber(regexp)
        tab[id]={}
        tab[id]["img"] = i-1
      elseif w == 2 then
        tab[id]["banda"] = regexp
      elseif w == 3 then
        tab[id]["album"] = regexp
	 elseif w == 4 then
        tab[id]["descricao"] = regexp

      end
      if w < 5
      then
        w=w+1
      else
        w=1
      end
    end
  end
  return tab
end
-- ex: local tab = layoutPgmAltofalanteAlbuns(ReadTable("table.txt"))

function layoutPgmAltofalanteNews(table)
  local tab={}
  local id = 0
  for i = 2, #table, 1 do
    local w=1
    for regexp in table[i]:gmatch("[^\t\t]+") do
      if w == 1 then
        id = tonumber(regexp)
        tab[id]={}
        tab[id]["img"] = i-1
      elseif w == 2 then
        tab[id]["nome"] = regexp
      elseif w == 3 then
        tab[id]["desc"] = regexp
      elseif w == 4 then
        tab[id]["data"] = regexp
      end
      if w < 5
      then
        w=w+1
      else
        w=1
      end
    end
  end
  return tab
end
-- ex: local tab = layoutPgmAltofalanteNews(ReadTable("table.txt"))

function layoutPgmAltofalantePgms(table)
  local tab={}
  local id = 0
  for i = 2, #table, 1 do
    local w=1
    for regexp in table[i]:gmatch("[^\t\t]+") do
      if w == 1 then
        id = tonumber(regexp)
        tab[id]={}
        tab[id]["img"] = i-1
      elseif w == 2 then
        tab[id]["nome"] = regexp
        print(regexp)
      elseif w == 3 then
        tab[id]["desc"] = regexp
      elseif w == 4 then
        tab[id]["site"] = regexp
      end
      if w < 5
      then
        w=w+1
      else
        w=1
      end
    end
  end
  return tab
end
-- ex: local tab = layoutPgmAltofalantePgms(ReadTable("table.txt"))
