package flashP2P.stream
{
   import flash.events.NetStatusEvent;
   import flash.net.NetConnection;
   import flash.net.NetStream;
   
   public class SendStream extends NetStream
   {
       
      
      public const DDT_P2P_PUBLISH_NAME:String = "DDT-P2P-PUBLISH-NAME";
      
      private var _playerID:int;
      
      public function SendStream(param1:NetConnection, param2:String = "connectToFMS")
      {
         super(param1,param2);
         addEventListener("netStatus",__onStreamHandler);
         init();
      }
      
      protected function init() : void
      {
         publish("DDT-P2P-PUBLISH-NAME");
      }
      
      protected function __onStreamHandler(param1:NetStatusEvent) : void
      {
         var _loc2_:* = param1.info.code;
         if("NetStream.Publish.Start" !== _loc2_)
         {
         }
      }
   }
}
