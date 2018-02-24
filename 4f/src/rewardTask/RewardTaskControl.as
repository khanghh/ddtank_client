package rewardTask
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.Event;
   import rewardTask.data.RewardTaskModel;
   import rewardTask.view.RewardTaskMainView;
   
   public class RewardTaskControl
   {
      
      private static var _instance:RewardTaskControl;
       
      
      private var _model:RewardTaskModel;
      
      public function RewardTaskControl(param1:inner){super();}
      
      public static function get instance() : RewardTaskControl{return null;}
      
      public function setup() : void{}
      
      private function __onComplete(param1:Event) : void{}
      
      private function showFrame() : void{}
      
      public function get model() : RewardTaskModel{return null;}
      
      public function get rewardTaskPrice() : int{return 0;}
      
      public function get rewardMultiplePrice() : int{return 0;}
      
      public function get addRewardTask() : int{return 0;}
      
      public function get taskNum() : int{return 0;}
      
      public function get addTaskNumPrice() : int{return 0;}
   }
}

class inner
{
    
   
   function inner(){super();}
}
