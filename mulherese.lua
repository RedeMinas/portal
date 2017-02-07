-- #author: Carlos Henrique G. Paulino
-- #description: Portal Institucional redeminas
-- #description: mulherese teste
-- #ginga - ncl / lua

VERSION = "mulherese teste"

START = false
MENUON = false
PGMON = false
ICON.state = 1

-- reads table menu

dofile("lib_icon.lua")
dofile("lib_main.lua")
dofile("lib_tables.lua")

function handler (evt)
  if (evt.class == 'key' and evt.type == 'press') then
    -- icon
    if (evt.key == "ENTER" and not MENUON)  then
      dofile("lib_mulherese.lua")
      MENUON=true
      coroutine.resume(comainIcon)
      mse=mulhereseMenu:new{}
      mse:iconsDraw()
    elseif (PGMON == true) then
      if ( evt.key=="EXIT") then
        print ("menu exit")
        ICON.state=1
        MENUON = false
        comainIcon = coroutine.create(mainIconAnim)
        mainIconUpdate()
        --browse on mulherese
      elseif (evt.key=="CURSOR_RIGHT") then
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
    end
  elseif (evt.action == "start") then
    mainIconUpdate()
  end
end
event.register(handler)
