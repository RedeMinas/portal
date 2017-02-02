----------- MULHERE-SE ------------------------
mulhereseMenu = {}

function mulhereseMenu:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.iconsDisplay = 9
  self.pos = 1
  self.ppos = 1
  self.lastppos = 1
  self.pages = 3
  self.start = false
  self.list=layoutPgmMulherese(ReadTable("tbl_mulherese.txt"))
  self.bgcolor={r=41,g=19,b=69,a=204}

  return o
end

--deal with keys
function mulhereseMenu:input()
  if (evt.key=="CURSOR_RIGHT") then
    self.pos=shift(self.pos,1,#self.list)
    self:iconsDraw()
  elseif (evt.key=="CURSOR_LEFT") then
    self.pos=shift(self.pos,-1,#self.list)
    self:iconsDraw()
  elseif (evt.key=="CURSOR_UP") then
    self.ppos=shift(self.ppos,-1,self.pages)
    self:pageDraw()
  elseif ( evt.key=="CURSOR_DOWN") then
    self.ppos=shift(self.ppos,1,self.pages)
    self:pageDraw()
  end
end

function mulhereseMenu:iconsDraw(nItens)
  --selective clear all on start or partial on icons area
  canvas:attrColor(0,0,0,200)
  if (not pgmOn) then
    canvas:clear(0,0, grid*32, grid*18 )
  else
    canvas:clear(0,grid*14.5, grid*32, grid*18 )
  end
  for i=1,self.iconsDisplay  do
    if i==1 then
      self:iconsDrawItens(shift(self.pos-1,i,#self.list),i,true)
    else
      self:iconsDrawItens(shift(self.pos-1,i,#self.list),i)
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

  local icon = canvas:new("media/mulherese/icon" .. string.format("%02d" , t) .. ".png")
  canvas:compose((grid+(item_w*(slot-1))+(0.92*grid*(slot-1))), grid*17.5-item_h, icon )
  canvas:attrColor("blue")
  canvas:attrFont("Vera", font_size,"bold")

  if ativo then
    canvas:attrColor(255,255,255,255)
    canvas:drawRect("frame", grid+(item_w*(slot-1))+(grid*(slot-1)), grid*17.5-item_h, 100, 100)
  end

end

function mulhereseMenu:textDraw(text)

  canvas:attrColor(41,19,69,200)
  canvas:clear(grid*6,grid*2, grid*25, grid*12.5 )
  --display text margin - remove!

  canvas:attrFont("Tiresias", 20 , "normal")
  canvas:attrColor(255,255,255,200)

  list=textWrap(text,screen_width/20)

  --for i in ipairs(list) do
  --    print(list[i])
  --  end

  --canvas:drawText(grid*6, grid*1.7+((lasti+1)*grid*0.7) , result)

end


function mulhereseMenu:pageReset()

  -- clear
  canvas:attrColor(41,19,69,200)
  canvas:clear(grid,grid,grid*30,grid*13.5 )
  --canvas:attrColor(self.bgcolor["r"],self.bgcolor["g"],self.bgcolor["b"],self.bgcolor["a"])
--  canvas:drawRect("fill", grid, grid, grid*30, grid*13.5 )

  -- draw redeminas logo
  local logo = canvas:new("media/btn1off.png")
  canvas:compose(grid*26.8, grid*1.3, logo )


  -- Draw nav buttons
  local btnarrowv = canvas:new("media/btnarrowv.png")
  local btnarrowh = canvas:new("media/btnarrowh.png")
  local btnexit = canvas:new("media/btnsair.png")
  canvas:compose(grid*1.5, grid*13.5, btnarrowv)
  canvas:compose(grid*2.7, grid*13.5, btnarrowh)
  canvas:compose(grid*4, grid*13.5, btnexit)
  canvas:flush()
end

function mulhereseMenu:pageDraw()

  if (not pgmOn) then
    self.pageReset()
    pgmOn = true
  end

  -- Draw Ilustrations on left
  canvas:attrColor(41,19,69,200)
  canvas:clear(grid*1,grid*1,grid*5,grid*12.5 )
  local str = string.format("%02d" , self.pos)
  local imgil = canvas:new("media/mulherese/il" .. str .. ".png")
  print(str)
  canvas:compose(grid*1, grid*1, imgil)

  -- Draw Group Title
  canvas:attrColor(41,19,69,200)
    canvas:clear(grid*6,grid*1.2,grid*19,grid )

  --draw title
  canvas:attrColor(255,255,255,255)
  canvas:attrFont("Tiresias", 22 ,"bold")

  -- Draw Group Text using textDraw() function
  local text=""
  if (self.ppos == 1)   then
    texttitle = "As leis"
    text = self.list[self.pos]["page1"]
  elseif (self.ppos == 2)   then
    texttitle = "Acesso à justiça"
    text = self.list[self.pos]["page2"]
  elseif (self.ppos == 3)   then
    texttitle = "Serviços públicos"
    text = self.list[self.pos]["page3"]
  end
  canvas:drawText(grid*6, grid*1.2, self.list[self.pos]["id"] .. ": " ..texttitle)

  self:textDraw(text)

  canvas:flush()
end
