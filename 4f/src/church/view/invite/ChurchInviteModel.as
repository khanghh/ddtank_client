package church.view.invite{   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;      public class ChurchInviteModel extends EventDispatcher   {            public static const LIST_UPDATE:String = "listupdate";                   private var _type:int;            private var _currentList:Array;            public function ChurchInviteModel(target:IEventDispatcher = null) { super(null); }
            public function setList(type:int, data:Array) : void { }
            public function get currentList() : Array { return null; }
            public function get type() : int { return 0; }
            public function dispose() : void { }
   }}