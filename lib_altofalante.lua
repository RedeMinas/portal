--- altofalante object

altofalante = {}

function altofalante:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self

  self.posh = 1


  self.page = 1

  self.pos = {}

  self.listalbuns = layoutPgmAltofalanteAlbuns(ReadTable("tbl_af_albuns.txt"))

  self.bgdcolor = {255,102,0,200}

  ---   [1], pos,[2] pages, [3]offset, [4]x, [5]y
  self.meta = {
    {2,8,2,GRID*5,GRID/2,"knob",color1="blue", color2="yellow", menu="Resumo"},
    {1,#self.listalbuns,2,GRID*10,GRID/2,"knob",color1="yellow", color2="blue", menu="News"},
    {1,2,0,GRID*12.5,GRID/2,"switch",color1="red", color2="white", menu="auto"},
    {3,7,1.5,GRID*15,GRID/2,"knob",color1="pink", color2="red", menu="contato"},
    {1,13,3,GRID*20,GRID/2,"knob",color1="brown", color2="white", menu="Garimpo"},
    {1,2,3,GRID*26,GRID/2,"switch",color1="brown", color2="white", menu="Liga"}
  }

  self.pages=#self.meta

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
  elseif ( evt.key=="RED") then
    print("red")
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

    local imgcabecote = canvas:new("media/altofalante/cabecote.png")
    canvas:compose(0,0, imgcabecote )

    -- top menu logo
    local imglogoaf = canvas:new("media/altofalante/logo.png")
    local dx,dy = imglogoaf:attrSize()
    canvas:compose(GRID/2, GRID/2, imglogoaf )

    local imglogorm = canvas:new("media/btn1off.png")
    local dx,dy = imglogorm:attrSize()
    canvas:compose(SCREEN_WIDTH-GRID-dx, GRID/2, imglogorm )


    local btnarrowh = canvas:new("media/btnarrowh.png")
    local btnexit = canvas:new("media/btnsair.png")
    canvas:compose(SCREEN_WIDTH-GRID*4, GRID*1.5, btnarrowh)
    canvas:compose(SCREEN_WIDTH-GRID*2, GRID*1.5, btnexit)

    -- top menu
    canvas:attrFont("Tiresias", 14,"bold")

    -- main menu: knobs and titles
    for i=1, self.pages do
      if self.meta[i][6] == "knob" then
        self:knobcvs(i)
      else
        self:switchcvs(i)
      end

    end

    self:sector1()
    self:sector2()
    self:sector3()
    self:garimpo()

  elseif(page) then

    local sector
    if (page ==1)  then
      self:sector1()
    elseif (page==2) then
      self:sector2()
    elseif (page==4) then
      self:sector3()
    elseif (page==5) then
      self:garimpo()
    end

    if self.meta[page][6] == "knob" then
      self:knobcvs(page)
    else
      self:switchcvs(page)
    end

  end
  canvas:flush()
end

function altofalante:knobcvs(component)
  local offsetx=self.meta[component][4]
  local offsety=self.meta[component][5]
  local div = self.meta[component][3] +1
  local pi = 22/7
  local size = GRID*2
  local alpha	= pi * 2 / self.meta[component][2]
  local btnarrowv = canvas:new("media/btnarrowv.png")

  local imgcabecote = canvas:new("media/altofalante/cabecote.png")
  imgcabecote:attrCrop(0,0,GRID*2.25,GRID*3)
  canvas:compose(offsetx,0, imgcabecote )


  -- knob degress
  canvas:attrColor("white")

  for i=1,self.meta[component][2] do
    local theta = alpha * (i  + self.meta[component][3])
    local px = math.cos( theta ) * size*0.55 + size/2
    local py = math.sin( theta ) * size*0.5 + size/2
    canvas:drawLine(offsetx+size/2,offsety+size/2, offsetx+px,offsety+py)
  end

  -- is active?
  if component == self.page then
    canvas:compose(offsetx+GRID*2, offsety+GRID, btnarrowv)
    canvas:attrColor("white")
  else
    canvas:attrColor("black")
  end

  -- menu text, color from above
  canvas:attrFont("Tiresias", 14,"normal")
  local dx,dy = canvas:measureText(self.meta[component].menu)
  print(dx)
  canvas:drawText(offsetx+size/2-dx/2,offsety+GRID*2, self.meta[component].menu)

  -- knob image
  local imgknob = canvas:new("media/altofalante/knob.png")
  canvas:compose(offsetx,offsety, imgknob )

  -- knob position
  local theta = alpha * (self.meta[component][1]  + self.meta[component][3])
  local px = math.cos( theta ) * size*0.4 + size/2
  local py = math.sin( theta ) * size*0.4 + size/2

  --canvas:attrColor(self.meta[component].color2)
  canvas:attrColor("black")

  --canvas:attrLineWidth(5) -- bug in all tvs
  canvas:drawLine(offsetx+size/2,offsety+size/2, offsetx+px,offsety+py)

  canvas:attrFont("Tiresias", 16,"bold")
  canvas:attrColor("black")
  canvas:drawText(offsetx+dx/2,offsety+size/2, self.meta[component][1])
end

function altofalante:switchcvs(component)
  local mult = self.meta[component][2]
  local sizex = GRID/2
  local sizey = GRID/2
  local offsetx = self.meta[component][4]
  local offsety = self.meta[component][5]
  local pos = self.meta[component][1]
  -- fundo

  if component == self.page then
    local btnarrowv = canvas:new("media/btnarrowv.png")
    canvas:compose(offsetx+GRID/2, offsety-GRID/2, btnarrowv)
    canvas:attrColor("white")
  else
    canvas:attrColor(unpack(self.bgdcolor))
  end
  canvas:clear(offsetx-GRID/6,offsety-GRID/6,sizex+GRID/3,sizey*mult+GRID/3)

  canvas:attrColor(self.meta[component].color1)
  canvas:clear(offsetx,offsety,sizex,sizey*mult)

  canvas:attrColor(self.meta[component].color2)
  canvas:drawRect ('fill', offsetx, offsety+(sizey*(pos-1)), sizex,sizex,sizey)

  --canvas:attrFont("Tiresias", 16,"bold")
  --canvas:attrColor("white")
  --canvas:drawText(offsetx+GRID,offsety, pos)
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

function altofalante:garimpo()
  local sizex = GRID*13
  local sizey = GRID*11
  local offsetx = GRID*25
  local offsety = GRID*9

  canvas:attrColor(self.meta[5].color1)
  canvas:drawRect('fill',offsetx,offsety,sizex,sizey)
  canvas:attrColor(self.meta[5].color2)
  canvas:attrFont("Tiresias", 12,"normal")
  canvas:drawText(offsetx+GRID/2,offsety+GRID/2, self.meta[5][1] .. " " .. self.listalbuns[self.meta[4][1]]["banda"]  )
  canvas:drawText(offsetx+GRID/2,offsety+GRID*1.5, self.listalbuns[self.meta[5][1]]["album"] )

  local index = string.format("%02d" , self.meta[5][1] )
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
  local timeout = 1000
  if self.meta[3][1] == 1 then
    if cancelTimerFunc then
      cancelTimerFunc()
    end
    cancelTimerFunc = event.timer(timeout, autoForward)
  end

end
