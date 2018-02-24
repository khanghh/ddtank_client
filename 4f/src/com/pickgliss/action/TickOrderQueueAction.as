package com.pickgliss.action
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class TickOrderQueueAction extends OrderQueueAction
   {
       
      
      private var _interval:uint;
      
      private var _tickTimer:Timer;
      
      private var _delay:uint;
      
      private var _delayTimer:Timer;
      
      public function TickOrderQueueAction(param1:Array, param2:uint = 100, param3:uint = 0, param4:uint = 0){super(null,null);}
      
      override public function act() : void{}
      
      private function onDelayTimerComplete(param1:TimerEvent) : void{}
      
      private function removeDelayTimer() : void{}
      
      override protected function actOne() : void{}
      
      private function startTickTimer() : void{}
      
      private function onTickTimerComplete(param1:TimerEvent) : void{}
      
      private function removeTickTimer() : void{}
      
      override protected function onLimitTimerComplete(param1:TimerEvent) : void{}
      
      override public function cancel() : void{}
   }
}
