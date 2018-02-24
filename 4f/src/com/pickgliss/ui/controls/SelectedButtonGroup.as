package com.pickgliss.ui.controls
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   
   public class SelectedButtonGroup extends EventDispatcher implements Disposeable
   {
       
      
      private var _canUnSelect:Boolean;
      
      private var _currentSelecetdIndex:int = -1;
      
      private var _items:Vector.<ISelectable>;
      
      private var _lastSelectedButton:ISelectable;
      
      private var _mutiSelectCount:int;
      
      public function SelectedButtonGroup(param1:Boolean = false, param2:int = 1){super();}
      
      public function addSelectItem(param1:ISelectable) : void{}
      
      public function dispose() : void{}
      
      public function length() : int{return 0;}
      
      public function getSelectIndexByItem(param1:ISelectable) : int{return 0;}
      
      public function getItemByIndex(param1:int) : ISelectable{return null;}
      
      public function removeItemByIndex(param1:int) : void{}
      
      public function removeSelectItem(param1:ISelectable) : void{}
      
      public function get selectIndex() : int{return 0;}
      
      public function set selectIndex(param1:int) : void{}
      
      public function get selectedCount() : int{return 0;}
      
      public function set selectedCount(param1:int) : void{}
      
      private function __onItemClicked(param1:MouseEvent) : void{}
   }
}
