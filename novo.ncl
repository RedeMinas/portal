<?xml version="1.0" encoding="UTF-8"?>
<ncl id="rede-minas" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
     <!--
        Serie Rede-Minas
        Date: 17/06/2016
        Author: Bernardo Monteiro and Alessandro Cezar
        Organization: Rede Minas
     -->
    <head>
     
        <regionBase>
            <region id="rgVideo"                width="100%"        height="100%"                                  zIndex="2"/>
            <region id="rgIcone"                width="11.4%"       height="9.2%"       top="10%"    left="9.97%"  zIndex="2"/>
            <region id="rgIconetest"            width="11.4%"       height="3.5%"       top="10%"    left="9.97%"  zIndex="3"/>
            <region id="rgSair"                 width="2.29%"       height="4.63%"      top="90%"    left="82%"    zIndex="5"/>
            <region id="rgVoltar"               width="2.29%"       height="4.63%"      top="72%"    left="79%"    zIndex="15"/>
            <region id="rgOk"                   width="2.29%"       height="4.63%"      top="72%"    left="76%"    zIndex="5"/>
            <!-- CONTEUDO DOS BOTOES -->
            <region id="rgconteudoBtn01"        width="80%"       height="15.84%"     top="80%"    left="12.5%"  zIndex="5"/>
            <region id="rgconteudoBtn03"        width="74.94%"      height="11.67%"     top="78%"    left="12.5%"  zIndex="5"/>
            <!-- BOTOES -->
            <region id="rgBtn1"                 width="13.80%"      height="3.18%"      top="72%"    left="12.5%"  zIndex="5"/>
            <region id="rgBtn2"                 width="10.93%"      height="3.18%"      top="72%"    left="27.5%"  zIndex="5"/>
            <region id="rgBtn3"                 width="10.93%"      height="3.18%"      top="72%"    left="38.5%"  zIndex="5"/>
            <region id="rgBtnAux"               width="35.41%"      height="3.18%"      top="90%"    left="12.5%"  zIndex="5"/>
            <!-- IMAGEM DE FUNDO-->
            <region id="rgFundo"                width="100%"        height="10%"        top="90%"                  zIndex="4"/>
            <region id="rgFundo2"               width="100%"        height="10%"        top="90%"                  zIndex="4"/>
            <region id="rgFundo3"               width="100%"        height="10%"        top="90%"                  zIndex="4"/>
            <region id="rgFundo4"               width="100%"        height="1%"         top="96.8%"                zIndex="4"/>
            <region id="rgLua"                  width="78.95%"      height="45%"        top="54%"    left="10%"    zIndex="9"/>
        </regionBase>

        <descriptorBase>
            <descriptor id="deVideo"                region="rgVideo"/>   
            <descriptor id="deFundo"                region="rgFundo"> 
            <descriptorParam name="transparency"    value="0.010"/>    
            </descriptor>      
            <descriptor id="deFundo2"               region="rgFundo2">
            <descriptorParam name="transparency"    value="0.010"/>    
            </descriptor>           
            <descriptor id="deFundo3"               region="rgFundo3">  
            <descriptorParam name="transparency"    value="0.010"/>    
            </descriptor>
            <descriptor id="debtnOk"                region="rgOk"/> 
            <descriptor id="deFundo4"               region="rgFundo4"> 
            <descriptorParam name="transparency"    value="0.010"/>    
            </descriptor>
            <descriptor id="deVoltar"               region="rgVoltar" />        
            <descriptor id="deIcone"                region="rgIcone"/> 
            <descriptor id="deIconetest"            region="rgIconetest"/>
            <descriptor id="deSair"                 region="rgSair"/>
            <descriptor id="deconteudoBtn01"        region="rgconteudoBtn01"/>
            <descriptor id="deconteudoBtn03"        region="rgconteudoBtn03"/>
            <descriptor id="deBtnAux"               region="rgBtnAux"/>
            <descriptor id="deBtn1"                 region="rgBtn1" focusBorderWidth="0" focusIndex="1" focusSrc="midia/btn1on.png" focusSelSrc="midia/btn1on.png" moveLeft="3" moveRight="2"/>
            <descriptor id="deBtn2"                 region="rgBtn2" focusBorderWidth="0" focusIndex="2" focusSrc="midia/btn2on.png" focusSelSrc="midia/btn2on.png" moveLeft="1" moveRight="3" moveDown="4"/>
            <descriptor id="deBtn3"                 region="rgBtn3" focusBorderWidth="0" focusIndex="3" focusSrc="midia/btn3on.png" focusSelSrc="midia/btn3on.png" moveLeft="2" moveRight="1"/>
             <descriptor id="dsLua"                 region="rgLua"/>
        </descriptorBase>

        <!-- BIBLIOTECA DOS CONECTORES -->
        <connectorBase>
            <importBase documentURI="connector.ncl" alias="conBase"/>
        </connectorBase>
    </head>
    <body>

        <port id="pMediaInitialPort" component="Video"/>


        <!-- VIDEO MP4 
        <media id="Video" src="sbtvd-ts://video" descriptor="deFullScreenMedia">
            <area id="icon" begin="2s"/>
            <property name="bounds"/>
            <property name="zIndex" value="3"/>
        </media>
 -->
        <!-- MIDIAS -->
        <media id="Video"           src="midia/video.mp4"           descriptor="deVideo"/>
        <media id="icone"           src="midia/icon3.png"           descriptor="deIcone"><property name="top"/></media>
        <media id="iconetest"       src="midia/icon.png"            descriptor="deIconetest"/>
        <media id="voltar"          src="midia/voltar.png"          descriptor="deVoltar"/>
        
        
        <!-- BOTOES (TEXTO NCL) -->
        <media id="btn1" src="midia/btn1off.png" descriptor="deBtn1"/>
        <media id="btnAux" src="midia/btn01.png"  descriptor="deBtnAux"><property name="top"/><area id="conteudo" begin="0.8s"/>
        </media>
      
        <media id="btn2" src="midia/btn2off.png"  descriptor="deBtn2"/> 
        <media id="btn3" src="midia/btn3off.png"  descriptor="deBtn3"/>

        <media id="btnOk"     src="midia/ok.png"  descriptor="debtnOk"/>
        <media id="sair" src="midia/sair.png"     descriptor="deSair"><property name="top"/></media>
        
        <!-- FIM DOS BOTOES (TEXTO NCL) -->
        <media id="conteudo1"  src="texto/conteudo1.txt"  descriptor="deconteudoBtn01">
            <property name="background" value="transparent"/>
            <property name="fontColor" value="black" />
            <property name="fontFamily" value="vera" />
            <property name="fontSize" value="30" />
            <property name="textAlign" value="left" />
            <property name="text" value="" />
        </media>

        <media id="conteudo3"      src="midia/contato.png"      descriptor="deconteudoBtn03"/>
        <media id="lua"            src="scroll.lua"             descriptor="dsLua"/>
      

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
            <property name="service.currentFocus" value=""/>
        </media>

        <!-- INICIO DO PROGRAMA -->
        <link id="link_onBeginVideo"    xconnector="conBase#onBeginStart">
            <bind role="onBegin"        component="Video" />
            <bind role="start"          component="iconetest"/>
            <bind role="start"          component="icone"/>
        </link>

         <!-- QUANDO O ICONE FOR SELECIONADO... -->
        <link id="link_icon"         xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="icone" >
                <bindParam name="keyCode" value="ENTER"/>
            </bind>
            <bind role="stop"       component="icone"/>
            <bind role="start"      component="btnAux"/>
            <bind role="start"      component="sair"/>
            <bind role="start"      component="fundo"/>
            <bind role="start"      component="fundo2"/>
            <bind role="start"      component="fundo3"/>
            <bind role="start"      component="fundo4"/>
        </link>

        <!-- ANIMACOES | ANIMACOES | ANIMACOES | ANIMACOES | ANIMACOES | ANIMACOES -->
        <!-- ANIMACOES DO ICONE -->
        <link id="Animacao_Icone" xconnector="conBase#onBeginIconMenuSetAnim">
            <bind role="onBegin" component="icone"/>
            <bind role="set" component="icone" interface="top">
                <bindParam name="vBy"           value="0"/>
                <bindParam name="vDuration"     value="1s"/>
                <bindParam name="newValue"      value="13.5%"/>

            </bind>
        </link>

        <link id="Animacao_Icone_Fim" xconnector="conBase#onEndIconMenuSetAnim">
            <bind role="onEnd" component="icone"/>
            <bind role="set" component="icone" interface="top">
                <bindParam name="vBy"           value="0"/>
                <bindParam name="vDuration"     value="0"/>
                <bindParam name="newValue"      value="10%"/>
            </bind>
        </link>
        <!-- FIM DA ANIMACAO DO ICONE -->


        <!-- ANIMACAO DOS BOTOES -->



        <link id="Animacao_BtnAux" xconnector="conBase#onBeginIconMenuSetAnim">
            <bind role="onBegin" component="fundo"/>
            <bind role="set" component="btnAux" interface="top">
                <bindParam name="vBy"           value="0"/>
                <bindParam name="vDuration"     value="0.5s"/>
                <bindParam name="newValue"      value="72%"/>
            </bind>
        </link>

        <link id="Animacao_BtnAux_Fim" xconnector="conBase#onEndIconMenuSetAnim">
            <bind role="onEnd" component="fundo"/>
            <bind role="set" component="btnAux" interface="top" >
                <bindParam name="vBy"           value="0"/>
                <bindParam name="vDuration"     value="0"/>
                <bindParam name="newValue"      value="90%"/>
            </bind>
        </link>


        <link id="Animacao_SAIR" xconnector="conBase#onBeginIconMenuSetAnim">
            <bind role="onBegin" component="sair"/>
            <bind role="set" component="sair" interface="top">
                <bindParam name="vBy"           value="0"/>
                <bindParam name="vDuration"     value="0.5s"/>
                <bindParam name="newValue"      value="72%"/>
            </bind>
        </link>

        <link id="Animacao_SAIR_Fim" xconnector="conBase#onEndIconMenuSetAnim">
            <bind role="onEnd" component="sair"/>
            <bind role="set" component="sair" interface="top" >
                <bindParam name="vBy"           value="0"/>
                <bindParam name="vDuration"     value="0"/>
                <bindParam name="newValue"      value="90%"/>
            </bind>
        </link>

        <!-- FIM DA ANIMACAO DOS BOTOES -->


        <!-- LINKS ANIMACAO FUNDO -->
        
        <link id="Animacao_Fundo_Inicio" xconnector="conBase#onBeginIconMenuSetAnim">
            <bind role="onBegin" component="fundo"/>
            <bind role="set" component="fundo" interface="top">
                <bindParam name="vBy"           value=""/>
                <bindParam name="vDuration"     value="0.5s"/>
                <bindParam name="newValue"      value="67.88%"/>
            </bind>
            
        </link>

        <link id="Animacao_Fundo_FimStop" xconnector="conBase#onEndIconMenuSetAnim">
            <bind role="onEnd" component="fundo4"/>
            <bind role="set" component="fundo" interface="top" >
                <bindParam name="vBy"           value="0"/>
                <bindParam name="vDuration"     value="0"/>
                <bindParam name="newValue"      value="90%"/>
            </bind>
        </link>

         <link id="Animacao_Fundo2_Inicio" xconnector="conBase#onBeginIconMenuSetAnim">
            <bind role="onBegin" component="fundo2"/>
            <bind role="set" component="fundo2" interface="top">
                <bindParam name="vBy"           value=""/>
                <bindParam name="vDuration"     value="0.5s"/>
                <bindParam name="newValue"      value="87.4%"/>
            </bind>
        </link>

        <link id="Animacao_Fundo2_Fim" xconnector="conBase#onEndIconMenuSetAnim">
            <bind role="onEnd" component="fundo4"/>
            <bind role="set" component="fundo2" interface="top" >
                <bindParam name="vBy"           value="0"/>
                <bindParam name="vDuration"     value="0"/>
                <bindParam name="newValue"      value="90%"/>
            </bind>
        </link>

        <link id="Animacao_Fundo3_Inicio" xconnector="conBase#onBeginIconMenuSetAnim">
            <bind role="onBegin" component="fundo3" />
            <bind role="set" component="fundo3" interface="top" >
                <bindParam name="vBy"           value="0"/>
                <bindParam name="vDuration"     value="0.5s"/>
                <bindParam name="newValue"      value="77.9%"/>
            </bind>
        </link>

        <link id="Animacao_Fundo3_Fim" xconnector="conBase#onEndIconMenuSetAnim">
            <bind role="onEnd" component="fundo4"/>
            <bind role="set" component="fundo3" interface="top" >
                <bindParam name="vBy"           value="0"/>
                <bindParam name="vDuration"     value="0"/>
                <bindParam name="newValue"      value="90%"/>
            </bind>
        </link>

        <!-- FIM DA ANIMACAO DO FUNDO -->
