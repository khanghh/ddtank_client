package ddt.view.bossbox
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class TimeCountDown extends EventDispatcher
   {
      
      public static const COUNTDOWN_COMPLETE:String = "TIME_countdown_complete";
      
      public static const COUNTDOWN_ONE:String = "countdown_one";
       
      
      private var _time:TimerJuggler;
      
      private var _count:int;
      
      private var _stepSecond:int;
      
      public function TimeCountDown(param1:int){super();}
      
      public function setTimeOnMinute(param1:Number) : void{}
      
      private function _timer(param1:Event) : void{}
      
      private function _timerComplete(param1:Event) : void{}
      
      public function dispose() : void{}
   }
}
