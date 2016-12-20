--- Main Menu
function MainMenu:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function MainMenu:shift(x,v,limit)
  -- not as num?
  if v == nil then v = 0 end
  if x + v < 1 then
    return x + v + limit
  elseif  x + v > limit  then
    return x + v - limit
  else
    return x+v
  end
end

-- debugger
function MainMenu:settings()
    if (self.debug==true) then
    canvas:attrColor("red")
    canvas:drawRect("fill",screen_width-(screen_width/6),0,200,200)
    canvas:attrColor("white")
    canvas:attrFont("Vera", 12,"normal")
    canvas:drawText(pos_x,pos_y, screen_width .. "x" .. screen_height .. "\n" .. self.pos)
  else
    canvas:attrColor(0,0,0,0)
    canvas:clear(grid*16,grid*5,200,200)
  end
  canvas:flush()
end

-- main menu icons vert scroll
function MainMenu:iconDraw(t)
  local iconpath=""
  local sumdy=0
  canvas:attrColor(0,0,0,0)
  canvas:clear(0,0, grid*32, grid*18 )
  canvas:flush()
  for i=1,t  do
    if i==self.pos then
      iconpath = "media/btn" ..  tostring(i) .. "on.png"
    else
      iconpath = "media/btn" ..  tostring(i) .. "off.png"
    end
    local icon = canvas:new(iconpath)
    local dx,dy = icon:attrSize()
    canvas:compose(grid, grid*11.5+sumdy, icon )
    sumdy=sumdy+dy+grid/2
  end
  canvas:flush()
end

-- main menu treatment
function MainMenu:menuItem()
  canvas:attrColor(0,0,0,0)
  canvas:clear(grid*7,grid*10, grid*32, grid*18 )
  if self.pos==1 then
    local img = canvas:new("media/aredeminas.png")
    canvas:compose(grid*6, grid*12, img)
    canvas:flush()
  elseif self.pos==2 then
    self:pgmDraw(pgmShowItens)
    self:pgmDrawInfo()
  elseif self.pos==3 then
    local img = canvas:new("media/sede.png")
    canvas:compose(grid*2, grid*2, img)
    canvas:flush()
  elseif self.pos==4 then
    local img = canvas:new("media/aredeminas.png")
    canvas:compose(grid*6, grid*12, img)
    canvas:flush()
  end
end

-- sub menu pgm draw carrossel
function MainMenu:pgmDraw(t)
  print("debug")
  print(t)
  canvas:attrColor(0,0,0,0)
  canvas:clear(grid*6,grid*11, grid*32, grid*18 )
  canvas:flush()
  for i=1,pgmShowItens  do
    if i==1 then
      self:pgmDrawItem(self:shift(self.spos-1,i,pgmTotalItens),i,true)
    else
      self:pgmDrawItem(self:shift(self.spos-1,i,pgmTotalItens),i,false)
    end
  end
  canvas:flush()
end

-- sub menu pgm draw carrossel icons
function MainMenu:pgmDrawItem(t, slot, ativo)
  --setup parameters
  local item_h = 154
  local item_w = 85

  local icon = canvas:new("media/" .. string.format("%02d" , t).. ".png")
  canvas:compose((grid*7+(item_w*(slot-1))+(2*grid*(slot-1))), grid*11.5, icon )

  if ativo then
    canvas:attrColor("red")
    canvas:drawRect("frame", grid*7, grid*11.5, item_h+1, item_w+1)
  end

  canvas:flush()
end

-- sub menu pgm draw information
function MainMenu:pgmDrawInfo()
  local font_size = 21

  canvas:attrColor(0,0,0,0)
  canvas:clear(grid*7,grid*14, grid*32, grid*18 )

  canvas:attrFont("Vera", font_size,"bold")

  --shadow text
  canvas:attrColor('black')
  canvas:drawText(grid*7+1,grid*14+1, self.list[self.spos]["descricao"])

  --text
  canvas:attrColor('red')
  canvas:drawText(grid*7,grid*14, self.list[self.spos]["descricao"])
  canvas:flush()
end
