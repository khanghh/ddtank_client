package gradeAwardsBoxBtn.model
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class RemainingTimeManager
   {
      
      private static var instance:RemainingTimeManager;
       
      
      public var funOnTimer:Function = null;
      
      private var _timer:Timer;
      
      public function RemainingTimeManager(single:inner)
      {
         super();
         _timer = new Timer(30000);
      }
      
      public static function getInstance() : RemainingTimeManager
      {
         if(instance == null)
         {
            instance = new RemainingTimeManager(new inner());
         }
         return instance;
      }
      
      public function start() : void
      {
         _timer.addEventListener("timer",onTimer);
         _timer.start();
      }
      
      protected function onTimer(te:TimerEvent) : void
      {
         if(funOnTimer != null)
         {
            funOnTimer();
         }
      }
      
      public function stop() : void
      {
         _timer.removeEventListener("timer",onTimer);
         _timer.reset();
      }
      
      public function isRuning() : Boolean
      {
         return _timer && _timer.running;
      }
      
      public function dispose() : void
      {
         instance = null;
         _timer.stop();
         _timer.removeEventListener("timer",onTimer);
         _timer = null;
         funOnTimer = null;
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
