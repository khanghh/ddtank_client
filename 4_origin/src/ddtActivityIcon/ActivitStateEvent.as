package ddtActivityIcon
{
   import flash.events.Event;
   
   public class ActivitStateEvent extends Event
   {
       
      
      public var data;
      
      public function ActivitStateEvent(type:String, $data:*)
      {
         super(type);
         data = $data;
      }
   }
}
