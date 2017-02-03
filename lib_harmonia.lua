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
    STOP=true
    self:iconDraw()
  elseif ( evt.key=="CURSOR_DOWN") then
    self.pos=shift(self.pos,1,self.icons)
    STOP=true
    self:iconDraw()
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

  local menu ={
    {desc="Edição da semana",width=1200},
    {desc="Especial do mês",width=500},
    {desc="Repertório",width=1200},
    {desc="Contatos",width=400}
  }
  local param = {}
  canvas:attrFont("Vera", 20,"bold")

  for i=1,self.icons  do
    --remover?
    if i==self.pos then
      local dx,dy = canvas:measureText(menu[i].desc)
      --draw barHorizontal for each menu icon entry
      -- CHANGE CONDITIONS TO  TABLE menu!!!!
      param.y = ((grid*11)+((grid*i)))
      param.width = menu[i].width
      print ("ok")
      barHorizontal(param)
      --canvas:attrColor(255,195,111,200)
--      canvas:drawText((menu[i].width-dx),(grid*10.5+(grid*i)), menu[i].desc)
      local imgbtn = canvas:new("media/harmonia/btn" .. i .. "on.png")
      canvas:compose(0, grid*10+grid*i, imgbtn)
      --end
    else
      local imgbtn = canvas:new("media/harmonia/btn" .. i .. "off.png")
      canvas:compose(0, grid*10+grid*i, imgbtn)
      --canvas:attrColor(255,255,255,150)
      --canvas:drawText((grid*1.5),(grid*10.5+(grid*i)), menu[i].desc)
    end
  end
  self:menuItem()
  canvas:flush()
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
    -- contatos
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

function barHorizontalAnim(param)
  canvas:attrColor("black",100)
  local mult = 100
  for i=1,(param.width/mult) do
    if (pgmOn and not STOP) then
      canvas:attrColor(255,255,255,200)
      canvas:clear(10,param.y,(i*mult),10)

      --DEBUG
      if (_debug_) then
          canvas:attrFont("Vera", 20,"bold")
        canvas:attrColor(0,0,0,255)
        canvas:clear(0,param.y-500,grid*20,grid*2)
        canvas:attrColor(255,120,120,200)
        canvas:drawText(grid*1,param.y-500, i*mult)
      end
        canvas:flush()
      coroutine.yield(i) -- sleep...
    end
  end
end

function barHorizontalUpdate(param)
  --    print (coroutine.status(barHorizontalCoroutine))
  errorfree, value = coroutine.resume(barHorizontalCoroutine,param)
  if   coroutine.status(barHorizontalCoroutine) ~= 'dead'  then
    event.timer(160,barHorizontalUpdate,param)
  end
  return value
end

STOP=false

_debug_=true
function barHorizontal(param)
    barHorizontalCoroutine=coroutine.create(barHorizontalAnim)
    return barHorizontalUpdate(param)
end

