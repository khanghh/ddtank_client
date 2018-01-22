package times.utils.timerManager
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public final class TimerJuggler extends EventDispatcher
   {
       
      
      private var _id:uint;
      
      private var _delay:Number;
      
      private var _repeatCount:int;
      
      private var _running:Boolean;
      
      private var _currentCount:int = 0;
      
      private var _totalTime:Number;
      
      private var _currentTime:int = 0;
      
      private var _revise:Boolean;
      
      private var _type:String;
      
      public function TimerJuggler(param1:InternalFlag, param2:Number, param3:int, param4:int, param5:Boolean, param6:String)
      {
         super();
         _delay = param2;
         _repeatCount = param3;
         _id = param4;
         _running = false;
         _totalTime = param3 * param2;
         _revise = param5;
      }
      
      final function advance(param1:Number) : void
      {
         var _loc2_:Boolean = false;
         if(!_running)
         {
            return;
         }
         _currentTime = _currentTime + param1;
         if(_currentTime < (_currentCount + 1) * delay)
         {
            return;
         }
         if(_revise)
         {
            _currentCount = _currentTime / delay;
            _loc2_ = _currentTime >= _totalTime && _totalTime > 0;
         }
         else
         {
            _currentCount = Number(_currentCount) + 1;
            _loc2_ = _currentCount >= repeatCount && repeatCount > 0;
         }
         if(_loc2_)
         {
            _running = false;
            dispatchEvent(new Event("timer"));
            dispatchEvent(new Event("timerComplete"));
            _currentCount = 0;
            _currentTime = 0;
         }
         else
         {
            dispatchEvent(new Event("timer"));
         }
      }
      
      public function reset() : void
      {
         _running = false;
         _currentCount = 0;
         _currentTime = 0;
      }
      
      public function start() : void
      {
         _running = true;
      }
      
      public function stop() : void
      {
         _running = false;
      }
      
      public function get running() : Boolean
      {
         return _running;
      }
      
      public function get currentCount() : int
      {
         if(repeatCount == 0)
         {
            return _currentCount;
         }
         return Math.min(repeatCount,_currentCount);
      }
      
      public function get id() : uint
      {
         return _id;
      }
      
      public function get repeatCount() : int
      {
         return _repeatCount;
      }
      
      public function set repeatCount(param1:int) : void
      {
         _repeatCount = param1;
         _totalTime = _repeatCount * _delay;
      }
      
      public function get delay() : Number
      {
         return _delay;
      }
      
      public function set delay(param1:Number) : void
      {
         _delay = param1;
         _totalTime = _repeatCount * _delay;
      }
      
      public function get revise() : Boolean
      {
         return _revise;
      }
      
      public function get type() : String
      {
         return _type;
      }
   }
}
