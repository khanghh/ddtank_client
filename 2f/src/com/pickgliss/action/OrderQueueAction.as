package com.pickgliss.action{   public class OrderQueueAction extends BaseAction   {                   protected var _actList:Array;            protected var _count:int;            public function OrderQueueAction(actList:Array, timeOut:uint = 0) { super(null); }
            override public function act() : void { }
            private function startAct() : void { }
            protected function actOne() : void { }
            private function actOneComplete(target:IAction) : void { }
            protected function actNext() : void { }
            override public function cancel() : void { }
            public function getActions() : Array { return null; }
   }}