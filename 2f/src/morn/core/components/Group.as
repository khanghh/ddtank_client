package morn.core.components{   import flash.display.DisplayObject;   import morn.core.handlers.Handler;      [Event(name="change",type="flash.events.Event")]   public class Group extends Box implements IItem   {                   protected var _items:Vector.<ISelect>;            protected var _selectHandler:Handler;            protected var _selectedIndex:int = -1;            protected var _skin:String;            protected var _labels:String;            protected var _labelColors:String;            protected var _labelStroke:String;            protected var _labelSize:Object;            protected var _labelBold:Object;            protected var _labelMargin:String;            protected var _direction:String;            protected var _space:Number = 0;            public function Group(labels:String = null, skin:String = null) { super(); }
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
            public function get labels() : String { return null; }
            public function set labels(value:String) : void { }
            protected function createItem(skin:String, label:String) : DisplayObject { return null; }
            public function get labelColors() : String { return null; }
            public function set labelColors(value:String) : void { }
            public function get labelStroke() : String { return null; }
            public function set labelStroke(value:String) : void { }
            public function get labelSize() : Object { return null; }
            public function set labelSize(value:Object) : void { }
            public function get labelBold() : Object { return null; }
            public function set labelBold(value:Object) : void { }
            public function get labelMargin() : String { return null; }
            public function set labelMargin(value:String) : void { }
            public function get direction() : String { return null; }
            public function set direction(value:String) : void { }
            public function get space() : Number { return 0; }
            public function set space(value:Number) : void { }
            protected function changeLabels() : void { }
            override public function commitMeasure() : void { }
            public function get items() : Vector.<ISelect> { return null; }
            public function get selection() : ISelect { return null; }
            public function set selection(value:ISelect) : void { }
            override public function set dataSource(value:Object) : void { }
            override public function dispose() : void { }
   }}