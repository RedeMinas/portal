--- altofalante object

altofalante = {}

function altofalante:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self

  self.posh = 1

  self.pages = 4
  self.page = 1

  self.pos = {}
  for i = 1, self.pages do
    self.pos[i] = {}
    for j = 1 , 8 do
      self.pos[i][j]=1
    end
  end

  self.bgdcolor = {255,102,0,200}

  ---   [1], pos,[2] pages, [3]offset, [4]x, [5]y
  self.meta = {
    {1,8,2,0,GRID*5,color1="brown", color2="yellow"},
    {1,4,2,0,GRID*10,color1="yellow", color2="blue"},
    {1,7,2,GRID*15,GRID*5,color1="pink", color2="red"},
    {1,6,2,GRID*15,GRID*10,color1="gray", color2="white"},
  }

--  self.listevt=layoutPgmAgendaEvt(ReadTable("tbl_agendaevt.txt"))
  return o
end

--deal with keys
function altofalante:input(evt)
  if ( evt.key == "CURSOR_LEFT" ) then
    self.page=shift(self.page,-1,self.pages)
    self:pageReset()
  elseif ( evt.key=="CURSOR_RIGHT") then
    self.page=shift(self.page,1,self.pages)
    self:pageReset()

  elseif ( evt.key == "CURSOR_UP" ) then
    self.meta[self.page][1]=shift(self.meta[self.page][1],1,self.meta[self.page][2])
    self:pageReset(self.page)
  elseif ( evt.key=="CURSOR_DOWN") then
    self.meta[self.page][1]=shift(self.meta[self.page][1],-1,self.meta[self.page][2])
    self:pageReset(self.page)
  end
end

-- agenda icons vert scroll
function altofalante:pageReset(page)
  if (not PGMON) then
    canvas:attrColor("black")
    canvas:clear()
    PGMON = true
  end

  if not page then
    canvas:attrColor(unpack(self.bgdcolor))
    canvas:clear(0,0,SCREEN_WIDTH,GRID*3)
    local imglogo = canvas:new("media/altofalante/logo.png")
    local dx,dy = imglogo:attrSize()
    canvas:compose(GRID/2, GRID/2, imglogo )

    --selector
    canvas:attrColor("red")
    canvas:drawEllipse("fill", GRID*6+GRID*5*(self.page-1), GRID*1.5, GRID*2.25, GRID*2.25)

    -- top menu
    for i=1, #self.meta do
      local knob = self:knobcvs(i)
      canvas:compose(GRID*5*i,GRID*0.5,knob)

    end

    local sector1 = self:sector1()
    local sector2 = self:sector2()
    local sector3 = self:sector3()
    local sector4 = self:sector4()

    canvas:compose(self.meta[1][4],self.meta[1][5],sector1)
    canvas:compose(self.meta[2][4],self.meta[2][5],sector2)
    canvas:compose(self.meta[3][4],self.meta[3][5],sector3)
    canvas:compose(self.meta[4][4],self.meta[4][5],sector4)

  elseif(page) then

    local sector
    if (page ==1)  then
      sector = self:sector1()
    elseif (page==2) then
      sector = self:sector2()
    elseif (page==3) then
      sector = self:sector3()
    elseif (page==4) then
      sector = self:sector4()
    end

    local knob = self:knobcvs(page)

    canvas:compose(GRID*5*page,GRID*0.5,knob)

    canvas:compose(self.meta[page][4],self.meta[page][5],sector)
  end


  canvas:flush()
end

function altofalante:knobcvs(component)
    local div = self.meta[component][3] +1

  local pi = 22/7
  local size = GRID*2
  local alpha	= pi * 2 / self.meta[component][2]
  local theta = alpha * (self.meta[component][1]  + self.meta[component][3])
  --print ("alpha, teta" ,alpha, theta)
  local px = math.cos( theta )  * size*0.4 + size/2
  local py = math.sin( theta )  * size*0.4 + size/2
  --print("px,py" , px, py)
  local cvs = canvas.new(size,size)

  cvs:attrColor(self.meta[component].color1)
  cvs:drawEllipse ('fill', size/2,size/2, size,size)
  cvs:attrColor(self.meta[component].color2)
  cvs:drawLine(size/2,size/2, px,py)
  cvs:attrFont("Tiresias", 16,"bold")
  cvs:attrColor("black")
  cvs:drawText(size/2,size/2, self.meta[component][1])
  cvs:flush()
  return cvs
end


function altofalante:switchcvs(pos, div, color1, color2)
  local size = GRID*4
  local mult = 4
  local cvs = canvas.new(size/mult,size)

  -- fundo
  cvs:attrColor(color1)
  cvs:clear()
  --cvs:drawRect ('fill', 10, 10, size/mult,size/div)

  cvs:attrColor(color2)
  cvs:drawRect ('fill', 10, size/div*(pos-1), size-20, size/div)

  cvs:attrFont("Tiresias", 16,"bold")
  cvs:attrColor("white")
  cvs:drawText(size/2,size/2, pos)

  cvs:flush()
  return cvs
end

function altofalante:sector1()
  local sizex = GRID*6
  local sizey = GRID*5

  local cvs = canvas.new(sizex,sizey)
  cvs:attrColor(self.meta[1].color1)
  cvs:drawRect('fill',0,0,sizex,sizey)
  cvs:attrColor(self.meta[1].color2)
  cvs:drawText(GRID,GRID,self.meta[1][1])

  cvs:flush()
  return cvs
end


function altofalante:sector2()
  local sizex = GRID*5
  local sizey = GRID*5

  local cvs = canvas.new(sizex,sizey)
  cvs:attrColor(self.meta[2].color1)
  cvs:drawRect('fill',0,0,sizex,sizey)
  cvs:attrColor(self.meta[2].color2)
  cvs:drawText(GRID,GRID,self.meta[2][1])

  cvs:flush()
  return cvs
end


function altofalante:sector3()
  local sizex = GRID*5
  local sizey = GRID*5

  local cvs = canvas.new(sizex,sizey)
  cvs:attrColor(self.meta[3].color1)
  cvs:drawRect('fill',0,0,sizex,sizey)
  cvs:attrColor(self.meta[3].color2)

  cvs:flush()
  return cvs
end

function altofalante:sector4()
  local sizex = GRID*5
  local sizey = GRID*5

  local cvs = canvas.new(sizex,sizey)
  
  cvs:attrColor(self.meta[4].color1)
  cvs:drawRect('fill',0,0,sizex,sizey)
  cvs:attrColor(self.meta[4].color2)
  cvs:drawText(GRID,GRID,self.meta[4][1])

  cvs:flush()
  return cvs
end
