--- altofalante object

altofalante = {}

function altofalante:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self

  self.posh = 1
  self.page = 1
  self.bgdcolor = {255,102,0,200}

  self.listalbuns = layoutPgmAltofalanteAlbuns(ReadTable("tbl_af_albuns.txt"))
  self.listnews = layoutPgmAltofalanteNews(ReadTable("tbl_af_news.txt"))

  ---   [1], pos,[2] pages, [3]offset, [4]x, [5]y

  --    {1,2,0,GRID*12.5,GRID,"switch",color1={0,0,200,200}, color2={200,200,200,255}, menu="auto"},
  self.meta = {
    {2,8,2,GRID*7,GRID,"knob",color1={30,20,30,200}, color2={0,0,0,255}, menu="Programas"},
    {1,#self.listnews,2,GRID*11,GRID,"knob",color1={0,200,200,200}, color2={0,0,0,255}, menu="Noticias"},
    {3,7,1.5,GRID*15,GRID,"knob",color1={200,100,100,200}, color2={0,0,0,255}, menu="Discos"},
    {1,#self.listalbuns,5,GRID*19,GRID,"knob",color1={200,200,0,200}, color2={0,0,0,255}, menu="Contatos"}
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

    local imggarimpo = canvas:new("media/altofalante/garimpo.png")
    canvas:compose(GRID*27.25,GRID*3.50, imggarimpo )

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
    self:news()
    self:sector3()
    self:discos()

  elseif(page) then

    local sector
    if (page ==1)  then
      self:sector1()
    elseif (page==2) then
      self:news()
    elseif (page==3) then
      self:sector3()
    elseif (page==4) then
      self:discos()
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
  local size = GRID*1.5
  local alpha	= pi * 2 / self.meta[component][2]
  local btnarrowv = canvas:new("media/altofalante/btnarrowv.png")

  local imgplot = canvas:new("media/altofalante/plot.png")
--  imgcabecote:attrCrop(GRID*10,0,GRID*2.25,GRID*4)
  canvas:compose(offsetx,0, imgplot )

  -- knob degress
--  canvas:attrColor("red")
  for i=1, self.page do
    if i == component then
      -- canvas:attrColor(238,118,0,255)
      canvas:attrColor("white")
    else
      -- canvas:attrColor(54,54,54,255)
      canvas:attrColor("black")
    end
  end
 
  for i=1,self.meta[component][2] do
    local theta = alpha * (i  + self.meta[component][3])
    local px = math.cos( theta ) * size*0.6 + size/2
    local py = math.sin( theta ) * size*0.6 + size/2
    canvas:drawLine(offsetx+size/2,offsety+size/2, offsetx+px,offsety+py)
  end

  -- is active?
  local imgbtn
  if component == self.page then
     imgbtn = canvas:new("media/altofalante/btn" .. component .. "on.png")
  else
     imgbtn = canvas:new("media/altofalante/btn" .. component .. "off.png")
  end
  local dx,dy = imgbtn:attrSize()
  canvas:compose(  offsetx+30-dx/2, offsety+GRID*2-4, imgbtn)

  --canvas:drawText(offsetx+size/2-dx/2,offsety+GRID*1.75, self.meta[component].menu)


  -- knob image
  local imgknob = canvas:new("media/altofalante/knob.png")
  canvas:compose(offsetx,offsety, imgknob )

  -- knob position
  local theta = alpha * (self.meta[component][1]  + self.meta[component][3])
  local px = math.cos( theta ) * size*0.4 + size/2
  local py = math.sin( theta ) * size*0.4 + size/2
  canvas:attrColor(unpack(self.meta[component].color2))

  --canvas:attrLineWidth(5) -- bug in all tvs
  canvas:drawLine(offsetx+size/2,offsety+size/2, offsetx+px,offsety+py)

--  canvas:attrFont("Tiresias", 16,"bold")
--  canvas:attrColor("black")
--  canvas:drawText(offsetx+dx/2,offsety+size/2, self.meta[component][1])
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
    local btnarrowv = canvas:new("media/altofalante/btnarrowv.png")
    canvas:compose(offsetx+GRID, offsety+GRID/5, btnarrowv)
    canvas:attrColor("white")
  else
    canvas:attrColor(unpack(self.bgdcolor))
  end
  canvas:clear(offsetx-GRID/6,offsety-GRID/6,sizex+GRID/3,sizey*mult+GRID/3)

  canvas:attrColor(unpack(self.meta[component].color1))
  canvas:clear(offsetx,offsety,sizex,sizey*mult)

  canvas:attrColor(unpack(self.meta[component].color2))
  canvas:drawRect ('fill', offsetx, offsety+(sizey*(pos-1)), sizex,sizex,sizey)

  if (component == 3) then
--    self:timer()
  end
  --canvas:attrFont("Tiresias", 16,"bold")
  --canvas:attrColor("white")
  --canvas:drawText(offsetx+GRID,offsety, pos)
end

function altofalante:clear(offsetx,offsety,sizex,sizey,color1,color2)
  canvas:attrColor("black")
  canvas:clear(offsetx,offsety,sizex,sizey)

  canvas:attrColor(unpack(color1))
  canvas:drawRect('fill',offsetx,offsety,sizex,sizey)

--  local imgpattern = canvas:new("media/altofalante/pattern.png")
--  local dx,dy = imgpattern:attrSize()

--  for i = 0, math.floor(sizex/dx)-1 do
    --canvas:compose(offsetx+dx*i, offsety, imgpattern)
    --for j = 0, math.floor(sizey/dx)-1 do
--      canvas:compose(offsetx+dx*i, offsety+dy*j, imgpattern)
    --end
  --end
end

function altofalante:sector1()
  local sizex = GRID*18.5
  local sizey = GRID*10.75
  local offsetx = GRID*0.75
  local offsety = GRID*3.5

  self:clear(offsetx,offsety,sizex,sizey, self.meta[1].color1, self.meta[1].color2)

  local imgil = canvas:new("media/altofalante/il2.png")
  local dx,dy = imgil:attrSize()
  canvas:compose(GRID, GRID*4, imgil )

  canvas:attrColor(unpack(self.meta[1].color2))
  canvas:drawText(offsetx+GRID,offsety+GRID,self.meta[1][1])
end

function altofalante:news()
  local sizex = GRID*18.5
  local sizey = GRID*3
  local offsetx = GRID*0.75
  local offsety = GRID*14.25

  self:clear(offsetx,offsety,sizex,sizey, self.meta[2].color1, self.meta[2].color2)

  canvas:attrFont("Tiresias", 14,"bold")
  canvas:attrColor(unpack(self.meta[2].color2))
  canvas:drawText(offsetx+GRID,offsety,self.meta[2][1] .. "/" .. #self.listnews .. " : " ..  self.listnews[self.meta[2][1]]["nome"])
  canvas:attrFont("Tiresias", 12,"normal")

  local text = textWrap (self.listnews[self.meta[2][1]]["desc"], 150)

  for i = 1, #text do
    canvas:drawText(offsetx+GRID,offsety+GRID/2*i,text[i])
  end

  local imgcornerll = canvas:new("media/altofalante/cornerll.png")
  local dx,dy = imgcornerll:attrSize()
  canvas:compose(0, SCREEN_HEIGHT-dy, imgcornerll)

  --  self:timer()

end


function altofalante:sector3()
  local sizex = GRID*8
  local sizey = GRID*3
  local offsetx = GRID*19.25
  local offsety = GRID*3.5

  self:clear(offsetx,offsety,sizex,sizey, self.meta[2].color1, self.meta[2].color2)

  canvas:attrColor(unpack(self.meta[3].color2))
  canvas:attrFont("Tiresias", 14,"bold")
  canvas:drawText(offsetx+GRID,offsety+GRID,self.meta[4][1])
end

function altofalante:discos()
  local sizex = GRID*8
  local sizey = GRID*10.75
  local offsetx = GRID*19.25
  local offsety = GRID*6.5

  self:clear(offsetx,offsety,sizex,sizey, self.meta[4].color1, self.meta[4].color2)

  canvas:attrColor(unpack(self.meta[4].color2))
  canvas:attrFont("Tiresias", 14,"normal")
  canvas:drawText(offsetx+GRID/2,offsety+GRID/3, self.meta[4][1] .. " " .. self.listalbuns[self.meta[4][1]]["banda"]  )
  canvas:drawText(offsetx+GRID/2,offsety+GRID, self.listalbuns[self.meta[4][1]]["album"] )

  local index = string.format("%02d" , self.meta[4][1] )
  local imgalbum = canvas:new("media/altofalante/albuns/" .. index  .. ".png")
  canvas:compose(offsetx+GRID/2,offsety+GRID*3,imgalbum )

  local imgcornerlr = canvas:new("media/altofalante/cornerlr.png")
  local dx,dy = imgcornerlr:attrSize()
  canvas:compose(SCREEN_WIDTH-dx, SCREEN_HEIGHT-dy, imgcornerlr)
end


function afautoForward()
  if af.meta[3][1] == 1 and PGMON then
    af.meta[2][1]=shift(af.meta[2][1],1,af.meta[2][2])

    af:news()
    af:knobcvs(2)
    canvas:flush()
  end
end

function altofalante:timer()
  local timeout = 1000
  if self.meta[3][1] == 1 and PGMON then
    if cancelTimerFunc then
      cancelTimerFunc()
    end
    cancelTimerFunc = event.timer(timeout, afautoForward)
  end
end
