package morn.core.ex{   import flash.events.MouseEvent;   import flash.utils.getTimer;   import morn.core.components.Component;   import morn.core.components.ISelect;   import morn.core.components.Image;   import morn.core.components.Label;   import morn.core.components.Styles;   import morn.core.events.UIEvent;   import morn.core.handlers.Handler;   import morn.core.utils.ObjectUtils;   import morn.core.utils.StringUtils;      public class TabButtonEx extends Component implements ISelect   {                   protected var _selected:Boolean;            protected var _clickHandler:Handler;            protected var _tabItemBg:Image;            protected var _tabItemBg2:Image;            protected var _offsets:Array;            protected var _skin:String;            protected var _skins:Array;            protected var _toggle:Boolean;            protected var _lastClickTime:int;            protected var _clickInterval:int;            protected var _showClickTooQuickTip:Boolean = false;            protected var _enableRollOverLightEffect:Boolean = true;            protected var _btnLabel:Label;            protected var _labelMargin:Array;            protected var _labelColors:Array;            protected var _autoSize:Boolean = true;            public function TabButtonEx() { super(); }
            override protected function createChildren() : void { }
            override protected function initialize() : void { }
            public function get selected() : Boolean { return false; }
            public function set selected(value:Boolean) : void { }
            public function set skin(value:String) : void { }
            protected function changeLabelSize() : void { }
            public function set offsets(value:String) : void { }
            public function set toggle(value:Boolean) : void { }
            public function set showClickTooQuickTip(value:Boolean) : void { }
            public function set enableRollOverLightEffect(value:Boolean) : void { }
            public function set clickInterval(value:int) : void { }
            protected function changeState() : void { }
            protected function changeSkins() : void { }
            public function get labelColors() : String { return null; }
            public function set labelColors(value:String) : void { }
            public function get clickHandler() : Handler { return null; }
            public function set clickHandler(value:Handler) : void { }
            protected function onMouse(e:MouseEvent) : void { }
            public function get label() : String { return null; }
            public function set label(value:String) : void { }
            public function set labelHtml(value:String) : void { }
            public function get labelStroke() : String { return null; }
            public function set labelStroke(value:String) : void { }
            public function get labelSize() : Object { return null; }
            public function set labelSize(value:Object) : void { }
            public function get labelBold() : Object { return null; }
            public function set labelBold(value:Object) : void { }
            public function get letterSpacing() : Object { return null; }
            public function set letterSpacing(value:Object) : void { }
            public function get labelFont() : String { return null; }
            public function set labelFont(value:String) : void { }
            public function get labelLeading() : Object { return null; }
            public function set labelLeading(value:Object) : void { }
            public function get btnLabel() : Label { return null; }
            override public function dispose() : void { }
   }}