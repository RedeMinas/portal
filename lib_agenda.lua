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
  self.page = 1
  self.pages = 4
  self.menu = {"Agenda Cultural", "Centros Culturais", "Especial", "Contatos"}
  self.ccregions = {"Barreiro", "Centro Sul", "Leste", "Nordeste", "Noroeste", "Norte", "Oeste", "Pampulha", "Venda Nova"}
  self.catcolors = {{217,215,215,255},{183,43,137,255},{207,120,24,255},{209,197,16,255},{118,176,40,255},{0,227,247,255}}
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
  elseif (self.page == 3) then
    if (evt.key=="CURSOR_UP") then
      self.pollposv=shift(self.pollposv,-1,6)
      self:especial()
    elseif ( evt.key=="CURSOR_DOWN") then
      self.pollposv=shift(self.pollposv,1,6)
      self:especial()
    end
  end
  end
-- agenda icons vert scroll
function agendaMenu:pageReset()
  if (not PGMON) then
    -- canvas:attrColor(255,141,47,200)
   canvas:attrColor("black")
   canvas:clear(0,0, GRID*32, GRID*18)

   -- imagem hora extra
   local imgbgd = canvas:new("media/agenda/he.png")
   local dx,dy = imgbgd:attrSize()
   canvas:compose(SCREEN_WIDTH-dx, GRID*2, imgbgd)

   PGMON = true
  end

  -- clear top bar
  canvas:attrColor(64,64,65,204)
  canvas:clear(0,0, SCREEN_WIDTH, GRID*2)

  -- draw agenda logo
  local imglogo = canvas:new("media/agenda/logoagenda.png")
  local dx,dy = imglogo:attrSize()
  canvas:compose(GRID/2,GRID-dy/2, imglogo )

  -- draw tagtop detail
  -- local imgtagtop = canvas:new("media/agenda/tagtop.png")
  -- local dx,dy = imgtagtop:attrSize()
  -- canvas:compose(GRID*25, GRID*2-dy, imgtagtop )

  -- draw redeminas logo
  local imglogorm = canvas:new("media/agenda/logoredeminas.png")
  local dx,dy = imglogorm:attrSize()
  canvas:compose(SCREEN_WIDTH-dx-GRID/2, GRID-dy/2, imglogorm )

  -- clear left menu
  canvas:attrColor(64,64,65,204)
  canvas:clear(0,GRID*2,GRID*3.75,GRID*16)

  self:bgd()
  if (self.page == 1) then
    -- Draw nav buttons
    local btnarrowv = canvas:new("media/btnarrowv.png")
    local btnarrowh = canvas:new("media/btnarrowh.png")
    local btnexit = canvas:new("media/btnsair.png")
    canvas:compose(GRID/4, GRID*17, btnarrowv)
    canvas:compose(GRID*1.5, GRID*17, btnarrowh)
    canvas:compose(GRID*2.75, GRID*17, btnexit)
    self:calendar()
  elseif(self.page==2) then
    -- Draw nav buttons
    local btnarrowv = canvas:new("media/btnarrowv.png")
    local btnarrowh = canvas:new("media/btnarrowh.png")
    local btnexit = canvas:new("media/btnsair.png")
    canvas:compose(GRID/4, GRID*17, btnarrowv)
    canvas:compose(GRID*1.5, GRID*17, btnarrowh)
    canvas:compose(GRID*2.75, GRID*17, btnexit)

    self:cc()
  elseif(self.page==3) then
    -- Draw nav buttons
    local btnarrowv = canvas:new("media/btnarrowv.png")
    local btnexit = canvas:new("media/btnsair.png")
    canvas:compose(GRID/4, GRID*17, btnarrowv)
    canvas:compose(GRID*2.75, GRID*17, btnexit)

    self:especial()
  elseif(self.page==4) then
    -- Draw nav buttons
    local btnexit = canvas:new("media/btnsair.png")
    canvas:compose(GRID*2.75, GRID*17, btnexit)

    self:contatos()
  end
  canvas:flush()
end

