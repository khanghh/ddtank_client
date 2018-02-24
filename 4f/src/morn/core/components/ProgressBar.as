package morn.core.components
{
   import flash.display.Shape;
   import flash.events.Event;
   import morn.core.handlers.Handler;
   
   [Event(name="change",type="flash.events.Event")]
   public class ProgressBar extends Component
   {
       
      
      protected var _bg:Image;
      
      protected var _bar:Image;
      
      protected var _skin:String;
      
      protected var _value:Number = 0.5;
      
      protected var _label:String;
      
      protected var _barLabel:Label;
      
      protected var _barLabelX:Number;
      
      protected var _barLabelY:Number;
      
      protected var _changeHandler:Handler;
      
      protected var _mark:Shape;
      
      protected var _barMaskOffsetX:Number = 0;
      
      protected var _barMaskOffsetY:Number = 0;
      
      public function ProgressBar(param1:String = null){super();}
      
      override protected function createChildren() : void{}
      
      override protected function initialize() : void{}
      
      public function get skin() : String{return null;}
      
      public function set skin(param1:String) : void{}
      
      protected function changeLabelPoint() : void{}
      
      public function get value() : Number{return 0;}
      
      public function set value(param1:Number) : void{}
      
      protected function changeValue() : void{}
      
      public function get label() : String{return null;}
      
      public function set label(param1:String) : void{}
      
      public function get bar() : Image{return null;}
      
      public function get barLabel() : Label{return null;}
      
      public function get sizeGrid() : String{return null;}
      
      public function set sizeGrid(param1:String) : void{}
      
      override public function set width(param1:Number) : void{}
      
      override public function set height(param1:Number) : void{}
      
      override public function set dataSource(param1:Object) : void{}
      
      public function set barLabelX(param1:Number) : void{}
      
      public function get barLabelX() : Number{return 0;}
      
      public function set barLabelY(param1:Number) : void{}
      
      public function get barLabelY() : Number{return 0;}
      
      public function set barMaskOffsetX(param1:Number) : void{}
      
      public function get barMaskOffsetX() : Number{return 0;}
      
      public function set barMaskOffsetY(param1:Number) : void{}
      
      public function get barMaskOffsetY() : Number{return 0;}
      
      override public function dispose() : void{}
   }
}
