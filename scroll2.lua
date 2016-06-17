--  LICENSE: LGPL
--  Filename        : scroll.lua
--  Description     : rotaciona itens em menu
-- 

local posicao = 1
local guarda_min = 1
local guarda_max = 14
--rever como calcular a partir das imagens do menu
local distancia = 30
local dx, dy = canvas:attrSize()
local menu = {}
local imagem = {}

-- inicialização
-- rever - melhor usar objetos

for i=guarda_min,guarda_max do
   menu[i] = {}
   --instancia imagens
   menu[i][canvas] = canvas:new( 'midia/' .. tostring(i) .. 'off.png')
   -- calcula posição inicial na tela
   menu[i][dx]=(menu[i][canvas]:attrSize(width)*(i) )
end

-- Funcao de redesenho: chamada a cada ciclo de animacao
-- reescrever para centralizar...
function redraw ()
   -- fundo
   canvas:attrColor('black')
   canvas:drawRect('fill', 0, 0, dx, dy )
   print ("posicao: " .. posicao)
   for i=guarda_min,guarda_max do

      print (menu[i][dx])
      
--      canvas:compose(menu[i][dx] +  distancia*(i) ,
--		     menu[i][canvas]:attrSize(height)  ,
      --		     menu[i][canvas])

      canvas:compose(menu[i][dx] + distancia*(i) ,
		     menu[i][canvas]:attrSize(height)  ,
		     menu[i][canvas])
   end
   
   canvas:attrColor('red')
   local tamanhoicone = 30
   canvas:drawRect('fill', dx/2-tamanhoicone/2, dy/2-tamanhoicone/2, tamanhoicone, tamanhoicone)
   
   canvas:flush()
end

-- Funcao de tratamento de eventos:

function handler (evt)
   if (evt.class == 'key' and evt.type == 'press') then
      if evt.key == "CURSOR_RIGHT" then
	 if posicao == guarda_max then
	    posicao = guarda_min
	 else
	    posicao = posicao + 1
	 end

	 for i=guarda_min,guarda_max do
	    menu[i][dx] = menu[i][dx] - (menu[i][canvas]:attrSize(width)  )
	 end

      else if evt.key == "CURSOR_LEFT" then
	    if posicao == guarda_min then
	       posicao = guarda_max	 
	    else
	       posicao = posicao - 1
	    end
	    
	    for i=guarda_min,guarda_max do
	       menu[i][dx] = menu[i][dx] + (menu[i][canvas]:attrSize(width) )
	    end
	    
	   end
      end
   else if evt.key == "ENTER" then
	 print ( "pressionou enter, valor guarda:" .. tostring(posicao))
	end
      redraw()      
   end --  if
end -- handler
event.register(handler)
