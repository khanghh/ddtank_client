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
         var _loc1_:Object = {};
         _loc1_["color"] = "gold";
         _questBtnShine = EffectManager.Instance.creatEffect(3,getAwardBtn,_loc1_);
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
      
      protected function __onGetAwardBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         if(!taskInfo)
         {
            return;
         }
         SoundManager.instance.playButtonSound();
         var _loc3_:QuestInfo = taskInfo;
         if(_loc3_.RewardBindMoney != 0 && _loc3_.RewardBindMoney + PlayerManager.Instance.Self.DDTMoney > ServerConfigManager.instance.getBindBidLimit(PlayerManager.Instance.Self.Grade,PlayerManager.Instance.Self.VIPLevel))
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.BindBid.tip"),LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"),LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText"),false,false,true,1);
            _loc2_.addEventListener("response",__onResponse);
         }
         else
         {
            finishQuest(_loc3_);
         }
      }
      
      protected function __onGotoBtnClick(param1:MouseEvent) : void
      {
         if(_gotoFunc != null)
         {
            _gotoFunc();
         }
      }
      
      private function finishQuest(param1:QuestInfo) : void
      {
         if(param1 && !param1.isCompleted)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.task.TaskCatalogContentView.dropTaskIII"));
            return;
         }
         if(param1)
         {
            TaskManager.instance.sendQuestFinish(param1.QuestID);
         }
      }
      
      private function __onResponse(param1:FrameEvent) : void
      {
         param1.currentTarget.removeEventListener("response",__onResponse);
         if(param1.responseCode == 3)
         {
            finishQuest(taskInfo);
         }
         ObjectUtils.disposeObject(param1.currentTarget);
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
      
      private function getFuncID(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < _taskIdArray.length)
         {
            if(_taskIdArray[_loc3_].indexOf(param1) != -1)
            {
               _loc2_ = _loc3_;
               break;
            }
            _loc3_++;
         }
         return _loc2_;
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
      
      private function battleOpenHandler(param1:ActivitStateEvent) : void
      {
         var _loc3_:Array = param1.data as Array;
         var _loc2_:int = _loc3_[0];
         if(_loc2_ == 5)
         {
            _isBattleOpen = true;
            if(_gotoFunc == gotoBattle)
            {
               gotoBtn.enable = true;
            }
         }
      }
      
      private function battleOverHandler(param1:PkgEvent) : void
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
         var _loc1_:int = ServerConfigManager.instance.trialBattleLevelLimit;
         if(PlayerManager.Instance.Self.Grade < _loc1_)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",_loc1_));
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
      
      private function consortiaBossHandler(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _bossState = _loc2_.readByte();
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
      
      override public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
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
         _loc2_ = 0;
         while(_loc2_ < _taskIdArray.length)
         {
            _taskIdArray[_loc2_] = null;
            _loc2_++;
         }
         _taskIdArray.length = 0;
         _loc1_ = 0;
         while(_loc1_ < _funcArray.length)
         {
            _funcArray[_loc1_] = null;
            _loc1_++;
         }
         _funcArray.length = 0;
      }
      
      public function get taskInfo() : QuestInfo
      {
         return _taskInfo;
      }
      
      public function set taskInfo(param1:QuestInfo) : void
      {
         _taskInfo = param1;
         if(taskInfo)
         {
            setModuleInfo();
         }
      }
      
      public function get getAwardBtn() : BaseButton
      {
         return _getAwardBtn;
      }
      
      public function set getAwardBtn(param1:BaseButton) : void
      {
         _getAwardBtn = param1;
      }
      
      public function get questBtnShine() : IEffect
      {
         return _questBtnShine;
      }
      
      public function set questBtnShine(param1:IEffect) : void
      {
         _questBtnShine = param1;
      }
      
      public function get gotoBtn() : BaseButton
      {
         return _gotoBtn;
      }
      
      public function set gotoBtn(param1:BaseButton) : void
      {
         _gotoBtn = param1;
      }
   }
}
