package ddtActivityIcon
{
   import flash.events.Event;
   
   public class ActivitStateEvent extends Event
   {
       
      
      public var data;
      
      public function ActivitStateEvent(param1:String, param2:*)
      {
         super(param1);
         data = param2;
      }
   }
}
