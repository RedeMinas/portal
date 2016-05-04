<?xml version="1.0" encoding="UTF-8"?>
<ncl id="rede-minas textncl" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
     <!--
        Serie Rede-Minas
        Date: 27/04/2016
        Author: Bernardo Monteiro 
        Organization: Rede Minas
     -->

    <head>
        <regionBase>
        	
            <region id="rgVideo"                width="100%"        height="100%"                                  zIndex="2"/>
            <region id="rgIcone"                width="11.4%"       height="9.2%"       top="10%"    left="9.97%"  zIndex="2"/>
            <region id="rgIconetest"            width="11.4%"       height="3.5%"       top="10%"    left="9.97%"  zIndex="3"/>
            <region id="rgSair"                 width="2.29%"       height="4.63%"      top="90%"    left="82%"    zIndex="5"/>
            <region id="rgVoltar"               width="2.29%"       height="4.63%"      top="72%"    left="79%"    zIndex="5"/>
            <region id="rgEsquerda"             width="2.08%"       height="2.78%"      top="82%"    left="9.5%"   zIndex="5"/>
            <region id="rgDireita"              width="2.08%"       height="2.78%"      top="82%"    left="88%"    zIndex="5"/>
            <region id="rgOk"                   width="2.29%"       height="4.63%"      top="72%"    left="76%"    zIndex="5"/>
            <!-- CONTEÚDO DOS BOTÕES -->
            <region id="rgconteudoBtn01"        width="59.9%"       height="15.84%"     top="77%"    left="12.5%"  zIndex="5"/>
            <region id="rgconteudoBtn02foto1"   width="14.53%"      height="13.61%"     top="78%"    left="12.5%"  zIndex="5"/>
            <region id="rgconteudoBtn02foto2"   width="14.53%"      height="13.61%"     top="78%"    left="27.5%"  zIndex="5"/>
            <region id="rgconteudoBtn02foto3"   width="14.53%"      height="13.61%"     top="78%"    left="42.5%"  zIndex="5"/>
            <region id="rgconteudoBtn02foto4"   width="14.53%"      height="13.61%"     top="78%"    left="57.5%"  zIndex="5"/>
            <region id="rgconteudoBtn02foto5"   width="14.53%"      height="13.61%"     top="78%"    left="72.5%"  zIndex="5"/>
            <region id="rgconteudoBtn02foto6"   width="14.53%"      height="13.61%"     top="78%"    left="12.5%"  zIndex="5"/>
            <region id="rgconteudoBtn02foto7"   width="14.53%"      height="13.61%"     top="78%"    left="27.5%"  zIndex="5"/>
            <region id="rgconteudoBtn03"        width="74.94%"      height="11.67%"     top="78%"    left="12.5%"  zIndex="5"/>
            <!-- BOTÕES -->
            <region id="rgBtn1"                 width="13.80%"      height="3.18%"      top="90%"    left="12.5%"   zIndex="5"/>
            <region id="rgBtn1on"               width="13.80%"      height="3.18%"      top="90%"    left="12.5%"   zIndex="5"/>
            <region id="rgBtn2"                 width="10.93%"      height="3.18%"      top="90%"    left="27.5%"   zIndex="5"/>
            <region id="rgBtn3"                 width="10.93%"      height="3.18%"      top="90%"    left="38.5%"   zIndex="5"/>
            <!-- IMAGEM DE FUNDO-->
            <region id="rgFundo"                width="100%"        height="10%"     top="90%"                     zIndex="4"/>
            <region id="rgFundo2"               width="100%"        height="10%"     top="90%"                     zIndex="4"/>
            <region id="rgFundo3"               width="100%"        height="10%"     top="90%"                     zIndex="4"/>
            <region id="rgFundo4"               width="100%"        height="1%"      top="96.8%"                   zIndex="4"/>
            
        </regionBase>

        <descriptorBase>
        	  
            <descriptor id="deVideo"                region="rgVideo"/>   
            <descriptor id="deFundo"                region="rgFundo"> 
            <descriptorParam name="transparency"     value="0.010"/>    
            </descriptor>      
            <descriptor id="deFundo2"               region="rgFundo2">
            <descriptorParam name="transparency"     value="0.010"/>    
            </descriptor>           
            <descriptor id="deFundo3"               region="rgFundo3">  
                <descriptorParam name="transparency" value="0.010"/>    
            </descriptor>
            <descriptor id="debtnOk"                    region="rgOk"/> 
            <descriptor id="deFundo4"               region="rgFundo4"> 
                <descriptorParam name="transparency" value="0.010"/>    
            </descriptor>
            <descriptor id="deVoltar"               region="rgVoltar"/>             
            <descriptor id="deIcone"                region="rgIcone"/> 
            <descriptor id="deIconetest"            region="rgIconetest"/>
            <descriptor id="deSair"                 region="rgSair"/>
            <descriptor id="deconteudoBtn01"        region="rgconteudoBtn01"/>
            <descriptor id="deconteudoBtn02foto1"        region="rgconteudoBtn02foto1" focusIndex="4" focusSrc="media/1on.png" moveLeft="8" moveRight="5" moveUp="2"/>
            <descriptor id="deconteudoBtn02foto2"        region="rgconteudoBtn02foto2" focusIndex="5" focusSrc="media/2on.png" moveLeft="4" moveRight="6" moveUp="2"/>
            <descriptor id="deconteudoBtn02foto3"        region="rgconteudoBtn02foto3" focusIndex="6" focusSrc="media/3on.png" moveLeft="5" moveRight="7" moveUp="2"/>
            <descriptor id="deconteudoBtn02foto4"        region="rgconteudoBtn02foto4" focusIndex="7" focusSrc="media/4on.png"
            moveLeft="6" moveRight="8" moveUp="2"/>
            <descriptor id="deconteudoBtn02foto5"        region="rgconteudoBtn02foto5" focusIndex="8" focusSrc="media/5on.png"
            moveLeft="7" moveRight="11" moveUp="2"/>    
            <descriptor id="deconteudoBtn02foto6"        region="rgconteudoBtn02foto6" focusIndex="9" focusSrc="media/6on.png"
            moveLeft="8" moveRight="10" moveUp="2"/>
            <descriptor id="deconteudoBtn02foto7"        region="rgconteudoBtn02foto7" focusIndex="10" focusSrc="media/7on.png"
            moveLeft="9" moveRight="1" moveUp="2"/>       
            <descriptor id="deconteudoBtn03"        region="rgconteudoBtn03"/>
            <descriptor id="deBtn1on"                 region="rgBtn1on"/>

            <descriptor id="deBtn1"                 region="rgBtn1" focusIndex="1"
             focusSrc="media/btn1on.png" moveLeft="3" moveRight="2"/>


            <descriptor id="deBtn2"                 region="rgBtn2"  focusIndex="2" 
                focusSrc="media/btn2on.png" moveLeft="1" moveRight="3" moveDown="4"/>

            <descriptor id="deBtn3"                 region="rgBtn3" focusIndex="3" 
                focusSrc="media/btn3on.png" moveLeft="2" moveRight="1"/>

            <descriptor id="deEsquerda"             region="rgEsquerda"/>
            <descriptor id="deDireita"              region="rgDireita" focusIndex="11" moveRight="9"/>
       
        </descriptorBase>

        <!-- BIBLIOTECA DOS CONECTORES -->
        <connectorBase>
            <importBase documentURI="connector.ncl" alias="conBase"/>
        </connectorBase>
    </head>

    <body>

        <port id="pMediaInitialPort" component="Video"/>
        

        <!-- Extra -->
       
		<media id="Video"      src="midia/video.mp4"              descriptor="deVideo"/>
			
 <!-- VIDEO MP4 
        <media id="Video" src="sbtvd-ts://video" descriptor="deFullScreenMedia">
            <area id="icon" begin="2s"/>
            <property name="bounds"/>
            <property name="zIndex" value="3"/>
        </media>
 -->
           
        
        <media id="icone"           src="midia/icon3.png"    descriptor="deIcone"><property name="top"/></media>
        <media id="iconetest"       src="midia/icon.png"     descriptor="deIconetest"/>
        <media id="voltar"          src="midia/voltar.png"   descriptor="deVoltar"/>
        
        <!-- BOTOES (TEXTO NCL) -->
        <media id="btn1" src="media/btn1off.png" descriptor="deBtn1"><property name="top"/><area id="conteudo" begin="0.8s"/></media>
        <media id="btn1on" src="media/btn1on.png" descriptor="deBtn1"><property name="top"/>
        </media>
        <media id="btn2" src="media/btn2off.png"             descriptor="deBtn2">  <property name="top"/> </media>  
        <media id="btn3" src="media/btn3off.png"             descriptor="deBtn3"><property name="top"/></media>
        <media id="esquerda" src="midia/esquerda.png"      descriptor="deEsquerda"/>
        <media id="direita" src="midia/direita.png"        descriptor="deDireita"/>
        <media id="baixo" src="midia/baixo.png"            descriptor="deEsquerda"/>
        <media id="btnOk"     src="midia/ok.png"           descriptor="debtnOk"/>
        <media id="sair" src="midia/sair.png" descriptor="deSair"><property name="top"/></media>
        
        <!-- FIM DOS BOTOES (TEXTO NCL) -->
        <media id="conteudo1"      src="midia/conteudo1.png" descriptor="deconteudoBtn01"/>
        <media id="conteudo3"      src="midia/contato.png" descriptor="deconteudoBtn03"/>
        <media id="conteudo2Menu1" src="media/1off.png"   descriptor="deconteudoBtn02foto1"/>
        <media id="conteudo2Menu2" src="media/2off.png"   descriptor="deconteudoBtn02foto2"/>
        <media id="conteudo2Menu3" src="media/3off.png"   descriptor="deconteudoBtn02foto3"/>
        <media id="conteudo2Menu4" src="media/4off.png"   descriptor="deconteudoBtn02foto4"/>
        <media id="conteudo2Menu5" src="media/5off.png"   descriptor="deconteudoBtn02foto5"/>
        <media id="conteudo2Menu6" src="media/6off.png"   descriptor="deconteudoBtn02foto6"/>
        <media id="conteudo2Menu7" src="media/7off.png"   descriptor="deconteudoBtn02foto7"/>
    

       
         <!-- FUNDO -->
         <media id="fundo"  src="midia/fundo2.png" descriptor="deFundo"><property name="top"/>
        </media>
        <media id="fundo2"  src="midia/fundo3.png" descriptor="deFundo2"><property name="top"/>
        </media>
        <media id="fundo3"  src="midia/fundo3.png" descriptor="deFundo3"><property name="top"/>
        </media>
        <media id="fundo4"  src="midia/fundo3.png" descriptor="deFundo4"/>
        
      
        
        <!-- FIM FUNDO -->


         <media id="settings" type="application/x-ginga-settings">
            <property name="service.currentKeyMaster" value=""/>
        </media>
        <!-- INÍCIO DO PROGRAMA -->
        <link id="link_onBeginVideo"  xconnector="conBase#onBeginStart">
            <bind role="onBegin"   component="Video" />
            <bind role="start"     component="iconetest"/>
            <bind role="start"     component="icone"/>
        </link>

         <!-- QUANDO O ÍCONE FOR SELECIONADO... -->
        <link id="link_icon" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="icone" >
                <bindParam name="keyCode" value="ENTER"/>
            </bind>
            <bind role="stop"      component="icone"/>
            
            <bind role="start"     component="btn1"/>
            <bind role="start"     component="btn2"/>
            <bind role="start"     component="btn3"/>
            <bind role="start"     component="sair"/>
            <bind role="start"     component="fundo"/>
            <bind role="start"     component="fundo2"/>
            <bind role="start"     component="fundo3"/>
            <bind role="start"     component="fundo4"/>
        </link>
     

        <!-- ANIMAÇÃO DO ÍCONE -->
        <link id="Animação_Icone" xconnector="conBase#onBeginIconMenuSetAnim">
            <bind role="onBegin" component="icone"/>
            <bind role="set" component="icone" interface="top">
                <bindParam name="vBy" value="0"/>
                <bindParam name="vDuration" value="1s"/>
                <bindParam name="newValue" value="13.5%"/>

            </bind>
        </link>

        <link id="Animação_Icone_Fim" xconnector="conBase#onEndIconMenuSetAnim">
            <bind role="onEnd" component="icone"/>
            <bind role="set" component="icone" interface="top">
                <bindParam name="vBy" value="0"/>
                <bindParam name="vDuration" value="0"/>
                <bindParam name="newValue" value="10%"/>
            </bind>
        </link>
        <!-- FIM DA ANIMAÇÃO DO ÍCONE -->


        <!-- ANIMAÇÃO DOS BOTÕES -->
        <link id="Animação_Btn1onn" xconnector="conBase#onBeginIconMenuSetAnim">
            <bind role="onBegin" component="fundo"/>
            <bind role="set" component="btn1on" interface="top">
                <bindParam name="vBy" value="0"/>
                <bindParam name="vDuration" value="0.5s"/>
                <bindParam name="newValue" value="72%"/>
            </bind>
        </link>

        <link id="Animação_Btn1onn_Fim" xconnector="conBase#onEndIconMenuSetAnim">
            <bind role="onEnd" component="fundo"/>
            <bind role="set" component="btn1on" interface="top" >
                <bindParam name="vBy" value="0"/>
                <bindParam name="vDuration" value="0"/>
                <bindParam name="newValue" value="90%"/>
            </bind>
        </link>

        <link id="Animação_Btn1" xconnector="conBase#onBeginIconMenuSetAnim">
            <bind role="onBegin" component="fundo"/>
            <bind role="set" component="btn1" interface="top">
                <bindParam name="vBy" value="0"/>
                <bindParam name="vDuration" value="0.5s"/>
                <bindParam name="newValue" value="72%"/>
            </bind>
        </link>

        <link id="Animação_Btn1_Fim" xconnector="conBase#onEndIconMenuSetAnim">
            <bind role="onEnd" component="fundo"/>
            <bind role="set" component="btn1" interface="top" >
                <bindParam name="vBy" value="0"/>
                <bindParam name="vDuration" value="0"/>
                <bindParam name="newValue" value="90%"/>
            </bind>
        </link>

        <link id="Animação_Btn2" xconnector="conBase#onBeginIconMenuSetAnim">
            <bind role="onBegin" component="fundo"/>
            <bind role="set" component="btn2" interface="top">
                <bindParam name="vBy" value="0"/>
                <bindParam name="vDuration" value="0.5s"/>
                <bindParam name="newValue" value="72%"/>
            </bind>
        </link>

        <link id="Animação_Btn2_Fim" xconnector="conBase#onEndIconMenuSetAnim">
            <bind role="onEnd" component="fundo"/>
            <bind role="set" component="btn2" interface="top" >
                <bindParam name="vBy" value="0"/>
                <bindParam name="vDuration" value="0"/>
                <bindParam name="newValue" value="90%"/>
            </bind>
        </link>

        <link id="Animação_Btn3" xconnector="conBase#onBeginIconMenuSetAnim">
            <bind role="onBegin" component="fundo"/>
            <bind role="set" component="btn3" interface="top">
                <bindParam name="vBy" value="0"/>
                <bindParam name="vDuration" value="0.5s"/>
                <bindParam name="newValue" value="72%"/>
            </bind>
        </link>

        <link id="Animação_Btn3_Fim" xconnector="conBase#onEndIconMenuSetAnim">
            <bind role="onEnd" component="fundo"/>
            <bind role="set" component="btn3" interface="top" >
                <bindParam name="vBy" value="0"/>
                <bindParam name="vDuration" value="0"/>
                <bindParam name="newValue" value="90%"/>
            </bind>
        </link>

    

        
        <link id="Animação_SAIR" xconnector="conBase#onBeginIconMenuSetAnim">
            <bind role="onBegin" component="sair"/>
            <bind role="set" component="sair" interface="top">
                <bindParam name="vBy" value="0"/>
                <bindParam name="vDuration" value="0.5s"/>
                <bindParam name="newValue" value="72%"/>
            </bind>
        </link>

        <link id="Animação_SAIR_Fim" xconnector="conBase#onEndIconMenuSetAnim">
            <bind role="onEnd" component="sair"/>
            <bind role="set" component="sair" interface="top" >
                <bindParam name="vBy" value="0"/>
                <bindParam name="vDuration" value="0"/>
                <bindParam name="newValue" value="90%"/>
            </bind>
        </link>

        <!-- FIM DA ANIMAÇÃO DOS BOTÕES -->


        <!-- LINKS ANIMAÇÃO FUNDO -->
        
        <link id="Animação_Fundo_Inicio" xconnector="conBase#onBeginIconMenuSetAnim">
            <bind role="onBegin" component="fundo"/>
            <bind role="set" component="fundo" interface="top">
                <bindParam name="vBy" value=""/>
                <bindParam name="vDuration" value="0.5s"/>
                <bindParam name="newValue" value="67.88%"/>
            </bind>
            
        </link>

        <link id="Animação_Fundo_FimStop" xconnector="conBase#onEndIconMenuSetAnim">
            <bind role="onEnd" component="fundo4"/>
            <bind role="set" component="fundo" interface="top" >
                <bindParam name="vBy" value="0"/>
                <bindParam name="vDuration" value="0"/>
                <bindParam name="newValue" value="90%"/>
            </bind>
            
        
        </link>

         <link id="Animação_Fundo2_Inicio" xconnector="conBase#onBeginIconMenuSetAnim">
            <bind role="onBegin" component="fundo2"/>
            <bind role="set" component="fundo2" interface="top">
                <bindParam name="vBy" value=""/>
                <bindParam name="vDuration" value="0.5s"/>
                <bindParam name="newValue" value="87.4%"/>
            </bind>
        </link>

        <link id="Animação_Fundo2_Fim" xconnector="conBase#onEndIconMenuSetAnim">
            <bind role="onEnd" component="fundo4"/>
            <bind role="set" component="fundo2" interface="top" >
                <bindParam name="vBy" value="0"/>
                <bindParam name="vDuration" value="0"/>
                <bindParam name="newValue" value="90%"/>
            </bind>
        </link>

        <link id="Animação_Fundo3_Inicio" xconnector="conBase#onBeginIconMenuSetAnim">
            <bind role="onBegin" component="fundo3" />
            <bind role="set" component="fundo3" interface="top" >
                <bindParam name="vBy" value="0"/>
                <bindParam name="vDuration" value="0.5s"/>
                <bindParam name="newValue" value="77.9%"/>
            </bind>
        </link>

        <link id="Animação_Fundo3_Fim" xconnector="conBase#onEndIconMenuSetAnim">
            <bind role="onEnd" component="fundo4"/>
            <bind role="set" component="fundo3" interface="top" >
                <bindParam name="vBy" value="0"/>
                <bindParam name="vDuration" value="0"/>
                <bindParam name="newValue" value="90%"/>
            </bind>
        </link>

         
        <!-- FIM DA ANIMAÇÃO DO FUNDO -->

    

        <!-- LINKS PARA BOTÕES -->
        <link id="link_btn1" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection"  component="btn1" >   
            </bind>
            <bind role="start"    component="conteudo1"/>
            <bind role="stop"    component="conteudo3"/>
            <bind role="stop"     component="esquerda"/>
            <bind role="stop"     component="direita"/>
            <bind role="stop"     component="baixo"/>
            <bind role="stop"     component="btnOk"/>
            <bind role="stop"    component="conteudo2Menu1"/>
            <bind role="stop"    component="conteudo2Menu2"/>
            <bind role="stop"    component="conteudo2Menu3"/>
            <bind role="stop"    component="conteudo2Menu4"/>
            <bind role="stop"    component="conteudo2Menu5"/>
            
        </link>

        <link id="link_btn1" xconnector="conBase#onBeginStart">
            <bind role="onBegin"  component="btn1" interface="conteudo" >   
            </bind>
            <bind role="start"    component="conteudo1"/>
        </link>

        <link id="link_btn2" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection"  component="btn2" >   
            </bind>
            <bind role="stop"     component="conteudo1"/>
            <bind role="stop"     component="btn1on"/>
            <bind role="stop"     component="conteudo3"/>
            <bind role="start"    component="baixo"/>
            <bind role="start"    component="direita"/>
            <bind role="start"    component="voltar"/>
            <bind role="start"    component="btnOk"/>
            <bind role="start"    component="conteudo2Menu1"/>
            <bind role="start"    component="conteudo2Menu2"/>
            <bind role="start"    component="conteudo2Menu3"/>
            <bind role="start"    component="conteudo2Menu4"/>
            <bind role="start"    component="conteudo2Menu5"/>
        </link>

        <link id="link_btn3" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection"  component="btn3" >   
            </bind>
             <bind role="start"    component="conteudo3"/>
             <bind role="start"    component="btn1"/>
             <bind role="stop"   component="conteudo1"/>
            <bind role="stop"     component="esquerda"/>
            <bind role="stop"     component="direita"/>
            <bind role="stop"     component="baixo"/>
            <bind role="stop"     component="btnOk"/>
            <bind role="stop"    component="conteudo2Menu1"/>
            <bind role="stop"    component="conteudo2Menu2"/>
            <bind role="stop"    component="conteudo2Menu3"/>
            <bind role="stop"    component="conteudo2Menu4"/>
            <bind role="stop"    component="conteudo2Menu5"/>
            
        </link>
       
     

    
       <link id="link" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="direita" />
              
            <bind role="stop"      component="baixo"/>   
            <bind role="stop"      component="conteudo2Menu1"/>
            <bind role="stop"      component="conteudo2Menu2"/>
            <bind role="stop"      component="conteudo2Menu3"/>
            <bind role="stop"      component="conteudo2Menu4"/>
            <bind role="stop"      component="conteudo2Menu5"/>
            <bind role="start"     component="conteudo2Menu6"/>
            <bind role="start"     component="conteudo2Menu7"/>
            <bind role="start"     component="esquerda"/>
          

        </link>
  

 <link id="link_Voltar1"  xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="voltar">
                <bindParam name="keyCode" value="BACK"/>
            </bind>
            
            <bind component="voltar"                  role="stop"/>
            <bind component="direita"                 role="stop"/>
            <bind component="baixo"                   role="stop"/>
            <bind component="esquerda"                role="stop"/>
            <bind component="btnOk"                   role="stop"/>
            <bind component="conteudo2Menu1"          role="stop"/>
            <bind component="conteudo2Menu2"          role="stop"/>
            <bind component="conteudo2Menu3"          role="stop"/>
            <bind component="conteudo2Menu4"          role="stop"/>
            <bind component="conteudo2Menu5"          role="stop"/>
 
        </link>




        
        <!-- QUANDO BOTÃO SAIR FOR SELECIONADO.. -->
        <link id="link_Sair"  xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="sair">
                <bindParam name="keyCode" value="EXIT"/>
            </bind>
            <bind component="icone"                   role="start"/>
            <bind component="btn1"                    role="stop"/>
            <bind component="btn2"                    role="stop"/>
            <bind component="btn3"                    role="stop"/>
            <bind component="conteudo1"               role="stop"/>
            <bind component="conteudo2Menu1"          role="stop"/>
            <bind component="conteudo2Menu2"          role="stop"/>
            <bind component="conteudo2Menu3"          role="stop"/>
            <bind component="conteudo2Menu4"          role="stop"/>
            <bind component="conteudo2Menu5"          role="stop"/>
            <bind component="baixo"                   role="stop"/>
            <bind component="direita"                 role="stop"/>
            <bind component="esquerda"                role="stop"/>
            <bind component="fundo"                   role="stop"/>
            <bind component="fundo2"                  role="stop"/>
            <bind component="fundo3"                  role="stop"/>
            <bind component="fundo5"                  role="stop"/>
            <bind component="conteudo3"               role="stop"/>
            <bind component="sair"                    role="stop"/>
            <bind component="voltar"                  role="stop"/>
            <bind component="btnOk"                      role="stop"/>
        </link>

     
    </body>
        <!-- FIM DO PROGRAMA -->
</ncl>
