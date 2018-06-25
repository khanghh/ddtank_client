package morn.core.components{   import com.greensock.TweenLite;   import com.pickgliss.utils.ObjectUtils;   import flash.display.DisplayObject;   import flash.display.Graphics;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Rectangle;   import morn.core.events.DragEvent;   import morn.core.handlers.Handler;   import morn.editor.Builder;   import morn.editor.Sys;   import morn.editor.core.IRender;      [Event(name="change",type="flash.events.Event")]   [Event(name="listRender",type="morn.core.events.UIEvent")]   public class List extends Box implements IRender, IItem   {                   protected var _content:Box;            protected var _scrollBar:ScrollBar;            protected var _itemRender;            protected var _repeatX:int;            protected var _repeatY:int;            protected var _repeatX2:int;            protected var _repeatY2:int;            protected var _spaceX:int;            protected var _spaceY:int;            protected var _cells:Vector.<Component>;            protected var _array:Array;            protected var _startIndex:int;            protected var _selectedIndex:int = -1;            protected var _selectHandler:Handler;            protected var _renderHandler:Handler;            protected var _mouseHandler:Handler;            protected var _page:int;            protected var _totalPage:int;            protected var _selectEnable:Boolean = true;            protected var _isVerticalLayout:Boolean = true;            protected var _cellSize:Number = 20;            protected var _autoHideItem:Boolean = false;            public function List() { super(); }
            override protected function createChildren() : void { }
            override public function removeChild(child:DisplayObject) : DisplayObject { return null; }
            override public function removeChildAt(index:int) : DisplayObject { return null; }
            public function get content() : Box { return null; }
            public function get scrollBar() : ScrollBar { return null; }
            public function set scrollBar(value:ScrollBar) : void { }
            public function get itemRender() : * { return null; }
            public function set itemRender(value:*) : void { }
            public function get repeatX() : int { return 0; }
            public function set repeatX(value:int) : void { }
            public function get repeatY() : int { return 0; }
            public function set repeatY(value:int) : void { }
            public function get spaceX() : int { return 0; }
            public function set spaceX(value:int) : void { }
            public function get spaceY() : int { return 0; }
            public function set spaceY(value:int) : void { }
            protected function changeCells() : void { }
            public function updateCellSpaceX() : void { }
            private function updateCellSpaceXReal() : void { }
            private function createItem() : Box { return null; }
            private function destroyCells() : void { }
            protected function addCell(cell:Component) : void { }
            public function initItems() : void { }
            override public function set width(value:Number) : void { }
            override public function set height(value:Number) : void { }
            public function setContentSize(width:Number, height:Number) : void { }
            protected function onCellMouse(e:MouseEvent) : void { }
            protected function changeCellState(cell:Component, visable:Boolean, frame:int) : void { }
            protected function changeCellBg(cell:Component, frame:int) : void { }
            protected function onScrollBarChange(e:Event) : void { }
            public function get autoHideItem() : Boolean { return false; }
            public function set autoHideItem(value:Boolean) : void { }
            public function get selectEnable() : Boolean { return false; }
            public function set selectEnable(value:Boolean) : void { }
            public function get selectedIndex() : int { return 0; }
            public function set selectedIndex(value:int) : void { }
            public function resetSelect() : void { }
            protected function changeSelectStatus() : void { }
            public function get selectedItem() : Object { return null; }
            public function set selectedItem(value:Object) : void { }
            public function get selection() : Component { return null; }
            public function set selection(value:Component) : void { }
            public function get selectHandler() : Handler { return null; }
            public function set selectHandler(value:Handler) : void { }
            public function get renderHandler() : Handler { return null; }
            public function set renderHandler(value:Handler) : void { }
            public function get mouseHandler() : Handler { return null; }
            public function set mouseHandler(value:Handler) : void { }
            public function get startIndex() : int { return 0; }
            public function set startIndex(value:int) : void { }
            protected function renderItems() : void { }
            protected function renderItem(cell:Component, index:int) : void { }
            private function changeItemBg(cell:Component, index:int) : void { }
            public function get array() : Array { return null; }
            public function set array(value:Array) : void { }
            public function get totalPage() : int { return 0; }
            public function set totalPage(value:int) : void { }
            public function get page() : int { return 0; }
            public function set page(value:int) : void { }
            public function get length() : int { return 0; }
            override public function set dataSource(value:Object) : void { }
            public function get cells() : Vector.<Component> { return null; }
            public function get vScrollBarSkin() : String { return null; }
            public function set vScrollBarSkin(value:String) : void { }
            public function get hScrollBarSkin() : String { return null; }
            public function set hScrollBarSkin(value:String) : void { }
            override public function commitMeasure() : void { }
            public function refresh() : void { }
            public function getItem(index:int) : Object { return null; }
            public function changeItem(index:int, source:Object) : void { }
            public function addItem(souce:Object) : void { }
            public function addItemAt(souce:Object, index:int) : void { }
            public function deleteItem(index:int) : void { }
            public function updateItem(index:int, item:*) : void { }
            public function getCell(index:int) : Box { return null; }
            public function scrollTo(index:int) : void { }
            public function getDropIndex(e:DragEvent) : int { return 0; }
            override public function dispose() : void { }
   }}