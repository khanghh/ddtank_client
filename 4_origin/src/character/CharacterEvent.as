package character
{
   import flash.events.Event;
   
   public class CharacterEvent extends Event
   {
      
      public static const ADD_ACTION:String = "addAction";
      
      public static const REMOVE_ACTION:String = "removeAction";
       
      
      private var _data:Object;
      
      public function CharacterEvent(param1:String, param2:Object = null)
      {
         this._data = param2;
         super(param1,bubbles,cancelable);
      }
      
      public function get data() : Object
      {
         return this._data;
      }
   }
}
