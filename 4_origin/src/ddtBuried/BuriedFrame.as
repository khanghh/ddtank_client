package ddtBuried
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddtBuried.event.BuriedEvent;
   import ddtBuried.views.BuriedRewardsProgressBar;
   import ddtBuried.views.BuriedView;
   import ddtBuried.views.DiceView;
   import trainer.view.NewHandContainer;
   
   public class BuriedFrame extends Frame
   {
      
      private static const MAP1:int = 1;
      
      private static const MAP2:int = 2;
      
      private static const MAP3:int = 3;
       
      
      private var _buriedView:BuriedView;
      
      private var _diceView:DiceView;
      
      private var _rewardsProgressBar:BuriedRewardsProgressBar;
      
      private var _type:int;
      
      public function BuriedFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
      }
      
      public function addRewardsProgressBar() : void
      {
         _rewardsProgressBar = new BuriedRewardsProgressBar();
         _rewardsProgressBar.x = 184;
         _rewardsProgressBar.y = 9;
         addToContent(_rewardsProgressBar);
      }
      
      public function updateProgressBar() : void
      {
         _rewardsProgressBar.updateProgressState();
      }
      
      public function updatePlayGainedAnimation(param1:int) : void
      {
         _rewardsProgressBar.playGainBox(param1);
      }
      
      public function updateShowGetRewardBoxAnimation(param1:int) : void
      {
         _rewardsProgressBar.playGetRewardBoxAnimation(param1);
      }
      
      public function addDiceView(param1:int) : void
      {
         _diceView = new DiceView();
         switch(int(param1) - 1)
         {
            case 0:
               _diceView.addMaps(BuriedControl.Instance.mapArrays.itemMaps1,11,7,2,94);
               break;
            case 1:
               _diceView.addMaps(BuriedControl.Instance.mapArrays.itemMaps2,8,8,136,81);
               break;
            case 2:
               _diceView.addMaps(BuriedControl.Instance.mapArrays.itemMaps3,9,8,136,74);
         }
         addToContent(_diceView);
      }
      
      public function setStarList(param1:int) : void
      {
         _diceView.setStarList(param1);
      }
      
      public function updataStarLevel(param1:int) : void
      {
         _diceView.updataStarLevel(param1);
      }
      
      public function setCrFrame(param1:String) : void
      {
         _diceView.setCrFrame(param1);
      }
      
      public function setTxt(param1:String, param2:Boolean = true) : void
      {
         _diceView.setTxt(param1,param2);
      }
      
      public function play() : void
      {
         _diceView.play();
      }
      
      public function upDataBtn() : void
      {
         _diceView.upDataBtn();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",_response);
         BuriedControl.Instance.addEventListener("openburiedview",openBuriedHander);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",_response);
         BuriedControl.Instance.removeEventListener("openburiedview",openBuriedHander);
      }
      
      private function openBuriedHander(param1:BuriedEvent) : void
      {
         if(_buriedView)
         {
            ObjectUtils.disposeObject(_buriedView);
            _buriedView = null;
         }
         _buriedView = new BuriedView();
         addToContent(_buriedView);
      }
      
      private function _response(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         NewHandContainer.Instance.clearArrowByID(136);
         removeEvents();
         if(_rewardsProgressBar)
         {
            _rewardsProgressBar.dispose();
         }
         if(_diceView)
         {
            _diceView.dispose();
         }
         if(_buriedView)
         {
            _buriedView.dispose();
         }
         ObjectUtils.disposeObject(_buriedView);
         ObjectUtils.disposeObject(_diceView);
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         super.dispose();
         _diceView = null;
         _buriedView = null;
         SocketManager.Instance.out.outCard();
      }
   }
}
