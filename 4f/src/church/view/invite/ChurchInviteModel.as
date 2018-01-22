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
      
      public function ChurchInviteModel(param1:IEventDispatcher = null){super(null);}
      
      public function setList(param1:int, param2:Array) : void{}
      
      public function get currentList() : Array{return null;}
      
      public function get type() : int{return 0;}
      
      public function dispose() : void{}
   }
}
