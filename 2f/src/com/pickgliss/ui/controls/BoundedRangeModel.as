package com.pickgliss.ui.controls{   import com.pickgliss.events.InteractiveEvent;   import flash.events.EventDispatcher;      public class BoundedRangeModel extends EventDispatcher   {                   private var value:int;            private var extent:int;            private var min:int;            private var max:int;            private var isAdjusting:Boolean;            public function BoundedRangeModel(value:int = 0, extent:int = 0, min:int = 0, max:int = 100) { super(); }
            public function getValue() : int { return 0; }
            public function getExtent() : int { return 0; }
            public function getMinimum() : int { return 0; }
            public function getMaximum() : int { return 0; }
            public function setValue(n:int) : void { }
            public function setExtent(n:int) : void { }
            public function setMinimum(n:int) : void { }
            public function setMaximum(n:int) : void { }
            public function setValueIsAdjusting(b:Boolean) : void { }
            public function getValueIsAdjusting() : Boolean { return false; }
            public function setRangeProperties(newValue:int, newExtent:int, newMin:int, newMax:int, adjusting:Boolean) : void { }
            public function addStateListener(listener:Function, priority:int = 0, useWeakReference:Boolean = false) : void { }
            public function removeStateListener(listener:Function) : void { }
            protected function fireStateChanged() : void { }
            override public function toString() : String { return null; }
   }}