-- #author: Carlos Henrique G. Paulino
-- #description: Portal Institucional Rede Minas
-- #description: somente menu agenda 
-- #ginga - ncl / lua

VERSION = "calendar"

-- reads functions
dofile("lib_icon.lua")
dofile("lib_main.lua")
dofile("lib_tables.lua")
dofile("lib_agenda.lua")
dofile("lib_calendar.lua")

cal=calendar:new{}

function handler (evt)
  if (evt.class == 'key' and evt.type == 'press') then
    -- icon
    if (evt.key == "ENTER" and MENUON ~= true and PGMON ~=true)  then
      --      MENUON = true
      PGMON = true
      coroutine.resume(comainIcon)
      --      agenda:iconDraw()
      --      agenda:menuItem()
      cal:agenda()
      --testes agenda
    elseif(PGMON) then
      if ( evt.key=="EXIT") then
        ICON.state=1
        PGMON = false
        MENUON = false
        comainIcon = coroutine.create(mainIconAnim)
        mainIconUpdate()
      elseif (evt.key=="CURSOR_UP") then
        cal.aposv=shift(cal.aposv,-1,5)
        cal:agenda()
      elseif ( evt.key=="CURSOR_DOWN") then
        cal.aposv=shift(cal.aposv,1,5)
        cal:agenda()
      elseif (evt.key=="CURSOR_LEFT") then
        cal.aposh=shift(cal.aposh,-1,7)
        cal:agenda()
      elseif ( evt.key=="CURSOR_RIGHT") then
        cal.aposh=shift(cal.aposh,1,7)
        cal:agenda()
      end
    end
  elseif (evt.action == "start") then
--    mainIconUpdate()
  end
end
event.register(handler)
