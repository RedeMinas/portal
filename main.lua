-- #author: Carlos Henrique G. Paulino
-- #description: Portal Institucional Rede Minas
-- #ginga - ncl / lua

-- reads functions
dofile("lib_main.lua")
dofile("lib_icon.lua")
dofile("lib_tables.lua")
dofile("lib_menu.lua")

m=MainMenu:new{}

countMetric()

function handler (evt)
  if (evt.class == 'key' and evt.type == 'press') then
    -- icon
    if (evt.key == "ENTER" and not menuOn and not pgmOn)  then
      menuOn = true
      coroutine.resume(comainIcon)
      m:iconDraw(m.icons)
      m:menuItem()
      -- realocate icon
    elseif (evt.key == "CURSOR_UP" and not menuOn and not pgmOn )then
      mainIconPos=shift(mainIconPos,1,4)
    elseif (evt.key == "CURSOR_DOWN" and not menuOn and not pgmOn) then
      mainIconPos=shift(mainIconPos,-1,4)
    elseif (evt.key == "CURSOR_LEFT" and not menuOn and not pgmOn ) then
      mainIconPos=shift(mainIconPos,-1,4)
    elseif ( evt.key == "CURSOR_RIGHT" and not menuOn and not pgmOn ) then
      mainIconPos=shift(mainIconPos,1,4)
      -- main menu
    elseif (menuOn ==true and pgmOn == false ) then
      m:input(evt)
      --pgms
    elseif( menuOn and pgmOn) then
      if ( evt.key=="EXIT") then
        pgmOn = false
        m:iconDraw()
        m:menuItem()
      elseif (m.list[m.spos]["img"]==1) then
        --browse on agenda
        agenda:input(evt)
      elseif (m.list[m.spos]["img"]==8) then
        --browse on harmonia
        harmonia:input(evt)
      elseif (m.list[m.spos]["img"]==13) then
        --browse on mulherese
        mulherese:input(evt)
      end
    end
  elseif (evt.action == "start") then
    mainIconUpdate()
  end
end
event.register(handler)
