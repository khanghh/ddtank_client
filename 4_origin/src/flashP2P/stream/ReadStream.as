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
      
      public function ReadStream(connection:NetConnection, playerID:int, peerID:String = "connectToFMS")
      {
         super(connection,peerID);
         _playerID = playerID;
         addEventListener("netStatus",__onStreamHandler);
         init();
      }
      
      protected function init() : void
      {
         publish("DDT-P2P-PUBLISH-NAME");
      }
      
      protected function __onStreamHandler(event:NetStatusEvent) : void
      {
         var _loc2_:* = event.info.code;
         if("NetStream.Publish.Start" !== _loc2_)
         {
         }
      }
      
      public function get playerID() : int
      {
         return _playerID;
      }
      
      public function readByteArray(eventType:String, inputByteArray:ByteArray) : void
      {
         dispatchEvent(new StreamEvent("defaultEvent",eventType,inputByteArray));
      }
   }
}
