package times.utils.timerManager
{
   public class TimerManager
   {
      
      public static const TIMER_COMPLETE:String = "timerComplete";
      
      public static const TIMER:String = "timer";
      
      public static const COMMON:String = "common";
      
      public static const Delay80ms:String = "80ms";
      
      public static const Delay1000ms:String = "1s";
      
      private static var instance:TimerManager;
       
      
      private var _timerSpecial:TManagerJuggler;
      
      private var _timer80ms:TManagerJuggler;
      
      private var _timer1000ms:TManagerJuggler;
      
      public function TimerManager(param1:inner){super();}
      
      public static function getInstance() : TimerManager{return null;}
      
      public function addTimerJuggler(param1:Number, param2:int = 0, param3:Boolean = true, param4:String = "common") : TimerJuggler{return null;}
      
      public function removeTimerJuggler(param1:uint) : void{}
      
      public function removeJugglerByTimer(param1:TimerJuggler) : void{}
      
      public function addTimer1000ms(param1:Number, param2:int = 0) : TimerJuggler{return null;}
      
      public function removeTimer1000ms(param1:TimerJuggler) : void{}
      
      public function addTimer100ms(param1:Number, param2:int = 0) : TimerJuggler{return null;}
      
      public function removeTimer100ms(param1:TimerJuggler) : void{}
   }
}

class inner
{
    
   
   function inner(){super();}
}
