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
      
      public function set zoneName(value:String) : void
      {
         _zoneName = value;
         dispatchEvent(new Event("change"));
      }
      
      public function get AgentID() : int
      {
         return _agentid;
      }
      
      public function set AgentID(value:int) : void
      {
         _agentid = value;
      }
      
      public function set current(value:ServerInfo) : void
      {
         _current = value;
      }
      
      public function get current() : ServerInfo
      {
         return _current;
      }
      
      public function get list() : Vector.<ServerInfo>
      {
         return _list;
      }
      
      public function set list(value:Vector.<ServerInfo>) : void
      {
         _list = value;
         dispatchEvent(new Event("change"));
      }
      
      public function setup(analyzer:ServerListAnalyzer) : void
      {
         _list = analyzer.list;
         _agentid = analyzer.agentId;
         _zoneName = analyzer.zoneName;
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
         var player:SelfInfo = PlayerManager.Instance.Self;
         if(DDT.SERVER_ID != -1)
         {
            _current = getServerInfoByID(DDT.SERVER_ID);
            return;
         }
         if(player.LastServerId != -1)
         {
            _current = getServerInfoByID(player.LastServerId);
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
      
      public function getServerInfoByID(id:int) : ServerInfo
      {
         var i:int = 0;
         for(i = 0; i < _list.length; )
         {
            if(_list[i].ID == id)
            {
               return _list[i];
            }
            i++;
         }
         return null;
      }
      
      private function searchServerByState(state:int) : ServerInfo
      {
         var i:int = 0;
         for(i = 0; i < _list.length; )
         {
            if(_list[i].State == state)
            {
               return _list[i];
            }
            i++;
         }
         return null;
      }
      
      public function connentServer(info:ServerInfo) : Boolean
      {
         var alert:* = null;
         if(info == null)
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.serverlist.ServerListPosView.choose"));
            alertControl(alert);
            return false;
         }
         if(info.MustLevel < PlayerManager.Instance.Self.Grade)
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.serverlist.ServerListPosView.your"));
            alertControl(alert);
            return false;
         }
         if(info.LowestLevel > PlayerManager.Instance.Self.Grade)
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.serverlist.ServerListPosView.low"));
            alertControl(alert);
            return false;
         }
         if(info.State == 5)
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.serverlist.ServerListPosView.full"));
            alertControl(alert);
            return false;
         }
         if(info.State == 1)
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.serverlist.ServerListPosView.maintenance"));
            alertControl(alert);
            return false;
         }
         _current = info;
         SocketManager.Instance.isChangeChannel = true;
         connentCurrentServer();
         dispatchEvent(new Event("changeServer"));
         return true;
      }
      
      private function alertControl(alert:BaseAlerFrame) : void
      {
         alert.addEventListener("response",__alertResponse);
      }
      
      private function __alertResponse(evt:FrameEvent) : void
      {
         var alert:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",__alertResponse);
         alert.dispose();
      }
      
      private function __onLoginLastServer(e:PkgEvent) : void
      {
         var playerID:int = e.pkg.readInt();
         var lastServerID:int = e.pkg.readInt();
         if(playerID == PlayerManager.Instance.Self.ID && lastServerID != -1)
         {
            PlayerManager.Instance.Self.LastServerId = lastServerID;
            connentServer(getServerInfoByID(lastServerID));
         }
      }
      
      private function __onLoginComplete(event:PkgEvent) : void
      {
         var styleAndSkin:* = null;
         var t:* = null;
         var locked:Boolean = false;
         var lockReleased:Boolean = false;
         var alert:* = null;
         var pkg:PackageIn = event.pkg;
         var self:SelfInfo = PlayerManager.Instance.Self;
         if(pkg.readByte() == 0)
         {
            CacheSysManager.getInstance().singleRelease("alertInNewversionguidetip");
            CacheSysManager.lock("alertInNewversionguidetip");
            self.beginChanges();
            SocketManager.Instance.isLogin = true;
            self.ZoneID = pkg.readInt();
            self.Attack = pkg.readInt();
            self.Defence = pkg.readInt();
            self.Agility = pkg.readInt();
            self.Luck = pkg.readInt();
            self.GP = pkg.readInt();
            self.Repute = pkg.readInt();
            self.Gold = pkg.readInt();
            self.Money = pkg.readInt();
            self.DDTMoney = pkg.readInt();
            self.BandMoney = pkg.readInt();
            self.Score = pkg.readInt();
            self.Hide = pkg.readInt();
            self.FightPower = pkg.readInt();
            self.apprenticeshipState = pkg.readInt();
            self.masterID = pkg.readInt();
            self.setMasterOrApprentices(pkg.readUTF());
            self.graduatesCount = pkg.readInt();
            self.honourOfMaster = pkg.readUTF();
            self.freezesDate = pkg.readDate();
            self.typeVIP = pkg.readByte();
            self.VIPLevel = pkg.readInt();
            self.VIPExp = pkg.readInt();
            self.VIPExpireDay = pkg.readDate();
            self.LastDate = pkg.readDate();
            self.VIPNextLevelDaysNeeded = pkg.readInt();
            self.systemDate = pkg.readDate();
            self.canTakeVipReward = pkg.readBoolean();
            self.OptionOnOff = pkg.readInt();
            self.AchievementPoint = pkg.readInt();
            self.honor = pkg.readUTF();
            self.honorId = pkg.readInt();
            TimeManager.Instance.totalGameTime = pkg.readInt();
            self.Sex = pkg.readBoolean();
            styleAndSkin = pkg.readUTF();
            t = styleAndSkin.split("&");
            self.Style = t[0];
            self.Colors = t[1];
            self.Skin = pkg.readUTF();
            self.ConsortiaID = pkg.readInt();
            self.ConsortiaName = pkg.readUTF();
            self.badgeID = pkg.readInt();
            self.DutyLevel = pkg.readInt();
            self.DutyName = pkg.readUTF();
            self.Right = pkg.readInt();
            self.consortiaInfo.ChairmanName = pkg.readUTF();
            self.consortiaInfo.Honor = pkg.readInt();
            self.consortiaInfo.Riches = pkg.readInt();
            locked = pkg.readBoolean();
            lockReleased = self.bagPwdState && !self.bagLocked;
            self.bagPwdState = locked;
            if(lockReleased)
            {
               setTimeout(releaseLock,1000);
            }
            self.bagLocked = locked;
            self.questionOne = pkg.readUTF();
            self.questionTwo = pkg.readUTF();
            self.leftTimes = pkg.readInt();
            self.LoginName = pkg.readUTF();
            self.Nimbus = pkg.readInt();
            TaskManager.instance.requestCanAcceptTask();
            self.PvePermission = pkg.readUTF();
            self.fightLibMission = pkg.readUTF();
            self.userGuildProgress = pkg.readInt();
            self.LastSpaDate = pkg.readDate();
            self.shopFinallyGottenTime = pkg.readDate();
            self.UseOffer = pkg.readInt();
            self.matchInfo.dailyScore = pkg.readInt();
            self.matchInfo.dailyWinCount = pkg.readInt();
            self.matchInfo.dailyGameCount = pkg.readInt();
            self.DailyLeagueFirst = pkg.readBoolean();
            self.DailyLeagueLastScore = pkg.readInt();
            self.matchInfo.weeklyScore = pkg.readInt();
            self.matchInfo.weeklyGameCount = pkg.readInt();
            self.matchInfo.weeklyRanking = pkg.readInt();
            self.spdTexpExp = pkg.readInt();
            self.attTexpExp = pkg.readInt();
            self.defTexpExp = pkg.readInt();
            self.hpTexpExp = pkg.readInt();
            self.lukTexpExp = pkg.readInt();
            self.magicAtkTexpExp = pkg.readInt();
            self.magicDefTexpExp = pkg.readInt();
            self.texpTaskCount = pkg.readInt();
            self.texpCount = pkg.readInt();
            self.magicTexpCount = pkg.readInt();
            self.texpTaskDate = pkg.readDate();
            self.isOldPlayerHasValidEquitAtLogin = pkg.readBoolean();
            self.badLuckNumber = pkg.readInt();
            self.luckyNum = pkg.readInt();
            self.lastLuckyNumDate = pkg.readDate();
            self.lastLuckNum = pkg.readInt();
            self.isOld = pkg.readBoolean();
            self.isOld2 = pkg.readBoolean();
            self.CardSoul = pkg.readInt();
            self.GetSoulCount = pkg.readInt();
            self.uesedFinishTime = pkg.readInt();
            self.totemId = pkg.readInt();
            self.necklaceExp = pkg.readInt();
            self.accumulativeLoginDays = pkg.readInt();
            self.accumulativeAwardDays = pkg.readInt();
            pkg.readInt();
            pkg.readInt();
            pkg.readInt();
            self.isFirstDivorce = pkg.readInt();
            self.PveEpicPermission = pkg.readUTF();
            self.MountsType = pkg.readInt();
            self.PetsID = pkg.readInt();
            HorseRaceManager.Instance.horseRaceCanRaceTime = pkg.readInt();
            self.isAttest = pkg.readBoolean();
            self.ImagePath = pkg.readUTF();
            self.SubID = pkg.readInt();
            self.SubName = pkg.readUTF();
            self.IsShow = pkg.readBoolean();
            pkg.readBoolean();
            self.createPlayerDate = pkg.readDate();
            self.commitChanges();
            self.vipDiscount = pkg.readInt();
            self.vipDiscountValidity = pkg.readDate();
            self.stive = pkg.readInt();
            self.manualProInfo.manual_Level = pkg.readInt();
            self.manualProInfo.pro_Agile = pkg.readInt();
            self.manualProInfo.pro_Armor = pkg.readInt();
            self.manualProInfo.pro_Attack = pkg.readInt();
            self.manualProInfo.pro_Damage = pkg.readInt();
            self.manualProInfo.pro_Defense = pkg.readInt();
            self.manualProInfo.pro_HP = pkg.readInt();
            self.manualProInfo.pro_Lucky = pkg.readInt();
            self.manualProInfo.pro_MagicAttack = pkg.readInt();
            self.manualProInfo.pro_MagicResistance = pkg.readInt();
            self.manualProInfo.pro_Stamina = pkg.readInt();
            self.teamID = pkg.readInt();
            self.teamName = pkg.readUTF();
            self.teamTag = pkg.readUTF();
            self.teamGrade = pkg.readInt();
            self.teamWinTime = pkg.readInt();
            self.teamTotalTime = pkg.readInt();
            self.teamDivision = pkg.readInt();
            self.teamScore = pkg.readInt();
            self.teamDuty = pkg.readInt();
            self.teamPersonalScore = pkg.readInt();
            self.freeInvitedUsedCnt = pkg.readInt();
            self.critTexpExp = pkg.readInt();
            self.sunderArmorTexpExp = pkg.readInt();
            self.critDmgTexpExp = pkg.readInt();
            self.speedTexpExp = pkg.readInt();
            self.uniqueSkillTexpExp = pkg.readInt();
            self.dmgTexpExp = pkg.readInt();
            self.armorDefTexpExp = pkg.readInt();
            self.nsTexpCount = pkg.readInt();
            self.commitChanges();
            MapManager.buildMap();
            PlayerManager.Instance.Self.loadRelatedPlayersInfo();
            DailyButtunBar.Insance.hideFlag = true;
            MainToolBar.Instance.signEffectEnable = true;
            StateManager.setState("main");
            ExternalInterfaceManager.sendTo360Agent(4);
            if(!StartupResourceLoader.firstEnterHall)
            {
               StartupResourceLoader.Instance.startLoadRelatedInfo();
               SocketManager.Instance.out.sendPlayerGift(self.ID);
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
            ConsortionModelManager.Instance.setup();
         }
         else
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("alert"),LanguageMgr.GetTranslation("ServerLinkError"));
            alertControl(alert);
         }
         WaitTimeAlertManager.Instance.dispose();
      }
      
      private function addLoader(loader:BaseLoader) : void
      {
         _loaderQueue.addLoader(loader);
      }
      
      private function addLoaderAgain() : void
      {
         _loaderQueue = new QueueLoader();
         _loaderQueue.addEventListener("change",__onSetupSourceLoadChange);
         _loaderQueue.addEventListener("complete",__onSetupSourceLoadComplete);
         _loaderQueue.start();
      }
      
      private function __onSetupSourceLoadChange(event:Event) : void
      {
         _requestCompleted = (event.currentTarget as QueueLoader).completeCount;
      }
      
      private function __onSetupSourceLoadComplete(event:Event) : void
      {
         var queue:QueueLoader = event.currentTarget as QueueLoader;
         queue.removeEventListener("complete",__onSetupSourceLoadComplete);
         queue.removeEventListener("change",__onSetupSourceLoadChange);
         queue.dispose();
         queue = null;
      }
      
      private function releaseLock() : void
      {
         AUTO_UNLOCK = true;
         SocketManager.Instance.out.sendBagLocked(BaglockedManager.PWD,2);
      }
      
      private function __onLoginCountHandler(event:CrazyTankSocketEvent) : void
      {
         event = event;
         var pkg:PackageIn = event.pkg;
         var count:int = pkg.readInt();
         var waitTime:int = count * 1;
         WaitTimeAlertManager.Instance.createWaitFrame(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("server.loginCountTimeOutMsg"),count,waitTime,function():void
         {
            WaitTimeAlertManager.Instance.updateWaitFrameMsg(LanguageMgr.GetTranslation("server.loginCountTimeOutMsg2"));
         });
      }
      
      private function __onConfigHandler(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         PathManager.getPathInfo().beginChanges();
         var clientDownload:String = pkg.readUTF();
         PathManager.getPathInfo().CLIENT_DOWNLOAD = clientDownload;
         var landersAwardOfficial:Boolean = pkg.readBoolean();
         LandersAwardManager.instance.landersAwardOfficial = landersAwardOfficial;
         var disableTaskIds:String = pkg.readUTF().replace(/#/g,",");
         PathManager.getPathInfo().DISABLE_TASK_ID = disableTaskIds;
         var feedbackEnable:Boolean = pkg.readBoolean();
         PathManager.getPathInfo().FEEDBACK_ENABLE = feedbackEnable;
         var feedbackTelNumber:String = pkg.readUTF();
         PathManager.getPathInfo().FEEDBACK_TEL_NUMBER = feedbackTelNumber;
         var communityExist:Boolean = pkg.readBoolean();
         PathManager.getPathInfo().COMMUNITY_EXIST = communityExist;
         PathManager.getPathInfo().commitChanges();
      }
   }
}