function agendaMenu:bgd()
  -- background fundo
  canvas:attrColor(64,64,65,153)
  canvas:clear(GRID*3.75,GRID*12,GRID, GRID*6)

  --  canvas:attrColor(64,64,65,153)

  canvas:flush()


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

  -- clean calendar events area
  canvas:attrColor(64,64,65,153)
  canvas:clear(GRID*3.75,GRID*2,GRID,GRID*10)
  canvas:clear(GRID*4.75,GRID*2,GRID*21.75,GRID*16)

  -- clean week menu lateral bar
  canvas:attrColor(64,64,65,204)
  canvas:clear(0,GRID*2,GRID*3.75,GRID*8)

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

  local str=""
  if #tab == 0 then
    str = "Nenhum evento encontrado!"
    canvas:attrColor("white")
    canvas:attrFont("Tiresias", 15,"bold")
    local dx,dy = canvas:measureText(str)
    canvas:drawText( SCREEN_WIDTH-dx-(GRID*5.75), GRID*17.4, str)

  else
    if #tab == 1 then
      str= "1 evento encontrado."
    elseif  #tab > 1 and #tab <= 12 then
      str =  #tab .. " eventos encontrados."
    elseif  #tab > 12 then
      str =  #tab .. " eventos encontrados, filre sua busca..."
    end
    canvas:attrColor("white")
    canvas:attrFont("Tiresias", 15,"bold")
    local dx,dy = canvas:measureText(str)
    canvas:drawText( SCREEN_WIDTH-dx-(GRID*5.75), GRID*17.4, str)


    local posx, posy
    local offsetx, offsety = GRID*6 , GRID*2.5
    for i=1, #tab do
      --first line
      if i == 1 or i <= 3 then
        posx = GRID * ((i-1)*7.25)  ; posy = GRID* 2.5
        -- second line
      elseif i == 4 or i <=6 then
        posx = GRID * ((i-4)*7.25)  ; posy = GRID* 6.25
      elseif i >= 7 and i <= 9 then
        posx =  GRID * ((i-7)*7.25) ; posy = GRID * 10
      elseif i >= 10 and i <= 12 then
        posx = GRID * ((i-10)*7.25)  ; posy = GRID * 13.75
      else
        posx = GRID * ((i-12)*7.25);  posy = GRID * 18.5
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
      canvas:drawRect("fill",offsetx+posx-50,posy,GRID*6.5,GRID*3.5)

      -- tag on box
      local imgtagevt = canvas:new("media/agenda/tagevt" .. icat-1 .. ".png")
      local dx,dy = imgtagevt:attrSize()
      canvas:compose(offsetx+posx-50+GRID*6.5-5-dx/2-1,posy, imgtagevt )


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
  canvas:attrColor(64,64,65,200)
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

  -- clean ccs area
  canvas:attrColor(64,64,65,153)
  canvas:clear(GRID*3.75,GRID*2,GRID,GRID*10)
  canvas:clear(GRID*4.75,GRID*2,GRID*21.75,GRID*16)


  -- clean week menu lateral bar
  canvas:attrColor(64,64,65,204)
  canvas:clear(0,GRID*2,GRID*3.75,GRID*10)

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
    print(i)
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

  local str=""
  if #tab == 0 then
    str =  "Nenhum centro cultural encontrado!"
    canvas:attrColor("white")
    canvas:attrFont("Tiresias", 15,"bold")
    local dx,dy = canvas:measureText(str)
    canvas:drawText( SCREEN_WIDTH-dx-(GRID*5.75), GRID*17.4, str)

  else
    if #tab == 1 then
      str =  "1 centro cultural encontrado."
    elseif  #tab > 1 and #tab <= 12 then
      str =  #tab .. " centros culturais encontrados."
    elseif  #tab > 12 then
      str =  #tab .. " centros culturais encontrados, filtre sua busca..."
    end
    canvas:attrColor("white")
    canvas:attrFont("Tiresias", 15,"bold")
    local dx,dy = canvas:measureText(str)
    canvas:drawText( SCREEN_WIDTH-dx-(GRID*5.75), GRID*17.4, str)

    local posx, posy
    local offsetx, offsety = GRID*6 , GRID*2.5

    local qty
    if #tab > 8 then
      qty = 8
    else
      qty = #tab
    end

    for i=1, qty do
       --first line
      if i == 1 or i == 2 then
        posx = GRID * ((i-1)*10.5)  ; posy = GRID * 2.5
      elseif i == 3 or i ==4 then
        posx = GRID * ((i-3)*10.5)  ; posy = GRID * 6.25
      elseif i == 5 or i == 6 then
        posx =  GRID * ((i-5)*10.5) ; posy = GRID * 10
      elseif i == 7 or i == 8 then
        posx = GRID * ((i-7)*10.5)  ; posy = GRID * 13.75
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
      canvas:drawRect("fill",offsetx+posx-50,posy,GRID*10+5,GRID*3.5)

      -- tag on box
      local imgtagevt = canvas:new("media/agenda/tagevt" .. icat-1 .. ".png")
      local dx,dy = imgtagevt:attrSize()
      canvas:compose(offsetx+posx-50+GRID*10-dx/2-1,posy, imgtagevt )

      -- draw event text
      canvas:attrFont("Tiresias", 14, "bold")
      canvas:attrColor("white")
      canvas:drawText(offsetx+posx-40, posy, tab[i]["nome"])

      canvas:attrFont("Tiresias", 12, "normal")
      local desc = textWrap (tab[i]["desc"], 72)

      -- draw event desc lines (max 4)
      for i = 1, #desc do
        canvas:drawText(offsetx+posx-42, posy+GRID/4+GRID/2.5*i, desc[i])
      end
      canvas:drawText(offsetx+posx-40, posy+GRID*2, tab[i]["func"])
      canvas:drawText(offsetx+posx-40, posy+GRID*2.4, tab[i]["end"])
      canvas:drawText(offsetx+posx-40, posy+GRID*2.8, tab[i]["contato"])
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

