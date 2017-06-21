<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="portal teste com video" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
  <head>

    <regionBase>
      <region id="rgVideo"  width="100%"        height="100%"    zIndex="1"/>

      <region id="rgMain"    width="100%"    height="100%"       zIndex="3"/>
    </regionBase>

    <descriptorBase>
      <descriptor id="deVideo"      region="rgVideo"/>

      <descriptor id="deMain"    region="rgMain" focusBorderWidth="0" focusIndex="idxLua" />
    </descriptorBase>
    
    <connectorBase>
      <causalConnector id="onBeginSet">
        <connectorParam name="value"/>
        <simpleCondition role="onBegin"/>
        <simpleAction role="set" value="$value"/>
      </causalConnector>

      <causalConnector id="onBeginStart">
        <simpleCondition role="onBegin"/>
        <simpleAction role="start" max="unbounded" qualifier="par"/>
      </causalConnector>

    </connectorBase>

  </head>

  <body>

    <port id="pMediaInitialPort" component="mVideo"/>

    <media id="mMain"     src="main.lua"         descriptor="deMain">
      <area id="inc" label="lMain"/>
    </media>

    <media id="mVideo"  src="teste.mp4"  descriptor="deVideo"/>

    <media id="settings" type="application/x-ginga-settings">
      <property name="service.currentKeyMaster" value="mMain"/>
      <property name="service.currentFocus" value="idXLua"/>
    </media>

    <link id="link_focoScroll2BEGIN"    xconnector="onBeginSet">
      <bind role="onBegin"        component="mMain"/>
      <bind role="set"            component="settings" interface="service.currentKeyMaster">
        <bindParam name="value" value="idxLua"/>
      </bind>
    </link>

    <!-- for sony DLC -->
    <link id="link_start"    xconnector="onBeginStart">
      <bind role="onBegin"        component="mVideo"/>
      <bind role="start"            component="mMain">
        <bindParam name="value" value="idxLua"/>
      </bind>
    </link>

  </body>
</ncl>
