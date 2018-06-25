package game.gametrainer
{
   import flash.events.Event;
   
   public class TrainerEvent extends Event
   {
      
      public static const CLOSE_FRAME:String = "closeFrame";
       
      
      public function TrainerEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
   }
}
