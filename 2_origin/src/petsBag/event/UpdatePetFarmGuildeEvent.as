package petsBag.event
{
   import flash.events.Event;
   
   public class UpdatePetFarmGuildeEvent extends Event
   {
      
      public static const FINISH:String = "finish";
       
      
      public var data:Object;
      
      public function UpdatePetFarmGuildeEvent(type:String, obj:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         data = obj;
         super(type,bubbles,cancelable);
      }
   }
}
