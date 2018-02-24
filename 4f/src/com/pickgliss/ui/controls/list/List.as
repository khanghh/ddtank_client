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
      
      public function List(){super();}
      
      public function addStateListener(param1:Function, param2:int = 0, param3:Boolean = false) : void{}
      
      public function get cellFactory() : IListCellFactory{return null;}
      
      public function set cellFactory(param1:IListCellFactory) : void{}
      
      public function contentsChanged(param1:ListDataEvent) : void{}
      
      override public function dispose() : void{}
      
      public function getExtentSize() : IntDimension{return null;}
      
      public function getViewSize() : IntDimension{return null;}
      
      public function getViewportPane() : Component{return null;}
      
      public function get horizontalBlockIncrement() : int{return 0;}
      
      public function set horizontalBlockIncrement(param1:int) : void{}
      
      public function get horizontalUnitIncrement() : int{return 0;}
      
      public function set horizontalUnitIncrement(param1:int) : void{}
      
      public function intervalAdded(param1:ListDataEvent) : void{}
      
      public function intervalRemoved(param1:ListDataEvent) : void{}
      
      public function isSelectedIndex(param1:int) : Boolean{return false;}
      
      public function get model() : IListModel{return null;}
      
      public function set model(param1:IListModel) : void{}
      
      public function removeStateListener(param1:Function) : void{}
      
      public function scrollRectToVisible(param1:IntRectangle) : void{}
      
      public function setListData(param1:Array) : void{}
      
      public function setViewportTestSize(param1:IntDimension) : void{}
      
      public function updateListView() : void{}
      
      public function get verticalBlockIncrement() : int{return 0;}
      
      public function set verticalBlockIncrement(param1:int) : void{}
      
      public function get verticalUnitIncrement() : int{return 0;}
      
      public function set verticalUnitIncrement(param1:int) : void{}
      
      public function get viewPosition() : IntPoint{return null;}
      
      public function set viewPosition(param1:IntPoint) : void{}
      
      protected function __onItemInteractive(param1:MouseEvent) : void{}
      
      public function getCellAt(param1:int) : IListCell{return null;}
      
      public function getAllCells() : Vector.<IListCell>{return null;}
      
      public function get currentSelectedIndex() : int{return 0;}
      
      public function set currentSelectedIndex(param1:int) : void{}
      
      protected function addCellToContainer(param1:IListCell) : void{}
      
      override protected function addChildren() : void{}
      
      protected function creatMaskShape() : void{}
      
      protected function createCells() : void{}
      
      protected function createCellsWhenNotShareCells() : void{}
      
      protected function createCellsWhenShareCells() : void{}
      
      protected function createNewCell() : IListCell{return null;}
      
      protected function fireStateChanged(param1:Boolean = true) : void{}
      
      protected function getListCellModelHeight(param1:int) : int{return 0;}
      
      protected function getViewMaxPos() : IntPoint{return null;}
      
      override protected function init() : void{}
      
      protected function layoutWhenShareCellsHasNotSameHeight() : void{}
      
      protected function layoutWhenShareCellsHasSameHeight() : void{}
      
      override protected function onProppertiesUpdate() : void{}
      
      protected function refreshViewSize() : void{}
      
      public function get viewHeight() : Number{return 0;}
      
      public function set viewHeight(param1:Number) : void{}
      
      public function get viewWidth() : Number{return 0;}
      
      public function set viewWidth(param1:Number) : void{}
      
      public function unSelectedAll() : void{}
      
      protected function removeAllCell() : void{}
      
      protected function removeCellFromContainer(param1:IListCell) : void{}
      
      protected function restrictionViewPos(param1:IntPoint) : IntPoint{return null;}
      
      protected function updatePos() : void{}
      
      protected function updateShowMask() : void{}
      
      public function get cell() : Vector.<IListCell>{return null;}
   }
}
