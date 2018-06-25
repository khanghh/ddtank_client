package road7th.data
{
   import flash.events.Event;
   
   public class DictionaryEvent extends Event
   {
      
      public static const ADD:String = "add";
      
      public static const UPDATE:String = "update";
      
      public static const REMOVE:String = "remove";
      
      public static const CLEAR:String = "clear";
       
      
      public var data:Object;
      
      public function DictionaryEvent(type:String, obj:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         data = obj;
         super(type,bubbles,cancelable);
      }
   }
}
