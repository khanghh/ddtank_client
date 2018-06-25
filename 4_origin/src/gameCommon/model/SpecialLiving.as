package gameCommon.model
{
   import ddt.events.LivingEvent;
   
   [Event(name="special_do_action",type="ddt.events.LivingEvent")]
   public class SpecialLiving extends Living
   {
       
      
      public function SpecialLiving(id:int, team:int, maxBlood:int, templeId:int = 0)
      {
         super(id,team,maxBlood,templeId);
      }
      
      public function playSpecialMovie(type:String, fun:Function = null, args:Array = null) : void
      {
         dispatchEvent(new LivingEvent("special_do_action",0,0,type,fun,args));
      }
   }
}
