package morn.core.components{   import flash.events.Event;   import flash.events.MouseEvent;   import morn.core.handlers.Handler;   import morn.editor.core.IRender;      [Event(name="change",type="flash.events.Event")]   public class Tree extends Box implements IRender   {                   protected var _list:List;            protected var _source:Array;            protected var _xml:XML;            protected var _renderHandler:Handler;            protected var _spaceLeft:Number = 10;            protected var _spaceBottom:Number = 0;            protected var _keepOpenStatus:Boolean = true;            public function Tree() { super(); }
            override protected function createChildren() : void { }
            private function onListChange(e:Event) : void { }
            public function get keepOpenStatus() : Boolean { return false; }
            public function set keepOpenStatus(value:Boolean) : void { }
            public function get array() : Array { return null; }
            public function set array(value:Array) : void { }
            public function get source() : Array { return null; }
            public function get list() : List { return null; }
            public function get itemRender() : * { return null; }
            public function set itemRender(value:*) : void { }
            public function get scrollBarSkin() : String { return null; }
            public function set scrollBarSkin(value:String) : void { }
            public function get mouseHandler() : Handler { return null; }
            public function set mouseHandler(value:Handler) : void { }
            public function get renderHandler() : Handler { return null; }
            public function set renderHandler(value:Handler) : void { }
            public function get spaceLeft() : Number { return 0; }
            public function set spaceLeft(value:Number) : void { }
            public function get spaceBottom() : Number { return 0; }
            public function set spaceBottom(value:Number) : void { }
            public function get selectedIndex() : int { return 0; }
            public function set selectedIndex(value:int) : void { }
            public function get selectedItem() : Object { return null; }
            public function set selectedItem(value:Object) : void { }
            override public function set width(value:Number) : void { }
            override public function set height(value:Number) : void { }
            protected function getArray() : Array { return null; }
            protected function getDepth(item:Object, num:int = 0) : int { return 0; }
            protected function getParentOpenStatus(item:Object) : Boolean { return false; }
            private function renderItem(cell:Box, index:int) : void { }
            private function onArrowClick(e:MouseEvent) : void { }
            override public function set dataSource(value:Object) : void { }
            public function get xml() : XML { return null; }
            public function set xml(value:XML) : void { }
            protected function parseXml(xml:XML, source:Array, nodeParent:Object, isRoot:Boolean) : void { }
            protected function parseOpenStatus(oldSource:Array, newSource:Array) : void { }
            protected function isSameParent(item1:Object, item2:Object) : Boolean { return false; }
            override public function dispose() : void { }
   }}