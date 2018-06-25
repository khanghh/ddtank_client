package times.utils.timerManager{   public class TimerManager   {            public static const TIMER_COMPLETE:String = "timerComplete";            public static const TIMER:String = "timer";            public static const COMMON:String = "common";            public static const Delay80ms:String = "80ms";            public static const Delay1000ms:String = "1s";            private static var instance:TimerManager;                   private var _timerSpecial:TManagerJuggler;            private var _timer80ms:TManagerJuggler;            private var _timer1000ms:TManagerJuggler;            public function TimerManager(single:inner) { super(); }
            public static function getInstance() : TimerManager { return null; }
            public function addTimerJuggler(delay:Number, repeatCount:int = 0, revise:Boolean = true, type:String = "common") : TimerJuggler { return null; }
            public function removeTimerJuggler(id:uint) : void { }
            public function removeJugglerByTimer(timer:TimerJuggler) : void { }
            public function addTimer1000ms(delay:Number, repeatCount:int = 0) : TimerJuggler { return null; }
            public function removeTimer1000ms(timer:TimerJuggler) : void { }
            public function addTimer100ms(delay:Number, repeatCount:int = 0) : TimerJuggler { return null; }
            public function removeTimer100ms(timer:TimerJuggler) : void { }
   }}class inner{          function inner() { super(); }
}