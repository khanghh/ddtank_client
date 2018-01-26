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
      
      public function OutMainListPanel(){super();}
      
      override protected function init() : void{}
      
      override protected function addChildren() : void{}
      
      public function get vectorListModel() : VectorListModel{return null;}
      
      public function contentsChanged(param1:ListDataEvent) : void{}
      
      public function intervalAdded(param1:ListDataEvent) : void{}
      
      public function intervalRemoved(param1:ListDataEvent) : void{}
      
      private function syncScrollBar() : void{}
      
      private function changeDate() : void{}
      
      private function createCells() : void{}
      
      protected function createNewCell() : IListCell{return null;}
      
      protected function addCellToContainer(param1:IListCell) : void{}
      
      protected function __onItemInteractive(param1:MouseEvent) : void{}
      
      protected function removeAllCell() : void{}
      
      protected function removeCellFromContainer(param1:IListCell) : void{}
      
      protected function initEvent() : void{}
      
      public function onMouseWheel(param1:MouseEvent) : void{}
      
      public function set vScrollbarInnerRectString(param1:String) : void{}
      
      public function set vScrollbarStyle(param1:String) : void{}
      
      public function get vScrollbar() : Scrollbar{return null;}
      
      public function set vScrollbar(param1:Scrollbar) : void{}
      
      protected function __onScrollValueChange(param1:InteractiveEvent) : void{}
      
      public function set factoryStyle(param1:String) : void{}
      
      override protected function onProppertiesUpdate() : void{}
      
      protected function layoutComponent() : void{}
      
      override public function dispose() : void{}
   }
}
