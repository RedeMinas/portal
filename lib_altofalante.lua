--- altofalante object

altofalante = {}

function altofalante:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.posv = 1
  self.posh = 1
  self.page = 1
self.discpos = 1
  self.txtpos = 1
  self.pgmpos = 1
  -- Lines News 
  self.newslines = 6

  -- Lines Pgm
  self.pgmlines = 8
  -- lines disc
  self.disclines =13

  self.bgdcolor = {255,102,0,200}

  self.listalbuns = layoutPgmAltofalanteAlbuns(ReadTable("tbl_af_albuns.txt"))
  self.listnews = layoutPgmAltofalanteNews(ReadTable("tbl_af_news.txt"))
  self.listpgm = layoutPgmAltofalantePgms(ReadTable("tbl_af_pgms.txt"))

  ---   [1], pos,[2] pages, [3]offset, [4]x, [5]y
  -- switch example
  --  {1,2,0,GRID*12.5,GRID,"switch",color1={0,0,200,200}, color2={200,200,200,255}, menu="auto"},


  self.meta = {
    {1,#self.listpgm,2,GRID*8,GRID,"knob",color1={102,102,102,255}, color2={0,0,0,255},color3={169,169,169,200}, menu="Programas"},
    {1,#self.listnews,2,GRID*12 ,GRID,"knob",color1={168,168,168,255}, color2={0,0,0,255}, color3={169,169,169,200},menu="Noticias"},
    {1,#self.listalbuns,5,GRID*16,GRID,"knob",color1={1,50,50,200}, color2={0,0,0,200},color3={169,169,169,200}, menu="Discos"},
    {3,6,5,GRID*20,GRID,"knob",color1={75,75,75,100}, color2={0,0,0,200},color3={105,105,105,200}, menu="Contatos"}
  }

  self.pages=#self.meta

  return o
end

--deal with keys
function altofalante:input(evt)
  if ( evt.key == "CURSOR_LEFT" ) then
    self.page=shift(self.page,-1,self.pages)
    self:pageReset()

  elseif ( evt.key=="CURSOR_RIGHT") then    self.page=shift(self.page,1,self.pages)
    self:pageReset()

  elseif ( evt.key == "CURSOR_UP" ) then
    self.meta[self.page][1]=shift(self.meta[self.page][1],1,self.meta[self.page][2])
-- contatos
    if (self.page==4) then
      self.posv=shift(self.posv,-1,6)
      self:contatos()
    end
    self:pageReset(self.page)

  elseif ( evt.key=="CURSOR_DOWN") then
    self.meta[self.page][1]=shift(self.meta[self.page][1],-1,self.meta[self.page][2])
--contatos
    if (self.page==4) then
      self.posv=shift(self.posv,1,6)
      self:contatos()
    end
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
    -- img cabecote
    local imgcabecote = canvas:new("media/altofalante/cabecote.png")
    canvas:compose(0,0, imgcabecote )
    -- img garimpo
    local imggarimpo = canvas:new("media/altofalante/garimpo.png")
    canvas:compose(GRID*27.25,GRID*3.5, imggarimpo )
    -- img display
    local imgdisplay = canvas:new("media/altofalante/display.png")
    canvas:compose(GRID*26.23, GRID, imgdisplay)
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

    self:pgm()
    self:news()
    self:discos()
    self:contatos()
  elseif(page) then

    local sector
    if (page ==1)  then
      self:pgm()
    elseif (page==2) then
      self:news()
    elseif (page==3) then
      self:discos()
    elseif (page==4) then
      self:contatos()
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
--[[
  
  -- btn arrow image
  if component == self.page then
    local btnarrowh = canvas:new("media/altofalante/btnarrowv.png")
    canvas:compose(offsetx+95,offsety+GRID*1.7, btnarrowh)
  end
--]] 
  local imgplot = canvas:new("media/altofalante/plot.png")
--imgcabecote:attrCrop(GRID*10,0,GRID*2.25,GRID*4)
  canvas:compose(offsetx-GRID-3,offsety-GRID+30, imgplot )

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
--[[
local imgbtn
  if component == self.page then
    imgbtn = canvas:new("media/altofalante/btn" .. component .. "on.png")
    local dx,dy = imgbtn:attrSize()
    canvas:compose(offsetx+27-dx/2, offsety+GRID*1.9,imgbtn)
  end
--]]



  -- is active?
  local imgbtn
 -- local btnarrowv
  if component == self.page then
  imgbtn = canvas:new("media/altofalante/btn" .. component .. "on.png")
  btnarrowv = canvas:new("media/altofalante/btnarrowv.png")
  local dx,dy = imgbtn:attrSize()
  canvas:compose(offsetx+27-dx/2, offsety+GRID*1.9,imgbtn)
  --  canvas:compose(offsetx+37+dx/2, offsety+GRID*1.7,btnarrowv)
  else
  imgbtn = canvas:new("media/altofalante/btn" .. component .. "off.png")
  local dx,dy = imgbtn:attrSize()
  canvas:compose(offsetx+27-dx/2, offsety+GRID*2-5,imgbtn)
  end

  --canvas:drawText(offsetx+size/2-dx/2,offsety+GRID*1.75, self.meta[component].menu)


    -- knob image
  local imgknob = canvas:new("media/altofalante/knob.png")
  canvas:compose(offsetx,offsety+5, imgknob )
  -- knob position

  local theta = alpha * (self.meta[component][1]  + self.meta[component][3])
  local px = math.cos( theta ) * size*0.4 + size/2
  local py = math.sin( theta ) * size*0.4 + size/2
  canvas:attrColor("black")
  --canvas:attrColor(unpack(self.meta[component].color2))
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
--[[  if component == self.page then
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
--]]

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

  local imgdisplay = canvas:new("media/altofalante/display.png")
  canvas:compose(GRID*26.23, GRID, imgdisplay)--end
end

function altofalante:pgm()
  local sizex = GRID*16
  local sizey = GRID*8.75
  local offsetx = GRID*0.75
  local offsety = GRID*3.5

 self:clear(offsetx,offsety,sizex,sizey, self.meta[1].color1, self.meta[1].color2)

 local index = string.format("%02d" , self.meta[1][1] )
 local imgpgms = canvas:new("media/altofalante/programas/" .. index  .. ".png")
 canvas:compose(GRID*1.25, GRID*4, imgpgms )

 --line programa

 local imgpgm
  if self.page == 1  then
    imgpgm = canvas:new("media/altofalante/l1.png")
    canvas:compose(GRID-9.8, GRID*3.5, imgpgm)
  end

   --count programas
   canvas:attrFont("Tiresias", 16,"bold")
   canvas:attrColor("black")
   canvas:drawText(offsetx*35.5,offsety/2.5,self.meta[1][1].."/"..#self.listpgm)

   canvas:attrFont("Tiresias",14,"bold")
   canvas:attrColor("black")
   -- count lines pgm
  self.textPgm = textWrap (self.listpgm[self.meta[1][1]]["desc"], 87) 
  local m = (self.pgmpos-1)*self.pgmlines
  for i = m+1, m+self.pgmlines do
    if
    not self.textPgm[i] then
      self.textPgm[i]= " "
    end
    canvas:drawText(offsetx*2,offsety+(GRID*4)+GRID*0.5*(i-m-0.5),self.textPgm[i])
  end
  
 --[[ if  self.txtpos == 2 then
    canvas:drawText(offsetx*2,offsety+(GRID/4*i)+GRID/4*(i+2),self.textPgm[i])
  end
 --]]
  
  --[[
  local list=textWrap(self.textPgm,offsety/14)
  local ll = 1
  local llist = {}

  for regexp in text:gmatch("[^\\]+") do
    local list=textWrap(regexp,106)
    for i=1,#list do
      if i ~= 1 then
        ll = ll +1
      end
      llist[ll]=list[i]
    end
  end
  ]] --

  -- show pgms description
 
  -- local text = textWrap (self.listpgm[self.meta[1][1]]["desc"], 150)
--[[
  for i = 1, #text do
    canvas:drawText(offsetx*2,offsety+GRID*4+(GRID*0.5*i)+GRID/2,text[i])
    print (text[i])
  end
--]]

  canvas:attrColor(unpack(self.meta[1].color2))
-- cout img programas
  --canvas:drawText(offsetx+GRID,offsety+GRID,self.meta[1][1])
end

function altofalante:news()
  local sizex = GRID*16
  local sizey = GRID*5
  local offsetx = GRID*0.75
  local offsety = GRID*12.25

  self:clear(offsetx,offsety,sizex,sizey, self.meta[2].color3, self.meta[2].color1)
  canvas:attrFont("Tiresias", 14,"bold")
  canvas:attrColor(unpack(self.meta[2].color2))
  --count noticias
  canvas:attrFont("Tiresias", 16,"bold")
  canvas:attrColor("black")
  canvas:drawText(offsetx*35.5,offsety/9,self.meta[2][1] .. "/" .. #self.listnews)
 -- count lines news
  self.textNews = textWrap (self.listnews[self.meta[2][1]]["desc"],88)
  local m = (self.txtpos-1)*self.newslines
  for i = m+1, m+self.newslines do
    if
    not self.textNews[i] then
      self.textNews[i]= " "
    end
    canvas:drawText(offsetx*2,offsety+(GRID/4*i)+GRID/4*(i-m+3),self.textNews[i])
  end
  
-- desc noticias 
  canvas:attrFont("Tiresias", 16,"bold")
  canvas:attrColor("black")
  canvas:drawText(offsetx*2,offsety+15,self.listnews[self.meta[2][1]]["nome"])
  canvas:drawText(offsetx*18, offsety+15, self.listnews[self.meta[2][1]]["data"])
  --[[
  if  self.txtpos == 2 then
    canvas:drawText(offsetx*2,offsety+(GRID/4*i)+GRID/4*(i+2),self.text[i])
  end
  --]]


--[[
  for i = 1, #text do
    if (self.txtpos==1) then
      canvas:drawText(offsetx*2,offsety+(GRID*0.5*i)+GRID/2,text[i])
    end
--]]

 

  local imgcornerll = canvas:new("media/altofalante/cornerll.png")
  local dx,dy = imgcornerll:attrSize()
  canvas:compose(0, SCREEN_HEIGHT-dy, imgcornerll)
  -- line noticias
 
    local imgnews
    if self.page == 2  then
    imgnews = canvas:new("media/altofalante/l2.png")
    canvas:compose(GRID-2, GRID*3.49, imgnews)
    end
 

  --  self:timer()

end
function altofalante:discos()
  local sizex = GRID*10.5
  local sizey = GRID*10.75
  local offsetx = GRID*16.75
  local offsety = GRID*3.5
  self:clear(offsetx,offsety,sizex,sizey, self.meta[1].color1, self.meta[1].color2)
  canvas:attrColor("gray")
  canvas:drawRect("fill",offsetx+GRID*2, offsety,sizex*0.55, sizey*0.65)

  -- canvas:drawText(offsetx*36.5,offsety/2.5,self.meta[3][1].. "/" .. self.listalbuns[self.meta[3][1]]["album"])
--count discos
  canvas:attrColor("black")
  canvas:attrFont("Tiresias", 16,"bold")
  canvas:drawText(offsetx+GRID*10,offsety/2.5, self.meta[3][1] .. "/" .. #self.listalbuns )

  --canvas:attrColor(unpack(self.meta[4].color2))
  canvas:attrColor("black")
  canvas:attrFont("Tiresias", 18,"normal")
  canvas:drawText(offsetx+GRID*4,offsety/1.15+GRID/2, self.listalbuns[self.meta[3][1]]["banda"]  )
  canvas:drawText(offsetx+GRID*4,offsety/1.15+GRID, self.listalbuns[self.meta[3][1]]["album"] )
 
   self.textDisc = textWrap (self.listalbuns[self.meta[3][1]]["descricao"], 63)
  local m = (self.discpos-1)*self.disclines
  for i = m+1, m+self.disclines do
    if
    not self.textDisc[i] then
      self.textDisc[i]= " "
    end
   -- canvas:attrColor(unpack(self.meta[4].color3))
    canvas:attrColor("black")
    canvas:attrFont("Tiresias", 14,"normal")
    canvas:drawText(offsetx+GRID/3,offsety*3+(GRID/4*i)+GRID/4*(i-m-1),self.textDisc[i])
  end

  local index = string.format("%02d" , self.meta[3][1] )
  local imgalbum = canvas:new("media/altofalante/albuns/" .. index  .. ".png")
  canvas:compose(offsetx+GRID*2.4,offsety+GRID*1.6,imgalbum )
  local imgcornerlr = canvas:new("media/altofalante/cornerlr.png")
  local dx,dy = imgcornerlr:attrSize()
  canvas:compose(SCREEN_WIDTH-dx, SCREEN_HEIGHT-dy, imgcornerlr)

--line disco 
  
  local imgdisc
  if self.page == 3  then
    imgdisc = canvas:new("media/altofalante/l3.png")
    canvas:compose(GRID*16.97,GRID*3.5, imgdisc)
  end
  
  --self:pgm()
end

function altofalante:contatos()
  local sizex = GRID*10.5
  local sizey = GRID*3.05

  local offsetx = GRID*16.75
  local offsety = GRID*14.2


  self:clear(offsetx,offsety,sizex,sizey, self.meta[2].color1, self.meta[2].color2)

  canvas:attrColor(unpack(self.meta[3].color2))
  canvas:attrFont("Tiresias", 14,"bold")
  -- canvas:drawText(offsetx+GRID,offsety+GRID,self.meta[4][1])
--[[
  -- imagem contato
  local imgcontato = canvas:new("media/altofalante/cnt.png")
  local dx, dy = imgcontato:attrSize()
  canvas:compose(GRID*17.2, GRID*12.25, imgcontato)

  -- imagem cone/seta
  local imgset = canvas:new("media/altofalante/tagcnt.png")
  local dx, dy = imgset:attrSize()
  canvas:compose(GRID*17.2, GRID*11.25+(self.posv-1)*GRID, imgset )

  if self.posv ~= 1 then
    -- imagem qr
    local imgqr = canvas:new("media/altofalante/qr".. self. posv ..".png")
    local dx, dy = imgqr:attrSize()
    canvas:compose(GRID*22.25, GRID*10.75+GRID, imgqr )
  else
    -- imagem info
    local imginfo = canvas:new("media/altofalante/info.png")
    local dx, dy = imginfo:attrSize()
    canvas:compose(GRID*22.25, GRID*11.6, imginfo)
    canvas:flush()
  end
--]]

  -- line contato

 local imgcnt
  if self.page == 4
  then
    imgcnt = canvas:new("media/altofalante/l4.png")
    canvas:compose(GRID*16.98, GRID*3.5, imgcnt)
  end

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
