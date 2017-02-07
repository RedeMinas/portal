
--- agenda object

calendar = {}

function calendar:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.pos = 1
  self.spos = 1
  self.icons = 7
  self.aposh = 1
  self.aposv = 1
--  self.pgmicons = math.floor(SCREEN_WIDTH/210)
--  self.list=layoutPgmTable(ReadTable("tbl_pgm.txt"))
  self.debug=false
--  self.settings=false
  return o
end


function calendar:agenda()
  self:agendaGrid()
  self:agendaDisplayDay()
end


-- based  on http://lua-users.org/wiki/DisplayCalendarInHtml
function calendar:agendaGrid()
  canvas:attrColor(0,0,0,0)
  canvas:clear(0,0,GRID*32,GRID*16)

  local d=0
  local yy,mm,dd, M = os.date("%Y"), os.date("%m"), os.date("%d"), os.date("%w")
  local month_days = get_days_in_month(mm,yy)
  local day_week = get_day_of_week(1, mm, yy)

  local day_start = 2
  local days_of_week = {{"Dom",1},{"Seg",2},{"Ter",3},{"Qua",4},{"Qui",5},{"Sex",6},{"Sab",7}}
  local days_of_week_ordered =  {}

  --order table
  for k=1, 7 do
    local v = {}
    v.dayname = days_of_week[k][1]
    v.daynum = days_of_week[k][2]
    table.insert(days_of_week_ordered,v)
  end

  for i,v in ipairs(days_of_week_ordered) do
    canvas:attrColor("red")
    canvas:attrFont("Vera", 20,"bold")
    canvas:drawText(GRID*4*(i-1)+GRID, 10 , v.dayname)
    if (day_week == v.daynum) then
      d= -i+2
    end
  end

  canvas:attrFont("Vera", 20,"bold")

  local w = 1
  while(d<month_days) do
    for i,v in ipairs (days_of_week) do
      if (d>=1 and d<=month_days) then
        if (d==tonumber(dd)) then
          canvas:attrColor("red")
          canvas:drawRect("frame",(GRID*(i-1)*4)+GRID+1,(GRID*(w-1)*3)+GRID+1,GRID*4-2,GRID*3-2)
          canvas:drawText((GRID*(i-1)*4)+GRID*1.5, (GRID*(w-1)*3)+GRID*1.5,  "!" .. d)
        else
          canvas:attrColor("gray")
          canvas:drawRect("frame",(GRID*(i-1)*4)+GRID,(GRID*(w-1)*3)+GRID,GRID*4,GRID*3)
          canvas:drawText((GRID*(i-1)*4)+GRID*1.5, (GRID*(w-1)*3)+GRID*1.5,  d)
        end
        if(i==self.aposh and w==self.aposv) then
          print("ok")
          canvas:attrColor("yellow")
          canvas:drawRect("fill",(GRID*(self.aposh-1)*4)+GRID,(GRID*(self.aposv-1)*3)+GRID,GRID*4,GRID*3)
          canvas:attrColor("black")
          canvas:drawText((GRID*(i-1)*4)+GRID*1.5, (GRID*(w-1)*3)+GRID*1.5,  d)
        end
      end
      d = d+1
      print(d)
    end
    w = w+1
  end
end

function calendar:agendaDisplayDay()
  canvas:attrColor("yellow")
  canvas:clear(0,GRID*17,SCREEN_WIDTH,GRID*18)
  canvas:attrColor("black")
  canvas:attrFont("Vera", 20,"bold")
  canvas:drawText(GRID*1, GRID*17, "aposh:" .. self.aposh)
  canvas:drawText(GRID*5, GRID*17, "aposv:" .. self.aposv)
  canvas:drawText(GRID*15, GRID*17, "data os:" .. os.date("%d.%m.%Y"))

  canvas:flush()
end


-- harmonia icons vert scroll
function calendar:iconDraw()
  if (not PGMON) then
    self.pageReset()
    PGMON = true
  end

  local iconpath=""
  local sumdy=0

  for i=1,self.icons  do
    if i==self.pos then
      iconpath = "media/harmonia/btn" ..  tostring(i) .. "on.png"
    else
      iconpath = "media/harmonia/btn" ..  tostring(i) .. "off.png"
    end
    local icon = canvas:new(iconpath)
    local dx,dy = icon:attrSize()
    canvas:compose(GRID, GRID*11+sumdy, icon )
    sumdy=sumdy+dy
  end
  self:pageDraw()
  canvas:flush()
end



function calendar:pageDraw()
  canvas:attrColor(93,196,179,217)
  canvas:attrColor("blue")
  canvas:clear(GRID*7,GRID*11, GRID*32, GRID*18 )

  if self.pos == 1 then
    print ("chegou")
  end
end
