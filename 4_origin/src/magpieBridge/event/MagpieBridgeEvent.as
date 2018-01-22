package magpieBridge.event
{
   import flash.events.Event;
   
   public class MagpieBridgeEvent extends Event
   {
      
      public static const WALK_OVER:String = "walkOver";
      
      public static const SETBTNENABLE:String = "setBtnEnable";
       
      
      public function MagpieBridgeEvent(param1:String)
      {
         super(param1,bubbles,cancelable);
      }
   }
}
