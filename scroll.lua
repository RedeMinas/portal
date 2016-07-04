local posicao = 1
local guarda_min = 1
local guarda_max = 18
--rever como calcular a partir das imagens do menu
local distancia = 30
local espacamento = 144.22/2
local dx, dy = canvas:attrSize()
local menu= {}
local aux= {}
local imagem = {}

function criaVetor()
    -- cria vetor primario
    for i=guarda_min,guarda_max do
      menu[i] = {}
      menu[i][canvas] = canvas:new('midia/menu2/'..tostring(i) .. 'off.png')
      menu[i][dx]=(menu[i][canvas]:attrSize(width)*(i) )
    end
    for i=guarda_min,guarda_max do
        menu[i][dx] = menu[i][dx] - (menu[i][canvas]:attrSize(width) + distancia)
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
  canvas:attrColor('black')
  canvas:drawRect('fill', 0, 0, dx, dy )

  for i=guarda_min,guarda_max do   
    canvas:compose(menu[i][dx] + distancia*(i) ,menu[i][canvas]:attrSize(height),menu[i][canvas])
  end
  
  icone = canvas:new('midia/selecao.png')
   fundo = canvas:new('midia/transparent.png')
   --canvas:attrColor('transparent')
   --local tamanhoicone = 30
  -- print(contador)
  -- canvas:drawRect('frame', dx/1.8-(tamanhoicone/2), dy/1.48-(tamanhoicone/2), tamanhoicone, tamanhoicone)
    canvas:compose(dx/1920,275,fundo)
    print(dx/1920)
     canvas:flush()
   --canvas:attrColor('transparent')
   --local tamanhoicone = 30
  -- print(contador)
  -- canvas:drawRect('frame', dx/1.8-(tamanhoicone/2), dy/1.48-(tamanhoicone/2), tamanhoicone, tamanhoicone)

    canvas:compose(dx/2.05,dy/1.25,icone)
   canvas:flush()
      
 
         esquerda = canvas:new('midia/esquerda.png')
            canvas:compose(0,240,esquerda)
            canvas:flush()
             direita = canvas:new('midia/direita.png')
            canvas:compose(1475,240,direita)
            canvas:flush()end

function goToFimVetor ()
    for i=1,(guarda_max -5) do
        for j=guarda_min,guarda_max do
            menu[j][dx] = menu[j][dx] - (menu[j][canvas]:attrSize(width) + distancia)
        end
    end    
