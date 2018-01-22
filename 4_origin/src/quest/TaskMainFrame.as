package quest
{
   import academy.AcademyManager;
   import bagAndInfo.BagAndInfoManager;
   import baglocked.BaglockedManager;
   import collectionTask.CollectionTaskManager;
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.manager.NoviceDataManager;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.MD5;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyFrame;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.data.quest.QuestInfo;
   import ddt.data.quest.QuestItemReward;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.TaskEvent;
   import ddt.manager.CheckWeaponManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import ddt.view.MainToolBar;
   import fightLib.FightLibManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.utils.Timer;
   import flash.utils.setTimeout;
   import hall.tasktrack.HallTaskGuideManager;
   import hall.tasktrack.HallTaskTrackManager;
   import petsBag.PetsBagManager;
   import petsBag.event.UpdatePetFarmGuildeEvent;
   import quest.cmd.CmdThreeAndPowerPickUpAndEnable;
   import room.RoomManager;
   import roomList.RoomListEnumerate;
   import trainer.controller.NewHandGuideManager;
   import trainer.controller.WeakGuildManager;
   import trainer.view.NewHandContainer;
   import tryonSystem.TryonSystemController;
   
   public class TaskMainFrame extends Frame
   {
      
      private static const SPINEL:int = 11555;
      
      private static const TYPE_NUMBER:int = 9;
       
      
      private const CATEVIEW_X:int = 0;
      
      private const CATEVIEW_Y:int = 0;
      
      private const CATEVIEW_H:int = 50;
      
      private var cateViewArr:Array;
      
      private var infoView:QuestInfoPanelView;
      
      private var _questBtn:BaseButton;
      
      private var _goDungeonBtnShine:IEffect;
      
      private var _downClientShine:IEffect;
      
      private var _questBtnShine:IEffect;
      
      private var _buySpinelBtn:TextButton;
      
      private var _currentCateView:QuestCateView;
      
      public var currentNewCateView:QuestCateView;
      
      private var leftPanel:ScrollPanel;
      
      private var leftPanelContent:VBox;
      
      private var _trusteeshipView:TrusteeshipView;
      
      private var _leftBGStyleNormal:MovieClip;
      
      private var _rightBGStyleNormal:MovieClip;
      
      private var _rightBottomBg:ScaleBitmapImage;
      
      private var _goDungeonBtn:BaseButton;
      
      private var _downloadClientBtn:TextButton;
      
      private var _gotoAcademy:BaseButton;
      
      private var _gotoGameBtn:BaseButton;
      
      private var _gotoTrainBtn:BaseButton;
      
      private var _gotoSceneBtn:SimpleBitmapButton;
      
      private var _mcTaskTarget:MovieClip;
      
      private var _timer:Timer;
      
      private var _style:int;
      
      private var _quick:QuickBuyFrame;
      
      public function TaskMainFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get width() : Number
      {
         return _container.width;
      }
      
      override public function get height() : Number
      {
         return _container.height;
      }
      
      private function initView() : void
      {
         initStyleNormalBG();
         initStyleGuideBG();
         leftPanel = ComponentFactory.Instance.creatComponentByStylename("core.quest.questCateList");
         leftPanelContent = new VBox();
         leftPanelContent.spacing = 0;
         leftPanel.setView(leftPanelContent);
         addToContent(leftPanel);
         addQuestList();
         infoView = new QuestInfoPanelView();
         PositionUtils.setPos(infoView,"quest.infoPanelPos");
         addToContent(infoView);
         _questBtn = ComponentFactory.Instance.creat("quest.getAwardBtn");
         addToContent(_questBtn);
         _goDungeonBtn = ComponentFactory.Instance.creatComponentByStylename("core.quest.GoDungeonBtn");
         addToContent(_goDungeonBtn);
         _goDungeonBtn.visible = false;
         _gotoGameBtn = ComponentFactory.Instance.creatComponentByStylename("core.quest.goGameBtn");
         addToContent(_gotoGameBtn);
         _gotoGameBtn.visible = false;
         _gotoTrainBtn = ComponentFactory.Instance.creatComponentByStylename("core.quest.goGameBtn");
         addToContent(_gotoTrainBtn);
         _gotoTrainBtn.visible = false;
         _gotoSceneBtn = ComponentFactory.Instance.creatComponentByStylename("core.quest.goSceneBtn");
         addToContent(_gotoSceneBtn);
         _gotoSceneBtn.visible = false;
         _gotoAcademy = ComponentFactory.Instance.creatComponentByStylename("core.quest.gotoAcademyBtn");
         addToContent(_gotoAcademy);
         _gotoAcademy.visible = false;
         _downloadClientBtn = ComponentFactory.Instance.creat("core.quest.DownloadClientBtn");
         _downloadClientBtn.text = LanguageMgr.GetTranslation("tank.manager.TaskManager.DownloadClient");
         addToContent(_downloadClientBtn);
         _downloadClientBtn.visible = false;
         _buySpinelBtn = ComponentFactory.Instance.creatComponentByStylename("core.quest.buySpinelBtn");
         _buySpinelBtn.text = LanguageMgr.GetTranslation("tank.manager.TaskManager.buySpinel");
         addToContent(_buySpinelBtn);
         var _loc1_:Object = {};
         _loc1_["color"] = "gold";
         _goDungeonBtnShine = EffectManager.Instance.creatEffect(3,_goDungeonBtn,_loc1_);
         _goDungeonBtnShine.stop();
         _downClientShine = EffectManager.Instance.creatEffect(3,_downloadClientBtn,_loc1_);
         _downClientShine.play();
         _questBtnShine = EffectManager.Instance.creatEffect(3,_questBtn,_loc1_);
         _questBtnShine.stop();
         _buySpinelBtn.visible = false;
         _questBtn.enable = false;
         titleText = LanguageMgr.GetTranslation("tank.game.ToolStripView.task");
         _trusteeshipView = ComponentFactory.Instance.creatCustomObject("quest.trusteeshipView");
         if(PathManager.getTrusteeshipViewEnable)
         {
            _trusteeshipView.visible = false;
            addToContent(_trusteeshipView);
         }
         showStyle(1);
      }
      
      private function initStyleNormalBG() : void
      {
         _leftBGStyleNormal = ComponentFactory.Instance.creat("asset.core.quest.leftBGStyle1");
         PositionUtils.setPos(_leftBGStyleNormal,"quest.leftBgpos");
         _rightBGStyleNormal = ComponentFactory.Instance.creat("asset.background.mapBg");
         PositionUtils.setPos(_rightBGStyleNormal,"quest.rightBgpos");
         _rightBottomBg = ComponentFactory.Instance.creatComponentByStylename("quest.rightBottomBgImg");
         addToContent(_leftBGStyleNormal);
         addToContent(_rightBGStyleNormal);
         addToContent(_rightBottomBg);
      }
      
      private function clearVBox() : void
      {
         while(leftPanelContent.numChildren)
         {
            leftPanelContent.removeChild(leftPanelContent.getChildAt(0));
         }
      }
      
      private function initStyleGuideBG() : void
      {
      }
      
      private function switchBG(param1:int) : void
      {
      }
      
      private function addQuestList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         if(cateViewArr)
         {
            return;
         }
         cateViewArr = [];
         _loc2_ = 0;
         while(_loc2_ < 9)
         {
            _loc1_ = new QuestCateView(_loc2_,leftPanel);
            _loc1_.collapse();
            _loc1_.x = 0;
            _loc1_.y = 0 + 50 * _loc2_;
            _loc1_.addEventListener(QuestCateView.TITLECLICKED,__onTitleClicked);
            _loc1_.addEventListener("change",__onCateViewChange);
            _loc1_.addEventListener("enableChange",__onEnbleChange);
            cateViewArr.push(_loc1_);
            leftPanelContent.addChild(_loc1_);
            _loc2_++;
         }
         leftPanel.invalidateViewport();
         __onEnbleChange(null);
      }
      
      private function __onEnbleChange(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc4_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 9 - 1)
         {
            _loc2_ = cateViewArr[_loc3_];
            if(_loc2_.visible)
            {
               _loc2_.y = 0 + 50 * _loc4_;
               _loc4_++;
               leftPanelContent.addChild(_loc2_);
            }
            _loc3_++;
         }
         leftPanel.setView(leftPanelContent);
         leftPanel.invalidateViewport();
      }
      
      private function addEvent() : void
      {
         TaskManager.instance.addEventListener("changed",__onDataChanged);
         TaskManager.instance.addEventListener("finish",__onTaskFinished);
         addEventListener("response",__frameEventHandler);
         _questBtn.addEventListener("click",__onQuestBtnClicked);
         _goDungeonBtn.addEventListener("click",__onGoDungeonClicked);
         _gotoAcademy.addEventListener("click",__gotoAcademy);
         _downloadClientBtn.addEventListener("click",__downloadClient);
         _buySpinelBtn.addEventListener("click",__buySpinelClick);
         _gotoGameBtn.addEventListener("click",__gotoGame);
         _gotoTrainBtn.addEventListener("click",__gotoTrain);
         _gotoSceneBtn.addEventListener("click",__gotoScene);
         PetsBagManager.instance().addEventListener("finish",__updatePetFarmGuilde);
         TrusteeshipManager.instance.addEventListener("update_all_data",updateAllDataHandler);
         TrusteeshipManager.instance.addEventListener("update_spirit_value",updateSpiritValueHandler);
      }
      
      protected function __onTaskFinished(param1:TaskEvent) : void
      {
         if(param1.data.id == 367)
         {
            PetsBagManager.instance().showPetFarmGuildArrow(94,50,"farmTrainer.openBagArrowPos","asset.farmTrainer.clickHere","farmTrainer.openBagTipPos",LayerManager.Instance.getLayerByType(4),10);
         }
         if(param1.data.id == 369 && StateManager.currentStateType == "main")
         {
            PetsBagManager.instance().showPetFarmGuildArrow(119,-150,"farmTrainer.openFarmArrowPos","asset.farmTrainer.grain1","farmTrainer.grainopenFarmTipPos",LayerManager.Instance.getLayerByType(4),10);
         }
         if(param1.data.id == 368 && StateManager.currentStateType == "main")
         {
            PetsBagManager.instance().showPetFarmGuildArrow(120,-150,"farmTrainer.openFarmArrowPos","asset.farmTrainer.seed","farmTrainer.grainopenFarmTipPosout",LayerManager.Instance.getLayerByType(4),10);
         }
      }
      
      private function removeEvent() : void
      {
         TaskManager.instance.removeEventListener("changed",__onDataChanged);
         TaskManager.instance.removeEventListener("finish",__onTaskFinished);
         removeEventListener("response",__frameEventHandler);
         if(_questBtn)
         {
            _questBtn.removeEventListener("click",__onQuestBtnClicked);
         }
         if(_goDungeonBtn)
         {
            _goDungeonBtn.removeEventListener("click",__onGoDungeonClicked);
         }
         if(_gotoAcademy)
         {
            _gotoAcademy.removeEventListener("click",__gotoAcademy);
         }
         if(_downloadClientBtn)
         {
            _downloadClientBtn.removeEventListener("click",__downloadClient);
         }
         if(_buySpinelBtn)
         {
            _buySpinelBtn.removeEventListener("click",__buySpinelClick);
         }
         if(_gotoGameBtn)
         {
            _gotoGameBtn.removeEventListener("click",__gotoGame);
         }
         if(_gotoTrainBtn)
         {
            _gotoTrainBtn.removeEventListener("click",__gotoTrain);
         }
         if(_gotoSceneBtn)
         {
            _gotoSceneBtn.removeEventListener("click",__gotoScene);
         }
         PetsBagManager.instance().removeEventListener("finish",__updatePetFarmGuilde);
         RoomManager.Instance.removeEventListener("gameRoomCreate",__gameStart);
         TrusteeshipManager.instance.removeEventListener("update_all_data",updateAllDataHandler);
         TrusteeshipManager.instance.removeEventListener("update_spirit_value",updateSpiritValueHandler);
      }
      
      private function __updatePetFarmGuilde(param1:UpdatePetFarmGuildeEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         PetsBagManager.instance().finishTask();
         var _loc4_:QuestInfo = param1.data as QuestInfo;
         if(_loc4_ && _loc4_.QuestID == 363)
         {
            _loc3_ = 0;
            while(_loc3_ < cateViewArr.length)
            {
               _loc2_ = cateViewArr[_loc3_] as QuestCateView;
               _loc2_.initData();
               var _loc7_:int = 0;
               var _loc6_:* = _loc2_.data.list;
               for each(var _loc5_ in _loc2_.data.list)
               {
                  if(_loc5_ == _loc4_)
                  {
                     _loc2_.active();
                     jumpToQuest(_loc4_);
                     if(!PetsBagManager.instance().haveTaskOrderByID(363))
                     {
                     }
                     return;
                  }
               }
               _loc3_++;
            }
         }
      }
      
      private function __onDataChanged(param1:TaskEvent) : void
      {
         var _loc2_:* = 0;
         infoView.visible = false;
         _questBtn.enable = false;
         if(!_currentCateView || currentNewCateView != null)
         {
            return;
         }
         if(_currentCateView.active())
         {
            return;
         }
         _loc2_ = uint(0);
         while(!(cateViewArr[_loc2_] as QuestCateView).active())
         {
            _loc2_++;
            if(_loc2_ == 4)
            {
               return;
            }
         }
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               TaskManager.instance.switchVisible();
         }
      }
      
      public function jumpToQuest(param1:QuestInfo) : void
      {
         var _loc2_:int = 0;
         if(param1.MapID > 0 || param1.Condition == 64)
         {
            showOtherBtn(param1);
         }
         else if(checkGotoSceneCondition(param1))
         {
            _gotoAcademy.visible = false;
            _goDungeonBtn.visible = false;
            _downloadClientBtn.visible = false;
            _questBtn.visible = false;
            _buySpinelBtn.visible = false;
            _gotoGameBtn.visible = false;
            _gotoTrainBtn.visible = false;
            if(!TrusteeshipManager.instance.getTrusteeshipInfo(param1.id))
            {
               _gotoSceneBtn.visible = true;
            }
            else
            {
               _gotoSceneBtn.visible = false;
            }
         }
         else
         {
            _loc2_ = TaskManager.itemAwardSelected;
            _goDungeonBtn.visible = false;
            _goDungeonBtnShine.stop();
            _gotoAcademy.visible = false;
            _downloadClientBtn.visible = false;
            _questBtn.visible = true;
            _gotoGameBtn.visible = false;
            _gotoTrainBtn.visible = false;
            _gotoSceneBtn.visible = false;
            _buySpinelBtn.visible = existRewardId(param1,11555);
            showStyle(1);
            hideGuide();
         }
         infoView.info = param1;
         showQuestOverBtn(param1.isCompleted);
         if(PathManager.getTrusteeshipViewEnable)
         {
            showTrusteeshipView(param1);
         }
      }
      
      private function showTrusteeshipView(param1:QuestInfo) : void
      {
         if(param1.TrusteeshipCost >= 0)
         {
            _trusteeshipView.visible = true;
            _trusteeshipView.refreshView(param1,showQuestOverBtn,_questBtn);
         }
         else
         {
            _trusteeshipView.visible = false;
            _trusteeshipView.clearSome();
         }
      }
      
      private function showQuestOverBtn(param1:Boolean) : void
      {
         if(param1)
         {
            _questBtn.enable = true;
            _questBtn.visible = true;
            _questBtnShine.play();
            _goDungeonBtn.visible = false;
            _gotoAcademy.visible = false;
            _gotoGameBtn.visible = false;
            _gotoTrainBtn.visible = false;
            _gotoSceneBtn.visible = false;
            if(WeakGuildManager.Instance.switchUserGuide && !PlayerManager.Instance.Self.IsWeakGuildFinish(950) && TaskManager.instance.getQuestByID(318).isCompleted && !TaskManager.instance.getQuestByID(318).isAchieved)
            {
               NewHandContainer.Instance.showArrow(4,0,"trainer.getTaskRewardArrowPos","asset.trainer.txtGetReward","trainer.getTaskRewardTipPos",this);
            }
         }
         else
         {
            _questBtn.enable = false;
            _questBtnShine.stop();
         }
      }
      
      private function showOtherBtn(param1:QuestInfo) : void
      {
         if(param1.Condition == 64)
         {
            _gotoAcademy.visible = false;
            _downloadClientBtn.visible = false;
            _goDungeonBtn.visible = false;
            _gotoGameBtn.visible = false;
            _gotoTrainBtn.visible = false;
            _gotoSceneBtn.visible = true;
         }
         else if(param1.MapID > 0)
         {
            if(param1.MapID == 1)
            {
               _gotoAcademy.visible = false;
               _goDungeonBtn.visible = false;
               _downloadClientBtn.visible = false;
               _questBtn.visible = false;
               _buySpinelBtn.visible = false;
               _gotoGameBtn.visible = false;
               _gotoTrainBtn.visible = false;
               _gotoSceneBtn.visible = true;
            }
            else if(param1.MapID == 2)
            {
               _gotoAcademy.visible = true;
               _goDungeonBtn.visible = false;
               _downloadClientBtn.visible = false;
               _questBtn.visible = false;
               _buySpinelBtn.visible = false;
               _gotoGameBtn.visible = false;
               _gotoTrainBtn.visible = false;
               _gotoSceneBtn.visible = false;
            }
            else if(param1.MapID == 3)
            {
               _downloadClientBtn.visible = true;
               _questBtn.visible = true;
               _gotoAcademy.visible = false;
               _goDungeonBtn.visible = false;
               _buySpinelBtn.visible = false;
               _gotoGameBtn.visible = false;
               _gotoTrainBtn.visible = false;
               _gotoSceneBtn.visible = false;
            }
            else if(param1.MapID == 4)
            {
               _downloadClientBtn.visible = false;
               _gotoAcademy.visible = false;
               _goDungeonBtn.visible = false;
               _buySpinelBtn.visible = false;
               _gotoGameBtn.visible = true;
               _gotoTrainBtn.visible = false;
               _gotoSceneBtn.visible = false;
            }
            else if(param1.MapID > 9 && param1.MapID < 30)
            {
               _downloadClientBtn.visible = false;
               _gotoAcademy.visible = false;
               _goDungeonBtn.visible = false;
               _buySpinelBtn.visible = false;
               _gotoGameBtn.visible = false;
               _gotoTrainBtn.visible = true;
               _gotoSceneBtn.visible = false;
            }
            else
            {
               showStyle(2);
               _goDungeonBtn.visible = true;
               _goDungeonBtn.enable = !param1.isCompleted;
               if(_goDungeonBtn.enable)
               {
                  _goDungeonBtnShine.play();
                  HallTaskGuideManager.instance.showTaskFightItemArrow();
               }
               else
               {
                  _goDungeonBtnShine.stop();
               }
               _gotoAcademy.visible = false;
               _downloadClientBtn.visible = false;
               _questBtn.visible = false;
               _buySpinelBtn.visible = false;
               _gotoGameBtn.visible = false;
               _gotoTrainBtn.visible = false;
               _gotoSceneBtn.visible = false;
            }
         }
         else
         {
            _gotoAcademy.visible = false;
            _downloadClientBtn.visible = false;
            _goDungeonBtn.visible = false;
            _gotoGameBtn.visible = false;
            _gotoTrainBtn.visible = false;
            _gotoSceneBtn.visible = false;
            _buySpinelBtn.visible = existRewardId(param1,11555);
         }
         if(WeakGuildManager.Instance.switchUserGuide && !PlayerManager.Instance.Self.IsWeakGuildFinish(950) && PlayerManager.Instance.Self.Grade < 2 && _goDungeonBtn.visible && _goDungeonBtn.enable)
         {
            showGuide();
         }
      }
      
      private function existRewardId(param1:QuestInfo, param2:int) : Boolean
      {
         var _loc5_:int = 0;
         var _loc4_:* = param1.itemRewards;
         for each(var _loc3_ in param1.itemRewards)
         {
            if(_loc3_.itemID == param2)
            {
               return true;
            }
         }
         return false;
      }
      
      private function showGuide() : void
      {
         hideGuide();
         if(!_mcTaskTarget)
         {
            _mcTaskTarget = ComponentFactory.Instance.creatCustomObject("trainer.mcTaskTarget");
         }
         if(!_timer)
         {
            _timer = new Timer(4000,1);
         }
         addChild(_mcTaskTarget);
         _timer.addEventListener("timer",__timer);
         _timer.start();
      }
      
      private function __timer(param1:TimerEvent) : void
      {
         resetTimer();
         removeChild(_mcTaskTarget);
         NewHandContainer.Instance.showArrow(3,0,"trainer.clickBeatArrowPos","asset.trainer.txtClickBeat","trainer.clickBeatTipPos",this);
      }
      
      private function resetTimer() : void
      {
         if(_timer)
         {
            _timer.removeEventListener("timer",__timer);
            _timer.stop();
            _timer.reset();
         }
      }
      
      private function hideGuide() : void
      {
         if(!WeakGuildManager.Instance.switchUserGuide || PlayerManager.Instance.Self.IsWeakGuildFinish(950))
         {
            return;
         }
         NewHandContainer.Instance.clearArrowByID(3);
         resetTimer();
         if(_mcTaskTarget && _mcTaskTarget.parent)
         {
            removeChild(_mcTaskTarget);
         }
      }
      
      private function showStyle(param1:int) : void
      {
         var _loc2_:int = 0;
         if(_style == param1)
         {
            return;
         }
         _style = param1;
         _loc2_ = 0;
         while(_loc2_ < cateViewArr.length)
         {
            (cateViewArr[_loc2_] as QuestCateView).taskStyle = param1;
            _loc2_++;
         }
         switchBG(param1);
      }
      
      private function __onCateViewChange(param1:Event) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         clearVBox();
         infoView.visible = false;
         var _loc3_:int = 0;
         var _loc2_:int = 42;
         _loc5_ = 0;
         while(_loc5_ < cateViewArr.length)
         {
            _loc4_ = cateViewArr[_loc5_] as QuestCateView;
            if(_loc4_.visible)
            {
               _loc3_++;
               _loc4_.y = _loc2_;
               _loc2_ = _loc2_ + (_loc4_.contentHeight + 7);
               leftPanelContent.addChild(_loc4_);
            }
            _loc5_++;
         }
         leftPanel.setView(leftPanelContent);
         leftPanel.invalidateViewport();
         if(_loc3_ == 0)
         {
            TaskManager.instance.taskFrameHide();
         }
      }
      
      private function __onTitleClicked(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         clearVBox();
         if(!parent || currentNewCateView != null)
         {
            return;
         }
         if(_currentCateView != param1.target as QuestCateView)
         {
         }
         _currentCateView = param1.target as QuestCateView;
         var _loc2_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < cateViewArr.length)
         {
            _loc3_ = cateViewArr[_loc4_] as QuestCateView;
            if(_loc3_ != _currentCateView)
            {
               _loc3_.collapse();
            }
            if(_loc3_.visible)
            {
               _loc3_.y = _loc2_;
               _loc2_ = _loc2_ + (_loc3_.contentHeight + 7);
               leftPanelContent.addChild(_loc3_);
            }
            _loc4_++;
         }
         leftPanel.setView(leftPanelContent);
         leftPanel.invalidateViewport();
      }
      
      public function switchVisible() : void
      {
         if(parent)
         {
            dispose();
         }
         else
         {
            _show();
         }
      }
      
      private function _show() : void
      {
         MainToolBar.Instance.unReadTask = false;
         LayerManager.Instance.addToLayer(this,3,false,1);
      }
      
      public function open() : void
      {
         _show();
         if(leftPanel)
         {
            leftPanel.invalidateViewport();
         }
      }
      
      private function __onQuestBtnClicked(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc8_:* = null;
         var _loc6_:* = null;
         var _loc4_:* = null;
         if(!infoView.info)
         {
            return;
         }
         SoundManager.instance.play("008");
         var _loc7_:QuestInfo = infoView.info;
         if(_loc7_.id >= 2153 && _loc7_.id <= 2160)
         {
            _loc3_ = TimeManager.Instance.Now().getTime() / 1000;
            _loc2_ = PlayerManager.Instance.Self.LoginName + "m$iux6&dn!0Q2dsf#q3o3sdxc6ml@w5L" + _loc7_.id.toString();
            _loc5_ = new URLLoader();
            _loc8_ = new URLRequest(PathManager.getRequest_path() + "VIP360GameReward.ashx");
            _loc6_ = new URLVariables();
            _loc6_["username"] = PlayerManager.Instance.Self.LoginName;
            _loc6_["questid"] = _loc7_.id;
            _loc6_["sign"] = MD5.hash(_loc2_);
            _loc6_["timestamp"] = _loc3_;
            _loc8_.data = _loc6_;
            _loc5_.load(_loc8_);
            return;
         }
         if(_loc7_.RewardBindMoney != 0 && _loc7_.RewardBindMoney + PlayerManager.Instance.Self.DDTMoney > ServerConfigManager.instance.getBindBidLimit(PlayerManager.Instance.Self.Grade,PlayerManager.Instance.Self.VIPLevel))
         {
            _loc4_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.BindBid.tip"),LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"),LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText"),false,false,true,1);
            _loc4_.addEventListener("response",__onResponse);
         }
         else
         {
            finishQuest(_loc7_);
         }
      }
      
      private function finishQuest(param1:QuestInfo) : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         if(param1 && !param1.isCompleted)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.task.TaskCatalogContentView.dropTaskIII"));
            _currentCateView.active();
            return;
         }
         if(TaskManager.itemAwardSelected == -1)
         {
            _loc2_ = [];
            var _loc6_:int = 0;
            var _loc5_:* = param1.itemRewards;
            for each(var _loc3_ in param1.itemRewards)
            {
               _loc4_ = new InventoryItemInfo();
               _loc4_.TemplateID = _loc3_.itemID;
               ItemManager.fill(_loc4_);
               _loc4_.ValidDate = _loc3_.ValidateTime;
               _loc4_.TemplateID = _loc3_.itemID;
               _loc4_.IsJudge = true;
               _loc4_.IsBinds = _loc3_.isBind;
               _loc4_.AttackCompose = _loc3_.AttackCompose;
               _loc4_.DefendCompose = _loc3_.DefendCompose;
               _loc4_.AgilityCompose = _loc3_.AgilityCompose;
               _loc4_.LuckCompose = _loc3_.LuckCompose;
               _loc4_.StrengthenLevel = _loc3_.StrengthenLevel;
               _loc4_.Count = _loc3_.count[param1.QuestLevel - 1];
               if(!(0 != _loc4_.NeedSex && getSexByInt(PlayerManager.Instance.Self.Sex) != _loc4_.NeedSex))
               {
                  if(_loc3_.isOptional == 1)
                  {
                     _loc2_.push(_loc4_);
                  }
               }
            }
            TryonSystemController.Instance.show(_loc2_,chooseReward,cancelChoose);
            return;
         }
         if(infoView.info)
         {
            TaskManager.instance.sendQuestFinish(infoView.info.QuestID);
            if(TaskManager.instance.isAchieved(TaskManager.instance.getQuestByID(318)) && TaskManager.instance.isAchieved(TaskManager.instance.getQuestByID(319)))
            {
               SocketManager.Instance.out.syncWeakStep(49);
            }
            checkThreeAndPower();
         }
      }
      
      private function checkThreeAndPower() : void
      {
         if(infoView && infoView.info)
         {
            new CmdThreeAndPowerPickUpAndEnable().excute(infoView.info.QuestID);
         }
      }
      
      private function __onResponse(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         param1.currentTarget.removeEventListener("response",__onResponse);
         if(param1.responseCode == 3)
         {
            _loc2_ = infoView.info;
            finishQuest(_loc2_);
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function getSexByInt(param1:Boolean) : int
      {
         if(param1)
         {
            return 1;
         }
         return 2;
      }
      
      private function chooseReward(param1:ItemTemplateInfo) : void
      {
         SocketManager.Instance.out.sendQuestFinish(infoView.info.QuestID,param1.TemplateID);
         TaskManager.itemAwardSelected = -1;
         checkThreeAndPower();
      }
      
      private function cancelChoose() : void
      {
         TaskManager.itemAwardSelected = -1;
      }
      
      private function __onGoDungeonClicked(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _goDungeonBtn.enable = false;
         CheckWeaponManager.instance.setFunction(this,__onGoDungeonClicked,[param1]);
         if(CheckWeaponManager.instance.isNoWeapon())
         {
            CheckWeaponManager.instance.showAlert();
            _goDungeonBtn.enable = true;
            return;
         }
         if(infoView.info.MapID > 0)
         {
            NewHandGuideManager.Instance.mapID = infoView.info.MapID;
            if(StateManager.currentStateType == "matchRoom" || StateManager.currentStateType == "challengeRoom")
            {
               StateManager.setState("roomlist");
            }
            setTimeout(SocketManager.Instance.out.createUserGuide,500);
            if(infoView.info.MapID == 111 || infoView.info.MapID == 112)
            {
               NoviceDataManager.instance.saveNoviceData(350,PathManager.userName(),PathManager.solveRequestPath());
            }
            else if(infoView.info.MapID == 113)
            {
               NoviceDataManager.instance.saveNoviceData(460,PathManager.userName(),PathManager.solveRequestPath());
            }
            else if(infoView.info.MapID == 114)
            {
               NoviceDataManager.instance.saveNoviceData(510,PathManager.userName(),PathManager.solveRequestPath());
            }
            else if(infoView.info.MapID == 115)
            {
               NoviceDataManager.instance.saveNoviceData(540,PathManager.userName(),PathManager.solveRequestPath());
            }
            else if(infoView.info.MapID == 116)
            {
               NoviceDataManager.instance.saveNoviceData(670,PathManager.userName(),PathManager.solveRequestPath());
            }
         }
      }
      
      private function __gotoGame(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _gotoGameBtn.enable = false;
         StateManager.setState("roomlist");
         setTimeout(GameInSocketOut.sendCreateRoom,1000,RoomListEnumerate.PREWORD[int(Math.random() * RoomListEnumerate.PREWORD.length)],0,3);
         if(PetsBagManager.instance().haveTaskOrderByID(363))
         {
            PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(99);
         }
      }
      
      private function __gotoScene(param1:MouseEvent) : void
      {
         var _loc2_:Boolean = false;
         SoundManager.instance.play("008");
         _gotoSceneBtn.enable = false;
         switch(int(infoView.info.ConditionTurn) - 1)
         {
            case 0:
               (HallTaskTrackManager.instance.btnList[HallTaskTrackManager.instance.btnIndexMap["store"]] as BaseButton).dispatchEvent(new MouseEvent("click"));
               TaskManager.instance.taskFrameHide();
               break;
            case 1:
               break;
            case 2:
               break;
            case 3:
               if(StateManager.currentStateType != "main")
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("lanternRiddles.view.openTips"));
                  return;
               }
               (HallTaskTrackManager.instance.btnList[HallTaskTrackManager.instance.btnIndexMap["dungeon"]] as BaseButton).dispatchEvent(new MouseEvent("click"));
               TaskManager.instance.taskFrameHide();
               break;
            case 4:
               if(StateManager.currentStateType != "main")
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("lanternRiddles.view.openTips"));
                  return;
               }
               (HallTaskTrackManager.instance.btnList[HallTaskTrackManager.instance.btnIndexMap["roomList"]] as BaseButton).dispatchEvent(new MouseEvent("click"));
               TaskManager.instance.taskFrameHide();
               break;
            case 5:
               break;
            case 6:
               break;
            case 7:
               break;
            case 8:
               break;
            case 9:
               (HallTaskTrackManager.instance.btnList[HallTaskTrackManager.instance.btnIndexMap["home"]] as BaseButton).dispatchEvent(new MouseEvent("click"));
               TaskManager.instance.taskFrameHide();
               break;
            case 10:
               (HallTaskTrackManager.instance.btnList[HallTaskTrackManager.instance.btnIndexMap["cryptBoss"]] as BaseButton).dispatchEvent(new MouseEvent("click"));
               TaskManager.instance.taskFrameHide();
               break;
            case 11:
               NoviceDataManager.instance.saveNoviceData(820,PathManager.userName(),PathManager.solveRequestPath());
               CollectionTaskManager.Instance.setUp();
               break;
            default:
               NoviceDataManager.instance.saveNoviceData(820,PathManager.userName(),PathManager.solveRequestPath());
               CollectionTaskManager.Instance.setUp();
               break;
            default:
               NoviceDataManager.instance.saveNoviceData(820,PathManager.userName(),PathManager.solveRequestPath());
               CollectionTaskManager.Instance.setUp();
               break;
            default:
               NoviceDataManager.instance.saveNoviceData(820,PathManager.userName(),PathManager.solveRequestPath());
               CollectionTaskManager.Instance.setUp();
               break;
            default:
               NoviceDataManager.instance.saveNoviceData(820,PathManager.userName(),PathManager.solveRequestPath());
               CollectionTaskManager.Instance.setUp();
               break;
            case 16:
               ObjectUtils.disposeObject(this);
               BagAndInfoManager.Instance.showBagAndInfo(2);
               break;
            case 17:
               if(PlayerManager.Instance.Self.Grade < 11)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",11));
                  return;
               }
               _loc2_ = false;
               if(PlayerManager.Instance.Self.IsWeakGuildFinish(13) && !PlayerManager.Instance.Self.IsWeakGuildFinish(61))
               {
                  SocketManager.Instance.out.syncWeakStep(61);
                  _loc2_ = true;
               }
               StateManager.setState("civil",_loc2_);
               ComponentSetting.SEND_USELOG_ID(10);
               break;
         }
      }
      
      private function __gotoTrain(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _gotoTrainBtn.enable = false;
         CheckWeaponManager.instance.setFunction(this,__gotoTrain,[param1]);
         if(CheckWeaponManager.instance.isNoWeapon())
         {
            CheckWeaponManager.instance.showAlert();
            return;
         }
         TaskManager.instance.guideId = infoView.info.MapID;
         if(StateManager.currentStateType == "matchRoom" || StateManager.currentStateType == "dungeonRoom")
         {
            StateManager.setState("roomlist");
         }
         setTimeout(__createUserGude,500);
         RoomManager.Instance.addEventListener("gameRoomCreate",__gameStart);
      }
      
      private function __createUserGude() : void
      {
         SocketManager.Instance.out.createUserGuide(5);
      }
      
      private function __gameStart(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         RoomManager.Instance.removeEventListener("gameRoomCreate",__gameStart);
         switch(int(TaskManager.instance.guideId) - 10)
         {
            case 0:
               _loc2_ = 0;
               _loc4_ = 1000;
               break;
            case 1:
               _loc2_ = 1;
               _loc4_ = 1000;
               break;
            case 2:
               _loc2_ = 2;
               _loc4_ = 1000;
               break;
            case 3:
               _loc2_ = 0;
               _loc4_ = 1001;
               break;
            case 4:
               _loc2_ = 1;
               _loc4_ = 1001;
               break;
            case 5:
               _loc2_ = 2;
               _loc4_ = 1001;
               break;
            case 6:
               _loc2_ = 0;
               _loc4_ = 1002;
               break;
            case 7:
               _loc2_ = 1;
               _loc4_ = 1002;
               break;
            case 8:
               _loc2_ = 2;
               _loc4_ = 1002;
               break;
            case 9:
               _loc2_ = 0;
               _loc4_ = 1003;
               break;
            case 10:
               _loc2_ = 1;
               _loc4_ = 1003;
               break;
            case 11:
               _loc2_ = 2;
               _loc4_ = 1003;
               break;
            case 12:
               _loc2_ = 0;
               _loc4_ = 1004;
               break;
            case 13:
               _loc2_ = 1;
               _loc4_ = 1004;
               break;
            case 14:
               _loc2_ = 2;
               _loc4_ = 1004;
         }
         _loc3_ = getSecondType(_loc4_,_loc2_);
         GameInSocketOut.sendGameRoomSetUp(_loc4_,5,false,"","",_loc3_,_loc2_,0,false,0);
         FightLibManager.Instance.currentInfoID = _loc4_;
         FightLibManager.Instance.currentInfo.difficulty = _loc2_;
         StateManager.setState("fightLib");
      }
      
      private function updateAllDataHandler(param1:Event) : void
      {
         if(!_trusteeshipView.visible && !PathManager.getTrusteeshipViewEnable)
         {
            return;
         }
         _trusteeshipView.refreshSpiritTxt();
         _trusteeshipView.refreshView(infoView.info,showQuestOverBtn,_questBtn);
         if(!TrusteeshipManager.instance.getTrusteeshipInfo(infoView.info.id))
         {
            if(checkGotoSceneCondition(infoView.info))
            {
               _gotoSceneBtn.visible = true;
            }
         }
         else
         {
            _gotoSceneBtn.visible = false;
         }
      }
      
      private function checkGotoSceneCondition(param1:QuestInfo) : Boolean
      {
         if(param1.Condition == 21 || param1.Condition == 6 || param1.Condition == 34 || param1.Condition == 26 || param1.Condition == 5 || param1.Condition == 51 || param1.Condition == 9 || param1.Condition == 85 || param1.Condition == 86 || param1.Condition == 87 || param1.Condition == 83)
         {
            return true;
         }
         return false;
      }
      
      private function updateSpiritValueHandler(param1:Event) : void
      {
         if(!_trusteeshipView.visible && !PathManager.getTrusteeshipViewEnable)
         {
            return;
         }
         _trusteeshipView.refreshSpiritTxt();
      }
      
      private function getSecondType(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         if(param1 == 1001 || param1 == 1002 || param1 == 1003)
         {
            if(param2 == 0)
            {
               _loc3_ = 6;
            }
            else if(param2 == 1)
            {
               _loc3_ = 5;
            }
            else
            {
               _loc3_ = 3;
            }
         }
         else if(param1 == 1004)
         {
            if(param2 == 0)
            {
               _loc3_ = 5;
            }
            else if(param2 == 1)
            {
               _loc3_ = 4;
            }
            else
            {
               _loc3_ = 3;
            }
         }
         return _loc3_;
      }
      
      private function __gotoAcademy(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         AcademyManager.Instance.gotoAcademyState();
      }
      
      private function __downloadClient(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function __buySpinelClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:ShopItemInfo = ShopManager.Instance.getMoneyShopItemByTemplateID(11555);
         _quick = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
         _quick.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
         _quick.itemID = 11555;
         _quick.buyFrom = 7;
         _quick.maxLimit = 3;
         LayerManager.Instance.addToLayer(_quick,2,true,1);
      }
      
      public function gotoQuest(param1:QuestInfo) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         _loc4_ = 0;
         while(_loc4_ < cateViewArr.length)
         {
            _loc3_ = cateViewArr[_loc4_] as QuestCateView;
            var _loc9_:int = 0;
            var _loc8_:* = _loc3_.data.list;
            for each(var _loc5_ in _loc3_.data.list)
            {
               if(_loc5_.QuestID == param1.QuestID)
               {
                  _loc3_.active();
                  var _loc7_:int = 0;
                  var _loc6_:* = _loc3_.itemArr;
                  for each(var _loc2_ in _loc3_.itemArr)
                  {
                     if(_loc2_.info.id == param1.QuestID)
                     {
                        _loc2_.active();
                     }
                  }
                  return;
               }
            }
            _loc4_++;
         }
      }
      
      override protected function __onAddToStage(param1:Event) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc2_:* = null;
         super.__onAddToStage(param1);
         var _loc3_:* = -1;
         _loc5_ = 0;
         while(_loc5_ < cateViewArr.length)
         {
            _loc4_ = cateViewArr[_loc5_] as QuestCateView;
            _loc4_.initData();
            _loc5_++;
         }
         _loc6_ = 0;
         while(_loc6_ < cateViewArr.length)
         {
            _loc2_ = cateViewArr[_loc6_] as QuestCateView;
            if(_loc2_.questType != 4)
            {
               _loc2_.initData();
               if(_loc2_.data.haveCompleted)
               {
                  _loc2_.active();
                  leftPanel.invalidateViewport();
                  return;
               }
               if(_loc2_.length > 0 && _loc3_ < 0)
               {
                  _loc3_ = _loc6_;
                  _loc2_.active();
               }
            }
            _loc6_++;
         }
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = null;
         TaskControl.instance.MainFrame = null;
         hideGuide();
         removeEvent();
         _currentCateView = null;
         currentNewCateView = null;
         while(true)
         {
            _loc1_ = cateViewArr.pop();
            if(!cateViewArr.pop())
            {
               break;
            }
            _loc1_.removeEventListener(QuestCateView.TITLECLICKED,__onTitleClicked);
            _loc1_.removeEventListener("enableChange",__onEnbleChange);
            _loc1_.removeEventListener("change",__onCateViewChange);
            _loc1_.dispose();
            _loc1_ = null;
         }
         ObjectUtils.disposeObject(leftPanelContent);
         leftPanelContent = null;
         ObjectUtils.disposeObject(leftPanel);
         leftPanel = null;
         if(_quick && _quick.canDispose)
         {
            _quick.dispose();
         }
         _quick = null;
         if(infoView)
         {
            infoView.dispose();
         }
         infoView = null;
         if(_questBtn)
         {
            ObjectUtils.disposeObject(_questBtn);
         }
         _questBtn = null;
         if(_goDungeonBtnShine)
         {
            ObjectUtils.disposeObject(_goDungeonBtnShine);
         }
         _goDungeonBtnShine = null;
         if(_downClientShine)
         {
            ObjectUtils.disposeObject(_downClientShine);
         }
         _downClientShine = null;
         if(_questBtnShine)
         {
            ObjectUtils.disposeObject(_questBtnShine);
         }
         _questBtnShine = null;
         if(_mcTaskTarget)
         {
            ObjectUtils.disposeObject(_mcTaskTarget);
         }
         _mcTaskTarget = null;
         if(_rightBottomBg)
         {
            ObjectUtils.disposeObject(_rightBottomBg);
         }
         _rightBottomBg = null;
         if(_leftBGStyleNormal)
         {
            ObjectUtils.disposeObject(_leftBGStyleNormal);
         }
         _leftBGStyleNormal = null;
         if(_rightBGStyleNormal)
         {
            ObjectUtils.disposeObject(_rightBGStyleNormal);
         }
         _rightBGStyleNormal = null;
         if(_goDungeonBtn)
         {
            ObjectUtils.disposeObject(_goDungeonBtn);
         }
         _goDungeonBtn = null;
         if(_downloadClientBtn)
         {
            ObjectUtils.disposeObject(_downloadClientBtn);
         }
         _downloadClientBtn = null;
         if(_gotoAcademy)
         {
            ObjectUtils.disposeObject(_gotoAcademy);
         }
         _gotoAcademy = null;
         if(_gotoTrainBtn)
         {
            ObjectUtils.disposeObject(_gotoTrainBtn);
         }
         _gotoTrainBtn = null;
         if(_gotoSceneBtn)
         {
            ObjectUtils.disposeObject(_gotoSceneBtn);
         }
         _gotoSceneBtn = null;
         if(_gotoGameBtn)
         {
            ObjectUtils.disposeObject(_gotoGameBtn);
            _gotoGameBtn = null;
         }
         if(PathManager.getTrusteeshipViewEnable)
         {
            ObjectUtils.disposeObject(_trusteeshipView);
            _trusteeshipView = null;
         }
         _timer = null;
         TaskManager.instance.selectedQuest = null;
         TaskManager.instance.isShow = false;
         TaskManager.instance.clearNewQuest();
         NewHandContainer.Instance.clearArrowByID(4);
         HallTaskGuideManager.instance.clearTaskFightItemArrow();
         PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(99);
         MainToolBar.Instance.tipTask();
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
