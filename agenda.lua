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
      MENUON = true
      agenda:iconDraw()

    elseif (evt.key == "EXIT" and MENUON and PGMON)  then
      ICON.state=1
      MENUON = false
      PGMON = false
      comainIcon = coroutine.create(mainIconAnim)
      mainIconUpdate()
      coroutine.resume(comainIcon)
      --barHorizontal()
      -- main menu
    elseif( MENUON and PGMON) then
      agenda:input(evt)

    end
  elseif (evt.action == "start") then
    mainIconUpdate()
  end
end
event.register(handler)
