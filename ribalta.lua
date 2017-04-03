-- #author: Carlos Henrique G. Paulino
-- #description: Portal Institucional Rede Minas
-- #description: somente menu agenda
-- #ginga - ncl / lua

-- reads functions
dofile("lib_main.lua")
dofile("lib_icon.lua")
dofile("lib_tables.lua")
dofile("lib_ribalta.lua")

ribalta=ribaltaMenu:new{}

function handler (evt)
  if (evt.class == 'key' and evt.type == 'press') then
    -- icon
    if (evt.key == "ENTER" and MENUON ~= true and PGMON ~=true)  then
      MENUON = true
      print("enter")
      ribalta:pageReset()
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
      ribalta:input(evt)
    end
  elseif (evt.action == "start") then
    mainIconUpdate()
  end
end
event.register(handler)
