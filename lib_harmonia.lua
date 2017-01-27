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
    self.pageReset()
    pgmOn = true
  end

  local iconpath=""
  local sumdy=0

  for i=1,self.icons  do
    if i==self.pos then
      iconpath = "media/harmonia/btn" ..  tostring(i) .. "on.png"
    else
      iconpath = "media/harmonia/btn" ..  tostring(i) .. "off.png"
    end
    local icon = canvas:new(iconpath)
    local dx,dy = icon:attrSize()
    canvas:compose(grid, grid*11+sumdy, icon )
    sumdy=sumdy+dy
  end
  self:pageDraw()
  canvas:flush()
end



function harmoniaMenu:pageDraw()
  canvas:attrColor(93,196,179,217)
  canvas:attrColor("blue")
  canvas:clear(grid*7,grid*11, grid*32, grid*18 )

  if self.pos == 1 then
    print ("chegou")
  end
end



function harmoniaMenu:pageReset()
  canvas:attrColor(0,0,0,0)
  canvas:clear(0,0, grid*32, grid*18 )

  canvas:attrColor(93,196,179,217)
  canvas:clear(0,grid*11, grid*32, grid*18 )

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
  canvas:flush()
end
