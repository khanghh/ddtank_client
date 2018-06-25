package morn.core.components{   import flash.display.DisplayObject;   import flash.display.InteractiveObject;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import morn.core.handlers.Handler;      [Event(name="change",type="flash.events.Event")]   public class ScrollBar extends Component   {            public static const HORIZONTAL:String = "horizontal";            public static const VERTICAL:String = "vertical";                   protected var _scrollSize:Number = 1;            protected var _skin:String;            protected var _upButton:Button;            protected var _downButton:Button;            protected var _slider:Slider;            protected var _changeHandler:Handler;            protected var _thumbPercent:Number = 1;            protected var _target:InteractiveObject;            protected var _touchScrollEnable:Boolean;            protected var _mouseWheelEnable:Boolean;            protected var _lastPoint:Point;            protected var _lastOffset:Number = 0;            protected var _autoHide:Boolean = true;            protected var _showButtons:Boolean = true;            protected var _sliderOffset:Number = 1.5;            public function ScrollBar(skin:String = null) { super(); }
            override protected function preinitialize() : void { }
            override protected function createChildren() : void { }
            override protected function initialize() : void { }
            protected function onSliderChange(e:Event) : void { }
            protected function onButtonMouseDown(e:MouseEvent) : void { }
            protected function startLoop(isUp:Boolean) : void { }
            protected function slide(isUp:Boolean) : void { }
            protected function onStageMouseUp(e:MouseEvent) : void { }
            public function get skin() : String { return null; }
            public function set skin(value:String) : void { }
            protected function changeScrollBar() : void { }
            protected function resetButtonPosition() : void { }
            override protected function changeSize() : void { }
            private function resetPositions() : void { }
            public function setScroll(min:Number, max:Number, value:Number) : void { }
            public function get max() : Number { return 0; }
            public function set max(value:Number) : void { }
            public function get min() : Number { return 0; }
            public function set min(value:Number) : void { }
            public function get value() : Number { return 0; }
            public function set value(value:Number) : void { }
            public function get direction() : String { return null; }
            public function set direction(value:String) : void { }
            public function get sizeGrid() : String { return null; }
            public function set sizeGrid(value:String) : void { }
            public function get scrollSize() : Number { return 0; }
            public function set scrollSize(value:Number) : void { }
            override public function set dataSource(value:Object) : void { }
            public function get thumbPercent() : Number { return 0; }
            public function set thumbPercent(value:Number) : void { }
            public function get target() : InteractiveObject { return null; }
            public function set target(value:InteractiveObject) : void { }
            public function get touchScrollEnable() : Boolean { return false; }
            public function set touchScrollEnable(value:Boolean) : void { }
            public function get mouseWheelEnable() : Boolean { return false; }
            public function set mouseWheelEnable(value:Boolean) : void { }
            public function get autoHide() : Boolean { return false; }
            public function set autoHide(value:Boolean) : void { }
            public function get showButtons() : Boolean { return false; }
            public function set showButtons(value:Boolean) : void { }
            public function get changeHandler() : Handler { return null; }
            public function set changeHandler(value:Handler) : void { }
            protected function onTargetMouseDown(e:MouseEvent) : void { }
            protected function onStageEnterFrame(e:Event) : void { }
            protected function onStageMouseUp2(e:MouseEvent) : void { }
            private function tweenMove() : void { }
            public function set sliderOffset(value:Number) : void { }
            public function get sliderOffset() : Number { return 0; }
            protected function onMouseWheel(e:MouseEvent) : void { }
            override public function dispose() : void { }
            public function get slider() : Slider { return null; }
            public function set slider(value:Slider) : void { }
            public function get downButton() : Button { return null; }
            public function set downButton(value:Button) : void { }
            public function get upButton() : Button { return null; }
            public function set upButton(value:Button) : void { }
   }}