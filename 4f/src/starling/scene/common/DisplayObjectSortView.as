package starling.scene.common{   import starling.display.DisplayObject;   import starling.display.Sprite;      public class DisplayObjectSortView extends Sprite   {                   private var _disObjArr:Array;            public function DisplayObjectSortView() { super(); }
            public function addDisplayObject(value:DisplayObject) : void { }
            public function removeDisplayObject(value:DisplayObject, dispose:Boolean) : void { }
            public function removeDisplayObjectByType(typeClazz:Class, dispose:Boolean) : void { }
            public function removeDisplayObjectByIndex(index:int, dispose:Boolean) : void { }
            public function indexOfDisplayObject(value:DisplayObject) : int { return 0; }
            public function indexOfDisplayObjectByFun(checkFun:Function) : int { return 0; }
            public function getDisplayObjectByIndex(index:int) : * { return null; }
            public function sortDisplayObjectLayer() : void { }
            public function get disObjArr() : Array { return null; }
            override public function dispose() : void { }
   }}