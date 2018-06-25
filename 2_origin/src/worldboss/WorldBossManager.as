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
      
      public function set isBuyBuffAlert(value:Boolean) : void
      {
         _isBuyBuffAlert = value;
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
      
      private function __init(event:PkgEvent) : void
      {
         var j:int = 0;
         var i:int = 0;
         var buffInfo:* = null;
         _bossResourceId = event.pkg.readUTF();
         _currentPVE_ID = event.pkg.readInt();
         event.pkg.readUTF();
         iconEnterPath = getWorldbossResource() + "/icon/worldbossIcon.swf";
         addSocketEvent();
         _bossInfo = new WorldBossInfo();
         _bossInfo.myPlayerVO = new PlayerVO();
         _bossInfo.name = event.pkg.readUTF();
         _bossInfo.total_Blood = event.pkg.readLong();
         _bossInfo.current_Blood = _bossInfo.total_Blood;
         var boss_x:int = event.pkg.readInt();
         var boss_y:int = event.pkg.readInt();
         mapPath = getWorldbossResource() + "/map/worldbossMap.swf";
         _appearPos.length = 0;
         var posCount:int = event.pkg.readInt();
         for(j = 0; j < posCount; )
         {
            _appearPos.push(new Point(event.pkg.readInt(),event.pkg.readInt()));
            j++;
         }
         _bossInfo.playerDefaultPos = Helpers.randomPick(_appearPos);
         _bossInfo.begin_time = event.pkg.readDate();
         _bossInfo.end_time = event.pkg.readDate();
         _bossInfo.fight_time = event.pkg.readInt();
         _bossInfo.fightOver = event.pkg.readBoolean();
         _bossInfo.roomClose = event.pkg.readBoolean();
         _bossInfo.ticketID = event.pkg.readInt();
         _bossInfo.need_ticket_count = event.pkg.readInt();
         _bossInfo.timeCD = event.pkg.readInt();
         _bossInfo.reviveMoney = event.pkg.readInt();
         _bossInfo.reFightMoney = event.pkg.readInt();
         _bossInfo.addInjureBuffMoney = event.pkg.readInt();
         _bossInfo.addInjureValue = event.pkg.readInt();
         _bossInfo.buffArray.length = 0;
         var count:int = event.pkg.readInt();
         for(i = 0; i < count; )
         {
            buffInfo = new WorldBossBuffInfo();
            buffInfo.ID = event.pkg.readInt();
            buffInfo.name = event.pkg.readUTF();
            buffInfo.price = event.pkg.readInt();
            buffInfo.decription = event.pkg.readUTF();
            buffInfo.costID = event.pkg.readInt();
            _bossInfo.buffArray.push(buffInfo);
            i++;
         }
         _isShowBlood = event.pkg.readBoolean();
         _autoBlood = event.pkg.readBoolean();
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
      
      protected function __updatePrivateInfo(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         WorldBossManager.Instance.bossInfo.myPlayerVO.myDamage = pkg.readInt();
         WorldBossManager.Instance.bossInfo.myPlayerVO.myHonor = pkg.readInt();
         dispatchEvent(new Event("change"));
      }
      
      protected function __updateBuffLevel(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         WorldBossManager.Instance.bossInfo.myPlayerVO.buffLevel = pkg.readInt();
         WorldBossManager.Instance.bossInfo.myPlayerVO.buffInjure = pkg.readInt();
         dispatchEvent(new Event("change"));
      }
      
      private function __gameRoomFull(pEvent:CrazyTankSocketEvent) : void
      {
         dispatchEvent(new WorldBossRoomEvent("worldBossRoomFull"));
      }
      
      public function creatEnterIcon($isUse:Boolean = true, type:int = 1, $timeStr:String = null) : void
      {
         HallIconManager.instance.updateSwitchHandler(HallIconType["WORLDBOSSENTRANCE" + _bossResourceId],true,$timeStr);
      }
      
      public function disposeEnterBtn() : void
      {
         if(_entranceBtn)
         {
            ObjectUtils.disposeObject(_entranceBtn);
         }
         _entranceBtn = null;
      }
      
      private function __enter(event:PkgEvent) : void
      {
         var count:int = 0;
         var i:int = 0;
         if(event.pkg.bytesAvailable > 0 && event.pkg.readBoolean())
         {
            _bossInfo.isLiving = !event.pkg.readBoolean();
            _bossInfo.myPlayerVO.reviveCD = event.pkg.readInt();
            count = event.pkg.readInt();
            for(i = 0; i < count; )
            {
               _bossInfo.myPlayerVO.buffID = event.pkg.readInt();
               i++;
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
      
      private function onMapSrcLoadedComplete(e:Event) : void
      {
         if(StateManager.getState("worldboss") == null)
         {
            UIModuleSmallLoading.Instance.addEventListener("close",__loadingIsCloseRoom);
         }
         StateManager.setState("worldboss");
      }
      
      private function __loadingIsCloseRoom(e:Event) : void
      {
         UIModuleSmallLoading.Instance.removeEventListener("close",__loadingIsCloseRoom);
      }
      
      private function __update(event:PkgEvent) : void
      {
         _autoBlood = event.pkg.readBoolean();
         _bossInfo.total_Blood = event.pkg.readLong();
         _bossInfo.current_Blood = event.pkg.readLong();
         dispatchEvent(new WorldBossRoomEvent("boss_hp_updata"));
      }
      
      private function __fightOver(event:PkgEvent) : void
      {
         _bossInfo.fightOver = true;
         _bossInfo.isLiving = !event.pkg.readBoolean();
         if(_entranceBtn)
         {
            _entranceBtn.setFrame(2);
         }
         dispatchEvent(new WorldBossRoomEvent("fight_over"));
      }
      
      private function __leaveRoom(e:Event) : void
      {
         _bossInfo.roomClose = true;
         if(StateManager.currentStateType == "worldboss")
         {
            StateManager.setState("main");
            dispatchEvent(new CEvent("closeView"));
         }
         dispatchEvent(new WorldBossRoomEvent("room close"));
      }
      
      private function __showRanking(evt:PkgEvent) : void
      {
         if(evt.pkg.readBoolean())
         {
            showRankingFrame(evt.pkg);
         }
         else
         {
            showRankingInRoom(evt.pkg);
         }
      }
      
      private function showRankingFrame(pkg:PackageIn) : void
      {
         var i:int = 0;
         var personInfo:* = null;
         _rankingInfos.length = 0;
         var rankingFrame:WorldBossRankingFram = ComponentFactory.Instance.creat("worldboss.ranking.frame");
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            personInfo = new RankingPersonInfo();
            personInfo.id = pkg.readInt();
            personInfo.name = pkg.readUTF();
            personInfo.damage = pkg.readInt();
            rankingFrame.addPersonRanking(personInfo);
            _rankingInfos.push(personInfo);
            i++;
         }
         if(!(CacheSysManager.isLock("alertInFight") && StateManager.currentStateType != "worldboss"))
         {
            rankingFrame.show();
         }
      }
      
      private function showRankingInRoom(pkg:PackageIn) : void
      {
         dispatchEvent(new CrazyTankSocketEvent("worldboss_ranking_inroom",pkg));
      }
      
      private function __allOver(event:PkgEvent) : void
      {
         event = event;
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
      
      public function showHallSkyEffort(sky:MovieClip) : void
      {
         if(sky == _sky)
         {
            return;
         }
         ObjectUtils.disposeObject(_sky);
         _sky = sky;
      }
      
      public function set isOpen(value:Boolean) : void
      {
         _isOpen = value;
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
         var temp:String = _bossResourceId == null?"1":_bossResourceId;
         return PathManager.SITE_MAIN + "image/worldboss/" + temp;
      }
      
      public function buyNewBuff(type:int, isBuyFull:Boolean) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var curLevel:int = bossInfo.myPlayerVO.buffLevel;
         if(curLevel >= 20)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.worldboss.buffLevelMax"));
            return;
         }
         var addInjureBuffMoney:int = WorldBossManager.Instance.bossInfo.addInjureBuffMoney;
         var needMoney:* = addInjureBuffMoney;
         if(isBuyFull)
         {
            needMoney = int((20 - curLevel) * addInjureBuffMoney);
         }
         if(type == 1)
         {
            if(PlayerManager.Instance.Self.Money < needMoney)
            {
               LeavePageManager.showFillFrame();
               return;
            }
         }
         else if(type == 2)
         {
            if(PlayerManager.Instance.Self.BandMoney < needMoney)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.transfer.StoreIITransferBG.lijinbuzu"));
               return;
            }
         }
         SocketManager.Instance.out.sendNewBuyWorldBossBuff(type,!!isBuyFull?20 - curLevel:1);
      }
      
      public function set isLoadingState(value:Boolean) : void
      {
         _isLoadingState = value;
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
      
      private function getDateHourTime(date:Date) : int
      {
         return int(date.hours * 3600 + date.minutes * 60 + date.seconds);
      }
      
      public function setSelfStatus(value:int) : void
      {
         dispatchEvent(new CEvent("setselfstatus",value));
      }
   }
}
