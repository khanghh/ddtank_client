package morn.core.components
{
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import morn.core.handlers.Handler;
   import morn.core.utils.StringUtils;
   
   public class Dialog extends View
   {
      
      public static const CLOSE:String = "close";
      
      public static const CANCEL:String = "cancel";
      
      public static const SURE:String = "sure";
      
      public static const NO:String = "no";
      
      public static const OK:String = "ok";
      
      public static const YES:String = "yes";
       
      
      protected var _dragArea:Rectangle;
      
      protected var _popupCenter:Boolean = true;
      
      protected var _closeHandler:Handler;
      
      public function Dialog(){super();}
      
      override protected function initialize() : void{}
      
      protected function onClick(param1:MouseEvent) : void{}
      
      public function show(param1:Boolean = false) : void{}
      
      public function popup(param1:Boolean = false) : void{}
      
      public function close(param1:String = null) : void{}
      
      public function get dragArea() : String{return null;}
      
      public function set dragArea(param1:String) : void{}
      
      private function onMouseDown(param1:MouseEvent) : void{}
      
      public function get isPopup() : Boolean{return false;}
      
      public function get popupCenter() : Boolean{return false;}
      
      public function set popupCenter(param1:Boolean) : void{}
      
      public function get closeHandler() : Handler{return null;}
      
      public function set closeHandler(param1:Handler) : void{}
   }
}
