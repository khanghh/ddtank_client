package equipretrieve
{
   import flash.events.Event;
   
   public class EquipretrieveEvt extends Event
   {
      
      public static const START_MODEL:String = "start_model";
       
      
      public var obj:Object;
      
      public function EquipretrieveEvt(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         obj = {};
         super(type,bubbles,cancelable);
      }
   }
}
