-- #author: Carlos Henrique G. Paulino
-- #description: Portal Institucional redeminas
-- #ginga - ncl / lua


-- parametros globais
screen_width, screen_height = canvas:attrSize()
--canvas:attrAntiAlias("subpixel")
grid = screen_width/32
version = "1.2t"

start = false
tcpresult = ""
menuOn = false
pgmOn = false
mainIconState = 1

-- reads table menu
dofile("lib_tables.lua")

dofile("lib_menu.lua")

m=MainMenu:new{}

--evento = {
--  class = 'ncl',
--  type  = 'attribution',
--  name  = 'propriedade'
--}

-- start
countMetric()

function handler (evt)
  if (evt.class == 'key' and evt.type == 'press') then
    -- icon
    if (evt.key == "ENTER" and menuOn ~= true and pgmOn ~=true)  then
      menuOn = true
      coroutine.resume(comainIcon)
      m:iconDraw(m.icons)
      m:menuItem()
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
        m:pgmDrawInfo()
      elseif ( m.pos==2 and evt.key == "CURSOR_RIGHT" ) then
        print(#m.list)
        m.spos=shift(m.spos,1, #m.list)
        print (m.spos)
        m:pgmDraw()
        m:pgmDrawInfo()
        -- PGM
      elseif  (m.pos==2 and m.spos==13 and evt.key == "ENTER" ) then
        print("ok")
        pgmOn = true
        mse=mulhereseMenu:new{}
        mse:draw()
        mse:page()
      elseif (m.pos ==2 and (m.spos>=3 and m.spos < 13) and evt.key =="ENTER") then
        print("chegou")
        pgmOn = true
        dofile('lib_pgm.lua')
        pgm(m.spos)
      elseif ( m.pos==4 and evt.key == "RED" ) then
        m:menuItem('red')
      elseif ( m.pos==4 and evt.key == "GREEN" ) then
        m:menuItem('green')
      elseif ( m.pos==4 and evt.key == "YELLOW" ) then
        m:menuItem('yellow')
      elseif ( m.pos==4 and evt.key == "BLUE" ) then
        m:menuItem('blue')
      elseif ( evt.key=="EXIT" ) then
        print ("menu exit")
        mainIconState=1
        menuOn = false
        --comainIcon = coroutine.create(mainIcon)
        mainIcon()
      end
    --pgms
    elseif( menuOn and pgmOn) then
      if ( evt.key=="EXIT") then
        pgmOn = false
        m:iconDraw(menu_itens)
        m:menuItem()
      --browse on mulherese
      elseif (m.spos == 13) then
        if (evt.key=="CURSOR_RIGHT") then
          mse.pos=shift(mse.pos,1,#mse.list)
          mse:draw()
          mse:page()
        elseif (evt.key=="CURSOR_LEFT") then
          mse.pos=shift(mse.pos,-1,#mse.list)
          mse:draw()
          mse:page()
        elseif (evt.key=="CURSOR_UP") then
          mse.ppos=shift(mse.ppos,-1,mse.pages)
          mse:page()
        elseif ( evt.key=="CURSOR_DOWN") then
          mse.ppos=shift(mse.ppos,1,mse.pages)
          mse:page()
        end
      elseif (m.spos == 1) then
        if (evt.key=="CURSOR_RIGHT") then
          mse.pos=shift(mse.pos,1,#mse.list)
          mse:draw()
          mse:page()
        elseif (evt.key=="CURSOR_LEFT") then
          mse.pos=shift(mse.pos,-1,#mse.list)
          mse:draw()
          mse:page()
        elseif (evt.key=="CURSOR_UP") then
          mse.ppos=shift(mse.ppos,-1,mse.pages)
          mse:page()
        elseif ( evt.key=="CURSOR_DOWN") then
          mse.ppos=shift(mse.ppos,1,mse.pages)
          mse:page()
        end
      end
    end
  elseif (evt.action == "start") then
    mainIconUpdate()
  end
end
event.register(handler)
