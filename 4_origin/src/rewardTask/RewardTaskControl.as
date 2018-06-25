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
      
      public function RewardTaskControl($inner:inner)
      {
         super();
      }
      
      public static function get instance() : RewardTaskControl
      {
         if(_instance == null)
         {
            _instance = new RewardTaskControl(new inner());
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _model = new RewardTaskModel();
         RewardTaskManager.instance.addEventListener("complete",__onComplete);
      }
      
      private function __onComplete(e:Event) : void
      {
         SocketManager.Instance.out.sendRewardTaskQuestOfferInfo();
         new HelperUIModuleLoad().loadUIModule(["rewardTask"],showFrame);
      }
      
      private function showFrame() : void
      {
         var frame:RewardTaskMainView = ComponentFactory.Instance.creatComponentByStylename("rewardTask.mainView");
         frame.show();
      }
      
      public function get model() : RewardTaskModel
      {
         return _model;
      }
      
      public function get rewardTaskPrice() : int
      {
         return ServerConfigManager.instance.rewardTaskPrice;
      }
      
      public function get rewardMultiplePrice() : int
      {
         return ServerConfigManager.instance.rewardMultiplePrice;
      }
      
      public function get addRewardTask() : int
      {
         return ServerConfigManager.instance.addRewardTaskPrice;
      }
      
      public function get taskNum() : int
      {
         return ServerConfigManager.instance.taskNumber;
      }
      
      public function get addTaskNumPrice() : int
      {
         return ServerConfigManager.instance.addTaskNumPrice;
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
