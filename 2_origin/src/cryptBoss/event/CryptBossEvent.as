package cryptBoss.event
{
   import flash.events.Event;
   
   public class CryptBossEvent extends Event
   {
      
      public static const GET_BOSS_DATA:int = 1;
      
      public static const UPDATE_SINGLEBOSS_DATA:int = 2;
      
      public static const FIGHT:int = 3;
      
      public static const CRYPTBOSS_OPENVIEW:String = "cryptBossOpenView";
      
      public static const CRYPTBOSS_UPDATEVIEW:String = "cryptBossUpdateView";
       
      
      public function CryptBossEvent(param1:String)
      {
         super(param1,bubbles,cancelable);
      }
   }
}
