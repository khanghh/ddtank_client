package com.pickgliss.action{   import flash.events.TimerEvent;   import flash.utils.Timer;      public class TickOrderQueueAction extends OrderQueueAction   {                   private var _interval:uint;            private var _tickTimer:Timer;            private var _delay:uint;            private var _delayTimer:Timer;            public function TickOrderQueueAction(actList:Array, interval:uint = 100, delay:uint = 0, timeOut:uint = 0) { super(null,null); }
            override public function act() : void { }
            private function onDelayTimerComplete(event:TimerEvent) : void { }
            private function removeDelayTimer() : void { }
            override protected function actOne() : void { }
            private function startTickTimer() : void { }
            private function onTickTimerComplete(event:TimerEvent) : void { }
            private function removeTickTimer() : void { }
            override protected function onLimitTimerComplete(event:TimerEvent) : void { }
            override public function cancel() : void { }
   }}