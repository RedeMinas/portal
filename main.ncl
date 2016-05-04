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
            <region id="rgconteudoBtn02"        width="74.58%"      height="14.44%"     top="77%"    left="12.5%"  zIndex="5"/>
            <region id="rgconteudoBtn03"        width="74.94%"      height="11.67%"     top="78%"    left="12.5%"  zIndex="5"/>
            <!-- BOTÕES -->
            <region id="rgBtn1"                 width="35.41%"      height="3.18%"      top="90%"    left="12.5%"   zIndex="5"/>
            <region id="rgBtn2"                 width="35.41%"      height="3.18%"      top="72%"    left="12.5%"  zIndex="5"/>
            <region id="rgBtn3"                 width="35.41%"      height="3.18%"      top="72%"    left="12.5%"  zIndex="5"/>
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
            <descriptor id="deconteudoBtn02"        region="rgconteudoBtn02" />
            <descriptor id="deconteudoBtn03"        region="rgconteudoBtn03"/>
            <descriptor id="deBtn1"                 region="rgBtn1"/>
            <descriptor id="deBtn2"                 region="rgBtn2"/>
            <descriptor id="deBtn3"                 region="rgBtn3"/>
            <descriptor id="deEsquerda"             region="rgEsquerda"/>
            <descriptor id="deDireita"              region="rgDireita"/>
       
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
        <media id="voltar"          src="midia/voltar.png"      descriptor="deVoltar"/>
        
        <!-- BOTOES (TEXTO NCL) -->
        <media id="btn1" src="midia/btn01.png" descriptor="deBtn1"><property name="top"/><area id="conteudo" begin="0.8s"/>
        </media>
        <media id="btn2" src="midia/btn02.png"             descriptor="deBtn2"/>
        <media id="btnAux" src="midia/btn02.png"           descriptor="deBtn2"/>
        <media id="btn3" src="midia/btn03.png"             descriptor="deBtn3"/>
        <media id="esquerda" src="midia/esquerda.png"      descriptor="deEsquerda"/>
        <media id="direita" src="midia/direita.png"        descriptor="deDireita"/>
        <media id="baixo" src="midia/baixo.png"            descriptor="deEsquerda"/>
        <media id="btnOk"     src="midia/ok.png"           descriptor="debtnOk"/>
        <media id="sair" src="midia/sair.png" descriptor="deSair"><property name="top"/></media>
        
        <!-- FIM DOS BOTOES (TEXTO NCL) -->
        <media id="conteudo1"      src="midia/conteudo1.png" descriptor="deconteudoBtn01"/>
        <media id="conteudo3"      src="midia/contato.png" descriptor="deconteudoBtn03"/>
        <media id="conteudo2"      src="midia/menu.png"    descriptor="deconteudoBtn02"/>
        <media id="conteudo2Menu1" src="midia/menu1.png"   descriptor="deconteudoBtn02"/>
        <media id="conteudo2Menu2" src="midia/menu2.png"   descriptor="deconteudoBtn02"/>
        <media id="conteudo2Menu3" src="midia/menu3.png"   descriptor="deconteudoBtn02"/>
        <media id="conteudo2Menu4" src="midia/menu4.png"   descriptor="deconteudoBtn02"/>
        <media id="conteudo2Menu5" src="midia/menu5.png"   descriptor="deconteudoBtn02"/>
        <media id="conteudo2Menu6" src="midia/menu6.png"   descriptor="deconteudoBtn02"/>
        <media id="conteudo2Menu7" src="midia/menu7.png"   descriptor="deconteudoBtn02"/>
        <media id="conteudo2Menu8" src="midia/menu8.png"   descriptor="deconteudoBtn02"/>
        <media id="conteudo2Menu9" src="midia/menu9.png"   descriptor="deconteudoBtn02"/>
        <media id="conteudo2Menu10" src="midia/menu10.png" descriptor="deconteudoBtn02"/>
        <media id="conteudo2Menu11" src="midia/menu11.png" descriptor="deconteudoBtn02"/>
        <media id="conteudo2Menu12" src="midia/menu12.png" descriptor="deconteudoBtn02"/>
        <media id="conteudo2Menu13" src="midia/menu13.png" descriptor="deconteudoBtn02"/>
        <media id="conteudo2Menu14" src="midia/menu14.png" descriptor="deconteudoBtn02"/>
        <media id="conteudo2Menu1Selected" src="midia/menu1.2.png" descriptor="deconteudoBtn02"/>
        <media id="conteudo2Menu2Selected" src="midia/menu2.2.png" descriptor="deconteudoBtn02"/>
        <media id="conteudo2Menu3Selected" src="midia/menu3.2.png" descriptor="deconteudoBtn02"/>
        <media id="conteudo2Menu4Selected" src="midia/menu4.2.png" descriptor="deconteudoBtn02"/>
        <media id="conteudo2Menu5Selected" src="midia/menu5.2.png" descriptor="deconteudoBtn02"/>
        <media id="conteudo2Menu6Selected" src="midia/menu6.2.png" descriptor="deconteudoBtn02"/>
        <media id="conteudo2Menu7Selected" src="midia/menu7.2.png" descriptor="deconteudoBtn02"/>
        <media id="conteudo2Menu8Selected" src="midia/menu8.2.png" descriptor="deconteudoBtn02"/>
        <media id="conteudo2Menu9Selected" src="midia/menu9.2.png" descriptor="deconteudoBtn02"/>
        <media id="conteudo2Menu10Selected" src="midia/menu10.2.png" descriptor="deconteudoBtn02"/>
        <media id="conteudo2Menu11Selected" src="midia/menu11.2.png" descriptor="deconteudoBtn02"/>
        <media id="conteudo2Menu12Selected" src="midia/menu12.2.png" descriptor="deconteudoBtn02"/>
        <media id="conteudo2Menu13Selected" src="midia/menu13.2.png" descriptor="deconteudoBtn02"/>
        <media id="conteudo2Menu14Selected" src="midia/menu14.2.png" descriptor="deconteudoBtn02"/>

       
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
        <link id="link_btn1" xconnector="conBase#onBeginStopStart">
            <bind role="onBegin"  component="btn1" >   
            </bind>
            <bind role="stop"     component="btn2"/>
            <bind role="stop"     component="btn3"/>
            <bind role="stop"     component="esquerda"/>
            <bind role="stop"     component="direita"/>
            <bind role="stop"     component="baixo"/>
            <bind role="stop"     component="btnOk"/>
            <bind role="start"    component="btn1"/>
            
        </link>
        <link id="link_btn1conteudo1" xconnector="conBase#onBeginStart">
            <bind role="onBegin"  component="btn1" interface="conteudo" >   
            </bind>
            <bind role="start"    component="conteudo1"/>
        </link>

            <link id="link_btn2" xconnector="conBase#onBeginStopStart">
            <bind role="onBegin"  component="btn2" >   
            </bind>
            <bind role="stop"     component="btn1"/>
            <bind role="stop"     component="btn3"/>
            <bind role="start"    component="baixo"/>
            <bind role="start"    component="direita"/>
            <bind role="start"    component="conteudo2"/>
            
            </link>

            <link id="link_ConteudoMenu1" xconnector="conBase#onBeginStopStart">
            <bind role="onBegin"  component="conteudo2Menu1" >   
            </bind>
            <bind role="stop"     component="btn3"/>
            <bind role="stop"     component="btn2"/>
            <bind role="stop"     component="conteudo3"/>
            <bind role="stop"     component="conteudo2"/>
            <bind role="start"    component="conteudo2Menu1"/>
        </link>

         <link id="link_btn3" xconnector="conBase#onBeginStopStart">
            <bind role="onBegin"  component="btn3" >   
            </bind>
            <bind role="stop"     component="btn1"/>
            <bind role="stop"     component="voltar"/>
            <bind role="stop"     component="btnOk"/>
            <bind role="stop"     component="esquerda"/>
            <bind role="stop"     component="direita"/>
            <bind role="stop"     component="baixo"/>
            <bind role="stop"     component="btn2"/>
            <bind role="stop"     component="btnOk"/>
            <bind role="start"    component="conteudo3"/>
        </link>
        <link id="link_ConteudoMenu2" xconnector="conBase#onBeginStopStart">
            <bind role="onBegin"  component="conteudo2Menu2" >   
            </bind>
            <bind role="stop"     component="conteudo2Menu1"/>
            
            <bind role="start"    component="conteudo2Menu2"/>
        </link>

        <link id="link_ConteudoMenu3" xconnector="conBase#onBeginStopStart">
            <bind role="onBegin"  component="conteudo2Menu3" >   
            </bind>
            <bind role="stop"     component="conteudo2Menu2"/>
            <bind role="start"    component="conteudo2Menu3"/>
        </link>

           
        <!-- FIM DE LINKS PARA BOTÕES-->
   


    

       

        <!-- LINK PARA SELEÇÃO DOS BOTÕES -->
        <link id="link_Btn1_RIGHT" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="btn1">
                <bindParam name="keyCode" value="CURSOR_RIGHT"/>
            </bind>
            <bind role="stop"  component="btn1"/>
            <bind role="stop"  component="conteudo1"/>
             
            <bind role="start" component="btn2"/>        
        </link>

        <link id="link_Btn1_LEFT" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="btn1">
                <bindParam name="keyCode" value="CURSOR_LEFT"/>
            </bind>
            <bind role="stop"  component="btn1"/>
            <bind role="stop"  component="conteudo1"/>
            <bind role="start" component="btn3"/>    
        </link>


        <link id="link_Btn2_RIGHT" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="btn2">
                <bindParam name="keyCode" value="CURSOR_RIGHT"/>
            </bind>
            <bind role="stop"  component="btn2"/>
            <bind role="stop"  component="conteudo2"/>
            <bind role="start" component="btn3"/>
        </link>

        <link id="link_Btn2_LEFT" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="btn2">
                <bindParam name="keyCode" value="CURSOR_LEFT"/>
            </bind>
            <bind role="stop"  component="btn2"/>
            <bind role="stop"  component="conteudo2"/>
            <bind role="start" component="conteudo1"/>
            <bind role="start" component="btn1"/>        
        </link>


        <link id="link_Btn3_RIGHT" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="btn3">
                <bindParam name="keyCode" value="CURSOR_RIGHT"/>
            </bind>
            <bind role="stop"  component="btn3"/>
            <bind role="stop"  component="conteudo3"/>
            <bind role="start" component="conteudo1"/>
            <bind role="start" component="btn1"/>
        </link>

        <link id="link_Btn3_LEFT" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="btn3">
                <bindParam name="keyCode" value="CURSOR_LEFT"/>
            </bind>
            <bind role="stop"  component="btn3"/>
            <bind role="stop"  component="conteudo3"/>
            <bind role="start" component="baixo"/>
            <bind role="start" component="btn2"/>
        </link>
        <!-- FIM DE LINKS PARA SELEÇÃO DOS BOTOES (TEXTO NCL) -->

        <!-- LINKS PARA SELEÇÃO DOS MENUS (TEXTO NCL) -->
        <link id="link_Btn2Down" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="btn2">
                <bindParam name="keyCode" value="CURSOR_DOWN"/>
            </bind>
            
           <bind role="stop"   component="btn3"/>
           <bind role="stop"   component="btn1"/>
           <bind role="stop"   component="conteudo1"/>
           <bind role="stop"   component="conteudo3"/>
           <bind role="stop"   component="conteudo2"/>
           <bind role="start"  component="voltar"/>
           <bind role="start"   component="btnOk"/>
           <bind role="start"  component="btnAux"/>          
           <bind role="start"  component="conteudo2Menu1"/>
        </link>

        <!-- CONTROLE DOS CONTEÚDOS DOS MENUS NÃO SELECIONADOS -->
        <link id="link_ConteudoMenu1_Right" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu1">
                <bindParam name="keyCode" value="CURSOR_RIGHT"/>
            </bind>
           <bind role="stop"  component="conteudo2Menu1"/>
           <bind role="stop"  component="baixo"/>
           <bind role="start"  component="esquerda"/>
           <bind role="start"  component="conteudo2Menu2"/>
        </link>
        <link id="link_ConteudoMenu1_LEFT" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu1">
                <bindParam name="keyCode" value="CURSOR_LEFT"/>
            </bind>
           <bind role="stop"   component="conteudo2Menu1"/>
           <bind role="stop"   component="baixo"/>
           <bind role="stop"  component="direita"/>
           <bind role="start"  component="esquerda"/>
           <bind role="start"  component="conteudo2Menu14"/>
        </link>

        <link id="link_ConteudoMenu2_Right" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu2">
                <bindParam name="keyCode" value="CURSOR_RIGHT"/>
            </bind>
           <bind role="stop"  component="conteudo2Menu2"/>
           <bind role="start"  component="conteudo2Menu3"/>
        </link>
        <link id="link_ConteudoMenu2_LEFT" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu2">
                <bindParam name="keyCode" value="CURSOR_LEFT"/>
            </bind>
           <bind role="stop"  component="conteudo2Menu2"/>
           <bind role="stop"  component="esquerda"/>
           <bind role="start"  component="conteudo2Menu1"/>
        </link>
        <link id="link_ConteudoMenu3_Right" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu3">
                <bindParam name="keyCode" value="CURSOR_RIGHT"/>
            </bind>
           <bind role="stop"  component="conteudo2Menu3"/>
           <bind role="start"  component="conteudo2Menu4"/>
        </link>
        <link id="link_ConteudoMenu3_LEFT" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu3">
                <bindParam name="keyCode" value="CURSOR_LEFT"/>
            </bind>
           <bind role="stop"  component="conteudo2Menu3"/>
           <bind role="start"  component="conteudo2Menu2"/>
        </link>

        <link id="link_ConteudoMenu4_Right" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu4">
                <bindParam name="keyCode" value="CURSOR_RIGHT"/>
            </bind>
           <bind role="stop"  component="conteudo2Menu4"/>
           <bind role="start"  component="conteudo2Menu5"/>
        </link>
        <link id="link_ConteudoMenu4_LEFT" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu4">
                <bindParam name="keyCode" value="CURSOR_LEFT"/>
            </bind>
           <bind role="stop"  component="conteudo2Menu4"/>
           <bind role="start"  component="conteudo2Menu3"/>
        </link>
        <link id="link_ConteudoMenu5_Right" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu5">
                <bindParam name="keyCode" value="CURSOR_RIGHT"/>
            </bind>
           <bind role="stop"  component="conteudo2Menu5"/>
           <bind role="start"  component="conteudo2Menu6"/>
        </link>
        <link id="link_ConteudoMenu5_LEFT" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu5">
                <bindParam name="keyCode" value="CURSOR_LEFT"/>
            </bind>
           <bind role="stop"  component="conteudo2Menu5"/>
           <bind role="start"  component="conteudo2Menu4"/>
        </link>


        <link id="link_ConteudoMenu6_Right" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu6">
                <bindParam name="keyCode" value="CURSOR_RIGHT"/>
            </bind>
           <bind role="stop"  component="conteudo2Menu6"/>
           <bind role="start"  component="conteudo2Menu7"/>
        </link>
        <link id="link_ConteudoMenu6_LEFT" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu6">
                <bindParam name="keyCode" value="CURSOR_LEFT"/>
            </bind>
           <bind role="stop"  component="conteudo2Menu6"/>
           <bind role="start"  component="conteudo2Menu5"/>
        </link>

        <link id="link_ConteudoMenu7_Right" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu7">
                <bindParam name="keyCode" value="CURSOR_RIGHT"/>
            </bind>
           <bind role="stop"  component="conteudo2Menu7"/>
           <bind role="start"  component="conteudo2Menu8"/>
        </link>
        <link id="link_ConteudoMenu7_LEFT" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu7">
                <bindParam name="keyCode" value="CURSOR_LEFT"/>
            </bind>
           <bind role="stop"  component="conteudo2Menu7"/>
           <bind role="start"  component="conteudo2Menu6"/>
        </link>

        <link id="link_ConteudoMenu8_Right" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu8">
                <bindParam name="keyCode" value="CURSOR_RIGHT"/>
            </bind>
           <bind role="stop"  component="conteudo2Menu8"/>
           <bind role="start"  component="conteudo2Menu9"/>
        </link>
        <link id="link_ConteudoMenu8_LEFT" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu8">
                <bindParam name="keyCode" value="CURSOR_LEFT"/>
            </bind>
           <bind role="stop"  component="conteudo2Menu8"/>
           <bind role="start"  component="conteudo2Menu7"/>
        </link>

        <link id="link_ConteudoMenu9_Right" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu9">
                <bindParam name="keyCode" value="CURSOR_RIGHT"/>
            </bind>
           <bind role="stop"  component="conteudo2Menu9"/>
           <bind role="start"  component="conteudo2Menu10"/>
        </link>
        <link id="link_ConteudoMenu9_LEFT" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu9">
                <bindParam name="keyCode" value="CURSOR_LEFT"/>
            </bind>
           <bind role="stop"  component="conteudo2Menu9"/>
           <bind role="start"  component="conteudo2Menu8"/>
        </link>

        <link id="link_ConteudoMenu10_Right" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu10">
                <bindParam name="keyCode" value="CURSOR_RIGHT"/>
            </bind>
           <bind role="stop"  component="conteudo2Menu10"/>
           <bind role="start"  component="conteudo2Menu11"/>
        </link>
        <link id="link_ConteudoMenu10_LEFT" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu10">
                <bindParam name="keyCode" value="CURSOR_LEFT"/>
            </bind>
           <bind role="stop"  component="conteudo2Menu10"/>
           <bind role="start"  component="conteudo2Menu9"/>
        </link>

        <link id="link_ConteudoMenu11_Right" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu11">
                <bindParam name="keyCode" value="CURSOR_RIGHT"/>
            </bind>
           <bind role="stop"  component="conteudo2Menu11"/>

           <bind role="start"  component="conteudo2Menu12"/>
        </link>
        <link id="link_ConteudoMenu11_LEFT" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu11">
                <bindParam name="keyCode" value="CURSOR_LEFT"/>
            </bind>
           <bind role="stop"  component="conteudo2Menu11"/>
           <bind role="start"  component="conteudo2Menu10"/>
        </link>

        <link id="link_ConteudoMenu12_Right" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu12">
                <bindParam name="keyCode" value="CURSOR_RIGHT"/>
            </bind>
           <bind role="stop"  component="conteudo2Menu12"/>
           <bind role="start"  component="conteudo2Menu13"/>
        </link>
        <link id="link_ConteudoMenu12_LEFT" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu12">
                <bindParam name="keyCode" value="CURSOR_LEFT"/>
            </bind>
           <bind role="stop"  component="conteudo2Menu12"/>
           <bind role="start"  component="conteudo2Menu11"/>
        </link>

        <link id="link_ConteudoMenu13_Right" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu13">
                <bindParam name="keyCode" value="CURSOR_RIGHT"/>
            </bind>
            <bind role="stop"  component="direita"/>
           <bind role="stop"  component="conteudo2Menu13"/>
           <bind role="start"  component="conteudo2Menu14"/>
        </link>
        <link id="link_ConteudoMenu13_LEFT" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu13">
                <bindParam name="keyCode" value="CURSOR_LEFT"/>
            </bind>
           <bind role="stop"  component="conteudo2Menu13"/>
           <bind role="start"  component="conteudo2Menu12"/>
        </link>

        <link id="link_ConteudoMenu14_Right" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu14">
                <bindParam name="keyCode" value="CURSOR_RIGHT"/>
            </bind>
           <bind role="stop"  component="conteudo2Menu14"/>
           <bind role="stop"  component="baixo"/>
           <bind role="stop"  component="esquerda"/>
           <bind role="start"  component="direita"/>
           <bind role="start"  component="conteudo2Menu1"/>
        </link>
        <link id="link_ConteudoMenu14_LEFT" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu14">
                <bindParam name="keyCode" value="CURSOR_LEFT"/>
            </bind>
           <bind role="stop"  component="conteudo2Menu14"/>
           <bind role="start"  component="direita"/>
           <bind role="start"  component="conteudo2Menu13"/>
        </link>
        <!-- FIM DO CONTROLE DOS CONTEÚDOS DOS MENUS NÃO SELECIONADOS -->

        <!-- SAIR DO CONTEÚDO 2 APERTANDO O BOTÃO UP -->
        <link id="link_Btn2Menu1Up" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu1">
                <bindParam name="keyCode" value="CURSOR_UP"/>
            </bind>
            <bind role="start"   component="btn2"/>
            <bind role="start"   component="conteudo2"/>
            <bind role="stop"    component="btnAux"/> 
            <bind role="stop"    component="esquerda"/> 
            <bind role="stop"    component="conteudo2Menu1"/>  
            <bind role="stop"    component="voltar"/>
            <bind role="stop"    component="btnOk"/>
        </link>
        <link id="link_Btn2Menu2Up" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu2">
                <bindParam name="keyCode" value="CURSOR_UP"/>
            </bind>
            <bind role="start"  component="btn2"/>
            <bind role="start" component="conteudo2"/> 
            <bind role="stop" component="btnAux"/>
            <bind role="stop" component="esquerda"/> 
            <bind role="stop" component="voltar"/>
            <bind role="stop"     component="btnOk"/>
            <bind role="stop" component="conteudo2Menu2"/>  
        </link>
        <link id="link_Btn2Menu3Up" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu3">
                <bindParam name="keyCode" value="CURSOR_UP"/>
            </bind>
            <bind role="start"  component="btn2"/>
            <bind role="start" component="conteudo2"/> 
            <bind role="stop" component="btnAux"/> 
            <bind role="stop" component="voltar"/>
            <bind role="stop"     component="btnOk"/>
            <bind role="stop" component="esquerda"/> 
            <bind role="stop" component="conteudo2Menu3"/>  
        </link>
        <link id="link_Btn2Menu4Up" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu4">
                <bindParam name="keyCode" value="CURSOR_UP"/>
            </bind>
            <bind role="start"  component="btn2"/>
            <bind role="start"  component="conteudo2"/> 
            <bind role="stop"   component="btnAux"/>
            <bind role="stop"   component="esquerda"/> 
            <bind role="stop"   component="conteudo2Menu4"/>  
            <bind role="stop"   component="voltar"/>
            <bind role="stop"   component="btnOk"/>
        </link>
        <link id="link_Btn2Menu5Up" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu5">
                <bindParam name="keyCode" value="CURSOR_UP"/>
            </bind>
            <bind role="start"  component="btn2"/>
            <bind role="start"  component="conteudo2"/> 
            <bind role="stop"   component="btnAux"/>
            <bind role="stop"   component="esquerda"/> 
            <bind role="stop"   component="conteudo2Menu5"/>  
            <bind role="stop"   component="voltar"/>
            <bind role="stop"   component="btnOk"/>
        </link>

        <link id="link_Btn2Menu6Up" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu6">
                <bindParam name="keyCode" value="CURSOR_UP"/>
            </bind>
            <bind role="start"    component="btn2"/>
            <bind role="start"    component="conteudo2"/>
            <bind role="stop"     component="btnAux"/> 
            <bind role="stop"     component="esquerda"/> 
            <bind role="stop"     component="conteudo2Menu6"/>  
            <bind role="stop"     component="voltar"/>
            <bind role="stop"     component="btnOk"/>
        </link>
        <link id="link_Btn2Menu7Up" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu7">
                <bindParam name="keyCode" value="CURSOR_UP"/>
            </bind>
            <bind role="start"  component="btn2"/>
            <bind role="start"  component="conteudo2"/> 
            <bind role="stop"   component="btnAux"/>
            <bind role="stop"   component="esquerda"/> 
            <bind role="stop"   component="voltar"/>
            <bind role="stop"   component="btnOk"/>
            <bind role="stop"   component="conteudo2Menu7"/>  
        </link>
        <link id="link_Btn2Menu8Up" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu8">
                <bindParam name="keyCode" value="CURSOR_UP"/>
            </bind>
            <bind role="start" component="btn2"/>
            <bind role="start" component="conteudo2"/> 
            <bind role="stop"  component="btnAux"/> 
            <bind role="stop"  component="voltar"/>
            <bind role="stop"  component="esquerda"/> 
            <bind role="stop"  component="btnOk"/>
            <bind role="stop"  component="conteudo2Menu8"/>  
        </link>

        <link id="link_Btn2Menu9Up" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu9">
                <bindParam name="keyCode" value="CURSOR_UP"/>
            </bind>
            <bind role="start"  component="btn2"/>
            <bind role="start" component="conteudo2"/> 
            <bind role="stop" component="btnAux"/>
            <bind role="stop" component="esquerda"/> 
            <bind role="stop" component="voltar"/>
            <bind role="stop"     component="btnOk"/>
            <bind role="stop" component="conteudo2Menu9"/>  
        </link>
        <link id="link_Btn2Menu10Up" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu10">
                <bindParam name="keyCode" value="CURSOR_UP"/>
            </bind>
            <bind role="start"  component="btn2"/>
            <bind role="start" component="conteudo2"/> 
            <bind role="stop" component="btnAux"/>
            <bind role="stop" component="esquerda"/> 
            <bind role="stop" component="voltar"/>
            <bind role="stop"     component="btnOk"/>
            <bind role="stop" component="conteudo2Menu10"/>  
        </link>

        <link id="link_Btn2Menu11Up" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu11">
                <bindParam name="keyCode" value="CURSOR_UP"/>
            </bind>
            <bind role="start"  component="btn2"/>
            <bind role="start" component="conteudo2"/>
            <bind role="stop" component="btnAux"/> 
            <bind role="stop" component="esquerda"/> 
            <bind role="stop" component="conteudo2Menu11"/>  
            <bind role="stop" component="voltar"/>
            <bind role="stop"     component="btnOk"/>
        </link>
        <link id="link_Btn2Menu12Up" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu12">
                <bindParam name="keyCode" value="CURSOR_UP"/>
            </bind>
            <bind role="start"  component="btn2"/>
            <bind role="start" component="conteudo2"/> 
            <bind role="stop" component="btnAux"/>
            <bind role="stop" component="voltar"/>
            <bind role="stop" component="esquerda"/> 
            <bind role="stop"     component="btnOk"/>
            <bind role="stop" component="conteudo2Menu12"/>  
        </link>
        <link id="link_Btn2Menu13Up" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu13">
                <bindParam name="keyCode" value="CURSOR_UP"/>
            </bind>
            <bind role="start"  component="btn2"/>
            <bind role="start" component="conteudo2"/> 
            <bind role="stop" component="btnAux"/> 
            <bind role="stop" component="voltar"/>
            <bind role="stop" component="esquerda"/> 
            <bind role="stop"     component="btnOk"/>
            <bind role="stop" component="conteudo2Menu13"/>  
        </link>
        <link id="link_Btn2Menu14Up" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu14">
                <bindParam name="keyCode" value="CURSOR_UP"/>
            </bind>
            <bind role="start"  component="btn2"/>
            <bind role="start" component="conteudo2"/> 
            <bind role="stop" component="btnAux"/>
            <bind role="stop" component="esquerda"/> 
            <bind role="stop" component="voltar"/>
            <bind role="stop"     component="btnOk"/>
            <bind role="stop" component="conteudo2Menu14"/>  
        </link>
        <!-- SAIR DO CONTEÚDO 2 APERTANDO O BOTÃO UP -->

        <!-- CONTEÚDO DOS MENUS SELECIONADOS -->
        <link id="link_Btn2Menu1Selected" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu1">
                <bindParam name="keyCode" value="ENTER"/>
            </bind>
            <bind role="start" component="esquerda"/> 
            <bind role="stop" component="baixo"/> 
            <bind role="stop" component="direita"/> 
            <bind role="stop" component="conteudo2Menu1"/> 
            <bind role="stop"     component="btnOk"/> 

            <bind role="start" component="conteudo2Menu1Selected"/> 
        </link>

        <link id="link_Btn2Menu2Selected" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu2">
                <bindParam name="keyCode" value="ENTER"/>
            </bind>
            <bind role="start" component="esquerda"/> 
            <bind role="stop" component="baixo"/> 
            <bind role="stop" component="direita"/> 
            <bind role="stop"     component="btnOk"/>
            <bind role="stop" component="conteudo2Menu2"/>  
            <bind role="start" component="conteudo2Menu2Selected"/> 
        </link>

        <link id="link_Btn2Menu3Selected" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu3">
                <bindParam name="keyCode" value="ENTER"/>
            </bind>
            <bind role="start" component="esquerda"/> 
            <bind role="stop" component="baixo"/> 
            <bind role="stop" component="direita"/> 
            <bind role="stop"     component="btnOk"/>
            <bind role="stop" component="conteudo2Menu3"/>  
            <bind role="start" component="conteudo2Menu3Selected"/> 
        </link>

        <link id="link_Btn2Menu4Selected" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu4">
                <bindParam name="keyCode" value="ENTER"/>
            </bind>
            <bind role="start" component="esquerda"/> 
            <bind role="stop" component="baixo"/> 
            <bind role="stop" component="direita"/> 
            <bind role="stop"     component="btnOk"/>
            <bind role="stop" component="conteudo2Menu4"/>  
            <bind role="start" component="conteudo2Menu4Selected"/> 
        </link>

        <link id="link_Btn2Menu5Selected" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu5">
                <bindParam name="keyCode" value="ENTER"/>
            </bind>
            <bind role="start" component="esquerda"/> 
            <bind role="stop" component="baixo"/> 
            <bind role="stop" component="direita"/> 
            <bind role="stop"     component="btnOk"/>
            <bind role="stop" component="conteudo2Menu5"/>  
            <bind role="start" component="conteudo2Menu5Selected"/> 
        </link>

         <link id="link_Btn2Menu6Selected" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu6">
                <bindParam name="keyCode" value="ENTER"/>
            </bind>
            <bind role="start" component="esquerda"/> 
            <bind role="stop" component="baixo"/> 
            <bind role="stop" component="direita"/> 
            <bind role="stop" component="conteudo2Menu6"/> 
            <bind role="stop"     component="btnOk"/> 
            <bind role="start" component="conteudo2Menu6Selected"/> 
        </link>

        <link id="link_Btn2Menu7Selected" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu7">
                <bindParam name="keyCode" value="ENTER"/>
            </bind>
            <bind role="start" component="esquerda"/> 
            <bind role="stop" component="baixo"/> 
            <bind role="stop" component="direita"/> 
            <bind role="stop"     component="btnOk"/>
            <bind role="stop" component="conteudo2Menu7"/>  
            <bind role="start" component="conteudo2Menu7Selected"/> 
        </link>

        <link id="link_Btn2Menu8Selected" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu8">
                <bindParam name="keyCode" value="ENTER"/>
            </bind>
            <bind role="start" component="esquerda"/> 
            <bind role="stop" component="baixo"/> 
            <bind role="stop" component="direita"/> 
            <bind role="stop"     component="btnOk"/>
            <bind role="stop" component="conteudo2Menu8"/>  
            <bind role="start" component="conteudo2Menu8Selected"/> 
        </link>

        <link id="link_Btn2Menu9Selected" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu9">
                <bindParam name="keyCode" value="ENTER"/>
            </bind>
            <bind role="start" component="esquerda"/> 
            <bind role="stop" component="baixo"/> 
            <bind role="stop" component="direita"/> 
            <bind role="stop"     component="btnOk"/>
            <bind role="stop" component="conteudo2Menu9"/>  
            <bind role="start" component="conteudo2Menu9Selected"/> 
        </link>

        <link id="link_Btn2Menu10Selected" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu10">
                <bindParam name="keyCode" value="ENTER"/>
            </bind>
            <bind role="start" component="esquerda"/> 
            <bind role="stop" component="baixo"/> 
            <bind role="stop" component="direita"/> 
            <bind role="stop"     component="btnOk"/>
            <bind role="stop" component="conteudo2Menu10"/>  
            <bind role="start" component="conteudo2Menu10Selected"/> 
        </link>

         <link id="link_Btn2Menu11Selected" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu11">
                <bindParam name="keyCode" value="ENTER"/>
            </bind>
            <bind role="start" component="esquerda"/> 
            <bind role="stop" component="baixo"/> 
            <bind role="stop" component="direita"/> 
            <bind role="stop" component="conteudo2Menu11"/> 
            <bind role="stop"     component="btnOk"/> 
            <bind role="start" component="conteudo2Menu11Selected"/> 
        </link>

        <link id="link_Btn2Menu12Selected" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu12">
                <bindParam name="keyCode" value="ENTER"/>
            </bind>
            <bind role="start" component="esquerda"/> 
            <bind role="stop" component="baixo"/> 
            <bind role="stop" component="direita"/> 
            <bind role="stop"     component="btnOk"/>
            <bind role="stop" component="conteudo2Menu12"/>  
            <bind role="start" component="conteudo2Menu12Selected"/> 
        </link>

        <link id="link_Btn2Menu13Selected" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu13">
                <bindParam name="keyCode" value="ENTER"/>
            </bind>
            <bind role="start" component="esquerda"/> 
            <bind role="stop" component="baixo"/> 
            <bind role="stop" component="direita"/> 
            <bind role="stop"     component="btnOk"/>
            <bind role="stop" component="conteudo2Menu13"/>  
            <bind role="start" component="conteudo2Menu13Selected"/> 
        </link>

        <link id="link_Btn2Menu14Selected" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu14">
                <bindParam name="keyCode" value="ENTER"/>
            </bind>
            <bind role="start" component="esquerda"/> 
            <bind role="stop" component="baixo"/> 
            <bind role="stop" component="direita"/> 
            <bind role="stop"     component="btnOk"/>
            <bind role="stop" component="conteudo2Menu14"/>  
            <bind role="start" component="conteudo2Menu14Selected"/> 
        </link>
       <!-- FIM DO CONTEÚDO DOS MENUS SELECIONADOS -->

        <!-- SAIR DO CONTEÚDO DOS MENUS SELECIONADOS -->
        <link id="link_Btn2Menu1SelectExit" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu1Selected">
                <bindParam name="keyCode" value="CURSOR_LEFT"/>
            </bind>
            <bind role="stop" component="esquerda"/> 
            <bind role="stop" component="baixo"/> 
            <bind role="start" component="direita"/> 
            <bind role="start"     component="btnOk"/>
            <bind role="start" component="conteudo2Menu1"/>  
            <bind role="stop" component="conteudo2Menu1Selected"/> 
        </link>

        <link id="link_Btn2Menu2SelectedExit" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu2Selected">
                <bindParam name="keyCode" value="CURSOR_LEFT"/>
            </bind>
            <bind role="start" component="esquerda"/> 
            <bind role="stop" component="baixo"/> 
            <bind role="start"     component="btnOk"/>
            <bind role="start" component="direita"/> 
            <bind role="start" component="conteudo2Menu2"/>  
            <bind role="stop" component="conteudo2Menu2Selected"/> 
        </link>

        <link id="link_Btn2Menu3SelectedExit" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu3Selected">
                <bindParam name="keyCode" value="CURSOR_LEFT"/>
            </bind>
            <bind role="start" component="esquerda"/> 
            <bind role="stop" component="baixo"/> 
            <bind role="start"     component="btnOk"/>
            <bind role="start" component="direita"/> 
            <bind role="start" component="conteudo2Menu3"/>  
            <bind role="stop" component="conteudo2Menu3Selected"/> 
        </link>

        <link id="link_Btn2Menu4SelectedExit" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu4Selected">
                <bindParam name="keyCode" value="CURSOR_LEFT"/>
            </bind>
            <bind role="start" component="esquerda"/> 
            <bind role="stop" component="baixo"/> 
            <bind role="start" component="direita"/> 
            <bind role="start"     component="btnOk"/>
            <bind role="start" component="conteudo2Menu4"/>  
            <bind role="stop" component="conteudo2Menu4Selected"/> 
        </link>

        <link id="link_Btn2Menu5SelectedExit" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu5Selected">
                <bindParam name="keyCode" value="CURSOR_LEFT"/>
            </bind>
            <bind role="start" component="esquerda"/> 
            <bind role="stop" component="baixo"/> 
            <bind role="start" component="direita"/> 
            <bind role="start"     component="btnOk"/>
            <bind role="start" component="conteudo2Menu5"/>  
            <bind role="stop" component="conteudo2Menu5Selected"/> 
        </link>

        <link id="link_Btn2Menu6SelectExit" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu6Selected">
                <bindParam name="keyCode" value="CURSOR_LEFT"/>
            </bind>
            <bind role="stop" component="esquerda"/> 
            <bind role="stop" component="baixo"/> 
            <bind role="start" component="direita"/> 
            <bind role="start"     component="btnOk"/>
            <bind role="start" component="conteudo2Menu6"/>  
           
            <bind role="stop" component="conteudo2Menu6Selected"/> 
        </link>

        <link id="link_Btn2Menu7SelectedExit" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu7Selected">
                <bindParam name="keyCode" value="CURSOR_LEFT"/>
            </bind>
            <bind role="start" component="esquerda"/> 
            <bind role="stop" component="baixo"/> 
            <bind role="start"     component="btnOk"/>
            <bind role="start" component="direita"/> 
            <bind role="start" component="conteudo2Menu7"/>  
            <bind role="stop" component="conteudo2Menu7Selected"/> 
        </link>

        <link id="link_Btn2Menu8SelectedExit" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu8Selected">
                <bindParam name="keyCode" value="CURSOR_LEFT"/>
            </bind>
            <bind role="start" component="esquerda"/> 
            <bind role="stop" component="baixo"/> 
            <bind role="start"     component="btnOk"/>
            <bind role="start" component="direita"/> 
            <bind role="start" component="conteudo2Menu8"/>  
            <bind role="stop" component="conteudo2Menu8Selected"/> 
        </link>

        <link id="link_Btn2Menu9SelectedExit" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu9Selected">
                <bindParam name="keyCode" value="CURSOR_LEFT"/>
            </bind>
            <bind role="start" component="esquerda"/> 
            <bind role="stop" component="baixo"/> 
            <bind role="start" component="direita"/> 
            <bind role="start"     component="btnOk"/>
            <bind role="start" component="conteudo2Menu9"/>  
            <bind role="stop" component="conteudo2Menu9Selected"/> 
        </link>

        <link id="link_Btn2Menu10SelectedExit" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu10Selected">
                <bindParam name="keyCode" value="CURSOR_LEFT"/>
            </bind>
            <bind role="start" component="esquerda"/> 
            <bind role="stop" component="baixo"/> 
            <bind role="start" component="direita"/> 
            <bind role="start"     component="btnOk"/>
            <bind role="start" component="conteudo2Menu10"/>  
            <bind role="stop" component="conteudo2Menu10Selected"/> 
        </link>

        <link id="link_Btn2Menu11SelectExit" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu11Selected">
                <bindParam name="keyCode" value="CURSOR_LEFT"/>
            </bind>
            <bind role="stop" component="esquerda"/> 
            <bind role="stop" component="baixo"/> 
            <bind role="start" component="direita"/> 
            <bind role="start"     component="btnOk"/>
            <bind role="start" component="conteudo2Menu11"/>      
            <bind role="stop" component="conteudo2Menu11Selected"/> 
        </link>

        <link id="link_Btn2Menu12SelectedExit" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu12Selected">
                <bindParam name="keyCode" value="CURSOR_LEFT"/>
            </bind>
            <bind role="start" component="esquerda"/> 
            <bind role="stop" component="baixo"/> 
            <bind role="start"     component="btnOk"/>
            <bind role="start" component="direita"/> 
            <bind role="start" component="conteudo2Menu12"/>  
            <bind role="stop" component="conteudo2Menu12Selected"/> 
        </link>

        <link id="link_Btn2Menu13SelectedExit" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu13Selected">
                <bindParam name="keyCode" value="CURSOR_LEFT"/>
            </bind>
            <bind role="start" component="esquerda"/> 
            <bind role="stop" component="baixo"/> 
            <bind role="start"     component="btnOk"/>
            <bind role="start" component="direita"/> 
            <bind role="start" component="conteudo2Menu13"/>  
            <bind role="stop" component="conteudo2Menu13Selected"/> 
        </link>

        <link id="link_Btn2Menu14SelectedExit" xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="conteudo2Menu14Selected">
                <bindParam name="keyCode" value="CURSOR_LEFT"/>
            </bind>
            <bind role="start" component="esquerda"/> 
            <bind role="stop" component="baixo"/> 
            <bind role="start" component="direita"/> 
            <bind role="start"     component="btnOk"/>
            <bind role="start" component="conteudo2Menu14"/>  
            <bind role="stop" component="conteudo2Menu14Selected"/> 
        </link>


      
       <!-- SAIR DO CONTEÚDO DOS MENUS SELECIONADOS -->


 <link id="link_Voltar1"  xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="voltar">
                <bindParam name="keyCode" value="BACK"/>
            </bind>
            <bind component="btnAux"                  role="stop"/>
            <bind component="voltar"                  role="stop"/>
            <bind component="direita"                 role="stop"/>
            <bind component="esquerda"                role="stop"/>
            <bind component="btn2"                    role="start"/>
            <bind component="btnOk"                   role="stop"/>
            <bind component="conteudo2"               role="start"/>
            <bind component="conteudo2Menu1"          role="stop"/>
            <bind component="conteudo2Menu2"          role="stop"/>
            <bind component="conteudo2Menu3"          role="stop"/>
            <bind component="conteudo2Menu4"          role="stop"/>
            <bind component="conteudo2Menu5"          role="stop"/>
            <bind component="conteudo2Menu6"          role="stop"/>
            <bind component="conteudo2Menu7"          role="stop"/>
            <bind component="conteudo2Menu8"          role="stop"/>
            <bind component="conteudo2Menu9"          role="stop"/>
            <bind component="conteudo2Menu10"         role="stop"/>
            <bind component="conteudo2Menu11"         role="stop"/>
            <bind component="conteudo2Menu12"         role="stop"/>
            <bind component="conteudo2Menu13"         role="stop"/>
            <bind component="conteudo2Menu14"         role="stop"/>
        </link>

        <link id="link_Voltar2"  xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="voltar">
                <bindParam name="keyCode" value="BACK"/>
            </bind>
            <bind component="conteudo2"               role="start"/>
            <bind component="conteudo2Menu1Selected"  role="stop"/>
            <bind component="conteudo2Menu2Selected"  role="stop"/>
            <bind component="conteudo2Menu3Selected"  role="stop"/>
            <bind component="conteudo2Menu4Selected"  role="stop"/>
            <bind component="conteudo2Menu5Selected"  role="stop"/>
            <bind component="conteudo2Menu6Selected"  role="stop"/>
            <bind component="conteudo2Menu7Selected"  role="stop"/>
            <bind component="conteudo2Menu8Selected"  role="stop"/>
            <bind component="conteudo2Menu9Selected"  role="stop"/>
            <bind component="conteudo2Menu10Selected"  role="stop"/>
            <bind component="conteudo2Menu11Selected"  role="stop"/>
            <bind component="conteudo2Menu12Selected"  role="stop"/>
            <bind component="conteudo2Menu13Selected"  role="stop"/>
            <bind component="conteudo2Menu14Selected"  role="stop"/>
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
            <bind component="conteudo2"               role="stop"/>
            <bind component="conteudo2Menu1"         role="stop"/>
            <bind component="conteudo2Menu2"          role="stop"/>
            <bind component="conteudo2Menu3"          role="stop"/>
            <bind component="conteudo2Menu4"          role="stop"/>
            <bind component="conteudo2Menu5"          role="stop"/>
            <bind component="conteudo2Menu6"          role="stop"/>
            <bind component="conteudo2Menu7"          role="stop"/>
            <bind component="conteudo2Menu8"          role="stop"/>
            <bind component="conteudo2Menu9"          role="stop"/>
            <bind component="conteudo3"               role="stop"/>
            <bind component="sair"                    role="stop"/>
            <bind component="voltar"                  role="stop"/>
            <bind component="fundo"                   role="stop"/>
            <bind component="fundo2"                  role="stop"/>
            <bind component="fundo3"                  role="stop"/> 
            <bind component="fundo4"                  role="stop"/> 
            <bind component="esquerda"                role="stop"/>
            <bind component="direita"                 role="stop"/>
            <bind component="baixo"                   role="stop"/>
            <bind component="btnAux"                  role="stop"/>
            <bind component="btnOk"                   role="stop"/>
        </link>

        <link id="link_Sair2"  xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="sair">
                <bindParam name="keyCode" value="EXIT"/>
            </bind> 
            <bind component="icone"                   role="start"/>
            <bind component="btn1"                    role="stop"/>
            <bind component="btn2"                    role="stop"/>
            <bind component="btn3"                    role="stop"/>
            <bind component="conteudo1"               role="stop"/>
            <bind component="conteudo2"               role="stop"/>
            <bind component="conteudo2Menu10"         role="stop"/>
            <bind component="conteudo2Menu11"          role="stop"/>
            <bind component="conteudo2Menu12"          role="stop"/>
            <bind component="conteudo2Menu13"          role="stop"/>
            <bind component="conteudo2Menu14"          role="stop"/>
            <bind component="conteudo2Menu1Selected"  role="stop"/>
            <bind component="conteudo2Menu2Selected"  role="stop"/>
            <bind component="conteudo2Menu3Selected"  role="stop"/>
            <bind component="conteudo2Menu4Selected"  role="stop"/>
            <bind component="conteudo2Menu5Selected"  role="stop"/>
            <bind component="conteudo2Menu6Selected"  role="stop"/>
            <bind component="conteudo2Menu7Selected"  role="stop"/>
            <bind component="conteudo2Menu8Selected"  role="stop"/>
            <bind component="conteudo2Menu9Selected"  role="stop"/>
            <bind component="conteudo2Menu10Selected"  role="stop"/>
            <bind component="conteudo2Menu11Selected"  role="stop"/>
            <bind component="conteudo2Menu12Selected"  role="stop"/>
            <bind component="conteudo2Menu13Selected"  role="stop"/>
            <bind component="conteudo2Menu14Selected"  role="stop"/>
        </link>
    </body>
        <!-- FIM DO PROGRAMA -->
</ncl>
