--- main global parameteres
SCREEN_WIDTH, SCREEN_HEIGHT = canvas:attrSize()

GRID = SCREEN_WIDTH/32
--review!!!
tcpresult = ""
MENUON = false
PGMON = false
ICON = {}
ICON.state = 1
ICON.pos =1
DEBUG = true
VERSION = "1.2.5"
START = false

--- tcp metrics
require 'lib_tcp'

--- Send Info over tcpip
function countMetric(param)
  -- ping internet
  --if START == false then
  if not param then
    param = "portal"
  end
    tcp.execute(
      function ()
        tcp.connect('redeminas.mg.gov.br', 80)
        tcp.send('get /ginga.php?aplicacao=' .. param .. VERSION .. '\n')
        tcpresult = tcp.receive()
        if tcpresult then
          tcpresult = tcpresult or '0'
        else
          tcpresult = 'er:' .. evt.error
        end
        canvas:flush()
        tcp.disconnect()
        START = true
      end
    )
  --end
end

--- Send Info over tcpip
function connecttcp(t)
  -- ping internet
  tcp.execute(
    function ()
      tcp.connect('redeminas.mg.gov.br', 80)
      tcp.send('get /ginga.php?aplicacao=' .. t .. '\n')
      tcpresult = tcp.receive()
      if tcpresult then
        tcpresult = tcpresult or '0'
      else
        tcpresult = 'er:' .. evt.error
      end
      canvas:flush()
      tcp.disconnect()
    end
  )
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

---Input a text string, get a lefty list
-- @parameter text (string)
-- @parameter size (integer)
function textWrap(text,size)
  local list = {}
  local offset = 0
  local offsetSum = 0
  local lasti =0
  local lines = (math.floor(string.len(text)/size)+1)
  for i=1,lines do
    if (i==1) then
      result=string.sub(text,((i-1)*size),(i*size))
    else
      result=string.sub(text,(((i-1)*size-offsetSum)),(i*size+offsetSum))
    end
    -- calculate offset
    offset = 0
    if i ~= lines then
      while (string.sub(result,size-offset,size-offset) ~= " " ) do
        if offset < size then
          offset = offset +1
        end
      end
    end

    result = string.sub(result,0,size-offset)

    -- if line starts with space, remove it
    if string.sub(result,1,1) == " " or string.sub(result,1,1) == "," then
      result = string.sub(result,2,size+offset)
      --      elseif (string.sub(result,size+1,size+1) == ",") then
    end
    offsetSum = offsetSum + offset
--    canvas:drawText(GRID*6, GRID*1.7+i*GRID*0.7 , result)
    lasti = i
    list[i]=result
  end

  --resto
  result=string.sub(text,(((lasti)*size-offsetSum)),(lasti*size+offsetSum))
  list[lasti+1]=result
  return(list)
end

--based on http://lua-users.org/wiki/DayOfWeekAndDaysInMonthExample
function get_day_of_week(dd, mm, yy)
  dw=os.date('*t',os.time{year=yy,month=mm,day=dd})['wday']
  return dw,({"Dom","Seg","Ter","Qua","Qui","Sex","Sab" })[dw]
end

function get_days_in_month(mnth, yr)
  return os.date('*t',os.time{year=yr,month=mnth+1,day=0})['day']
end
