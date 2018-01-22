package morn.core.ex
{
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import morn.core.components.Component;
   import morn.core.components.ISelect;
   import morn.core.components.Image;
   import morn.core.components.Styles;
   import morn.core.events.UIEvent;
   import morn.core.handlers.Handler;
   
   public class TabButtonEx extends Component implements ISelect
   {
       
      
      protected var _selected:Boolean;
      
      protected var _clickHandler:Handler;
      
      protected var _tabItemBg:Image;
      
      protected var _tabItemBg2:Image;
      
      protected var _offsets:Array;
      
      protected var _skin:String;
      
      protected var _skins:Array;
      
      protected var _toggle:Boolean;
      
      protected var _lastClickTime:int;
      
      protected var _clickInterval:int;
      
      protected var _showClickTooQuickTip:Boolean = false;
      
      protected var _enableRollOverLightEffect:Boolean = true;
      
      public function TabButtonEx(){super();}
      
      override protected function createChildren() : void{}
      
      override protected function initialize() : void{}
      
      public function get selected() : Boolean{return false;}
      
      public function set selected(param1:Boolean) : void{}
      
      public function set skin(param1:String) : void{}
      
      public function set offsets(param1:String) : void{}
      
      public function set toggle(param1:Boolean) : void{}
      
      public function set showClickTooQuickTip(param1:Boolean) : void{}
      
      public function set enableRollOverLightEffect(param1:Boolean) : void{}
      
      public function set clickInterval(param1:int) : void{}
      
      protected function changeState() : void{}
      
      protected function changeSkins() : void{}
      
      public function get clickHandler() : Handler{return null;}
      
      public function set clickHandler(param1:Handler) : void{}
      
      protected function onMouse(param1:MouseEvent) : void{}
      
      public function set text(param1:String) : void{}
      
      public function set stroke(param1:String) : void{}
      
      public function set size(param1:int) : void{}
      
      public function set color(param1:uint) : void{}
      
      override public function dispose() : void{}
   }
}
