--- Harmonia object

harmoniaMenu = {}

function harmoniaMenu:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.pos = 1
  self.spos = 1

  self.icons=4
  self.debug=false
  self.bar={}
  self.bar.stop=false
  self.repertorioItens=4
  self.menu ={{desc="Edição da semana",width=150},{desc="Repertório",width=160}, {desc="Villa Lobos",width=150}, {desc="Contatos",width=180}}
  --remove
  self.list=layoutPgmHarmoniaRep(ReadTable("tbl_harmoniarep.txt"))
  print("debug", #self.list)
  self.listextra=layoutPgmHarmoniaExtra(ReadTable("tbl_harmoniaextra.txt"))
  self.especiallist = textWrap (self.listextra[2]["especial"], 90)
  self.especiallines = 7
  self.especialpages = math.ceil(#self.especiallist/self.especiallines)
  self.especialpos =1
  self.episodiolist = textWrap (self.listextra[2]["episodio"], 82)
  self.episodiolines = 6
  self.episodiopages = math.ceil(#self.episodiolist/self.episodiolines)
  self.episodiopos =1
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
  elseif (self.pos ==1 and self.episodiopages > 1) then
    if ( evt.key == "CURSOR_LEFT" ) then
      self.episodiopos=shift(self.episodiopos,-1, self.episodiopages)
      self:episodio()
    elseif (  evt.key == "CURSOR_RIGHT" ) then
      self.episodiopos=shift(self.episodiopos,1, self.episodiopages)
      self:episodio()
    end
  elseif ( self.pos==2 ) then
    if ( evt.key == "CURSOR_LEFT" ) then
      self.spos=shift(self.spos,-1, #self.list)
      self:repertorio()
    elseif (  evt.key == "CURSOR_RIGHT" ) then
      self.spos=shift(self.spos,1, #self.list)
      self:repertorio()
    end
  elseif ( self.pos==3 and self.especialpages >1 ) then
    if ( evt.key == "CURSOR_LEFT" ) then
      self.especialpos=shift(self.especialpos,-1, self.especialpages)
      self:iconDraw()
    elseif (  evt.key == "CURSOR_RIGHT" ) then
      self.especialpos=shift(self.especialpos,1, self.especialpages)
      self:iconDraw()
    end
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

  canvas:attrColor(93,196,179,217)
  canvas:clear(0,GRID*11, GRID*32, GRID*18 )
  canvas:attrFont("Tiresias", 21,"bold")

  for i=1,#self.menu  do
    -- icon on
    if i==self.pos then
      self.bar.y = ((GRID*11.34)+((GRID*i)))
      self.bar.width = self.menu[i].width
      self.bar.desc = self.menu[i].desc

      local imgicon = canvas:new("media/harmonia/icon.png")
      canvas:compose(0, GRID*10.15+(GRID*i)*1.2, imgicon)

      local btni = canvas:new("media/harmonia/btn" .. i .. "on.png")
      canvas:compose(GRID, GRID*10.4+(GRID*i)*1.2, btni)
--      barHorizontal()
    else
      canvas:attrColor(1,1,1,160)
      local btni = canvas:new("media/harmonia/btn" .. i .. "off.png")
      canvas:compose(GRID, GRID*10.4+(GRID*i)*1.2, btni)
    end
  end

  local imgbgdleft = canvas:new("media/harmonia/bgd00.png")
  canvas:compose(0, GRID*11, imgbgdleft )

  -- Draw nav buttons
  local btnarrowv = canvas:new("media/btnarrowv.png")
  local btnexit = canvas:new("media/btnsair.png")
  canvas:compose(GRID*1, GRID*17, btnarrowv)
  canvas:compose(GRID*4, GRID*17, btnexit)

  self:menuItem()
  --canvas:flush()
end

-- sub menu episodio (programa) da semana
function harmoniaMenu:episodio()
  canvas:attrColor(93,196,179,217)
  canvas:clear(GRID*6,GRID*11, GRID*32, GRID*18 )

  local imgbgdr = canvas:new("media/harmonia/bgd0" .. math.random(4) .. ".png")
  canvas:compose(GRID*6, GRID*11, imgbgdr)

  canvas:attrColor(1,1,1,160)
  canvas:attrFont("Tiresias", 22,"bold")
  canvas:drawText(GRID*6,GRID*11.5,self.listextra[1]["episodio"])

  canvas:attrFont("Tiresias", 17,"normal")
  local m = (self.episodiopos-1)*self.episodiolines
  for  i = m+1, m+self.episodiolines   do
    if not self.episodiolist[i] then
      self.episodiolist[i] = " "
    end
    canvas:drawText(GRID*6,GRID*12.5+(GRID*0.65*(i-m-1)),self.episodiolist[i])
  end

  local img = canvas:new("media/harmonia/asemana" .. self.episodiopos .. ".png")
  local dx,dy = img:attrSize()
  canvas:compose(SCREEN_WIDTH-dx-GRID,SCREEN_HEIGHT-GRID/2-dy, img)


-- switch pages a semana
  for i=1, self.episodiopages do
    if (i == self.episodiopos) then
      -- canvas:attrColor(1,1,1,160)
      local imgb3 = canvas:new("media/harmonia/b1.png")
      canvas:compose(SCREEN_WIDTH-GRID-(GRID/2.5*self.episodiopages)+GRID/2*(i-1),SCREEN_HEIGHT-GRID*6.45,imgb3)
    else
      local imgb4 = canvas:new("media/harmonia/b2.png")
      canvas:compose(SCREEN_WIDTH-GRID-(GRID/2.5*self.episodiopages)+GRID/2*(i-1),SCREEN_HEIGHT-GRID*6.45,imgb4)
 
    end
   end
 --[[ canvas:attrFont("Tiresias", 14,"normal")
  canvas:attrColor("white")
  canvas:drawText(SCREEN_WIDTH-GRID*2,GRID*11.5+dy+GRID/4, "(" .. self.episodiopos .. "/" .. self.episodiopages .. ")")
 --]]

  if (self.episodiopos == 1) then
    local imglermais = canvas:new("media/harmonia/lermais.png")
    canvas:compose(GRID*6, GRID*17.25, imglermais)
  elseif (self.episodiopos == 2) then
    local imgvoltar = canvas:new("media/harmonia/voltar.png")
    canvas:compose(GRID*6, GRID*17.25, imgvoltar)
  end

  canvas:flush()
end


-- sub menu repertorio draw carrossel
function harmoniaMenu:repertorio()
--  canvas:attrColor(0,0,0,0)
  --  canvas:clear(0,0, GRID*32, GRID*11 )
  local offset_x = GRID*6.5
  local offset_y = GRID*11.5
  canvas:attrColor(93,196,179,217)
  canvas:clear(GRID*6,GRID*11, GRID*32, GRID*18 )

  local imgbgdr = canvas:new("media/harmonia/bgd0" .. math.random(4) .. ".png")

  local imgiconpath = string.format("%02d",self.list[self.spos]["img"])


  local imgicon = canvas:new("media/harmonia/" .. imgiconpath .. ".png" )
  local dx,dy = imgicon:attrSize()

  canvas:compose(GRID*6, GRID*11, imgbgdr)
  canvas:compose(GRID*6, GRID*11.5, imgicon )

  --lines
  canvas:attrColor(255,255,255,255)
  canvas:drawLine(offset_x+dx, offset_y+GRID/2+5, SCREEN_WIDTH-GRID, offset_y+GRID/2+5  )

  --texts
  canvas:attrFont("Tiresias", 21,"bold")
  canvas:attrColor(1,1,1,160 )
  canvas:drawText((offset_x+dx),offset_y, self.list[self.spos]["evento"] )
  canvas:attrFont("Tiresias", 17,"bold")
  canvas:attrColor(1,1,1,160 )
  canvas:drawText((offset_x+dx),(offset_y+(GRID)), self.list[self.spos]["regente"])
  canvas:drawText((offset_x+dx),(offset_y+(GRID*2)), self.list[self.spos]["local"])
  canvas:drawText((offset_x+dx),offset_y+(GRID*3), "Data: " .. self.list[self.spos]["data"])
  canvas:drawText((offset_x+dx),(offset_y+(GRID*4)),self.list[self.spos]["horario"])

  if (self.list["ingresso"] ~= " " or self.list["ingresso"] ~= "FALSE" or not self.list["ingresso"]) then
    canvas:drawText((offset_x+dx*2),(offset_y+(GRID*4)),"Valor: " .. self.list[self.spos]["ingresso"])
  end
  --obras, lines of text
  local list =textWrap(self.list[self.spos]["programa"],70)
  for i=1,#list do
    canvas:drawText((offset_x+dx),(offset_y+GRID*5+((i-1)*(GRID/2))) , list[i])
  end

  -- switch pages harmonia

  for i=1, #self.list do
    if (i == self.spos) then
      -- canvas:attrColor(1,1,1,160)
      local imgb1 = canvas:new("media/harmonia/b1.png")
      canvas:compose((SCREEN_WIDTH-(GRID+13.5*#self.list)-GRID)+(GRID/2)*i-1,(offset_y+dy-GRID*5.95),imgb1)
    else
      local imgb2 = canvas:new("media/harmonia/b2.png")
      canvas:compose((SCREEN_WIDTH-(GRID+13.5*#self.list)-GRID)+(GRID/2)*i-1,(offset_y+dy-GRID*5.95),imgb2)
      -- canvas:attrColor("white")
    end
    -- canvas:drawEllipse("fill",(SCREEN_WIDTH-(GRID/2*#self.list)-GRID)+(GRID/2)*i-1,(offset_y+dy-GRID*6.1),8,8)
    -- canvas:flush()
  end

  local imgqr = canvas:new("media/harmonia/qr" .. imgiconpath .. ".png")
  dx,dy = imgqr:attrSize()
  canvas:compose(SCREEN_WIDTH-GRID-dx, SCREEN_HEIGHT-GRID-dy, imgqr)

  canvas:flush()
end

-- sub menu especial do mês
function harmoniaMenu:especial()
  canvas:attrColor(93,196,179,217)
  canvas:clear(GRID*6,GRID*11, GRID*32, GRID*18 )

  local imgbgdr = canvas:new("media/harmonia/bgd0" .. math.random(4) .. ".png")
  canvas:compose(GRID*6, GRID*11, imgbgdr)

  canvas:attrColor(1,1,1,160)

  canvas:attrFont("Tiresias", 22,"bold")

  --  canvas:drawText(GRID*6,GRID*11.5,  self.listextra[1]["especial"])
  canvas:drawText(GRID*6,GRID*11.5, "Villa Lobos")

  canvas:attrFont("Tiresias", 17,"normal")

  local m = (self.especialpos-1)*self.especiallines
  for  i = m+1, m+self.especiallines   do
    if not self.especiallist[i] then
      self.especiallist[i] = " "
    end
    canvas:drawText(GRID*6,GRID*12.5+(GRID*0.65*(i-m-1)),self.especiallist[i])
  end

  local img = canvas:new("media/harmonia/especialdomes" .. self.especialpos .. ".png")
  local dx,dy = img:attrSize()
  canvas:compose(SCREEN_WIDTH-dx-GRID, SCREEN_HEIGHT-GRID/2-dy, img)

  for i=1, self.especialpages do
    if (i == self.especialpos) then
      -- canvas:attrColor(1,1,1,160)
      local imgb5 = canvas:new("media/harmonia/b1.png")
      canvas:compose(SCREEN_WIDTH-GRID-(GRID/2.5*self.especialpages)+GRID/2*(i-1),SCREEN_HEIGHT-GRID*6.45,imgb5)
    else
      local imgb6 = canvas:new("media/harmonia/b2.png")
      canvas:compose(SCREEN_WIDTH-GRID-(GRID/2.5*self.especialpages)+GRID/2*(i-1),SCREEN_HEIGHT-GRID*6.45,imgb6)
       end
  end

--[[  canvas:attrFont("Tiresias", 14,"bold")
  canvas:attrColor("white")
  canvas:drawText(SCREEN_WIDTH-GRID*2,GRID*11.5+dy+GRID/4, "(" .. self.especialpos .. "/" .. self.especialpages .. ")")
--]]

  if (self.especialpos == 1) then
    local imglermais = canvas:new("media/harmonia/lermais.png")
    canvas:compose(GRID*6, GRID*17.25, imglermais)
  elseif (self.especialpos == 2) then
    local imgvoltar = canvas:new("media/harmonia/voltar.png")
    canvas:compose(GRID*6, GRID*17.25, imgvoltar)
  end

end

--- main menu treatment
function harmoniaMenu:menuItem(par)

  canvas:attrColor(93,196,179,217)
  canvas:clear(GRID*6,GRID*11, GRID*32, GRID*18 )

  -- programa da semana
  if (self.pos==1) then
    if (self.episodiopages>1) then
      local imgbtnarrowh = canvas:new("media/btnarrowh.png")
      canvas:compose(GRID*2.5, GRID*17, imgbtnarrowh)
    end
    self:episodio()
    -- repertorio - agenda semanal
  elseif (self.pos == 2) then
    local imgbtnarrowh = canvas:new("media/btnarrowh.png")
    canvas:compose(GRID*2.5, GRID*17, imgbtnarrowh)
    local imgbgdr = canvas:new("media/harmonia/bgd0" .. math.random(4) .. ".png")
    canvas:compose(GRID*6, GRID*11.5, imgbgdr)
    self:repertorio()
    -- especial do mes
  elseif (self.pos==3) then
    if (self.especialpages>1) then
      local imgbtnarrowh = canvas:new("media/btnarrowh.png")
      canvas:compose(GRID*2.5, GRID*17, imgbtnarrowh)
    end
    self:especial()
    -- contatos
  elseif (self.pos==4) then
    local imgbgdr = canvas:new("media/harmonia/bgd0" .. math.random(4) .. ".png")
    canvas:compose(GRID*6, GRID*11, imgbgdr)
    local img = canvas:new("media/harmonia/contatos.png")
    canvas:compose(GRID*6, GRID*11, img)
    if  par == 'red' then
      local img = canvas:new("media/harmonia/qrcontato01.png")
      local dx,dy = img:attrSize()
      canvas:attrColor(0,0,0,0)
      canvas:clear(SCREEN_WIDTH-GRID*5.5,SCREEN_HEIGHT-GRID*5.5, dx, dy )
      canvas:compose(SCREEN_WIDTH-GRID*5.5,SCREEN_HEIGHT-GRID*5.5, img)
    elseif  par == 'green' then
      local img = canvas:new("media/harmonia/qrcontato02.png")
      local dx,dy = img:attrSize()
      canvas:attrColor(0,0,0,0)
      canvas:clear(SCREEN_WIDTH-GRID*5.5,SCREEN_HEIGHT-GRID*5.5, dx, dy )
      canvas:compose(SCREEN_WIDTH-GRID*5.5,SCREEN_HEIGHT-GRID*5.5, img)
    elseif  par == 'yellow' then
      local img = canvas:new("media/harmonia/qrcontato03.png")
      local dx,dy = img:attrSize()
      canvas:attrColor(0,0,0,0)
      canvas:clear(SCREEN_WIDTH-GRID*5.5,SCREEN_HEIGHT-GRID*5.5, dx, dy )
      canvas:compose(SCREEN_WIDTH-GRID*5.5,SCREEN_HEIGHT-GRID*5.5, img)
    elseif  par == 'blue' then
      local img = canvas:new("media/harmonia/qrcontato04.png")
      local dx,dy = img:attrSize()
      canvas:attrColor(0,0,0,0)
      canvas:clear(SCREEN_WIDTH-GRID*5.5,SCREEN_HEIGHT-GRID*5.5, dx, dy )
      canvas:compose(SCREEN_WIDTH-GRID*5.5,SCREEN_HEIGHT-GRID*5.5, img)
    end
  end
  canvas:flush()
end

function barHorizontalAnim()
  local mult = 10
  for i=1,(harmonia.bar.width/mult) do
    if (PGMON and not harmonia.bar.stop) then
      canvas:attrColor(255,255,255,255)
      canvas:clear(GRID/2-3,harmonia.bar.y,((i)*mult),1)
      canvas:flush()
      coroutine.yield(i) -- sleep...
    end
  end
end

function barHorizontalUpdate()
--  print (coroutine.status(barHorizontalCoroutine))
  coroutine.resume(barHorizontalCoroutine)
  if   coroutine.status(barHorizontalCoroutine) ~= 'dead'  then
    event.timer(30,barHorizontalUpdate)
  end
end

function barHorizontal()
  harmonia.bar.stop=false
  barHorizontalCoroutine=coroutine.create(barHorizontalAnim)
  barHorizontalUpdate()
end
;
