local pgmMseOn
local pgmMseVPos
local pgmMseHPos

function pgm(id)
  canvas:attrColor(id*4,id*4,id*4,200)
  canvas:clear(0,0, GRID*32, GRID*18 )
  local icon = canvas:new("media/" .. string.format("%02d" , id).. ".png")
  canvas:compose(0,0, icon )
  canvas:attrColor("white")
  canvas:attrFont("Vera", 8,"bold")
  canvas:drawText(GRID*16, GRID*17, "programa: " .. id )
  canvas:flush()
end

--function handler ()
--  if (evt.class == 'key' and evt.type == 'press') then
    --if ((evt.key == "RED") and (pgmMseOn == true) and (PGMON ~=true))  then
--    end
--  end
--end

--event.register(handler)

