package worldBossHelper.event
{
   import flash.events.Event;
   
   public class WorldBossHelperEvent extends Event
   {
      
      public static const BOSS_OPEN:String = "bossOpen";
      
      public static const CHANGE_HELPER_STATE:String = "changeHelperState";
       
      
      public var state:Boolean;
      
      public function WorldBossHelperEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
