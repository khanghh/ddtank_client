package morn.core.components{   import flash.display.Shape;   import flash.events.MouseEvent;   import flash.geom.Rectangle;   import morn.core.handlers.Handler;   import morn.core.utils.StringUtils;      [Event(name="change",type="flash.events.Event")]   public class Slider extends Component   {            public static const HORIZONTAL:String = "horizontal";            public static const VERTICAL:String = "vertical";                   protected var _allowBackClick:Boolean;            protected var _max:Number = 100;            protected var _min:Number = 0;            protected var _tick:Number = 1;            protected var _value:Number = 0;            protected var _direction:String = "vertical";            protected var _skin:String;            protected var _back:Image;            protected var _bar:Button;            protected var _progressMask:Shape;            protected var _label:Label;            protected var _showLabel:Boolean = true;            protected var _changeHandler:Handler;            protected var _progressMargin:Array;            protected var _barMargin:Array;            protected var _isBarZero:Boolean;            public function Slider(skin:String = null) { super(); }
            override protected function preinitialize() : void { }
            override protected function createChildren() : void { }
            override protected function initialize() : void { }
            protected function onButtonMouseDown(e:MouseEvent) : void { }
            protected function showValueText() : void { }
            protected function hideValueText() : void { }
            protected function onStageMouseUp(e:MouseEvent) : void { }
            protected function onStageMouseMove(e:MouseEvent) : void { }
            private function updateTexture() : void { }
            protected function sendChangeEvent() : void { }
            public function get skin() : String { return null; }
            public function set skin(value:String) : void { }
            public function set barMargin(value:String) : void { }
            public function get barMargin() : String { return null; }
            public function set progressMargin(value:String) : void { }
            public function get progressMargin() : String { return null; }
            protected function initMask() : void { }
            protected function updateMask() : void { }
            override protected function changeSize() : void { }
            protected function setBarPoint() : void { }
            public function get sizeGrid() : String { return null; }
            public function set sizeGrid(value:String) : void { }
            protected function changeValue() : void { }
            public function setSlider(min:Number, max:Number, value:Number) : void { }
            public function get tick() : Number { return 0; }
            public function set tick(value:Number) : void { }
            public function get max() : Number { return 0; }
            public function set max(value:Number) : void { }
            public function get min() : Number { return 0; }
            public function set min(value:Number) : void { }
            public function get value() : Number { return 0; }
            public function set value(num:Number) : void { }
            public function get direction() : String { return null; }
            public function set direction(value:String) : void { }
            public function get showLabel() : Boolean { return false; }
            public function set showLabel(value:Boolean) : void { }
            public function get allowBackClick() : Boolean { return false; }
            public function set allowBackClick(value:Boolean) : void { }
            protected function onBackBoxMouseDown(e:MouseEvent) : void { }
            override public function set dataSource(value:Object) : void { }
            public function get bar() : Button { return null; }
            protected function get barWidth() : Number { return 0; }
            public function set isBarZero(value:Boolean) : void { }
            public function get changeHandler() : Handler { return null; }
            public function set changeHandler(value:Handler) : void { }
            override public function dispose() : void { }
   }}