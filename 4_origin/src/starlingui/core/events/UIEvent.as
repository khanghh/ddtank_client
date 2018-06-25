package starlingui.core.events
{
   import starling.events.Event;
   
   public class UIEvent extends Event
   {
      
      public static const MOVE:String = "move";
       
      
      public function UIEvent($type:String, $data:* = null, $bubbles:Boolean = false)
      {
         super($type,$bubbles,$data);
      }
      
      public function clone() : Event
      {
         return new UIEvent(type,data,bubbles);
      }
   }
}
