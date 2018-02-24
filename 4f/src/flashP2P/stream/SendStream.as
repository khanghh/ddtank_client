package flashP2P.stream
{
   import flash.events.NetStatusEvent;
   import flash.net.NetConnection;
   import flash.net.NetStream;
   
   public class SendStream extends NetStream
   {
       
      
      public const DDT_P2P_PUBLISH_NAME:String = "DDT-P2P-PUBLISH-NAME";
      
      private var _playerID:int;
      
      public function SendStream(param1:NetConnection, param2:String = "connectToFMS"){super(null,null);}
      
      protected function init() : void{}
      
      protected function __onStreamHandler(param1:NetStatusEvent) : void{}
   }
}
