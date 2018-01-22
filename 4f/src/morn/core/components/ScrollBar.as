package morn.core.components
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import morn.core.handlers.Handler;
   
   [Event(name="change",type="flash.events.Event")]
   public class ScrollBar extends Component
   {
      
      public static const HORIZONTAL:String = "horizontal";
      
      public static const VERTICAL:String = "vertical";
       
      
      protected var _scrollSize:Number = 1;
      
      protected var _skin:String;
      
      protected var _upButton:Button;
      
      protected var _downButton:Button;
      
      protected var _slider:Slider;
      
      protected var _changeHandler:Handler;
      
      protected var _thumbPercent:Number = 1;
      
      protected var _target:InteractiveObject;
      
      protected var _touchScrollEnable:Boolean;
      
      protected var _mouseWheelEnable:Boolean;
      
      protected var _lastPoint:Point;
      
      protected var _lastOffset:Number = 0;
      
      protected var _autoHide:Boolean = true;
      
      protected var _showButtons:Boolean = true;
      
      protected var _sliderOffset:Number = 1.5;
      
      public function ScrollBar(param1:String = null){super();}
      
      override protected function preinitialize() : void{}
      
      override protected function createChildren() : void{}
      
      override protected function initialize() : void{}
      
      protected function onSliderChange(param1:Event) : void{}
      
      protected function onButtonMouseDown(param1:MouseEvent) : void{}
      
      protected function startLoop(param1:Boolean) : void{}
      
      protected function slide(param1:Boolean) : void{}
      
      protected function onStageMouseUp(param1:MouseEvent) : void{}
      
      public function get skin() : String{return null;}
      
      public function set skin(param1:String) : void{}
      
      protected function changeScrollBar() : void{}
      
      protected function resetButtonPosition() : void{}
      
      override protected function changeSize() : void{}
      
      private function resetPositions() : void{}
      
      public function setScroll(param1:Number, param2:Number, param3:Number) : void{}
      
      public function get max() : Number{return 0;}
      
      public function set max(param1:Number) : void{}
      
      public function get min() : Number{return 0;}
      
      public function set min(param1:Number) : void{}
      
      public function get value() : Number{return 0;}
      
      public function set value(param1:Number) : void{}
      
      public function get direction() : String{return null;}
      
      public function set direction(param1:String) : void{}
      
      public function get sizeGrid() : String{return null;}
      
      public function set sizeGrid(param1:String) : void{}
      
      public function get scrollSize() : Number{return 0;}
      
      public function set scrollSize(param1:Number) : void{}
      
      override public function set dataSource(param1:Object) : void{}
      
      public function get thumbPercent() : Number{return 0;}
      
      public function set thumbPercent(param1:Number) : void{}
      
      public function get target() : InteractiveObject{return null;}
      
      public function set target(param1:InteractiveObject) : void{}
      
      public function get touchScrollEnable() : Boolean{return false;}
      
      public function set touchScrollEnable(param1:Boolean) : void{}
      
      public function get mouseWheelEnable() : Boolean{return false;}
      
      public function set mouseWheelEnable(param1:Boolean) : void{}
      
      public function get autoHide() : Boolean{return false;}
      
      public function set autoHide(param1:Boolean) : void{}
      
      public function get showButtons() : Boolean{return false;}
      
      public function set showButtons(param1:Boolean) : void{}
      
      public function get changeHandler() : Handler{return null;}
      
      public function set changeHandler(param1:Handler) : void{}
      
      protected function onTargetMouseDown(param1:MouseEvent) : void{}
      
      protected function onStageEnterFrame(param1:Event) : void{}
      
      protected function onStageMouseUp2(param1:MouseEvent) : void{}
      
      private function tweenMove() : void{}
      
      public function set sliderOffset(param1:Number) : void{}
      
      public function get sliderOffset() : Number{return 0;}
      
      protected function onMouseWheel(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
      
      public function get slider() : Slider{return null;}
      
      public function set slider(param1:Slider) : void{}
      
      public function get downButton() : Button{return null;}
      
      public function set downButton(param1:Button) : void{}
      
      public function get upButton() : Button{return null;}
      
      public function set upButton(param1:Button) : void{}
   }
}
