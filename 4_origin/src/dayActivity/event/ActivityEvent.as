package dayActivity.event
{
   import flash.events.Event;
   
   public class ActivityEvent extends Event
   {
      
      public static var SEND_GOOD:String = "send_good";
      
      public static var UPDATE_COUNT:String = "update_count";
       
      
      public var id:int;
      
      public function ActivityEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
