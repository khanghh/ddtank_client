package flashP2P.event
{
   import flash.events.Event;
   import flash.utils.ByteArray;
   
   public class StreamEvent extends Event
   {
      
      public static const DEFAULT_EVENT:String = "defaultEvent";
      
      public static const PRIVATE_MSG:String = "PrivateMsg";
      
      public static const LOOK_PLAYER_INFO:String = "LookPlayerInfo";
      
      public static const SHOW_PLAYER_INFO:String = "ShowPlayerInfo";
       
      
      public var readByteArray:ByteArray;
      
      public var eventType:String;
      
      public function StreamEvent(param1:String, param2:String = "", param3:ByteArray = null, param4:Boolean = false, param5:Boolean = false)
      {
         eventType = param2;
         readByteArray = param3;
         super(param1,param4,param5);
      }
   }
}
