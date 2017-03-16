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

  self.listalbuns = layoutPgmAltofalanteAlbuns(ReadTable("tbl_af_albuns.txt"))

  self.bgdcolor = {255,102,0,200}

  ---   [1], pos,[2] pages, [3]offset, [4]x, [5]y
  self.meta = {
    {2,8,2,GRID/2,GRID*3.5,color1="blue", color2="yellow", menu="Resumo"},
    {1,#self.listalbuns,0.5,0,GRID*14,color1="yellow", color2="blue", menu="News"},
    {3,7,1.5,GRID*21,GRID*3,color1="pink", color2="red", menu="contato"},
    {1,13,3,GRID*21,GRID*7,color1="brown", color2="white", menu="Garimpo"},
  }

  

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
    -- top menu box
    canvas:attrColor(unpack(self.bgdcolor))
    canvas:clear(0,0,SCREEN_WIDTH,GRID*3)

    -- top menu logo
    local imglogoaf = canvas:new("media/altofalante/logo.png")
    local dx,dy = imglogoaf:attrSize()
    canvas:compose(GRID/2, GRID/2, imglogoaf )

    local imglogorm = canvas:new("media/btn1off.png")
    local dx,dy = imglogorm:attrSize()
    canvas:compose(SCREEN_WIDTH-GRID-dx, GRID/2, imglogorm )

    local btnarrowv = canvas:new("media/btnarrowv.png")
    local btnarrowh = canvas:new("media/btnarrowh.png")
    local btnexit = canvas:new("media/btnsair.png")
    canvas:compose(SCREEN_WIDTH-GRID*4, GRID*1.5, btnarrowh)
    canvas:compose(SCREEN_WIDTH-GRID*2, GRID*1.5, btnexit)

    -- top menu
    canvas:attrFont("Tiresias", 14,"bold")

    -- main menu: knobs and titles
    for i=1, #self.meta do
      self:knobcvs(i)
      if i == self.page then
        canvas:attrColor("white")
        canvas:compose(GRID*5*i+GRID*2.25, GRID*2.25, btnarrowv)
      else
        canvas:attrColor("black")
      end
      local dx,dy = canvas:measureText(self.meta[i].menu)
      canvas:drawText(GRID*5*i+GRID-dx/2,GRID*2.4, self.meta[i].menu)
    end

    self:sector1()
    self:sector2()
    self:sector3()
    self:sector4()

  elseif(page) then

    local sector
    if (page ==1)  then
      self:sector1()
    elseif (page==2) then
      self:sector2()
    elseif (page==3) then
      self:sector3()
    elseif (page==4) then
      self:sector4()
    end

    self:knobcvs(page)
  end
  canvas:flush()
end

function altofalante:knobcvs(component)
  local offsetx=GRID*5*component
  local offsety=GRID/2
  local div = self.meta[component][3] +1
  local pi = 22/7
  local size = GRID*2
  local alpha	= pi * 2 / self.meta[component][2]

  -- knob degress
  canvas:attrColor("white")

  for i=1,self.meta[component][2] do
    local theta = alpha * (i  + self.meta[component][3])
    local px = math.cos( theta ) * size*0.6 + size/2
    local py = math.sin( theta ) * size*0.6 + size/2
    canvas:drawLine(offsetx+size/2,offsety+size/2, offsetx+px,offsety+py)
  end

  local imgknob = canvas:new("media/altofalante/knob1.png")
  canvas:compose(offsetx,offsety, imgknob )


  -- knob position
  local theta = alpha * (self.meta[component][1]  + self.meta[component][3])
  local px = math.cos( theta ) * size*0.4 + size/2
  local py = math.sin( theta ) * size*0.4 + size/2
  --print("px,py" , px, py)


  --  canvas:attrColor(self.meta[component].color2)
  canvas:attrColor("black")

  --canvas:attrLineWidth(5) -- bug in all tvs
  canvas:drawLine(offsetx+size/2,offsety+size/2, offsetx+px,offsety+py)

  canvas:attrFont("Tiresias", 16,"bold")
  canvas:attrColor("black")
  canvas:drawText(offsetx+size/2,offsety+size/2, self.meta[component][1])
end

function altofalante:switchcvs(pos, div, color1, color2)
  local size = GRID*4
  local mult = GRID/2

  -- fundo
  canvas:attrColor(color1)
  canvas:clear()
  --cvs:drawRect ('fill', 10, 10, size/mult,size/div)

  canvas:attrColor(color2)
  canvas:drawRect ('fill', 10, size/div*(pos-1), size-20, size/div)

  canvas:attrFont("Tiresias", 16,"bold")
  canvas:attrColor("white")
  canvas:drawText(size/2,size/2, pos)
end

function altofalante:sector1()
  local sizex = GRID*20
  local sizey = GRID*10
  local offsetx = 0
  local offsety = GRID*3

  canvas:attrColor(self.meta[1].color1)
  canvas:drawRect('fill',offsetx,offsety,sizex,sizey)

  local imgil = canvas:new("media/altofalante/il2.png")
  local dx,dy = imgil:attrSize()
  canvas:compose(GRID/2, GRID*3.5, imgil )


  canvas:attrColor(self.meta[1].color2)
  canvas:drawText(offsetx+GRID,offsety+GRID,self.meta[1][1])
end

function altofalante:sector2()
  local sizex = GRID*25
  local sizey = GRID*2
  local offsetx = 0
  local offsety = GRID*16

  canvas:attrColor(self.meta[2].color1)
  canvas:drawRect('fill',offsetx,offsety,sizex,sizey)

  canvas:attrFont("Tiresias", 18,"bold")
  canvas:attrColor(self.meta[2].color2)
  canvas:drawText(offsetx+GRID,offsety+GRID,self.meta[2][1] .. "/" .. #self.listalbuns .. " : " ..  self.listalbuns[self.meta[2][1]]["album"])

  self:timer()
end


function altofalante:sector3()
  local sizex = GRID*11
  local sizey = GRID*6
  local offsetx = GRID*25
  local offsety = GRID*3

  canvas:attrColor(self.meta[3].color1)
  canvas:drawRect('fill',offsetx,offsety,sizex,sizey)

  canvas:attrColor(self.meta[3].color2)
  canvas:attrFont("Tiresias", 14,"bold")
  canvas:drawText(offsetx+GRID,offsety+GRID,self.meta[4][1])
end

function altofalante:sector4()
  local sizex = GRID*13
  local sizey = GRID*11
  local offsetx = GRID*25
  local offsety = GRID*9

  canvas:attrColor(self.meta[4].color1)
  canvas:drawRect('fill',offsetx,offsety,sizex,sizey)
  canvas:attrColor(self.meta[4].color2)
  canvas:attrFont("Tiresias", 12,"normal")
  canvas:drawText(offsetx+GRID/2,offsety+GRID/2, self.meta[4][1] .. " " .. self.listalbuns[self.meta[4][1]]["banda"]  )
  canvas:drawText(offsetx+GRID/2,offsety+GRID*1.5, self.listalbuns[self.meta[4][1]]["album"] )

  local index = string.format("%02d" , self.meta[4][1] )
  local imgalbum = canvas:new("media/altofalante/albuns/" .. index  .. ".png")
  canvas:compose(offsetx+GRID/2,offsety+GRID*2.5,imgalbum )

end


function autoForward()
  af.meta[2][1]=shift(af.meta[2][1],1,af.meta[2][2])
  af:sector2()
  af:knobcvs(2)
  canvas:flush()
end

function altofalante:timer()
  local timeout = 5000

  if cancelTimerFunc then
    cancelTimerFunc()
  end
  cancelTimerFunc = event.timer(timeout, autoForward)
end
