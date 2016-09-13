local posicao = 1

local menu  = dofile("tbl_pgm.lua")

local guarda_min = 1
local guarda_max = 18
--rever como calcular a partir das imagens do menu
local distancia = 30
local tamImagem = 180

local dx, dy = canvas:attrSize()
local aux= {}
local imagem = {}

function criaVetor()
   -- cria vetor primario
   for i=guarda_min,guarda_max do
      menu[i][canvas] = canvas:new('midia/menu2/'..tostring(i) .. 'off.png')
      menu[i][dx]=(tamImagem*(i) )
   end
   for i=guarda_min,guarda_max do
      menu[i][dx] = menu[i][dx] - (tamImagem + distancia)
   end
end
criaVetor()

function clonaVetor()
   -- cria vetor auxiliar
   for i=guarda_min,guarda_max do
      aux[i] = {}
      aux[i][dx] = menu[i][dx]
   end
end
clonaVetor()

function restauraVetor()
   -- cria vetor auxiliar
   for i=guarda_min,guarda_max do
      menu[i][dx] = aux[i][dx]
   end
end

function desenha ()
   -- fundo
   canvas:attrColor('transparent')
   canvas:drawRect('fill', 0, 0, dx, dy )

   for i=guarda_min,guarda_max do   
      canvas:compose(menu[i][dx] + distancia*(i) ,dy/2,menu[i][canvas])
   end
   
   icone = canvas:new('midia/selecao.png')
   fundo = canvas:new('midia/transparent2.png')
   --canvas:attrColor('transparent')
   --local tamanhoicone = 30
   -- print(contador)
   -- canvas:drawRect('frame', dx/1.8-(tamanhoicone/2), dy/1.48-(tamanhoicone/2), tamanhoicone, tamanhoicone)
   canvas:compose(dx/1920,dy/2,fundo)

   canvas:flush()
   --canvas:attrColor('transparent')
   --local tamanhoicone = 30
   -- print(contador)
   -- canvas:drawRect('frame', dx/1.8-(tamanhoicone/2), dy/1.48-(tamanhoicone/2), tamanhoicone, tamanhoicone)

   canvas:compose(dx/2.05,dy/1.25,icone)
   canvas:flush()
   
   
   esquerda = canvas:new('midia/esquerda.png')
   canvas:compose(dx/100,dy/3,esquerda)
   canvas:flush()
   direita = canvas:new('midia/direita.png')
   canvas:compose(dx/1.05,dy/3,direita)
   canvas:flush()end

function goToFimVetor ()
   for i=1,(guarda_max -5) do
      for j=guarda_min,guarda_max do
	 menu[j][dx] = menu[j][dx] - (tamImagem + distancia)
      end
   end    
end
function writeText()
   
   for i=guarda_min,posicao do
      canvas:attrColor('black')
      canvas:drawRect('fill', 0, 0, dx, dy )  
      canvas:compose((dx/2 - dy/2)/5,dy/2,menu[posicao+2][canvas])
      canvas:flush()
   end
   
   acima = canvas:new('midia/acima.png')
   canvas:compose(dx/1920,dy/2,acima)

   canvas:attrFont("vera", 22)
   canvas:attrColor('maroon')
   canvas:drawText(dx/2 -dy/1.4, dy/3, menu[posicao]["nome"])
   canvas:attrColor('maroon')
   canvas:drawText(dx/2 -dy/1.1, dy/2, menu[posicao]["descricao"])
   canvas:flush()
end
--desenha interface ao abrir
desenha()

function handler (evt)
   if (evt.class == 'key' and evt.type == 'press') then      
      if evt.key == "CURSOR_RIGHT" then
	 if posicao >= (guarda_max-4) then
	    posicao = guarda_min            
	    restauraVetor()
	 else
	    for i=guarda_min,guarda_max do
	       menu[i][dx] = menu[i][dx] - (tamImagem + distancia)
	    end
	    posicao = posicao + 1
	    print("posicao "..posicao)
	 end          
	 desenha()
	 
      else
	 if evt.key == "CURSOR_LEFT" then
	    if posicao <= (guarda_min) then
	       posicao = guarda_max -4
	       restauraVetor()
	       goToFimVetor()                
	    else
	       for i=guarda_min,guarda_max do
                  menu[i][dx] = menu[i][dx] + (tamImagem + distancia )
                  canvas:flush()
	       end

	       posicao = posicao - 1
	       print("posicao "..posicao)
	    end              
	    desenha()
	   
	 else
	    if evt.key == "ENTER" then
	       print ("pressionou enter, valor guarda:" .. tostring(posicao))
	       writeText() 
            end
	    
            if evt.key == "CURSOR_UP" then
	       print ("pressionou up, valor guarda:" .. tostring(posicao))
	       desenha()
            end
            

	 end          
      end
   end
end

event.register(handler)
