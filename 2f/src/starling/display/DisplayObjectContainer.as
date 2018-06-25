package starling.display{   import flash.geom.Matrix;   import flash.geom.Point;   import flash.geom.Rectangle;   import flash.system.Capabilities;   import flash.utils.getQualifiedClassName;   import starling.core.RenderSupport;   import starling.errors.AbstractClassError;   import starling.events.Event;   import starling.filters.FragmentFilter;   import starling.utils.MatrixUtil;      public class DisplayObjectContainer extends DisplayObject   {            private static var sHelperMatrix:Matrix = new Matrix();            private static var sHelperPoint:Point = new Point();            private static var sBroadcastListeners:Vector.<DisplayObject> = new Vector.<DisplayObject>(0);            private static var sSortBuffer:Vector.<DisplayObject> = new Vector.<DisplayObject>(0);                   private var mChildren:Vector.<DisplayObject>;            private var mTouchGroup:Boolean;            public function DisplayObjectContainer() { super(); }
            private static function mergeSort(input:Vector.<DisplayObject>, compareFunc:Function, startIndex:int, length:int, buffer:Vector.<DisplayObject>) : void { }
            override public function dispose() : void { }
            public function addChild(child:DisplayObject) : DisplayObject { return null; }
            public function addChildAt(child:DisplayObject, index:int) : DisplayObject { return null; }
            public function removeChild(child:DisplayObject, dispose:Boolean = false) : DisplayObject { return null; }
            public function removeChildAt(index:int, dispose:Boolean = false) : DisplayObject { return null; }
            public function removeChildren(beginIndex:int = 0, endIndex:int = -1, dispose:Boolean = false) : void { }
            public function getChildAt(index:int) : DisplayObject { return null; }
            public function getChildByName(name:String) : DisplayObject { return null; }
            public function getChildIndex(child:DisplayObject) : int { return 0; }
            public function setChildIndex(child:DisplayObject, index:int) : void { }
            public function swapChildren(child1:DisplayObject, child2:DisplayObject) : void { }
            public function swapChildrenAt(index1:int, index2:int) : void { }
            public function sortChildren(compareFunction:Function) : void { }
            public function contains(child:DisplayObject) : Boolean { return false; }
            override public function getBounds(targetSpace:DisplayObject, resultRect:Rectangle = null) : Rectangle { return null; }
            override public function hitTest(localPoint:Point, forTouch:Boolean = false) : DisplayObject { return null; }
            override public function render(support:RenderSupport, parentAlpha:Number) : void { }
            public function broadcastEvent(event:Event) : void { }
            public function broadcastEventWith(type:String, data:Object = null) : void { }
            public function get numChildren() : int { return 0; }
            public function get touchGroup() : Boolean { return false; }
            public function set touchGroup(value:Boolean) : void { }
            private function spliceChildren(startIndex:int, deleteCount:uint = 4294967295, insertee:DisplayObject = null) : void { }
            protected function getChildEventListeners(object:DisplayObject, eventType:String, listeners:Vector.<DisplayObject>) : void { }
   }}