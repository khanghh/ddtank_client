package com.pickgliss.action
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class BaseAction implements IAction
   {
       
      
      protected var _completeFun:Function;
      
      protected var _acting:Boolean;
      
      private var _limitTimer:Timer;
      
      private var _timeOut:uint;
      
      public function BaseAction(timeOut:uint = 0)
      {
         super();
      }
      
      public function act() : void
      {
         if(_timeOut > 0)
         {
            startLimitTimer();
         }
      }
      
      public function setCompleteFun(fun:Function) : void
      {
         _completeFun = fun;
      }
      
      private function startLimitTimer() : void
      {
         removeLimitTimer();
         _limitTimer = new Timer(_timeOut,1);
         _limitTimer.addEventListener("timerComplete",onLimitTimerComplete);
         _limitTimer.start();
      }
      
      protected function onLimitTimerComplete(event:TimerEvent) : void
      {
         removeLimitTimer();
         if(_acting)
         {
            cancel();
            execComplete();
         }
      }
      
      private function removeLimitTimer() : void
      {
         if(_limitTimer)
         {
            _limitTimer.stop();
            _limitTimer.removeEventListener("timerComplete",onLimitTimerComplete);
            _limitTimer = null;
         }
      }
      
      public function get acting() : Boolean
      {
         return _acting;
      }
      
      public function cancel() : void
      {
         removeLimitTimer();
         _acting = false;
      }
      
      protected function execComplete() : void
      {
         removeLimitTimer();
         if(_completeFun is Function)
         {
            _completeFun(this);
         }
      }
   }
}
