--- Harmonia object

harmoniaMenu = {}

function harmoniaMenu:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.pos = 1
  self.spos = 1

  self.icons=4
  self.debug=false
  self.bar={}
  self.bar.stop=false
  self.repertorioItens=4
  self.menu ={{desc="Edição da semana",width=150},{desc="Repertório",width=160}, {desc="Villa Lobos",width=150}, {desc="Contatos",width=180}}
  --remove
  self.list=layoutPgmHarmoniaRep(ReadTable("tbl_harmoniarep.txt"))
  self.listextra=layoutPgmHarmoniaExtra(ReadTable("tbl_harmoniaextra.txt"))
  self.especiallist = textWrap (self.listextra["especial"], 90)
  self.especiallines = 8
  self.especialpages = math.ceil(#self.especiallist/self.especiallines)
  self.especialpos =1
  self.episodiolist = textWrap (self.listextra["episodio"], 90)
  self.episodiolines = 8
  self.episodiopages = math.ceil(#self.episodiolist/self.episodiolines)
  self.episodiopos =1
--  self.settings=false
  return o
end

--deal with keys
function harmoniaMenu:input (evt)
  if (evt.key=="CURSOR_UP") then
    self.pos=shift(self.pos,-1,self.icons)
    self.bar.stop=true
    self:iconDraw()
  elseif ( evt.key=="CURSOR_DOWN") then
    self.pos=shift(self.pos,1,self.icons)
    self.bar.stop=true
    self:iconDraw()
  elseif (self.pos ==1 and self.episodiopages > 1) then
    if ( evt.key == "CURSOR_LEFT" ) then
      self.episodiopos=shift(self.episodiopos,-1, self.episodiopages)
      self:episodio()
    elseif (  evt.key == "CURSOR_RIGHT" ) then
      self.episodiopos=shift(self.episodiopos,1, self.episodiopages)
      self:episodio()
    end
  elseif ( self.pos==2 ) then
    if ( evt.key == "CURSOR_LEFT" ) then
      self.spos=shift(self.spos,-1, #self.list)
      self:repertorio()
    elseif (  evt.key == "CURSOR_RIGHT" ) then
      self.spos=shift(self.spos,1, #self.list)
      self:repertorio()
    end
  elseif ( self.pos==3 and self.especialpages >1 ) then
    if ( evt.key == "CURSOR_LEFT" ) then
      self.especialpos=shift(self.especialpos,-1, self.especialpages)
      self:iconDraw()
    elseif (  evt.key == "CURSOR_RIGHT" ) then
      self.especialpos=shift(self.especialpos,1, self.especialpages)
      self:iconDraw()
    end
    -- PGM
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

-- harmonia icons vert scroll
function harmoniaMenu:iconDraw()
  if (not PGMON) then
    canvas:attrColor(0,0,0,0)
    canvas:clear(0,0, GRID*32, GRID*18 )
    PGMON = true
  end

  local sumdy=01

  canvas:attrColor(93,196,179,217)
  canvas:clear(0,GRID*11, GRID*32, GRID*18 )
  canvas:attrFont("Tiresias", 22,"bold")

  for i=1,#self.menu  do
    -- icon on
    if i==self.pos then
      self.bar.y = ((GRID*11.34)+((GRID*i)))
      self.bar.width = self.menu[i].width
      self.bar.desc = self.menu[i].desc

      local imgicon = canvas:new("media/harmonia/icon.png")
      canvas:compose(0, GRID*10.5+(GRID*i), imgicon)

      local btni = canvas:new("media/harmonia/btn" .. i .. "on.png")
      canvas:compose(GRID, GRID*10.8+(GRID*i), btni)
--      barHorizontal()
    else
      canvas:attrColor(1,1,1,160)
      local btni = canvas:new("media/harmonia/btn" .. i .. "off.png")
      canvas:compose(GRID, GRID*10.8+(GRID*i), btni)
    end
  end

  local imgbgdleft = canvas:new("media/harmonia/bgd00.png")
  canvas:compose(0, GRID*11, imgbgdleft )

  -- Draw nav buttons
  local btnarrowv = canvas:new("media/btnarrowv.png")
  local btnexit = canvas:new("media/btnsair.png")
  canvas:compose(GRID*1.5, GRID*17, btnarrowv)
  canvas:compose(GRID*3, GRID*17, btnexit)

  self:menuItem()
  --canvas:flush()
end

-- sub menu repertorio draw carrossel
function harmoniaMenu:repertorio()
--  canvas:attrColor(0,0,0,0)
  --  canvas:clear(0,0, GRID*32, GRID*11 )
  local offset_x = GRID*6.5
  local offset_y = GRID*11.5
  canvas:attrColor(93,196,179,217)
  canvas:clear(GRID*6,GRID*11, GRID*32, GRID*18 )

  local imgbgdr = canvas:new("media/harmonia/bgd0" .. math.random(4) .. ".png")
  local imgiconpath = string.format("%02d",self.list[self.spos]["img"])
  local imgicon = canvas:new("media/harmonia/" .. imgiconpath .. ".png" )
  local dx,dy = imgicon:attrSize()

  canvas:compose(GRID*6, GRID*11, imgbgdr)
  canvas:compose(GRID*6, GRID*11.5, imgicon )

  --lines
  canvas:attrColor(255,255,255,255)
  canvas:drawLine(offset_x+dx, offset_y+GRID/2+5, SCREEN_WIDTH-GRID, offset_y+GRID/2  )

  --texts
  canvas:attrFont("Tiresias", 18,"bold")
  canvas:attrColor(1,1,1,200)
  canvas:drawText((offset_x+dx),offset_y, self.list[self.spos]["evento"] )
  canvas:drawText((offset_x+dx),(offset_y+(GRID)), self.list[self.spos]["regente"])
  canvas:drawText((offset_x+dx),(offset_y+(GRID*2)), self.list[self.spos]["local"])
  canvas:drawText((offset_x+dx),offset_y+(GRID*3), "Data: " .. self.list[self.spos]["data"])
  canvas:drawText((offset_x+dx),(offset_y+(GRID*4)), "Horário: " .. self.list[self.spos]["horario"])

  --obras, lines of text
  local list =textWrap(self.list[self.spos]["programa"],70)
  for i=1,#list do
    canvas:drawText((offset_x+dx),(offset_y+GRID*5+((i-1)*(GRID/2))) , list[i])
  end

  canvas:attrFont("Tiresias", 14,"bold")
  canvas:drawText((offset_x-GRID/2),(offset_y+dy+GRID/4), "Evento: " .. self.spos .. "/" .. #self.list)

  --qr code
  local imgqr = canvas:new("media/harmonia/qr" .. string.format("%02d",self.list[self.spos]["img"]) .. ".png")
  dx,dy = imgqr:attrSize()
  canvas:compose(SCREEN_WIDTH-GRID-dx, SCREEN_HEIGHT-GRID-dy, imgqr)

  canvas:flush()
end



-- sub menu especial do mês
function harmoniaMenu:episodio()
  canvas:attrColor(93,196,179,217)
  canvas:clear(GRID*6,GRID*11, GRID*32, GRID*18 )

  local imgbgdr = canvas:new("media/harmonia/bgd0" .. math.random(4) .. ".png")
  canvas:compose(GRID*6, GRID*11, imgbgdr)

  canvas:attrFont("Tiresias", 14,"normal")
  canvas:attrColor(1,1,1,200)

  local m = (self.episodiopos-1)*self.episodiolines
  for  i = m+1, m+self.episodiolines   do
    if not self.episodiolist[i] then
      self.episodiolist[i] = " "
    end
    canvas:drawText(GRID*6,GRID*11.5+(GRID*0.75*(i-m-1)),self.episodiolist[i])
  end


  local img = canvas:new("media/harmonia/asemana" .. self.episodiopos .. ".png")
  local dx,dy = img:attrSize()
  canvas:compose(SCREEN_WIDTH-dx-GRID/2, GRID*11.5, img)

  local btnok = canvas:new("media/pgminfo.png")
  local btnokdx,btnokdy = btnok:attrSize()
  canvas:compose(SCREEN_WIDTH-btnokdx-GRID/2, GRID*11.5+dy+GRID/4, btnok)



  canvas:flush()
end



-- sub menu especial do mês
function harmoniaMenu:especial()
  canvas:attrColor(93,196,179,217)
  canvas:clear(GRID*6,GRID*11, GRID*32, GRID*18 )

  local imgbgdr = canvas:new("media/harmonia/bgd0" .. math.random(4) .. ".png")
  canvas:compose(GRID*6, GRID*11, imgbgdr)

  canvas:attrFont("Tiresias", 14,"normal")
  canvas:attrColor(1,1,1,200)

  local m = (self.especialpos-1)*self.especiallines 
  for  i = m+1, m+self.especiallines   do
    if not self.especiallist[i] then
      self.especiallist[i] = " "
    end
    canvas:drawText(GRID*6,GRID*11.5+(GRID*0.75*(i-m-1)),self.especiallist[i])
  end

  local img = canvas:new("media/harmonia/especialdomes" .. self.especialpos .. ".png")
  local dx,dy = img:attrSize()
  canvas:compose(SCREEN_WIDTH-dx-GRID/2, GRID*11.5, img)


  local btnok = canvas:new("media/pgminfo.png")
  local btnokdx,btnokdy = btnok:attrSize()
  canvas:compose(SCREEN_WIDTH-btnokdx-GRID/2, GRID*11.5+dy+GRID/4, btnok)
end

--- main menu treatment
function harmoniaMenu:menuItem(par)

  canvas:attrColor(93,196,179,217)
  canvas:clear(GRID*6,GRID*11, GRID*32, GRID*18 )

  -- edicao da semana
  if (self.pos==1) then
    if (self.episodiopages>1) then
      local imgbtnarrowh = canvas:new("media/btnarrowh.png")
      canvas:compose(GRID*4.5, GRID*11.5, imgbtnarrowh)
    end
    self:episodio()
    -- repertorio - agenda semanal
  elseif (self.pos == 2) then
    local imgbtnarrowh = canvas:new("media/btnarrowh.png")
    canvas:compose(GRID*4.5, GRID*12.5, imgbtnarrowh)
    local imgbgdr = canvas:new("media/harmonia/bgd0" .. math.random(4) .. ".png")
    canvas:compose(GRID*6, GRID*11.5, imgbgdr)
    self:repertorio()
    -- especial do mes
  elseif (self.pos==3) then
    if (self.especialpages>1) then
      local imgbtnarrowh = canvas:new("media/btnarrowh.png")
      canvas:compose(GRID*4.5, GRID*13.5, imgbtnarrowh)
    end
    self:especial()
    -- contatos
  elseif (self.pos==4) then
    local imgbgdr = canvas:new("media/harmonia/bgd0" .. math.random(4) .. ".png")
    canvas:compose(GRID*6, GRID*11, imgbgdr)
    local img = canvas:new("media/harmonia/contatos.png")
    canvas:compose(GRID*6, GRID*11, img)
    if  par == 'red' then
      local img = canvas:new("media/harmonia/qr01.png")
      local dx,dy = img:attrSize()
      canvas:attrColor(0,0,0,0)
      canvas:clear(SCREEN_WIDTH-GRID*5,SCREEN_HEIGHT-GRID*5, dx, dy )
      canvas:compose(SCREEN_WIDTH-GRID*5,SCREEN_HEIGHT-GRID*5, img)
    elseif  par == 'green' then
      local img = canvas:new("media/harmonia/qr02.png")
      local dx,dy = img:attrSize()
      canvas:attrColor(0,0,0,0)
      canvas:clear(SCREEN_WIDTH-GRID*5,SCREEN_HEIGHT-GRID*5, dx, dy )
      canvas:compose(SCREEN_WIDTH-GRID*5,SCREEN_HEIGHT-GRID*5, img)
    elseif  par == 'yellow' then
      local img = canvas:new("media/harmonia/qr03.png")
      local dx,dy = img:attrSize()
      canvas:attrColor(0,0,0,0)
      canvas:clear(SCREEN_WIDTH-GRID*5,SCREEN_HEIGHT-GRID*5, dx, dy )
      canvas:compose(SCREEN_WIDTH-GRID*5,SCREEN_HEIGHT-GRID*5, img)
    elseif  par == 'blue' then
      local img = canvas:new("media/harmonia/qr04.png")
      local dx,dy = img:attrSize()
      canvas:attrColor(0,0,0,0)
      canvas:clear(SCREEN_WIDTH-GRID*5,SCREEN_HEIGHT-GRID*5, dx, dy )
      canvas:compose(SCREEN_WIDTH-GRID*5,SCREEN_HEIGHT-GRID*5, img)
    end
  end
  canvas:flush()
end

function barHorizontalAnim()
  local mult = 10
  for i=1,(harmonia.bar.width/mult) do
    if (PGMON and not harmonia.bar.stop) then
      canvas:attrColor(255,255,255,255)
      canvas:clear(GRID/2-3,harmonia.bar.y,((i)*mult),1)
      canvas:flush()
      coroutine.yield(i) -- sleep...
    end
  end
end

function barHorizontalUpdate()
--  print (coroutine.status(barHorizontalCoroutine))
  coroutine.resume(barHorizontalCoroutine)
  if   coroutine.status(barHorizontalCoroutine) ~= 'dead'  then
    event.timer(30,barHorizontalUpdate)
  end
end

function barHorizontal()
  harmonia.bar.stop=false
  barHorizontalCoroutine=coroutine.create(barHorizontalAnim)
  barHorizontalUpdate()
end
