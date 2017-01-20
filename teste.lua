-- #author: Carlos Henrique G. Paulino
-- #description: Portal Institucional redeminas
-- #ginga - ncl / lua


-- parametros globais
screen_width, screen_height = canvas:attrSize()
grid = screen_width/32
version = "1.2t"

start = false
tcpresult = ""
menuOn = false
pgmOn = false
mainIconState = 1

-- reads table menu
dofile("lib_tables.lua")

---- load objects
MainMenu = {
  pos = 1,
  spos = 1,
  icons = 4,
  pgmicons = math.floor(screen_width/210),
  list=layoutPgmTable(ReadTable("tbl_pgm.txt")),
  debug=false,
  settings=false
}

mulhereseMenu = {
  pos = 1,
  ppos = 1,
  pages = 4,
  debug=false,
  settings=false
}


dofile("lib_menu.lua")
m=MainMenu:new{}


evento = {
  class = 'ncl',
  type  = 'attribution',
  name  = 'propriedade'
}

-- start

countMetric()

mainIconUpdate()

function handler (evt)
  if (evt.class == 'key' and evt.type == 'press') then
    -- icon
    if (evt.key == "ENTER" and menuOn ~= true and pgmOn ~=true)  then
      mse=mulhereseMenu:new{}
      mse:draw(9)
      mse:page()
    elseif ( evt.key=="EXIT") then
      mainIconUpdate()
      --browse on mulherese
    elseif (  evt.key=="CURSOR_RIGHT") then
      mse.pos=shift(mse.pos,1,#mse.list)
      mse:draw()
      mse:page()
    elseif (  evt.key=="CURSOR_LEFT") then
      mse.pos=shift(mse.pos,-1,#mse.list)
      mse:draw()
      mse:page()
    elseif (   evt.key=="CURSOR_UP") then
      print("chegou")
      mse.ppos=shift(mse.ppos,1,mse.pages)
      mse:page()
    elseif (  evt.key=="CURSOR_DOWN") then
      mse.ppos=shift(mse.ppos,-1,mse.pages)
      mse:page()
    end
    mainIconUpdate()
  end
end
event.register(handler)
