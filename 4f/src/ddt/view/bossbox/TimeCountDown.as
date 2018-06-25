package ddt.view.bossbox{   import flash.events.Event;   import flash.events.EventDispatcher;   import times.utils.timerManager.TimerJuggler;   import times.utils.timerManager.TimerManager;      public class TimeCountDown extends EventDispatcher   {            public static const COUNTDOWN_COMPLETE:String = "TIME_countdown_complete";            public static const COUNTDOWN_ONE:String = "countdown_one";                   private var _time:TimerJuggler;            private var _count:int;            private var _stepSecond:int;            public function TimeCountDown(stepSecond:int) { super(); }
            public function setTimeOnMinute(minute:Number) : void { }
            private function _timer(e:Event) : void { }
            private function _timerComplete(e:Event) : void { }
            public function dispose() : void { }
   }}