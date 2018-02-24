package morn.core.components
{
   import flash.display.DisplayObject;
   import morn.core.handlers.Handler;
   
   public class ViewStack extends Box implements IItem
   {
       
      
      protected var _items:Vector.<DisplayObject>;
      
      protected var _setIndexHandler:Handler;
      
      protected var _selectedIndex:int;
      
      public function ViewStack(){super();}
      
      public function setItems(param1:Array) : void{}
      
      public function addItem(param1:DisplayObject) : void{}
      
      public function initItems() : void{}
      
      public function get selectedIndex() : int{return 0;}
      
      public function set selectedIndex(param1:int) : void{}
      
      protected function setSelect(param1:int, param2:Boolean) : void{}
      
      public function get selection() : DisplayObject{return null;}
      
      public function set selection(param1:DisplayObject) : void{}
      
      public function get setIndexHandler() : Handler{return null;}
      
      public function set setIndexHandler(param1:Handler) : void{}
      
      protected function setIndex(param1:int) : void{}
      
      public function get items() : Vector.<DisplayObject>{return null;}
      
      override public function set dataSource(param1:Object) : void{}
      
      override public function dispose() : void{}
   }
}
