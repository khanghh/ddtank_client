package mysteriousRoullete.event
{
   import flash.events.Event;
   
   public class MysteriousEvent extends Event
   {
      
      public static const MYSTERIOUS_SETTIME:String = "mysteriousSetTime";
      
      public static const CHANG_VIEW:String = "changeView";
      
      public static const SHOW_VIEW:String = "showView";
       
      
      public var viewType:int;
      
      public function MysteriousEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false)
      {
         this.viewType = param2;
         super(param1,param3,param4);
      }
   }
}
