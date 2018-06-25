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
      
      public function TimeCountDown(stepSecond:int)
      {
         super();
         _stepSecond = stepSecond;
         _time = TimerManager.getInstance().addTimerJuggler(_stepSecond);
         _time.stop();
      }
      
      public function setTimeOnMinute(minute:Number) : void
      {
         minute = minute < 0?0:Number(minute);
         _count = minute * 60 * 1000 / _stepSecond;
         if(_count > 0)
         {
            _time.repeatCount = _count;
            _time.reset();
            _time.start();
            _time.addEventListener("timer",_timer);
            _time.addEventListener("timerComplete",_timerComplete);
         }
      }
      
      private function _timer(e:Event) : void
      {
         dispatchEvent(new Event("countdown_one"));
      }
      
      private function _timerComplete(e:Event) : void
      {
         dispatchEvent(new Event("TIME_countdown_complete"));
      }
      
      public function dispose() : void
      {
         if(_time)
         {
            _time.stop();
            _time.removeEventListener("timer",_timer);
            _time.removeEventListener("timerComplete",_timerComplete);
            TimerManager.getInstance().removeJugglerByTimer(_time);
         }
         _time = null;
      }
   }
}
