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
      
      public function TimesStatistics(){super();}
      
      public function get stayTime() : Vector.<int>{return null;}
      
      private function __timerTick(param1:Event) : void{}
      
      public function startTick() : void{}
      
      public function stopTick() : void{}
      
      public function dispose() : void{}
   }
}
