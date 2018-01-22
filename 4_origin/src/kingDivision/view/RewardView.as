package kingDivision.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import kingDivision.KingDivisionManager;
   
   public class RewardView extends Frame
   {
      
      private static const THISZONE:int = 0;
      
      private static const ALLZONE:int = 1;
       
      
      private var _bg:Bitmap;
      
      private var _thisZoneBtn:SelectedCheckButton;
      
      private var _allZoneBtn:SelectedCheckButton;
      
      private var _selectedBtnGroup:SelectedButtonGroup;
      
      private var _rewardList:RewardList;
      
      private var _rewardPanel:ScrollPanel;
      
      public function RewardView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _selectedBtnGroup = new SelectedButtonGroup(false,1);
         titleText = LanguageMgr.GetTranslation("kingDivision.rewardView.titleName");
         _bg = ComponentFactory.Instance.creatBitmap("asset.rewardView.bg");
         _thisZoneBtn = ComponentFactory.Instance.creatComponentByStylename("rewardView.thisZoneBtn");
         _selectedBtnGroup.addSelectItem(_thisZoneBtn);
         _allZoneBtn = ComponentFactory.Instance.creatComponentByStylename("rewardView.allZoneBtn");
         _selectedBtnGroup.addSelectItem(_allZoneBtn);
         _rewardList = ComponentFactory.Instance.creatComponentByStylename("kingDivision.RewardList");
         _rewardPanel = ComponentFactory.Instance.creatComponentByStylename("assets.rewardView.consorPanel");
         _rewardPanel.setView(_rewardList);
         addToContent(_bg);
         addToContent(_thisZoneBtn);
         addToContent(_allZoneBtn);
         addToContent(_rewardPanel);
         _selectedBtnGroup.selectIndex = 0;
         KingDivisionManager.Instance.model.goodsZone = 0;
         updateRewardList();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__responseHandler);
         _selectedBtnGroup.addEventListener("change",__typeChange);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _selectedBtnGroup.removeEventListener("change",__typeChange);
      }
      
      private function __typeChange(param1:Event) : void
      {
         defaultShowThisZoneView();
      }
      
      private function defaultShowThisZoneView() : void
      {
         switch(int(_selectedBtnGroup.selectIndex))
         {
            case 0:
               KingDivisionManager.Instance.model.goodsZone = 0;
               updateRewardList();
               break;
            case 1:
               KingDivisionManager.Instance.model.goodsZone = 1;
               updateRewardList();
         }
      }
      
      private function updateRewardList() : void
      {
         if(_rewardList)
         {
            ObjectUtils.disposeObject(_rewardList);
            _rewardList = null;
         }
         if(_rewardPanel)
         {
            ObjectUtils.disposeObject(_rewardPanel);
            _rewardPanel = null;
         }
         _rewardList = ComponentFactory.Instance.creatComponentByStylename("kingDivision.RewardList");
         _rewardPanel = ComponentFactory.Instance.creatComponentByStylename("assets.rewardView.consorPanel");
         _rewardPanel.setView(_rewardList);
         addToContent(_rewardPanel);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_thisZoneBtn);
         _thisZoneBtn = null;
         ObjectUtils.disposeObject(_allZoneBtn);
         _allZoneBtn = null;
         ObjectUtils.disposeObject(_rewardList);
         _rewardList = null;
         ObjectUtils.disposeObject(_rewardPanel);
         _rewardPanel = null;
         super.dispose();
      }
   }
}
