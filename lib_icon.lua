
function mainIcon()
  local icon = canvas:new("media/icon.png")
  canvas:attrColor(0,0,0,0)
  canvas:clear(0,0, GRID*32, GRID*18)
  canvas:compose(GRID*28,GRID*15,icon)
  canvas:flush()
end


function mainIconAnimBak()
  local icon = canvas:new("media/icon.png")
  local icon2 = canvas:new("media/icon2.png")
  while( MENUON == false) do
    canvas:attrColor(0,0,0,0)
    canvas:clear(0,0, GRID*32, GRID*18)
    if ICON.state < 50 then
      ICON.state=ICON.state+1
      canvas:compose(GRID*28,GRID*15,icon)
    elseif ICON.state >= 50 and ICON.state < 100 then
      ICON.state = ICON.state+1
      canvas:compose(GRID*28,GRID*15,icon2)
    elseif ICON.state == 100 then
      ICON.state =1
    end
    canvas:flush()
    coroutine.yield() -- sleep...
  end
end


function mainIconAnim()
  canvas:attrColor(0,0,0,0)
  canvas:clear(0,0, GRID*32, GRID*18)
  local icon = canvas:new("media/icon.png")
  local icon2 = canvas:new("media/icon2.png")
  local posx=GRID*29
  local posy=GRID*16
  local cycles = 50
  local iconDx,iconDy = icon:attrSize()

  while(not MENUON) do
    canvas:attrColor(0,0,0,0)
    canvas:clear(posx,posy,iconDx,iconDy)

    if (ICON.pos == 1) then
      posx=GRID*29
      posy=GRID*16
    elseif (ICON.pos ==2) then
      posx=GRID*1
      posy=GRID*16
    elseif (ICON.pos ==3) then
      posx=GRID*1
      posy=GRID*1
    else
      posx=GRID*29
      posy=GRID*1
    end

    if ICON.state < cycles then
      ICON.state=ICON.state+1
      canvas:compose(posx,posy,icon)
    elseif ICON.state >= cycles and ICON.state < (cycles*2) then
      ICON.state = ICON.state+1
      canvas:compose(posx,posy,icon2)
    elseif ICON.state == (cycles*2) then
      ICON.state =1
    end
    canvas:flush()
    coroutine.yield() -- sleep...
  end
end


comainIcon = coroutine.create(mainIconAnim)

function mainIconUpdate()
  --print (coroutine.status(comainIcon))
  coroutine.resume(comainIcon)
  if   coroutine.status(comainIcon) ~= 'dead' then
    event.timer(100,mainIconUpdate)
  end
end
