package morn.core.components
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import morn.core.handlers.Handler;
   import morn.editor.core.IRender;
   
   [Event(name="change",type="flash.events.Event")]
   public class Tree extends Box implements IRender
   {
       
      
      protected var _list:List;
      
      protected var _source:Array;
      
      protected var _xml:XML;
      
      protected var _renderHandler:Handler;
      
      protected var _spaceLeft:Number = 10;
      
      protected var _spaceBottom:Number = 0;
      
      protected var _keepOpenStatus:Boolean = true;
      
      public function Tree(){super();}
      
      override protected function createChildren() : void{}
      
      private function onListChange(param1:Event) : void{}
      
      public function get keepOpenStatus() : Boolean{return false;}
      
      public function set keepOpenStatus(param1:Boolean) : void{}
      
      public function get array() : Array{return null;}
      
      public function set array(param1:Array) : void{}
      
      public function get source() : Array{return null;}
      
      public function get list() : List{return null;}
      
      public function get itemRender() : *{return null;}
      
      public function set itemRender(param1:*) : void{}
      
      public function get scrollBarSkin() : String{return null;}
      
      public function set scrollBarSkin(param1:String) : void{}
      
      public function get mouseHandler() : Handler{return null;}
      
      public function set mouseHandler(param1:Handler) : void{}
      
      public function get renderHandler() : Handler{return null;}
      
      public function set renderHandler(param1:Handler) : void{}
      
      public function get spaceLeft() : Number{return 0;}
      
      public function set spaceLeft(param1:Number) : void{}
      
      public function get spaceBottom() : Number{return 0;}
      
      public function set spaceBottom(param1:Number) : void{}
      
      public function get selectedIndex() : int{return 0;}
      
      public function set selectedIndex(param1:int) : void{}
      
      public function get selectedItem() : Object{return null;}
      
      public function set selectedItem(param1:Object) : void{}
      
      override public function set width(param1:Number) : void{}
      
      override public function set height(param1:Number) : void{}
      
      protected function getArray() : Array{return null;}
      
      protected function getDepth(param1:Object, param2:int = 0) : int{return 0;}
      
      protected function getParentOpenStatus(param1:Object) : Boolean{return false;}
      
      private function renderItem(param1:Box, param2:int) : void{}
      
      private function onArrowClick(param1:MouseEvent) : void{}
      
      override public function set dataSource(param1:Object) : void{}
      
      public function get xml() : XML{return null;}
      
      public function set xml(param1:XML) : void{}
      
      protected function parseXml(param1:XML, param2:Array, param3:Object, param4:Boolean) : void{}
      
      protected function parseOpenStatus(param1:Array, param2:Array) : void{}
      
      protected function isSameParent(param1:Object, param2:Object) : Boolean{return false;}
      
      override public function dispose() : void{}
   }
}
