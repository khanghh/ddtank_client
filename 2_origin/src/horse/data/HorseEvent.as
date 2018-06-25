package horse.data
{
   import flash.events.Event;
   
   public class HorseEvent extends Event
   {
       
      
      private var _data:Object;
      
      public function HorseEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         _data = data;
         super(type,bubbles,cancelable);
      }
      
      public function get data() : Object
      {
         return _data;
      }
   }
}
