package ddt.manager
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.QueueLoader;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.manager.WaitTimeAlertManager;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import consortion.ConsortionModelManager;
   import ddt.DDT;
   import ddt.data.ServerInfo;
   import ddt.data.analyze.ServerListAnalyzer;
   import ddt.data.player.SelfInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.DuowanInterfaceEvent;
   import ddt.events.PkgEvent;
   import ddt.loader.StartupResourceLoader;
   import ddt.view.DailyButtunBar;
   import ddt.view.MainToolBar;
   import email.MailManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Timer;
   import flash.utils.setTimeout;
   import hall.player.HallPlayerView;
   import horseRace.controller.HorseRaceManager;
   import pet.sprite.PetSpriteManager;
   import quest.TaskManager;
   import road7th.comm.PackageIn;
   import sevenday.SevendayManager;
   import trainer.controller.SystemOpenPromptManager;
   
   [Event(name="change",type="flash.events.Event")]
   public class ServerManager extends EventDispatcher
   {
      
      public static const CHANGE_SERVER:String = "changeServer";
      
      public static var AUTO_UNLOCK:Boolean = false;
      
      private static const CONNENT_TIME_OUT:int = 30000;
      
      private static var _instance:ServerManager;
       
      
      private var _list:Vector.<ServerInfo>;
      
      private var _current:ServerInfo;
      
      private var _zoneName:String;
      
      private var _agentid:int;
      
      public var refreshFlag:Boolean = false;
      
      private var _connentTimer:Timer;
      
      private var _loaderQueue:QueueLoader;
      
      private var _requestCompleted:int;
      
      public function ServerManager()
      {
         super();
         SocketManager.Instance.addEventListener(PkgEvent.format(1),__onLoginComplete);
         SocketManager.Instance.addEventListener(PkgEvent.format(376),__onLoginLastServer);
         SocketManager.Instance.addEventListener(PkgEvent.format(356),__onLoginCountHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(359),__onConfigHandler);
      }
      
      public static function get Instance() : ServerManager
      {
         if(_instance == null)
         {
            _instance = new ServerManager();
         }
         return _instance;
      }
      
      public function get zoneName() : String
      {
         return _zoneName;
      }
      
      public function set zoneName(param1:String) : void
      {
         _zoneName = param1;
         dispatchEvent(new Event("change"));
      }
      
      public function get AgentID() : int
      {
         return _agentid;
      }
      
      public function set AgentID(param1:int) : void
      {
         _agentid = param1;
      }
      
      public function set current(param1:ServerInfo) : void
      {
         _current = param1;
      }
      
      public function get current() : ServerInfo
      {
         return _current;
      }
      
      public function get list() : Vector.<ServerInfo>
      {
         return _list;
      }
      
      public function set list(param1:Vector.<ServerInfo>) : void
      {
         _list = param1;
         dispatchEvent(new Event("change"));
      }
      
      public function setup(param1:ServerListAnalyzer) : void
      {
         _list = param1.list;
         _agentid = param1.agentId;
         _zoneName = param1.zoneName;
      }
      
      public function canAutoLogin() : Boolean
      {
         searchAvailableServer();
         return _current != null;
      }
      
      public function connentCurrentServer() : void
      {
         SocketManager.Instance.isLogin = false;
         SocketManager.Instance.connect(_current.IP,_current.Port);
      }
      
      private function searchAvailableServer() : void
      {
         var _loc1_:SelfInfo = PlayerManager.Instance.Self;
         if(DDT.SERVER_ID != -1)
         {
            _current = getServerInfoByID(DDT.SERVER_ID);
            return;
         }
         if(_loc1_.LastServerId != -1)
         {
            _current = getServerInfoByID(_loc1_.LastServerId);
            return;
         }
         _current = searchServerByState(2);
         if(_current == null)
         {
            _current = searchServerByState(4);
         }
         if(_current == null)
         {
            _current = _list[0];
         }
      }
      
      public function getServerInfoByID(param1:int) : ServerInfo
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _list.length)
         {
            if(_list[_loc2_].ID == param1)
            {
               return _list[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      private function searchServerByState(param1:int) : ServerInfo
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _list.length)
         {
            if(_list[_loc2_].State == param1)
            {
               return _list[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function connentServer(param1:ServerInfo) : Boolean
      {
         var _loc2_:* = null;
         if(param1 == null)
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.serverlist.ServerListPosView.choose"));
            alertControl(_loc2_);
            return false;
         }
         if(param1.MustLevel < PlayerManager.Instance.Self.Grade)
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.serverlist.ServerListPosView.your"));
            alertControl(_loc2_);
            return false;
         }
         if(param1.LowestLevel > PlayerManager.Instance.Self.Grade)
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.serverlist.ServerListPosView.low"));
            alertControl(_loc2_);
            return false;
         }
         if(param1.State == 5)
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.serverlist.ServerListPosView.full"));
            alertControl(_loc2_);
            return false;
         }
         if(param1.State == 1)
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.serverlist.ServerListPosView.maintenance"));
            alertControl(_loc2_);
            return false;
         }
         _current = param1;
         SocketManager.Instance.isChangeChannel = true;
         connentCurrentServer();
         dispatchEvent(new Event("changeServer"));
         return true;
      }
      
      private function alertControl(param1:BaseAlerFrame) : void
      {
         param1.addEventListener("response",__alertResponse);
      }
      
      private function __alertResponse(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__alertResponse);
         _loc2_.dispose();
      }
      
      private function __onLoginLastServer(param1:PkgEvent) : void
      {
         var _loc3_:int = param1.pkg.readInt();
         var _loc2_:int = param1.pkg.readInt();
         if(_loc3_ == PlayerManager.Instance.Self.ID && _loc2_ != -1)
         {
            PlayerManager.Instance.Self.LastServerId = _loc2_;
            connentServer(getServerInfoByID(_loc2_));
         }
      }
      
      private function __onLoginComplete(param1:PkgEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc8_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc4_:* = null;
         var _loc5_:PackageIn = param1.pkg;
         var _loc6_:SelfInfo = PlayerManager.Instance.Self;
         if(_loc5_.readByte() == 0)
         {
            CacheSysManager.getInstance().singleRelease("alertInNewversionguidetip");
            CacheSysManager.lock("alertInNewversionguidetip");
            _loc6_.beginChanges();
            SocketManager.Instance.isLogin = true;
            _loc6_.ZoneID = _loc5_.readInt();
            _loc6_.Attack = _loc5_.readInt();
            _loc6_.Defence = _loc5_.readInt();
            _loc6_.Agility = _loc5_.readInt();
            _loc6_.Luck = _loc5_.readInt();
            _loc6_.GP = _loc5_.readInt();
            _loc6_.Repute = _loc5_.readInt();
            _loc6_.Gold = _loc5_.readInt();
            _loc6_.Money = _loc5_.readInt();
            _loc6_.DDTMoney = _loc5_.readInt();
            _loc6_.BandMoney = _loc5_.readInt();
            _loc6_.Score = _loc5_.readInt();
            _loc6_.Hide = _loc5_.readInt();
            _loc6_.FightPower = _loc5_.readInt();
            _loc6_.apprenticeshipState = _loc5_.readInt();
            _loc6_.masterID = _loc5_.readInt();
            _loc6_.setMasterOrApprentices(_loc5_.readUTF());
            _loc6_.graduatesCount = _loc5_.readInt();
            _loc6_.honourOfMaster = _loc5_.readUTF();
            _loc6_.freezesDate = _loc5_.readDate();
            _loc6_.typeVIP = _loc5_.readByte();
            _loc6_.VIPLevel = _loc5_.readInt();
            _loc6_.VIPExp = _loc5_.readInt();
            _loc6_.VIPExpireDay = _loc5_.readDate();
            _loc6_.LastDate = _loc5_.readDate();
            _loc6_.VIPNextLevelDaysNeeded = _loc5_.readInt();
            _loc6_.systemDate = _loc5_.readDate();
            _loc6_.canTakeVipReward = _loc5_.readBoolean();
            _loc6_.OptionOnOff = _loc5_.readInt();
            _loc6_.AchievementPoint = _loc5_.readInt();
            _loc6_.honor = _loc5_.readUTF();
            _loc6_.honorId = _loc5_.readInt();
            TimeManager.Instance.totalGameTime = _loc5_.readInt();
            _loc6_.Sex = _loc5_.readBoolean();
            _loc3_ = _loc5_.readUTF();
            _loc2_ = _loc3_.split("&");
            _loc6_.Style = _loc2_[0];
            _loc6_.Colors = _loc2_[1];
            _loc6_.Skin = _loc5_.readUTF();
            _loc6_.ConsortiaID = _loc5_.readInt();
            _loc6_.ConsortiaName = _loc5_.readUTF();
            _loc6_.badgeID = _loc5_.readInt();
            _loc6_.DutyLevel = _loc5_.readInt();
            _loc6_.DutyName = _loc5_.readUTF();
            _loc6_.Right = _loc5_.readInt();
            _loc6_.consortiaInfo.ChairmanName = _loc5_.readUTF();
            _loc6_.consortiaInfo.Honor = _loc5_.readInt();
            _loc6_.consortiaInfo.Riches = _loc5_.readInt();
            _loc8_ = _loc5_.readBoolean();
            _loc7_ = _loc6_.bagPwdState && !_loc6_.bagLocked;
            _loc6_.bagPwdState = _loc8_;
            if(_loc7_)
            {
               setTimeout(releaseLock,1000);
            }
            _loc6_.bagLocked = _loc8_;
            _loc6_.questionOne = _loc5_.readUTF();
            _loc6_.questionTwo = _loc5_.readUTF();
            _loc6_.leftTimes = _loc5_.readInt();
            _loc6_.LoginName = _loc5_.readUTF();
            _loc6_.Nimbus = _loc5_.readInt();
            TaskManager.instance.requestCanAcceptTask();
            _loc6_.PvePermission = _loc5_.readUTF();
            _loc6_.fightLibMission = _loc5_.readUTF();
            _loc6_.userGuildProgress = _loc5_.readInt();
            _loc6_.LastSpaDate = _loc5_.readDate();
            _loc6_.shopFinallyGottenTime = _loc5_.readDate();
            _loc6_.UseOffer = _loc5_.readInt();
            _loc6_.matchInfo.dailyScore = _loc5_.readInt();
            _loc6_.matchInfo.dailyWinCount = _loc5_.readInt();
            _loc6_.matchInfo.dailyGameCount = _loc5_.readInt();
            _loc6_.DailyLeagueFirst = _loc5_.readBoolean();
            _loc6_.DailyLeagueLastScore = _loc5_.readInt();
            _loc6_.matchInfo.weeklyScore = _loc5_.readInt();
            _loc6_.matchInfo.weeklyGameCount = _loc5_.readInt();
            _loc6_.matchInfo.weeklyRanking = _loc5_.readInt();
            _loc6_.spdTexpExp = _loc5_.readInt();
            _loc6_.attTexpExp = _loc5_.readInt();
            _loc6_.defTexpExp = _loc5_.readInt();
            _loc6_.hpTexpExp = _loc5_.readInt();
            _loc6_.lukTexpExp = _loc5_.readInt();
            _loc6_.magicAtkTexpExp = _loc5_.readInt();
            _loc6_.magicDefTexpExp = _loc5_.readInt();
            _loc6_.texpTaskCount = _loc5_.readInt();
            _loc6_.texpCount = _loc5_.readInt();
            _loc6_.magicTexpCount = _loc5_.readInt();
            _loc6_.texpTaskDate = _loc5_.readDate();
            _loc6_.isOldPlayerHasValidEquitAtLogin = _loc5_.readBoolean();
            _loc6_.badLuckNumber = _loc5_.readInt();
            _loc6_.luckyNum = _loc5_.readInt();
            _loc6_.lastLuckyNumDate = _loc5_.readDate();
            _loc6_.lastLuckNum = _loc5_.readInt();
            _loc6_.isOld = _loc5_.readBoolean();
            _loc6_.isOld2 = _loc5_.readBoolean();
            _loc6_.CardSoul = _loc5_.readInt();
            _loc6_.GetSoulCount = _loc5_.readInt();
            _loc6_.uesedFinishTime = _loc5_.readInt();
            _loc6_.totemId = _loc5_.readInt();
            _loc6_.necklaceExp = _loc5_.readInt();
            _loc6_.accumulativeLoginDays = _loc5_.readInt();
            _loc6_.accumulativeAwardDays = _loc5_.readInt();
            _loc5_.readInt();
            _loc5_.readInt();
            _loc5_.readInt();
            _loc6_.isFirstDivorce = _loc5_.readInt();
            _loc6_.PveEpicPermission = _loc5_.readUTF();
            _loc6_.MountsType = _loc5_.readInt();
            _loc6_.PetsID = _loc5_.readInt();
            HorseRaceManager.Instance.horseRaceCanRaceTime = _loc5_.readInt();
            _loc6_.isAttest = _loc5_.readBoolean();
            _loc6_.ImagePath = _loc5_.readUTF();
            _loc6_.SubID = _loc5_.readInt();
            _loc6_.SubName = _loc5_.readUTF();
            _loc6_.IsShow = _loc5_.readBoolean();
            _loc5_.readBoolean();
            _loc6_.createPlayerDate = _loc5_.readDate();
            _loc6_.commitChanges();
            _loc6_.vipDiscount = _loc5_.readInt();
            _loc6_.vipDiscountValidity = _loc5_.readDate();
            _loc6_.stive = _loc5_.readInt();
            _loc6_.manualProInfo.manual_Level = _loc5_.readInt();
            _loc6_.manualProInfo.pro_Agile = _loc5_.readInt();
            _loc6_.manualProInfo.pro_Armor = _loc5_.readInt();
            _loc6_.manualProInfo.pro_Attack = _loc5_.readInt();
            _loc6_.manualProInfo.pro_Damage = _loc5_.readInt();
            _loc6_.manualProInfo.pro_Defense = _loc5_.readInt();
            _loc6_.manualProInfo.pro_HP = _loc5_.readInt();
            _loc6_.manualProInfo.pro_Lucky = _loc5_.readInt();
            _loc6_.manualProInfo.pro_MagicAttack = _loc5_.readInt();
            _loc6_.manualProInfo.pro_MagicResistance = _loc5_.readInt();
            _loc6_.manualProInfo.pro_Stamina = _loc5_.readInt();
            _loc6_.teamID = _loc5_.readInt();
            _loc6_.teamName = _loc5_.readUTF();
            _loc6_.teamTag = _loc5_.readUTF();
            _loc6_.teamGrade = _loc5_.readInt();
            _loc6_.teamWinTime = _loc5_.readInt();
            _loc6_.teamTotalTime = _loc5_.readInt();
            _loc6_.teamDivision = _loc5_.readInt();
            _loc6_.teamScore = _loc5_.readInt();
            _loc6_.teamDuty = _loc5_.readInt();
            _loc6_.teamPersonalScore = _loc5_.readInt();
            _loc6_.freeInvitedUsedCnt = _loc5_.readInt();
            _loc6_.commitChanges();
            MapManager.buildMap();
            PlayerManager.Instance.Self.loadRelatedPlayersInfo();
            DailyButtunBar.Insance.hideFlag = true;
            MainToolBar.Instance.signEffectEnable = true;
            StateManager.setState("main");
            ExternalInterfaceManager.sendTo360Agent(4);
            if(!StartupResourceLoader.firstEnterHall)
            {
               StartupResourceLoader.Instance.startLoadRelatedInfo();
               SocketManager.Instance.out.sendPlayerGift(_loc6_.ID);
            }
            if(DesktopManager.Instance.isDesktop)
            {
               setTimeout(TaskManager.instance.onDesktopApp,500);
            }
            PetSpriteManager.Instance.setup();
            DuowanInterfaceManage.Instance.dispatchEvent(new DuowanInterfaceEvent("onLine"));
            SystemOpenPromptManager.instance.isShowNewEuipTip = true;
            if(refreshFlag)
            {
               SystemOpenPromptManager.instance.showFrame();
               refreshFlag = false;
            }
            if(HallPlayerView.initFlag)
            {
               SocketManager.Instance.out.sendOtherPlayerInfo();
            }
            if(MailManager.Instance.linkChurchRoomId != -1)
            {
               SocketManager.Instance.out.sendEnterRoom(MailManager.Instance.linkChurchRoomId,"");
            }
            SocketManager.Instance.out.requestWonderfulActInit(2);
            addLoaderAgain();
            SevendayManager.instance.setup();
            ConsortionModelManager.Instance.setup();
         }
         else
         {
            _loc4_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("alert"),LanguageMgr.GetTranslation("ServerLinkError"));
            alertControl(_loc4_);
         }
         WaitTimeAlertManager.Instance.dispose();
      }
      
      private function addLoader(param1:BaseLoader) : void
      {
         _loaderQueue.addLoader(param1);
      }
      
      private function addLoaderAgain() : void
      {
         _loaderQueue = new QueueLoader();
         _loaderQueue.addEventListener("change",__onSetupSourceLoadChange);
         _loaderQueue.addEventListener("complete",__onSetupSourceLoadComplete);
         _loaderQueue.start();
      }
      
      private function __onSetupSourceLoadChange(param1:Event) : void
      {
         _requestCompleted = (param1.currentTarget as QueueLoader).completeCount;
      }
      
      private function __onSetupSourceLoadComplete(param1:Event) : void
      {
         var _loc2_:QueueLoader = param1.currentTarget as QueueLoader;
         _loc2_.removeEventListener("complete",__onSetupSourceLoadComplete);
         _loc2_.removeEventListener("change",__onSetupSourceLoadChange);
         _loc2_.dispose();
         _loc2_ = null;
      }
      
      private function releaseLock() : void
      {
         AUTO_UNLOCK = true;
         SocketManager.Instance.out.sendBagLocked(BaglockedManager.PWD,2);
      }
      
      private function __onLoginCountHandler(param1:CrazyTankSocketEvent) : void
      {
         event = param1;
         var pkg:PackageIn = event.pkg;
         var count:int = pkg.readInt();
         var waitTime:int = count * 1;
         WaitTimeAlertManager.Instance.createWaitFrame(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("server.loginCountTimeOutMsg"),count,waitTime,function():void
         {
            WaitTimeAlertManager.Instance.updateWaitFrameMsg(LanguageMgr.GetTranslation("server.loginCountTimeOutMsg2"));
         });
      }
      
      private function __onConfigHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc6_:PackageIn = param1.pkg;
         PathManager.getPathInfo().beginChanges();
         var _loc8_:String = _loc6_.readUTF();
         PathManager.getPathInfo().CLIENT_DOWNLOAD = _loc8_;
         var _loc5_:Boolean = _loc6_.readBoolean();
         LandersAwardManager.instance.landersAwardOfficial = _loc5_;
         var _loc4_:String = _loc6_.readUTF().replace(/#/g,",");
         PathManager.getPathInfo().DISABLE_TASK_ID = _loc4_;
         var _loc2_:Boolean = _loc6_.readBoolean();
         PathManager.getPathInfo().FEEDBACK_ENABLE = _loc2_;
         var _loc7_:String = _loc6_.readUTF();
         PathManager.getPathInfo().FEEDBACK_TEL_NUMBER = _loc7_;
         var _loc3_:Boolean = _loc6_.readBoolean();
         PathManager.getPathInfo().COMMUNITY_EXIST = _loc3_;
         PathManager.getPathInfo().commitChanges();
      }
   }
}
