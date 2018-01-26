package rewardTask
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class RewardTaskManager extends EventDispatcher
   {
      
      private static var _instance:RewardTaskManager;
       
      
      public function RewardTaskManager(param1:inner){super(null);}
      
      public static function get instance() : RewardTaskManager{return null;}
      
      public function show() : void{}
   }
}

class inner
{
    
   
   function inner(){super();}
}
