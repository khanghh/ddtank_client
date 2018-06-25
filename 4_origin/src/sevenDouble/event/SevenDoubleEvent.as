package sevenDouble.event
{
   import flash.events.Event;
   
   public class SevenDoubleEvent extends Event
   {
       
      
      public var data:Object;
      
      public function SevenDoubleEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
   }
}
