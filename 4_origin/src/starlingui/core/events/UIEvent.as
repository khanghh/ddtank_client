package starlingui.core.events
{
   import starling.events.Event;
   
   public class UIEvent extends Event
   {
      
      public static const MOVE:String = "move";
       
      
      public function UIEvent(param1:String, param2:* = null, param3:Boolean = false)
      {
         super(param1,param3,param2);
      }
      
      public function clone() : Event
      {
         return new UIEvent(type,data,bubbles);
      }
   }
}
