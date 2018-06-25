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
      
      public function TickOrderQueueAction(actList:Array, interval:uint = 100, delay:uint = 0, timeOut:uint = 0)
      {
         _interval = interval;
         _delay = delay;
         super(actList,timeOut);
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
      
      private function onDelayTimerComplete(event:TimerEvent) : void
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
         var action:IAction = _actList[_count] as IAction;
         startTickTimer();
         action.act();
      }
      
      private function startTickTimer() : void
      {
         _tickTimer = new Timer(_interval,1);
         _tickTimer.addEventListener("timerComplete",onTickTimerComplete);
         _tickTimer.start();
      }
      
      private function onTickTimerComplete(event:TimerEvent) : void
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
      
      override protected function onLimitTimerComplete(event:TimerEvent) : void
      {
         removeTickTimer();
         super.onLimitTimerComplete(event);
      }
      
      override public function cancel() : void
      {
         removeTickTimer();
         super.cancel();
      }
   }
}
