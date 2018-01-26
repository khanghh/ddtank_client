package morn.core.ex
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import morn.core.components.AutoBitmap;
   import morn.core.components.Component;
   import morn.core.components.ISelect;
   import morn.core.components.Styles;
   import morn.core.events.UIEvent;
   import morn.core.handlers.Handler;
   import morn.core.utils.StringUtils;
   
   public class ButtonEx extends Component implements ISelect
   {
      
      protected static var stateMap:Object = {
         "rollOver":1,
         "rollOut":0,
         "mouseDown":2,
         "mouseUp":1,
         "selected":2
      };
       
      
      protected var _content:Sprite;
      
      protected var _bitmap:AutoBitmap;
      
      protected var _image:AutoBitmap;
      
      protected var _clickHandler:Handler;
      
      protected var _state:int;
      
      protected var _toggle:Boolean;
      
      protected var _selected:Boolean;
      
      protected var _skin:String;
      
      protected var _imageLabel:String;
      
      protected var _autoSize:Boolean = true;
      
      protected var _enableClickMoveDownEffect:Boolean = true;
      
      protected var _enableRollOverLightEffect:Boolean = true;
      
      protected var _clickInterval:int;
      
      private var _lastClickTime:int;
      
      protected var _showClickTooQuickTip:Boolean = false;
      
      public function ButtonEx(param1:String = null, param2:String = ""){super();}
      
      override protected function createChildren() : void{}
      
      override protected function initialize() : void{}
      
      protected function onMouse(param1:MouseEvent) : void{}
      
      private function onStageMouseUp(param1:MouseEvent) : void{}
      
      public function get skin() : String{return null;}
      
      public function set skin(param1:String) : void{}
      
      protected function changeClips() : void{}
      
      override public function commitMeasure() : void{}
      
      public function get selected() : Boolean{return false;}
      
      public function set selected(param1:Boolean) : void{}
      
      protected function get state() : int{return 0;}
      
      protected function set state(param1:int) : void{}
      
      protected function changeState() : void{}
      
      public function get toggle() : Boolean{return false;}
      
      public function set toggle(param1:Boolean) : void{}
      
      override public function set disabled(param1:Boolean) : void{}
      
      public function get clickHandler() : Handler{return null;}
      
      public function set clickHandler(param1:Handler) : void{}
      
      public function get sizeGrid() : String{return null;}
      
      public function set sizeGrid(param1:String) : void{}
      
      override public function set width(param1:Number) : void{}
      
      override public function set height(param1:Number) : void{}
      
      override public function set dataSource(param1:Object) : void{}
      
      public function get imageLabel() : String{return null;}
      
      public function set imageLabel(param1:String) : void{}
      
      override public function dispose() : void{}
      
      public function get enableClickMoveDownEffect() : Boolean{return false;}
      
      public function set enableClickMoveDownEffect(param1:Boolean) : void{}
      
      public function get enableRollOverLightEffect() : Boolean{return false;}
      
      public function set enableRollOverLightEffect(param1:Boolean) : void{}
      
      public function get clickInterval() : int{return 0;}
      
      public function set clickInterval(param1:int) : void{}
      
      public function get showClickTooQuickTip() : Boolean{return false;}
      
      public function set showClickTooQuickTip(param1:Boolean) : void{}
   }
}
