package rewardTask
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class RewardTaskManager extends EventDispatcher
   {
      
      private static var _instance:RewardTaskManager;
       
      
      public function RewardTaskManager(param1:inner)
      {
         super(null);
      }
      
      public static function get instance() : RewardTaskManager
      {
         if(_instance == null)
         {
            _instance = new RewardTaskManager(new inner());
         }
         return _instance;
      }
      
      public function show() : void
      {
         dispatchEvent(new Event("complete"));
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
