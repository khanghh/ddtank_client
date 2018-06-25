package oldPlayerRegress
{
   import flash.events.Event;
   
   public class RegressEvent extends Event
   {
      
      public static const REGRESS_OPENVIEW:String = "regressOpenView";
      
      public static const REGRESS_UPDATE_TASKMENUITEM:String = "update_taskMenuItem";
      
      public static const REGRESS_ADD_REGRESSBTN:String = "regress_addbtn";
       
      
      public function RegressEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
   }
}
