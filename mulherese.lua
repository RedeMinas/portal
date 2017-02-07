-- #author: Carlos Henrique G. Paulino
-- #description: Portal Institucional redeminas
-- #description: mulherese teste
-- #ginga - ncl / lua

VERSION = "mulherese teste"

START = false
MENUON = false
PGMON = false
-- reads table menu

dofile("lib_icon.lua")
dofile("lib_main.lua")
dofile("lib_tables.lua")

function handler (evt)
  if (evt.class == 'key' and evt.type == 'press') then
    -- icon
    if (evt.key == "ENTER" and not MENUON)  then
      dofile("lib_mulherese.lua")
      MENUON=true
      coroutine.resume(comainIcon)
      mse=mulhereseMenu:new{}
      mse:iconsDraw()
    elseif (PGMON == true) then
      mse:input(evt)
    end
  elseif (evt.action == "start") then
    mainIconUpdate()
  end
end
event.register(handler)
