--- Harmonia object

harmoniaMenu = {}

function harmoniaMenu:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.pos = 1
  self.spos = 1
  self.icons = 4
--  self.pgmicons = math.floor(screen_width/210)
--  self.list=layoutPgmTable(ReadTable("tbl_pgm.txt"))
  self.debug=false
--  self.settings=false
  return o
end


--deal with keys
function harmoniaMenu:input (evt)
  if (evt.key=="CURSOR_UP") then
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

-- harmonia icons vert scroll
function harmoniaMenu:iconDraw()
  if (not pgmOn) then
    --self:pageReset()
    pgmOn = true
  end

  self:pageReset()
  local iconpath=""
  local sumdy=0

  local menu ={"Edição do mês","Repertório", "Bla", "blu"}
  canvas:attrFont("Vera", 20,"bold")

  for i=1,self.icons  do
    --remover?
    if i==self.pos then
      canvas:attrColor("grey")
      canvas:drawText(grid*1.5,grid*11+(grid*i), menu[i])
      barHorizontal(grid*11+(grid*i+30))
    else
      canvas:attrColor(255,255,255,200)
      canvas:drawText(grid*1,grid*11+(grid*i), menu[i])
    end
  end
  self:pageDraw()
  canvas:flush()
end

function harmoniaMenu:pageDraw()
  canvas:attrColor(93,196,179,217)
--  canvas:attrColor("blue")
--  canvas:clear(grid*7,grid*11, grid*32, grid*18 )
end

function harmoniaMenu:pageReset()
  canvas:attrColor(0,0,0,0)
  canvas:clear(0,0, grid*32, grid*18 )
  canvas:attrColor(93,196,179,217)
  canvas:clear(0,grid*11, grid*32, grid*18 )

  local imgbgdleft = canvas:new("media/harmonia/bgd00.png")
  canvas:compose(0, grid*11, imgbgdleft )

  -- draw redeminas logo
  local logo = canvas:new("media/btn1off.png")
  canvas:compose(grid*1.5, grid*16, logo )

  -- Draw nav buttons
  local btnarrowv = canvas:new("media/btnarrowv.png")
  --local btnarrowh = canvas:new("media/btnarrowh.png")
  local btnexit = canvas:new("media/btnsair.png")
  canvas:compose(grid, grid*17, btnarrowv)
--  canvas:compose(grid*2.5, grid*17, btnarrowh)
  canvas:compose(grid*4, grid*17, btnexit)
end

-- main menu treatment
function harmoniaMenu:menuItem(par)
  --canvas:attrColor(0,0,0,0)
  --canvas:clear(0,0, grid*32, grid*10 )

  -- edicao da semana
  if (self.pos==1) then
    local imgbgdr = canvas:new("media/harmonia/bgd0" .. math.random(4) .. ".png")
    canvas:compose(grid*7, grid*11.5, imgbgdr)
    local img = canvas:new("media/harmonia/edicaodasemana.png")
    canvas:compose(grid*7, grid*11.5, img)
    -- repertorio - agenda semanal
  elseif (self.pos == 2) then
    local imgbtnarrowh = canvas:new("media/btnarrowh.png")
    canvas:compose(grid*2.5, grid*17, imgbtnarrowh)
    local imgbgdr = canvas:new("media/harmonia/bgd0" .. math.random(4) .. ".png")
    canvas:compose(grid*7, grid*11.5, imgbgdr)
    local img = canvas:new("media/harmonia/repertorio.png")
    canvas:compose(grid*7, grid*11.5, img)
    -- especial do mes
  elseif (self.pos==3) then
    local imgbgdr = canvas:new("media/harmonia/bgd0" .. math.random(4) .. ".png")
    canvas:compose(grid*7, grid*11.5, imgbgdr)
    local img = canvas:new("media/harmonia/especialdomes.png")
    canvas:compose(grid*7, grid*11.5, img)
  elseif (self.pos==4) then
    local imgbgdr = canvas:new("media/harmonia/bgd0" .. math.random(4) .. ".png")
    canvas:compose(grid*7, grid*11.5, imgbgdr)
    local img = canvas:new("media/harmonia/contatos.png")
    canvas:compose(grid*7, grid*11.5, img)
    if  par == 'red' then
      local img = canvas:new("media/qrfb.png")
      local dx,dy = img:attrSize()
      canvas:attrColor(0,0,0,0)
      canvas:clear(grid*32-dx,grid, dx, dy )
      canvas:compose(grid*32-dx, grid, img)
    elseif  par == 'green' then
      local img = canvas:new("media/qrtwitter.png")
      local dx,dy = img:attrSize()
      canvas:attrColor(0,0,0,0)
      canvas:clear(grid*32-dx,grid, dx, dy )
      canvas:compose(grid*32-dx, grid, img)
    elseif  par == 'yellow' then
      local img = canvas:new("media/qrinsta.png")
      local dx,dy = img:attrSize()
      canvas:attrColor(0,0,0,0)
      canvas:clear(grid*32-dx,grid, dx, dy )
      canvas:compose(grid*32-dx, grid, img)
    elseif  par == 'blue' then
      local img = canvas:new("media/qryoutube.png")
      local dx,dy = img:attrSize()
      canvas:attrColor(0,0,0,0)
      canvas:clear(grid*32-dx,grid, dx, dy )
      canvas:compose(grid*32-dx, grid, img)
    end
  end
  canvas:flush()
end

function barHorizontalAnim(y)
  icon = canvas:new("media/harmonia/barh.png")
  for i=1,280 do
    if (pgmOn) then
      icon:attrCrop(0,0,i,4)
      canvas:compose(0,y,icon)
      canvas:attrColor("black")
      canvas:clear(0,y-500,grid*10,grid*2)
      canvas:attrFont("Vera", 20,"bold")
      canvas:attrColor("white")
      canvas:drawText(grid*1,y-500, i)
      canvas:flush()
      coroutine.yield() -- sleep...
    end
  end
end


function barHorizontalUpdate(y)
  --  print (coroutine.status(barHorizontalCoroutine))
  coroutine.resume(barHorizontalCoroutine,y)
  if   coroutine.status(barHorizontalCoroutine) ~= 'dead' then
    event.timer(3,barHorizontalUpdate,y)
  end
end

function barHorizontal(y)
  barHorizontalCoroutine= coroutine.create(barHorizontalAnim)
  barHorizontalUpdate(y)
end
