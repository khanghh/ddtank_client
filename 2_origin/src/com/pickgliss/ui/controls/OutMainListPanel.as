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
      
      public function contentsChanged(param1:ListDataEvent) : void
      {
         changeDate();
      }
      
      public function intervalAdded(param1:ListDataEvent) : void
      {
         syncScrollBar();
      }
      
      public function intervalRemoved(param1:ListDataEvent) : void
      {
         syncScrollBar();
      }
      
      private function syncScrollBar() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = _factory.getCellHeight();
         _needNum = Math.floor(_height / _loc2_);
         if(_vScrollbar != null)
         {
            _loc3_ = _needNum * _factory.getCellHeight();
            _loc4_ = _presentPos * _factory.getCellHeight();
            _loc1_ = _factory.getCellHeight() * _model.elements.length;
            _vScrollbar.unitIncrement = _factory.getCellHeight();
            _vScrollbar.blockIncrement = _factory.getCellHeight();
            _vScrollbar.getModel().setRangeProperties(_loc4_,_loc3_,0,_loc1_,false);
         }
         changeDate();
      }
      
      private function changeDate() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _needNum)
         {
            _cells[_loc1_].setCellValue(_model.elements[_presentPos + _loc1_]);
            _loc1_++;
         }
      }
      
      private function createCells() : void
      {
         var _loc1_:int = 0;
         var _loc7_:int = 0;
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var _loc5_:* = undefined;
         var _loc6_:int = 0;
         var _loc2_:int = _factory.getCellHeight();
         _needNum = Math.floor(_height / _loc2_);
         if(_cells.length == _needNum)
         {
            return;
         }
         if(_cells.length < _needNum)
         {
            _loc1_ = _needNum - _cells.length;
            _loc7_ = 0;
            while(_loc7_ < _loc1_)
            {
               _loc4_ = createNewCell();
               _loc4_.y = _factory.getCellHeight() * _loc7_;
               addCellToContainer(_loc4_);
               _loc7_++;
            }
         }
         else
         {
            _loc3_ = _needNum;
            _loc5_ = _cells.splice(_loc3_,_cells.length - _loc3_);
            _loc6_ = 0;
            while(_loc7_ < _loc5_.length)
            {
               removeCellFromContainer(_loc5_[_loc6_]);
               _loc6_++;
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
      
      protected function addCellToContainer(param1:IListCell) : void
      {
         param1.addEventListener("click",__onItemInteractive);
         param1.addEventListener("mouseDown",__onItemInteractive);
         param1.addEventListener("mouseUp",__onItemInteractive);
         param1.addEventListener("rollOver",__onItemInteractive);
         param1.addEventListener("rollOut",__onItemInteractive);
         param1.addEventListener("doubleClick",__onItemInteractive);
         _cells.push(_cellsContainer.addChild(param1.asDisplayObject()));
      }
      
      protected function __onItemInteractive(param1:MouseEvent) : void
      {
         var _loc4_:* = null;
         var _loc3_:IListCell = param1.currentTarget as IListCell;
         var _loc2_:int = _model.indexOf(_loc3_.getCellValue());
         var _loc5_:* = param1.type;
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
                           _loc4_ = "listItemRollOut";
                        }
                     }
                     else
                     {
                        _loc4_ = "listItemRollOver";
                     }
                  }
                  else
                  {
                     _loc4_ = "listItemMouseUp";
                  }
               }
               else
               {
                  _loc4_ = "listItemMouseDown";
               }
            }
            else
            {
               _loc4_ = "listItemDoubleclick";
            }
         }
         else
         {
            _loc4_ = "listItemClick";
         }
         dispatchEvent(new ListItemEvent(_loc3_,_loc3_.getCellValue(),_loc4_,_loc2_));
      }
      
      protected function removeAllCell() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _cells.length)
         {
            removeCellFromContainer(_cells[_loc1_]);
            _loc1_++;
         }
         _cells = new Vector.<IListCell>();
      }
      
      protected function removeCellFromContainer(param1:IListCell) : void
      {
         param1.removeEventListener("click",__onItemInteractive);
         param1.removeEventListener("mouseDown",__onItemInteractive);
         param1.removeEventListener("mouseUp",__onItemInteractive);
         param1.removeEventListener("rollOver",__onItemInteractive);
         param1.removeEventListener("rollOut",__onItemInteractive);
         param1.removeEventListener("doubleClick",__onItemInteractive);
         ObjectUtils.disposeObject(param1);
      }
      
      protected function initEvent() : void
      {
         addEventListener("mouseWheel",onMouseWheel);
      }
      
      public function onMouseWheel(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(_needNum > 0)
         {
            _loc2_ = Math.floor(param1.delta / _needNum);
            _loc3_ = _presentPos - _loc2_;
            if(_loc3_ > _model.elements.length - _needNum)
            {
               _loc3_ = _model.elements.length - _needNum;
            }
            else if(_loc3_ < 0)
            {
               _loc3_ = 0;
            }
            if(_presentPos == _loc3_)
            {
               return;
            }
            _presentPos = _loc3_;
            syncScrollBar();
         }
      }
      
      public function set vScrollbarInnerRectString(param1:String) : void
      {
         if(_vScrollbarInnerRectString == param1)
         {
            return;
         }
         _vScrollbarInnerRectString = param1;
         _vScrollbarInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_vScrollbarInnerRectString));
         onPropertiesChanged(P_vScrollbarInnerRect);
      }
      
      public function set vScrollbarStyle(param1:String) : void
      {
         if(_vScrollbarStyle == param1)
         {
            return;
         }
         _vScrollbarStyle = param1;
         vScrollbar = ComponentFactory.Instance.creat(_vScrollbarStyle);
      }
      
      public function get vScrollbar() : Scrollbar
      {
         return _vScrollbar;
      }
      
      public function set vScrollbar(param1:Scrollbar) : void
      {
         if(_vScrollbar == param1)
         {
            return;
         }
         if(_vScrollbar)
         {
            _vScrollbar.removeStateListener(__onScrollValueChange);
            ObjectUtils.disposeObject(_vScrollbar);
         }
         _vScrollbar = param1;
         _vScrollbar.addStateListener(__onScrollValueChange);
         onPropertiesChanged(P_vScrollbar);
      }
      
      protected function __onScrollValueChange(param1:InteractiveEvent) : void
      {
         var _loc2_:int = Math.floor(_vScrollbar.getModel().getValue() / _factory.getCellHeight());
         if(_loc2_ == _presentPos)
         {
            return;
         }
         _presentPos = _loc2_;
         syncScrollBar();
      }
      
      public function set factoryStyle(param1:String) : void
      {
         if(_factoryStyle == param1)
         {
            return;
         }
         _factoryStyle = param1;
         var _loc4_:Array = param1.split("|");
         var _loc3_:String = _loc4_[0];
         var _loc2_:Array = ComponentFactory.parasArgs(_loc4_[1]);
         _factory = ClassUtils.CreatInstance(_loc3_,_loc2_);
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
