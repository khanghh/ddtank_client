package sevenDayTarget.events
{
   import flash.events.Event;
   
   public class SevenDayTargetEvents extends Event
   {
      
      public static const OPEN_CLOSE:String = "open_close";
      
      public static const SEVENDAYTARGET_ENTER:String = "sevendaytarget_enter";
      
      public static const SEVENDAYTARGET_GET_REWARD:String = "sevendaytarget_getreward";
       
      
      public function SevenDayTargetEvents(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
