package oldPlayerRegress
{
   import flash.events.Event;
   
   public class RegressEvent extends Event
   {
      
      public static const REGRESS_OPENVIEW:String = "regressOpenView";
      
      public static const REGRESS_UPDATE_TASKMENUITEM:String = "update_taskMenuItem";
      
      public static const REGRESS_ADD_REGRESSBTN:String = "regress_addbtn";
       
      
      public function RegressEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
