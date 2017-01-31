
function mainIcon()
  local icon = canvas:new("media/icon.png")
  canvas:attrColor(0,0,0,0)
  canvas:clear(0,0, grid*32, grid*18)
  canvas:compose(grid*28,grid*15,icon)
  canvas:flush()
end

function mainIconAnim()
  local posx,posy
  local cycles = 50
  local icon = canvas:new("media/icon.png")
  local icon2 = canvas:new("media/icon2.png")
  local iconDx,iconDy = icon:attrSize()

  --clear only on start
  canvas:attrColor(0,0,0,0)
  canvas:clear(0,0,screenWidth,screenHeight)


  while( menuOn == false) do
    --clear icon region only, faster update
    canvas:attrColor(0,0,0,0)
    canvas:clear(posx,posy,iconDx,iconDy)
    if (mainIconPos == 1) then
      posx=grid*29
      posy=grid*16
    elseif (mainIconPos ==2) then
      posx=grid*1
      posy=grid*16
    elseif (mainIconPos ==3) then
      posx=grid*1
      posy=grid*1
    else
      posx=grid*29
      posy=grid*1
    end

    if mainIconState < cycles then
      mainIconState=mainIconState+1
      canvas:compose(posx,posy,icon)
    elseif mainIconState >= cycles and mainIconState < cycles*2 then
      mainIconState = mainIconState+1
      canvas:compose(posx,posy,icon2)
    elseif mainIconState == cycles*2 then
      mainIconState =1
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
