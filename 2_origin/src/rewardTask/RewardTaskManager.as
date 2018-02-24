package rewardTask
{
   import ddt.CoreManager;
   
   public class RewardTaskManager extends CoreManager
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
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
