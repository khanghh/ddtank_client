package worldBossHelper.event
{
   import flash.events.Event;
   
   public class WorldBossHelperEvent extends Event
   {
      
      public static const BOSS_OPEN:String = "bossOpen";
      
      public static const CHANGE_HELPER_STATE:String = "changeHelperState";
       
      
      public var state:Boolean;
      
      public function WorldBossHelperEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
   }
}
