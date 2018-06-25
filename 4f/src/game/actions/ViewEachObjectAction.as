package game.actions{   import game.view.map.MapView;   import gameCommon.actions.BaseAction;      public class ViewEachObjectAction extends BaseAction   {                   private var _map:MapView;            private var _objects:Array;            private var _interval:Number;            private var _index:int;            private var _count:int;            private var _type:int;            public function ViewEachObjectAction(map:MapView, objects:Array, type:int = 0, interval:Number = 1500) { super(); }
            override public function canReplace(action:BaseAction) : Boolean { return false; }
            override public function execute() : void { }
            public function get objects() : Array { return null; }
   }}