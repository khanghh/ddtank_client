package morn.core.components
{
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.ui.Keyboard;
   import morn.core.handlers.Handler;
   
   [Event(name="change",type="flash.events.Event")]
   public class ColorPicker extends Component
   {
       
      
      protected var _gridSize:int = 11;
      
      protected var _panelBgColor:uint = 16777215;
      
      protected var _panelBorderColor:uint = 0;
      
      protected var _panelTextColor:uint = 0;
      
      protected var _panelTextBgColor:uint = 15724527;
      
      protected var _colorPanel:Box;
      
      protected var _colorTiles:Sprite;
      
      protected var _colorBlock:Shape;
      
      protected var _colorField:TextField;
      
      protected var _colorButton:Button;
      
      protected var _colors:Array;
      
      protected var _selectedColor:int = -1;
      
      protected var _changeHandler:Handler;
      
      public function ColorPicker(){super();}
      
      override public function dispose() : void{}
      
      override protected function createChildren() : void{}
      
      override protected function initialize() : void{}
      
      protected function changePanel() : void{}
      
      private function onColorButtonClick(param1:MouseEvent) : void{}
      
      public function open() : void{}
      
      public function close() : void{}
      
      private function removeColorBox(param1:Event = null) : void{}
      
      private function onColorFieldKeyDown(param1:KeyboardEvent) : void{}
      
      private function onColorFieldChange(param1:Event) : void{}
      
      private function onColorTilesClick(param1:MouseEvent) : void{}
      
      private function onColorTilesMouseMove(param1:MouseEvent) : void{}
      
      protected function getColorByMouse() : uint{return null;}
      
      private function drawColorButton(param1:int) : void{}
      
      private function drawBlock(param1:int) : void{}
      
      public function get selectedColor() : int{return 0;}
      
      public function set selectedColor(param1:int) : void{}
      
      public function get changeHandler() : Handler{return null;}
      
      public function set changeHandler(param1:Handler) : void{}
      
      public function get skin() : String{return null;}
      
      public function set skin(param1:String) : void{}
      
      private function changeColor() : void{}
      
      public function get panelBgColor() : uint{return null;}
      
      public function set panelBgColor(param1:uint) : void{}
      
      public function get panelBorderColor() : uint{return null;}
      
      public function set panelBorderColor(param1:uint) : void{}
      
      public function get panelTextColor() : uint{return null;}
      
      public function set panelTextColor(param1:uint) : void{}
      
      public function get panelTextBgColor() : uint{return null;}
      
      public function set panelTextBgColor(param1:uint) : void{}
   }
}
