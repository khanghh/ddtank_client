package morn.core.components
{
   import com.greensock.TweenLite;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import morn.core.events.DragEvent;
   import morn.core.events.UIEvent;
   import morn.core.handlers.Handler;
   import morn.editor.Builder;
   import morn.editor.Sys;
   import morn.editor.core.IRender;
   
   [Event(name="listRender",type="morn.core.events.UIEvent")]
   [Event(name="change",type="flash.events.Event")]
   public class List extends Box implements IRender, IItem
   {
       
      
      protected var _content:Box;
      
      protected var _scrollBar:ScrollBar;
      
      protected var _itemRender;
      
      protected var _repeatX:int;
      
      protected var _repeatY:int;
      
      protected var _repeatX2:int;
      
      protected var _repeatY2:int;
      
      protected var _spaceX:int;
      
      protected var _spaceY:int;
      
      protected var _cells:Vector.<Component>;
      
      protected var _array:Array;
      
      protected var _startIndex:int;
      
      protected var _selectedIndex:int = -1;
      
      protected var _selectHandler:Handler;
      
      protected var _renderHandler:Handler;
      
      protected var _mouseHandler:Handler;
      
      protected var _page:int;
      
      protected var _totalPage:int;
      
      protected var _selectEnable:Boolean = true;
      
      protected var _isVerticalLayout:Boolean = true;
      
      protected var _cellSize:Number = 20;
      
      protected var _autoHideItem:Boolean = false;
      
      public function List(){super();}
      
      override protected function createChildren() : void{}
      
      override public function removeChild(param1:DisplayObject) : DisplayObject{return null;}
      
      override public function removeChildAt(param1:int) : DisplayObject{return null;}
      
      public function get content() : Box{return null;}
      
      public function get scrollBar() : ScrollBar{return null;}
      
      public function set scrollBar(param1:ScrollBar) : void{}
      
      public function get itemRender() : *{return null;}
      
      public function set itemRender(param1:*) : void{}
      
      public function get repeatX() : int{return 0;}
      
      public function set repeatX(param1:int) : void{}
      
      public function get repeatY() : int{return 0;}
      
      public function set repeatY(param1:int) : void{}
      
      public function get spaceX() : int{return 0;}
      
      public function set spaceX(param1:int) : void{}
      
      public function get spaceY() : int{return 0;}
      
      public function set spaceY(param1:int) : void{}
      
      protected function changeCells() : void{}
      
      public function updateCellSpaceX() : void{}
      
      private function updateCellSpaceXReal() : void{}
      
      private function createItem() : Box{return null;}
      
      private function destroyCells() : void{}
      
      protected function addCell(param1:Component) : void{}
      
      public function initItems() : void{}
      
      override public function set width(param1:Number) : void{}
      
      override public function set height(param1:Number) : void{}
      
      public function setContentSize(param1:Number, param2:Number) : void{}
      
      protected function onCellMouse(param1:MouseEvent) : void{}
      
      protected function changeCellState(param1:Component, param2:Boolean, param3:int) : void{}
      
      protected function changeCellBg(param1:Component, param2:int) : void{}
      
      protected function onScrollBarChange(param1:Event) : void{}
      
      public function get autoHideItem() : Boolean{return false;}
      
      public function set autoHideItem(param1:Boolean) : void{}
      
      public function get selectEnable() : Boolean{return false;}
      
      public function set selectEnable(param1:Boolean) : void{}
      
      public function get selectedIndex() : int{return 0;}
      
      public function set selectedIndex(param1:int) : void{}
      
      public function resetSelect() : void{}
      
      protected function changeSelectStatus() : void{}
      
      public function get selectedItem() : Object{return null;}
      
      public function set selectedItem(param1:Object) : void{}
      
      public function get selection() : Component{return null;}
      
      public function set selection(param1:Component) : void{}
      
      public function get selectHandler() : Handler{return null;}
      
      public function set selectHandler(param1:Handler) : void{}
      
      public function get renderHandler() : Handler{return null;}
      
      public function set renderHandler(param1:Handler) : void{}
      
      public function get mouseHandler() : Handler{return null;}
      
      public function set mouseHandler(param1:Handler) : void{}
      
      public function get startIndex() : int{return 0;}
      
      public function set startIndex(param1:int) : void{}
      
      protected function renderItems() : void{}
      
      protected function renderItem(param1:Component, param2:int) : void{}
      
      private function changeItemBg(param1:Component, param2:int) : void{}
      
      public function get array() : Array{return null;}
      
      public function set array(param1:Array) : void{}
      
      public function get totalPage() : int{return 0;}
      
      public function set totalPage(param1:int) : void{}
      
      public function get page() : int{return 0;}
      
      public function set page(param1:int) : void{}
      
      public function get length() : int{return 0;}
      
      override public function set dataSource(param1:Object) : void{}
      
      public function get cells() : Vector.<Component>{return null;}
      
      public function get vScrollBarSkin() : String{return null;}
      
      public function set vScrollBarSkin(param1:String) : void{}
      
      public function get hScrollBarSkin() : String{return null;}
      
      public function set hScrollBarSkin(param1:String) : void{}
      
      override public function commitMeasure() : void{}
      
      public function refresh() : void{}
      
      public function getItem(param1:int) : Object{return null;}
      
      public function changeItem(param1:int, param2:Object) : void{}
      
      public function addItem(param1:Object) : void{}
      
      public function addItemAt(param1:Object, param2:int) : void{}
      
      public function deleteItem(param1:int) : void{}
      
      public function updateItem(param1:int, param2:*) : void{}
      
      public function getCell(param1:int) : Box{return null;}
      
      public function scrollTo(param1:int) : void{}
      
      public function getDropIndex(param1:DragEvent) : int{return 0;}
      
      override public function dispose() : void{}
   }
}
