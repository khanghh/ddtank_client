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
         var shineData:Object = {};
         shineData["color"] = "gold";
         _goDungeonBtnShine = EffectManager.Instance.creatEffect(3,_goDungeonBtn,shineData);
         _goDungeonBtnShine.stop();
         _downClientShine = EffectManager.Instance.creatEffect(3,_downloadClientBtn,shineData);
         _downClientShine.play();
         _questBtnShine = EffectManager.Instance.creatEffect(3,_questBtn,shineData);
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
      
      private function switchBG(style:int) : void
      {
      }
      
      private function addQuestList() : void
      {
         var i:int = 0;
         var cateView:* = null;
         if(cateViewArr)
         {
            return;
         }
         cateViewArr = [];
         for(i = 0; i < 9; )
         {
            cateView = new QuestCateView(i,leftPanel);
            cateView.collapse();
            cateView.x = 0;
            cateView.y = 0 + 50 * i;
            cateView.addEventListener(QuestCateView.TITLECLICKED,__onTitleClicked);
            cateView.addEventListener("change",__onCateViewChange);
            cateView.addEventListener("enableChange",__onEnbleChange);
            cateViewArr.push(cateView);
            leftPanelContent.addChild(cateView);
            i++;
         }
         leftPanel.invalidateViewport();
         __onEnbleChange(null);
      }
      
      private function __onEnbleChange(evt:Event) : void
      {
         var i:int = 0;
         var cateView:* = null;
         var cates:int = 0;
         for(i = 0; i < 9 - 1; )
         {
            cateView = cateViewArr[i];
            if(cateView.visible)
            {
               cateView.y = 0 + 50 * cates;
               cates++;
               leftPanelContent.addChild(cateView);
            }
            i++;
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
      
      protected function __onTaskFinished(event:TaskEvent) : void
      {
         if(event.data.id == 367)
         {
            PetsBagManager.instance().showPetFarmGuildArrow(94,50,"farmTrainer.openBagArrowPos","asset.farmTrainer.clickHere","farmTrainer.openBagTipPos",LayerManager.Instance.getLayerByType(4),10);
         }
         if(event.data.id == 369 && StateManager.currentStateType == "main")
         {
            PetsBagManager.instance().showPetFarmGuildArrow(119,-150,"farmTrainer.openFarmArrowPos","asset.farmTrainer.grain1","farmTrainer.grainopenFarmTipPos",LayerManager.Instance.getLayerByType(4),10);
         }
         if(event.data.id == 368 && StateManager.currentStateType == "main")
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
      
      private function __updatePetFarmGuilde(e:UpdatePetFarmGuildeEvent) : void
      {
         var j:int = 0;
         var jview:* = null;
         PetsBagManager.instance().finishTask();
         var currentGuildeInfo:QuestInfo = e.data as QuestInfo;
         if(currentGuildeInfo && currentGuildeInfo.QuestID == 363)
         {
            for(j = 0; j < cateViewArr.length; )
            {
               jview = cateViewArr[j] as QuestCateView;
               jview.initData();
               var _loc7_:int = 0;
               var _loc6_:* = jview.data.list;
               for each(var taskInfo in jview.data.list)
               {
                  if(taskInfo == currentGuildeInfo)
                  {
                     jview.active();
                     jumpToQuest(currentGuildeInfo);
                     if(!PetsBagManager.instance().haveTaskOrderByID(363))
                     {
                     }
                     return;
                  }
               }
               j++;
            }
         }
      }
      
      private function __onDataChanged(e:TaskEvent) : void
      {
         var i:* = 0;
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
         i = uint(0);
         while(!(cateViewArr[i] as QuestCateView).active())
         {
            i++;
            if(i == 4)
            {
               return;
            }
         }
      }
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               TaskManager.instance.switchVisible();
         }
      }
      
      public function jumpToQuest(info:QuestInfo) : void
      {
         var s:int = 0;
         if(info.MapID > 0 || info.Condition == 64)
         {
            showOtherBtn(info);
         }
         else if(checkGotoSceneCondition(info))
         {
            _gotoAcademy.visible = false;
            _goDungeonBtn.visible = false;
            _downloadClientBtn.visible = false;
            _questBtn.visible = false;
            _buySpinelBtn.visible = false;
            _gotoGameBtn.visible = false;
            _gotoTrainBtn.visible = false;
            if(!TrusteeshipManager.instance.getTrusteeshipInfo(info.id))
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
            s = TaskManager.itemAwardSelected;
            _goDungeonBtn.visible = false;
            _goDungeonBtnShine.stop();
            _gotoAcademy.visible = false;
            _downloadClientBtn.visible = false;
            _questBtn.visible = true;
            _gotoGameBtn.visible = false;
            _gotoTrainBtn.visible = false;
            _gotoSceneBtn.visible = false;
            _buySpinelBtn.visible = existRewardId(info,11555);
            showStyle(1);
            hideGuide();
         }
         infoView.info = info;
         showQuestOverBtn(info.isCompleted);
         if(PathManager.getTrusteeshipViewEnable)
         {
            showTrusteeshipView(info);
         }
      }
      
      private function showTrusteeshipView(info:QuestInfo) : void
      {
         if(info.TrusteeshipCost >= 0)
         {
            _trusteeshipView.visible = true;
            _trusteeshipView.refreshView(info,showQuestOverBtn,_questBtn);
         }
         else
         {
            _trusteeshipView.visible = false;
            _trusteeshipView.clearSome();
         }
      }
      
      private function showQuestOverBtn(value:Boolean) : void
      {
         if(value)
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
      
      private function showOtherBtn(info:QuestInfo) : void
      {
         if(info.Condition == 64)
         {
            _gotoAcademy.visible = false;
            _downloadClientBtn.visible = false;
            _goDungeonBtn.visible = false;
            _gotoGameBtn.visible = false;
            _gotoTrainBtn.visible = false;
            _gotoSceneBtn.visible = true;
         }
         else if(info.MapID > 0)
         {
            if(info.MapID == 1)
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
            else if(info.MapID == 2)
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
            else if(info.MapID == 3)
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
            else if(info.MapID == 4)
            {
               _downloadClientBtn.visible = false;
               _gotoAcademy.visible = false;
               _goDungeonBtn.visible = false;
               _buySpinelBtn.visible = false;
               _gotoGameBtn.visible = true;
               _gotoTrainBtn.visible = false;
               _gotoSceneBtn.visible = false;
            }
            else if(info.MapID > 9 && info.MapID < 30)
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
               _goDungeonBtn.enable = !info.isCompleted;
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
            _buySpinelBtn.visible = existRewardId(info,11555);
         }
         if(WeakGuildManager.Instance.switchUserGuide && !PlayerManager.Instance.Self.IsWeakGuildFinish(950) && PlayerManager.Instance.Self.Grade < 2 && _goDungeonBtn.visible && _goDungeonBtn.enable)
         {
            showGuide();
         }
      }
      
      private function existRewardId(info:QuestInfo, itemID:int) : Boolean
      {
         var _loc5_:int = 0;
         var _loc4_:* = info.itemRewards;
         for each(var temp in info.itemRewards)
         {
            if(temp.itemID == itemID)
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
      
      private function __timer(evt:TimerEvent) : void
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
      
      private function showStyle(style:int) : void
      {
         var i:int = 0;
         if(_style == style)
         {
            return;
         }
         _style = style;
         for(i = 0; i < cateViewArr.length; )
         {
            (cateViewArr[i] as QuestCateView).taskStyle = style;
            i++;
         }
         switchBG(style);
      }
      
      private function __onCateViewChange(e:Event) : void
      {
         var i:int = 0;
         var view:* = null;
         clearVBox();
         infoView.visible = false;
         var visibleItemNumber:int = 0;
         var _currentY:int = 42;
         for(i = 0; i < cateViewArr.length; )
         {
            view = cateViewArr[i] as QuestCateView;
            if(view.visible)
            {
               visibleItemNumber++;
               view.y = _currentY;
               _currentY = _currentY + (view.contentHeight + 7);
               leftPanelContent.addChild(view);
            }
            i++;
         }
         leftPanel.setView(leftPanelContent);
         leftPanel.invalidateViewport();
         if(visibleItemNumber == 0)
         {
            TaskManager.instance.taskFrameHide();
         }
      }
      
      private function __onTitleClicked(e:Event) : void
      {
         var i:int = 0;
         var view:* = null;
         clearVBox();
         if(!parent || currentNewCateView != null)
         {
            return;
         }
         if(_currentCateView != e.target as QuestCateView)
         {
         }
         _currentCateView = e.target as QuestCateView;
         var _currentY:int = 0;
         for(i = 0; i < cateViewArr.length; )
         {
            view = cateViewArr[i] as QuestCateView;
            if(view != _currentCateView)
            {
               view.collapse();
            }
            if(view.visible)
            {
               view.y = _currentY;
               _currentY = _currentY + (view.contentHeight + 7);
               leftPanelContent.addChild(view);
            }
            i++;
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
      
      private function __onQuestBtnClicked(e:MouseEvent) : void
      {
         var time:int = 0;
         var strMd5:* = null;
         var loader:* = null;
         var url:* = null;
         var obj:* = null;
         var alert:* = null;
         if(!infoView.info)
         {
            return;
         }
         SoundManager.instance.play("008");
         var questInfo:QuestInfo = infoView.info;
         if(questInfo.id >= 2153 && questInfo.id <= 2160)
         {
            time = TimeManager.Instance.Now().getTime() / 1000;
            strMd5 = PlayerManager.Instance.Self.LoginName + "m$iux6&dn!0Q2dsf#q3o3sdxc6ml@w5L" + questInfo.id.toString();
            loader = new URLLoader();
            url = new URLRequest(PathManager.getRequest_path() + "VIP360GameReward.ashx");
            obj = new URLVariables();
            obj["username"] = PlayerManager.Instance.Self.LoginName;
            obj["questid"] = questInfo.id;
            obj["sign"] = MD5.hash(strMd5);
            obj["timestamp"] = time;
            url.data = obj;
            loader.load(url);
            return;
         }
         if(questInfo.RewardBindMoney != 0 && questInfo.RewardBindMoney + PlayerManager.Instance.Self.DDTMoney > ServerConfigManager.instance.getBindBidLimit(PlayerManager.Instance.Self.Grade,PlayerManager.Instance.Self.VIPLevel))
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.BindBid.tip"),LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"),LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText"),false,false,true,1);
            alert.addEventListener("response",__onResponse);
         }
         else
         {
            finishQuest(questInfo);
         }
      }
      
      private function finishQuest(pQuestInfo:QuestInfo) : void
      {
         var items:* = null;
         var info:* = null;
         if(pQuestInfo && !pQuestInfo.isCompleted)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.task.TaskCatalogContentView.dropTaskIII"));
            _currentCateView.active();
            return;
         }
         if(TaskManager.itemAwardSelected == -1)
         {
            items = [];
            var _loc6_:int = 0;
            var _loc5_:* = pQuestInfo.itemRewards;
            for each(var temp in pQuestInfo.itemRewards)
            {
               info = new InventoryItemInfo();
               info.TemplateID = temp.itemID;
               ItemManager.fill(info);
               info.ValidDate = temp.ValidateTime;
               info.TemplateID = temp.itemID;
               info.IsJudge = true;
               info.IsBinds = temp.isBind;
               info.AttackCompose = temp.AttackCompose;
               info.DefendCompose = temp.DefendCompose;
               info.AgilityCompose = temp.AgilityCompose;
               info.LuckCompose = temp.LuckCompose;
               info.StrengthenLevel = temp.StrengthenLevel;
               info.Count = temp.count[pQuestInfo.QuestLevel - 1];
               if(!(0 != info.NeedSex && getSexByInt(PlayerManager.Instance.Self.Sex) != info.NeedSex))
               {
                  if(temp.isOptional == 1)
                  {
                     items.push(info);
                  }
               }
            }
            TryonSystemController.Instance.show(items,chooseReward,cancelChoose);
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
      
      private function __onResponse(pEvent:FrameEvent) : void
      {
         var questInfo:* = null;
         pEvent.currentTarget.removeEventListener("response",__onResponse);
         if(pEvent.responseCode == 3)
         {
            questInfo = infoView.info;
            finishQuest(questInfo);
         }
         ObjectUtils.disposeObject(pEvent.currentTarget);
      }
      
      private function getSexByInt(Sex:Boolean) : int
      {
         if(Sex)
         {
            return 1;
         }
         return 2;
      }
      
      private function chooseReward(item:ItemTemplateInfo) : void
      {
         SocketManager.Instance.out.sendQuestFinish(infoView.info.QuestID,item.TemplateID);
         TaskManager.itemAwardSelected = -1;
         checkThreeAndPower();
      }
      
      private function cancelChoose() : void
      {
         TaskManager.itemAwardSelected = -1;
      }
      
      private function __onGoDungeonClicked(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _goDungeonBtn.enable = false;
         CheckWeaponManager.instance.setFunction(this,__onGoDungeonClicked,[event]);
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
      
      private function __gotoGame(e:MouseEvent) : void
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
      
      private function __gotoScene(event:MouseEvent) : void
      {
         var isFirst:Boolean = false;
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
               isFirst = false;
               if(PlayerManager.Instance.Self.IsWeakGuildFinish(13) && !PlayerManager.Instance.Self.IsWeakGuildFinish(61))
               {
                  SocketManager.Instance.out.syncWeakStep(61);
                  isFirst = true;
               }
               StateManager.setState("civil",isFirst);
               ComponentSetting.SEND_USELOG_ID(10);
               break;
         }
      }
      
      private function __gotoTrain(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _gotoTrainBtn.enable = false;
         CheckWeaponManager.instance.setFunction(this,__gotoTrain,[e]);
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
      
      private function __gameStart(e:CrazyTankSocketEvent) : void
      {
         var _difficulty:int = 0;
         var _infoId:int = 0;
         var _sencondType:int = 0;
         RoomManager.Instance.removeEventListener("gameRoomCreate",__gameStart);
         switch(int(TaskManager.instance.guideId) - 10)
         {
            case 0:
               _difficulty = 0;
               _infoId = 1000;
               break;
            case 1:
               _difficulty = 1;
               _infoId = 1000;
               break;
            case 2:
               _difficulty = 2;
               _infoId = 1000;
               break;
            case 3:
               _difficulty = 0;
               _infoId = 1001;
               break;
            case 4:
               _difficulty = 1;
               _infoId = 1001;
               break;
            case 5:
               _difficulty = 2;
               _infoId = 1001;
               break;
            case 6:
               _difficulty = 0;
               _infoId = 1002;
               break;
            case 7:
               _difficulty = 1;
               _infoId = 1002;
               break;
            case 8:
               _difficulty = 2;
               _infoId = 1002;
               break;
            case 9:
               _difficulty = 0;
               _infoId = 1003;
               break;
            case 10:
               _difficulty = 1;
               _infoId = 1003;
               break;
            case 11:
               _difficulty = 2;
               _infoId = 1003;
               break;
            case 12:
               _difficulty = 0;
               _infoId = 1004;
               break;
            case 13:
               _difficulty = 1;
               _infoId = 1004;
               break;
            case 14:
               _difficulty = 2;
               _infoId = 1004;
         }
         _sencondType = getSecondType(_infoId,_difficulty);
         GameInSocketOut.sendGameRoomSetUp(_infoId,5,false,"","",_sencondType,_difficulty,0,false,0);
         FightLibManager.Instance.currentInfoID = _infoId;
         FightLibManager.Instance.currentInfo.difficulty = _difficulty;
         StateManager.setState("fightLib");
      }
      
      private function updateAllDataHandler(event:Event) : void
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
      
      private function checkGotoSceneCondition(info:QuestInfo) : Boolean
      {
         if(info.Condition == 21 || info.Condition == 6 || info.Condition == 34 || info.Condition == 26 || info.Condition == 5 || info.Condition == 51 || info.Condition == 9 || info.Condition == 85 || info.Condition == 86 || info.Condition == 87 || info.Condition == 83)
         {
            return true;
         }
         return false;
      }
      
      private function updateSpiritValueHandler(event:Event) : void
      {
         if(!_trusteeshipView.visible && !PathManager.getTrusteeshipViewEnable)
         {
            return;
         }
         _trusteeshipView.refreshSpiritTxt();
      }
      
      private function getSecondType(infoId:int, difficulty:int) : int
      {
         var secondType:int = 0;
         if(infoId == 1001 || infoId == 1002 || infoId == 1003)
         {
            if(difficulty == 0)
            {
               secondType = 6;
            }
            else if(difficulty == 1)
            {
               secondType = 5;
            }
            else
            {
               secondType = 3;
            }
         }
         else if(infoId == 1004)
         {
            if(difficulty == 0)
            {
               secondType = 5;
            }
            else if(difficulty == 1)
            {
               secondType = 4;
            }
            else
            {
               secondType = 3;
            }
         }
         return secondType;
      }
      
      private function __gotoAcademy(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         AcademyManager.Instance.gotoAcademyState();
      }
      
      private function __downloadClient(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function __buySpinelClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var shopItemInfo:ShopItemInfo = ShopManager.Instance.getMoneyShopItemByTemplateID(11555);
         _quick = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
         _quick.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
         _quick.itemID = 11555;
         _quick.buyFrom = 7;
         _quick.maxLimit = 3;
         LayerManager.Instance.addToLayer(_quick,2,true,1);
      }
      
      public function gotoQuest(info:QuestInfo) : void
      {
         var j:int = 0;
         var jview:* = null;
         for(j = 0; j < cateViewArr.length; )
         {
            jview = cateViewArr[j] as QuestCateView;
            var _loc9_:int = 0;
            var _loc8_:* = jview.data.list;
            for each(var taskInfo in jview.data.list)
            {
               if(taskInfo.QuestID == info.QuestID)
               {
                  jview.active();
                  var _loc7_:int = 0;
                  var _loc6_:* = jview.itemArr;
                  for each(var item in jview.itemArr)
                  {
                     if(item.info.id == info.QuestID)
                     {
                        item.active();
                     }
                  }
                  return;
               }
            }
            j++;
         }
      }
      
      override protected function __onAddToStage(e:Event) : void
      {
         var j:int = 0;
         var jview:* = null;
         var k:int = 0;
         var view1:* = null;
         super.__onAddToStage(e);
         var cate:* = -1;
         for(j = 0; j < cateViewArr.length; )
         {
            jview = cateViewArr[j] as QuestCateView;
            jview.initData();
            j++;
         }
         for(k = 0; k < cateViewArr.length; )
         {
            view1 = cateViewArr[k] as QuestCateView;
            if(view1.questType != 4)
            {
               view1.initData();
               if(view1.data.haveCompleted)
               {
                  view1.active();
                  leftPanel.invalidateViewport();
                  return;
               }
               if(view1.length > 0 && cate < 0)
               {
                  cate = k;
                  view1.active();
               }
            }
            k++;
         }
      }
      
      override public function dispose() : void
      {
         var cateView:* = null;
         TaskControl.instance.MainFrame = null;
         hideGuide();
         removeEvent();
         _currentCateView = null;
         currentNewCateView = null;
         while(true)
         {
            cateView = cateViewArr.pop();
            if(!cateViewArr.pop())
            {
               break;
            }
            cateView.removeEventListener(QuestCateView.TITLECLICKED,__onTitleClicked);
            cateView.removeEventListener("enableChange",__onEnbleChange);
            cateView.removeEventListener("change",__onCateViewChange);
            cateView.dispose();
            cateView = null;
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
