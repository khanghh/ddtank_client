package rewardTask
{
   import ddt.CoreManager;
   
   public class RewardTaskManager extends CoreManager
   {
      
      private static var _instance:RewardTaskManager;
       
      
      public function RewardTaskManager(param1:inner){super(null);}
      
      public static function get instance() : RewardTaskManager{return null;}
   }
}

class inner
{
    
   
   function inner(){super();}
}
