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
      
      public function TickOrderQueueAction(param1:Array, param2:uint = 100, param3:uint = 0, param4:uint = 0)
      {
         _interval = param2;
         _delay = param3;
         super(param1,param4);
      }
      
      override public function act() : void
      {
         if(_delay > 0)
         {
            _delayTimer = new Timer(_delay,1);
            _delayTimer.addEventListener("timerComplete",onDelayTimerComplete);
            _delayTimer.start();
         }
         else
         {
            super.act();
         }
      }
      
      private function onDelayTimerComplete(param1:TimerEvent) : void
      {
         removeDelayTimer();
         super.act();
      }
      
      private function removeDelayTimer() : void
      {
         if(_delayTimer)
         {
            _delayTimer.stop();
            _delayTimer.removeEventListener("timerComplete",onDelayTimerComplete);
            _delayTimer = null;
         }
      }
      
      override protected function actOne() : void
      {
         var _loc1_:IAction = _actList[_count] as IAction;
         startTickTimer();
         _loc1_.act();
      }
      
      private function startTickTimer() : void
      {
         _tickTimer = new Timer(_interval,1);
         _tickTimer.addEventListener("timerComplete",onTickTimerComplete);
         _tickTimer.start();
      }
      
      private function onTickTimerComplete(param1:TimerEvent) : void
      {
         removeTickTimer();
         actNext();
      }
      
      private function removeTickTimer() : void
      {
         if(_tickTimer)
         {
            _tickTimer.stop();
            _tickTimer.removeEventListener("timerComplete",onTickTimerComplete);
            _tickTimer = null;
         }
      }
      
      override protected function onLimitTimerComplete(param1:TimerEvent) : void
      {
         removeTickTimer();
         super.onLimitTimerComplete(param1);
      }
      
      override public function cancel() : void
      {
         removeTickTimer();
         super.cancel();
      }
   }
}
