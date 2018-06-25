package com.pickgliss.ui.controls.list{   import com.pickgliss.events.ModelEvent;      public class ListDataEvent extends ModelEvent   {                   private var index0:int;            private var index1:int;            private var removedItems:Array;            public function ListDataEvent(source:Object, index0:int, index1:int, removedItems:Array) { super(null); }
            public function getIndex0() : int { return 0; }
            public function getIndex1() : int { return 0; }
            public function getRemovedItems() : Array { return null; }
   }}