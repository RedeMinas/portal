-- #author: Carlos Henrique G. Paulino
-- #description: Portal Institucional Rede Minas
-- #description: somente menu agenda
-- #ginga - ncl / lua

VERSION = "1.2.4t"

-- reads functions
dofile("lib_main.lua")
dofile("lib_icon.lua")
dofile("lib_tables.lua")
dofile("lib_agenda.lua")

agenda=agendaMenu:new{}

function handler (evt)
  if (evt.class == 'key' and evt.type == 'press') then
    -- icon
    if (evt.key == "ENTER" and MENUON ~= true and PGMON ~=true)  then
      coroutine.resume(comainIcon)
      agenda:iconDraw()
      agenda:menuItem()
      --testes agenda
    elseif(PGMON) then
      MENUON = true
      PGMON = true
      coroutine.resume(comainIcon)
      agenda:iconDraw()
      agenda:menuItem()
      -- main menu
    elseif( MENUON and PGMON) then
      agenda:input(evt)
    end
  elseif (evt.action == "start") then
    mainIconUpdate()
  end
end
event.register(handler)
