--- Main Menu object

MainMenu = {}

function MainMenu:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.pos = 1
  self.spos = 1
  self.icons = 5
  self.start = false
  self.pgmicons = math.floor(SCREEN_WIDTH/210)
  self.list=layoutPgmTable(ReadTable("tbl_pgm.txt"))
  self.debug=false
  self.settings=false
  return o
end

-- debugger
function settings()
  if (self.debug==true) then
    canvas:attrColor("red")
    canvas:drawRect("fill",SCREEN_WIDTH-(SCREEN_WIDTH/6),0,200,200)
    canvas:attrColor("white")
    canvas:attrFont("Vera", 12,"normal")
    canvas:drawText(pos_x,pos_y, SCREEN_WIDTH .. "x" .. SCREEN_HEIGHT .. "\n" .. self.pos)
  else
    canvas:attrColor(0,0,0,0)
    canvas:clear(GRID*16,GRID*5,200,200)
  end
  canvas:flush()
end

-- main menu icons vert scroll
function MainMenu:iconDraw()
  local iconpath=""
  local sumdy=0
  --conferir
  canvas:attrColor(0,0,0,0)
  canvas:clear(0,0, GRID*32, GRID*12)

  canvas:attrColor(1,1,1,200)
  canvas:clear(0,GRID*11, GRID*32, GRID*18 )
  --  canvas:attrColor("white")
  --  canvas:drawRect("fill", 0,GRID*12,GRID*32,GRID*18 )
  canvas:flush()
  --  for i=1,self.icons  do
  for i=1,self.icons  do
    if i==self.pos then
      iconpath = "media/btn" ..  tostring(i) .. "on.png"
    else
      iconpath = "media/btn" ..  tostring(i) .. "off.png"
    end
    local icon = canvas:new(iconpath)
    local dx,dy = icon:attrSize()
    canvas:compose(GRID, GRID*11.5+sumdy, icon )
    sumdy=sumdy+dy+GRID*0.3
  end

  local img = canvas:new("media/btnarrowv.png")
  canvas:compose(GRID, GRID*17, img)
  local imgexit = canvas:new("media/btnsair.png")
  canvas:compose(GRID*4, GRID*17, imgexit)
  canvas:flush()
end

-- main menu treatment
function MainMenu:menuItem(par)
  --canvas:attrColor(0,0,0,0)
  --canvas:clear(0,0, GRID*32, GRID*10 )
  -- a redeminas
  if self.pos==1 then
    local img = canvas:new("media/aredeminas.png")
    canvas:compose(GRID*6, GRID*11.5, img)
    -- programas
  elseif self.pos == 2 then
    local img = canvas:new("media/btnarrowh.png")
    canvas:compose(GRID*2.5, GRID*17, img)
    self:pgmDraw()
    -- Nova sede
  elseif self.pos==3 then
    local img = canvas:new("media/sede.png")
    canvas:compose(GRID*6, GRID*11.5, img)
  elseif self.pos==4 then
    local img = canvas:new("media/especial.png")
    canvas:compose(GRID*6, GRID*11.5, img)
  elseif self.pos==5 then
    canvas:attrColor(1,1,1,200)
    canvas:clear(GRID*6,GRID*11, GRID*32, GRID*18 )
    local img = canvas:new("media/contato.png")
    canvas:compose(GRID*6, GRID*11.5, img)
    -- results from tcp get
    canvas:attrColor("white")
    canvas:attrFont("Vera", 8,"bold")
    canvas:drawText(GRID*16, GRID*17.4, "v: " .. VERSION .. "/" .. tcpresult )
    if  par == 'red' then
      local img = canvas:new("media/qrfb.png")
      local dx,dy = img:attrSize()
      canvas:attrColor(0,0,0,0)
      canvas:clear(GRID*27,GRID*12.5, dx, dy )
      canvas:compose(GRID*27, GRID*12.5, img)
    elseif  par == 'green' then
      local img = canvas:new("media/qrtwitter.png")
      local dx,dy = img:attrSize()
      canvas:attrColor(0,0,0,0)
      canvas:clear(GRID*27,GRID*12.5, dx, dy )
      canvas:compose(GRID*27, GRID*12.5, img)
    elseif  par == 'yellow' then
      local img = canvas:new("media/qrinsta.png")
      local dx,dy = img:attrSize()
      canvas:attrColor(0,0,0,0)
      canvas:clear(GRID*27,GRID*12.5, dx, dy )
      canvas:compose(GRID*27, GRID*12.5, img)
    elseif  par == 'blue' then
      local img = canvas:new("media/qryoutube.png")
      local dx,dy = img:attrSize()
      canvas:attrColor(0,0,0,0)
      canvas:clear(GRID*27,GRID*12.5, dx, dy )
      canvas:compose(GRID*27, GRID*12.5, img)
    end
  end
  canvas:flush()
end

