package Indiana.event
{
   import flash.events.Event;
   
   public class IndianaEvent extends Event
   {
      
      public static const TURN_TO_ANNOUNCED:String = "turn_to_announced";
      
      public static const HISTORY_ITEM_INFO:String = "historyiteminfo";
      
      public static const RECODE_ITEM_INFO:String = "recodeiteminfo";
       
      
      public function IndianaEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
