package oldPlayerRegress.view.itemView.task
{
   import bagAndInfo.BagAndInfoManager;
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.quest.QuestInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.CheckWeaponManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddtActivityIcon.ActivitStateEvent;
   import ddtActivityIcon.DdtActivityIconManager;
   import ddtBuried.BuriedManager;
   import fightLib.FightLibManager;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import labyrinth.LabyrinthControl;
   import oldPlayerRegress.view.RegressView;
   import petsBag.PetsBagManager;
   import quest.TaskManager;
   import road7th.comm.PackageIn;
   import room.RoomManager;
   import trainer.controller.WeakGuildManager;
   
   public class RegressTaskView extends Frame
   {
       
      
      private var _taskInfo:QuestInfo;
      
      private var _taskIdArray:Array;
      
      private var _funcArray:Array;
      
      private var _gotoFunc:Function;
      
      private var _isBattleOpen:Boolean;
      
      private var _bottomBtnBg:ScaleBitmapImage;
      
      private var _getAwardBtn:BaseButton;
      
      private var _gotoBtn:BaseButton;
      
      private var _questBtnShine:IEffect;
      
      private var _lastCreatTime:int;
      
      private var _bossState:int = 0;
      
      public function RegressTaskView()
      {
         super();
         _init();
      }
      
      private function _init() : void
      {
         initData();
         initView();
         initEvent();
      }
      
      private function initData() : void
      {
         _isBattleOpen = false;
         _funcArray = new Array(notGo,gotoHall,gotoDungeon,gotoBagAndInfo,gotoPetView,gotoLabyrinth,gotoBattle,gotoBuried,gotoConsortiria,gotoTrain);
         _taskIdArray = new Array([1519,1520,1528],[1524,1525],[1526,1527],[1521],[1523],[1517,1518],[1515],[1522],[1516],[1529,1530]);
         SocketManager.Instance.out.sendConsortiaBossInfo(1);
      }
      
      private function initView() : void
      {
         _bottomBtnBg = ComponentFactory.Instance.creatComponentByStylename("regress.bottomBgImg");
         getAwardBtn = ComponentFactory.Instance.creat("regress.getAward");
         gotoBtn = ComponentFactory.Instance.creat("regress.goto");
         gotoBtn.visible = false;
         var shineData:Object = {};
         shineData["color"] = "gold";
         _questBtnShine = EffectManager.Instance.creatEffect(3,getAwardBtn,shineData);
         _questBtnShine.stop();
         addChild(_bottomBtnBg);
         addChild(getAwardBtn);
         addChild(gotoBtn);
      }
      
      private function initEvent() : void
      {
         getAwardBtn.addEventListener("click",__onGetAwardBtnClick);
         gotoBtn.addEventListener("click",__onGotoBtnClick);
         DdtActivityIconManager.Instance.addEventListener("start",battleOpenHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(132,2),battleOverHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(129,30),consortiaBossHandler);
      }
      
      protected function __onGetAwardBtnClick(event:MouseEvent) : void
      {
         var alert:* = null;
         if(!taskInfo)
         {
            return;
         }
         SoundManager.instance.playButtonSound();
         var questInfo:QuestInfo = taskInfo;
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
      
      protected function __onGotoBtnClick(event:MouseEvent) : void
      {
         if(_gotoFunc != null)
         {
            _gotoFunc();
         }
      }
      
      private function finishQuest(pQuestInfo:QuestInfo) : void
      {
         if(pQuestInfo && !pQuestInfo.isCompleted)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.task.TaskCatalogContentView.dropTaskIII"));
            return;
         }
         if(pQuestInfo)
         {
            TaskManager.instance.sendQuestFinish(pQuestInfo.QuestID);
         }
      }
      
      private function __onResponse(pEvent:FrameEvent) : void
      {
         pEvent.currentTarget.removeEventListener("response",__onResponse);
         if(pEvent.responseCode == 3)
         {
            finishQuest(taskInfo);
         }
         ObjectUtils.disposeObject(pEvent.currentTarget);
      }
      
      private function removeEvent() : void
      {
         getAwardBtn.removeEventListener("click",__onGetAwardBtnClick);
         gotoBtn.removeEventListener("click",__onGotoBtnClick);
         SocketManager.Instance.removeEventListener(PkgEvent.format(129,30),consortiaBossHandler);
         DdtActivityIconManager.Instance.removeEventListener("start",battleOpenHandler);
         SocketManager.Instance.removeEventListener(PkgEvent.format(132,2),battleOverHandler);
      }
      
      public function show() : void
      {
         this.visible = true;
      }
      
      private function setModuleInfo() : void
      {
         _gotoFunc = _funcArray[getFuncID(taskInfo.conditions[0].questID)];
         if(taskInfo.isCompleted)
         {
            getAwardBtn.visible = true;
            getAwardBtn.enable = true;
            gotoBtn.visible = false;
            questBtnShine.play();
         }
         else if(_gotoFunc == notGo)
         {
            getAwardBtn.visible = true;
            getAwardBtn.enable = false;
            gotoBtn.visible = false;
            questBtnShine.stop();
         }
         else if(_gotoFunc == gotoBattle)
         {
            getAwardBtn.visible = false;
            gotoBtn.visible = true;
            gotoBtn.enable = _isBattleOpen;
            questBtnShine.stop();
         }
         else if(_gotoFunc == gotoConsortiria)
         {
            getAwardBtn.visible = false;
            gotoBtn.visible = true;
            gotoBtn.enable = _bossState == 1?true:false;
            questBtnShine.stop();
         }
         else
         {
            getAwardBtn.visible = false;
            gotoBtn.visible = true;
            gotoBtn.enable = true;
            questBtnShine.stop();
         }
      }
      
      private function getFuncID(taskId:int) : int
      {
         var i:int = 0;
         var id:* = 0;
         for(i = 0; i < _taskIdArray.length; )
         {
            if(_taskIdArray[i].indexOf(taskId) != -1)
            {
               id = i;
               break;
            }
            i++;
         }
         return id;
      }
      
      private function notGo() : void
      {
      }
      
      private function gotoHall() : void
      {
         if(!WeakGuildManager.Instance.checkOpen(1,2))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",2));
            return;
         }
         StateManager.setState("roomlist");
         ComponentSetting.SEND_USELOG_ID(3);
         if(PlayerManager.Instance.Self.IsWeakGuildFinish(1) && !PlayerManager.Instance.Self.IsWeakGuildFinish(4))
         {
            SocketManager.Instance.out.syncWeakStep(4);
         }
      }
      
      private function gotoDungeon() : void
      {
         if(!WeakGuildManager.Instance.checkOpen(16,8))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",8));
            return;
         }
         if(!PlayerManager.Instance.checkEnterDungeon)
         {
            return;
         }
         StateManager.setState("dungeon");
         ComponentSetting.SEND_USELOG_ID(4);
         if(PlayerManager.Instance.Self.IsWeakGuildFinish(16) && !PlayerManager.Instance.Self.IsWeakGuildFinish(67))
         {
            SocketManager.Instance.out.syncWeakStep(67);
         }
      }
      
      private function gotoBagAndInfo() : void
      {
         BagAndInfoManager.Instance.showBagAndInfo();
         (parent.parent.parent as RegressView).dispatchEvent(new FrameEvent(0));
      }
      
      private function gotoPetView() : void
      {
         PetsBagManager.instance().show();
         (parent.parent.parent as RegressView).dispatchEvent(new FrameEvent(0));
      }
      
      private function gotoLabyrinth() : void
      {
         if(!WeakGuildManager.Instance.checkOpen(76,30))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",30));
            return;
         }
         LabyrinthControl.Instance.show();
         (parent.parent.parent as RegressView).dispatchEvent(new FrameEvent(0));
      }
      
      private function battleOpenHandler(event:ActivitStateEvent) : void
      {
         var arr:Array = event.data as Array;
         var id:int = arr[0];
         if(id == 5)
         {
            _isBattleOpen = true;
            if(_gotoFunc == gotoBattle)
            {
               gotoBtn.enable = true;
            }
         }
      }
      
      private function battleOverHandler(event:PkgEvent) : void
      {
         _isBattleOpen = false;
         if(_gotoFunc == gotoBattle)
         {
            gotoBtn.enable = false;
         }
      }
      
      private function gotoBattle() : void
      {
         trace("进入试炼之地");
         SoundManager.instance.play("008");
         var limitLev:int = ServerConfigManager.instance.trialBattleLevelLimit;
         if(PlayerManager.Instance.Self.Grade < limitLev)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",limitLev));
            return;
         }
         if(getTimer() - _lastCreatTime > 1000)
         {
            _lastCreatTime = getTimer();
            GameInSocketOut.sendCreateRoom(LanguageMgr.GetTranslation("ddt.battleRoom.roomName"),120,3);
         }
         (parent.parent.parent as RegressView).dispatchEvent(new FrameEvent(0));
      }
      
      private function gotoBuried() : void
      {
         SoundManager.instance.playButtonSound();
         BuriedManager.Instance.enter();
      }
      
      private function consortiaBossHandler(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         _bossState = pkg.readByte();
         if(_gotoFunc == gotoConsortiria)
         {
            gotoBtn.enable = _bossState == 1?true:false;
         }
         SocketManager.Instance.removeEventListener(PkgEvent.format(129,30),consortiaBossHandler);
      }
      
      private function gotoConsortiria() : void
      {
         if(_bossState == 1)
         {
            if(!WeakGuildManager.Instance.checkOpen(15,7))
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",7));
               return;
            }
            StateManager.setState("consortia");
            ComponentSetting.SEND_USELOG_ID(5);
            if(PlayerManager.Instance.Self.IsWeakGuildFinish(15) && !PlayerManager.Instance.Self.IsWeakGuildFinish(65))
            {
               SocketManager.Instance.out.syncWeakStep(65);
            }
         }
      }
      
      private function gotoTrain() : void
      {
         SoundManager.instance.play("008");
         CheckWeaponManager.instance.setFunction(this,gotoTrain);
         if(CheckWeaponManager.instance.isNoWeapon())
         {
            CheckWeaponManager.instance.showAlert();
            return;
         }
         TaskManager.instance.guideId = taskInfo.MapID;
         SocketManager.Instance.out.createUserGuide(5);
         RoomManager.Instance.addEventListener("gameRoomCreate",__gameStart);
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
      
      override public function dispose() : void
      {
         var i:int = 0;
         var j:int = 0;
         super.dispose();
         removeEvent();
         _gotoFunc = null;
         if(_bottomBtnBg)
         {
            _bottomBtnBg.dispose();
            _bottomBtnBg = null;
         }
         if(getAwardBtn)
         {
            getAwardBtn.dispose();
            getAwardBtn = null;
         }
         if(gotoBtn)
         {
            gotoBtn.dispose();
            gotoBtn = null;
         }
         if(questBtnShine)
         {
            questBtnShine.dispose();
            questBtnShine = null;
         }
         if(taskInfo)
         {
            taskInfo = null;
         }
         i = 0;
         while(i < _taskIdArray.length)
         {
            _taskIdArray[i] = null;
            i++;
         }
         _taskIdArray.length = 0;
         for(j = 0; j < _funcArray.length; )
         {
            _funcArray[j] = null;
            j++;
         }
         _funcArray.length = 0;
      }
      
      public function get taskInfo() : QuestInfo
      {
         return _taskInfo;
      }
      
      public function set taskInfo(value:QuestInfo) : void
      {
         _taskInfo = value;
         if(taskInfo)
         {
            setModuleInfo();
         }
      }
      
      public function get getAwardBtn() : BaseButton
      {
         return _getAwardBtn;
      }
      
      public function set getAwardBtn(value:BaseButton) : void
      {
         _getAwardBtn = value;
      }
      
      public function get questBtnShine() : IEffect
      {
         return _questBtnShine;
      }
      
      public function set questBtnShine(value:IEffect) : void
      {
         _questBtnShine = value;
      }
      
      public function get gotoBtn() : BaseButton
      {
         return _gotoBtn;
      }
      
      public function set gotoBtn(value:BaseButton) : void
      {
         _gotoBtn = value;
      }
   }
}
