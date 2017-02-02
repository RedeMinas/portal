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
<<<<<<< HEAD
        harmonia:input(evt)
      elseif (m.list[m.spos]["img"]==13) then
        --browse on mulherese
        mulherese:input(evt)
=======
      elseif (m.spos == 8) then
        if (evt.key=="CURSOR_UP") then

          harmonia.pos=shift(harmonia.pos,-1,harmonia.icons)
          harmonia:iconDraw()
          harmonia:menuItem()
        elseif ( evt.key=="CURSOR_DOWN") then
          harmonia.pos=shift(harmonia.pos,1,harmonia.icons)
          harmonia:iconDraw()
          harmonia:menuItem()
        elseif ( harmonia.pos==4 and evt.key == "RED" ) then
          harmonia:menuItem('red')
        elseif ( harmonia.pos==4 and evt.key == "GREEN" ) then
          harmonia:menuItem('green')
        elseif ( harmonia.pos==4 and evt.key == "YELLOW" ) then
          harmonia:menuItem('yellow')
        elseif ( harmonia.pos==4 and evt.key == "BLUE" ) then
          harmonia:menuItem('blue')
        end
>>>>>>> bba606726c0fe3a0e64a94a1d64cbbdcf22c8739
      end
    end
  elseif (evt.action == "start") then
    mainIconUpdate()
  end
end
event.register(handler)
