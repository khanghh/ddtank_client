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
   import morn.core.handlers.Handler;
   import morn.editor.Builder;
   import morn.editor.Sys;
   import morn.editor.core.IRender;
   
   [Event(name="change",type="flash.events.Event")]
   [Event(name="listRender",type="morn.core.events.UIEvent")]
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
      
      public function List()
      {
         _cells = new Vector.<Component>();
         super();
      }
      
      override protected function createChildren() : void
      {
         _content = new Box();
         addChild(new Box());
      }
      
      override public function removeChild(child:DisplayObject) : DisplayObject
      {
         return child != _content?super.removeChild(child):null;
      }
      
      override public function removeChildAt(index:int) : DisplayObject
      {
         return getChildAt(index) != _content?super.removeChildAt(index):null;
      }
      
      public function get content() : Box
      {
         return _content;
      }
      
      public function get scrollBar() : ScrollBar
      {
         return _scrollBar;
      }
      
      public function set scrollBar(value:ScrollBar) : void
      {
         if(_scrollBar != value)
         {
            _scrollBar = value;
            if(value)
            {
               addChild(_scrollBar);
               _scrollBar.target = this;
               _scrollBar.addEventListener("change",onScrollBarChange);
               _isVerticalLayout = _scrollBar.direction == "vertical";
            }
         }
      }
      
      public function get itemRender() : *
      {
         return _itemRender;
      }
      
      public function set itemRender(value:*) : void
      {
         _itemRender = value;
         callLater(changeCells);
      }
      
      public function get repeatX() : int
      {
         return _repeatX > 0?_repeatX:_repeatX2 > 0?_repeatX2:1;
      }
      
      public function set repeatX(value:int) : void
      {
         _repeatX = value;
         callLater(changeCells);
      }
      
      public function get repeatY() : int
      {
         return _repeatY > 0?_repeatY:_repeatY2 > 0?_repeatY2:1;
      }
      
      public function set repeatY(value:int) : void
      {
         _repeatY = value;
         callLater(changeCells);
      }
      
      public function get spaceX() : int
      {
         return _spaceX;
      }
      
      public function set spaceX(value:int) : void
      {
         _spaceX = value;
         callLater(changeCells);
      }
      
      public function get spaceY() : int
      {
         return _spaceY;
      }
      
      public function set spaceY(value:int) : void
      {
         _spaceY = value;
         callLater(changeCells);
      }
      
      protected function changeCells() : void
      {
         var cell:* = null;
         var cellWidth:Number = NaN;
         var cellHeight:Number = NaN;
         var listWidth:Number = NaN;
         var listHeight:Number = NaN;
         var numX:int = 0;
         var numY:int = 0;
         var k:int = 0;
         var l:int = 0;
         if(_itemRender)
         {
            destroyCells();
            _cells.length = 0;
            scrollBar = getChildByName("scrollBar") as ScrollBar;
            cell = createItem();
            cellWidth = cell.width + _spaceX;
            if(_repeatX < 1 && !isNaN(_width))
            {
               _repeatX2 = Math.round(_width / cellWidth);
            }
            cellHeight = cell.height + _spaceY;
            if(_repeatY < 1 && !isNaN(_height))
            {
               _repeatY2 = Math.round(_height / cellHeight);
            }
            listWidth = !!isNaN(_width)?cellWidth * repeatX - _spaceX:Number(_width);
            listHeight = !!isNaN(_height)?cellHeight * repeatY - _spaceY:Number(_height);
            _cellSize = !!_isVerticalLayout?cellHeight:Number(cellWidth);
            if(_isVerticalLayout && _scrollBar)
            {
               _scrollBar.height = listHeight;
            }
            else if(!_isVerticalLayout && _scrollBar)
            {
               _scrollBar.width = listWidth;
            }
            setContentSize(listWidth,listHeight);
            numX = !!_isVerticalLayout?repeatX:int(repeatY);
            numY = (!!_isVerticalLayout?repeatY:int(repeatX)) + (!!_scrollBar?1:0);
            for(k = 0; k < numY; )
            {
               for(l = 0; l < numX; )
               {
                  cell = createItem();
                  cell.x = (!!_isVerticalLayout?l:int(k)) * (_spaceX + cell.width);
                  cell.y = (!!_isVerticalLayout?k:int(l)) * (_spaceY + cell.height);
                  cell.name = "item" + (k * numX + l);
                  _content.addChild(cell);
                  addCell(cell);
                  l++;
               }
               k++;
            }
         }
         if(_array)
         {
            array = _array;
            exeCallLater(renderItems);
         }
      }
      
      public function updateCellSpaceX() : void
      {
         TweenLite.killTweensOf(updateCellSpaceXReal);
         TweenLite.delayedCall(2,updateCellSpaceXReal,null,true);
      }
      
      private function updateCellSpaceXReal() : void
      {
         var l:int = 0;
         var cell:* = null;
         var numX:int = repeatX;
         var nextCellX:* = 0;
         for(l = 0; l < numX; )
         {
            cell = _cells[l];
            cell.x = nextCellX;
            nextCellX = Number(cell.x + cell.width + _spaceX);
            l++;
         }
      }
      
      private function createItem() : Box
      {
         var tempBox:* = null;
         var display:* = null;
         var box:* = null;
         if(!Builder.isEditor)
         {
            tempBox = _itemRender is Class?new _itemRender():View.createComp(_itemRender) as Box;
            return tempBox;
         }
         display = Sys.getCompInstance(_itemRender);
         box = new Box();
         box.addChild(display);
         return box;
      }
      
      private function destroyCells() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var cell in _cells)
         {
            cell.removeEventListener("click",onCellMouse);
            cell.removeEventListener("rollOver",onCellMouse);
            cell.removeEventListener("rollOut",onCellMouse);
            cell.removeEventListener("mouseDown",onCellMouse);
            cell.removeEventListener("mouseUp",onCellMouse);
            cell.removeEventListener("doubleClick",onCellMouse);
            ObjectUtils.disposeObject(cell);
         }
      }
      
      protected function addCell(cell:Component) : void
      {
         cell.addEventListener("click",onCellMouse);
         cell.addEventListener("rollOver",onCellMouse);
         cell.addEventListener("rollOut",onCellMouse);
         cell.addEventListener("mouseDown",onCellMouse);
         cell.addEventListener("mouseUp",onCellMouse);
         cell.addEventListener("doubleClick",onCellMouse);
         _cells.push(cell);
      }
      
      public function initItems() : void
      {
         var i:int = 0;
         var cell:* = null;
         if(!_itemRender)
         {
            for(i = 0; i < 2147483647; )
            {
               cell = getChildByName("item" + i) as Component;
               if(cell)
               {
                  addCell(cell);
                  i++;
                  continue;
               }
               break;
            }
         }
      }
      
      override public function set width(value:Number) : void
      {
         .super.width = value;
         callLater(changeCells);
      }
      
      override public function set height(value:Number) : void
      {
         .super.height = value;
         callLater(changeCells);
      }
      
      public function setContentSize(width:Number, height:Number) : void
      {
         var g:Graphics = graphics;
         g.clear();
         g.beginFill(16711680,0);
         g.drawRect(0,0,width,height);
         g.endFill();
         _content.width = width;
         _content.height = height;
         if(_scrollBar)
         {
            _content.scrollRect = new Rectangle(0,0,width,height);
         }
      }
      
      protected function onCellMouse(e:MouseEvent) : void
      {
         var cell:Component = e.currentTarget as Component;
         var index:int = _startIndex + _cells.indexOf(cell);
         if(e.type == "click" || e.type == "rollOver" || e.type == "rollOut")
         {
            if(e.type == "click")
            {
               if(_selectEnable)
               {
                  selectedIndex = index;
               }
               else
               {
                  changeCellState(cell,true,0);
                  changeCellBg(cell,0);
               }
            }
            else if(_selectedIndex != index)
            {
               changeCellState(cell,e.type == "rollOver",0);
            }
         }
         if(_mouseHandler != null)
         {
            _mouseHandler.executeWith([e,index]);
         }
      }
      
      protected function changeCellState(cell:Component, visable:Boolean, frame:int) : void
      {
         var selectBox:Component = cell.getChildByName("selectBox") as Component;
         if(selectBox)
         {
            selectBox.visible = visable;
            if(selectBox is Clip)
            {
               (selectBox as Clip).frame = frame;
            }
         }
      }
      
      protected function changeCellBg(cell:Component, frame:int) : void
      {
         var i:int = 0;
         var selectBox:Clip = cell.getChildByName("selectBg") as Clip;
         if(selectBox)
         {
            selectBox.frame = frame;
         }
         for(i = 0; i < 2147483647; )
         {
            selectBox = cell.getChildByName("selectBg" + i) as Clip;
            if(selectBox)
            {
               selectBox.frame = frame;
               i++;
               continue;
            }
            break;
         }
      }
      
      protected function onScrollBarChange(e:Event) : void
      {
         exeCallLater(changeCells);
         var rect:Rectangle = _content.scrollRect;
         var scrollValue:Number = _scrollBar.value;
         if(isNaN(scrollValue))
         {
            _scrollBar.value = 0;
            return;
         }
         var index:int = int(scrollValue / _cellSize) * (!!_isVerticalLayout?repeatX:int(repeatY));
         if(index != _startIndex)
         {
            startIndex = index;
         }
         if(_isVerticalLayout)
         {
            rect.y = scrollValue % _cellSize;
         }
         else
         {
            rect.x = scrollValue % _cellSize;
         }
         _content.scrollRect = rect;
      }
      
      public function get autoHideItem() : Boolean
      {
         return _autoHideItem;
      }
      
      public function set autoHideItem(value:Boolean) : void
      {
         _autoHideItem = value;
      }
      
      public function get selectEnable() : Boolean
      {
         return _selectEnable;
      }
      
      public function set selectEnable(value:Boolean) : void
      {
         _selectEnable = value;
      }
      
      public function get selectedIndex() : int
      {
         return _selectedIndex;
      }
      
      public function set selectedIndex(value:int) : void
      {
         if(_selectedIndex != value)
         {
            _selectedIndex = value;
            changeSelectStatus();
         }
         sendEvent("change");
         sendEvent("select");
         if(_selectHandler != null)
         {
            _selectHandler.executeWith([value]);
         }
      }
      
      public function resetSelect() : void
      {
         _selectedIndex = -1;
      }
      
      protected function changeSelectStatus() : void
      {
         var i:int = 0;
         var n:int = 0;
         for(i = 0,n = _cells.length; i < n; )
         {
            changeCellState(_cells[i],_selectedIndex == _startIndex + i,1);
            changeCellBg(_cells[i],_selectedIndex == _startIndex + i?1:0);
            i++;
         }
      }
      
      public function get selectedItem() : Object
      {
         return _selectedIndex != -1?_array[_selectedIndex]:null;
      }
      
      public function set selectedItem(value:Object) : void
      {
         selectedIndex = _array.indexOf(value);
      }
      
      public function get selection() : Component
      {
         return getCell(_selectedIndex);
      }
      
      public function set selection(value:Component) : void
      {
         selectedIndex = _startIndex + _cells.indexOf(value);
      }
      
      public function get selectHandler() : Handler
      {
         return _selectHandler;
      }
      
      public function set selectHandler(value:Handler) : void
      {
         _selectHandler = value;
      }
      
      public function get renderHandler() : Handler
      {
         return _renderHandler;
      }
      
      public function set renderHandler(value:Handler) : void
      {
         _renderHandler = value;
      }
      
      public function get mouseHandler() : Handler
      {
         return _mouseHandler;
      }
      
      public function set mouseHandler(value:Handler) : void
      {
         _mouseHandler = value;
      }
      
      public function get startIndex() : int
      {
         return _startIndex;
      }
      
      public function set startIndex(value:int) : void
      {
         _startIndex = value > 0?value:0;
         callLater(renderItems);
      }
      
      protected function renderItems() : void
      {
         var i:int = 0;
         var n:int = 0;
         for(i = 0,n = _cells.length; i < n; )
         {
            renderItem(_cells[i],_startIndex + i);
            i++;
         }
         changeSelectStatus();
      }
      
      protected function renderItem(cell:Component, index:int) : void
      {
         cell.visible = true;
         if(index < _array.length)
         {
            cell.dataSource = _array[index];
         }
         else
         {
            if(_autoHideItem)
            {
               cell.visible = false;
            }
            cell.dataSource = null;
         }
         changeItemBg(cell,index);
         sendEvent("listRender",[cell,index]);
         if(_renderHandler != null)
         {
            _renderHandler.executeWith([cell,index]);
         }
      }
      
      private function changeItemBg(cell:Component, index:int) : void
      {
         var itemBg:Clip = cell.getChildByName("itemBg") as Clip;
         if(itemBg)
         {
            itemBg.index = index % 2;
         }
      }
      
      public function get array() : Array
      {
         return _array;
      }
      
      public function set array(value:Array) : void
      {
         var numX:int = 0;
         var numY:int = 0;
         var lineCount:int = 0;
         exeCallLater(changeCells);
         _array = value || [];
         var length:int = _array.length;
         _totalPage = Math.ceil(length / (repeatX * repeatY));
         _selectedIndex = _selectedIndex < length?_selectedIndex:length - 1;
         startIndex = _startIndex;
         if(_scrollBar)
         {
            numX = !!_isVerticalLayout?repeatX:int(repeatY);
            numY = !!_isVerticalLayout?repeatY:int(repeatX);
            lineCount = Math.ceil(length / numX);
            _scrollBar.visible = _totalPage > 1;
            if(_scrollBar.visible)
            {
               _scrollBar.scrollSize = _cellSize;
               _scrollBar.thumbPercent = numY / lineCount;
               _scrollBar.setScroll(0,(lineCount - numY) * _cellSize,_startIndex / numX * _cellSize);
            }
            else
            {
               _scrollBar.setScroll(0,0,0);
            }
         }
      }
      
      public function get totalPage() : int
      {
         return _totalPage;
      }
      
      public function set totalPage(value:int) : void
      {
         _totalPage = value;
      }
      
      public function get page() : int
      {
         return _page;
      }
      
      public function set page(value:int) : void
      {
         _page = value;
         if(_array)
         {
            _page = value > 0?value:0;
            _page = _page < _totalPage?_page:_totalPage - 1;
            startIndex = _page * repeatX * repeatY;
         }
      }
      
      public function get length() : int
      {
         return _array.length;
      }
      
      override public function set dataSource(value:Object) : void
      {
         _dataSource = value;
         if(value is int || value is String)
         {
            selectedIndex = int(value);
         }
         else if(value is Array)
         {
            array = value as Array;
         }
         else
         {
            .super.dataSource = value;
         }
      }
      
      public function get cells() : Vector.<Component>
      {
         exeCallLater(changeCells);
         return _cells;
      }
      
      public function get vScrollBarSkin() : String
      {
         return !!_scrollBar?_scrollBar.skin:null;
      }
      
      public function set vScrollBarSkin(value:String) : void
      {
         removeChildByName("scrollBar");
         var scrollBar:ScrollBar = new VScrollBar();
         scrollBar.name = "scrollBar";
         scrollBar.right = 0;
         scrollBar.skin = value;
         addChild(scrollBar);
         callLater(changeCells);
      }
      
      public function get hScrollBarSkin() : String
      {
         return !!_scrollBar?_scrollBar.skin:null;
      }
      
      public function set hScrollBarSkin(value:String) : void
      {
         removeChildByName("scrollBar");
         var scrollBar:ScrollBar = new HScrollBar();
         scrollBar.name = "scrollBar";
         scrollBar.bottom = 0;
         scrollBar.skin = value;
         addChild(scrollBar);
         callLater(changeCells);
      }
      
      override public function commitMeasure() : void
      {
         exeCallLater(changeCells);
      }
      
      public function refresh() : void
      {
         array = _array;
      }
      
      public function getItem(index:int) : Object
      {
         if(index > -1 && index < _array.length)
         {
            return _array[index];
         }
         return null;
      }
      
      public function changeItem(index:int, source:Object) : void
      {
         if(index > -1 && index < _array.length)
         {
            _array[index] = source;
            if(index >= _startIndex && index < _startIndex + _cells.length)
            {
               renderItem(getCell(index),index);
            }
         }
      }
      
      public function addItem(souce:Object) : void
      {
         _array.push(souce);
         array = _array;
      }
      
      public function addItemAt(souce:Object, index:int) : void
      {
         _array.splice(index,0,souce);
         array = _array;
      }
      
      public function deleteItem(index:int) : void
      {
         _array.splice(index,1);
         array = _array;
      }
      
      public function updateItem(index:int, item:*) : void
      {
         _array[index] = item;
      }
      
      public function getCell(index:int) : Box
      {
         exeCallLater(changeCells);
         if(index > -1 && _cells)
         {
            return _cells[(index - _startIndex) % _cells.length] as Box;
         }
         return null;
      }
      
      public function scrollTo(index:int) : void
      {
         var numX:int = 0;
         startIndex = index;
         if(_scrollBar)
         {
            numX = !!_isVerticalLayout?repeatX:int(repeatY);
            _scrollBar.value = index / numX * _cellSize;
         }
      }
      
      public function getDropIndex(e:DragEvent) : int
      {
         var i:int = 0;
         var n:int = 0;
         var target:DisplayObject = e.data.dropTarget;
         for(i = 0,n = _cells.length; i < n; )
         {
            if(_cells[i].contains(target))
            {
               return _startIndex + i;
            }
            i++;
         }
         return -1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         TweenLite.killTweensOf(updateCellSpaceXReal);
         destroyCells();
         _content && _content.dispose();
         _scrollBar && _scrollBar.dispose();
         _content = null;
         _scrollBar = null;
         _itemRender = null;
         _cells = null;
         _array = null;
         _selectHandler = null;
         _renderHandler = null;
         _mouseHandler = null;
      }
   }
}
