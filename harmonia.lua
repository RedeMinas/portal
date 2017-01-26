-- #author: Carlos Henrique G. Paulino
-- #description: Portal Institucional Rede Minas
-- #description: somente menu harmonia 
-- #ginga - ncl / lua

version = "1.2.4t"

-- reads functions
dofile("lib_icon.lua")
dofile("lib_main.lua")
dofile("lib_tables.lua")
dofile("lib_harmonia.lua")

harmonia=harmoniaMenu:new{}

function handler (evt)
  if (evt.class == 'key' and evt.type == 'press') then
    -- icon
    if (evt.key == "ENTER" and menuOn ~= true and pgmOn ~=true)  then
      menuOn = true
      pgmOn = true
      coroutine.resume(comainIcon)
      harmonia:iconDraw()
      harmonia:menuItem()
      -- main menu
    elseif( menuOn and pgmOn) then
      if ( evt.key=="EXIT") then
        pgmOn = false
        harmonia:iconDraw()
        harmonia:menuItem()
      --browse on mulherese
      elseif (evt.key=="CURSOR_UP") then
        harmonia.pos=shift(harmonia.pos,-1,harmonia.icons)
        harmonia:iconDraw()
      elseif ( evt.key=="CURSOR_DOWN") then
        harmonia.pos=shift(harmonia.pos,1,harmonia.icons)
        harmonia:iconDraw()
      end
    end

  elseif (evt.action == "start") then
    mainIconUpdate()
  end
end
event.register(handler)