<!-- FIM ANIMACOES | FIM ANIMACOES | FIM ANIMACOES | FIM ANIMACOES | FIM ANIMACOES | FIM ANIMACOES -->
    
        <!-- LINKS PARA BOTOES -->
        <link id="link_btn1"            xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection"    component="btn1" >   
            </bind>
            <bind role="start"          component="conteudo1"/>
            <bind role="stop"           component="conteudo3"/>
            <bind role="stop"           component="voltar"/>
            <bind role="stop"           component="btnOk"/>
            <bind role="stop"           component="lua"/>
        </link>

        <link id="link_btn1Begin"        xconnector="conBase#onBeginStart">
            <bind role="onBegin"    component="btnAux" interface="conteudo" >   
            </bind>
            <bind role="start"      component="conteudo1"/>
        </link>
        
       
        <link id="link_btn2"            xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection"    component="btn2" >   
            </bind>
            <bind role="stop"           component="conteudo1"/>
            <bind role="stop"           component="conteudo3"/>
            <bind role="start"          component="voltar"/>
            <bind role="start"          component="btnOk"/>
            <bind role="start"          component="lua"/>
        </link>
        

        <link id="link_btn3"            xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection"    component="btn3" >   
            </bind>
            <bind role="start"          component="conteudo3"/>
            <bind role="start"          component="btn1"/>
            <bind role="stop"           component="conteudo1"/>
            <bind role="stop"           component="btnOk"/>
            <bind role="stop"           component="lua"/>
            <bind role="stop"           component="voltar"/>
        </link>
       
        <link id="btnAuxTObtn2"              xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection"    component="btnAux" >
                <bindParam name="keyCode" value="CURSOR_RIGHT"/>
            </bind>
            <bind role="stop"           component="btnAux"/>
            <bind role="start"           component="btn2"/>
        </link>
          <link id="BeginBtn2"              xconnector="conBase#onBeginStart">
            <bind role="onBegin"         component="btn2"/>
            <bind role="start"           component="btn1"/>
            <bind role="start"           component="btn3"/>
        </link>
        <link id="btnAuxTObtn3"              xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection"    component="btnAux" >
                <bindParam name="keyCode" value="CURSOR_LEFT"/>
            </bind>
            <bind role="stop"           component="btnAux"/>
            <bind role="start"           component="btn3"/>
        </link>
        <link id="BeginBtn3"              xconnector="conBase#onBeginStart">
            <bind role="onBegin"         component="btn3"/>
            <bind role="start"           component="btn1"/>
            <bind role="start"           component="btn2"/>
        </link>
        

        <!-- CONTROLE LUA -->
        <link id="link_focoConteudo2BEGIN"    xconnector="conBase#onBeginSet">
            <bind role="onBegin"        component="lua"/>
            <bind role="set"            component="settings" interface="service.currentKeyMaster">
                <bindParam name="value" value="lua"/>
            </bind>
        </link>
        
        <link id="link_focoConteudo2END"    xconnector="conBase#onEndSet">
            <bind role="onEnd"              component="lua" />
            <bind role="set"                component="settings" interface="service.currentKeyMaster">
                <bindParam name="value" value=""/>
            </bind>
        </link>
