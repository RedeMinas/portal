

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
--  self.pgmicons = math.floor(screen_width/210)
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
  canvas:clear(0,0,grid*32,grid*16)

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
    canvas:drawText(grid*4*(i-1)+grid, 10 , v.dayname)
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
          canvas:drawRect("frame",(grid*(i-1)*4)+grid+1,(grid*(w-1)*3)+grid+1,grid*4-2,grid*3-2)
          canvas:drawText((grid*(i-1)*4)+grid*1.5, (grid*(w-1)*3)+grid*1.5,  "!" .. d)
        else
          canvas:attrColor("gray")
          canvas:drawRect("frame",(grid*(i-1)*4)+grid,(grid*(w-1)*3)+grid,grid*4,grid*3)
          canvas:drawText((grid*(i-1)*4)+grid*1.5, (grid*(w-1)*3)+grid*1.5,  d)
        end
        if(i==self.aposh and w==self.aposv) then
          print("ok")
          canvas:attrColor("yellow")
          canvas:drawRect("fill",(grid*(self.aposh-1)*4)+grid,(grid*(self.aposv-1)*3)+grid,160,120)
          canvas:attrColor("black")
          canvas:drawText((grid*(i-1)*4)+grid*1.5, (grid*(w-1)*3)+grid*1.5,  d)
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
  canvas:clear(0,grid*17,screen_width,grid*18)
  canvas:attrColor("black")
  canvas:attrFont("Vera", 20,"bold")
  canvas:drawText(grid*1, grid*17, "aposh:" .. self.aposh)
  canvas:drawText(grid*5, grid*17, "aposv:" .. self.aposv)
  canvas:drawText(grid*15, grid*17, "data os:" .. os.date("%d.%m.%Y"))

  canvas:flush()
end


-- harmonia icons vert scroll
function calendar:iconDraw()
  if (not pgmOn) then
    self.pageReset()
    pgmOn = true
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
    canvas:compose(grid, grid*11+sumdy, icon )
    sumdy=sumdy+dy
  end
  self:pageDraw()
  canvas:flush()
end



function calendar:pageDraw()
  canvas:attrColor(93,196,179,217)
  canvas:attrColor("blue")
  canvas:clear(grid*7,grid*11, grid*32, grid*18 )

  if self.pos == 1 then
    print ("chegou")
  end
end



function agendaMenu:pageReset()
  canvas:attrColor(0,0,0,0)
  canvas:clear(0,0, grid*32, grid*18 )

  canvas:attrColor(93,196,179,217)
  canvas:clear(0,grid*11, grid*32, grid*18 )

  --canvas:attrColor(self.bgcolor["r"],self.bgcolor["g"],self.bgcolor["b"],self.bgcolor["a"])
  --  canvas:drawRect("fill", grid, grid, grid*30, grid*13.5 )

  -- draw redeminas logo
  local logo = canvas:new("media/btn1off.png")
  canvas:compose(grid, grid*16, logo )

  -- Draw nav buttons
  local btnarrowv = canvas:new("media/btnarrowv.png")
  local btnarrowh = canvas:new("media/btnarrowh.png")
  local btnexit = canvas:new("media/btnsair.png")
  canvas:compose(grid, grid*17, btnarrowv)
  canvas:compose(grid*2.5, grid*17, btnarrowh)
  canvas:compose(grid*4, grid*17, btnexit)
  canvas:flush()
end
