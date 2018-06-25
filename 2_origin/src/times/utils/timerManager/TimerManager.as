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
      
      public function TimerManager(single:inner)
      {
         super();
         _timerSpecial = new TManagerJuggler(new InternalFlag(),0);
         _timer80ms = new TManagerJuggler(new InternalFlag(),0);
         _timer1000ms = new TManagerJuggler(new InternalFlag(),0);
         _timerSpecial.init(100);
         _timer80ms.init(80);
         _timer1000ms.init(1000);
      }
      
      public static function getInstance() : TimerManager
      {
         if(!instance)
         {
            instance = new TimerManager(new inner());
         }
         return instance;
      }
      
      public function addTimerJuggler(delay:Number, repeatCount:int = 0, revise:Boolean = true, type:String = "common") : TimerJuggler
      {
         var _loc5_:* = type;
         if("common" !== _loc5_)
         {
            if("80ms" !== _loc5_)
            {
               if("1s" !== _loc5_)
               {
                  return _timerSpecial.addTimer(delay,repeatCount,revise,type);
               }
               return _timer1000ms.addTimer(delay,repeatCount,revise,type);
            }
            return _timer80ms.addTimer(delay,repeatCount,revise,type);
         }
         return _timerSpecial.addTimer(delay,repeatCount,revise,type);
      }
      
      public function removeTimerJuggler(id:uint) : void
      {
         _timerSpecial.removeTimer(id);
      }
      
      public function removeJugglerByTimer(timer:TimerJuggler) : void
      {
         if(timer == null)
         {
            return;
         }
         var _loc2_:* = timer.type;
         if("common" !== _loc2_)
         {
            if("80ms" !== _loc2_)
            {
               if("1s" === _loc2_)
               {
                  _timer1000ms.removeTimer(timer.id);
               }
            }
            else
            {
               _timer80ms.removeTimer(timer.id);
            }
         }
         else
         {
            _timerSpecial.removeTimer(timer.id);
         }
      }
      
      public function addTimer1000ms(delay:Number, repeatCount:int = 0) : TimerJuggler
      {
         return _timer1000ms.addTimer(delay,repeatCount,false,"1s");
      }
      
      public function removeTimer1000ms(timer:TimerJuggler) : void
      {
         if(timer == null)
         {
            return;
         }
         if(timer.type != "1s")
         {
            return;
         }
         _timer1000ms.removeTimer(timer.id);
      }
      
      public function addTimer100ms(delay:Number, repeatCount:int = 0) : TimerJuggler
      {
         return _timerSpecial.addTimer(delay,repeatCount,false,"common");
      }
      
      public function removeTimer100ms(timer:TimerJuggler) : void
      {
         if(timer == null)
         {
            return;
         }
         if(timer.type != "common")
         {
            return;
         }
         _timerSpecial.removeTimer(timer.id);
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
