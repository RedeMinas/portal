local aux = 0
local guarda = 1
local guarda_min = 1
local guarda_max = 7
--rever como calcular a partir das imagens do menu
local distancia = 280
local dx, dy = canvas:attrSize()
local menu = {}
local imagem = {}

-- rever
for i=guarda_min,guarda_max do
   menu[i] = {}
end

--menu1 guarda a imagem, posicao inicial e dimensoes

for i=guarda_min,guarda_max do
   --instancia imagens
   menu[i][canvas] = canvas:new( tostring(i) .. 'off.png')
   --  menu[i].caminho2 = canvas:new(i . 'off.png')
   -- calcula posição inicial na tela
   menu[i][dx]=(menu[i][canvas]:attrSize(width)*(i-1))
end

-- Funcao de redesenho:
-- chamada a cada ciclo de animacao
function redraw ()
   -- fundo
   for i=guarda_min,guarda_max do
      canvas:attrColor('black')
      canvas:drawRect('fill', 0, 0, dx, dy )
      -- conferir... se precisa de if
    end
   for i=guarda_min,guarda_max do
	   canvas:compose(menu[i][dx]* 1.05 , menu[i][canvas]:attrSize(height), menu[i][canvas])
      canvas:flush()
   end
end

--function desenha(guarda)
--   for i=guarda_min,guarda_max do
--      if guarda == i then
--	      canvas:attrColor('black')
--	      canvas:drawRect('fill', 0,0, menu[i][dx],menu[i][canvas]:attrSize(height))
--	      canvas:compose(menu[i][dx], menu2[i][canvas]:attrSize(height), menu2[i][canvas])
--	      canvas:flush()
--      end
--   end
--end
redraw()
-- Funcao de tratamento de eventos:
function handler (evt)
   -- a animacao comeca no *start* e eh realimentada por eventos da classe *user*
   if (evt.class == 'key' and evt.type == 'press') then

      if evt.key == "CURSOR_RIGHT" then
	      if guarda > guarda_max  then
            guarda = guarda_min
         end 
         for i=guarda_min,guarda_max do
            menu[i][dx] = menu[i][dx] - (distancia + 1)
            redraw()
	      end
         if guarda < guarda_max then
	         guarda = guarda + 1
	         print(guarda)
         end
      end

--   if evt.key == "ENTER" then
--     print(guarda)
--	    desenha(guarda)
--	    menu2[guarda].p = menu2[guarda].f 
--   end 
      
      else if evt.key == "CURSOR_LEFT" then
	      for i=guarda_min,guarda_max do
	         menu[i][dx] = menu[i][dx] + (distancia + 1)
	         redraw()
         end

	      if guarda < guarda_max then
         guarda = guarda - 1
         print(guarda)
         end
      end
   end
end

event.register(handler)
