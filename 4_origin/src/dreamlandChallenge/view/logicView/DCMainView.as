package dreamlandChallenge.view.logicView
{
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.map.DungeonInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import dreamlandChallenge.DreamlandChallengeControl;
   import dreamlandChallenge.DreamlandChallengeManager;
   import dreamlandChallenge.data.DreamLandModel;
   import dreamlandChallenge.view.logicView.ranking.DCPointRankingView;
   import dreamlandChallenge.view.logicView.ranking.DCSpeedMatchRankingView;
   import dreamlandChallenge.view.mornui.DCMainViewUI;
   import flash.events.Event;
   import morn.core.handlers.Handler;
   import road7th.utils.DateUtils;
   
   public class DCMainView extends DCMainViewUI
   {
       
      
      private var _control:DreamlandChallengeControl;
      
      private var _dupView:DCDuplicateChooseView;
      
      private var _confirmFrame:BaseAlerFrame;
      
      private var _dcModel:DreamLandModel;
      
      private var _helpBtn:SimpleBitmapButton;
      
      public function DCMainView(control:DreamlandChallengeControl)
      {
         _control = control;
         _dcModel = DreamlandChallengeManager.instance.mode;
         super();
         initActionSuplusDate();
         __updateSuplusCount(null);
      }
      
      private function initActionSuplusDate() : void
      {
         var days:* = null;
         var acEndDate:Date = ServerConfigManager.instance.unrealContestEndDate;
         var suplusTime:int = acEndDate.time - TimeManager.Instance.Now().time;
         var day:int = 0;
         var min:int = 0;
         var sec:int = 0;
         if(suplusTime > 0)
         {
            days = DateUtils.dateTimeRemainArr(suplusTime / 1000);
            if(days && days.length >= 3)
            {
               day = days[0];
               min = days[1];
               sec = days[2];
            }
         }
         lbl_surplusTime.htmlText = LanguageMgr.GetTranslation("ddt.dreamLand.mainView.actionSuplusDate",day,min,sec);
         text1.text = LanguageMgr.GetTranslation("ddt.dreamLand.view.text1");
         btn_dupDesc.label = LanguageMgr.GetTranslation("ddt.dreamLand.view.text2");
         btn_storyDesc.label = LanguageMgr.GetTranslation("ddt.dreamLand.view.text3");
         btn_point.label = LanguageMgr.GetTranslation("ddt.dreamLand.view.text4");
         btn_speedMatch.label = LanguageMgr.GetTranslation("ddt.dreamLand.view.text5");
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         _dupView = new DCDuplicateChooseView(_control);
         PositionUtils.setPos(_dupView,"asset.dreamLand.dupView.pos");
         addChild(_dupView);
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"dreamland.mainView.helpBtn",null,LanguageMgr.GetTranslation("Indiana.resoult.helpDis"),"dreamLand.mainView.helpFrameTxt",482,524) as SimpleBitmapButton;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         btn_close.clickHandler = new Handler(__closeView);
         btn_point.clickHandler = new Handler(__onPointRanking);
         btn_speedMatch.clickHandler = new Handler(__onSpeedMatchRanking);
         btn_challenge.clickHandler = new Handler(__challenge);
         btn_buyCount.clickHandler = new Handler(__buyCount);
         btn_dupDesc.clickHandler = new Handler(__dupDesc);
         btn_storyDesc.clickHandler = new Handler(__storyDesc);
         if(_dcModel)
         {
            _dcModel.addEventListener("updateChallengeCount",__updateSuplusCount);
         }
         disableChallengeBtn = _control.disableChallengeBtn;
      }
      
      private function __dupDesc() : void
      {
         SoundManager.instance.playButtonSound();
         var cur:int = ServerConfigManager.instance.DreamLandId;
         if(cur == DreamlandChallengeManager.BOGUID)
         {
            HelpFrameUtils.Instance.simpleHelpFrame(LanguageMgr.GetTranslation("ddt.dreamLand.mainView.dupDescTitleTxt"),"dreamLand.mainView.dupDeschelpFrameTxt",640,480,false);
         }
         else if(cur == DreamlandChallengeManager.XIESHENID)
         {
            HelpFrameUtils.Instance.simpleHelpFrame(LanguageMgr.GetTranslation("ddt.dreamLand.mainView.dupDescTitleTxt"),"dreamLand.mainView.dupDeschelpFrameTxt1",625,480,false);
         }
      }
      
      private function __storyDesc() : void
      {
         SoundManager.instance.playButtonSound();
         var cur:int = ServerConfigManager.instance.DreamLandId;
         if(cur == DreamlandChallengeManager.BOGUID)
         {
            HelpFrameUtils.Instance.simpleHelpFrame(LanguageMgr.GetTranslation("ddt.dreamLand.mainView.storyDescTitleTxt"),"dreamLand.mainView.storyDeschelpFrameTxt",410,340,false);
         }
         else if(cur == DreamlandChallengeManager.XIESHENID)
         {
            HelpFrameUtils.Instance.simpleHelpFrame(LanguageMgr.GetTranslation("ddt.dreamLand.mainView.storyDescTitleTxt"),"dreamLand.mainView.storyDeschelpFrameTxt1",410,340,false);
         }
      }
      
      public function set disableChallengeBtn(value:Boolean) : void
      {
         var _loc2_:* = value;
         btn_challenge.disabled = _loc2_;
         btn_buyCount.disabled = _loc2_;
      }
      
      private function __updateSuplusCount(evt:Event) : void
      {
         var count:int = _dcModel.surplusCount;
         var haveCount:* = count > 0;
         updateChalengeBtnState(haveCount);
         btn_challenge.label = LanguageMgr.GetTranslation("ddt.dreamLand.suplus.challengeCount",count);
      }
      
      private function updateChalengeBtnState(haveCount:Boolean) : void
      {
         btn_buyCount.visible = !haveCount;
         btn_challenge.visible = haveCount;
      }
      
      private function __buyCount() : void
      {
         if(_control)
         {
            _control.showBuychallengeCountFrame();
         }
      }
      
      private function __onPointRanking() : void
      {
         var pointView:DCPointRankingView = new DCPointRankingView(_dcModel);
         pointView.control = _control;
         pointView.show();
      }
      
      private function __onSpeedMatchRanking() : void
      {
         var matchView:DCSpeedMatchRankingView = new DCSpeedMatchRankingView(_dcModel);
         matchView.control = _control;
         matchView.show();
      }
      
      private function __challenge() : void
      {
         SoundManager.instance.play("008");
         var info:DungeonInfo = _dupView.curSelectedDuplicateInfo;
         var difficulty:int = _dupView.curSelectedDupDifficulty;
         if(_control)
         {
            _control.startChallenge(difficulty,info);
         }
      }
      
      private function __closeView() : void
      {
         SoundManager.instance.playButtonSound();
         dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_dupView);
         _control.reset();
         if(_dcModel)
         {
            _dcModel.removeEventListener("updateChallengeCount",__updateSuplusCount);
         }
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         super.dispose();
         _dcModel = null;
         _control = null;
         _dupView = null;
      }
   }
}
