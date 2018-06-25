package newChickenBox.events
{
   import flash.events.Event;
   
   public class NewChickenBoxEvents extends Event
   {
      
      public static const GETALLITEMINFO:String = "getalliteminfo";
      
      public static const CHANGEDITEM:String = "changeditem";
      
      public static const CANCLICKENABLE:String = "canclickenable";
       
      
      private var _info:Object = null;
      
      public function NewChickenBoxEvents(type:String, info:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         _info = info;
         super(type,bubbles,cancelable);
      }
      
      public function get info() : Object
      {
         return _info;
      }
      
      public function set info(value:Object) : void
      {
         _info = value;
      }
   }
}
