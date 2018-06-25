package church.view.invite
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class ChurchInviteModel extends EventDispatcher
   {
      
      public static const LIST_UPDATE:String = "listupdate";
       
      
      private var _type:int;
      
      private var _currentList:Array;
      
      public function ChurchInviteModel(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public function setList(type:int, data:Array) : void
      {
         _type = type;
         _currentList = data;
         dispatchEvent(new Event("listupdate"));
      }
      
      public function get currentList() : Array
      {
         return _currentList;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function dispose() : void
      {
      }
   }
}
