package morn.core.components{   import flash.display.DisplayObject;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.text.TextFormat;   import morn.core.handlers.Handler;   import morn.core.utils.ObjectUtils;   import morn.core.utils.StringUtils;      [Event(name="change",type="flash.events.Event")]   public class ComboBox extends Component   {            public static const UP:String = "up";            public static const DOWN:String = "down";                   protected var _visibleNum:int = 6;            protected var _button:Button;            protected var _listBg:Image;            protected var _list:List;            protected var _isOpen:Boolean;            protected var _scrollBar:VScrollBar;            protected var _itemColors:Array;            protected var _itemSize:int;            protected var _labels:Array;            protected var _selectedIndex:int = -1;            protected var _selectHandler:Handler;            protected var _itemHeight:Number;            protected var _itemH:Number;            protected var _itemLabelMargin:String = "";            protected var _itemLabelStroke:String = "";            protected var _listHeight:Number;            protected var _itemClipUrl:String;            protected var _itemSteateNum:int = 1;            protected var _itemSizeGride:String;            public var canForceChange:Boolean;            public function ComboBox(skin:String = null, labels:String = null) { super(); }
            override protected function preinitialize() : void { }
            override protected function createChildren() : void { }
            override protected function initialize() : void { }
            private function onButtonMouseDown(e:MouseEvent) : void { }
            protected function onListChange(e:Event) : void { }
            public function get skin() : String { return null; }
            public function set skin(value:String) : void { }
            public function set imageLabel(value:String) : void { }
            public function set imageLabelX(value:int) : void { }
            public function set imageLabelY(value:int) : void { }
            public function set imageLabelSizeGrid(value:String) : void { }
            public function set imageLabelRect(value:String) : void { }
            public function set enableClickMoveDownEffect(value:Boolean) : void { }
            public function set listSkin(value:String) : void { }
            public function set listSizeGrid(value:String) : void { }
            public function set itemSizeGride(value:String) : void { }
            public function set itemSteateNum(value:int) : void { }
            public function set itemClipUrl(value:String) : void { }
            public function set itemHeight(value:Number) : void { }
            public function set itemLabelMargin(value:String) : void { }
            public function set itemLabelStroke(value:String) : void { }
            protected function changeList() : void { }
            protected function onlistItemMouse(e:MouseEvent, index:int) : void { }
            protected function changeOpen() : void { }
            override public function set width(value:Number) : void { }
            override public function set height(value:Number) : void { }
            public function get labels() : String { return null; }
            public function set labels(value:String) : void { }
            protected function changeItem() : void { }
            public function get selectedIndex() : int { return 0; }
            public function set selectedIndex(value:int) : void { }
            public function resetSelect() : void { }
            public function get selectHandler() : Handler { return null; }
            public function set selectHandler(value:Handler) : void { }
            public function get selectedLabel() : String { return null; }
            public function set selectedLabel(value:String) : void { }
            public function get visibleNum() : int { return 0; }
            public function set visibleNum(value:int) : void { }
            public function get itemColors() : String { return null; }
            public function set itemColors(value:String) : void { }
            public function get itemSize() : int { return 0; }
            public function set itemSize(value:int) : void { }
            public function get isOpen() : Boolean { return false; }
            public function set isOpen(value:Boolean) : void { }
            protected function removeList(e:Event) : void { }
            public function get scrollBarSkin() : String { return null; }
            public function set scrollBarSkin(value:String) : void { }
            public function get sizeGrid() : String { return null; }
            public function set sizeGrid(value:String) : void { }
            public function get scrollBar() : VScrollBar { return null; }
            public function get button() : Button { return null; }
            public function get list() : List { return null; }
            override public function set dataSource(value:Object) : void { }
            public function get labelColors() : String { return null; }
            public function set labelColors(value:String) : void { }
            public function get labelMargin() : String { return null; }
            public function set labelMargin(value:String) : void { }
            public function get labelStroke() : String { return null; }
            public function set labelStroke(value:String) : void { }
            public function get labelSize() : Object { return null; }
            public function set labelSize(value:Object) : void { }
            public function get labelBold() : Object { return null; }
            public function set labelBold(value:Object) : void { }
            public function get labelFont() : String { return null; }
            public function set labelFont(value:String) : void { }
            public function set buttonLabel(value:String) : void { }
            public function get stateNum() : int { return 0; }
            public function set stateNum(value:int) : void { }
            override public function dispose() : void { }
   }}