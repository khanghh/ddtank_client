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
      
      public function TimerManager(param1:inner)
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
      
      public function addTimerJuggler(param1:Number, param2:int = 0, param3:Boolean = true, param4:String = "common") : TimerJuggler
      {
         var _loc5_:* = param4;
         if("common" !== _loc5_)
         {
            if("80ms" !== _loc5_)
            {
               if("1s" !== _loc5_)
               {
                  return _timerSpecial.addTimer(param1,param2,param3,param4);
               }
               return _timer1000ms.addTimer(param1,param2,param3,param4);
            }
            return _timer80ms.addTimer(param1,param2,param3,param4);
         }
         return _timerSpecial.addTimer(param1,param2,param3,param4);
      }
      
      public function removeTimerJuggler(param1:uint) : void
      {
         _timerSpecial.removeTimer(param1);
      }
      
      public function removeJugglerByTimer(param1:TimerJuggler) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:* = param1.type;
         if("common" !== _loc2_)
         {
            if("80ms" !== _loc2_)
            {
               if("1s" === _loc2_)
               {
                  _timer1000ms.removeTimer(param1.id);
               }
            }
            else
            {
               _timer80ms.removeTimer(param1.id);
            }
         }
         else
         {
            _timerSpecial.removeTimer(param1.id);
         }
      }
      
      public function addTimer1000ms(param1:Number, param2:int = 0) : TimerJuggler
      {
         return _timer1000ms.addTimer(param1,param2,false,"1s");
      }
      
      public function removeTimer1000ms(param1:TimerJuggler) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.type != "1s")
         {
            return;
         }
         _timer1000ms.removeTimer(param1.id);
      }
      
      public function addTimer100ms(param1:Number, param2:int = 0) : TimerJuggler
      {
         return _timerSpecial.addTimer(param1,param2,false,"common");
      }
      
      public function removeTimer100ms(param1:TimerJuggler) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.type != "common")
         {
            return;
         }
         _timerSpecial.removeTimer(param1.id);
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
