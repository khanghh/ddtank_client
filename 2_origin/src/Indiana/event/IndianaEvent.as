package Indiana.event
{
   import flash.events.Event;
   
   public class IndianaEvent extends Event
   {
      
      public static const TURN_TO_ANNOUNCED:String = "turn_to_announced";
      
      public static const HISTORY_ITEM_INFO:String = "historyiteminfo";
      
      public static const RECODE_ITEM_INFO:String = "recodeiteminfo";
       
      
      public function IndianaEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
   }
}
