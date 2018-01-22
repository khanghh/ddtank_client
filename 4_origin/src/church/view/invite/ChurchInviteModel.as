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
      
      public function ChurchInviteModel(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function setList(param1:int, param2:Array) : void
      {
         _type = param1;
         _currentList = param2;
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