function agendaMenu:especial()
   -- clean draw area

  canvas:attrColor(64,64,65,153)
  canvas:clear(GRID*3.75,GRID*2,GRID,GRID*10)
  canvas:clear(GRID*4.75,GRID*2,GRID*21.75,GRID*16)


  local imgesp = canvas:new("media/agenda/especial.png")
  canvas:compose(GRID*7, GRID*3.5, imgesp)

  -- list side bar
  local imgcalwdtag = canvas:new("media/agenda/tagesp" .. math.random(5) ..".png")
  local dx,dy = imgcalwdtag:attrSize()
  canvas:compose(GRID*7,GRID*3.5+(self.pollposv-1)*GRID*2.3, imgcalwdtag )
  local img = canvas:new("media/agenda/qresp" ..self. pollposv .. ".png")
  local dx,dy = img:attrSize()
  canvas:compose(GRID*21, GRID*13, img)
  canvas:flush()
end

function agendaMenu:contatos()
  -- clean draw area
  canvas:attrColor(64,64,65,153)
  canvas:clear(GRID*3.75,GRID*2,GRID,GRID*10)
  canvas:clear(GRID*4.75,GRID*2,GRID*21.75,GRID*16)

  --img contatos
  local imgcnt = canvas:new("media/agenda/cnt.png")
  -- local dx,dy = imgbgd:attrSize()

  canvas:compose(GRID*5, GRID*2.75, imgcnt)
  for i=1,4 do
    local imgqrtag = canvas:new("media/agenda/qrtag" .. i .. ".png")
    local imgqr = canvas:new("media/agenda/qr" .. i .. ".png")
    local dx,dy = imgqrtag:attrSize()
    canvas:attrColor("white")
    if i == 1 then
      -- rede minas
      canvas:compose(GRID*5, GRID*7.5, imgqr )
      canvas:compose(GRID*8.75 -1, GRID*7.5, imgqrtag )
      canvas:attrFont("Tiresias",15,"normal")
      canvas:attrColor("white")
      canvas:drawText(GRID*5,GRID*11.75,"redeminas.tv/agenda")
      -- youtube
    elseif i == 2 then
      canvas:compose(GRID*13, GRID*7.5, imgqr )
      canvas:compose(GRID*16.75-1, GRID*7.5, imgqrtag )
      canvas:attrFont("Tiresias",15,"normal")
      canvas:attrColor("white")
      canvas:drawText(GRID*13, GRID*11.75,"youtube.com/user/programaagendatv") 
      -- facebook
    elseif i == 3 then
      canvas:compose(GRID*9, GRID*12.75, imgqr )
      canvas:compose(GRID*12.75-1, GRID*12.75, imgqrtag )
      canvas:attrFont("Tiresias",15,"normal")
      canvas:attrColor("white")
      canvas:drawText(GRID*9, GRID*17,"facebook.com/programaagenda")
      -- email
    elseif i == 4 then
      canvas:compose(GRID*17, GRID*12.75, imgqr )
      canvas:compose(GRID*20.75-1, GRID*12.75, imgqrtag )
      canvas:attrFont("Tiresias",15,"normal")
      canvas:attrColor("white")
      canvas:drawText(GRID*17,GRID*17,"agenda.redeminas@gmail.com")
    end
  end
end
