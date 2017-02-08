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
--  self.aposv = 1
  self.list=layoutPgmAgenda(ReadTable("tbl_agenda.txt"))
  return o
end

--deal with keys
function agendaMenu:input(evt)
  if (evt.key=="CURSOR_LEFT") then
    self.aposh=shift(self.aposh,-1,7)
    self:calendar()
  elseif ( evt.key=="CURSOR_RIGHT") then
    self.aposh=shift(self.aposh,1,7)
    self:calendar()
  elseif (evt.key=="CURSOR_UP") then
    self.pos=shift(self.pos,-1,self.icons)
    self:iconDraw()
    self:menuItem()
  elseif ( evt.key=="CURSOR_DOWN") then
    self.pos=shift(self.pos,1,self.icons)
    self:iconDraw()
    self:menuItem()
  elseif ( self.pos==4 ) then
    if ( evt.key == "RED" ) then
      self:menuItem('red')
    elseif ( self.pos==4 and evt.key == "GREEN" ) then
      self:menuItem('green')
    elseif ( self.pos==4 and evt.key == "YELLOW" ) then
      self:menuItem('yellow')
    elseif ( self.pos==4 and evt.key == "BLUE" ) then
      self:menuItem('blue')
    end
  end
end


-- agenda icons vert scroll
function agendaMenu:iconDraw()
  if (not PGMON) then
    self:pageReset()
    PGMON = true
  end

  local iconpath=""
  local sumdy=0

  local menu={"agenda","sobre","teste","bla"}

  canvas:attrFont("Vera", 15,"bold")

  for i=1,4 do
    if (i == self.pos) then
      canvas:attrColor("red")

    else
      canvas:attrColor("white")
    end
    canvas:drawRect("fill", GRID, GRID*11+GRID*i, GRID, GRID )
    canvas:drawText(GRID*2.5,GRID*11+GRID*i,menu[i])

  end

--  canvas:compose(0, GRID*11+sumdy, icon )
  --sumdy=sumdy+dy

  self:pageDraw()
  canvas:flush()
end

function agendaMenu:pageDraw()
  canvas:attrColor(93,196,179,217)
--  canvas:attrColor("blue")
--  canvas:clear(GRID*7,GRID*11, GRID*32, GRID*18 )


end

function agendaMenu:pageReset()
  canvas:attrColor(255,141,47,200)
  canvas:clear(0,0, GRID*32, GRID*18)

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

-- main menu treatment
function agendaMenu:menuItem(par)
  --canvas:attrColor(0,0,0,0)
  --canvas:clear(0,0, GRID*32, GRID*10 )

  -- edicao da semana
  if (self.pos==1) then
    -- agenda semanal
  elseif (self.pos == 2) then
    --local img = canvas:new("media/btnarrowh.png")
--    canvas:compose(GRID*2.5, GRID*17, img)
--    local img = canvas:new("media/harmonia/repertorio.png")
    --canvas:compose(GRID*6, GRID*11.5, img)
    self:calendar()
  elseif (self.pos==3) then
    --local img = canvas:new("media/harmonia/especialdomes.png")
    --canvas:compose(GRID*6, GRID*11.5, img)
  elseif (self.pos==4) then
    local img = canvas:new("media/harmonia/contatos.png")
    canvas:compose(GRID*6, GRID*11.5, img)
    -- results from tcp get
    if  par == 'red' then
      local img = canvas:new("media/qrfb.png")
      local dx,dy = img:attrSize()
      canvas:attrColor(0,0,0,0)
      canvas:clear(GRID*32-dx,GRID, dx, dy )
      canvas:compose(GRID*32-dx, GRID, img)
    elseif  par == 'green' then
      local img = canvas:new("media/qrtwitter.png")
      local dx,dy = img:attrSize()
      canvas:attrColor(0,0,0,0)
      canvas:clear(GRID*32-dx,GRID, dx, dy )
      canvas:compose(GRID*32-dx, GRID, img)
    elseif  par == 'yellow' then
      local img = canvas:new("media/qrinsta.png")
      local dx,dy = img:attrSize()
      canvas:attrColor(0,0,0,0)
      canvas:clear(GRID*32-dx,GRID, dx, dy )
      canvas:compose(GRID*32-dx, GRID, img)
    elseif  par == 'blue' then
      local img = canvas:new("media/qryoutube.png")
      local dx,dy = img:attrSize()
      canvas:attrColor(0,0,0,0)
      canvas:clear(GRID*32-dx,GRID, dx, dy )
      canvas:compose(GRID*32-dx, GRID, img)
    end
  end
  canvas:flush()
end


-- based  on http://lua-users.org/wiki/DisplayCalendarInHtml
function agendaMenu:calendarGrid()
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
  print("d", d, "month_days", month_days)

  while(d<month_days) do
    for i,v in ipairs (days_of_week) do
      if (d>=1 and d<=month_days) then
        -- arrumar!!!!
        if w ==2  then
          if (d==tonumber(dd)) then
            canvas:attrColor("red")
            canvas:drawRect("frame",(GRID*(i-1)*4)+GRID+1,(GRID*3)+GRID+1,GRID*4-2,GRID*3-2)
            canvas:drawText((GRID*(i-1)*4)+GRID*1.5, (GRID*3)+GRID*1.5,  "!" .. d)
          else
            canvas:attrColor("gray")
            canvas:drawRect("frame",(GRID*(i-1)*4)+GRID,(GRID*3)+GRID,GRID*4,GRID*3)
            canvas:drawText((GRID*(i-1)*4)+GRID*1.5, (GRID*3)+GRID*1.5,  d)
          end
          if(i==self.aposh ) then
            print("ok")
            canvas:attrColor("yellow")
            canvas:drawRect("fill",(GRID*(self.aposh-1)*4)+GRID,(GRID*3)+GRID,GRID*4,GRID*3)
            canvas:attrColor("black")
            canvas:drawText((GRID*(i-1)*4)+GRID*1.5, (GRID*3)+GRID*1.5, d)
          end
        end
      end
      d = d+1
    end
    w = w+1
  end
end

function agendaMenu:calendarDisplayDay()
  canvas:attrColor("yellow")
  canvas:clear(0,GRID*17,SCREEN_WIDTH,GRID*18)
  canvas:attrColor("black")
  canvas:attrFont("Vera", 20,"bold")
  canvas:drawText(GRID*1, GRID*17, "aposh:" .. self.aposh)
  canvas:drawText(GRID*15, GRID*17, "Dia atual:" .. os.date("%d/%m/%Y"))

  canvas:flush()
end

function agendaMenu:calendar()
  self:calendarGrid()
  self:calendarDisplayDay()
end
