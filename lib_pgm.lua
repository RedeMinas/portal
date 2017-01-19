local pgmMseOn
local pgmMseVPos
local pgmMseHPos

function pgm(id)
  canvas:attrColor(id*4,id*4,id*4,200)
  canvas:clear(0,0, grid*32, grid*18 )
  local icon = canvas:new("media/" .. string.format("%02d" , id).. ".png")
  canvas:compose(0,0, icon )
  canvas:attrColor("white")
  canvas:attrFont("Vera", 8,"bold")
  canvas:drawText(grid*16, grid*17, "programa: " .. id )
  canvas:flush()
end

--function handler ()
--  if (evt.class == 'key' and evt.type == 'press') then
    --if ((evt.key == "RED") and (pgmMseOn == true) and (pgmOn ~=true))  then
--    end
--  end
--end

--event.register(handler)

