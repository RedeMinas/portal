<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="Rede_Minas" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
    <head>
        <connectorBase>
            <causalConnector id="onBeginStart">
                <simpleCondition role="onBegin"/>
                <simpleAction role="start" max="unbounded" qualifier="par"/>
            </causalConnector>

            <causalConnector id="onBeginStop">
                <simpleCondition role="onBegin"/>
                <simpleAction role="stop" max="unbounded" qualifier="par"/>
            </causalConnector>

            <causalConnector id="onEndStop">
                <simpleCondition role="onEnd"/>
                <simpleAction role="stop" max="unbounded" qualifier="par"/>
            </causalConnector>
            <causalConnector id="onEndStart">
                <simpleCondition role="onEnd"/>
                <simpleAction role="start" max="unbounded" qualifier="par"/>
            </causalConnector>

            <causalConnector id="onEndStopStart">
                <simpleCondition role="onEnd"/>
                <compoundAction operator="seq">
                <simpleAction role="stop" max="unbounded" qualifier="seq"/>
                <simpleAction role="start" max="unbounded" qualifier="seq"/>
                </compoundAction>
            </causalConnector>

            <causalConnector id="onBeginStopStart">
                <simpleCondition role="onBegin"/>
                <compoundAction operator="seq">
                    <simpleAction role="start" max="unbounded" qualifier="seq"/>
                    <simpleAction role="stop" max="unbounded" qualifier="seq"/>
                </compoundAction>
            </causalConnector>

            <causalConnector id="onSelectionStart">
                <connectorParam name="keyCode"/>
                <simpleCondition role="onSelection" key="$keyCode"/>
                <compoundAction operator="seq">
                    <simpleAction role="start" max="unbounded" qualifier="seq"/>
                </compoundAction>
            </causalConnector>

            <causalConnector id="onAbortStopStart">
                
                <simpleCondition role="onSelection" />
                <compoundAction operator="seq">
                    <simpleAction role="stop" max="unbounded" qualifier="seq"/>
                    <simpleAction role="start" max="unbounded" qualifier="seq"/>
                </compoundAction>
            </causalConnector>

            <causalConnector id="onSelectionStartStop">
                <connectorParam name="keyCode"/>
                <simpleCondition role="onSelection" key="$keyCode"/>
                <compoundAction operator="seq">
                    <simpleAction role="start" max="unbounded" qualifier="seq"/>
                    <simpleAction role="stop" max="unbounded" qualifier="seq"/>
                </compoundAction>
            </causalConnector>

           <causalConnector id="onBeginIconMenuSetAnim">
                <connectorParam name="vBy" />
                <connectorParam name="vDuration" />
                <connectorParam name="newValue"/>
                <simpleCondition role="onBegin"/>
                <simpleAction role="set" value="$newValue" duration="$vDuration" by="$vBy" />
            </causalConnector>



            <causalConnector id="onEndIconMenuSetAnim">
                <connectorParam name="vBy" />
                <connectorParam name="vDuration" />
                <connectorParam name="newValue"/>
                <simpleCondition role="onEnd"/>
                <simpleAction role="set" value="$newValue" duration="$vDuration" by="$vBy" />
            </causalConnector>
          
             <causalConnector id="onEndIconMenuSetAnimStart">
                <connectorParam name="vBy" />
                <connectorParam name="vDuration" />
                <connectorParam name="newValue"/>
                <simpleCondition role="onBegin"/>
                <simpleAction role="set" value="$newValue" duration="$vDuration" by="$vBy" />
                
                <simpleAction role="start" max="unbounded" qualifier="seq"/>
            </causalConnector>
            <causalConnector id="onSelectionIconMenuResizeVideo">
                <connectorParam name="varSet"/>
                <connectorParam name="keyCode"/>
                <simpleCondition role="onSelection" key="$keyCode"/>
                <compoundAction operator="seq">
                    <simpleAction role="stop" max="unbounded" qualifier="par"/>
                    <simpleAction role="start" max="unbounded" qualifier="par"/>
                    <simpleAction role="set" value="$varSet"/>
                </compoundAction>
            </causalConnector>

            <causalConnector id="onSelectionResizeBackVideo">
                <connectorParam name="varSet"/>
                <connectorParam name="keyCode"/>
                <simpleCondition role="onSelection" key="$keyCode"/>
                <compoundAction operator="seq">
                    <simpleAction role="stop" max="unbounded" qualifier="par"/>
                    <simpleAction role="start" max="unbounded" qualifier="par"/>
                    <simpleAction role="set" value="$varSet"/>
                </compoundAction>
            </causalConnector>

            <causalConnector id="onBeginSet">
                <connectorParam name="value"/>
                <simpleCondition role="onBegin"/>
                <simpleAction role="set" value="$value"/>
            </causalConnector>

         <causalConnector id="onEndSet">
                <connectorParam name="value"/>
                <simpleCondition role="onEnd"/>
                <simpleAction role="set" value="$value"/>
            </causalConnector>
    </connectorBase>
    </head>
</ncl>
