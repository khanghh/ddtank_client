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
      
      public function BaseAction(param1:uint = 0){super();}
      
      public function act() : void{}
      
      public function setCompleteFun(param1:Function) : void{}
      
      private function startLimitTimer() : void{}
      
      protected function onLimitTimerComplete(param1:TimerEvent) : void{}
      
      private function removeLimitTimer() : void{}
      
      public function get acting() : Boolean{return false;}
      
      public function cancel() : void{}
      
      protected function execComplete() : void{}
   }
}
