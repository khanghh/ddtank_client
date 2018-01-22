package panicBuying.event
{
   import flash.events.Event;
   
   public class PanicBuyingEvent extends Event
   {
      
      public static const PANIC_BUYING_OPENVIEW:String = "panicBuyingOpenView";
      
      public static const UPDATE_VIEW:String = "updateView";
       
      
      public var info;
      
      public function PanicBuyingEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
