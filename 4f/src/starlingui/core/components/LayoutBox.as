package starlingui.core.components{   import starling.display.DisplayObject;   import starling.events.Event;      public class LayoutBox extends Box   {                   protected var _space:Number = 0;            protected var _align:String = "none";            protected var _maxX:Number = 0;            protected var _maxY:Number = 0;            public function LayoutBox() { super(); }
            override public function addChild(child:DisplayObject) : DisplayObject { return null; }
            private function setChild(child:DisplayObject) : void { }
            private function onResize(e:Event) : void { }
            override public function addChildAt(child:DisplayObject, index:int) : DisplayObject { return null; }
            override public function removeChild(child:DisplayObject, dispose:Boolean = false) : DisplayObject { return null; }
            override public function removeChildAt(index:int, dispose:Boolean = false) : DisplayObject { return null; }
            override public function commitMeasure() : void { }
            public function refresh() : void { }
            protected function changeItems() : void { }
            public function get space() : Number { return 0; }
            public function set space(value:Number) : void { }
            public function get align() : String { return null; }
            public function set align(value:String) : void { }
   }}