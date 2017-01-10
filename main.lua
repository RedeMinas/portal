-- parametros globais
screen_width, screen_height = canvas:attrSize()
grid = screen_width/32
version = 1.2

start = false
tcpresult = ""
menuOn = false

-- reads table menu

dofile("lib_tables.lua")
local tab = layoutPgmTable(ReadTable("tbl_pgm.txt"))

-- metodo antigo:
-- dofile("tbl_pgm.lua")

-- how many itens to exibhit
menu_itens = 4
icon_itens = 4

-- how many itens to exibhit
pgmShowItens = 6
-- how many total pgms
pgmTotalItens = 19

MainMenu = { pos = 1, spos = 1,  list=tab,  debug=false, settings=false }

dofile("lib_menu.lua")

evento = {
  class = 'ncl',
  type  = 'attribution',
  name  = 'propriedade'
}

-- start
m=MainMenu:new{}

mainIcon()


function handler (evt)
  if (evt.class == 'key' and evt.type == 'press') then
    if evt.key == "ENTER" and menuOn == false then
      menuOn = true
      m:iconDraw(menu_itens)
      m:menuItem()
    end

    if evt.key == "CURSOR_UP" and menuOn then
      m.pos=m:shift(m.pos,-1,menu_itens)
      m:iconDraw(menu_itens)
      m:menuItem()
    elseif evt.key == "CURSOR_DOWN" and menuOn then
      m.pos=m:shift(m.pos,1, menu_itens )
      m:iconDraw(menu_itens)
      m:menuItem()
    elseif ( m.pos==2 and evt.key == "CURSOR_LEFT" and menuOn) then
      m.spos=m:shift(m.spos,-1, pgmTotalItens)
      m:pgmDraw(pgmShowItens)
      m:pgmDrawInfo()
    elseif ( m.pos==2 and evt.key == "CURSOR_RIGHT" and menuOn) then
      m.spos=m:shift(m.spos,1, pgmTotalItens)
      m:pgmDraw(pgmShowItens)
      m:pgmDrawInfo()
    elseif ( m.pos==3 and evt.key == "RED" and menuOn) then
      m:menuItem('red')
    elseif ( m.pos==4 and evt.key == "RED" and menuOn) then
      m:menuItem('red')
    elseif ( m.pos==4 and evt.key == "GREEN" and menuOn) then
      m:menuItem('green')
    elseif ( m.pos==4 and evt.key == "YELLOW" and menuOn) then
      m:menuItem('yellow')
    elseif ( m.pos==4 and evt.key == "BLUE" and menuOn) then
      m:menuItem('blue')
    elseif ( evt.key=="EXIT" and menuOn) then
      menuOn = false
      mainIcon()
    end
  end
end
event.register(handler)
