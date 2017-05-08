----------- MULHERE-SE ------------------------
mulhereseMenu = {}

function mulhereseMenu:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.iconsDisplay = 9
  self.pos = 1
  self.ppos = 1
  -- self.posv = 1
  self.lastppos = 1
  self.pages = 4
  self.start = false
  self.list=layoutPgmMulherese(ReadTable("tbl_mulherese.txt"))
  self.llines = 15
  self.llpos = 1
  self.llpages=1
  self.bgcolor={r=41,g=19,b=69,a=204}
  self.colors = {{127,30,43,255},{11,108,84,255},{203,164,9,255},{22,59,118,255}}
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
  elseif ( evt.key=="RED") then
    self.llpos,self.llpages =1,1
    self.ppos=1
    self:pageDraw()
  elseif ( evt.key=="GREEN") then
    self.llpos,self.llpages =1,1
    self.ppos=2
    self:pageDraw()
  elseif ( evt.key=="YELLOW") then
    self.llpos,self.llpages =1,1
    self.ppos=3
    self:pageDraw()
  elseif ( evt.key=="BLUE") then
    self.llpos,self.llpages =1,1
    self.ppos=4
    self:pageDraw()
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
  canvas:attrColor(0,0,0,200)
  if (not PGMON) then
    canvas:clear(0,0, GRID*32, GRID*18 )
  else
    canvas:clear(0,GRID*14.5, GRID*32, GRID*18 )
  end
  for i=1,self.iconsDisplay  do
    if i==1 then
      self:iconsDrawItens(shift(self.pos-1,i,#self.list-1),i,true)
    else
      self:iconsDrawItens(shift(self.pos-1,i,#self.list-1),i)
    end
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
  canvas:compose((GRID+(item_w*(slot-1))+(0.92*GRID*(slot-1))), GRID*17.5-item_h, icon )
  canvas:attrColor("blue")
  canvas:attrFont("Vera", font_size,"bold")

  if ativo then
    canvas:attrColor(255,255,255,255)
    --canvas:drawRect("frame", GRID+(item_w*(slot-1))+(GRID*(slot-1)), GRID*17.5-item_h, 100, 100)
    local iconborder = canvas:new("media/mulherese/focusborder.png")
    canvas:compose(GRID-2, GRID*17.5-item_h-2, iconborder )
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
  canvas:attrColor(41,19,69,200)
  canvas:clear(GRID*6,GRID*2, GRID*25, GRID*12.5 )

  --display text margin - remove!
  if intro then
    canvas:attrFont("Tiresias",20, "normal")
  else
    canvas:attrFont("Tiresias",15, "normal")
  end

  canvas:attrColor(255,255,255,200)

  local m = (self.llpos-1)*self.llines
  for  i = m+1, m+self.llines do
    canvas:drawText(GRID*6,GRID*2.5+(GRID*0.75*(i-m-1)),list[i])
  end
end

function mulhereseMenu:pageReset()
  -- clear
  canvas:attrColor(41,19,69,200)
  canvas:clear(GRID,GRID,GRID*30,GRID*13.5 )
  --canvas:attrColor(self.bgcolor["r"],self.bgcolor["g"],self.bgcolor["b"],self.bgcolor["a"])
--  canvas:drawRect("fill", GRID, GRID, GRID*30, GRID*13.5 )

  -- draw redeminas logo
  local logo = canvas:new("media/btn1off.png")
  canvas:compose(GRID*26.8, GRID*1.3, logo )

  -- Draw nav buttons
 -- local btnarrowv = canvas:new("media/btnarrowv.png")
  local btnarrowh = canvas:new("media/btnarrowh.png")
  local btnexit = canvas:new("media/btnsair.png")
 -- canvas:compose(GRID*1.5, GRID*13.5, btnarrowv)
  canvas:compose(GRID*2, GRID*13.5, btnarrowh)
  canvas:compose(GRID*4, GRID*13.5, btnexit)
  canvas:flush()
end

function mulhereseMenu:pageDraw()
  if (not PGMON) then
    self:pageReset()
    PGMON = true
  end

  -- Draw Ilustrations on left
  canvas:attrColor(41,19,69,200)
  canvas:clear(GRID*1,GRID*1,GRID*5,GRID*12.5 )

  local str = string.format("%02d" , self.list[self.pos+1]["id"])
  local imgil = canvas:new("media/mulherese/il" ..  str .. ".png")
  canvas:compose(GRID*1, GRID*1, imgil)

 --Draw btnicon on left
 -- canvas:attrColor(41,19,69,200)
 -- canvas:clear(GRID*1,GRID*1,GRID*5, GRID*12.5)
  for i=1, self.pages do
    if i == self.ppos then
      canvas:attrColor(
        self.colors[i][1],
        self.colors[i][2],
        self.colors[i][3],
        self.colors[i][4]
      )
    else
      canvas:attrColor("white")
    end
    canvas:attrFont("Tiresias", 13,"bold")
    local param = "page" .. i

    canvas:drawText(GRID*2.25, GRID*8.52+0.85*GRID*i-1, tostring(self.list[1][param]))

    local imgicons = canvas:new("media/mulherese/btnicon.png")
    local dx,dy = imgicons:attrSize()
    canvas:compose(GRID*2-dx, GRID*9.39, imgicons )
    --canvas:drawText(GRID*14,GRID*16 , self.acats[self.aposh])
    canvas:flush()
  end
  -- Draw Group Title
  canvas:attrColor(41,19,69,200)
    canvas:clear(GRID*6,GRID*1.2,GRID*19,GRID )

  -- Draw Group Text using textDraw() function
    local text=""

  if (self.ppos == 1)   then
    texttitle = self.list[1]["page1"]
    text = self.list[self.pos+1]["page1"]
  elseif (self.ppos == 2)   then
    texttitle = self.list[1]["page2"]
    text = self.list[self.pos+1]["page2"]
  elseif (self.ppos == 3)   then
    texttitle = self.list[1]["page3"]
    text = self.list[self.pos+1]["page3"]
  elseif (self.ppos == 4)   then
    texttitle = self.list[1]["page4"]
    text = self.list[self.pos+1]["page4"]
  end

  local a = self:textPrepare(text)

  -- sets llpages
  if (self.ppos == 1) then
    self:displayText(a,true)
  else
    self:displayText(a,false)
  end

  canvas:attrColor(255,255,255,255)
  canvas:attrFont("Tiresias", 22 ,"bold")

  -- if pages, change title, draw arrowv
  if self.llpages > 1 then
    texttitle = texttitle .. " (" .. self.llpos .. " / " .. self.llpages .. ")"
    dx,dy=canvas:measureText(texttitle)

    local btnarrowv = canvas:new("media/btnarrowv.png")
    canvas:compose(GRID*6+dx+GRID*4, GRID*1.1, btnarrowv)
  end

  --draw title
  canvas:drawText(GRID*6, GRID*1.2, self.list[self.pos+1]["cat"] .. ": " ..texttitle)
  canvas:flush()

end
