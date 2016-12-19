<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="portal" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
  <head>

    <regionBase>
      <region id="rgIcone"     width="11.4%"  height="9.2%"   top="10%"  left="9.97%"  zIndex="2"/>
      <region id="rgSair"      width="2.29%"  height="4.63%"  top="72%"  left="82%"    zIndex="5"/>
      <region id="rgVoltar"    width="2.29%"  height="4.63%"  top="72%"  left="79%"    zIndex="8"/>
      <region id="rgOk"        width="2.29%"  height="4.63%"  top="72%"  left="76%"    zIndex="5"/>
      <region id="rgContent01" width="80%"    height="15.84%" top="80%"  left="12.5%"  zIndex="5"/>
      <region id="rgContent03" width="74.94%" height="11.67%" top="78%"  left="12.5%"  zIndex="5"/>
      <region id="rgBtn1"      width="12.91%" height="2.77%"  top="72%"  left="12.5%"  zIndex="5"/>
      <region id="rgBtn1on"    width="12.91%" height="2.77%"  top="72%"  left="12.5%"  zIndex="5"/>
      <region id="rgBtn2"      width="10.20%" height="3.33%"  top="72%"  left="27%"    zIndex="5"/>
      <region id="rgBtn2on"    width="10.33%" height="3.33%"  top="72%"  left="27%"    zIndex="5"/>
      <region id="rgBtn3"      width="7.5%"   height="2.77%"  top="72%"  left="38.5%"  zIndex="5"/>
      <region id="rgBtn3on"    width="7.5%"   height="2.77%"  top="72%"  left="38.5%"  zIndex="5"/>
      <region id="rgBtn4"      width="6.25%"  height="2.31%"  top="72%"  left="47.5%"  zIndex="5"/>
      <region id="rgBtn4on"    width="6.25%"  height="2.31%"  top="72%"  left="47.5%"  zIndex="5"/>
      <region id="rgBgd"       width="100%"   height="40%"    top="60%"  zIndex="4"/>
      <region id="rgScroll"    width="54%"    height="20%" top="77%"     left="18%"    zIndex="9"/>
    </regionBase>

    <descriptorBase>
      <descriptor id="deBgd"     region="rgBgd"/> 
      <descriptor id="debtnOk"     region="rgOk"/> 
      <descriptor id="deVoltar"    region="rgVoltar" />        
      <descriptor id="deIcone"     region="rgIcone"/> 
      <descriptor id="deSair"      region="rgSair"/>
      <descriptor id="deContent01" region="rgContent01"/>
      <descriptor id="deContent03" region="rgContent03"/>
      <descriptor id="deBtn1"      region="rgBtn1" focusBorderWidth="3" focusBorderColor="red" focusIndex="1"  moveLeft="4" moveRight="2"/>
      <descriptor id="deBtn2"      region="rgBtn2" focusBorderWidth="3" focusBorderColor="red" focusIndex="2"  moveLeft="1" moveRight="3"/>
      <descriptor id="deBtn3"      region="rgBtn3" focusBorderWidth="3" focusBorderColor="red" focusIndex="3"  moveLeft="2" moveRight="4"/>
      <descriptor id="deBtn4"      region="rgBtn4" focusBorderWidth="3" focusBorderColor="red" focusIndex="4"  moveLeft="3" moveRight="1"/>
      <descriptor id="deBtn1on"    region="rgBtn1on"/>
      <descriptor id="deBtn2on"    region="rgBtn2on"/>
      <descriptor id="deBtn3on"    region="rgBtn3on"/>
      <descriptor id="deBtn4on"    region="rgBtn4on"/>
      <descriptor id="dsScroll"    region="rgScroll" focusBorderWidth="0" focusIndex="0" />
    </descriptorBase>

    <connectorBase>
      <importBase documentURI="connector.ncl" alias="conBase"/>
    </connectorBase>

  </head>

  <body>

    <port id="pMediaInitialPort" component="icone"/>
    <media id="icone"           src="media/icon.png"           descriptor="deIcone"/>
    <media id="voltar"          src="media/voltar.png"          descriptor="deVoltar"/>
    <media id="btn1"   src="media/btn1off.png" descriptor="deBtn1"/>
    <media id="btn1on" src="media/btn1on.png"  descriptor="deBtn1on"/>
    <media id="btn2"   src="media/btn2off.png" descriptor="deBtn2"/>
    <media id="btn2on" src="media/btn2on.png"  descriptor="deBtn2on"/>
    <media id="btn3"   src="media/btn3off.png" descriptor="deBtn3"/>
    <media id="btn3on" src="media/btn3on.png"  descriptor="deBtn3on"/>
    <media id="btn4"   src="media/btn4off.png" descriptor="deBtn4"/>
    <media id="btn4on" src="media/btn4on.png"  descriptor="deBtn4on"/>

    <media id="btnOk"  src="media/ok.png"      descriptor="debtnOk"/>
    <media id="sair"   src="media/sair.png"    descriptor="deSair"/>
    <media id="sairMenuScroll"   src="media/sair.png"    descriptor="deSair"/>

    <media id="conteudo1"  src="media/contato.png"  descriptor="deContent01"/>
    <media id="conteudo3"  src="media/contato.png"  descriptor="deContent03"/>
    <media id="scroll"     src="scroll.lua"         descriptor="dsScroll"/>
    
    <media id="fundo"  src="media/fundo.png" descriptor="deBgd"/>
    
    <media id="settings" type="application/x-ginga-settings">
      <property name="service.currentKeyMaster" value=""/>
      <property name="service.currentFocus" value=""/>
    </media>
    

    <link id="link_icon"       xconnector="conBase#onSelectionStartStop">
      <bind role="onSelection" component="icone" >
        <bindParam name="keyCode" value="ENTER"/>
        </bind>1
        <bind role="start"      component="btn1"/>
        <bind role="start"      component="btn1on"/>
        <bind role="start"      component="btn2"/>
        <bind role="start"      component="btn3"/>
        <bind role="start"      component="btn4"/>
        <bind role="start"      component="conteudo1"/>
        <bind role="start"      component="sair"/>
        <bind role="start"      component="fundo"/>
        <bind role="stop"       component="icone"/>
    </link>
    
    <link id="link_btn1"            xconnector="conBase#onSelectionStartStop">
      <bind role="onSelection"    component="btn1" />   
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
      <bind role="stop"           component="conteudo1"/>
      <bind role="stop"           component="conteudo3"/>
      <bind role="stop"           component="btn1on"/>
      <bind role="stop"           component="btn2on"/>
      <bind role="stop"           component="btn3on"/>
      <bind role="stop"           component="sair"/>
    </link>
    
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


    <link id="link_Sair"  xconnector="conBase#onSelectionStartStop">
      <bind role="onSelection" component="sair">
        <bindParam name="keyCode" value="EXIT"/>
      </bind>
      <bind component="icone"       role="start"/>
      <bind component="btn1"        role="stop"/>
      <bind component="btn2"        role="stop"/>
      <bind component="btn3"        role="stop"/>
      <bind component="btn4"        role="stop"/>
      <bind component="btn1on"        role="stop"/>
      <bind component="btn2on"        role="stop"/>
      <bind component="btn3on"        role="stop"/>
      <bind component="btn4on"        role="stop"/>
      <bind component="conteudo1"     role="stop"/>
      <bind component="fundo"       role="stop"/>
      <bind component="conteudo3"     role="stop"/>
      <bind component="sair"          role="stop"/>
      <bind component="voltar"        role="stop"/>
      <bind component="btnOk"         role="stop"/>
    </link>

  </body>
</ncl>
