package com.pickgliss.ui.controls{   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.MouseEvent;      public class SelectedButtonGroup extends EventDispatcher implements Disposeable   {                   private var _canUnSelect:Boolean;            private var _currentSelecetdIndex:int = -1;            private var _items:Vector.<ISelectable>;            private var _lastSelectedButton:ISelectable;            private var _mutiSelectCount:int;            public function SelectedButtonGroup(canUnSelect:Boolean = false, mutiSelectCount:int = 1) { super(); }
            public function addSelectItem(item:ISelectable) : void { }
            public function dispose() : void { }
            public function length() : int { return 0; }
            public function getSelectIndexByItem(item:ISelectable) : int { return 0; }
            public function getItemByIndex($index:int) : ISelectable { return null; }
            public function removeItemByIndex(index:int) : void { }
            public function removeSelectItem(item:ISelectable) : void { }
            public function get selectIndex() : int { return 0; }
            public function set selectIndex(index:int) : void { }
            public function get selectedCount() : int { return 0; }
            public function set selectedCount(value:int) : void { }
            private function __onItemClicked(event:MouseEvent) : void { }
   }}