-- #author: Carlos Henrique G. Paulino
-- #description: Portal Institucional Rede Minas
-- #description: somente menu agenda
-- #ginga - ncl / lua

version = "agenda"

-- reads functions
dofile("lib_main.lua")
dofile("lib_icon.lua")
dofile("lib_tables.lua")
dofile("lib_agenda.lua")

agenda=agendaMenu:new{}

function handler (evt)
  if (evt.class == 'key' and evt.type == 'press') then
    -- icon
    if (evt.key == "ENTER" and menuOn ~= true and pgmOn ~=true)  then
      coroutine.resume(comainIcon)
      agenda:iconDraw()
      agenda:menuItem()
      --testes agenda
    elseif(pgmOn) then
      if ( evt.key=="EXIT") then
        mainIconState=1
        pgmOn = false
        menuOn = false
        comainIcon = coroutine.create(mainIconAnim)
        mainIconUpdate()
      elseif (evt.key=="CURSOR_UP") then
        agenda.pos=shift(agenda.pos,-1,5)
        agenda:iconDraw()
        agenda:menuItem()
      elseif ( evt.key=="CURSOR_DOWN") then
        agenda.pos=shift(agenda.pos,1,5)
        agenda:iconDraw()
        agenda:menuItem()
--      elseif (evt.key=="CURSOR_LEFT") then
--        agenda.aposh=shift(agenda.aposh,-1,7)
--        agenda:agenda()
--      elseif ( evt.key=="CURSOR_RIGHT") then
--        agenda.aposh=shift(agenda.aposh,1,7)
--        agenda:agenda()
      end
    end
  elseif (evt.action == "start") then
    mainIconUpdate()
  end
end
event.register(handler)
