package com.pickgliss.ui.controls
{
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.geom.InnerRectangle;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.cell.IListCellFactory;
   import com.pickgliss.ui.controls.list.ListDataEvent;
   import com.pickgliss.ui.controls.list.ListDataListener;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class OutMainListPanel extends Component implements ListDataListener
   {
       
      
      private var P_vScrollbar:String = "vScrollBar";
      
      private var P_vScrollbarInnerRect:String = "vScrollBarInnerRect";
      
      private var P_cellFactory:String = "cellFactory";
      
      private var _cellsContainer:Sprite;
      
      private var _vScrollbarStyle:String;
      
      private var _vScrollbar:Scrollbar;
      
      private var _vScrollbarInnerRectString:String;
      
      private var _vScrollbarInnerRect:InnerRectangle;
      
      private var _factoryStyle:String;
      
      private var _factory:IListCellFactory;
      
      private var _model:VectorListModel;
      
      private var _cells:Vector.<IListCell>;
      
      private var _presentPos:int;
      
      private var _needNum:int;
      
      public function OutMainListPanel()
      {
         super();
      }
      
      override protected function init() : void
      {
         initEvent();
         _presentPos = 0;
         _cells = new Vector.<IListCell>();
         _model = new VectorListModel();
         _model.addListDataListener(this);
         super.init();
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_vScrollbar)
         {
            _cellsContainer.addChild(_vScrollbar);
         }
         _cellsContainer = new Sprite();
         addChild(_cellsContainer);
      }
      
      public function get vectorListModel() : VectorListModel
      {
         return _model;
      }
      
      public function contentsChanged(event:ListDataEvent) : void
      {
         changeDate();
      }
      
      public function intervalAdded(event:ListDataEvent) : void
      {
         syncScrollBar();
      }
      
      public function intervalRemoved(event:ListDataEvent) : void
      {
         syncScrollBar();
      }
      
      private function syncScrollBar() : void
      {
         var extent:int = 0;
         var value:int = 0;
         var max:int = 0;
         var ih:int = _factory.getCellHeight();
         _needNum = Math.floor(_height / ih);
         if(_vScrollbar != null)
         {
            extent = _needNum * _factory.getCellHeight();
            value = _presentPos * _factory.getCellHeight();
            max = _factory.getCellHeight() * _model.elements.length;
            _vScrollbar.unitIncrement = _factory.getCellHeight();
            _vScrollbar.blockIncrement = _factory.getCellHeight();
            _vScrollbar.getModel().setRangeProperties(value,extent,0,max,false);
         }
         changeDate();
      }
      
      private function changeDate() : void
      {
         var i:int = 0;
         for(i = 0; i < _needNum; )
         {
            _cells[i].setCellValue(_model.elements[_presentPos + i]);
            i++;
         }
      }
      
      private function createCells() : void
      {
         var addNum:int = 0;
         var i:int = 0;
         var cell:* = null;
         var removeIndex:int = 0;
         var removed:* = undefined;
         var j:int = 0;
         var ih:int = _factory.getCellHeight();
         _needNum = Math.floor(_height / ih);
         if(_cells.length == _needNum)
         {
            return;
         }
         if(_cells.length < _needNum)
         {
            addNum = _needNum - _cells.length;
            for(i = 0; i < addNum; )
            {
               cell = createNewCell();
               cell.y = _factory.getCellHeight() * i;
               addCellToContainer(cell);
               i++;
            }
         }
         else
         {
            removeIndex = _needNum;
            removed = _cells.splice(removeIndex,_cells.length - removeIndex);
            for(j = 0; i < removed.length; )
            {
               removeCellFromContainer(removed[j]);
               j++;
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
         }
         dispatchEvent(new ListItemEvent(target,target.getCellValue(),type,index));
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
      
      protected function initEvent() : void
      {
         addEventListener("mouseWheel",onMouseWheel);
      }
      
      public function onMouseWheel(event:MouseEvent) : void
      {
         var incre:int = 0;
         var resulte:int = 0;
         if(_needNum > 0)
         {
            incre = Math.floor(event.delta / _needNum);
            resulte = _presentPos - incre;
            if(resulte > _model.elements.length - _needNum)
            {
               resulte = _model.elements.length - _needNum;
            }
            else if(resulte < 0)
            {
               resulte = 0;
            }
            if(_presentPos == resulte)
            {
               return;
            }
            _presentPos = resulte;
            syncScrollBar();
         }
      }
      
      public function set vScrollbarInnerRectString(value:String) : void
      {
         if(_vScrollbarInnerRectString == value)
         {
            return;
         }
         _vScrollbarInnerRectString = value;
         _vScrollbarInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_vScrollbarInnerRectString));
         onPropertiesChanged(P_vScrollbarInnerRect);
      }
      
      public function set vScrollbarStyle(stylename:String) : void
      {
         if(_vScrollbarStyle == stylename)
         {
            return;
         }
         _vScrollbarStyle = stylename;
         vScrollbar = ComponentFactory.Instance.creat(_vScrollbarStyle);
      }
      
      public function get vScrollbar() : Scrollbar
      {
         return _vScrollbar;
      }
      
      public function set vScrollbar(bar:Scrollbar) : void
      {
         if(_vScrollbar == bar)
         {
            return;
         }
         if(_vScrollbar)
         {
            _vScrollbar.removeStateListener(__onScrollValueChange);
            ObjectUtils.disposeObject(_vScrollbar);
         }
         _vScrollbar = bar;
         _vScrollbar.addStateListener(__onScrollValueChange);
         onPropertiesChanged(P_vScrollbar);
      }
      
      protected function __onScrollValueChange(event:InteractiveEvent) : void
      {
         var newPos:int = Math.floor(_vScrollbar.getModel().getValue() / _factory.getCellHeight());
         if(newPos == _presentPos)
         {
            return;
         }
         _presentPos = newPos;
         syncScrollBar();
      }
      
      public function set factoryStyle(value:String) : void
      {
         if(_factoryStyle == value)
         {
            return;
         }
         _factoryStyle = value;
         var factoryAndArgs:Array = value.split("|");
         var classname:String = factoryAndArgs[0];
         var args:Array = ComponentFactory.parasArgs(factoryAndArgs[1]);
         _factory = ClassUtils.CreatInstance(classname,args);
         onPropertiesChanged(P_cellFactory);
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties[P_cellFactory])
         {
            createCells();
         }
         if(_changedPropeties[P_vScrollbar] || _changedPropeties[P_vScrollbarInnerRect])
         {
            layoutComponent();
         }
      }
      
      protected function layoutComponent() : void
      {
         if(_vScrollbar)
         {
            DisplayUtils.layoutDisplayWithInnerRect(_vScrollbar,_vScrollbarInnerRect,_width,_height);
         }
      }
      
      override public function dispose() : void
      {
         removeEventListener("mouseWheel",onMouseWheel);
         removeAllCell();
         if(_vScrollbar)
         {
            _vScrollbar.removeStateListener(__onScrollValueChange);
            ObjectUtils.disposeObject(_vScrollbar);
         }
         _vScrollbar = null;
         if(_cellsContainer)
         {
            ObjectUtils.disposeObject(_cellsContainer);
         }
         _cellsContainer = null;
         if(_model)
         {
            _model.removeListDataListener(this);
         }
         _model = null;
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
