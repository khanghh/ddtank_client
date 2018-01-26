package consortion.view.selfConsortia.consortiaTask
{
   import flash.events.Event;
   
   public class ConsortiaTaskEvent extends Event
   {
      
      public static const GETCONSORTIATASKINFO:String = "getConsortiaTaskInfo";
      
      public static const DELAY_TASK_TIME:String = "Consortia_Delay_Task_Time";
       
      
      public var value:int;
      
      public function ConsortiaTaskEvent(param1:String, param2:Boolean = false, param3:Boolean = false){super(null,null,null);}
   }
}
