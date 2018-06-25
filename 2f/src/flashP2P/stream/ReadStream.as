package flashP2P.stream{   import flash.events.NetStatusEvent;   import flash.net.NetConnection;   import flash.net.NetStream;   import flash.utils.ByteArray;   import flashP2P.event.StreamEvent;      public class ReadStream extends NetStream   {                   public const DDT_P2P_PUBLISH_NAME:String = "DDT-P2P-PUBLISH-NAME";            private var _playerID:int;            public function ReadStream(connection:NetConnection, playerID:int, peerID:String = "connectToFMS") { super(null,null); }
            protected function init() : void { }
            protected function __onStreamHandler(event:NetStatusEvent) : void { }
            public function get playerID() : int { return 0; }
            public function readByteArray(eventType:String, inputByteArray:ByteArray) : void { }
   }}