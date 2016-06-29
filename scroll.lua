local posicao = 1
local guarda_min = 1
local guarda_max = 14
--rever como calcular a partir das imagens do menu
local distancia = 30
local espacamento = 144.22
local enter = false
local dx, dy = canvas:attrSize()
local menu = {}
local imagem = {}

-- inicialização
-- rever - melhor usar objetos

for i=guarda_min,guarda_max do
   menu[i] = {}
   --instancia imagens
  -- menu[i][canvas] = canvas:new( 'midia/' .. tostring(i) .. 'off.png')
  menu[i][canvas] = canvas:new(tostring(i) .. 'off.png')
   -- calcula posição inicial na tela
   menu[i][dx]=(menu[i][canvas]:attrSize(width)*(i) )

end

-- Funcao de redesenho: chamada a cada ciclo de animacao
-- reescrever para centralizar...
function redraw ()
   -- fundo
   canvas:attrColor('black')
   canvas:drawRect('fill', 0, 0, dx, dy )

   for i=guarda_min,guarda_max do

      canvas:compose(menu[i][dx] + distancia*(i) ,menu[i][canvas]:attrSize(height),menu[i][canvas])
      canvas:compose(menu[i][dx] + distancia*(i-espacamento) ,menu[i][canvas]:attrSize(height),menu[i][canvas])
      canvas:compose(menu[i][dx] + distancia*(i+espacamento) ,menu[i][canvas]:attrSize(height),menu[i][canvas])
      canvas:compose(menu[i][dx] + distancia*(i-(espacamento*2)) ,menu[i][canvas]:attrSize(height),menu[i][canvas])
      canvas:compose(menu[i][dx] + distancia*(i+(espacamento*2)) ,menu[i][canvas]:attrSize(height),menu[i][canvas])
      canvas:compose(menu[i][dx] + distancia*(i-(espacamento*3)) ,menu[i][canvas]:attrSize(height),menu[i][canvas])
      canvas:compose(menu[i][dx] + distancia*(i+(espacamento*3)) ,menu[i][canvas]:attrSize(height),menu[i][canvas])
      canvas:compose(menu[i][dx] + distancia*(i-(espacamento*4)) ,menu[i][canvas]:attrSize(height),menu[i][canvas])
      canvas:compose(menu[i][dx] + distancia*(i+(espacamento*4)) ,menu[i][canvas]:attrSize(height),menu[i][canvas])
      canvas:compose(menu[i][dx] + distancia*(i-(espacamento*5)) ,menu[i][canvas]:attrSize(height),menu[i][canvas])
      canvas:compose(menu[i][dx] + distancia*(i+(espacamento*5)) ,menu[i][canvas]:attrSize(height),menu[i][canvas])
      canvas:compose(menu[i][dx] + distancia*(i-(espacamento*6)) ,menu[i][canvas]:attrSize(height),menu[i][canvas])
      canvas:compose(menu[i][dx] + distancia*(i+(espacamento*6)) ,menu[i][canvas]:attrSize(height),menu[i][canvas])
      canvas:compose(menu[i][dx] + distancia*(i-(espacamento*7)) ,menu[i][canvas]:attrSize(height),menu[i][canvas])
      canvas:compose(menu[i][dx] + distancia*(i+(espacamento*7)) ,menu[i][canvas]:attrSize(height),menu[i][canvas])
      canvas:compose(menu[i][dx] + distancia*(i-(espacamento*8)) ,menu[i][canvas]:attrSize(height),menu[i][canvas])
      canvas:compose(menu[i][dx] + distancia*(i+(espacamento*8)) ,menu[i][canvas]:attrSize(height),menu[i][canvas])
      canvas:compose(menu[i][dx] + distancia*(i-(espacamento*9)) ,menu[i][canvas]:attrSize(height),menu[i][canvas])
      canvas:compose(menu[i][dx] + distancia*(i+(espacamento*9)) ,menu[i][canvas]:attrSize(height),menu[i][canvas])
      canvas:compose(menu[i][dx] + distancia*(i-(espacamento*10)) ,menu[i][canvas]:attrSize(height),menu[i][canvas])
      canvas:compose(menu[i][dx] + distancia*(i+(espacamento*10)) ,menu[i][canvas]:attrSize(height),menu[i][canvas])
   end
   icone = canvas:new('selecao.png')
   --canvas:attrColor('transparent')
   --local tamanhoicone = 30
  -- print(contador)
  -- canvas:drawRect('frame', dx/1.8-(tamanhoicone/2), dy/1.48-(tamanhoicone/2), tamanhoicone, tamanhoicone)
    canvas:compose(dx/1.85,dy/1.55,icone)
   canvas:flush()
   if enter == true then

      print("f")
   end
end

-- Funcao de tratamento de eventos:

function handler (evt)
   if (evt.class == 'key' and evt.type == 'press') then
      
      if evt.key == "CURSOR_RIGHT" then
    if posicao == guarda_max then
       posicao = guarda_min
    else
       posicao = posicao + 1
       print("direita"..posicao)
    end

    for i=guarda_min,guarda_max do
       menu[i][dx] = menu[i][dx] - (menu[i][canvas]:attrSize(width) + distancia)
    end

      else if evt.key == "CURSOR_LEFT" then
       if posicao == guarda_min then
          posicao = guarda_max    
       else
          posicao = posicao - 1
           print("esquerda"..posicao)
       end
       
       for i=guarda_min,guarda_max do
          menu[i][dx] = menu[i][dx] + (menu[i][canvas]:attrSize(width) + distancia )
          canvas:flush()
       end
       
      end
      end
   else if evt.key == "ENTER" then
    print ( "pressionou enter, valor guarda:" .. tostring(posicao))
    enter = true
   end
   enter = false
      redraw()      
   end --  if
end -- handler
event.register(handler)