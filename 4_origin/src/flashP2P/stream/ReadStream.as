package flashP2P.stream
{
   import flash.events.NetStatusEvent;
   import flash.net.NetConnection;
   import flash.net.NetStream;
   import flash.utils.ByteArray;
   import flashP2P.event.StreamEvent;
   
   public class ReadStream extends NetStream
   {
       
      
      public const DDT_P2P_PUBLISH_NAME:String = "DDT-P2P-PUBLISH-NAME";
      
      private var _playerID:int;
      
      public function ReadStream(param1:NetConnection, param2:int, param3:String = "connectToFMS")
      {
         super(param1,param3);
         _playerID = param2;
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
      
      public function get playerID() : int
      {
         return _playerID;
      }
      
      public function readByteArray(param1:String, param2:ByteArray) : void
      {
         dispatchEvent(new StreamEvent("defaultEvent",param1,param2));
      }
   }
}
