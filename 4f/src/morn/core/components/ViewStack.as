package morn.core.components{   import flash.display.DisplayObject;   import morn.core.handlers.Handler;      public class ViewStack extends Box implements IItem   {                   protected var _items:Vector.<DisplayObject>;            protected var _setIndexHandler:Handler;            protected var _selectedIndex:int;            public function ViewStack() { super(); }
            public function setItems(views:Array) : void { }
            public function addItem(view:DisplayObject) : void { }
            public function initItems() : void { }
            public function get selectedIndex() : int { return 0; }
            public function set selectedIndex(value:int) : void { }
            protected function setSelect(index:int, selected:Boolean) : void { }
            public function get selection() : DisplayObject { return null; }
            public function set selection(value:DisplayObject) : void { }
            public function get setIndexHandler() : Handler { return null; }
            public function set setIndexHandler(value:Handler) : void { }
            protected function setIndex(index:int) : void { }
            public function get items() : Vector.<DisplayObject> { return null; }
            override public function set dataSource(value:Object) : void { }
            override public function dispose() : void { }
   }}