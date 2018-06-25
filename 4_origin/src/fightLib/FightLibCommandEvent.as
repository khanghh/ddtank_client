package fightLib
{
   import flash.events.Event;
   
   public class FightLibCommandEvent extends Event
   {
      
      public static const WAIT:String = "wait";
      
      public static const FINISH:String = "finish";
       
      
      public function FightLibCommandEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
   }
}
