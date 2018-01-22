package newChickenBox.events
{
   import flash.events.Event;
   
   public class NewChickenBoxEvents extends Event
   {
      
      public static const GETALLITEMINFO:String = "getalliteminfo";
      
      public static const CHANGEDITEM:String = "changeditem";
      
      public static const CANCLICKENABLE:String = "canclickenable";
       
      
      private var _info:Object = null;
      
      public function NewChickenBoxEvents(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         _info = param2;
         super(param1,param3,param4);
      }
      
      public function get info() : Object
      {
         return _info;
      }
      
      public function set info(param1:Object) : void
      {
         _info = param1;
      }
   }
}
