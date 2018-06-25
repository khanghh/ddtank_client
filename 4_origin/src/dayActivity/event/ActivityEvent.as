package dayActivity.event
{
   import flash.events.Event;
   
   public class ActivityEvent extends Event
   {
      
      public static var SEND_GOOD:String = "send_good";
      
      public static var UPDATE_COUNT:String = "update_count";
       
      
      public var id:int;
      
      public function ActivityEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
   }
}
