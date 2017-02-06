--- Harmonia object

harmoniaMenu = {}

function harmoniaMenu:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.pos = 1
  self.spos = 1
  self.icons=4
--  self.pgmicons = math.floor(screen_width/210)
--  self.list=layoutPgmTable(ReadTable("tbl_pgm.txt"))
  self.debug=false
  self.bar={}
  self.bar.stop=false
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

  self:menuItem()

  local sumdy=0

  local menu ={
    {desc="Edição da semana",width=500},
    {desc="Especial do mês",width=800},
    {desc="Repertório",width=1200},
    {desc="Contatos",width=200}
  }

  canvas:attrFont("Vera", 18,"bold")

  for i=1,#menu  do
    -- icon on
    if i==self.pos then
      if i == 4 then
        local imgbtn = canvas:new("media/harmonia/btn4on.png")
        local dx,dy = canvas:attrSize(imbtn)
        canvas:compose(0, grid*10+grid*i, imgbtn)
      else
        canvas:attrColor(255,195,111,200)
        local dx,dy = canvas:measureText(menu[i].desc)
        canvas:drawText((menu[i].width-dx),(grid*10.5+(grid*i)), menu[i].desc)
        --draw barHorizontal for each menu icon entry
        -- CHANGE CONDITIONS TO  TABLE menu!!!!
      end
      self.bar.y = ((grid*11)+((grid*i)))
      self.bar.width = menu[i].width
      barHorizontal()
      --icon off
    else
      if i == 4 then
        local imgbtn = canvas:new("media/harmonia/btn4off.png")
        canvas:compose(0, grid*10+grid*i, imgbtn)
      else
        canvas:attrColor(255,195,111,200)
        local dx,dy = canvas:measureText(menu[i].desc)
        canvas:drawText((grid*2),(grid*10.5+(grid*i)), menu[i].desc)

      end
    end
  end
  
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
--  canvas:attrColor(0,0,0,0)
--  canvas:clear(0,0, grid*32, grid*10 )
  canvas:attrColor(93,196,179,217)
  canvas:clear(grid*7,grid*11, grid*32, grid*18 )

  -- edicao da semana
  if (self.pos==1) then
    local imgbgdr = canvas:new("media/harmonia/bgd0" .. math.random(4) .. ".png")
    canvas:compose(grid*7, grid*11.5, imgbgdr)
    local img = canvas:new("media/harmonia/edicaodasemana.png")
    canvas:compose(grid*7, grid*11.5, img)
    -- especial do mes
  elseif (self.pos==2) then
    local imgbgdr = canvas:new("media/harmonia/bgd0" .. math.random(4) .. ".png")
    canvas:compose(grid*7, grid*11.5, imgbgdr)
    local img = canvas:new("media/harmonia/especialdomes.png")
    canvas:compose(grid*7, grid*11.5, img)
    -- repertorio - agenda semanal

  elseif (self.pos == 3) then
    local imgbtnarrowh = canvas:new("media/btnarrowh.png")
    canvas:compose(grid*2.5, grid*17, imgbtnarrowh)
    local imgbgdr = canvas:new("media/harmonia/bgd0" .. math.random(4) .. ".png")
    canvas:compose(grid*7, grid*11.5, imgbgdr)
    local img = canvas:new("media/harmonia/repertorio.png")
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

--function barHorizontalAnim(param)
function barHorizontalAnim()
  local mult = 10
  for i=1,(harmonia.bar.width/mult) do
    if (pgmOn and not harmonia.bar.stop) then
      canvas:attrColor(255,255,255,200)
       canvas:drawRect("fill",10,harmonia.bar.y,(i*mult),10)
      canvas:flush()
      coroutine.yield(i) -- sleep...
    end
  end
  --    canvas:flush(10,param.y,(i*mult),10)
end


function barHorizontalUpdate()
  --   print (coroutine.status(barHorizontalCoroutine))
  coroutine.resume(barHorizontalCoroutine)
  if   coroutine.status(barHorizontalCoroutine) ~= 'dead'  then
    --    event.timer(30,barHorizontalUpdate,param)
    event.timer(30,barHorizontalUpdate)
  end
end

--function barHorizontal(param)
function barHorizontal()
  harmonia.bar.stop=false
  barHorizontalCoroutine=coroutine.create(barHorizontalAnim)
  barHorizontalUpdate()
end
