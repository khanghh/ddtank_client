package gameStarling.actions{   import gameCommon.actions.BaseAction;   import gameStarling.view.map.MapView3D;      public class ViewEachObjectAction extends BaseAction   {                   private var _map:MapView3D;            private var _objects:Array;            private var _interval:Number;            private var _index:int;            private var _count:int;            private var _type:int;            public function ViewEachObjectAction(map:MapView3D, objects:Array, type:int = 0, interval:Number = 1500) { super(); }
            override public function canReplace(action:BaseAction) : Boolean { return false; }
            override public function execute() : void { }
            public function get objects() : Array { return null; }
   }}