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
      if ( evt.key=="EXIT") then
        ICON.state=1
        PGMON = false
        MENUON = false
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
        print("up")
        agenda.pos=shift(agenda.pos,-1,agenda.icons)
        agenda:iconDraw()
        agenda:menuItem()
      elseif ( evt.key=="CURSOR_DOWN") then
        print("down")
        agenda.pos=shift(agenda.pos,1,agenda.icons)
        agenda:iconDraw()
        agenda:menuItem()
      elseif ( agenda.pos==4 and evt.key == "RED" ) then
        print("ok")
        agenda:menuItem('red')
      elseif ( agenda.pos==4 and evt.key == "GREEN" ) then
        agenda:menuItem('green')
      elseif ( agenda.pos==4 and evt.key == "YELLOW" ) then
        agenda:menuItem('yellow')
      elseif ( agenda.pos==4 and evt.key == "BLUE" ) then
        agenda:menuItem('blue')
      end
    end
  elseif (evt.action == "start") then
    mainIconUpdate()
  end
end
event.register(handler)
