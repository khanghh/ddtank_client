package com.pickgliss.ui.controls.list{   import com.pickgliss.utils.ArrayUtils;      public class BaseListModel   {                   private var listeners:Array;            public function BaseListModel() { super(); }
            public function addListDataListener(l:ListDataListener) : void { }
            public function removeListDataListener(l:ListDataListener) : void { }
            protected function fireContentsChanged(target:Object, index0:int, index1:int, removedItems:Array) : void { }
            protected function fireIntervalAdded(target:Object, index0:int, index1:int) : void { }
            protected function fireIntervalRemoved(target:Object, index0:int, index1:int, removedItems:Array) : void { }
   }}