-- #author: Carlos Henrique G. Paulino
-- #description: Portal Institucional Rede Minas
-- #ginga - ncl / lua



-- reads functions
dofile("lib_main.lua")
--dofile("lib_icon.lua")
--dofile("lib_tables.lua")
--dofile("lib_menu.lua")


--m=MainMenu:new{}


--m.iconDraw()
print("ok")


local icon = canvas:new("media/btn1off.png")
canvas:compose(50,50,icon)
canvas:flush()

