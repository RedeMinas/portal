--main icon and tcp metrics

require 'lib_tcp'

function countMetric()
  -- ping internet
  if start == false then
    tcp.execute(
      function ()
        tcp.connect('www.redeminas.mg.gov.br', 80)
        tcp.send('get /ginga.php?aplicacao=portal' .. version .. '\n')
        tcpresult = tcp.receive()
        --print(tcpresult)
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

function shift(x,v,limit)
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


function mainIcon()
  local icon = canvas:new("media/icon.png")

  canvas:attrColor(0,0,0,0)
  canvas:clear(0,0, grid*32, grid*18)
  canvas:compose(grid*28,grid*15,icon)
  canvas:flush()

end

-- disabled
function mainIconAnim()
  local icon = canvas:new("media/icon.png")
  local icon2 = canvas:new("media/icon2.png")
  while( menuOn == false) do
    canvas:attrColor(0,0,0,0)
    canvas:clear(0,0, grid*32, grid*18)
    if mainIconState < 50 then
      mainIconState=mainIconState+1
      canvas:compose(grid*28,grid*15,icon)
    elseif mainIconState >= 50 and mainIconState < 100 then
      mainIconState = mainIconState+1
      canvas:compose(grid*28,grid*15,icon2)
    elseif mainIconState == 100 then
      mainIconState =1
    end
    canvas:flush()

    coroutine.yield() -- sleep...
  end
end
comainIcon = coroutine.create(mainIcon)

function mainIconUpdate()
  --  print (coroutine.status(comainIcon))
  coroutine.resume(comainIcon)
  if   coroutine.status(comainIcon) ~= 'dead' then
    event.timer(100,mainIconUpdate)
  end
end

--- Main Menu
function MainMenu:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
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
      canvas:attrColor(0,0,0,0)
      canvas:clear(grid*32-dx,grid, dx, dy )
      canvas:compose(grid*32-dx, grid, img)
      canvas:flush()
    end
    if self.pos == 4 and par == 'green' then
      local img = canvas:new("media/qrtwitter.png")
      local dx,dy = img:attrSize()
      canvas:attrColor(0,0,0,0)
      canvas:clear(grid*32-dx,grid, dx, dy )
      canvas:compose(grid*32-dx, grid, img)
      canvas:flush()
    end
    if self.pos == 4 and par == 'yellow' then
      local img = canvas:new("media/qrinsta.png")
      local dx,dy = img:attrSize()
      canvas:attrColor(0,0,0,0)
      canvas:clear(grid*32-dx,grid, dx, dy )
      canvas:compose(grid*32-dx, grid, img)
      canvas:flush()
    end
    if self.pos == 4 and par == 'blue' then
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
  canvas:attrColor(1,1,1,200)
  canvas:clear(grid*6,grid*11, grid*32, grid*18 )
  canvas:flush()
  for i=1,self.pgmicons  do
    if i==1 then
      self:pgmDrawItem(shift(self.spos-1,i,#self.list),i,true)
    else
      self:pgmDrawItem(shift(self.spos-1,i,#self.list),i,false)
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

  --print (unpack(self.list[1]))

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



----------- MULHERE-SE ------------------------

--- mulherese
function mulhereseMenu:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.list = { "Mulhere-se", "Informe-se", "Mulheres Idosas","Mulheres Negras", "Mulheres em situação de rua", "Mulheres Encarceradas","Mulheres Deficientes", "Mulheres Usuárias da saúde mental", "Mulheres Lésbicas", "Mulheres Trans", "Mulheres Prostitutas", "Mulheres Refugiadas", "Mulheres do campo", "Mulheres Quilombolas", "Mulheres Jovens"}
  return o
end

function mulhereseMenu:draw(nItens)
  canvas:attrColor(0,0,0,200)
  canvas:clear(0,0, grid*32, grid*18 )
  for i=1,9  do
    if i==1 then
      self:draw_item(shift(self.pos-1,i,#self.list),i,true)
    else
      self:draw_item(shift(self.pos-1,i,#self.list),i)
    end
  end
  canvas:flush()
end

function mulhereseMenu:draw_item(t, slot, ativo)
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
  canvas:flush()
end


local test = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas congue tortor quis lectus mattis, porta scelerisque magna vestibulum. Praesent enim erat, luctus sit amet ligula et, vulputate rutrum turpis. Aliquam at quam quis risus interdum blandit. Phasellus volutpat dolor id urna viverra tincidunt. Etiam lorem felis, mattis id ligula ac, mollis dictum nibh. Curabitur condimentum sollicitudin auctor. Morbi vitae erat felis. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. In hac habitasse platea dictumst. Nullam scelerisque, justo quis accumsan fringilla, libero dui ornare lectus, vitae volutpat magna odio ac magna. In id congue eros, rhoncus sagittis nibh. Sed efficitur, erat a fringilla facilisis, neque eros iaculis felis, tristique laoreet velit odio eget libero. Donec quis risus sit amet tellus efficitur suscipit. Cras blandit id ligula et rutrum. Maecenas et ante odio. Vestibulum sed accumsan lacus, non mollis est. Duis in eleifend ligula. Nullam sit amet sapien in ligula pretium condimentum nec sit amet tellus. Donec auctor, justo ac facilisis dapibus, ex nisl venenatis lacus, et aliquet nunc turpis facilisis magna. Proin ornare eleifend aliquam. In ullamcorper volutpat urna sed vulputate. Vestibulum a neque ultrices, finibus purus eu, condimentum lorem.  "
local test2 = "Etiam dapibus est id magna fermentum, quis ultrices mi placerat. Pellentesque malesuada orci id molestie condimentum. Mauris commodo nisi nec justo lobortis, a vehicula tortor fringilla. Nullam non eleifend odio. Phasellus laoreet tempor magna, eget ornare enim. Nunc quis eros sed libero scelerisque dictum ac sit amet erat. Donec varius turpis interdum neque sodales, aliquam efficitur sem sodales. Aliquam vel nibh a neque auctor dignissim eu in felis. Pellentesque laoreet, nisl nec consequat tristique, justo velit semper urna, in aliquam dolor lacus id massa. Pellentesque tortor odio, volutpat at porttitor id, malesuada eu lorem. Vestibulum mollis malesuada purus ultrices convallis. Fusce sed massa dolor. Duis tempor rhoncus fringilla. Sed elementum pharetra fermentum. Donec odio tortor, consectetur a mauris vel, condimentum efficitur felis. Phasellus imperdiet purus et imperdiet vestibulum. Cras eu lectus nec dolor posuere ullamcorper vel non nulla. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin efficitur aliquet laoreet. Ut porta tincidunt metus."

function wrap(s, w, i1, i2)
  w = w or 78
  i1 = i1 or 0
  i2 = i2 or 0
  --affirm(i1 < w and i2 < w,
    --     "wrap: the indents must be less than the line width")
  s = string.gsub(" ", i1) .. s
  local lstart, len = 1, strlen(s)
  while len - lstart > w do
    local i = lstart + w
    while i > lstart and strsub(s, i, i) ~= " " do i = i - 1 end
    local j = i
    while j > lstart and strsub(s, j, j) == " " do j = j - 1 end
    s = strsub(s, 1, j) .. "\n" .. strrep(" ", i2) ..
      strsub(s, i + 1, -1)
    local change = i2 + 1 - (i - j)
    lstart = j + change
    len = len + change
  end
  return s
end

function mulhereseMenu:textDraw(text,size,pos_x,pos_y)

  if (self.ppos == 2) then
    text = test2
  elseif (self.ppos == 3) then
    text = " página 3"
  elseif (self.ppos == 4) then
    text = " pagina 4 - ilustrações"
  end

  canvas:attrFont("Tiresias", 17 , "normal")
  canvas:attrColor(255,255,255,200)
  for i=1,(math.floor(string.len(text)/size)+1) do
    local offset=0
    if i==1 then
      result=string.sub(text,i,size)
--      print( canvas:measureText (result))
      canvas:drawText(grid*2, grid*2.5 , result)
    else
--      print(string.sub(result,size-1,size-1))
      print(string.sub(result,size,size))
      result=string.sub(text,((i-1)*size),(i*size))
      if string.sub(result,1,1) == " " then
        result = string.sub(result,2,size)
        --      elseif (string.sub(result,size+1,size+1) == ",") then
      elseif (result[100] == ",") then

        print("rolou")
        offset=offset+1
      end
      canvas:drawText(grid*2, grid*1.8+i*grid*0.7 , result)
    end
  end
end

function mulhereseMenu:page()

  -- clear
  canvas:attrColor(0,0,0,0)
  canvas:clear(grid,grid,grid*30,grid*13.5 )

  local font_size = 20
  local icon_size = 100
  --Draw Group Background
  canvas:attrColor(153,151,204,200)
  canvas:drawRect("fill", grid, grid, grid*30, grid*13.5 )

  --test margin - remove!

  canvas:attrColor("red")
  canvas:drawRect("frame", grid*2, grid*2, grid*24, grid*12 )

  -- Draw Group Icon
  local str = string.format("%02d" , self.pos)
  local icone = canvas:new("media/mulherese/icon" .. str .. ".png")
  canvas:compose(((grid*30.5)-icon_size), (grid*5)-icon_size, icone )

  -- Draw Group Title
  canvas:attrColor(255,255,255,255)
  canvas:attrFont("GFS Artemisia", font_size,"normal")
  local textSizeWidth, textSizeHeight = canvas:measureText (self.list[self.pos])
  --print( canvas:measureText (self.list[t]))
  canvas:drawText((grid*30.5-textSizeWidth), grid*2-textSizeHeight, self.list[self.pos])

  local text=""
  if (self.ppos == 1)   then
     text = "info"
  elseif (self.ppos == 2)   then
     text = "leis"
  elseif (self.ppos == 3)   then
     text = "diretos"
  elseif (self.ppos == 4)   then
     text = "slot livre"
  end

  canvas:drawText(grid*27, grid*8,  text)

  -- Draw Group Text using textDraw() function
  self:textDraw(test,100,grid*2,grid*2)
    canvas:flush()

end
