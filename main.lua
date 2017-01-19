-- parametros globais
screen_width, screen_height = canvas:attrSize()
grid = screen_width/32
version = "1.2t"

start = false
tcpresult = ""
menuOn = false
pgmOn = false
mainIconState = 1


-- how many itens to exibhit
menu_itens = 4
icon_itens = 4

-- how many itens to exibhit
pgmShowItens = 6
-- how many total pgms
pgmTotalItens = 19


-- reads table menu

dofile("lib_tables.lua")

local tab = layoutPgmTable(ReadTable("tbl_pgm.txt"))

---- load objects
MainMenu = { pos = 1, spos = 1,  list=tab,  debug=false, settings=false }


-- TODO:  read from file!!!
local tbl_mulherese = { "Mulhere-se", "Informe-se", "Mulheres Idosas","Mulheres Negras", "Mulheres em situação de rua", "Mulheres Encarceradas","Mulheres Deficientes", "Mulheres Usuárias da saúde mental", "Mulheres Lésbicas", "Mulheres Trans", "Mulheres Prostitutas", "Mulheres Refugiadas", "Mulheres do campo", "Mulheres Quilombolas", "Mulheres Jovens"}

mulhereseMenu = { pos = 1, limit=#tbl_mulherese, pad=30, list=tbl_mulherese, debug=false, settings=false }

dofile("lib_menu.lua")

evento = {
  class = 'ncl',
  type  = 'attribution',
  name  = 'propriedade'
}

-- start
m=MainMenu:new{}
countMetric()

function handler (evt)
  if (evt.class == 'key' and evt.type == 'press') then
    -- icon
    if (evt.key == "ENTER" and menuOn ~= true and pgmOn ~=true)  then
      menuOn = true
      coroutine.resume(comainIcon)
      m:iconDraw(menu_itens)
      m:menuItem()
      -- main menu
    elseif (menuOn and pgmOn == false ) then
      if (evt.key == "CURSOR_UP" )then
        m.pos=shift(m.pos,-1,menu_itens)
        m:iconDraw(menu_itens)
        m:menuItem()
      elseif (evt.key == "CURSOR_DOWN") then
        m.pos=shift(m.pos,1, menu_itens )
        m:iconDraw(menu_itens)
        m:menuItem()
      elseif ( m.pos==2 and evt.key == "CURSOR_LEFT" ) then
        m.spos=shift(m.spos,-1, pgmTotalItens)
        m:pgmDraw(pgmShowItens)
        m:pgmDrawInfo()
      elseif ( m.pos==2 and evt.key == "CURSOR_RIGHT" ) then
        m.spos=shift(m.spos,1, pgmTotalItens)
        m:pgmDraw(pgmShowItens)
        m:pgmDrawInfo()
        -- PGM
      elseif  (m.pos==2 and m.spos==13 and evt.key == "ENTER" ) then
        pgmOn = true
        mse=mulhereseMenu:new{}
        mse:draw(9)
        mse:text(mse.pos)
      elseif ((m.pos>=1 and m.spos < 13)   and evt.key =="ENTER") then
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
      --pgm
    elseif( menuOn and pgmOn) then
      if ( evt.key=="EXIT") then
        pgmOn = false
        m:iconDraw(menu_itens)
      m:menuItem()
        print ("saida")
        --browse on mulherese
      elseif ( m.spos == 13 and evt.key=="CURSOR_RIGHT") then
        mse.pos=shift(mse.pos,1,mse.limit)
        mse:draw()
        mse:text(mse.pos)
      elseif ( m.spos == 13 and evt.key=="CURSOR_LEFT") then
        mse.pos=shift(mse.pos,-1,mse.limit)
        mse:draw()
        mse:text(mse.pos)
      elseif ( m.spos == 13 and evt.key=="CURSOR_UP") then
        mse:text(mse.pos,1)
      elseif ( m.spos == 13 and evt.key=="CURSOR_DOWN") then
        mse:text(mse.pos,-1)
      end
    end
  elseif (evt.action == "start") then
    mainIconUpdate()
  end
end
event.register(handler)
