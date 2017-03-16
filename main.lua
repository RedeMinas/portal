---  Portal Institucional Rede Minas
-- @author: Carlos Henrique G. Paulino
-- @copyright: Aphero GPL - Fundação TV Minas Cultural e Educativa
-- ginga - ncl / lua

--- reads functions
dofile("lib_main.lua")
dofile("lib_icon.lua")
dofile("lib_tables.lua")
dofile("lib_menu.lua")

m=MainMenu:new{}

countMetric()

--- deal with keys
-- Some description, can be over several lines.
-- @param evt first parameter
-- @return nil
function handler (evt)
  if (evt.class == 'key' and evt.type == 'press') then
    -- icon
    if (not MENUON and not PGMON) then
      if (evt.key == "ENTER")  then 
        MENUON = true
        coroutine.resume(comainIcon)
        m:iconDraw(m.icons)
        m:menuItem()
        -- realocate icon
      elseif (evt.key == "CURSOR_UP")then
        ICON.pos=shift(ICON.pos,1,4)
      elseif (evt.key == "CURSOR_DOWN") then
        ICON.pos=shift(ICON.pos,-1,4)
      elseif (evt.key == "CURSOR_LEFT") then
        ICON.pos=shift(ICON.pos,-1,4)
      elseif ( evt.key == "CURSOR_RIGHT") then
        ICON.pos=shift(ICON.pos,1,4)
        --- main menu
      end
    elseif (MENUON ==true and PGMON == false ) then
      m:input(evt)
     ---pgms
    elseif( MENUON and PGMON) then
      if ( evt.key=="EXIT") then
        PGMON = false
        m:iconDraw()
        m:menuItem()
      elseif (m.list[m.spos]["img"]==1) then
        --browse on agenda
        agenda:input(evt)
      elseif (m.list[m.spos]["img"]==2) then
        --browse on agenda
        af:input(evt)
      elseif (m.list[m.spos]["img"]==8) then
        --browse on harmonia
        countMetric("harmonia")
        harmonia:input(evt)
      elseif (m.list[m.spos]["img"]==13) then
        --browse on mulherese
        mse:input(evt)
      end
    end
  elseif (evt.action == "start") then
    mainIconUpdate()
  end
end
event.register(handler)
