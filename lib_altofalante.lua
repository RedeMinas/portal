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

  self.apos = 1
  self.apages = 8

  self.xpos = 1
  self.xpages=4

  self.ypos = 1
  self.ypages = 10

  self.zpos = 1
  self.zpages=10

  self.wpos = 1
  self.spos = 1

  self.bgdcolor = {255,102,0,200}

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
  elseif ( self.page == 1 ) then
    if ( evt.key == "CURSOR_UP" ) then
      self.apos=shift(self.apos,1,self.apages)
      self:pageReset()
    elseif ( evt.key=="CURSOR_DOWN") then
      self.apos=shift(self.apos,-1,self.apages)
      self:pageReset()
    end
  elseif ( self.page == 2 ) then
    if ( evt.key == "CURSOR_UP" ) then
      self.xpos=shift(self.xpos,1,self.xpages)
      self:pageReset()
    elseif ( evt.key=="CURSOR_DOWN") then
      self.xpos=shift(self.xpos,-1,self.xpages)
      self:pageReset()
    end
  elseif ( self.page == 3 ) then
    if ( evt.key == "CURSOR_UP" ) then
      self.ypos=shift(self.ypos,-1,self.ypages)
      self:pageReset()
    elseif ( evt.key=="CURSOR_DOWN") then
      self.ypos=shift(self.ypos,1,self.ypages)
      self:pageReset()
    end
  elseif ( self.page == 4 ) then
    if ( evt.key == "CURSOR_UP" ) then
      self.zpos=shift(self.zpos,1,self.zpages)
      self:pageReset()
    elseif ( evt.key=="CURSOR_DOWN") then
      self.zpos=shift(self.zpos,-1,self.zpages)
      self:pageReset()
    end
  end
end

-- agenda icons vert scroll
function altofalante:pageReset()
  if (not PGMON) then
    canvas:attrColor("black")
    canvas:clear()
    PGMON = true
  end

  canvas:attrColor(unpack(self.bgdcolor))
  canvas:clear(0,0,SCREEN_WIDTH,GRID*3)
  local imglogo = canvas:new("media/altofalante/logo.png")
  local dx,dy = imglogo:attrSize()
  canvas:compose(GRID/2, GRID/2, imglogo )

  --selector
  canvas:attrColor("red")
  canvas:drawEllipse("fill", GRID*6+GRID*5*(self.page-1), GRID*1.5, GRID*2.25, GRID*2.25)

  local knob1 = self:knobcvs(self.apos,self.apages,2, "brown", "yellow")
  canvas:compose(GRID*5,GRID*0.5,knob1)

  local knob2 = self:knobcvs(self.xpos,self.xpages,1, "brown", "blue")
  canvas:compose(GRID*10,GRID*0.5,knob2)

  local switch1 = self:switchcvs(self.ypos,self.ypages, "pink", "red")
  canvas:compose(GRID*15,GRID*0.5,switch1)

  local knob3 = self:knobcvs(self.zpos,self.zpages,3, "green", "white")
  canvas:compose(GRD*20,GRID*0.5,knob3)

  canvas:flush()
end

function altofalante:knobcvs(pos,div,offset,color1, color2)
  div = div +1
  local pi = 22/7
  local size = GRID*2
  local alpha	= pi * 2 / (div )
  local theta = alpha * (pos  + offset)
  --print ("alpha, teta" ,alpha, theta)
  local px = math.cos( theta )  * size*0.4 + size/2
  local py = math.sin( theta )  * size*0.4 + size/2
  --print("px,py" , px, py)
  local cvs = canvas.new(size,size)

  cvs:attrColor(color1)
  cvs:drawEllipse ('fill', size/2,size/2, size,size)
  cvs:attrColor(color2)
  cvs:drawLine(size/2,size/2, px,py)
  cvs:attrFont("Tiresias", 16,"bold")
  cvs:attrColor("black")
  cvs:drawText(size/2,size/2, pos)
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

  self:discos()
  cvs:flush()
  return cvs
end

function altofalante:discos()
  for i = 1, 10 do
--    local imglogo = canvas:new("media/" .. i .. ".png")
    --local dx,dy = imglogo:attrSize()
    --canvas:compose(GRID*2, GRID*5+GRID*i-1, imglogo)
    print(i)
  end
end
