----------- MULHERE-SE ------------------------
mulhereseMenu = {}

function mulhereseMenu:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  --numero de icons 
  self.iconsDisplay = 8
  self.pos = 1
  self.ppos = 1
  -- self.posv = 1
  self.lastppos = 1
  self.start = false
  self.debug = false
  if not self.debug then
    self.list=layoutPgmMulherese(ReadTable("tbl_mulherese.txt"))
  end
  self.llines = 15
  self.llpos = 1
  self.llpages = 1
  --self.bgcolor={r=70,g=32,b=27,a=204} -- cinza
  self.bgcolor = {r=100,g=50,b=50,a=150} -- terra
  self.bgcolor2 = {r=100,g=50,b=50,a=200} -- terra

  --self.colors = {{127,30,43,255},{11,108,84,255},{203,164,9,255},{22,59,118,255}}
  return o
end

--deal with keys
function mulhereseMenu:input(evt)
  if (evt.key=="CURSOR_RIGHT") then
    self.llpos,self.llpages =1,1
    self.pos=shift(self.pos,1,#self.list-1)
    self:iconsDraw()

  elseif (evt.key=="CURSOR_LEFT") then
    self.llpos,self.llpages =1,1
    self.pos=shift(self.pos,-1,#self.list-1)
    self:iconsDraw()
  end

  if( self.llpages > 1) then
    if ( evt.key=="CURSOR_DOWN") then
      self.llpos=shift(self.llpos,1,self.llpages)
      self:pageDraw()
    elseif (evt.key=="CURSOR_UP") then
      self.llpos=shift(self.llpos,-1,self.llpages)
      self:pageDraw()
    end
  end
end

function mulhereseMenu:iconsDraw(nItens)
  --selective clear all on start or partial on icons area
--  canvas:attrColor(0,0,0,200)
  canvas:attrColor(self.bgcolor["r"],self.bgcolor["g"],self.bgcolor["b"],self.bgcolor["a"])
  if (not PGMON) then
    canvas:clear(0,0, GRID*32, GRID*18 )
    self:pageReset()
    PGMON=true
  else
    -- clear bottom icons area
    canvas:clear(GRID*5,GRID*14.5, GRID*32, GRID*18 )
  end

  for i=1,self.iconsDisplay  do
    if i==1 then
      self:iconsDrawItens(shift(self.pos-1,i,#self.list-1),i,true)
    else
      self:iconsDrawItens(shift(self.pos-1,i,#self.list-1),i)
    end
    canvas:flush()
  end
  self:pageDraw()
  canvas:flush()
end

function mulhereseMenu:iconsDrawItens(t, slot, ativo)
    --setup parameters
  local item_h = 100
  local item_w = 100
  local font_size = 12

  local str = string.format("%02d" , self.list[t+1]["id"])

  local icon = canvas:new("media/mulherese/icon" .. str .. ".png")
  canvas:compose((GRID*7+(item_w*(slot-1))+(0.5*GRID*(slot-1))), GRID*17.5-item_h, icon )
  canvas:attrColor("blue")
  canvas:attrFont("Vera", font_size,"bold")

  if ativo then
    canvas:attrColor(255,255,255,255)
    --canvas:drawRect("frame", GRID+(item_w*(slot-1))+(GRID*(slot-1)), GRID*17.5-item_h, 100, 100)
    local iconborder = canvas:new("media/mulherese/focusborder.png")
    canvas:compose(GRID*7-2, GRID*17.5-item_h-2, iconborder )
  end
end

function mulhereseMenu:textPrepare(text)
  local list=textWrap(text,SCREEN_WIDTH/12)
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
--[[
  for regexp in llist:gmatch("[^\\]+") do
    for i=1,#llist do
      if i ~= 1 then
        l = l +1
      end
      list[ll]=llist[i]
    end
  end
]]--


  self.llpages=math.ceil(ll/self.llines)

  -- treat nill -> insert empty lines
  for j = 1, self.llpages*self.llines do
    if not llist[j] then
      llist[j]= " "
    end
  end

  return llist
end

function mulhereseMenu:displayText(list,intro)
-- RECT DISPLAY
  canvas:attrColor(self.bgcolor2["r"],self.bgcolor2["g"],self.bgcolor2["b"],self.bgcolor2["a"])
  canvas:clear(GRID*5.5,0, GRID*27, GRID*14.5 )
  --display text margin - remove!
  if intro then
    canvas:attrFont("Tiresias",20, "normal")
  else
    canvas:attrFont("Tiresias",15, "normal")
  end
  canvas:attrColor(255,255,255,200)
  local m = (self.llpos-1)*self.llines
  for  i = m+1, m+self.llines do
    canvas:drawText(GRID*6.25,GRID*2+(GRID*0.75*(i-m-1)),list[i])
  end
end

function mulhereseMenu:pageReset()
  -- clear
  canvas:attrColor(self.bgcolor["r"],self.bgcolor["g"],self.bgcolor["b"],self.bgcolor["a"])
  canvas:clear(GRID*6,GRID*4.5,GRID*30,GRID*13.5 )
--  canvas:drawRect("fill", GRID, GRID, GRID*30, GRID*13.5 )

end

function mulhereseMenu:pageDraw()
  -- RECT ICONS
  -- Draw Ilustrations on left
  canvas:attrColor(self.bgcolor["r"],self.bgcolor["g"],self.bgcolor["b"],self.bgcolor["a"])
  canvas:clear(0,0,GRID*5.5,GRID*18)
  local imgil = canvas:new("media/mulherese/il.png")
  canvas:compose(0,0 , imgil)


  -- Draw Group Title
  canvas:attrColor(self.bgcolor["r"],self.bgcolor["g"],self.bgcolor["b"],self.bgcolor["a"])
  canvas:clear(GRID*7,GRID*1.2,GRID*19,GRID )

  -- Draw Group Text using textDraw() function
  local text = self.list[self.pos+1]["page"]
  local texttitle = ""
  local pagetitle = ""
  local a = self:textPrepare(text)
  -- sets llpages
  if (self.ppos == 1) then
    self:displayText(a,true)
  else
    self:displayText(a,false)
  end

  if (self.pos == 1 and self.llpos == 2) then
    local imgqr = canvas:new("media/mulherese/qrmse.png")
    canvas:compose(GRID*15,GRID*8 , imgqr)
  end

  canvas:attrColor(255,255,255,255)
  canvas:attrFont("Tiresias", 22 ,"bold")

  -- if pages, change title, draw arrowv
  canvas:attrColor(self.bgcolor["r"],self.bgcolor["g"],self.bgcolor["b"],self.bgcolor["a"])
  canvas:clear(GRID*2.5,GRID*17,GRID,GRID )
  if self.llpages > 1 then
    texttitle = self.list[self.pos+1]["cat"]
    pagetitle = "(" .. self.llpos .. " / " .. self.llpages .. ")"
    local dx,dy=canvas:measureText(texttitle)
    local btnarrowv = canvas:new("media/btnarrowv.png")
    canvas:compose(GRID*2.5, GRID*17, btnarrowv)
  else
    texttitle = self.list[self.pos+1]["cat"]
  end
   -- Draw nav buttons
  local btnarrowh = canvas:new("media/btnarrowh.png")
  local btnexit = canvas:new("media/btnsair.png")
  canvas:compose(GRID*1, GRID*17, btnarrowh)
  canvas:compose(GRID*4, GRID*17, btnexit)
  canvas:flush()

  -- draw redeminas logo
  local logo = canvas:new("media/btn1off.png")
  canvas:compose(GRID*0.75, GRID/2, logo )
  --draw title
  canvas:attrColor(255,255,255,255)
  canvas:attrFont("Tiresias", 28 ,"bold")
  canvas:drawText(GRID*6.25, GRID/2, texttitle)
  canvas:drawText(GRID*26, GRID/2, pagetitle)
  canvas:flush()

end
