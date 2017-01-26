
function mainIcon()
  local icon = canvas:new("media/icon.png")
  canvas:attrColor(0,0,0,0)
  canvas:clear(0,0, grid*32, grid*18)
  canvas:compose(grid*28,grid*15,icon)
  canvas:flush()
end

function mainIconAnim()
  local icon = canvas:new("media/icon.png")
  local icon2 = canvas:new("media/icon2.png")
  while( menuOn == false) do
    canvas:attrColor(0,0,0,0)
    canvas:clear(0,0, grid*32, grid*18)
    if mainIconState < 50 then
      mainIconState=mainIconState+1
      canvas:compose(grid*28,grid*15,icon)
    elseif mainIconState >= 50 and mainIconState < 100 then
      mainIconState = mainIconState+1
      canvas:compose(grid*28,grid*15,icon2)
    elseif mainIconState == 100 then
      mainIconState =1
    end
    canvas:flush()
    coroutine.yield() -- sleep...
  end
end

comainIcon = coroutine.create(mainIconAnim)

function mainIconUpdate()
  print (coroutine.status(comainIcon))
  coroutine.resume(comainIcon)
  if   coroutine.status(comainIcon) ~= 'dead' then
    event.timer(100,mainIconUpdate)
  end
end
