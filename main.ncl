<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="portal" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
  <head>

    <regionBase>
      <region id="rgIcone"     width="3%"  height="5%"   top="90%"  left="90%"  zIndex="2"/>
      <region id="rgSair"      width="3.125%"  height="5.55%"  top="90%"  left="12.4%"    zIndex="4"/>
      <region id="rgMain"    width="100%"    height="100%"       zIndex="3"/>
    </regionBase>

    <descriptorBase>
      <descriptor id="deIcone"     region="rgIcone"/> 
      <descriptor id="deSair"      region="rgSair"/>
      <descriptor id="deMain"    region="rgMain" focusBorderWidth="0" focusIndex="idxLua" />
    </descriptorBase>

    <connectorBase>
      <importBase documentURI="connector.ncl" alias="conBase"/>
    </connectorBase>

  </head>

  <body>

    <port id="pMediaInitialPort" component="mIcon"/>
    <media id="mIcon"           src="media/icon.png"           descriptor="deIcone"/>
    <media id="mExit"   src="media/btnsair.png"    descriptor="deSair"/>
    <media id="mMain"     src="main.lua"         descriptor="deMain">
      <area id="inc"/>
    </media>

    <media id="mFocus" type="application/x-ginga-settings">
      <property name="service.currentKeyMaster" value="idxLua"/>
    </media>

    <media id="settings" type="application/x-ginga-settings">
      <property name="service.currentKeyMaster" value="idxLua"/>
      <property name="service.currentFocus" value=""/>
    </media>
    

    <link id="link_icon"       xconnector="conBase#onSelectionStartStop">
      <bind role="onSelection" component="mIcon" >
        <bindParam name="keyCode" value="ENTER"/>
        </bind>
        <bind role="start"      component="mMain"/>
        <bind role="start"      component="mExit"/>
        <bind role="stop"       component="mIcon"/>
    </link>
    
    
    <link id="link_focoScroll2BEGIN"    xconnector="conBase#onBeginSet">
      <bind role="onBegin"        component="mMain"/>
      <bind role="set"            component="settings" interface="service.currentKeyMaster">
        <bindParam name="value" value="idxLua"/>
      </bind>
    </link>

    <link id="link_focoScroll2END"    xconnector="conBase#onEndSet">
      <bind role="onEnd"              component="mMain" />
      <bind role="set"                component="settings" interface="service.currentKeyMaster">
        <bindParam name="value" value=""/>
      </bind>
    </link>

    <link id="link_Sair"  xconnector="conBase#onSelectionStartStop">
      <bind role="onSelection" component="mExit">
        <bindParam name="keyCode" value="EXIT"/>
      </bind>
      <bind component="mIcon"       role="start"/>
      <bind component="mMain"        role="stop"/>
      <bind component="mExit"        role="stop"/>
    </link>

    
    <link id="link_Sair3"  xconnector="conBase#onBeginStopStart">
      <bind role="onBegin" component="mMain" interface="inc"/>
      <bind component="mMain"      role="stop"/>
      <bind component="mIcon"      role="start"/>
      <bind component="mExit"      role="stop"/>
    </link>

  </body>
</ncl>
