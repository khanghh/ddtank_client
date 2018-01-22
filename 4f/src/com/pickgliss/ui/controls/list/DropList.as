package com.pickgliss.ui.controls.list
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.controls.cell.IDropListCell;
   import com.pickgliss.ui.controls.container.BoxContainer;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class DropList extends Component implements Disposeable
   {
      
      public static const SELECTED:String = "selected";
      
      public static const P_backgound:String = "backgound";
      
      public static const P_container:String = "container";
       
      
      private var _backStyle:String;
      
      private var _backGround:DisplayObject;
      
      private var _cellStyle:String;
      
      private var _containerStyle:String;
      
      private var _container:BoxContainer;
      
      private var _targetDisplay:IDropListTarget;
      
      private var _showLength:int;
      
      private var _dataList:Array;
      
      private var _items:Vector.<IDropListCell>;
      
      private var _currentSelectedIndex:int;
      
      private var _preItemIdx:int;
      
      private var _cellHeight:int;
      
      private var _cellWidth:int;
      
      private var _isListening:Boolean;
      
      private var _canUseEnter:Boolean = true;
      
      public function DropList(){super();}
      
      override protected function init() : void{}
      
      public function set container(param1:BoxContainer) : void{}
      
      public function set containerStyle(param1:String) : void{}
      
      public function set cellStyle(param1:String) : void{}
      
      public function set dataList(param1:Array) : void{}
      
      private function updateBg() : void{}
      
      private function getHightLightItemIdx() : int{return 0;}
      
      private function unSelectedAllItems() : int{return 0;}
      
      private function updateItemValue(param1:Boolean = false) : void{}
      
      private function setHightLightItem(param1:Boolean = false) : void{}
      
      override protected function addChildren() : void{}
      
      public function set targetDisplay(param1:IDropListTarget) : void{}
      
      private function __onRemoveFromStage(param1:Event) : void{}
      
      public function set showLength(param1:int) : void{}
      
      private function __onCellMouseClick(param1:MouseEvent) : void{}
      
      private function __onCellMouseOver(param1:MouseEvent) : void{}
      
      override protected function onProppertiesUpdate() : void{}
      
      private function __onKeyDown(param1:KeyboardEvent) : void{}
      
      public function set canUseEnter(param1:Boolean) : void{}
      
      public function get canUseEnter() : Boolean{return false;}
      
      public function set currentSelectedIndex(param1:int) : void{}
      
      private function setTargetValue() : void{}
      
      private function __setSelection(param1:Event) : void{}
      
      public function set backStyle(param1:String) : void{}
      
      public function set backgound(param1:DisplayObject) : void{}
      
      override public function dispose() : void{}
   }
}
