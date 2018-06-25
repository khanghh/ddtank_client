package lanternriddles.event
{
   import flash.events.Event;
   
   public class LanternEvent extends Event
   {
      
      public static const LANTERN_SELECT:String = "lanternSelect";
      
      public static const LANTERN_SETTIME:String = "lanternSettime";
      
      public static const LANTERN_OPENVIEW:String = "lanternOpenView";
       
      
      public var flag:Boolean;
      
      public var Time:String;
      
      public function LanternEvent(type:String, value:String = "")
      {
         super(type,bubbles,cancelable);
         Time = value;
      }
   }
}
