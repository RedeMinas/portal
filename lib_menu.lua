--main icon and tcp metrics
function mainIcon()

  canvas:attrColor(0,0,0,0)
  canvas:clear(0,0, grid*32, grid*18)

  local icon = canvas:new("media/icon.png")
  canvas:compose(grid*28, grid*15, icon )

  canvas:flush()
  require 'lib_tcp'
  if start == false then
    tcp.execute(
      function ()
        tcp.connect('www.redeminas.mg.gov.br', 80)
        tcp.send('get /ginga.php?aplicacao=portal' .. version .. '\n')
        tcpresult = tcp.receive()
        print(tcpresult)
        if tcpresult then
          tcpresult = tcpresult or '0'
        else
          tcpresult = 'er:' .. evt.error
        end
        canvas:flush()
        tcp.disconnect()
        start = true
      end
    )
  end
end

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
  --conferir
  canvas:attrColor(0,0,0,0)
  canvas:clear(0,0, grid*32, grid*12)

  canvas:attrColor(1,1,1,200)
  canvas:clear(0,grid*11, grid*32, grid*18 )
--  canvas:attrColor("white")
--  canvas:drawRect("fill", 0,grid*12,grid*32,grid*18 )
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
    -- programsa
  elseif self.pos == 2 then
    local img = canvas:new("media/btnarrowh.png")
    canvas:compose(grid*2.5, grid*17, img)
    canvas:flush()
    self:pgmDraw(pgmShowItens)
    self:pgmDrawInfo()
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
    canvas:drawText(grid*16, grid*17, "v: " .. version .. "/" .. tcpresult )

    canvas:flush()
    if self.pos == 4 and par == 'red' then
      local img = canvas:new("media/qrfb.png")
      local dx,dy = img:attrSize()
      canvas:compose(grid*32-dx, grid, img)
      canvas:flush()
    end
    if self.pos == 4 and par == 'green' then
      local img = canvas:new("media/qrtwitter.png")
      local dx,dy = img:attrSize()
      canvas:compose(grid*32-dx, grid, img)
      canvas:flush()
    end
    if self.pos == 4 and par == 'yellow' then
      local img = canvas:new("media/qrinsta.png")
      local dx,dy = img:attrSize()
      canvas:compose(grid*32-dx, grid, img)
      canvas:flush()
    end
    if self.pos == 4 and par == 'blue' then
      local img = canvas:new("media/qryoutube.png")
      local dx,dy = img:attrSize()
      canvas:compose(grid*32-dx, grid, img)
      canvas:flush()
    end
  end
end

-- sub menu pgm draw carrossel
function MainMenu:pgmDraw(t)
  canvas:attrColor(1,1,1,200)
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
    canvas:drawRect("frame", grid*7-1, grid*11.5-1, item_h+2, item_w+2)
    canvas:drawRect("frame", grid*7-2, grid*11.5-2, item_h+3, item_w+3)
    canvas:drawRect("frame", grid*7-2, grid*11.5-2, item_h+4, item_w+4)
  end

  canvas:flush()
end

-- sub menu pgm draw information
function MainMenu:pgmDrawInfo()
  local font_size = 21

  print (unpack(self.list[1]))

  canvas:attrColor(1,1,1,200)
  canvas:clear(grid*7,grid*14, grid*32, grid*18 )

  canvas:attrFont("Vera", font_size,"bold")
  --text
  canvas:attrColor("white")
  canvas:drawText(grid*7, grid*14, self.list[self.spos]["desc1"] )
  canvas:drawText(grid*7, grid*14.7, self.list[self.spos]["desc2"] )
  canvas:drawText(grid*7, grid*15.4, self.list[self.spos]["desc3"] )

--  canvas:drawText(grid*7, grid*16.4, self.list[self.spos]["nome"] )
--  canvas:drawText(grid*10, grid*16.4, self.list[self.spos]["site"] )
--  canvas:drawText(grid*14, grid*16.4, self.list[self.spos]["youtube"] )

  canvas:drawText(grid*7,grid*17, self.list[self.spos]["grade"])
  canvas:flush()
end
