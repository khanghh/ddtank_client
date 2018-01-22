package gameCommon.model
{
   import ddt.events.LivingEvent;
   
   [Event(name="special_do_action",type="ddt.events.LivingEvent")]
   public class SpecialLiving extends Living
   {
       
      
      public function SpecialLiving(param1:int, param2:int, param3:int, param4:int = 0)
      {
         super(param1,param2,param3,param4);
      }
      
      public function playSpecialMovie(param1:String, param2:Function = null, param3:Array = null) : void
      {
         dispatchEvent(new LivingEvent("special_do_action",0,0,param1,param2,param3));
      }
   }
}
