-- parametros globais
screen_width, screen_height = canvas:attrSize()
grid = screen_width/32


-- reads table menu
dofile("tbl_pgm.lua")

-- how many itens to exibhit
menu_itens = 4
icon_itens = 4

-- how many itens to exibhit
pgmShowItens = 6
-- how many total pgms
pgmTotalItens = 18

MainMenu = { pos = 1, spos = 1,  list=menu,  debug=false, settings=false }

dofile("lib_menu.lua")

evento = {
  class = 'ncl',
  type  = 'attribution',
  name  = 'propriedade'
}

-- start
m=MainMenu:new{}
m:iconDraw(menu_itens)
m:menuItem()

function handler (evt)
  if (evt.class == 'key' and evt.type == 'press') then
    if evt.key == "CURSOR_UP" then
      m.pos=m:shift(m.pos,-1,menu_itens)
      m:iconDraw(menu_itens)
      m:menuItem()
    elseif evt.key == "CURSOR_DOWN" then
      m.pos=m:shift(m.pos,1, menu_itens )
      m:iconDraw(menu_itens)
      m:menuItem()
    elseif ( m.pos==2 and evt.key == "CURSOR_LEFT") then
      m.spos=m:shift(m.spos,-1, pgmTotalItens)
      m:pgmDraw(pgmShowItens)
      m:pgmDrawInfo()
    elseif ( m.pos==2 and evt.key == "CURSOR_RIGHT") then
      m.spos=m:shift(m.spos,1, pgmTotalItens)
      m:pgmDraw(pgmShowItens)
      m:pgmDrawInfo()
    elseif ( m.pos==3 and evt.key == "RED") then
      m:menuItem('red')
    elseif ( m.pos==4 and evt.key == "RED") then
      m:menuItem('red')
    elseif ( m.pos==4 and evt.key == "GREEN") then
      m:menuItem('green')
    elseif ( m.pos==4 and evt.key == "YELLOW") then
      m:menuItem('yellow')
    elseif ( m.pos==4 and evt.key == "BLUE") then
      m:menuItem('blue')
    elseif ( evt.key=="ENTER" or evt.key=="EXIT") then
      event.post("out",{
                   class = 'ncl',
                   type='presentation',
                   label='lMain',
                   action='start'
      })
      event.post("out",{
                   class = 'ncl',
                   type='presentation',
                   label='inc',
                   action='start'
      })



    end
  end
end
event.register(handler)
