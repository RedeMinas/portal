--- Harmonia object

harmoniaMenu = {}

function harmoniaMenu:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.pos = 1
  self.spos = 1
  self.icons = 4
--  self.pgmicons = math.floor(screen_width/210)
--  self.list=layoutPgmTable(ReadTable("tbl_pgm.txt"))
  self.debug=false
--  self.settings=false
  return o
end

-- harmonia icons vert scroll
function harmoniaMenu:iconDraw()
  if (not pgmOn) then
    --self:pageReset()
    pgmOn = true
  end

  self:pageReset()
  local iconpath=""
  local sumdy=0

  for i=1,self.icons  do
    local text
    if i == 1 then
      text="Edição da semana"
    elseif i == 2 then
      text="Repertório"
    elseif i == 3 then
      text="Especial do mês"
    else
      text="Contatos"
    end
    if i==self.pos then
      iconpath = "media/harmonia/btn" ..  tostring(i) .. "on.png"
      canvas:attrColor(255,255,255,255)
    else
      iconpath = "media/harmonia/btn" ..  tostring(i) .. "off.png"
      canvas:attrColor(0,0,0,255)
    end
    local icon = canvas:new(iconpath)
    local dx,dy = icon:attrSize()

    canvas:attrFont("Vera", 15,"bold")
    canvas:drawText(grid,grid*10.5+(grid*i),text)
--    canvas:compose(0, grid*11+sumdy, icon )
    sumdy=sumdy+dy
  end
  self:pageDraw()
  canvas:flush()
end



function harmoniaMenu:pageDraw()
  canvas:attrColor(93,196,179,217)
--  canvas:attrColor("blue")
--  canvas:clear(grid*7,grid*11, grid*32, grid*18 )

  if self.pos == 1 then
    print ("chegou")
  end
end



function harmoniaMenu:pageReset()
  canvas:attrColor(0,0,0,0)
  canvas:clear(0,0, grid*32, grid*18 )

  local logo = canvas:new("media/harmonia/fundo.png")
  canvas:compose(0, grid*11, logo )

--  canvas:attrColor(93,196,179,217)
--  canvas:clear(0,grid*11, grid*32, grid*18 )

  --canvas:attrColor(self.bgcolor["r"],self.bgcolor["g"],self.bgcolor["b"],self.bgcolor["a"])
  --  canvas:drawRect("fill", grid, grid, grid*30, grid*13.5 )

  -- draw redeminas logo
  local logo = canvas:new("media/btn1off.png")
  canvas:compose(grid, grid*16, logo )

  -- Draw nav buttons
  local btnarrowv = canvas:new("media/btnarrowv.png")
  local btnarrowh = canvas:new("media/btnarrowh.png")
  local btnexit = canvas:new("media/btnsair.png")
  canvas:compose(grid, grid*17, btnarrowv)
  canvas:compose(grid*2.5, grid*17, btnarrowh)
  canvas:compose(grid*4, grid*17, btnexit)
end



-- main menu treatment
function harmoniaMenu:menuItem(par)
  --canvas:attrColor(0,0,0,0)
  --canvas:clear(0,0, grid*32, grid*10 )

  -- edicao da semana
  if (self.pos==1) then
    local logo = canvas:new("media/btn1off.png")
    canvas:compose(grid, grid*16, logo )
    local img = canvas:new("media/harmonia/edicaodasemana.png")
    canvas:compose(grid*6, grid*11.5, img)
    -- repertorio - agenda semanal
  elseif (self.pos == 2) then
    --local img = canvas:new("media/btnarrowh.png")
--    canvas:compose(grid*2.5, grid*17, img)
    local img = canvas:new("media/harmonia/repertorio.png")
    canvas:compose(grid*6, grid*11.5, img)
    -- especial do mes
  elseif (self.pos==3) then
    local img = canvas:new("media/harmonia/especialdomes.png")
    canvas:compose(grid*6, grid*11.5, img)
  elseif (self.pos==4) then
    canvas:attrColor(1,1,1,200)
    canvas:clear(grid*6,grid*11, grid*32, grid*18 )
    local img = canvas:new("media/harmonia/contatos.png")
    canvas:compose(grid*6, grid*11.5, img)
    -- results from tcp get
    if  par == 'red' then
      local img = canvas:new("media/qrfb.png")
      local dx,dy = img:attrSize()
      canvas:attrColor(0,0,0,0)
      canvas:clear(grid*32-dx,grid, dx, dy )
      canvas:compose(grid*32-dx, grid, img)
    elseif  par == 'green' then
      local img = canvas:new("media/qrtwitter.png")
      local dx,dy = img:attrSize()
      canvas:attrColor(0,0,0,0)
      canvas:clear(grid*32-dx,grid, dx, dy )
      canvas:compose(grid*32-dx, grid, img)
    elseif  par == 'yellow' then
      local img = canvas:new("media/qrinsta.png")
      local dx,dy = img:attrSize()
      canvas:attrColor(0,0,0,0)
      canvas:clear(grid*32-dx,grid, dx, dy )
      canvas:compose(grid*32-dx, grid, img)
    elseif  par == 'blue' then
      local img = canvas:new("media/qryoutube.png")
      local dx,dy = img:attrSize()
      canvas:attrColor(0,0,0,0)
      canvas:clear(grid*32-dx,grid, dx, dy )
      canvas:compose(grid*32-dx, grid, img)
    end
  end
  canvas:flush()
end
