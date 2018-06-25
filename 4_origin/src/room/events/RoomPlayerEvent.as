package room.events
{
   import flash.events.Event;
   
   public class RoomPlayerEvent extends Event
   {
      
      public static const READY_CHANGE:String = "readyChange";
      
      public static const IS_HOST_CHANGE:String = "isHostChange";
      
      public static const PROGRESS_CHANGE:String = "progressChange";
       
      
      public function RoomPlayerEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
   }
}
