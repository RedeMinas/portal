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
pgmOn = false

function handler (evt)
  if (evt.class == 'key' and evt.type == 'press') then
    -- icon
    if (evt.key == "ENTER" and menuOn ~= true and pgmOn ~=true)  then
      menuOn = true
      harmonia:iconDraw()
      -- main menu
    elseif (evt.key == "EXIT" and menuOn and pgmOn)  then
      mainIconState=1
      menuOn = false
      pgmOn = false
      comainIcon = coroutine.create(mainIconAnim)
      mainIconUpdate()
      coroutine.resume(comainIcon)
      --barHorizontal()
      -- main menu
    elseif( menuOn and pgmOn) then
      harmonia:input(evt)
    end
  elseif (evt.action == "start") then
    mainIconUpdate()
   --harmonia:iconDraw()
  end
end
event.register(handler)
