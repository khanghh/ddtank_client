package starlingui.core.components
{
   import starling.display.DisplayObject;
   import starling.display.Shape;
   import starling.display.Sprite;
   import starling.events.Event;
   import starlingui.core.events.UIEvent;
   import starlingui.editor.core.IComponent;
   
   [Event(name="resize",type="flash.events.Event")]
   [Event(name="move",type="morn.core.events.UIEvent")]
   public class Component extends Sprite implements IComponent
   {
       
      
      protected var _width:Number;
      
      protected var _height:Number;
      
      protected var _contentWidth:Number = 0;
      
      protected var _contentHeight:Number = 0;
      
      protected var _disabled:Boolean;
      
      protected var _tag:Object;
      
      protected var _comXml:XML;
      
      protected var _dataSource:Object;
      
      protected var _toolTip:Object;
      
      protected var _top:Number;
      
      protected var _bottom:Number;
      
      protected var _left:Number;
      
      protected var _right:Number;
      
      protected var _centerX:Number;
      
      protected var _centerY:Number;
      
      protected var _layOutEabled:Boolean;
      
      private var _border:Shape;
      
      public function Component(){super();}
      
      protected function preinitialize() : void{}
      
      protected function createChildren() : void{}
      
      protected function initialize() : void{}
      
      public function setPosition(param1:Number, param2:Number) : void{}
      
      override public function set x(param1:Number) : void{}
      
      override public function set y(param1:Number) : void{}
      
      override public function get width() : Number{return 0;}
      
      public function get displayWidth() : Number{return 0;}
      
      protected function get measureWidth() : Number{return 0;}
      
      override public function set width(param1:Number) : void{}
      
      override public function get height() : Number{return 0;}
      
      public function get displayHeight() : Number{return 0;}
      
      protected function get measureHeight() : Number{return 0;}
      
      override public function set height(param1:Number) : void{}
      
      override public function get x() : Number{return 0;}
      
      override public function get y() : Number{return 0;}
      
      override public function set scaleX(param1:Number) : void{}
      
      override public function set scaleY(param1:Number) : void{}
      
      public function commitMeasure() : void{}
      
      protected function changeSize() : void{}
      
      public function setSize(param1:Number, param2:Number) : void{}
      
      public function set scale(param1:Number) : void{}
      
      public function get scale() : Number{return 0;}
      
      public function get disabled() : Boolean{return false;}
      
      public function set disabled(param1:Boolean) : void{}
      
      public function get tag() : Object{return null;}
      
      public function set tag(param1:Object) : void{}
      
      public function showBorder(param1:uint = 16711680) : void{}
      
      public function get comXml() : XML{return null;}
      
      public function set comXml(param1:XML) : void{}
      
      public function get dataSource() : Object{return null;}
      
      public function set dataSource(param1:Object) : void{}
      
      public function get top() : Number{return 0;}
      
      public function set top(param1:Number) : void{}
      
      public function get bottom() : Number{return 0;}
      
      public function set bottom(param1:Number) : void{}
      
      public function get left() : Number{return 0;}
      
      public function set left(param1:Number) : void{}
      
      public function get right() : Number{return 0;}
      
      public function set right(param1:Number) : void{}
      
      public function get centerX() : Number{return 0;}
      
      public function set centerX(param1:Number) : void{}
      
      public function get centerY() : Number{return 0;}
      
      public function set centerY(param1:Number) : void{}
      
      private function set layOutEabled(param1:Boolean) : void{}
      
      private function onRemoved(param1:Event) : void{}
      
      private function onAdded(param1:Event) : void{}
      
      private function onResize(param1:Event) : void{}
      
      protected function resetPosition() : void{}
      
      override public function dispose() : void{}
   }
}
