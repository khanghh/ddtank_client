package ddt.events
{
   import flash.events.Event;
   
   public class SharedEvent extends Event
   {
      
      public static const TRANSPARENTCHANGED:String = "transparentChanged";
       
      
      public function SharedEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
   }
}
