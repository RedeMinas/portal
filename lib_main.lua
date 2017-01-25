--main icon and tcp metrics

require 'lib_tcp'

function countMetric()
  -- ping internet
  if start == false then
    tcp.execute(
      function ()
        tcp.connect('www.redeminas.mg.gov.br', 80)
        tcp.send('get /ginga.php?aplicacao=portal' .. version .. '\n')
        tcpresult = tcp.receive()
        --print(tcpresult)
        if tcpresult then
          tcpresult = tcpresult or '0'
        else
          tcpresult = 'er:' .. evt.error
        end
        canvas:flush()
        tcp.disconnect()
        start = true
      end
    )
  end
end

function shift(x,v,limit)
  -- not as num?
  if v == nil then v = 0 end
  if x + v < 1 then
    return x + v + limit
  elseif  x + v > limit  then
    return x + v - limit
  else
    return x+v
  end
end

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

-- protoype wrap text

function wrap(s, w, i1, i2)
  w = w or 78
  i1 = i1 or 0
  i2 = i2 or 0
  --affirm(i1 < w and i2 < w,
  --     "wrap: the indents must be less than the line width")
  s = string.gsub(" ", i1) .. s
  local lstart, len = 1, strlen(s)
  while len - lstart > w do
    local i = lstart + w
    while i > lstart and strsub(s, i, i) ~= " " do i = i - 1 end
    local j = i
    while j > lstart and strsub(s, j, j) == " " do j = j - 1 end
    s = strsub(s, 1, j) .. "\n" .. strrep(" ", i2) ..
      strsub(s, i + 1, -1)
    local change = i2 + 1 - (i - j)
    lstart = j + change
    len = len + change
  end
  return s
end
