package consortionBattle.event
{
   import flash.events.Event;
   
   public class ConsBatEvent extends Event
   {
       
      
      public var data:Object;
      
      public function ConsBatEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
   }
}
