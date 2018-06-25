package morn.core.components{   import flash.display.BitmapData;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.geom.Rectangle;   import flash.utils.getTimer;   import morn.core.events.UIEvent;   import morn.core.handlers.Handler;   import morn.core.utils.ObjectUtils;   import morn.core.utils.StringUtils;      [Event(name="change",type="flash.events.Event")]   public class Button extends Component implements ISelect   {            protected static var stateMap:Object = {         "rollOver":1,         "rollOut":0,         "mouseDown":2,         "mouseUp":1,         "selected":2      };                   protected var _content:Sprite;            protected var _bitmap:AutoBitmap;            protected var _btnLabel:Label;            protected var _clickHandler:Handler;            protected var _labelColors:Array;            protected var _labelMargin:Array;            protected var _state:int;            protected var _toggle:Boolean;            protected var _selected:Boolean;            protected var _skin:String;            protected var _autoSize:Boolean = true;            protected var _stateNum:int;            protected var _threeURLs:Array;            protected var _twoURLs:Array;            protected var _imageLabel:String;            protected var _imageLabelSizeGrid:String;            protected var _imageLabelSkins:Array;            protected var _imageLabelClip:AutoBitmap;            protected var _imageLabelX:int;            protected var _imageLabelY:int;            protected var _imageLabelRect:Rectangle;            protected var _enableClickMoveDownEffect:Boolean = true;            protected var _enableRollOverLightEffect:Boolean = true;            protected var _clickInterval:int;            private var _lastClickTime:int;            protected var _showClickTooQuickTip:Boolean = false;            public function Button(skin:String = null, label:String = "") { super(); }
            override protected function createChildren() : void { }
            override protected function initialize() : void { }
            protected function onMouse(e:MouseEvent) : void { }
            private function onStageMouseUp(e:MouseEvent) : void { }
            public function set threeURLs(str:String) : void { }
            public function set twoURLs(str:String) : void { }
            public function set checkButtonSkin(str:String) : void { }
            public function get label() : String { return null; }
            public function set label(value:String) : void { }
            public function set labelHtml(value:String) : void { }
            public function get skin() : String { return null; }
            public function set skin(value:String) : void { }
            protected function changeClips() : void { }
            override public function commitMeasure() : void { }
            protected function changeLabelSize() : void { }
            public function get selected() : Boolean { return false; }
            public function set selected(value:Boolean) : void { }
            protected function get state() : int { return 0; }
            protected function set state(value:int) : void { }
            protected function changeState() : void { }
            public function get toggle() : Boolean { return false; }
            public function set toggle(value:Boolean) : void { }
            override public function set disabled(value:Boolean) : void { }
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
            public function get letterSpacing() : Object { return null; }
            public function set letterSpacing(value:Object) : void { }
            public function get labelFont() : String { return null; }
            public function set labelFont(value:String) : void { }
            public function get labelLeading() : Object { return null; }
            public function set labelLeading(value:Object) : void { }
            public function get clickHandler() : Handler { return null; }
            public function set clickHandler(value:Handler) : void { }
            public function get btnLabel() : Label { return null; }
            public function get sizeGrid() : String { return null; }
            public function set sizeGrid(value:String) : void { }
            override public function set width(value:Number) : void { }
            override public function set height(value:Number) : void { }
            override public function set dataSource(value:Object) : void { }
            public function get stateNum() : int { return 0; }
            public function set stateNum(value:int) : void { }
            public function get imageLabel() : String { return null; }
            public function set imageLabel(value:String) : void { }
            public function get imageLabelX() : int { return 0; }
            public function set imageLabelX(value:int) : void { }
            public function get imageLabelY() : int { return 0; }
            public function set imageLabelY(value:int) : void { }
            public function get bitmap() : AutoBitmap { return null; }
            public function get imageLabelClip() : AutoBitmap { return null; }
            override public function dispose() : void { }
            public function get enableClickMoveDownEffect() : Boolean { return false; }
            public function set enableClickMoveDownEffect(value:Boolean) : void { }
            public function get enableRollOverLightEffect() : Boolean { return false; }
            public function set enableRollOverLightEffect(value:Boolean) : void { }
            public function get clickInterval() : int { return 0; }
            public function set clickInterval(value:int) : void { }
            public function get showClickTooQuickTip() : Boolean { return false; }
            public function set showClickTooQuickTip(value:Boolean) : void { }
            public function get imageLabelSizeGrid() : String { return null; }
            public function set imageLabelSizeGrid(value:String) : void { }
            public function get imageLabelRect() : String { return null; }
            public function set imageLabelRect(value:String) : void { }
   }}