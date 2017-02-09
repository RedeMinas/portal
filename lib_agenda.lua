--- agenda object

agendaMenu = {}

function agendaMenu:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.pos = 1
  self.spos = 1
  self.icons = 4
  self.aposh = 1
  self.aposv = 1
  self.page = 1
  self.pages = 4
  self.categories = {"Artes Visuais", "Teatro", "Cinema", "Performance", "teste"}
  self.list=layoutPgmAgenda(ReadTable("tbl_agenda.txt"))
  return o
end

--deal with keys
function agendaMenu:input(evt)
  if ( evt.key == "RED" ) then
    self.page=1
    self:pageReset()
  elseif ( evt.key == "GREEN" ) then
    self.page=2
    self:pageReset()
  elseif ( evt.key == "YELLOW" ) then
    self.page=3
    self:pageReset()
  elseif ( evt.key == "BLUE" ) then
    self.page=4
    self:pageReset()
  elseif ( self.page==1 ) then
    if ( evt.key == "CURSOR_LEFT" ) then
      self.aposh=shift(self.aposh,-1,5)
      self:calendar()
    elseif ( evt.key=="CURSOR_RIGHT") then
      self.aposh=shift(self.aposh,1,5)
      self:calendar()
    elseif (evt.key=="CURSOR_UP") then
      self.aposv=shift(self.aposv,-1,7)
      self:calendar()
    elseif ( evt.key=="CURSOR_DOWN") then
      self.aposv=shift(self.aposv,1,7)
      self:calendar()
    end
  end
end


-- agenda icons vert scroll
function agendaMenu:pageReset()
  if (not PGMON) then
    canvas:attrColor(255,141,47,200)
    canvas:clear(0,0, GRID*32, GRID*18)
    PGMON = true
  end

  local menu={"agenda","sobre","teste","bla"}

  if (self.page == 1) then
    self:calendar()
  elseif(self.page==2) then
    self:page2()
  elseif(self.page==3) then
    self:page3()
  elseif(self.page==4) then
    self:page4()
  end

  canvas:flush()
end

function agendaMenu:page2()
  canvas:attrColor("green")
  canvas:clear()
end


function agendaMenu:page3()
  canvas:attrColor("yellow")
  canvas:clear()
end

function agendaMenu:page4()
  canvas:attrColor("blue")
  canvas:clear()
end


function agendaMenu:pageResetbak()

--  canvas:drawRect("fill", GRID, GRID, GRID*30, GRID*13.5 )

  -- draw redeminas logo
  local logorm = canvas:new("media/btn1off.png")
  canvas:compose(GRID, GRID, logorm )

  local logo = canvas:new("media/agenda/bgd1.png")

  local dx,dy = logo:attrSize()
  canvas:compose(0, GRID*18-dy, logo)

  -- Draw nav buttons
  local btnarrowv = canvas:new("media/btnarrowv.png")
  local btnarrowh = canvas:new("media/btnarrowh.png")
  local btnexit = canvas:new("media/btnsair.png")
  canvas:compose(GRID, GRID*17, btnarrowv)
  canvas:compose(GRID*2.5, GRID*17, btnarrowh)
  canvas:compose(GRID*4, GRID*17, btnexit)
end


function agendaMenu:calendarGrid()
  canvas:attrColor(0,0,0,0)
  canvas:clear(0,0,GRID*32,GRID*16)

  local d=tonumber(self.list[1]["domingo"])

  local yy,mm,dd, M = os.date("%Y"), os.date("%m"), os.date("%d"), os.date("%w")
  local month_days = get_days_in_month(mm,yy)
  local day_week = get_day_of_week(1, mm, yy)

  local day_start = 2
  local days_of_week = {{"Dom",1},{"Seg",2},{"Ter",3},{"Qua",4},{"Qui",5},{"Sex",6},{"Sab",7}}
  local days_of_week_ordered =  {}

  local offset_x = GRID
  local offset_y = GRID

  --order table
  for k=1, 7 do
    local v = {}
    v.dayname = days_of_week[k][1]
    v.daynum = days_of_week[k][2]
    table.insert(days_of_week_ordered,v)
  end

  for i,v in ipairs(days_of_week_ordered) do
    canvas:attrFont("Vera", 20,"bold")
    if (i-1+d==tonumber(dd)) then
      canvas:attrColor("red")
    else
      canvas:attrColor("green")
    end

    --print weekdays
    canvas:drawText(GRID, (i-1)*GRID*2 , v.dayname)
    canvas:drawRect("frame",GRID/2,(i-1)*GRID,GRID*2,GRID*2)
    --print days
    canvas:drawText(GRID*4,(i-1)*GRID*2, i-1+d)
    canvas:drawRect("frame",GRID*3,(i-1)*GRID,GRID*2,GRID*2)

--    if (day_week == v.daynum) then
      --d= -i+2
    --end
  end
  canvas:attrColor("blue")
  canvas:drawRect("frame",GRID*3,(self.aposv-1)*GRID*2,GRID*10,GRID)
  --- show events
  self:calendarEvents(self.aposv-1+d,self.aposh)
end

function agendaMenu:calendarEvents(day,cat)
  local tab = {}

  for i=1, #self.list do
    local d = tonumber(string.sub(self.list[i]["data"],1,2))
    if ( d == day ) then
      if (cat == 1) then
        table.insert(tab,self.list[i])
      elseif (cat == tonumber(self.list[i]["cat"])) then
        table.insert(tab,self.list[i])
      end
      print (i)
      
    end
  end

  for i=1, #tab do
    canvas:drawText(GRID*10, GRID*2+GRID*i, tab[i]["nome"])
    canvas:drawText(GRID*15, GRID*2+GRID*i, tab[i]["cat"])

  end
end


function agendaMenu:calendarCategory()
  for i=1, #self.categories do
    if i == self.aposh then
      canvas:attrColor("red")
    else
      canvas:attrColor("blue")
    end
    canvas:drawRect("frame",GRID*(i+1),GRID*16,GRID,GRID)
    --canvas:clear(    )
    canvas:drawText(GRID*10,GRID*16 , self.categories[self.aposh])
  end
end

function agendaMenu:calendarDebug()
  canvas:attrColor("yellow")
  canvas:clear(0,GRID*17,SCREEN_WIDTH,GRID*18)
  canvas:attrColor("black")
  canvas:attrFont("Vera", 20,"bold")
  canvas:drawText(GRID*1, GRID*17, "aposh:" .. self.aposh)
  canvas:drawText(GRID*5, GRID*17, "aposv:" .. self.aposv)
  canvas:drawText(GRID*9, GRID*17, "page:" .. self.page)
  canvas:drawText(GRID*24, GRID*17, "Dia atual:" .. os.date("%d/%m/%Y"))

end

function agendaMenu:calendar()
  self:calendarGrid()
  self:calendarCategory()
  self:calendarDebug()
  canvas:flush()
end
