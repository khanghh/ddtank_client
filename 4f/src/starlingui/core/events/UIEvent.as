package starlingui.core.events
{
   import starling.events.Event;
   
   public class UIEvent extends Event
   {
      
      public static const MOVE:String = "move";
       
      
      public function UIEvent(param1:String, param2:* = null, param3:Boolean = false){super(null,null,null);}
      
      public function clone() : Event{return null;}
   }
}
