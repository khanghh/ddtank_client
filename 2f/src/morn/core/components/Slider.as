package morn.core.components
{
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import morn.core.handlers.Handler;
   import morn.core.utils.StringUtils;
   
   [Event(name="change",type="flash.events.Event")]
   public class Slider extends Component
   {
      
      public static const HORIZONTAL:String = "horizontal";
      
      public static const VERTICAL:String = "vertical";
       
      
      protected var _allowBackClick:Boolean;
      
      protected var _max:Number = 100;
      
      protected var _min:Number = 0;
      
      protected var _tick:Number = 1;
      
      protected var _value:Number = 0;
      
      protected var _direction:String = "vertical";
      
      protected var _skin:String;
      
      protected var _back:Image;
      
      protected var _bar:Button;
      
      protected var _progressMask:Shape;
      
      protected var _label:Label;
      
      protected var _showLabel:Boolean = true;
      
      protected var _changeHandler:Handler;
      
      protected var _progressMargin:Array;
      
      protected var _barMargin:Array;
      
      protected var _isBarZero:Boolean;
      
      public function Slider(param1:String = null){super();}
      
      override protected function preinitialize() : void{}
      
      override protected function createChildren() : void{}
      
      override protected function initialize() : void{}
      
      protected function onButtonMouseDown(param1:MouseEvent) : void{}
      
      protected function showValueText() : void{}
      
      protected function hideValueText() : void{}
      
      protected function onStageMouseUp(param1:MouseEvent) : void{}
      
      protected function onStageMouseMove(param1:MouseEvent) : void{}
      
      private function updateTexture() : void{}
      
      protected function sendChangeEvent() : void{}
      
      public function get skin() : String{return null;}
      
      public function set skin(param1:String) : void{}
      
      public function set barMargin(param1:String) : void{}
      
      public function get barMargin() : String{return null;}
      
      public function set progressMargin(param1:String) : void{}
      
      public function get progressMargin() : String{return null;}
      
      protected function initMask() : void{}
      
      protected function updateMask() : void{}
      
      override protected function changeSize() : void{}
      
      protected function setBarPoint() : void{}
      
      public function get sizeGrid() : String{return null;}
      
      public function set sizeGrid(param1:String) : void{}
      
      protected function changeValue() : void{}
      
      public function setSlider(param1:Number, param2:Number, param3:Number) : void{}
      
      public function get tick() : Number{return 0;}
      
      public function set tick(param1:Number) : void{}
      
      public function get max() : Number{return 0;}
      
      public function set max(param1:Number) : void{}
      
      public function get min() : Number{return 0;}
      
      public function set min(param1:Number) : void{}
      
      public function get value() : Number{return 0;}
      
      public function set value(param1:Number) : void{}
      
      public function get direction() : String{return null;}
      
      public function set direction(param1:String) : void{}
      
      public function get showLabel() : Boolean{return false;}
      
      public function set showLabel(param1:Boolean) : void{}
      
      public function get allowBackClick() : Boolean{return false;}
      
      public function set allowBackClick(param1:Boolean) : void{}
      
      protected function onBackBoxMouseDown(param1:MouseEvent) : void{}
      
      override public function set dataSource(param1:Object) : void{}
      
      public function get bar() : Button{return null;}
      
      protected function get barWidth() : Number{return 0;}
      
      public function set isBarZero(param1:Boolean) : void{}
      
      public function get changeHandler() : Handler{return null;}
      
      public function set changeHandler(param1:Handler) : void{}
      
      override public function dispose() : void{}
   }
}