end
function writeText()
  
  for i=guarda_min,posicao do
        canvas:attrColor('black')
        canvas:drawRect('fill', 0, 0, dx, dy )  
        canvas:compose((dx/2 - dy/2)/5,dy/1.7,menu[posicao+2][canvas])
        canvas:flush()
    end
         acima = canvas:new('midia/acima.png')
         canvas:compose(dx/1920,dy/1.5,acima)
         canvas:flush()

   if posicao == 1 then
      canvas:attrColor('maroon')
      canvas:attrFont("vera", 22)
      canvas:drawText(dx/2 -dy/1.4, dy/1.55, "Uma revista eletrônica cultural sobre teatro, cinema, artes plásticas,\nliteratura e outras manifestações artísticas de forma aprofundada e \ncom um apurado cuiado estético e crítico.")
      canvas:flush()
   end

   if posicao == 2 then
      canvas:attrColor('maroon')
      canvas:attrFont("vera", 22)
      canvas:drawText(dx/2 -dy/1.4, dy/1.55, "Uma revista eletrônica dedicada à musica pop e suas vertentes.Traz a \nhistória, das grandes bandas de rock, divulga artistas independentes, \ndestaca os lançamentos, fala tudo sobre instrumentos musicais e conta \nainda com entrevistas.")
      canvas:flush()
   end

   if posicao == 3 then
      canvas:attrColor('maroon')
      canvas:attrFont("vera", 22)
      canvas:drawText(dx/2 -dy/1.4, dy/1.55, "O Arrumação abre espaço para diversas manifestações culturais como \na música, a dança, o teatro, a poesia, o folclore, as tradições, a \nnotícia boa e o bom-humor, apresentando os valores mais autênticos da \ncultura brasileira.")
      canvas:flush()
   end

   if posicao == 4 then
      canvas:attrColor('maroon')
      canvas:attrFont("vera", 22)
      canvas:drawText(dx/2 -dy/1.4, dy/1.55, "O Brasil das Gerais trata de temas como patrimônio cultural, tecnologia \nsocial e saúde. É sobre pessoas e sobre histórias de nossa Minas Gerais.")
      canvas:flush()
   end

   if posicao == 5 then
      canvas:attrColor('maroon')
      canvas:attrFont("vera", 22)
      canvas:drawText(dx/2 -dy/1.4, dy/1.55, "As aventuras dos bonecos Sdruvs, Judoca, Druzila e seus amigos, que \nvivenciam situações inusitadas, lúdicas e, por vezes, absurdas. ")
      canvas:flush()
   end

   if posicao == 6 then
      canvas:attrColor('maroon')
      canvas:attrFont("vera", 22)
      canvas:drawText(dx/2 -dy/1.4, dy/1.55, "O programa traz reportagens, matérias e documentários com o objetivo \nde divulgar a música clássica de forma atraente.")
      canvas:flush()
   end

   if posicao == 7 then
      canvas:attrColor('maroon')
      canvas:attrFont("vera", 22)
      canvas:drawText(dx/2 -dy/1.4, dy/1.55, "Magazine musical que exibe reportagens e entrevistas com grandes \nnomes do universo da música brasileira e internacional, combinando \nconteúdo informativo, opinativo, making offs e depoimentos de artistas \ne críticos.")
      canvas:flush()
   end

   if posicao == 8 then
      canvas:attrColor('maroon')
      canvas:attrFont("vera", 22)
      canvas:drawText(dx/2 -dy/1.4, dy/1.55, "A atração faz uma viagem pelo mundo dos livros e o universo que se \nabre a partir da palavra escrita, falada e cantada.")
      canvas:flush()
   end

 if posicao == 9 then
      canvas:attrColor('maroon')
      canvas:attrFont("vera", 22)
      canvas:drawText(dx/2 -dy/1.4, dy/1.55, "Telejornal que leva aos mineiros as notícias de Minas e dá dicas de \nsaúde, educação, cultura e esporte. O programa traz entrevistas ao vivo, \nopinião de especialistas e reportagens especiais")
      canvas:flush()
   end

   if posicao == 10 then
      canvas:attrColor('maroon')
      canvas:attrFont("vera", 22)
      canvas:drawText(dx/2 -dy/1.4, dy/1.55, "A notícia do futebol mineiro logo depois da rodada do fim de semana. \nMatérias especiais, compactos dos jogos, gols e os destaques do\n esporte no Brasil e no mundo. Informação com a participação de \nconvidados especiais e muito bom humor.")
      canvas:flush()
   end

   if posicao == 11 then
      canvas:attrColor('maroon')
      canvas:attrFont("vera", 22)
      canvas:drawText(dx/2 -dy/1.4, dy/1.55, "Mulhere-se é um programa construído de forma colaborativa que \npretende abordar a pluralidade do ser mulher e dar visibilidade às \nquestões e à construção social das imagens e do papel das mulheres.")
      canvas:flush()
   end

   if posicao == 12 then
      canvas:attrColor('maroon')
      canvas:attrFont("vera", 22)
      canvas:drawText(dx/2 -dy/1.4, dy/1.55, "O Rede Mídia é um programa de debate que analisa e discute o papel da \n mídia nos dias de hoje, reafirmando o conceito da TV colaborativa.")
      canvas:flush()
   end

   if posicao == 13 then
      canvas:attrColor('maroon')
      canvas:attrFont("vera", 22)
      canvas:drawText(dx/2 -dy/1.4, dy/1.55, "O Sou 60 busca abordar o envelhecimento de forma aberta e corajosa, \ncom seriedade e otimismo, discutindo temas como cidadania, saúde, \nsexualidade, comportamento, tecnologia, mercado de trabalho, viagem \ne exemplos inspiradores.")
      canvas:flush()
   end

   if posicao == 14 then
      canvas:attrColor('maroon')
      canvas:attrFont("vera", 22)
      canvas:drawText(dx/2 -dy/1.4, dy/1.55, "Programa dedicado à exibição de videoclipes. Exibe um panorama da \nmúsica pop atual e suas novas tendências, e revisita grandes bandas e \nartistas da história da música.")
      canvas:flush()
   end
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
                  menu[i][dx] = menu[i][dx] - (menu[i][canvas]:attrSize(width) + distancia)
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
                  menu[i][dx] = menu[i][dx] + (menu[i][canvas]:attrSize(width) + distancia )
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
            if evt.key == "BACK" then
            error("FIM")
            end

        end          
      end
  end
end

event.register(handler)