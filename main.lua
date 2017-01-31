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
      if (evt.key == "CURSOR_UP" )then
        m.pos=shift(m.pos,-1,m.icons)
        m:iconDraw()
        m:menuItem()
      elseif (evt.key == "CURSOR_DOWN") then
        m.pos=shift(m.pos,1,m.icons )
        m:iconDraw()
        m:menuItem()
      elseif ( m.pos==2 and evt.key == "CURSOR_LEFT" ) then
        m.spos=shift(m.spos,-1, #m.list)
        m:pgmDraw()
      elseif ( m.pos==2 and evt.key == "CURSOR_RIGHT" ) then
        m.spos=shift(m.spos,1, #m.list)
        m:pgmDraw()
        -- PGM
        --dangobalango start
      elseif(m.pos == 2 and m.list[m.spos]["img"]==6 and evt.key=="ENTER") then
        canvas:attrColor(0,0,0,0)
        canvas:clear(0,0, grid*32, grid*11 )
        local img = canvas:new("media/pgm06.png")
        canvas:compose(0, 0, img)
        canvas:flush()
        --harmonia start
      elseif  (m.pos==2 and m.list[m.spos]["img"]==8 and evt.key == "ENTER" ) then
        dofile("lib_harmonia.lua")
        harmonia=harmoniaMenu:new{}
        harmonia:iconDraw()
        harmonia:menuItem()
        --mulherese start
      elseif  (m.pos==2 and m.list[m.spos]["img"]==13 and evt.key == "ENTER" ) then
        dofile("lib_mulherese.lua")
        mse=mulhereseMenu:new{}
        mse:iconsDraw()
        --qrcodes on contatos 
      elseif ( m.pos==4 and evt.key == "RED" ) then
        m:menuItem('red')
      elseif ( m.pos==4 and evt.key == "GREEN" ) then
        m:menuItem('green')
      elseif ( m.pos==4 and evt.key == "YELLOW" ) then
        m:menuItem('yellow')
      elseif ( m.pos==4 and evt.key == "BLUE" ) then
        m:menuItem('blue')
      elseif ( evt.key=="EXIT" ) then
        mainIconState=1
        menuOn = false
        comainIcon = coroutine.create(mainIconAnim)
        mainIconUpdate()
      end
      --pgms
    elseif( menuOn and pgmOn) then
      if ( evt.key=="EXIT") then
        pgmOn = false
        m:iconDraw()
        m:menuItem()
        --browse on mulherese
      elseif (m.spos == 13) then
        if (evt.key=="CURSOR_RIGHT") then
          mse.pos=shift(mse.pos,1,#mse.list)
          mse:iconsDraw()
        elseif (evt.key=="CURSOR_LEFT") then
          mse.pos=shift(mse.pos,-1,#mse.list)
          mse:iconsDraw()
        elseif (evt.key=="CURSOR_UP") then
          mse.ppos=shift(mse.ppos,-1,mse.pages)
          mse:pageDraw()
        elseif ( evt.key=="CURSOR_DOWN") then
          mse.ppos=shift(mse.ppos,1,mse.pages)
          mse:pageDraw()
        end
        --browse on harmonia
      elseif (m.spos == 8) then
        if (evt.key=="CURSOR_UP") then
          print("up")
          harmonia.pos=shift(harmonia.pos,-1,harmonia.icons)
          harmonia:iconDraw()
          harmonia:menuItem()
        elseif ( evt.key=="CURSOR_DOWN") then
          print("down")
          harmonia.pos=shift(harmonia.pos,1,harmonia.icons)
          harmonia:iconDraw()
          harmonia:menuItem()
        elseif ( harmonia.pos==4 and evt.key == "RED" ) then
          print("ok")
          harmonia:menuItem('red')
        elseif ( harmonia.pos==4 and evt.key == "GREEN" ) then
          harmonia:menuItem('green')
        elseif ( harmonia.pos==4 and evt.key == "YELLOW" ) then
          harmonia:menuItem('yellow')
        elseif ( harmonia.pos==4 and evt.key == "BLUE" ) then
          harmonia:menuItem('blue')
        end
      end
    end
  elseif (evt.action == "start") then
    mainIconUpdate()
  end
end
event.register(handler)
