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
  elseif ( self.pos==2 and evt.key == "CURSOR_LEFT" ) then
    self.spos=shift(self.spos,-1, #self.list)
    self:repertorio()
  elseif ( self.pos==2 and evt.key == "CURSOR_RIGHT" ) then
    self.spos=shift(self.spos,1, #self.list)
    self:repertorio()
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
  --local btnarrowh = canvas:new("media/btnarrowh.png")
  local btnexit = canvas:new("media/btnsair.png")
  canvas:compose(GRID, GRID*17, btnarrowv)
  --  canvas:compose(GRID*2.5, GRID*17, btnarrowh)
  canvas:compose(GRID*4, GRID*17, btnexit)

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
  canvas:drawLine(offset_x+dx, offset_y+GRID/2, SCREEN_WIDTH-GRID, offset_y+GRID/2  )

  --texts
  canvas:attrFont("Tiresias", 18,"bold")
  canvas:attrColor(1,1,1,200)
  canvas:drawText((offset_x+dx),offset_y, self.list[self.spos]["grupo"] )
  canvas:drawText((offset_x+dx+(11*GRID)),offset_y, "Data: " .. self.list[self.spos]["data"])
  canvas:drawText((offset_x+dx+(17*GRID)),(offset_y), "Horário: " .. self.list[self.spos]["horario"])

--  canvas:drawText((offset_x+dx),(offset_y+(GRID)), self.list[self.spos]["compositores"])

  canvas:drawText((offset_x+dx),(offset_y+(GRID*0.6)), self.list[self.spos]["regente"])
  canvas:drawText((offset_x+dx+(11*GRID)),(offset_y+(GRID*0.6)), self.list[self.spos]["local"])

  --obras, lines of text
  local list =textWrap(self.list[self.spos]["obras"],70)
  for i=1,#list do
    canvas:drawText((offset_x+dx),(offset_y+GRID*0.7+(i*(GRID/2))) , list[i])
  end

  canvas:attrFont("Tiresias", 13,"bold")

  --description, lines of text
  local list =textWrap(self.list[self.spos]["desc"],96)
  for i=1,#list do
    canvas:drawText((offset_x+dx),(offset_y+(2*GRID)+(i*(GRID/2))) , list[i])
  end

  --qr code
  local imgqr = canvas:new("media/harmonia/qr" .. string.format("%02d",self.list[self.spos]["img"]) .. ".png")
  dx,dy = imgqr:attrSize()
  canvas:compose(SCREEN_WIDTH-GRID-dx, SCREEN_HEIGHT-GRID-dy, imgqr)
  canvas:flush()
end



--- main menu treatment
function harmoniaMenu:menuItem(par)

  canvas:attrColor(93,196,179,217)
  canvas:clear(GRID*6,GRID*11, GRID*32, GRID*18 )

  -- edicao da semana
  if (self.pos==1) then
    local imgbgdr = canvas:new("media/harmonia/bgd0" .. math.random(4) .. ".png")
    canvas:compose(GRID*6, GRID*11, imgbgdr)
    local img = canvas:new("media/harmonia/edicaodasemana.png")
    canvas:compose(GRID*6, GRID*11.5, img)
    -- repertorio - agenda semanal
  elseif (self.pos == 2) then
    local imgbtnarrowh = canvas:new("media/btnarrowh.png")
    canvas:compose(GRID*2.5, GRID*17, imgbtnarrowh)
    local imgbgdr = canvas:new("media/harmonia/bgd0" .. math.random(4) .. ".png")
    canvas:compose(GRID*6, GRID*11.5, imgbgdr)
--    local img = canvas:new("media/harmonia/repertorio.png")
  --  canvas:compose(GRID*7, GRID*11, img)
    self:repertorio()
    -- especial do mes
  elseif (self.pos==3) then
    local imgbgdr = canvas:new("media/harmonia/bgd0" .. math.random(4) .. ".png")
    canvas:compose(GRID*6, GRID*11, imgbgdr)
    local img = canvas:new("media/harmonia/especialdomes.png")
    canvas:compose(GRID*6, GRID*11.5, img)
    -- contatos
  elseif (self.pos==4) then
    local imgbgdr = canvas:new("media/harmonia/bgd0" .. math.random(4) .. ".png")
    canvas:compose(GRID*6, GRID*11, imgbgdr)
    local img = canvas:new("media/harmonia/contatos.png")
    canvas:compose(GRID*6, GRID*12, img)
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
