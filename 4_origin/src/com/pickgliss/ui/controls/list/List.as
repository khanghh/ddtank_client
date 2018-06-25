package com.pickgliss.ui.controls.list
{
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.geom.IntDimension;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.geom.IntRectangle;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.cell.IListCellFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.IViewprot;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   [Event(name="listItemClick",type="com.pickgliss.events.ListItemEvent")]
   [Event(name="listItemDoubleclick",type="com.pickgliss.events.ListItemEvent")]
   [Event(name="listItemMouseDown",type="com.pickgliss.events.ListItemEvent")]
   [Event(name="listItemMouseUp",type="com.pickgliss.events.ListItemEvent")]
   [Event(name="listItemRollOver",type="com.pickgliss.events.ListItemEvent")]
   [Event(name="listItemRollOut",type="com.pickgliss.events.ListItemEvent")]
   public class List extends Component implements IViewprot, ListDataListener
   {
      
      public static const AUTO_INCREMENT:int = -2147483648;
      
      public static const P_cellFactory:String = "cellFactory";
      
      public static const P_horizontalBlockIncrement:String = "horizontalBlockIncrement";
      
      public static const P_horizontalUnitIncrement:String = "horizontalUnitIncrement";
      
      public static const P_model:String = "model";
      
      public static const P_verticalBlockIncrement:String = "verticalBlockIncrement";
      
      public static const P_verticalUnitIncrement:String = "verticalUnitIncrement";
      
      public static const P_viewPosition:String = "viewPosition";
      
      public static const P_viewSize:String = "viewSize";
       
      
      protected var _cells:Vector.<IListCell>;
      
      protected var _cellsContainer:Sprite;
      
      protected var _factory:IListCellFactory;
      
      protected var _firstVisibleIndex:int;
      
      protected var _firstVisibleIndexOffset:int;
      
      protected var _horizontalBlockIncrement:int;
      
      protected var _horizontalUnitIncrement:int;
      
      protected var _lastVisibleIndex:int;
      
      protected var _lastVisibleIndexOffset:int;
      
      protected var _maskShape:Shape;
      
      protected var _model:IListModel;
      
      protected var _mouseActiveObjectShape:Shape;
      
      protected var _verticalBlockIncrement:int;
      
      protected var _verticalUnitIncrement:int;
      
      protected var _viewHeight:int;
      
      protected var _viewPosition:IntPoint;
      
      protected var _viewWidth:int;
      
      protected var _viewWidthNoCount:int;
      
      protected var _visibleCellWidth:int;
      
      protected var _visibleRowCount:int;
      
      protected var _currentSelectedIndex:int = -1;
      
      public function List()
      {
         _horizontalBlockIncrement = ComponentSetting.SCROLL_BLOCK_INCREMENT;
         _horizontalUnitIncrement = ComponentSetting.SCROLL_UINT_INCREMENT;
         _verticalBlockIncrement = ComponentSetting.SCROLL_BLOCK_INCREMENT;
         _verticalUnitIncrement = ComponentSetting.SCROLL_UINT_INCREMENT;
         super();
      }
      
      public function addStateListener(listener:Function, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         addEventListener("stateChange",listener,false,priority);
      }
      
      public function get cellFactory() : IListCellFactory
      {
         return _factory;
      }
      
      public function set cellFactory(factory:IListCellFactory) : void
      {
         if(_factory == factory)
         {
            return;
         }
         _factory = factory;
         onPropertiesChanged("cellFactory");
      }
      
      public function contentsChanged(event:ListDataEvent) : void
      {
         if(event.getIndex0() >= _firstVisibleIndex && event.getIndex0() <= _lastVisibleIndex || event.getIndex1() >= _firstVisibleIndex && event.getIndex1() <= _lastVisibleIndex || _lastVisibleIndex == -1)
         {
            updateListView();
         }
      }
      
      override public function dispose() : void
      {
         _mouseActiveObjectShape.graphics.clear();
         _mouseActiveObjectShape = null;
         _maskShape.graphics.clear();
         _maskShape = null;
         removeAllCell();
         _cells = null;
         if(_model)
         {
            _model.removeListDataListener(this);
         }
         _model = null;
         super.dispose();
      }
      
      public function getExtentSize() : IntDimension
      {
         return new IntDimension(_width,_height);
      }
      
      public function getViewSize() : IntDimension
      {
         return new IntDimension(_viewWidth,_viewHeight);
      }
      
      public function getViewportPane() : Component
      {
         return this;
      }
      
      public function get horizontalBlockIncrement() : int
      {
         return _horizontalBlockIncrement;
      }
      
      public function set horizontalBlockIncrement(increment:int) : void
      {
         if(_horizontalBlockIncrement == increment)
         {
            return;
         }
         _horizontalBlockIncrement = increment;
         onPropertiesChanged("horizontalBlockIncrement");
      }
      
      public function get horizontalUnitIncrement() : int
      {
         return _horizontalUnitIncrement;
      }
      
      public function set horizontalUnitIncrement(increment:int) : void
      {
         if(_horizontalUnitIncrement == increment)
         {
            return;
         }
         _horizontalUnitIncrement = increment;
         onPropertiesChanged("horizontalUnitIncrement");
      }
      
      public function intervalAdded(event:ListDataEvent) : void
      {
         refreshViewSize();
         onPropertiesChanged("viewSize");
         var ih:int = _factory.getCellHeight();
         var needNum:int = Math.floor(_height / ih);
         if(event.getIndex1() <= _lastVisibleIndex || _lastVisibleIndex == -1 || viewHeight < _height || _lastVisibleIndex <= needNum)
         {
            updateListView();
         }
      }
      
      public function intervalRemoved(event:ListDataEvent) : void
      {
         refreshViewSize();
         onPropertiesChanged("viewSize");
         var ih:int = _factory.getCellHeight();
         var needNum:int = Math.floor(_height / ih);
         if(event.getIndex1() <= _lastVisibleIndex || _lastVisibleIndex == -1 || viewHeight < _height || _lastVisibleIndex <= needNum)
         {
            updateListView();
         }
      }
      
      public function isSelectedIndex(index:int) : Boolean
      {
         return _currentSelectedIndex == index;
      }
      
      public function get model() : IListModel
      {
         return _model;
      }
      
      public function set model(m:IListModel) : void
      {
         if(m != model)
         {
            if(_model)
            {
               _model.removeListDataListener(this);
            }
            _model = m;
            _model.addListDataListener(this);
            onPropertiesChanged("model");
         }
      }
      
      public function removeStateListener(listener:Function) : void
      {
         removeEventListener("stateChange",listener);
      }
      
      public function scrollRectToVisible(contentRect:IntRectangle) : void
      {
         viewPosition = new IntPoint(contentRect.x,contentRect.y);
      }
      
      public function setListData(ld:Array) : void
      {
         var m:IListModel = new VectorListModel(ld);
         model = m;
      }
      
      public function setViewportTestSize(s:IntDimension) : void
      {
      }
      
      public function updateListView() : void
      {
         if(_factory == null)
         {
            return;
         }
         createCells();
         updateShowMask();
         updatePos();
      }
      
      public function get verticalBlockIncrement() : int
      {
         return _verticalBlockIncrement;
      }
      
      public function set verticalBlockIncrement(increment:int) : void
      {
         if(_verticalBlockIncrement == increment)
         {
            return;
         }
         _verticalBlockIncrement = increment;
         onPropertiesChanged("verticalBlockIncrement");
      }
      
      public function get verticalUnitIncrement() : int
      {
         return _verticalUnitIncrement;
      }
      
      public function set verticalUnitIncrement(increment:int) : void
      {
         if(_verticalUnitIncrement == increment)
         {
            return;
         }
         _verticalUnitIncrement = increment;
         onPropertiesChanged("verticalUnitIncrement");
      }
      
      public function get viewPosition() : IntPoint
      {
         return _viewPosition;
      }
      
      public function set viewPosition(p:IntPoint) : void
      {
         if(_viewPosition.equals(restrictionViewPos(p)))
         {
            return;
         }
         _viewPosition.setLocation(p);
         onPropertiesChanged("viewPosition");
      }
      
      protected function __onItemInteractive(event:MouseEvent) : void
      {
         var type:* = null;
         var target:IListCell = event.currentTarget as IListCell;
         var index:int = _model.indexOf(target.getCellValue());
         var _loc5_:* = event.type;
         if("click" !== _loc5_)
         {
            if("doubleClick" !== _loc5_)
            {
               if("mouseDown" !== _loc5_)
               {
                  if("mouseUp" !== _loc5_)
                  {
                     if("rollOver" !== _loc5_)
                     {
                        if("rollOut" === _loc5_)
                        {
                           type = "listItemRollOut";
                        }
                     }
                     else
                     {
                        type = "listItemRollOver";
                     }
                  }
                  else
                  {
                     type = "listItemMouseUp";
                  }
               }
               else
               {
                  type = "listItemMouseDown";
               }
            }
            else
            {
               type = "listItemDoubleclick";
            }
         }
         else
         {
            type = "listItemClick";
            _currentSelectedIndex = index;
            updateListView();
         }
         dispatchEvent(new ListItemEvent(target,target.getCellValue(),type,index));
      }
      
      public function getCellAt(val:int) : IListCell
      {
         return _cells[val];
      }
      
      public function getAllCells() : Vector.<IListCell>
      {
         return _cells;
      }
      
      public function get currentSelectedIndex() : int
      {
         return _currentSelectedIndex;
      }
      
      public function set currentSelectedIndex(val:int) : void
      {
         var targetCell:* = null;
         var tmp:* = _model.getElementAt(val);
         if(tmp)
         {
            _currentSelectedIndex = val;
            updateListView();
            var _loc6_:int = 0;
            var _loc5_:* = _cells;
            for each(var tmpIListCell in _cells)
            {
               if(tmpIListCell.getCellValue() == tmp)
               {
                  targetCell = tmpIListCell;
                  break;
               }
            }
            if(targetCell)
            {
               dispatchEvent(new ListItemEvent(targetCell,targetCell.getCellValue(),"listItemClick",_currentSelectedIndex));
            }
         }
      }
      
      protected function addCellToContainer(cell:IListCell) : void
      {
         cell.addEventListener("click",__onItemInteractive);
         cell.addEventListener("mouseDown",__onItemInteractive);
         cell.addEventListener("mouseUp",__onItemInteractive);
         cell.addEventListener("rollOver",__onItemInteractive);
         cell.addEventListener("rollOut",__onItemInteractive);
         cell.addEventListener("doubleClick",__onItemInteractive);
         _cells.push(_cellsContainer.addChild(cell.asDisplayObject()));
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         addChild(_mouseActiveObjectShape);
         addChild(_maskShape);
         addChild(_cellsContainer);
      }
      
      protected function creatMaskShape() : void
      {
         _maskShape = new Shape();
         _maskShape.graphics.beginFill(16711680,1);
         _maskShape.graphics.drawRect(0,0,100,100);
         _maskShape.graphics.endFill();
         _mouseActiveObjectShape = new Shape();
         _mouseActiveObjectShape.graphics.beginFill(16711680,0);
         _mouseActiveObjectShape.graphics.drawRect(0,0,100,100);
         _mouseActiveObjectShape.graphics.endFill();
      }
      
      protected function createCells() : void
      {
         if(_factory.isShareCells())
         {
            createCellsWhenShareCells();
         }
         else
         {
            createCellsWhenNotShareCells();
         }
      }
      
      protected function createCellsWhenNotShareCells() : void
      {
      }
      
      protected function createCellsWhenShareCells() : void
      {
         var i:int = 0;
         var cell:* = null;
         var maxCellWidth:int = 0;
         var addNum:int = 0;
         var removeIndex:* = 0;
         var removed:* = undefined;
         var ih:int = _factory.getCellHeight();
         var needNum:int = Math.floor(_height / ih) + 2;
         _viewWidth = _factory.getViewWidthNoCount();
         if(_cells.length == needNum)
         {
            return;
         }
         if(_cells.length < needNum)
         {
            addNum = needNum - _cells.length;
            for(i = 0; i < addNum; )
            {
               cell = createNewCell();
               maxCellWidth = Math.max(cell.width,maxCellWidth);
               addCellToContainer(cell);
               i++;
            }
         }
         else if(_cells.length > needNum)
         {
            removeIndex = needNum;
            removed = _cells.splice(removeIndex,_cells.length - removeIndex);
            for(i = 0; i < removed.length; )
            {
               removeCellFromContainer(removed[i]);
               i++;
            }
         }
      }
      
      protected function createNewCell() : IListCell
      {
         if(_factory == null)
         {
            return null;
         }
         return _factory.createNewCell();
      }
      
      protected function fireStateChanged(programmatic:Boolean = true) : void
      {
         dispatchEvent(new InteractiveEvent("stateChange"));
      }
      
      protected function getListCellModelHeight(index:int) : int
      {
         return 0;
      }
      
      protected function getViewMaxPos() : IntPoint
      {
         var showSize:IntDimension = getExtentSize();
         var viewSize:IntDimension = getViewSize();
         var p:IntPoint = new IntPoint(viewSize.width - showSize.width,viewSize.height - showSize.height);
         if(p.x < 0)
         {
            p.x = 0;
         }
         if(p.y < 0)
         {
            p.y = 0;
         }
         return p;
      }
      
      override protected function init() : void
      {
         creatMaskShape();
         _cellsContainer = new Sprite();
         addChild(_cellsContainer);
         _viewPosition = new IntPoint(0,0);
         _firstVisibleIndex = 0;
         _lastVisibleIndex = -1;
         _firstVisibleIndexOffset = 0;
         _lastVisibleIndexOffset = 0;
         _visibleRowCount = -1;
         _visibleCellWidth = -1;
         _cells = new Vector.<IListCell>();
         super.init();
         _model = new VectorListModel();
         _model.addListDataListener(this);
      }
      
      protected function layoutWhenShareCellsHasNotSameHeight() : void
      {
         var i:int = 0;
         var cell:* = null;
         var ldIndex:int = 0;
         createCellsWhenShareCells();
         restrictionViewPos(_viewPosition);
         var x:int = _viewPosition.x;
         var y:int = _viewPosition.y;
         var startIndex:int = _model.getStartIndexByPosY(y);
         var listSize:int = _model.getSize();
         var cx:int = -x;
         var maxY:int = _height;
         if(listSize < 0)
         {
            _lastVisibleIndex = -1;
         }
         for(i = 0; i < _cells.length; )
         {
            cell = _cells[i];
            ldIndex = startIndex + i;
            if(ldIndex < listSize)
            {
               cell.setCellValue(_model.getElementAt(ldIndex));
               cell.setListCellStatus(this,isSelectedIndex(ldIndex),ldIndex);
               cell.visible = true;
               cell.x = cx;
               cell.y = _model.getCellPosFromIndex(ldIndex) - y;
               if(cell.y < maxY)
               {
                  _lastVisibleIndex = ldIndex;
               }
            }
            else
            {
               cell.visible = false;
            }
            i++;
         }
         refreshViewSize();
         _firstVisibleIndex = startIndex;
      }
      
      protected function layoutWhenShareCellsHasSameHeight() : void
      {
         var i:int = 0;
         var cell:* = null;
         var ldIndex:int = 0;
         createCellsWhenShareCells();
         restrictionViewPos(_viewPosition);
         var x:int = _viewPosition.x;
         var y:int = _viewPosition.y;
         var ih:int = _factory.getCellHeight();
         var startIndex:int = Math.floor(y / ih);
         var startY:int = startIndex * ih - y;
         var listSize:int = _model.getSize();
         var cx:int = -x;
         var cy:* = startY;
         var maxY:int = _height;
         if(listSize < 0)
         {
            _lastVisibleIndex = -1;
         }
         for(i = 0; i < _cells.length; )
         {
            cell = _cells[i];
            ldIndex = startIndex + i;
            if(ldIndex < listSize)
            {
               cell.setCellValue(_model.getElementAt(ldIndex));
               cell.setListCellStatus(this,isSelectedIndex(ldIndex),ldIndex);
               cell.visible = true;
               cell.x = cx;
               cell.y = cy;
               if(cy < maxY)
               {
                  _lastVisibleIndex = ldIndex;
               }
               cy = int(cy + ih);
            }
            else
            {
               cell.visible = false;
            }
            i++;
         }
         refreshViewSize();
         _firstVisibleIndex = startIndex;
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         var mustUpdateListView:Boolean = false;
         _cellsContainer.mask = _maskShape;
         if(_changedPropeties["model"] || _changedPropeties["cellFactory"] || _changedPropeties["viewPosition"] || _changedPropeties["width"] || _changedPropeties["height"])
         {
            if(_changedPropeties["cellFactory"])
            {
               removeAllCell();
            }
            mustUpdateListView = true;
         }
         if(mustUpdateListView)
         {
            updateListView();
         }
         if(_changedPropeties["verticalBlockIncrement"] || _changedPropeties["verticalUnitIncrement"] || _changedPropeties["horizontalBlockIncrement"] || _changedPropeties["horizontalUnitIncrement"] || _changedPropeties["height"] || _changedPropeties["width"] || _changedPropeties["viewPosition"] || _changedPropeties["viewSize"])
         {
            fireStateChanged();
         }
      }
      
      protected function refreshViewSize() : void
      {
         if(_factory.isShareCells())
         {
            _viewWidth = _factory.getViewWidthNoCount();
            if(_factory.isAllCellHasSameHeight())
            {
               viewHeight = _model.getSize() * _factory.getCellHeight();
            }
            else
            {
               viewHeight = _model.getAllCellHeight();
            }
         }
      }
      
      public function get viewHeight() : Number
      {
         return _viewHeight;
      }
      
      public function set viewHeight(value:Number) : void
      {
         if(_viewHeight == value)
         {
            return;
         }
         _viewHeight = value;
         onPropertiesChanged("viewSize");
      }
      
      public function get viewWidth() : Number
      {
         return _viewWidth;
      }
      
      public function set viewWidth(value:Number) : void
      {
         if(_viewWidth == value)
         {
            return;
         }
         _viewWidth = value;
         onPropertiesChanged("viewSize");
      }
      
      public function unSelectedAll() : void
      {
         _currentSelectedIndex = -1;
         updateListView();
      }
      
      protected function removeAllCell() : void
      {
         var i:int = 0;
         for(i = 0; i < _cells.length; )
         {
            removeCellFromContainer(_cells[i]);
            i++;
         }
         _cells = new Vector.<IListCell>();
      }
      
      protected function removeCellFromContainer(cell:IListCell) : void
      {
         cell.removeEventListener("click",__onItemInteractive);
         cell.removeEventListener("mouseDown",__onItemInteractive);
         cell.removeEventListener("mouseUp",__onItemInteractive);
         cell.removeEventListener("rollOver",__onItemInteractive);
         cell.removeEventListener("rollOut",__onItemInteractive);
         cell.removeEventListener("doubleClick",__onItemInteractive);
         ObjectUtils.disposeObject(cell);
      }
      
      protected function restrictionViewPos(p:IntPoint) : IntPoint
      {
         var maxPos:IntPoint = getViewMaxPos();
         p.x = Math.max(0,Math.min(maxPos.x,p.x));
         p.y = Math.max(0,Math.min(maxPos.y,p.y));
         return p;
      }
      
      protected function updatePos() : void
      {
         if(_factory.isShareCells())
         {
            if(_factory.isAllCellHasSameHeight())
            {
               layoutWhenShareCellsHasSameHeight();
            }
            else
            {
               layoutWhenShareCellsHasNotSameHeight();
            }
         }
      }
      
      protected function updateShowMask() : void
      {
         var _loc1_:* = _width;
         _maskShape.width = _loc1_;
         _mouseActiveObjectShape.width = _loc1_;
         _loc1_ = _height;
         _maskShape.height = _loc1_;
         _mouseActiveObjectShape.height = _loc1_;
      }
      
      public function get cell() : Vector.<IListCell>
      {
         return _cells;
      }
   }
}
