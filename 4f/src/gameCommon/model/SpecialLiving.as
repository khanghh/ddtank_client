package gameCommon.model
{
   import ddt.events.LivingEvent;
   
   [Event(name="special_do_action",type="ddt.events.LivingEvent")]
   public class SpecialLiving extends Living
   {
       
      
      public function SpecialLiving(param1:int, param2:int, param3:int, param4:int = 0){super(null,null,null,null);}
      
      public function playSpecialMovie(param1:String, param2:Function = null, param3:Array = null) : void{}
   }
}
