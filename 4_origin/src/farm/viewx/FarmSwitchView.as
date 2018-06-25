package farm.viewx
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.states.BaseStateView;
   import ddt.view.MainToolBar;
   import farm.FarmModelController;
   import petsBag.PetsBagManager;
   import petsBag.event.UpdatePetFarmGuildeEvent;
   
   public class FarmSwitchView extends BaseStateView
   {
       
      
      private var _farmMainView:FarmMainView;
      
      public function FarmSwitchView()
      {
         super();
      }
      
      override public function enter(prev:BaseStateView, playerId:Object = null) : void
      {
         super.enter(prev,playerId);
         ObjectUtils.disposeObject(_farmMainView);
         _farmMainView = new FarmMainView();
         addChild(_farmMainView);
         MainToolBar.Instance.show();
         ChatManager.Instance.state = 27;
         ChatManager.Instance.lock = ChatManager.HALL_CHAT_LOCK;
         addChild(ChatManager.Instance.view);
         PetsBagManager.instance().addEventListener("finish",__updatePetFarmGuilde);
         FarmModelController.instance.creatSuperPetFoodPriceList();
      }
      
      private function __updatePetFarmGuilde(e:UpdatePetFarmGuildeEvent) : void
      {
         PetsBagManager.instance().finishTask();
         petFarmGuilde();
      }
      
      private function petFarmGuilde() : void
      {
         if(PetsBagManager.instance().haveTaskOrderByID(368))
         {
            PetsBagManager.instance().showPetFarmGuildArrow(94,50,"farmTrainer.openPetBagArrowPos","asset.farmTrainer.clickHere","farmTrainer.openPetBagTipPos",this);
         }
      }
      
      override public function leaving(next:BaseStateView) : void
      {
         PetsBagManager.instance().removeEventListener("finish",__updatePetFarmGuilde);
         ObjectUtils.disposeObject(_farmMainView);
         _farmMainView = null;
         super.leaving(next);
         FarmModelController.instance.stopTimer();
         MainToolBar.Instance.hide();
         dispose();
      }
      
      override public function getBackType() : String
      {
         return "main";
      }
      
      override public function getType() : String
      {
         return "farm";
      }
      
      override public function refresh() : void
      {
         super.refresh();
      }
      
      override public function dispose() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
