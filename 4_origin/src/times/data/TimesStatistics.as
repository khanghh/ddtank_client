package times.data
{
   import flash.events.Event;
   import times.TimesController;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class TimesStatistics
   {
       
      
      private var _stayTime:Vector.<int>;
      
      private var _timer:TimerJuggler;
      
      private var _controller:TimesController;
      
      public function TimesStatistics()
      {
         super();
         _controller = TimesController.Instance;
         _stayTime = new Vector.<int>(5);
         _timer = TimerManager.getInstance().addTimerJuggler(1000);
         _timer.addEventListener("timer",__timerTick);
      }
      
      public function get stayTime() : Vector.<int>
      {
         return _stayTime;
      }
      
      private function __timerTick(param1:Event) : void
      {
         var _loc2_:* = _controller.currentPointer;
         var _loc3_:* = _stayTime[_loc2_] + 1;
         _stayTime[_loc2_] = _loc3_;
      }
      
      public function startTick() : void
      {
         if(_timer && !_timer.running)
         {
            _stayTime = new Vector.<int>(5);
            _timer.start();
         }
      }
      
      public function stopTick() : void
      {
         if(_timer && _timer.running)
         {
            _timer.stop();
         }
      }
      
      public function dispose() : void
      {
         _controller = null;
         _stayTime = null;
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerTick);
            TimerManager.getInstance().removeTimerJuggler(_timer.id);
            _timer = null;
         }
      }
   }
}