-- sub menu pgm draw carrossel
function MainMenu:pgmDraw()

  canvas:attrColor(0,0,0,0)
  canvas:clear(0,0, GRID*32, GRID*11 )
  canvas:attrColor(1,1,1,200)
  canvas:clear(GRID*6,GRID*11.5, GRID*32, GRID*18 )

  for i=1,self.pgmicons  do
    if i==1 then
      self:pgmDrawIcons(shift(self.spos-1,i,#self.list),i,true)
    else
      self:pgmDrawIcons(shift(self.spos-1,i,#self.list),i,false)
    end
  end

  -- icone +info
  if (self.list[self.spos]["info"] == true) then
    local imginfo = canvas:new("media/pgminfo.png")
    canvas:compose(GRID*26.5, GRID*17, imginfo )
  end
  -- icone youtube
  if (self.list[self.spos]["youtube"] == true) then
    local imginfo = canvas:new("media/btnred.png")
    canvas:compose(GRID*28, GRID*17, imginfo )
  end
  -- icone site
  if (self.list[self.spos]["site"] == true) then
    local imginfo = canvas:new("media/btngreen.png")
    canvas:compose(GRID*29, GRID*17, imginfo )
  end
  -- icone facebook
  if (self.list[self.spos]["facebook"] == true) then
    local imginfo = canvas:new("media/btnyellow.png")
    canvas:compose(GRID*30, GRID*17, imginfo )
  end
  -- icone twitter
  if (self.list[self.spos]["twitter"] == true) then
    local imginfo = canvas:new("media/btnblue.png")
    canvas:compose(GRID*31, GRID*17, imginfo )
  end

  --text
  canvas:attrFont("Vera", 21,"bold")
  canvas:attrColor("white")

  canvas:drawText(GRID*6, GRID*14, self.list[self.spos]["desc1"] )
  canvas:drawText(GRID*6, GRID*14.7, self.list[self.spos]["desc2"] )
  canvas:drawText(GRID*6, GRID*15.4, self.list[self.spos]["desc3"] )
  canvas:drawText(GRID*6, GRID*16.1, self.list[self.spos]["desc4"] )
  --texto grade
  canvas:drawText(GRID*6,GRID*17, self.list[self.spos]["grade"])
  canvas:flush()
end

-- sub menu pgm draw carrossel icons

function MainMenu:pgmDrawIcons(t, slot, ativo)
  --setup parameters
  local item_h = 154
  local item_w = 85
  local icon = canvas:new("media/" .. string.format("%02d" , self.list[t]["img"]).. ".png")

  canvas:compose((GRID*6+(item_w*(slot-1))+(2*GRID*(slot-1))), GRID*11.5, icon )

  if ativo then
    canvas:attrColor("red")
    canvas:drawRect("frame", GRID*6, GRID*11.5, item_h+1, item_w+1)
    canvas:drawRect("frame", GRID*6-1, GRID*11.5-1, item_h+2, item_w+2)
    canvas:drawRect("frame", GRID*6-2, GRID*11.5-2, item_h+3, item_w+3)
    canvas:drawRect("frame", GRID*6-2, GRID*11.5-2, item_h+4, item_w+4)
  end
end

function MainMenu:input(evt)
  if (evt.key == "CURSOR_UP" )then
    self.pos=shift(self.pos,-1,self.icons)
    self:iconDraw()
    self:menuItem()
  elseif (evt.key == "CURSOR_DOWN") then
    self.pos=shift(self.pos,1,self.icons )
    self:iconDraw()
    self:menuItem()
  elseif ( self.pos==2 and evt.key == "CURSOR_LEFT" ) then
    self.spos=shift(self.spos,-1, #self.list)
    self:pgmDraw()
  elseif ( self.pos==2 and evt.key == "CURSOR_RIGHT" ) then
    self.spos=shift(self.spos,1, #self.list)
    self:pgmDraw()
    -- PGM
  elseif  (self.pos==2 and self.list[self.spos]["img"]==1 and self.list[self.spos]["info"] and evt.key == "ENTER" ) then
    --agenda start
    dofile("lib_agenda.lua")
    agenda=agendaMenu:new{}
    agenda:pageReset()
  elseif  (self.pos==2 and self.list[self.spos]["img"]==2 and self.list[self.spos]["info"] and evt.key == "ENTER" ) then
    --agenda start
    dofile("lib_altofalante.lua")
    af=altofalante:new{}
    --af:input()
    af:pageReset()

  elseif(self.pos == 2 and self.list[self.spos]["img"]==6 and self.list[self.spos]["info"] and evt.key=="ENTER") then
    --dango start
    canvas:attrColor(0,0,0,0)
    canvas:clear(0,0, GRID*32, GRID*11 )
    local img = canvas:new("media/pgm06.png")
    canvas:compose(0, 0, img)
    canvas:flush()
  elseif  (self.pos==2 and self.list[self.spos]["img"]==8 and self.list[self.spos]["info"] and evt.key == "ENTER" ) then
    --harmonia start
    dofile("lib_harmonia.lua")
    harmonia=harmoniaMenu:new{}
    harmonia:iconDraw()
    harmonia:menuItem()
  elseif  (self.pos==2 and self.list[self.spos]["img"]==13 and self.list[self.spos]["info"] and evt.key == "ENTER" ) then
    --mulherese start
    dofile("lib_mulherese.lua")
    mse=mulhereseMenu:new{}
    mse:iconsDraw()
  elseif  (self.pos==2 and self.list[self.spos]["img"]==18 and self.list[self.spos]["info"] and evt.key == "ENTER" ) then
    --mulherese start
    dofile("lib_ribalta.lua")
    ribalta=ribaltaMenu:new{}
    ribalta:pageReset()
    --qrcodes on contatos
  elseif ( self.pos==5 and evt.key == "RED" ) then
    self:menuItem('red')
  elseif ( self.pos==5 and evt.key == "GREEN" ) then
    self:menuItem('green')
  elseif ( self.pos==5 and evt.key == "YELLOW" ) then
    self:menuItem('yellow')
  elseif ( self.pos==5 and evt.key == "BLUE" ) then
    self:menuItem('blue')
  elseif ( evt.key=="EXIT" ) then
    ICON.state=1
    MENUON = false
    comainIcon = coroutine.create(mainIconAnim)
    mainIconUpdate()
  end
end
