--- Harmonia object

harmoniaMenu = {}

function harmoniaMenu:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.pos = 1
  self.spos = 1
  self.icons=4
--  self.pgmicons = math.floor(SCREEN_WIDTH/210)
--  self.list=layoutPgmTable(ReadTable("tbl_pgm.txt"))
  self.debug=false
  self.bar={}
  self.bar.stop=false
  self.repertorioItens=4
  --remove
  self.list=layoutPgmHarmonia(ReadTable("tbl_harmoniarepertorio.txt"))
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

  local menu ={
    {desc="Edição da semana",width=250},
    {desc="Repertório",width=200},
    {desc="Villa Lobos",width=250},
    {desc="Contatos",width=220}
  }

  canvas:attrColor(93,196,179,217)
  canvas:clear(0,GRID*11, GRID*32, GRID*18 )
  canvas:attrFont("Tiresias", 22,"bold")

  for i=1,#menu  do
    -- icon on
    if i==self.pos then
      self.bar.y = ((GRID*11+1)+((GRID*i)))
      self.bar.width = menu[i].width
      self.bar.desc = menu[i].desc
      if i == 4 then
        menu[i].desc= ""
      end
      canvas:attrColor("white")
      canvas:drawText((GRID),(GRID*11.3+(GRID*(i-1))), menu[i].desc)

      barHorizontal()
    else
      if (i < 4) then
        canvas:attrColor(1,1,1,160)
        canvas:drawText((GRID),(GRID*11.3+(GRID*(i-1))), menu[i].desc)
      end
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

-- sub menu pgm draw carrossel
function harmoniaMenu:repertorio()
--  canvas:attrColor(0,0,0,0)
--  canvas:clear(0,0, GRID*32, GRID*11 )
  canvas:attrColor(93,196,179,217)
  canvas:clear(GRID*6,GRID*11, GRID*32, GRID*18 )
  local imgbgdr = canvas:new("media/harmonia/bgd0" .. math.random(4) .. ".png")
  canvas:compose(GRID*6, GRID*11, imgbgdr)

  for i=1,self.repertorioItens  do
    if i==1 then
      self:repertorioIcons(shift(self.spos-1,i,#self.list),i,true)
    else
      self:repertorioIcons(shift(self.spos-1,i,#self.list),i,false)
    end
  end

  -- icone +info
  if (self.list[self.spos]["info"] == true) then
    local imginfo = canvas:new("media/pgminfo.png")
    canvas:compose(GRID*26.5, GRID*17, imginfo )
  end

  --text
  canvas:attrFont("Vera", 16,"bold")
  canvas:attrColor(1,1,1,160)

  canvas:drawText(GRID*6,GRID*14, self.list[self.spos]["grupo"] )
  canvas:drawText(GRID*14,GRID*14, self.list[self.spos]["regente"])
  canvas:drawText(GRID*20,GRID*14, self.list[self.spos]["obras"])

  canvas:attrFont("Vera", 13,"bold")

  canvas:drawText(GRID*6,GRID*14.5, self.list[self.spos]["compositores"])
  canvas:drawText(GRID*14,GRID*14.5, self.list[self.spos]["data"])
  canvas:drawText(GRID*18,GRID*14.5, self.list[self.spos]["horario"])
  canvas:drawText(GRID*20,GRID*14.5, self.list[self.spos]["local"])

  --  canvas:drawText(GRID*18,GRID*16, self.list[self.spos]["ingressso"])
  --  canvas:drawText(GRID*24,GRID*16, self.list[self.spos]["info"])

  --description, lines of text
  local list =textWrap(self.list[self.spos]["desc"],SCREEN_WIDTH/12)
  for i=1,#list do
    canvas:drawText(GRID*6, (GRID*15+i*GRID*0.4) , list[i])
  end

  --qr code
  local imgbgdr = canvas:new("media/harmonia/qr" .. string.format("%02d",self.list[self.spos]["img"]) .. ".png")
  local dx,dy = canvas:attrSize(imgbgdr)
  canvas:compose(GRID*24.5, GRID*11, imgbgdr)

  canvas:flush()
end

function harmoniaMenu:repertorioIcons(t, slot, ativo)
  --setup parameters
  local item_h = 160
  local item_w = 95
  local icon = canvas:new("media/harmonia/" .. string.format("%02d" , self.list[t]["img"]).. ".png")

  canvas:compose((GRID*6+(item_w*(slot-1))+(2*GRID*(slot-1))), GRID*11.5, icon )

  if ativo then
    canvas:attrColor("white")
    --review x !!!
    canvas:drawRect("fill", GRID*6, GRID*14-5, item_h, 4)
  end
end

--- main menu treatment
function harmoniaMenu:menuItem(par)

  canvas:attrColor(93,196,179,217)
  canvas:clear(GRID*7,GRID*11, GRID*32, GRID*18 )

  -- edicao da semana
  if (self.pos==1) then
    local imgbgdr = canvas:new("media/harmonia/bgd0" .. math.random(4) .. ".png")
    canvas:compose(GRID*7, GRID*11, imgbgdr)
    local img = canvas:new("media/harmonia/edicaodasemana.png")
    canvas:compose(GRID*7, GRID*11, img)
    -- repertorio - agenda semanal
  elseif (self.pos == 2) then
    local imgbtnarrowh = canvas:new("media/btnarrowh.png")
    canvas:compose(GRID*2.5, GRID*17, imgbtnarrowh)
    local imgbgdr = canvas:new("media/harmonia/bgd0" .. math.random(4) .. ".png")
    canvas:compose(GRID*7, GRID*11, imgbgdr)
--    local img = canvas:new("media/harmonia/repertorio.png")
  --  canvas:compose(GRID*7, GRID*11, img)
    self:repertorio()
    -- especial do mes
  elseif (self.pos==3) then
    local imgbgdr = canvas:new("media/harmonia/bgd0" .. math.random(4) .. ".png")
    canvas:compose(GRID*7, GRID*11, imgbgdr)
    local img = canvas:new("media/harmonia/especialdomes.png")
    canvas:compose(GRID*7, GRID*11, img)
    -- contatos
  elseif (self.pos==4) then
    local imgbgdr = canvas:new("media/harmonia/bgd0" .. math.random(4) .. ".png")
    canvas:compose(GRID*7, GRID*11, imgbgdr)
    local img = canvas:new("media/harmonia/contatos.png")
    canvas:compose(GRID*7, GRID*12, img)
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

function barHorizontalAnim()
  local mult = 10
  for i=1,(harmonia.bar.width/mult) do
    if (PGMON and not harmonia.bar.stop) then
      canvas:attrColor(255,255,255,255)
      canvas:clear(GRID/2-3,harmonia.bar.y,((i)*mult),2)
      canvas:flush()
      coroutine.yield(i) -- sleep...
    end
  end
end

function barHorizontalUpdate()
  print (coroutine.status(barHorizontalCoroutine))
  coroutine.resume(barHorizontalCoroutine)
  if   coroutine.status(barHorizontalCoroutine) ~= 'dead'  then
    event.timer(30,barHorizontalUpdate)
  end
end

--function barHorizontal(param)
function barHorizontal()
  harmonia.bar.stop=false
  barHorizontalCoroutine=coroutine.create(barHorizontalAnim)
  barHorizontalUpdate()
end
