package wonderfulActivity.event
{
   import flash.events.Event;
   
   public class WonderfulActivityEvent extends Event
   {
      
      public static const WONDERFULACTIVITY_OPENVIEW:String = "wonderfulActivityOpenView";
      
      public static const WONDERFULACTIVITY_ADDELEMENT:String = "wonderfulActivityAddEment";
      
      public static const SELECTED_CHANGE:String = "selected_change";
      
      public static const CHECK_ACTIVITY_STATE:String = "check_activity_state";
      
      public static const REFRESH:String = "refresh";
       
      
      public var data;
      
      public function WonderfulActivityEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
