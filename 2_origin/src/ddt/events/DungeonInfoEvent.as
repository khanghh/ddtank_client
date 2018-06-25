package ddt.events
{
   import flash.events.Event;
   
   public class DungeonInfoEvent extends Event
   {
      
      public static const DungeonHelpChanged:String = "DungeonHelpChanged";
       
      
      public function DungeonInfoEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
   }
}
