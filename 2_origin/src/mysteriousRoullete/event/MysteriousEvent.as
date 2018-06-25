package mysteriousRoullete.event
{
   import flash.events.Event;
   
   public class MysteriousEvent extends Event
   {
      
      public static const MYSTERIOUS_SETTIME:String = "mysteriousSetTime";
      
      public static const CHANG_VIEW:String = "changeView";
      
      public static const SHOW_VIEW:String = "showView";
       
      
      public var viewType:int;
      
      public function MysteriousEvent(type:String, viewType:int, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         this.viewType = viewType;
         super(type,bubbles,cancelable);
      }
   }
}
