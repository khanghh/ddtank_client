package morn.core.ex{   import com.pickgliss.utils.ObjectUtils;   import flash.display.DisplayObject;   import morn.core.components.Box;   import morn.core.components.IItem;   import morn.core.components.ISelect;   import morn.core.handlers.Handler;      public class GroupEx extends Box implements IItem   {                   protected var _items:Vector.<ISelect>;            protected var _selectHandler:Handler;            protected var _selectedIndex:int = -1;            protected var _skin:String;            protected var _imageLabels:String;            protected var _direction:String;            protected var _space:Number = 0;            public function GroupEx(imageLabels:String = null, skin:String = null) { super(); }
            public function addItem(item:ISelect, autoLayOut:Boolean = true) : int { return 0; }
            public function delItem(item:ISelect, autoLayOut:Boolean = true) : void { }
            public function initItems() : void { }
            protected function itemClick(index:int) : void { }
            public function resetSelect() : void { }
            public function get selectedIndex() : int { return 0; }
            public function set selectedIndex(value:int) : void { }
            public function set selectedIndexWithoutEvent(value:int) : void { }
            protected function setSelect(index:int, selected:Boolean) : void { }
            public function get selectHandler() : Handler { return null; }
            public function set selectHandler(value:Handler) : void { }
            public function get skin() : String { return null; }
            public function set skin(value:String) : void { }
            public function get imageLabels() : String { return null; }
            public function set imageLabels(value:String) : void { }
            protected function createItem(skin:String, imageLabel:String) : DisplayObject { return null; }
            public function get direction() : String { return null; }
            public function set direction(value:String) : void { }
            public function get space() : Number { return 0; }
            public function set space(value:Number) : void { }
            protected function changeImageLabels() : void { }
            override public function commitMeasure() : void { }
            public function get items() : Vector.<ISelect> { return null; }
            public function get selection() : ISelect { return null; }
            public function set selection(value:ISelect) : void { }
            override public function set dataSource(value:Object) : void { }
            override public function dispose() : void { }
   }}