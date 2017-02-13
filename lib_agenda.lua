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
  self.ccposh = 1
  self.ccposv = 1
  self.page = 1
  self.pages = 4
  self.acats = {"Todos" , "Música", "Cinema", "Literatura", "Artes Visuais", "Artes Cënicas", "blablla"}
  self.listevt=layoutPgmAgendaEvt(ReadTable("tbl_agendaevt.txt"))
  self.listcc=layoutPgmAgendaCc(ReadTable("tbl_agendacc.txt"))
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
      self.aposh=shift(self.aposh,-1,#self.acats)
      self:calendar()
    elseif ( evt.key=="CURSOR_RIGHT") then
      self.aposh=shift(self.aposh,1,#self.acats)
      self:calendar()
    elseif (evt.key=="CURSOR_UP") then
      self.aposv=shift(self.aposv,-1,7)
      self:calendar()
    elseif ( evt.key=="CURSOR_DOWN") then
      self.aposv=shift(self.aposv,1,7)
      self:calendar()
    end
  elseif ( self.page==2 ) then
    if ( evt.key == "CURSOR_LEFT" ) then
      self.ccposh=shift(self.ccposh,-1,#self.acats)
      self:pageReset()
    elseif ( evt.key=="CURSOR_RIGHT") then
      self.ccposh=shift(self.ccposh,1,#self.acats)
      self:pageReset()
    elseif (evt.key=="CURSOR_UP") then
      self.ccposv=shift(self.ccposv,-1,7)
      self:pageReset()
    elseif ( evt.key=="CURSOR_DOWN") then
      self.ccposv=shift(self.ccposv,1,7)
      self:pageReset()
    end
  end
end

-- agenda icons vert scroll
function agendaMenu:pageReset()
  if (not PGMON) then
    --    canvas:attrColor(255,141,47,200)
    canvas:attrColor("black")
    canvas:clear(0,0, GRID*32, GRID*18)
    PGMON = true
  end

  local menu={"agenda","sobre","teste","bla"}

  canvas:attrColor("gray")
  canvas:drawRect("fill",0,0,SCREEN_WIDTH,GRID*2)

  -- draw redeminas logo
  local imglogorm = canvas:new("media/btn1off.png")
  local dx,dy = imglogorm:attrSize()
  canvas:compose(SCREEN_WIDTH-dx-GRID/2, GRID/2, imglogorm )

  -- draw agenda logo
--  local imglogo = canvas:new("media/agenda/logo.png")
  --  canvas:compose(0,0, imglogo )
  canvas:attrColor("white")
  canvas:attrFont("Vera", 15,"bold")
  canvas:drawText(0,0,"inserir logo agenda")


--  local imgbgd = canvas:new("media/agenda/bgd1.png")
--  local dx,dy = imgbgd:attrSize()
--  canvas:compose(0, GRID*18-dy, imgbgd)

  -- Draw nav buttons
  local btnarrowv = canvas:new("media/btnarrowv.png")
  local btnarrowh = canvas:new("media/btnarrowh.png")
  local btnexit = canvas:new("media/btnsair.png")
  canvas:compose(GRID, GRID*17, btnarrowv)
  canvas:compose(GRID*2.5, GRID*17, btnarrowh)
  canvas:compose(GRID*4, GRID*17, btnexit)


  if (self.page == 1) then
    self:calendar()
  elseif(self.page==2) then
    self:cc()
  elseif(self.page==3) then
    self:page3()
  elseif(self.page==4) then
    self:page4()
  end
  canvas:flush()
end


function agendaMenu:calendar()

  canvas:attrColor("gray")
  canvas:clear(0,GRID*2,GRID*4.5,GRID*12)

  -- limpeza
  canvas:attrColor("red")
  canvas:clear(GRID*4.5,GRID*2,SCREEN_WIDTH,GRID*12)

  local d=tonumber(self.listevt[1]["domingo"])

  local yy,mm,dd, M = os.date("%Y"), os.date("%m"), os.date("%d"), os.date("%w")

  local month_days = get_days_in_month(mm,yy)
  local day_week = get_day_of_week(1, mm, yy)

  local day_start = 2
  local days_of_week= {{"Dom",1},{"Seg",2},{"Ter",3},{"Qua",4},{"Qui",5},{"Sex",6},{"Sab",7}}
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


  canvas:attrColor("white")
  canvas:drawRect("fill",GRID*3,GRID*3-2+(self.aposv-1)*GRID,GRID,GRID*0.8+4)


  -- week
  local j,k = 0,0
  for i,v in ipairs(days_of_week_ordered) do
    if (i-1+d==month_days+1) then
      j,k = 1, j
    elseif(i-1+d<=month_days) then
      k = i-1+d
    else
      j,k=j+1,j
    end

    -- marca dia atual
    if (k == tonumber(dd)) then
      canvas:attrColor("blue")
    elseif ( self.aposv == i) then
      canvas:attrColor("black")
    else
      canvas:attrColor("white")
    end
    --print weekdays
    canvas:attrFont("Vera", 15,"bold")
    canvas:drawText(GRID, GRID*3+(i-1)*GRID , v.dayname)
    canvas:drawText(GRID*3,GRID*3+(i-1)*GRID, k)
  end

  --- show events
  self:calendarEvents(self.aposv-1+d,self.aposh-1)
  canvas:flush()
end

function agendaMenu:calendarEvents(day,cat)
  local tab = {}

  for i=1, #self.listevt do
    local d = tonumber(string.sub(self.listevt[i]["data"],1,2))
    if ( d == day ) then
      if (cat == 0) then
        table.insert(tab,self.listevt[i])
      elseif (cat == tonumber(self.listevt[i]["cat"])) then
        table.insert(tab,self.listevt[i])
      end
    end
  end

  if #tab == 0 then
    canvas:attrColor("yellow")
    canvas:attrFont("Tiresias", 40,"bold")
    canvas:drawText(GRID*7, GRID*7, "nenhum evento encontrado!!!")

  else
    local posx, posy
    for i=1, #tab do
      if i == 1 then
        posx = GRID*5
        posy = GRID*1
      elseif i ==2 or i ==3 then
        posx = GRID * ((i-1)*5)
        posy = GRID*4
      elseif i >= 4 and i <= 6 then
        posx =  GRID * ((i-3)*5)
        posy = GRID * 7
      elseif i >= 7 and i <= 10 then
        posx = GRID * ((i-6)*5)
        posy = GRID * 10
      else
        posx = GRID * ((i-10)*5)
        posy = GRID * 13
      end
      canvas:attrColor("yellow")
      canvas:drawRect("frame",posx-5,posy,GRID*4,GRID*2)

      canvas:attrFont("Tiresias", 15, "normal")
      canvas:attrColor("white")

      canvas:drawText(posx, posy, tab[i]["nome"])
      canvas:drawText(posx, posy+GRID, self.acats[(tonumber(tab[i]["cat"])+1)])
    end
  end
  self:calendarCategory()
end

function agendaMenu:calendarCategory()
  for i=1, #self.acats do
    if i == self.aposh then
      canvas:attrColor("pink")
    else
      canvas:attrColor("blue")
    end
    canvas:drawRect("frame",GRID*4+GRID*(i+1),GRID*16,GRID,GRID)

    canvas:attrFont("Tiresias", 18, "bold")
    canvas:attrColor("white")
    canvas:drawText(GRID*14,GRID*16 , self.acats[self.aposh])
  end
end

--centros culturais
function agendaMenu:cc()

  canvas:attrColor("green")
  canvas:clear(0,GRID*2,SCREEN_WIDTH,GRID*12)
  canvas:attrColor("white")
  canvas:drawText(GRID*10,0,"Centros Culturais")

  local tab = {}

  for i=1, #self.listcc do
    if (self.ccposh-1 == 0) then
      table.insert(tab,self.listcc[i])
    elseif (self.ccposh-1 == tonumber(self.listcc[i]["cat"])) then
      table.insert(tab,self.listcc[i])
    end
  end

  if #tab == 0 then
    canvas:attrColor("yellow")
    canvas:attrFont("Tiresias", 40,"bold")
    canvas:drawText(GRID*7, GRID*7, "nenhum Centro Cultural encontrado!!!")
  else
    local posx, posy
    for i=1, #tab do
      if i == 1 then
        posx = GRID*5
        posy = GRID*1
      elseif i ==2 or i ==3 then
        posx = GRID * ((i-1)*5)
        posy = GRID*4
      elseif i >= 4 and i <= 6 then
        posx =  GRID * ((i-3)*5)
        posy = GRID * 7
      elseif i >= 7 and i <= 10 then
        posx = GRID * ((i-6)*5)
        posy = GRID * 10
      else
        posx = GRID * ((i-10)*5)
        posy = GRID * 13
      end
      canvas:attrColor("yellow")
      canvas:drawRect("frame",posx-5,posy,GRID*4,GRID*2)

      canvas:attrFont("Tiresias", 15, "normal")
      canvas:attrColor("white")

      canvas:drawText(posx, posy, tab[i]["nome"])
      canvas:drawText(posx, posy+GRID, self.acats[(tonumber(tab[i]["cat"])+1)])
    end
  end
  self:ccCategory()
end

function agendaMenu:ccCategory()

  for i=1, #self.acats do
    if i == self.ccposh then
      canvas:attrColor("yellow")
    else
      canvas:attrColor("green")
    end
    canvas:drawRect("frame",GRID*4+GRID*(i+1),GRID*16,GRID,GRID)

    canvas:attrFont("Tiresias", 18, "bold")
    canvas:attrColor("white")
    canvas:drawText(GRID*14,GRID*16 , self.acats[self.ccposh])
    canvas:drawText(GRID*20,GRID*16 , "teset")
  end
end


function agendaMenu:page3()
  canvas:attrColor("yellow")
  canvas:clear(0,GRID*2,SCREEN_WIDTH,GRID*12)

  canvas:attrColor("white")
  canvas:drawText(GRID*10,0,"Oscar")
end

function agendaMenu:page4()
  canvas:attrColor("blue")
  canvas:clear(0,GRID*2,SCREEN_WIDTH,GRID*12)

  canvas:attrColor("white")
  canvas:drawText(GRID*10,0,"slot vago")
end
