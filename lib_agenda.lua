--- agenda object

agendaMenu = {}

function agendaMenu:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.pos = 1
  self.spos = 1
  self.icons = 4
  -- calendar positions
  self.aposh = 1
  self.aposv = 1
  -- cc positions
  self.ccposh = 1
  self.ccposv = 1
  -- poll positions
  self.pollposh = 1
  self.pollposv = 1
  self.pollvote=false
  self.page = 1
  self.pages = 4
  self.menu = {"Agenda Cultural", "Centros Culturais", "Enquete", "Contatos"}
  self.ccregions = {"Barreiro", "Centro Sul", "Leste", "Nordeste", "Noroeste", "Norte", "Oeste", "Pampulha", "Venda Nova"}
  self.catcolors = {{217,215,215,200},{183,43,137,200},{207,120,24,200},{209,197,16,200},{118,176,40,200},{0,227,247,200}}
  self.acats = {"Todos" , "Cinema", "Teatro", "Literatura", "MÃºsica", "Artes"}
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
      self:cc()
    elseif ( evt.key=="CURSOR_RIGHT") then
      self.ccposh=shift(self.ccposh,1,#self.acats)
      self:cc()
    elseif (evt.key=="CURSOR_UP") then
      self.ccposv=shift(self.ccposv,-1,#self.ccregions)
      self:cc()
    elseif ( evt.key=="CURSOR_DOWN") then
      self.ccposv=shift(self.ccposv,1,#self.ccregions)
      self:cc()
    end
  elseif ( self.page==3 ) then
    if ( evt.key == "CURSOR_LEFT" ) then
      self.pollposh=shift(self.pollposh,-1,#self.acats)
      self:poll()
    elseif ( evt.key=="CURSOR_RIGHT") then
      self.pollposh=shift(self.pollposh,1,#self.acats)
      self:poll()
    elseif (evt.key=="CURSOR_UP") then
      self.pollposv=shift(self.pollposv,-1,#self.acats)
      self:poll()
    elseif ( evt.key=="CURSOR_DOWN") then
      self.pollposv=shift(self.pollposv,1,#self.acats)
      self:poll()
    elseif ( evt.key=="ENTER") then
      canvas:attrColor("white")
      canvas:attrFont("Tiresias",30,"normal")

      if not self.pollvote then
        canvas:drawText(GRID*5, GRID*4, "Computando voto")
        canvas:flush()
        local tcpresult2 = tcpresult
        connecttcp("agendavoto" ..  self.pollposv .. self.pollposh)
        if tcpresult ~= tcpresult2 then
          self.pollvote = true
          canvas:drawText(GRID*5, GRID*5, tcpresult)
          canvas:flush()
        end
      end
    else
      canvas:drawText(GRID*5, GRID*4, "Voto feito")
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

  -- clear top bar
  canvas:attrColor(64,64,65,204)
  canvas:clear(0,0, SCREEN_WIDTH, GRID*2)

  -- draw agenda logo
  local imglogo = canvas:new("media/agenda/logoagenda.png")
  local dx,dy = imglogo:attrSize()
  canvas:compose(GRID/2,GRID-dy/2, imglogo )

  -- draw tagtop detail
  local imgtagtop = canvas:new("media/agenda/tagtop.png")
  local dx,dy = imgtagtop:attrSize()
  canvas:compose(GRID*25, GRID*2-dy, imgtagtop )

  -- draw redeminas logo
  local imglogorm = canvas:new("media/agenda/logoredeminas.png")
  local dx,dy = imglogorm:attrSize()
  canvas:compose(SCREEN_WIDTH-dx-GRID/2, GRID-dy/2, imglogorm )

  -- clear left menu
  canvas:attrColor(64,64,65,204)
  canvas:clear(0,GRID*2,GRID*3.75,GRID*16)

  --- ???/
  --  canvas:attrColor("pink")
  --  canvas:clear(GRID*4.5,GRID*2,GRID,GRID*8)

  -- Draw nav buttons
  local btnarrowv = canvas:new("media/btnarrowv.png")
  local btnarrowh = canvas:new("media/btnarrowh.png")
  local btnexit = canvas:new("media/btnsair.png")
  canvas:compose(GRID/4, GRID*17, btnarrowv)
  canvas:compose(GRID*1.5, GRID*17, btnarrowh)
  canvas:compose(GRID*2.75, GRID*17, btnexit)

  if (self.page == 1) then
    self:calendar()
  elseif(self.page==2) then
    self:cc()
  elseif(self.page==3) then
    self:poll()
  elseif(self.page==4) then
    self:contatos()
  end
  canvas:flush()
end

function agendaMenu:bgd()
  local imgbgd = canvas:new("media/agenda/bgd.png")
  local dx,dy = imgbgd:attrSize()
  canvas:compose(GRID*3.75, GRID*2, imgbgd)

  for i=1,4 do
    local btncaticon
    if i ==  self.page then
      btncaticon = canvas:new("media/agenda/btn" .. i .. "on.png")
    else
      btncaticon = canvas:new("media/agenda/btn" .. i .. "off.png")
    end
    canvas:compose(0, GRID*11+GRID*1.2*i-1, btncaticon)
    canvas:attrFont("Tiresias",13,"normal")
    canvas:attrColor("white")
    canvas:drawText(GRID/4,GRID*11.25+GRID*1.2*i-1,self.menu[i])
  end
end


function agendaMenu:calendar()

  -- clean cleandar events area
  canvas:attrColor(0,0,0,0)
  canvas:clear(GRID*3.75 ,GRID*2,SCREEN_WIDTH,GRID*16)

  -- clean week menu lateral bar
  canvas:attrColor(64,64,65,204)
  canvas:clear(0,GRID*2,GRID*3.75,GRID*8)

  self:bgd()

  local d=tonumber(self.listevt[1]["segunda"])
  local yy,mm,dd, M = os.date("%Y"), os.date("%m"), os.date("%d"), os.date("%w")
  local month_days = get_days_in_month(mm,yy)
  local day_week = get_day_of_week(1, mm, yy)
  local days_of_week= {{"Seg",1},{"Ter",2},{"Qua",3},{"Qui",4},{"Sex",5},{"Sab",6},{"Dom",7}}
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


  --draw week menu
  canvas:attrColor("white")
  canvas:drawRect("fill",GRID*2.25,GRID*2.5+(self.aposv-1)*GRID,GRID*1.5,GRID)

  local imgcalwdtag = canvas:new("media/agenda/calwdtag.png")
  local dx,dy = imgcalwdtag:attrSize()
  canvas:compose(GRID*3.75,GRID*2+(self.aposv-1)*GRID, imgcalwdtag )

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
      canvas:attrColor(1,1,1,255)
    elseif ( self.aposv == i) then
      canvas:attrColor(215,38,156,255)
    else
      canvas:attrColor("white")
    end
    --print weekdays
    canvas:attrFont("Vera", 15,"bold")
    canvas:drawText(GRID/2, GRID*2.75+(i-1)*GRID , v.dayname)
    canvas:drawText(GRID*2.5,GRID*2.75+(i-1)*GRID, k)
  end

  --- show events
  self:calendarEvents(self.aposv-1+d,self.aposh-1)
  canvas:flush()
end

function agendaMenu:calendarEvents(day,cat)
  local tab = {}

  -- gen aux table (tab), category filter
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
    canvas:attrFont("Tiresias", 30,"bold")
    canvas:drawText(GRID*7, GRID*7, "Nenhum evento encontrado!!!")
  else
    local posx, posy
    local offsetx, offsety = GRID*6 , GRID*2.5
    for i=1, #tab do
      --first line
      if i == 1 or i == 2 then
        posx = GRID * ((i-1)*7)  ; posy = GRID* 2.5
        -- second line
      elseif i == 3 or i <=5 then
        posx = GRID * ((i-3)*7)  ; posy = GRID* 6.25
      elseif i >= 6 and i <= 8 then
        posx =  GRID * ((i-6)*7) ; posy = GRID * 10
      elseif i >= 9 and i <= 12 then
        posx = GRID * ((i-9)*7)  ; posy = GRID * 13.75
      else
        posx = GRID * ((i-10)*7);  posy = GRID * 18.5
      end

      -- category colors
      local icat = tonumber(tab[i]["cat"])+1
      canvas:attrColor(
        self.catcolors[icat][1],
        self.catcolors[icat][2],
        self.catcolors[icat][3],
        self.catcolors[icat][4]
      )

      -- box
      canvas:attrColor(64,64,65,204)
      canvas:drawRect("fill",offsetx+posx-50,posy,GRID*6+5,GRID*3.5)

      -- tag on box
      local imgtagevt = canvas:new("media/agenda/tagevt" .. icat-1 .. ".png")
      local dx,dy = imgtagevt:attrSize()
      canvas:compose(offsetx+posx-50+GRID*6-dx/2-1,posy, imgtagevt )


      -- draw event text
      canvas:attrFont("Tiresias", 14, "bold")
      canvas:attrColor("white")
      canvas:drawText(offsetx+posx-40, posy, tab[i]["nome"])

      canvas:attrFont("Tiresias", 12, "normal")
      local desc = textWrap (tab[i]["desc"], 43)

      -- draw event desc lines (max 4)
      for i = 1, 4 do
        canvas:drawText(offsetx+posx-42, posy+GRID/4+GRID/2.5*i, desc[i])
      end

      canvas:drawText(offsetx+posx-40, posy+GRID*2.5, tab[i]["hora"] .. " / R$ " .. tab[i]["valor"] )
      canvas:drawText(offsetx+posx-40, posy+GRID*3, "Local: " .. tab[i]["local"])

    end
  end
  self:calendarCategory()
end

function agendaMenu:calendarCategory()
  canvas:attrColor(64,64,65,204)
  canvas:clear(GRID*10,0,GRID*9, GRID*2)

  for i=1, #self.acats do
    if i == self.aposh then
      canvas:attrColor(
        self.catcolors[i][1],
        self.catcolors[i][2],
        self.catcolors[i][3],
        self.catcolors[i][4]
      )

      canvas:drawRect("fill",GRID*10+GRID*1.5*(i-1),5,GRID*1.5,GRID*1.5)
    end

    local imgcaticons = canvas:new("media/agenda/calcaticons.png")
    local dx,dy = imgcaticons:attrSize()
    canvas:compose(GRID*10, GRID*2-dy, imgcaticons )
    --canvas:drawText(GRID*14,GRID*16 , self.acats[self.aposh])
  end
end

--centros culturais
function agendaMenu:cc()

  -- clean cleandar events area
  canvas:attrColor(0,0,0,0)
  canvas:clear(GRID*3.75 ,GRID*2,SCREEN_WIDTH,GRID*16)

  -- clean week menu lateral bar
  canvas:attrColor(64,64,65,204)
  canvas:clear(0,GRID*2,GRID*3.75,GRID*10)

  self:bgd()

  -- list regions on left side bar

  local imgcalwdtag = canvas:new("media/agenda/calwdtag.png")
  local dx,dy = imgcalwdtag:attrSize()
  canvas:compose(GRID*3.75,GRID*2+(self.ccposv-1)*GRID, imgcalwdtag )

  canvas:attrColor("white")
  canvas:attrFont("Tiresias", 15,"bold")

  for i=1, #self.ccregions do
    if (i==self.ccposv) then
      canvas:attrColor("white")
      canvas:drawRect("fill",GRID/4,GRID*2.5+(self.ccposv-1)*GRID,GRID*3.5,GRID)
      canvas:attrColor(215,38,156,255)
    else
      canvas:attrColor("white")
    end
    canvas:drawText(GRID/2, GRID*1.8+GRID*i-1, self.ccregions[i] )
  end

  -- gen aux table (tab), category filter
  local tab = {}
  for i=1, #self.listcc do
    if (self.ccposv == tonumber(self.listcc[i]["reg"])) then
      if (self.ccposh -1 == 0) then
        table.insert(tab,self.listcc[i])
      elseif (self.ccposh -1 == tonumber(self.listcc[i]["cat"])) then
        table.insert(tab,self.listcc[i])
      end
    end
    if (self.ccposh -1 == 0) then
    end
end

    if #tab == 0 then
    canvas:attrColor("yellow")
    canvas:attrFont("Tiresias", 40,"bold")
    canvas:drawText(GRID*7, GRID*7, "nenhum Centro Cultural encontrado!!!")
  else
    local posx, posy
    local offsetx, offsety = GRID*6 , GRID*2.5
    for i=1, #tab do
       --first line
      if i == 1 or i == 2 then
        posx = GRID * ((i-1)*7)  ; posy = GRID*2.5
        -- second line
      elseif i ==3 or i <=5 then
        posx = GRID * ((i-3)*7)  ; posy = GRID*6.25
      elseif i >= 6 and i <= 8 then
        posx =  GRID * ((i-6)*7) ; posy = GRID * 10
      elseif i >= 9 and i <= 12 then
        posx = GRID * ((i-9)*7)  ; posy = GRID * 13.75
      else
        posx = GRID * ((i-10)*7);  posy = GRID * 18.5
      end
      -- category colors
      local icat = tonumber(tab[i]["cat"])+1
      canvas:attrColor(
        self.catcolors[icat][1],
        self.catcolors[icat][2],
        self.catcolors[icat][3],
        self.catcolors[icat][4]
      )

      -- box
      canvas:attrColor(64,64,65,204)
      canvas:drawRect("fill",offsetx+posx-50,posy,GRID*6+5,GRID*3.5)

      -- tag on box
      local imgtagevt = canvas:new("media/agenda/tagevt" .. icat-1 .. ".png")
      local dx,dy = imgtagevt:attrSize()
      canvas:compose(offsetx+posx-50+GRID*6-dx/2-1,posy, imgtagevt )

      -- draw event text
      canvas:attrFont("Tiresias", 14, "bold")
      canvas:attrColor("white")
      canvas:drawText(offsetx+posx-40, posy, tab[i]["nome"])

      canvas:attrFont("Tiresias", 12, "normal")
      local desc = textWrap (tab[i]["desc"], 43)

      -- draw event desc lines (max 4)
      for i = 1, 4 do
        canvas:drawText(offsetx+posx-42, posy+GRID/4+GRID/2.5*i, desc[i])

      end
        canvas:drawText(offsetx+posx-40, posy+GRID*2.5, tab[i]["end"] .. " / " .. tab[i]["func"] )
        canvas:drawText(offsetx+posx-40, posy+GRID*3, "Contato: " .. tab[i]["contato"])
      --canvas:drawText(posx, posy, tab[i]["nome"])
      --canvas:drawText(posx, posy+GRID, self.acats[(tonumber(tab[i]["cat"])+1)])
    end
  end
  self:ccCategoryDisplay()
  canvas:flush()
end

function agendaMenu:ccCategoryDisplay()
  canvas:attrColor(64,64,65,204)
  canvas:clear(GRID*10,0,GRID*9, GRID*2)
  for i=1, #self.acats do
    if i == self.ccposh then
      canvas:attrColor(
        self.catcolors[i][1],
        self.catcolors[i][2],
        self.catcolors[i][3],
        self.catcolors[i][4]
      )
      canvas:drawRect("fill",GRID*10+GRID*1.5*(i-1),5,GRID*1.5,GRID*1.5)
    end

    local imgcaticons = canvas:new("media/agenda/cccaticons.png")
    local dx,dy = imgcaticons:attrSize()
    canvas:compose(GRID*10, GRID*2-dy, imgcaticons )
    --canvas:drawText(GRID*14,GRID*16 , self.acats[self.aposh])
  end
end

function agendaMenu:poll()
  -- clean draw area
  canvas:attrColor(0,0,0,0)
  canvas:clear(GRID*3.75, GRID*2, SCREEN_WIDTH, GRID*16)

  self:bgd()
  canvas:attrFont("Tiresias",20,"normal")
  canvas:attrColor("yellow")
  canvas:drawText(GRID*8,GRID*3 , "Sistema de enquete ")

  local offsetx, offsety = GRID*6, GRID*3
  canvas:drawRect("fill", offsetx+GRID*2*self.pollposh,offsety+GRID*2*self.pollposv,GRID*2,GRID*2 )

  canvas:attrColor("black")
  canvas:drawText(offsetx+GRID*2*self.pollposh+30,offsety+GRID*2*self.pollposv+30 , self.pollposv .. "/" .. self.pollposh)

  canvas:flush()
end

function agendaMenu:contatos()
  -- clean draw area
  canvas:attrColor(0,0,0,0)
  canvas:clear(GRID*3.75 ,GRID*2,SCREEN_WIDTH,GRID*16)

  self:bgd()

  canvas:attrFont("Tiresias",20,"normal")
  canvas:attrColor("white")
  canvas:drawText(GRID*6,GRID*3 , "Fique por dentro! \n Ficha tecnica? :)")

  for i=1,4 do
    local imgqrtag = canvas:new("media/agenda/qrtag" .. i .. ".png")
    local imgqr = canvas:new("media/agenda/qr" .. i .. ".png")
    local dx,dy = imgqrtag:attrSize()
    canvas:attrColor("white")
    if i == 1 then
      canvas:compose(GRID*8, GRID*7, imgqr )
      canvas:compose(GRID*12 -1, GRID*7, imgqrtag )
    elseif i == 2 then
      canvas:compose(GRID*16, GRID*7, imgqr )
      canvas:compose(GRID*20-1, GRID*7, imgqrtag )
    elseif i == 3 then
      canvas:compose(GRID*8, GRID*12.75, imgqr )
      canvas:compose(GRID*12-1, GRID*12.75, imgqrtag )
    elseif i == 4 then
      canvas:compose(GRID*16, GRID*12.75, imgqr )
      canvas:compose(GRID*20-1, GRID*12.75, imgqrtag )
    end
  end
end
