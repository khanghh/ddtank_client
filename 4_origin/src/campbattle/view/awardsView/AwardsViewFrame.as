package campbattle.view.awardsView
{
   import campbattle.CampBattleManager;
   import campbattle.view.CampBattleHelpView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class AwardsViewFrame extends Frame
   {
      
      private static const AWARDS:int = 0;
      
      private static const MYAWARDS:int = 1;
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _awardsBtn:SelectedButton;
      
      private var _myAwardsBtn:SelectedButton;
      
      private var _selectedBtnGroup:SelectedButtonGroup;
      
      private var _rewardList:AwardsList;
      
      private var _rewardPanel:ScrollPanel;
      
      private var _bg1:Bitmap;
      
      private var _txt:FilterFrameText;
      
      private var _helpBtn:BaseButton;
      
      public function AwardsViewFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _selectedBtnGroup = new SelectedButtonGroup(false,1);
         titleText = LanguageMgr.GetTranslation("ddtCampBattle.rewardView.titleName");
         _bg = ComponentFactory.Instance.creatComponentByStylename("ddtCampBattle.AwardsViewFrame.bg");
         _awardsBtn = ComponentFactory.Instance.creatComponentByStylename("ddtCampBattle.AwardsViewFrame.awardsBtn");
         _selectedBtnGroup.addSelectItem(_awardsBtn);
         _myAwardsBtn = ComponentFactory.Instance.creatComponentByStylename("ddtCampBattle.AwardsViewFrame.myAwardsBtn");
         _selectedBtnGroup.addSelectItem(_myAwardsBtn);
         _rewardList = ComponentFactory.Instance.creatComponentByStylename("ddtCampBattle.RewardList");
         _rewardPanel = ComponentFactory.Instance.creatComponentByStylename("ddtCampBattle.AwardsViewFrame.consorPanel");
         _rewardPanel.setView(_rewardList);
         _bg1 = ComponentFactory.Instance.creatBitmap("asset.campbattle.bbgg1");
         _txt = ComponentFactory.Instance.creatComponentByStylename("ddtCampBattle.AwardsViewFrame.txtProp");
         _txt.text = LanguageMgr.GetTranslation("ddtCampBattle.AwardsViewFrame.txt").toString().split("|")[0].toString();
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("stateMap.texpSystem.btnHelp");
         addToContent(_bg);
         addToContent(_awardsBtn);
         addToContent(_myAwardsBtn);
         addToContent(_rewardPanel);
         addToContent(_bg1);
         addToContent(_txt);
         addToContent(_helpBtn);
         _selectedBtnGroup.selectIndex = 0;
         CampBattleManager.instance.goodsZone = 0;
         updateRewardList();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__responseHandler);
         _selectedBtnGroup.addEventListener("change",__typeChange);
         _helpBtn.addEventListener("click",__onHelpBtnClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _selectedBtnGroup.removeEventListener("change",__typeChange);
         _helpBtn.removeEventListener("click",__onHelpBtnClick);
      }
      
      protected function __onHelpBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var helpframe:CampBattleHelpView = ComponentFactory.Instance.creatComponentByStylename("ddtCampBattle.views.helpView");
         helpframe.addEventListener("response",frameEvent);
         LayerManager.Instance.addToLayer(helpframe,3,true,1);
      }
      
      private function frameEvent(event:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         event.currentTarget.removeEventListener("response",frameEvent);
         event.currentTarget.dispose();
      }
      
      private function __typeChange(evt:Event) : void
      {
         defaultShowThisZoneView();
      }
      
      private function defaultShowThisZoneView() : void
      {
         switch(int(_selectedBtnGroup.selectIndex))
         {
            case 0:
               CampBattleManager.instance.goodsZone = 0;
               _txt.text = LanguageMgr.GetTranslation("ddtCampBattle.AwardsViewFrame.txt").toString().split("|")[0].toString();
               updateRewardList();
               break;
            case 1:
               CampBattleManager.instance.goodsZone = 1;
               _txt.text = LanguageMgr.GetTranslation("ddtCampBattle.AwardsViewFrame.txt").toString().split("|")[1].toString();
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
         _rewardList = ComponentFactory.Instance.creatComponentByStylename("ddtCampBattle.RewardList");
         _rewardPanel = ComponentFactory.Instance.creatComponentByStylename("ddtCampBattle.AwardsViewFrame.consorPanel");
         _rewardPanel.setView(_rewardList);
         addToContent(_rewardPanel);
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_awardsBtn);
         _awardsBtn = null;
         ObjectUtils.disposeObject(_myAwardsBtn);
         _myAwardsBtn = null;
         ObjectUtils.disposeObject(_rewardList);
         _rewardList = null;
         ObjectUtils.disposeObject(_rewardPanel);
         _rewardPanel = null;
         if(_helpBtn)
         {
            _helpBtn.dispose();
         }
         _helpBtn = null;
         super.dispose();
      }
   }
}
