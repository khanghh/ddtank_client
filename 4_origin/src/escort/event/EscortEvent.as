package escort.event
{
   import flash.events.Event;
   
   public class EscortEvent extends Event
   {
       
      
      public var data:Object;
      
      public function EscortEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
