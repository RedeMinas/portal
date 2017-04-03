<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="portal:somente menu ribalta" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
  <head>

    <regionBase>
      <region id="rgMain"    width="100%"    height="100%"       zIndex="3"/>
    </regionBase>

    <descriptorBase>
      <descriptor id="deMain"    region="rgMain" focusBorderWidth="0" focusIndex="idxLua" />
    </descriptorBase>

    <connectorBase>
      <causalConnector id="onBeginSet">
        <connectorParam name="value"/>
        <simpleCondition role="onBegin"/>
        <simpleAction role="set" value="$value"/>
      </causalConnector>
    </connectorBase>

  </head>

  <body>

    <port id="pMediaInitialPort" component="mMain"/>

    <media id="mMain"     src="ribalta.lua"         descriptor="deMain">
      <area id="inc" label="lMain"/>
    </media>

    <media id="settings" type="application/x-ginga-settings">
      <property name="service.currentKeyMaster" value="mMain"/>
      <property name="service.currentFocus" value="idXLua"/>
    </media>

    <!-- for sony DLC -->
    <link id="link_focoScroll2BEGIN"    xconnector="onBeginSet">
      <bind role="onBegin"        component="mMain"/>
      <bind role="set"            component="settings" interface="service.currentKeyMaster">
        <bindParam name="value" value="idxLua"/>
      </bind>
    </link>

  </body>
</ncl>