<!-- FIM DO CONTROLE LUA -->
            <link id="link_Voltar"    xconnector="conBase#onSelectionStop">
            <bind role="onSelection"              component="voltar" >
            <bindParam name="keyCode" value="BACK"/>
            </bind>
            <bind role="stop"                component="lua"/>
            <bind role="stop"                component="voltar"/>

        </link>
         
        <!-- QUANDO BOTAO SAIR FOR SELECIONADO.. -->
        <link id="link_Sair"  xconnector="conBase#onSelectionStartStop">
            <bind role="onSelection" component="sair">
                <bindParam name="keyCode" value="EXIT"/>
            </bind>
            <bind component="icone"                   role="start"/>
            <bind component="lua"                     role="stop"/>
            <bind component="btn1"                    role="stop"/>
            <bind component="btnAux"                  role="stop"/>
            <bind component="btn2"                    role="stop"/>
            <bind component="btn3"                    role="stop"/>
            <bind component="conteudo1"               role="stop"/>
            <bind component="fundo"                   role="stop"/>
            <bind component="fundo2"                  role="stop"/>
            <bind component="fundo3"                  role="stop"/>
            <bind component="conteudo3"               role="stop"/>
            <bind component="sair"                    role="stop"/>
            <bind component="voltar"                  role="stop"/>
            <bind component="btnOk"                   role="stop"/>
        </link>
     </body>
        <!-- FIM DO PROGRAMA -->
</ncl>