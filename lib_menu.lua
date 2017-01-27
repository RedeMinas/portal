
--- Main Menu object

MainMenu = {}

function MainMenu:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.pos = 1
  self.spos = 1
  self.icons = 4
  self.start = false
  self.pgmicons = math.floor(screen_width/210)
  self.list=layoutPgmTable(ReadTable("tbl_pgm.txt"))
  self.debug=false
  self.settings=false
  return o
end

-- debugger
function settings()
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
function MainMenu:iconDraw()
  local iconpath=""
  local sumdy=0
  --conferir
  canvas:attrColor(0,0,0,0)
  canvas:clear(0,0, grid*32, grid*12)

  canvas:attrColor(1,1,1,200)
  canvas:clear(0,grid*11, grid*32, grid*18 )
  --  canvas:attrColor("white")
  --  canvas:drawRect("fill", 0,grid*12,grid*32,grid*18 )
  canvas:flush()
  for i=1,self.icons  do
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

  local img = canvas:new("media/btnarrowv.png")
  canvas:compose(grid, grid*17, img)
  local imgexit = canvas:new("media/btnsair.png")
  canvas:compose(grid*4, grid*17, imgexit)
  canvas:flush()
end

-- main menu treatment
function MainMenu:menuItem(par)
  --canvas:attrColor(0,0,0,0)
  --canvas:clear(0,0, grid*32, grid*10 )

  -- a redeminas
  if self.pos==1 then
    local img = canvas:new("media/aredeminas.png")
    canvas:compose(grid*6, grid*11.5, img)
    canvas:flush()
    -- programas
  elseif self.pos == 2 then
    local img = canvas:new("media/btnarrowh.png")
    canvas:compose(grid*2.5, grid*17, img)
    self:pgmDraw()
    canvas:flush()
    -- Nova sede
  elseif self.pos==3 then
    local img = canvas:new("media/sede.png")
    canvas:compose(grid*6, grid*11.5, img)
    canvas:flush()
  elseif self.pos==4 then
    canvas:attrColor(1,1,1,200)
    canvas:clear(grid*6,grid*11, grid*32, grid*18 )
    local img = canvas:new("media/contato.png")
    canvas:compose(grid*6, grid*11.5, img)
    -- results from tcp get
    canvas:attrColor("white")
    canvas:attrFont("Vera", 8,"bold")
    canvas:drawText(grid*15, grid*17.5, "v: " .. version .. "/" .. tcpresult )
    canvas:flush()
    if  par == 'red' then
      local img = canvas:new("media/qrfb.png")
      local dx,dy = img:attrSize()
      canvas:attrColor(0,0,0,0)
      canvas:clear(grid*32-dx,grid, dx, dy )
      canvas:compose(grid*32-dx, grid, img)
      canvas:flush()
    elseif  par == 'green' then
      local img = canvas:new("media/qrtwitter.png")
      local dx,dy = img:attrSize()
      canvas:attrColor(0,0,0,0)
      canvas:clear(grid*32-dx,grid, dx, dy )
      canvas:compose(grid*32-dx, grid, img)
      canvas:flush()
    elseif  par == 'yellow' then
      local img = canvas:new("media/qrinsta.png")
      local dx,dy = img:attrSize()
      canvas:attrColor(0,0,0,0)
      canvas:clear(grid*32-dx,grid, dx, dy )
      canvas:compose(grid*32-dx, grid, img)
      canvas:flush()
    elseif  par == 'blue' then
      local img = canvas:new("media/qryoutube.png")
      local dx,dy = img:attrSize()
      canvas:attrColor(0,0,0,0)
      canvas:clear(grid*32-dx,grid, dx, dy )
      canvas:compose(grid*32-dx, grid, img)
      canvas:flush()
    end
  end
end

-- sub menu pgm draw carrossel
function MainMenu:pgmDraw()

  canvas:attrColor(0,0,0,0)
  canvas:clear(0,0, grid*32, grid*11 )
  canvas:attrColor(1,1,1,200)
  canvas:clear(grid*6,grid*11.5, grid*32, grid*18 )

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
    canvas:compose(grid*26.5, grid*17, imginfo )
  end
  -- icone youtube
  if (self.list[self.spos]["youtube"] == true) then
    local imginfo = canvas:new("media/btnred.png")
    canvas:compose(grid*28, grid*17, imginfo )
  end
  -- icone site
  if (self.list[self.spos]["site"] == true) then
    local imginfo = canvas:new("media/btngreen.png")
    canvas:compose(grid*29, grid*17, imginfo )
  end
  -- icone facebook
  if (self.list[self.spos]["facebook"] == true) then
    local imginfo = canvas:new("media/btnyellow.png")
    canvas:compose(grid*30, grid*17, imginfo )
  end
  -- icone twitter
  if (self.list[self.spos]["twitter"] == true) then
    local imginfo = canvas:new("media/btnblue.png")
    canvas:compose(grid*31, grid*17, imginfo )
  end

  --text
  canvas:attrFont("Vera", 21,"bold")
  canvas:attrColor("white")

  canvas:drawText(grid*6, grid*14, self.list[self.spos]["desc1"] )
  canvas:drawText(grid*6, grid*14.7, self.list[self.spos]["desc2"] )
  canvas:drawText(grid*6, grid*15.4, self.list[self.spos]["desc3"] )
  canvas:drawText(grid*6, grid*16.1, self.list[self.spos]["desc4"] )


  --texto grade
  canvas:drawText(grid*6,grid*17, self.list[self.spos]["grade"])

  canvas:flush()
end

-- sub menu pgm draw carrossel icons

function MainMenu:pgmDrawIcons(t, slot, ativo)
  --setup parameters
  local item_h = 154
  local item_w = 85
  local icon = canvas:new("media/" .. string.format("%02d" , self.list[t]["img"]).. ".png")

  canvas:compose((grid*6+(item_w*(slot-1))+(2*grid*(slot-1))), grid*11.5, icon )

  if ativo then
    canvas:attrColor("red")
    canvas:drawRect("frame", grid*6, grid*11.5, item_h+1, item_w+1)
    canvas:drawRect("frame", grid*6-1, grid*11.5-1, item_h+2, item_w+2)
    canvas:drawRect("frame", grid*6-2, grid*11.5-2, item_h+3, item_w+3)
    canvas:drawRect("frame", grid*6-2, grid*11.5-2, item_h+4, item_w+4)
  end
end


