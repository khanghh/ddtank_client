package worldboss
{
   import baglocked.BaglockedManager;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.CoreManager;
   import ddt.events.CEvent;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddt.utils.Helpers;
   import ddt.view.UIModuleSmallLoading;
   import ddtActivityIcon.DdtActivityIconManager;
   import ddtActivityIcon.DdtIconTxt;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.clearInterval;
   import flash.utils.setTimeout;
   import hallIcon.HallIconManager;
   import hallIcon.HallIconType;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import wantstrong.WantStrongManager;
   import wantstrong.event.WantStrongEvent;
   import worldBossHelper.WorldBossHelperManager;
   import worldBossHelper.event.WorldBossHelperEvent;
   import worldboss.event.WorldBossRoomEvent;
   import worldboss.model.WorldBossBuffInfo;
   import worldboss.model.WorldBossInfo;
   import worldboss.player.PlayerVO;
   import worldboss.player.RankingPersonInfo;
   import worldboss.view.WorldBossIcon;
   import worldboss.view.WorldBossRankingFram;
   
   public class WorldBossManager extends CoreManager
   {
      
      private static var _instance:WorldBossManager;
      
      public static var IsSuccessStartGame:Boolean = false;
       
      
      private var _ishallComplete:Boolean = false;
      
      private var _isOpen:Boolean = false;
      
      private var _mapload:BaseLoader;
      
      private var _bossInfo:WorldBossInfo;
      
      private var _entranceBtn:WorldBossIcon;
      
      private var _currentPVE_ID:int;
      
      private var _sky:MovieClip;
      
      public var iconEnterPath:String;
      
      public var mapPath:String;
      
      private var _autoBuyBuffs:DictionaryData;
      
      private var _appearPos:Array;
      
      private var _isShowBlood:Boolean = false;
      
      private var _isBuyBuffAlert:Boolean = false;
      
      private var _bossResourceId:String;
      
      private var _rankingInfos:Vector.<RankingPersonInfo>;
      
      private var _autoBlood:Boolean = false;
      
      private var _mapLoader:BaseLoader;
      
      private var _isLoadingState:Boolean = false;
      
      private var _activityTxt:DdtIconTxt;
      
      public var worldBossNum:int;
      
      public function WorldBossManager()
      {
         iconEnterPath = getWorldbossResource() + "/icon/worldbossIcon.swf";
         _autoBuyBuffs = new DictionaryData();
         _appearPos = [];
         _rankingInfos = new Vector.<RankingPersonInfo>();
         super();
      }
      
      public static function get Instance() : WorldBossManager
      {
         if(!WorldBossManager._instance)
         {
            WorldBossManager._instance = new WorldBossManager();
         }
         return WorldBossManager._instance;
      }
      
      public function setup() : void
      {
         worldBossNum = 0;
         SocketManager.Instance.addEventListener(PkgEvent.format(102,0),__init);
      }
      
      override protected function start() : void
      {
         dispatchEvent(new CEvent("openview"));
      }
      
      public function get BossResourceId() : String
      {
         return _bossResourceId;
      }
      
      public function get isBuyBuffAlert() : Boolean
      {
         return _isBuyBuffAlert;
      }
      
      public function set isBuyBuffAlert(param1:Boolean) : void
      {
         _isBuyBuffAlert = param1;
      }
      
      public function get autoBuyBuffs() : DictionaryData
      {
         return _autoBuyBuffs;
      }
      
      public function get isShowBlood() : Boolean
      {
         return _isShowBlood;
      }
      
      public function get isAutoBlood() : Boolean
      {
         return _autoBlood;
      }
      
      public function get rankingInfos() : Vector.<RankingPersonInfo>
      {
         return _rankingInfos;
      }
      
      private function __init(param1:PkgEvent) : void
      {
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:* = null;
         _bossResourceId = param1.pkg.readUTF();
         _currentPVE_ID = param1.pkg.readInt();
         param1.pkg.readUTF();
         iconEnterPath = getWorldbossResource() + "/icon/worldbossIcon.swf";
         addSocketEvent();
         _bossInfo = new WorldBossInfo();
         _bossInfo.myPlayerVO = new PlayerVO();
         _bossInfo.name = param1.pkg.readUTF();
         _bossInfo.total_Blood = param1.pkg.readLong();
         _bossInfo.current_Blood = _bossInfo.total_Blood;
         var _loc5_:int = param1.pkg.readInt();
         var _loc6_:int = param1.pkg.readInt();
         mapPath = getWorldbossResource() + "/map/worldbossMap.swf";
         _appearPos.length = 0;
         var _loc2_:int = param1.pkg.readInt();
         _loc7_ = 0;
         while(_loc7_ < _loc2_)
         {
            _appearPos.push(new Point(param1.pkg.readInt(),param1.pkg.readInt()));
            _loc7_++;
         }
         _bossInfo.playerDefaultPos = Helpers.randomPick(_appearPos);
         _bossInfo.begin_time = param1.pkg.readDate();
         _bossInfo.end_time = param1.pkg.readDate();
         _bossInfo.fight_time = param1.pkg.readInt();
         _bossInfo.fightOver = param1.pkg.readBoolean();
         _bossInfo.roomClose = param1.pkg.readBoolean();
         _bossInfo.ticketID = param1.pkg.readInt();
         _bossInfo.need_ticket_count = param1.pkg.readInt();
         _bossInfo.timeCD = param1.pkg.readInt();
         _bossInfo.reviveMoney = param1.pkg.readInt();
         _bossInfo.reFightMoney = param1.pkg.readInt();
         _bossInfo.addInjureBuffMoney = param1.pkg.readInt();
         _bossInfo.addInjureValue = param1.pkg.readInt();
         _bossInfo.buffArray.length = 0;
         var _loc3_:int = param1.pkg.readInt();
         _loc8_ = 0;
         while(_loc8_ < _loc3_)
         {
            _loc4_ = new WorldBossBuffInfo();
            _loc4_.ID = param1.pkg.readInt();
            _loc4_.name = param1.pkg.readUTF();
            _loc4_.price = param1.pkg.readInt();
            _loc4_.decription = param1.pkg.readUTF();
            _loc4_.costID = param1.pkg.readInt();
            _bossInfo.buffArray.push(_loc4_);
            _loc8_++;
         }
         _isShowBlood = param1.pkg.readBoolean();
         _autoBlood = param1.pkg.readBoolean();
         isOpen = true;
         WorldBossManager.Instance.isLoadingState = false;
         worldBossNum = Number(worldBossNum) + 1;
         dispatchEvent(new WorldBossRoomEvent("gameInit"));
         if(WorldBossHelperManager.Instance.isInWorldBossHelperFrame && WorldBossHelperManager.Instance.helperOpen)
         {
            if(WorldBossHelperManager.Instance.isHelperOnlyOnce)
            {
               if(worldBossNum > 1)
               {
                  return;
               }
               WorldBossHelperManager.Instance.dispatchEvent(new WorldBossHelperEvent("bossOpen"));
            }
            else
            {
               WorldBossHelperManager.Instance.dispatchEvent(new WorldBossHelperEvent("bossOpen"));
            }
         }
      }
      
      private function addSocketEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(102,2),__enter);
         SocketManager.Instance.addEventListener(PkgEvent.format(102,5),__update);
         SocketManager.Instance.addEventListener(PkgEvent.format(102,8),__fightOver);
         SocketManager.Instance.addEventListener(PkgEvent.format(102,9),__leaveRoom);
         SocketManager.Instance.addEventListener(PkgEvent.format(102,10),__showRanking);
         SocketManager.Instance.addEventListener(PkgEvent.format(102,1),__allOver);
         SocketManager.Instance.addEventListener("gameRoomFull",__gameRoomFull);
         SocketManager.Instance.addEventListener(PkgEvent.format(102,12),__updateBuffLevel);
         SocketManager.Instance.addEventListener(PkgEvent.format(102,22),__updatePrivateInfo);
      }
      
      private function removeSocketEvent() : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(102,2),__enter);
         SocketManager.Instance.removeEventListener(PkgEvent.format(102,5),__update);
         SocketManager.Instance.removeEventListener(PkgEvent.format(102,8),__fightOver);
         SocketManager.Instance.removeEventListener(PkgEvent.format(102,9),__leaveRoom);
         SocketManager.Instance.removeEventListener(PkgEvent.format(102,10),__showRanking);
         SocketManager.Instance.removeEventListener(PkgEvent.format(102,1),__allOver);
         SocketManager.Instance.removeEventListener("gameRoomFull",__gameRoomFull);
         SocketManager.Instance.removeEventListener(PkgEvent.format(102,12),__updateBuffLevel);
         SocketManager.Instance.removeEventListener(PkgEvent.format(102,22),__updatePrivateInfo);
      }
      
      protected function __updatePrivateInfo(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         WorldBossManager.Instance.bossInfo.myPlayerVO.myDamage = _loc2_.readInt();
         WorldBossManager.Instance.bossInfo.myPlayerVO.myHonor = _loc2_.readInt();
         dispatchEvent(new Event("change"));
      }
      
      protected function __updateBuffLevel(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         WorldBossManager.Instance.bossInfo.myPlayerVO.buffLevel = _loc2_.readInt();
         WorldBossManager.Instance.bossInfo.myPlayerVO.buffInjure = _loc2_.readInt();
         dispatchEvent(new Event("change"));
      }
      
      private function __gameRoomFull(param1:CrazyTankSocketEvent) : void
      {
         dispatchEvent(new WorldBossRoomEvent("worldBossRoomFull"));
      }
      
      public function creatEnterIcon(param1:Boolean = true, param2:int = 1, param3:String = null) : void
      {
         HallIconManager.instance.updateSwitchHandler(HallIconType["WORLDBOSSENTRANCE" + _bossResourceId],true,param3);
      }
      
      public function disposeEnterBtn() : void
      {
         if(_entranceBtn)
         {
            ObjectUtils.disposeObject(_entranceBtn);
         }
         _entranceBtn = null;
      }
      
      private function __enter(param1:PkgEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1.pkg.bytesAvailable > 0 && param1.pkg.readBoolean())
         {
            _bossInfo.isLiving = !param1.pkg.readBoolean();
            _bossInfo.myPlayerVO.reviveCD = param1.pkg.readInt();
            _loc2_ = param1.pkg.readInt();
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _bossInfo.myPlayerVO.buffID = param1.pkg.readInt();
               _loc3_++;
            }
            if(_bossInfo.myPlayerVO.reviveCD > 0)
            {
               _bossInfo.myPlayerVO.playerStauts = 3;
               _bossInfo.myPlayerVO.playerPos = new Point(int(Math.random() * 300 + 300),int(Math.random() * 850) + 350);
            }
            else
            {
               _bossInfo.myPlayerVO.playerPos = _bossInfo.playerDefaultPos;
               _bossInfo.myPlayerVO.playerStauts = 1;
            }
            dispatchEvent(new WorldBossRoomEvent("can enter"));
            loadMap();
         }
      }
      
      private function loadMap() : void
      {
         _mapLoader = LoadResourceManager.Instance.createLoader(WorldBossManager.Instance.mapPath,4);
         _mapLoader.addEventListener("complete",onMapSrcLoadedComplete);
         LoadResourceManager.Instance.startLoad(_mapLoader);
      }
      
      private function onMapSrcLoadedComplete(param1:Event) : void
      {
         if(StateManager.getState("worldboss") == null)
         {
            UIModuleSmallLoading.Instance.addEventListener("close",__loadingIsCloseRoom);
         }
         StateManager.setState("worldboss");
      }
      
      private function __loadingIsCloseRoom(param1:Event) : void
      {
         UIModuleSmallLoading.Instance.removeEventListener("close",__loadingIsCloseRoom);
      }
      
      private function __update(param1:PkgEvent) : void
      {
         _autoBlood = param1.pkg.readBoolean();
         _bossInfo.total_Blood = param1.pkg.readLong();
         _bossInfo.current_Blood = param1.pkg.readLong();
         dispatchEvent(new WorldBossRoomEvent("boss_hp_updata"));
      }
      
      private function __fightOver(param1:PkgEvent) : void
      {
         _bossInfo.fightOver = true;
         _bossInfo.isLiving = !param1.pkg.readBoolean();
         if(_entranceBtn)
         {
            _entranceBtn.setFrame(2);
         }
         dispatchEvent(new WorldBossRoomEvent("fight_over"));
      }
      
      private function __leaveRoom(param1:Event) : void
      {
         _bossInfo.roomClose = true;
         if(StateManager.currentStateType == "worldboss")
         {
            StateManager.setState("main");
            dispatchEvent(new CEvent("closeView"));
         }
         dispatchEvent(new WorldBossRoomEvent("room close"));
      }
      
      private function __showRanking(param1:PkgEvent) : void
      {
         if(param1.pkg.readBoolean())
         {
            showRankingFrame(param1.pkg);
         }
         else
         {
            showRankingInRoom(param1.pkg);
         }
      }
      
      private function showRankingFrame(param1:PackageIn) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         _rankingInfos.length = 0;
         var _loc3_:WorldBossRankingFram = ComponentFactory.Instance.creat("worldboss.ranking.frame");
         var _loc2_:int = param1.readInt();
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc4_ = new RankingPersonInfo();
            _loc4_.id = param1.readInt();
            _loc4_.name = param1.readUTF();
            _loc4_.damage = param1.readInt();
            _loc3_.addPersonRanking(_loc4_);
            _rankingInfos.push(_loc4_);
            _loc5_++;
         }
         if(!(CacheSysManager.isLock("alertInFight") && StateManager.currentStateType != "worldboss"))
         {
            _loc3_.show();
         }
      }
      
      private function showRankingInRoom(param1:PackageIn) : void
      {
         dispatchEvent(new CrazyTankSocketEvent("worldboss_ranking_inroom",param1));
      }
      
      private function __allOver(param1:PkgEvent) : void
      {
         event = param1;
         _bossInfo.fightOver = true;
         _bossInfo.roomClose = true;
         isOpen = false;
         if(_entranceBtn)
         {
            _entranceBtn.visible = false;
            if(_entranceBtn.parent)
            {
               _entranceBtn.parent.removeChild(_entranceBtn);
            }
         }
         _entranceBtn = null;
         removeSocketEvent();
         DdtActivityIconManager.Instance.currObj = null;
         if(_activityTxt)
         {
            _activityTxt.resetTxt();
            ObjectUtils.disposeObject(_activityTxt);
            _activityTxt = null;
         }
         if(StateManager.currentStateType == "main" || StateManager.currentStateType == "roomlist" || StateManager.currentStateType == "dungeon")
         {
            var tempTimeNum:uint = setTimeout(function():void
            {
               clearInterval(tempTimeNum);
               WantStrongManager.Instance.dispatchEvent(new WantStrongEvent("alreadyUpdateTime"));
            },3000);
         }
      }
      
      public function enterGame() : void
      {
         SocketManager.Instance.out.enterUserGuide(WorldBossManager.Instance.currentPVE_ID,14);
         if(!WorldBossManager.Instance.bossInfo.fightOver)
         {
            IsSuccessStartGame = true;
            GameInSocketOut.sendGameStart();
            SocketManager.Instance.out.sendWorldBossRoomStauts(2);
            dispatchEvent(new Event("enteringGame"));
         }
         else
         {
            StateManager.setState("worldboss");
         }
      }
      
      public function exitGame() : void
      {
         IsSuccessStartGame = false;
         GameInSocketOut.sendGamePlayerExit();
      }
      
      public function showEntranceBtn() : void
      {
         _ishallComplete = true;
      }
      
      public function addshowHallEntranceBtn() : void
      {
         if(_ishallComplete && StateManager.currentStateType == "main")
         {
            showEntranceBtn();
         }
      }
      
      public function showHallSkyEffort(param1:MovieClip) : void
      {
         if(param1 == _sky)
         {
            return;
         }
         ObjectUtils.disposeObject(_sky);
         _sky = param1;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         _isOpen = param1;
         if(StateManager.currentStateType == "main")
         {
            if(_sky)
            {
               _sky.visible = !_bossInfo.fightOver;
            }
         }
         if((StateManager.currentStateType == "worldbossAward" || StateManager.currentStateType == "worldboss") && !isOpen)
         {
            StateManager.setState("main");
         }
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function get currentPVE_ID() : int
      {
         return _currentPVE_ID;
      }
      
      public function get bossInfo() : WorldBossInfo
      {
         return _bossInfo;
      }
      
      public function getWorldbossResource() : String
      {
         var _loc1_:String = _bossResourceId == null?"1":_bossResourceId;
         return PathManager.SITE_MAIN + "image/worldboss/" + _loc1_;
      }
      
      public function buyNewBuff(param1:int, param2:Boolean) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc5_:int = bossInfo.myPlayerVO.buffLevel;
         if(_loc5_ >= 20)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.worldboss.buffLevelMax"));
            return;
         }
         var _loc4_:int = WorldBossManager.Instance.bossInfo.addInjureBuffMoney;
         var _loc3_:* = _loc4_;
         if(param2)
         {
            _loc3_ = int((20 - _loc5_) * _loc4_);
         }
         if(param1 == 1)
         {
            if(PlayerManager.Instance.Self.Money < _loc3_)
            {
               LeavePageManager.showFillFrame();
               return;
            }
         }
         else if(param1 == 2)
         {
            if(PlayerManager.Instance.Self.BandMoney < _loc3_)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.transfer.StoreIITransferBG.lijinbuzu"));
               return;
            }
         }
         SocketManager.Instance.out.sendNewBuyWorldBossBuff(param1,!!param2?20 - _loc5_:1);
      }
      
      public function set isLoadingState(param1:Boolean) : void
      {
         _isLoadingState = param1;
      }
      
      public function get isLoadingState() : Boolean
      {
         return _isLoadingState;
      }
      
      public function get beforeStartTime() : int
      {
         if(!_bossInfo || !_bossInfo.begin_time)
         {
            return 0;
         }
         return getDateHourTime(_bossInfo.begin_time) + 300 - getDateHourTime(TimeManager.Instance.Now());
      }
      
      private function getDateHourTime(param1:Date) : int
      {
         return int(param1.hours * 3600 + param1.minutes * 60 + param1.seconds);
      }
      
      public function setSelfStatus(param1:int) : void
      {
         dispatchEvent(new CEvent("setselfstatus",param1));
      }
   }
}
