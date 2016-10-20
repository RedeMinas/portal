<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="rede-minas" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
  <!--
      Serie Rede-Minas
      Date: 17/06/2016
      Author: Nucleo Transmidia: Alessandro Cezar, Bernardo Monteiro, Bruna Menezes, Carlos Paulino, Joao Victor 
      Organization: Rede Minas
  -->
  <head>
    <regionBase>

      <region id="rgIcone"                width="11.4%"       height="9.2%"       top="10%"    left="9.97%"  zIndex="2"/>
      <region id="rgIconetest"            width="11.4%"       height="3.5%"       top="10%"    left="9.97%"  zIndex="3"/>
      <region id="rgSair"                 width="2.29%"       height="4.63%"      top="72%"    left="82%"    zIndex="5"/>
      <region id="rgVoltar"               width="2.29%"       height="4.63%"      top="72%"    left="79%"    zIndex="15"/>
      <region id="rgOk"                   width="2.29%"       height="4.63%"      top="72%"    left="76%"    zIndex="5"/>
      <!-- CONTEUDO DOS BOTOES -->

      <region id="rgconteudoBtn01"        width="80%"       height="15.84%"     top="80%"    left="12.5%"  zIndex="5"/>
      <region id="rgconteudoBtn03"        width="74.94%"      height="11.67%"     top="78%"    left="12.5%"  zIndex="5"/>
      <!-- BOTOES -->
      <region id="rgBtn1"                 width="13.80%"      height="3.18%"      top="72%"    left="12.5%"  zIndex="5"/>
      <region id="rgBtn2"                 width="10.93%"      height="3.18%"      top="72%"    left="27.5%"  zIndex="5"/>
      <region id="rgBtn3"                 width="10.93%"      height="3.18%"      top="72%"    left="38.5%"  zIndex="5"/>
      <region id="rgBtn4"                 width="10.93%"      height="3.18%"      top="72%"    left="50%"  zIndex="5"/>
      <region id="rgBtn1on"               width="13.80%"      height="3.18%"      top="72%"    left="12.5%"  zIndex="7"/>
      <region id="rgBtn2on"               width="10.93%"      height="3.18%"      top="72%"    left="27.5%"  zIndex="7"/>
      <region id="rgBtn3on"               width="10.93%"      height="3.18%"      top="72%"    left="38.5%"  zIndex="7"/>
      <region id="rgBtn4on"               width="10.93%"      height="3.18%"      top="72%"    left="50%"    zIndex="7"/>
      
      <region id="rgFundo"                width="100%"        height="40%"        top="60%"                  zIndex="4"/>
      
      <region id="rgScroll"                 left="10%" width="80%" height="20%" top="75%"   zIndex="9"/>
      <region id="rgSlide"               left="10%" width="80%" height="80%" top="10%"   zIndex="9"/>
    </regionBase>

    <descriptorBase>
      
      <descriptor id="deFundo"                region="rgFundo"/> 
      <descriptor id="debtnOk"                region="rgOk"/> 
      <descriptor id="deVoltar"               region="rgVoltar" />        
      <descriptor id="deIcone"                region="rgIcone"/> 
      <descriptor id="deIconetest"            region="rgIconetest"/>
      <descriptor id="deSair"                 region="rgSair"/>
      <descriptor id="deconteudoBtn01"        region="rgconteudoBtn01"/>
      <descriptor id="deconteudoBtn03"        region="rgconteudoBtn03"/>
      <descriptor id="deBtn1"      region="rgBtn1" focusBorderWidth="3" focusBorderColor="red" focusIndex="4"  moveLeft="2" moveRight="1"/>
      <descriptor id="deBtn2"      region="rgBtn2" focusBorderWidth="3" focusBorderColor="red" focusIndex="1"  moveLeft="4" moveRight="3"/>
      <descriptor id="deBtn3"      region="rgBtn3" focusBorderWidth="3" focusBorderColor="red" focusIndex="3"  moveLeft="1" moveRight="2"/>
      <descriptor id="deBtn4"      region="rgBtn4" focusBorderWidth="3" focusBorderColor="red" focusIndex="2"  moveLeft="3" moveRight="4"/>
     
      <descriptor id="deBtn1on"     region="rgBtn1on" />
      <descriptor id="deBtn2on"     region="rgBtn2on"   />
      <descriptor id="deBtn3on"     region="rgBtn3on" />
      <descriptor id="deBtn4on"     region="rgBtn4on"  />
      <descriptor id="dsScroll"        region="rgScroll" focusBorderWidth="0" focusIndex="0" />
      <descriptor id="deSlide"      region="rgSlide"  focusBorderWidth="0" focusIndex="1"  />
      
    </descriptorBase>

    <!-- BIBLIOTECA DOS CONECTORES -->
    <connectorBase>
      <importBase documentURI="connector.ncl" alias="conBase"/>
    </connectorBase>
  </head>
  <body>
    <port id="pMediaInitialPort" component="icone"/>

    <!-- MIDIAS -->

    <media id="icone"
	   src="midia/icon3.png"           descriptor="deIcone"/>
    <media id="iconetest"       src="midia/icon.png"            descriptor="deIconetest"/>
    <media id="voltar"          src="midia/voltar.png"          descriptor="deVoltar"/>
    
    <!-- BOTOES (TEXTO NCL) -->
    <media id="btn1"   src="midia/btn1off.png" descriptor="deBtn1"/>
    <media id="btn1on" src="midia/btn1on.png"  descriptor="deBtn1on"/>
    <media id="btn2"   src="midia/btn2off.png" descriptor="deBtn2"/>
    <media id="btn2on" src="midia/btn2on.png"  descriptor="deBtn2on"/>
    <media id="btn3"   src="midia/btn3off.png" descriptor="deBtn3"/>
    <media id="btn3on" src="midia/btn3on.png"  descriptor="deBtn3on"/>
    <media id="btn4"   src="midia/btn4off.png" descriptor="deBtn4"/>
    <media id="btn4on" src="midia/btn4on.png"  descriptor="deBtn4on"/>
    <media id="btnOk"  src="midia/ok.png"      descriptor="debtnOk"/>
    <media id="sair"   src="midia/sair.png"    descriptor="deSair"/>
    <media id="sairMenuScroll"   src="midia/sair.png"    descriptor="deSair"/>
     <media id="sairMenuSlide"   src="midia/sair.png"    descriptor="deSair"/>
    <!-- FIM DOS BOTOES (TEXTO NCL) -->
    <media id="conteudo1"  src="midia/conteudo1.txt"  descriptor="deconteudoBtn01">
      <property name="background" value="transparent"/>
      <property name="fontColor" value="black" />
      <property name="fontFamily" value="vera" />
      <property name="fontSize" value="30" />
      <property name="textAlign" value="left" />
      <property name="text" value="" />
    </media>

    <media id="conteudo3"   src="midia/contato.png"      descriptor="deconteudoBtn03"/>
    <media id="scroll"      src="scroll.lua"             descriptor="dsScroll"/>
    <media id="slide"       src="slideEdital.lua"        descriptor="deSlide"/>
    
    <!-- FUNDO -->
    <media id="fundo"  src="midia/fundo.png" descriptor="deFundo"/>
    
    <!-- FIM FUNDO -->
    
    <media id="settings" type="application/x-ginga-settings">
      <property name="service.currentKeyMaster" value=""/>
      <property name="service.currentFocus" value=""/>
    </media>
  

    <link id="link_icon"         xconnector="conBase#onSelectionStartStop">
      <bind role="onSelection" component="icone" >
        <bindParam name="keyCode" value="ENTER"/>
      </bind>
      <bind role="start"      component="btn1"/>
      <bind role="start"      component="btn2"/>
      <bind role="start"      component="btn3"/>
      <bind role="start"      component="btn4"/>
      <bind role="start"      component="conteudo1"/>
      <bind role="start"      component="sair"/>
      <bind role="start"      component="fundo"/>
      <bind role="stop"       component="icone"/>
    </link>
    
    <!-- LINKS PARA BOTOES -->
    <link id="link_btn1"            xconnector="conBase#onSelectionStartStop">
      <bind role="onSelection"    component="btn1" >   
      </bind>
      
      <bind role="start"          component="btn1on"/>
      <bind role="start"          component="conteudo1"/>
      <bind role="stop"           component="conteudo3"/>
      <bind role="stop"           component="btn2on"/>
      <bind role="stop"           component="btn3on"/>
      <bind role="stop"           component="btn4on"/>
    </link>
    
    <link id="link_btn2" xconnector="conBase#onSelectionStartStop">
      <bind role="onSelection"    component="btn2" >   
      </bind>
      <bind role="stop"           component="conteudo1"/>
      <bind role="stop"           component="conteudo3"/>
      <bind role="stop"           component="btn2"/>
      <bind role="start"          component="btn2on"/>
      <bind role="start"          component="scroll"/>
      <bind role="start"          component="sairMenuScroll"/>
       <bind role="stop"          component="sair"/>
      <bind role="stop"           component="btn1on"/>
      <bind role="stop"           component="btn3on"/>
      <bind role="stop"           component="btn4on"/>
    </link>

    <link id="link_btn3" xconnector="conBase#onSelectionStartStop">
      <bind role="onSelection"    component="btn3" >   
      </bind>
      <bind role="start"          component="conteudo3"/>
      <bind role="start"          component="btn3on"/>
      <bind role="stop"           component="btn1on"/>
      <bind role="stop"           component="btn2on"/>
      <bind role="stop"           component="btn4on"/>
     <bind role="stop"           component="conteudo1"/>   
    </link>

    <link id="link_btn4" xconnector="conBase#onSelectionStartStop">
      <bind role="onSelection"    component="btn4" >   
      </bind>
     
      <bind role="start"          component="btn4on"/>
      <bind role="start"          component="slide"/>
      <bind role="stop"           component="conteudo1"/>
      <bind role="stop"           component="conteudo3"/>
      <bind role="stop"           component="btn1on"/>
      <bind role="stop"           component="btn2on"/>
      <bind role="stop"           component="btn3on"/>
      <bind role="stop"           component="sair"/>
      <bind role="start"          component="sairMenuSlide"/>    
    </link>
    
 
    
    <!-- CONTROLE LUA -->
    <link id="link_focoScroll2BEGIN"    xconnector="conBase#onBeginSet">
      <bind role="onBegin"        component="scroll"/>
      <bind role="set"            component="settings" interface="service.currentKeyMaster">
        <bindParam name="value" value="scroll"/>
      </bind>
    </link>

    <link id="link_focoScroll2END"    xconnector="conBase#onEndSet">
      <bind role="onEnd"              component="scroll" />
      <bind role="set"                component="settings" interface="service.currentKeyMaster">
        <bindParam name="value" value=""/>
      </bind>
    </link>

    <link id="link_focoSlide2BEGIN"    xconnector="conBase#onBeginSet">
      <bind role="onBegin"        component="slide"/>
      <bind role="set"            component="settings" interface="service.currentKeyMaster">
        <bindParam name="value" value="slide"/>
      </bind>
    </link>

    <link id="link_focoSlide2END"    xconnector="conBase#onEndSet">
      <bind role="onEnd"              component="slide" />
      <bind role="set"                component="settings" interface="service.currentFocus">
        <bindParam name="value" value="2"/>
      </bind>
    </link>

     <link id="link_SairMenuScroll"  xconnector="conBase#onSelectionStartStop">
      <bind role="onSelection" component="sairMenuScroll">
        <bindParam name="keyCode" value="EXIT"/>
      </bind>
       <bind role="stop"          component="sairMenuScroll"/>
       <bind role="stop"          component="btn2on"/>      
       <bind role="stop"          component="scroll"/>     
       <bind role="stop"           component="btnOk"/>
       <bind role="start"          component="btn2"/>
       <bind role="start"          component="sair"/>
    </link>
    <link id="link_SairMenuSlide"  xconnector="conBase#onSelectionStartStop">
      <bind role="onSelection" component="sairMenuSlide">
        <bindParam name="keyCode" value="EXIT"/>
      </bind>
       <bind role="stop"          component="sairMenuSlide"/>
		<bind role="stop"          component="btn4on"/>
		<bind role="stop"          component="slide"/>
		 <bind role="start"          component="sair"/>
       <bind role="start"          component="btn4"/>  
    </link>
    <!-- QUANDO BOTAO SAIR FOR SELECIONADO.. -->
    <link id="link_Sair"  xconnector="conBase#onSelectionStartStop">
      <bind role="onSelection" component="sair">
        <bindParam name="keyCode" value="EXIT"/>
      </bind>
      <bind component="icone"	      role="start"/>
      <bind component="btn1"	      role="stop"/>
      <bind component="btn2"	      role="stop"/>
      <bind component="btn3"	      role="stop"/>
      <bind component="btn4"	      role="stop"/>
      <bind component="btn1on"	      role="stop"/>
      <bind component="btn2on"	      role="stop"/>
      <bind component="btn3on"	      role="stop"/>
      <bind component="btn4on"	      role="stop"/>
      <bind component="conteudo1"     role="stop"/>
      <bind component="fundo"	      role="stop"/>
      <bind component="conteudo3"     role="stop"/>
      <bind component="sair"          role="stop"/>
      <bind component="voltar"        role="stop"/>
      <bind component="btnOk"         role="stop"/>
    </link>
  </body>
  <!-- FIM DO PROGRAMA -->
</ncl>

