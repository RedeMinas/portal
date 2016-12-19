local posicao = 1
local guarda_min = 1
local guarda_max = 18
--rever como calcular a partir das imagens do menu
local distancia = 30
local tamImagem = 180
local dx, dy = canvas:attrSize()

dofile("tbl_pgm.lua")

local aux= {}
local imagem = {}

function criaVetor()
  -- cria vetor primario
  for i=guarda_min,guarda_max do
    menu[i][canvas] = canvas:new('media/pgm/'..tostring(i) .. 'off.png')
    menu[i][dx]=(tamImagem *(i)  )
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
  canvas:attrColor(0,0,0,0)
  canvas:clear()
  canvas:drawRect('fill', 0, 0, dx, dy )

  for i=guarda_min,guarda_max do
    canvas:compose(menu[i][dx] + distancia*(i) ,dy/5,menu[i][canvas])
  end

  icone = canvas:new('media/selecao.png')
--  fundo = canvas:new('media/scrollbgd.png')
--  canvas:compose(dx/1920,dy/5,fundo)

  canvas:flush()

  canvas:compose(dx/2.05,dy/1.40,icone)

  esquerda = canvas:new('media/esquerda.png')
	canvas:compose(dx/100,dy/70,esquerda)
  direita = canvas:new('media/direita.png')
  canvas:compose(dx/1.05,dy/70,direita)
  canvas:flush()
end

function goToFimVetor ()
  for i=1,(guarda_max -5) do
    for j=guarda_min,guarda_max do
      menu[j][dx] = menu[j][dx] - (tamImagem + distancia)
    end
  end
end

function writeText()
  for i=guarda_min,posicao do
    canvas:attrColor(0,0,0,0)
    canvas:clear()
    canvas:drawRect('fill', 0, 0, dx, dy)
    canvas:compose((dx/2 - dy/2)/5,dy/5,menu[posicao+2][canvas])
    canvas:flush()
  end
  acima = canvas:new('media/acima.png')
  canvas:compose(dx/1920,dy/5,acima)
  canvas:attrColor('maroon')
  canvas:attrFont("vera", 22)
  canvas:drawText(dx/2 -dy/1.1, dy/5, menu[posicao]["descricao"])
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
        --print("posicao "..posicao)
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
        end
        desenha()
      else
        if evt.key == "ENTER" then
          writeText()
        end

        if evt.key == "CURSOR_UP" then
          desenha()
        end
      end
    end
  end
end

event.register(handler)
