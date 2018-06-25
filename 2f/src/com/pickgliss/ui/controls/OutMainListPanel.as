package com.pickgliss.ui.controls{   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.events.ListItemEvent;   import com.pickgliss.geom.InnerRectangle;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.cell.IListCell;   import com.pickgliss.ui.controls.cell.IListCellFactory;   import com.pickgliss.ui.controls.list.ListDataEvent;   import com.pickgliss.ui.controls.list.ListDataListener;   import com.pickgliss.ui.controls.list.VectorListModel;   import com.pickgliss.ui.core.Component;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.DisplayUtils;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class OutMainListPanel extends Component implements ListDataListener   {                   private var P_vScrollbar:String = "vScrollBar";            private var P_vScrollbarInnerRect:String = "vScrollBarInnerRect";            private var P_cellFactory:String = "cellFactory";            private var _cellsContainer:Sprite;            private var _vScrollbarStyle:String;            private var _vScrollbar:Scrollbar;            private var _vScrollbarInnerRectString:String;            private var _vScrollbarInnerRect:InnerRectangle;            private var _factoryStyle:String;            private var _factory:IListCellFactory;            private var _model:VectorListModel;            private var _cells:Vector.<IListCell>;            private var _presentPos:int;            private var _needNum:int;            public function OutMainListPanel() { super(); }
            override protected function init() : void { }
            override protected function addChildren() : void { }
            public function get vectorListModel() : VectorListModel { return null; }
            public function contentsChanged(event:ListDataEvent) : void { }
            public function intervalAdded(event:ListDataEvent) : void { }
            public function intervalRemoved(event:ListDataEvent) : void { }
            private function syncScrollBar() : void { }
            private function changeDate() : void { }
            private function createCells() : void { }
            protected function createNewCell() : IListCell { return null; }
            protected function addCellToContainer(cell:IListCell) : void { }
            protected function __onItemInteractive(event:MouseEvent) : void { }
            protected function removeAllCell() : void { }
            protected function removeCellFromContainer(cell:IListCell) : void { }
            protected function initEvent() : void { }
            public function onMouseWheel(event:MouseEvent) : void { }
            public function set vScrollbarInnerRectString(value:String) : void { }
            public function set vScrollbarStyle(stylename:String) : void { }
            public function get vScrollbar() : Scrollbar { return null; }
            public function set vScrollbar(bar:Scrollbar) : void { }
            protected function __onScrollValueChange(event:InteractiveEvent) : void { }
            public function set factoryStyle(value:String) : void { }
            override protected function onProppertiesUpdate() : void { }
            protected function layoutComponent() : void { }
            override public function dispose() : void { }
   }}