package consortionBattle
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.BitmapLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.utils.ObjectUtils;
   import consortionBattle.event.ConsBatEvent;
   import consortionBattle.player.ConsortiaBattlePlayerInfo;
   import consortionBattle.view.ConsortiaBattleEntryBtn;
   import ddt.data.player.SelfInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddtActivityIcon.DdtActivityIconManager;
   import ddtActivityIcon.DdtIconTxt;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class ConsortiaBattleManager extends EventDispatcher
   {
      
      public static const ICON_AND_MAP_LOAD_COMPLETE:String = "consBatIconMapComplete";
      
      public static const CLOSE:String = "consortiaBattleClose";
      
      public static const MOVE_PLAYER:String = "consortiaBattleMovePlayer";
      
      public static const UPDATE_SCENE_INFO:String = "consortiaBattleUpdateSceneInfo";
      
      public static const HIDE_RECORD_CHANGE:String = "consortiaBattleHideRecordChange";
      
      public static const UPDATE_SCORE:String = "consortiaBattleUpdateScore";
      
      public static const BROADCAST:String = "consortiaBattleBroadcast";
      
      private static var _instance:ConsortiaBattleManager;
       
      
      public const resourcePrUrl:String = PathManager.SITE_MAIN + "image/factionwar/";
      
      public var isAutoPowerFull:Boolean = false;
      
      private var _entryBtn:ConsortiaBattleEntryBtn;
      
      private var _isOpen:Boolean = false;
      
      private var _isLoadIconComplete:Boolean = false;
      
      private var _isLoadMapComplete:Boolean = false;
      
      private var _playerDataList:DictionaryData;
      
      private var _buffPlayerList:DictionaryData;
      
      private var _buffCreatePlayerList:DictionaryData;
      
      private var _timer:TimerJuggler;
      
      public var isInMainView:Boolean = false;
      
      private var _startTime:Date;
      
      private var _endTime:Date;
      
      private var _isPowerFullUsed:Boolean = true;
      
      private var _isDoubleScoreUsed:Boolean = true;
      
      private var _victoryCount:int;
      
      private var _winningStreak:int;
      
      private var _score:int;
      
      private var _curHp:int;
      
      private var _hideRecord:int = 0;
      
      private var _buyRecordStatus:Array;
      
      private var _isCanEnter:Boolean;
      
      private var _activityTxt:DdtIconTxt;
      
      private var _isHadLoadRes:Boolean = false;
      
      private var _isHadShowOpenTip:Boolean = false;
      
      public function ConsortiaBattleManager(target:IEventDispatcher = null)
      {
         super(target);
         _playerDataList = new DictionaryData();
         _buffPlayerList = new DictionaryData();
         _buffCreatePlayerList = new DictionaryData();
         _timer = TimerManager.getInstance().addTimerJuggler(500);
         _timer.addEventListener("timer",timerHandler,false,0,true);
      }
      
      public static function get instance() : ConsortiaBattleManager
      {
         if(_instance == null)
         {
            _instance = new ConsortiaBattleManager();
         }
         return _instance;
      }
      
      public function get playerDataList() : DictionaryData
      {
         return _playerDataList;
      }
      
      public function get isPowerFullUsed() : Boolean
      {
         return _isPowerFullUsed;
      }
      
      public function get isDoubleScoreUsed() : Boolean
      {
         return _isDoubleScoreUsed;
      }
      
      public function get victoryCount() : int
      {
         return _victoryCount;
      }
      
      public function get winningStreak() : int
      {
         return _winningStreak;
      }
      
      public function get score() : int
      {
         return _score;
      }
      
      public function get curHp() : int
      {
         return _curHp;
      }
      
      public function get isCanEnter() : Boolean
      {
         return _isCanEnter;
      }
      
      private function timerHandler(event:Event) : void
      {
         if(_buffCreatePlayerList.length <= 0)
         {
            _timer.stop();
            return;
         }
         var tmpData:ConsortiaBattlePlayerInfo = _buffCreatePlayerList.list[0];
         _buffCreatePlayerList.remove(tmpData.id);
         if(_playerDataList.length < 80)
         {
            _playerDataList.add(tmpData.id,tmpData);
         }
      }
      
      public function judgeCreatePlayer(posX:Number, posY:Number) : void
      {
         var playerPosX:Number = NaN;
         var playerPosY:Number = NaN;
         var tmpData:* = null;
         var deleteIdList:Array = [];
         var _loc10_:int = 0;
         var _loc9_:* = _buffPlayerList;
         for each(var tmpPlayerData in _buffPlayerList)
         {
            playerPosX = tmpPlayerData.pos.x + posX;
            playerPosY = tmpPlayerData.pos.y + posY;
            if(playerPosX > 0 && playerPosX < 1000 && playerPosY > 10 && playerPosY <= 650)
            {
               deleteIdList.push(tmpPlayerData.id);
            }
         }
         var _loc12_:int = 0;
         var _loc11_:* = deleteIdList;
         for each(var id in deleteIdList)
         {
            tmpData = _buffPlayerList[id];
            _buffPlayerList.remove(id);
            _buffCreatePlayerList.add(tmpData.id,tmpData);
         }
         if(deleteIdList.length > 0 && !_timer.running)
         {
            _timer.start();
         }
      }
      
      public function getBuyRecordStatus(index:int) : Object
      {
         var i:int = 0;
         var obj:* = null;
         if(!_buyRecordStatus)
         {
            _buyRecordStatus = [];
            for(i = 0; i < 4; )
            {
               obj = {};
               obj.isNoPrompt = false;
               obj.isBand = false;
               _buyRecordStatus.push(obj);
               i++;
            }
         }
         return _buyRecordStatus[index];
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function get isLoadIconMapComplete() : Boolean
      {
         return _isLoadIconComplete && _isLoadMapComplete;
      }
      
      public function get beforeStartTime() : int
      {
         if(!_startTime)
         {
            return 0;
         }
         return getDateHourTime(_startTime) - getDateHourTime(TimeManager.Instance.Now());
      }
      
      public function get toEndTime() : int
      {
         if(!_endTime)
         {
            return 0;
         }
         return getDateHourTime(_endTime) - getDateHourTime(TimeManager.Instance.Now());
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(153),pkgHandler);
      }
      
      private function getDateHourTime(date:Date) : int
      {
         return int(date.hours * 3600 + date.minutes * 60 + date.seconds);
      }
      
      public function changeHideRecord(index:int, isHide:Boolean) : void
      {
         var tmp:int = 0;
         if(isHide)
         {
            if(index == 1)
            {
               tmp = 4;
            }
            else if(index == 2)
            {
               tmp = 2;
            }
            else
            {
               tmp = 1;
            }
            _hideRecord = _hideRecord | tmp;
         }
         else
         {
            if(index == 1)
            {
               tmp = 3;
            }
            else if(index == 2)
            {
               tmp = 5;
            }
            else
            {
               tmp = 6;
            }
            _hideRecord = _hideRecord & tmp;
         }
         dispatchEvent(new Event("consortiaBattleHideRecordChange"));
      }
      
      public function isHide(index:int) : Boolean
      {
         var tmp:int = 0;
         if(index == 1)
         {
            tmp = 4;
         }
         else if(index == 2)
         {
            tmp = 2;
         }
         else
         {
            tmp = 1;
         }
         if((_hideRecord & tmp) == 0)
         {
            return false;
         }
         return true;
      }
      
      public function addEntryBtn($isOpen:Boolean, $timeStr:String = null) : void
      {
         ConsortiaBattleManager.instance.addEventListener("consortiaBattleClose",closeHandler);
         if($timeStr != "" && $timeStr != null)
         {
            HallIconManager.instance.updateSwitchHandler("consortiabattle",$isOpen,$timeStr);
         }
         if(ConsortiaBattleManager.instance.isLoadIconMapComplete)
         {
            HallIconManager.instance.updateSwitchHandler("consortiabattle",$isOpen,$timeStr);
         }
         if(!_isHadLoadRes)
         {
            loadMap();
            _isHadLoadRes = true;
         }
      }
      
      private function closeHandler(event:Event) : void
      {
         HallIconManager.instance.updateSwitchHandler("consortiabattle",false);
      }
      
      public function disposeEntryBtn() : void
      {
         ObjectUtils.disposeObject(_entryBtn);
         _entryBtn = null;
         if(_activityTxt)
         {
            _activityTxt.resetTxt();
         }
      }
      
      private function pkgHandler(event:PkgEvent) : void
      {
         var tmpIsJump:Boolean = false;
         var pkg:PackageIn = event.pkg;
         var cmd:int = pkg.readByte();
         switch(int(cmd) - 1)
         {
            case 0:
               openOrCloseHandler(pkg);
               break;
            case 1:
               tmpIsJump = pkg.readBoolean();
               initSelfInfo(pkg);
               if(tmpIsJump)
               {
                  StateManager.setState("consortiaBattleScene");
               }
               break;
            case 2:
               addPlayerInfo(pkg);
               break;
            case 3:
               movePlayer(pkg);
               break;
            case 4:
               deletePlayer(pkg);
               break;
            default:
               deletePlayer(pkg);
               break;
            case 6:
               updatePlayerStatus(pkg);
               break;
            case 7:
               splitMergeHandler();
               break;
            case 8:
               updateSceneInfo(pkg);
               break;
            default:
               updateSceneInfo(pkg);
               break;
            default:
               updateSceneInfo(pkg);
               break;
            default:
               updateSceneInfo(pkg);
               break;
            default:
               updateSceneInfo(pkg);
               break;
            default:
               updateSceneInfo(pkg);
               break;
            default:
               updateSceneInfo(pkg);
               break;
            case 15:
               updateScore(pkg);
               break;
            default:
               updateScore(pkg);
               break;
            default:
               updateScore(pkg);
               break;
            case 18:
               broadcastHandler(pkg);
         }
      }
      
      private function broadcastHandler(pkg:PackageIn) : void
      {
         if(!isInMainView)
         {
            return;
         }
         var tmp:ConsBatEvent = new ConsBatEvent("consortiaBattleBroadcast");
         tmp.data = pkg;
         dispatchEvent(tmp);
      }
      
      private function splitMergeHandler() : void
      {
         if(!isInMainView)
         {
            return;
         }
         var _loc3_:int = 0;
         var _loc2_:* = _playerDataList;
         for(var key in _playerDataList)
         {
            if(int(key) != PlayerManager.Instance.Self.ID)
            {
               _playerDataList.remove(key);
            }
         }
         _buffPlayerList = new DictionaryData();
         _buffCreatePlayerList = new DictionaryData();
         SocketManager.Instance.out.sendConsBatRequestPlayerInfo();
      }
      
      private function updateScore(pkg:PackageIn) : void
      {
         if(!isInMainView)
         {
            return;
         }
         var tmp:ConsBatEvent = new ConsBatEvent("consortiaBattleUpdateScore");
         tmp.data = pkg;
         dispatchEvent(tmp);
      }
      
      private function updateSceneInfo(pkg:PackageIn) : void
      {
         _curHp = pkg.readInt();
         _victoryCount = pkg.readInt();
         _winningStreak = pkg.readInt();
         _score = pkg.readInt();
         _isPowerFullUsed = pkg.readBoolean();
         _isDoubleScoreUsed = pkg.readBoolean();
         var tmp:ConsortiaBattlePlayerInfo = _playerDataList[PlayerManager.Instance.Self.ID] as ConsortiaBattlePlayerInfo;
         if(tmp)
         {
            tmp.tombstoneEndTime = pkg.readDate();
         }
         dispatchEvent(new Event("consortiaBattleUpdateSceneInfo"));
      }
      
      private function updatePlayerStatus(pkg:PackageIn) : void
      {
         var tmpData:* = null;
         var id:int = pkg.readInt();
         if(!isInMainView && id != PlayerManager.Instance.Self.ID)
         {
            return;
         }
         if(_playerDataList[id])
         {
            tmpData = _playerDataList[id];
         }
         else if(_buffPlayerList[id])
         {
            tmpData = _buffPlayerList[id];
         }
         else
         {
            tmpData = _buffCreatePlayerList[id];
         }
         if(tmpData)
         {
            tmpData.tombstoneEndTime = pkg.readDate();
            tmpData.status = pkg.readByte();
            tmpData.pos = new Point(pkg.readInt(),pkg.readInt());
            tmpData.winningStreak = pkg.readInt();
            tmpData.failBuffCount = pkg.readInt();
            tmpData.MountsType = pkg.readInt();
            tmpData.PetsID = pkg.readInt();
            tmpData.Sex = pkg.readBoolean();
            tmpData.Style = pkg.readUTF();
            tmpData.Colors = pkg.readUTF();
            if(tmpData == _playerDataList[id])
            {
               _playerDataList.add(tmpData.id,tmpData);
            }
         }
      }
      
      private function deletePlayer(pkg:PackageIn) : void
      {
         var id:int = pkg.readInt();
         if(id == PlayerManager.Instance.Self.ID)
         {
            StateManager.setState("main");
            return;
         }
         if(isInMainView)
         {
            _playerDataList.remove(id);
            _buffPlayerList.remove(id);
            _buffCreatePlayerList.remove(id);
         }
      }
      
      private function movePlayer(pkg:PackageIn) : void
      {
         var i:* = 0;
         var p:* = null;
         var event:* = null;
         var tmpData:* = null;
         if(!isInMainView)
         {
            return;
         }
         var id:int = pkg.readInt();
         var posX:int = pkg.readInt();
         var posY:int = pkg.readInt();
         var pathStr:String = pkg.readUTF();
         if(id == PlayerManager.Instance.Self.ID)
         {
            return;
         }
         var arr:Array = pathStr.split(",");
         var path:Array = [];
         for(i = uint(0); i < arr.length; )
         {
            p = new Point(arr[i],arr[i + 1]);
            path.push(p);
            i = uint(i + 2);
         }
         if(_playerDataList[id])
         {
            event = new ConsBatEvent("consortiaBattleMovePlayer");
            event.data = {
               "id":id,
               "path":path
            };
            dispatchEvent(event);
         }
         else
         {
            if(_buffPlayerList[id])
            {
               tmpData = _buffPlayerList[id];
            }
            else
            {
               tmpData = _buffCreatePlayerList[id];
            }
            if(tmpData)
            {
               tmpData.pos = path[path.length - 1];
            }
         }
      }
      
      private function addPlayerInfo(pkg:PackageIn) : void
      {
         var i:int = 0;
         var tmpData:* = null;
         var tmpConsId:int = 0;
         if(!isInMainView)
         {
            return;
         }
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            tmpData = new ConsortiaBattlePlayerInfo();
            tmpData.id = pkg.readInt();
            tmpData.tombstoneEndTime = pkg.readDate();
            tmpData.status = pkg.readByte();
            tmpData.pos = new Point(pkg.readInt(),pkg.readInt());
            tmpData.sex = pkg.readBoolean();
            tmpConsId = pkg.readInt();
            if(tmpConsId == PlayerManager.Instance.Self.ConsortiaID)
            {
               tmpData.selfOrEnemy = 1;
            }
            else
            {
               tmpData.selfOrEnemy = 2;
            }
            tmpData.clothIndex = 2;
            tmpData.consortiaName = pkg.readUTF();
            tmpData.winningStreak = pkg.readInt();
            tmpData.failBuffCount = pkg.readInt();
            tmpData.MountsType = pkg.readInt();
            tmpData.PetsID = pkg.readInt();
            tmpData.Sex = pkg.readBoolean();
            tmpData.Style = pkg.readUTF();
            tmpData.Colors = pkg.readUTF();
            if(tmpData.id != PlayerManager.Instance.Self.ID)
            {
               _buffPlayerList.add(tmpData.id,tmpData);
            }
            i++;
         }
      }
      
      private function initSelfInfo(pkg:PackageIn) : void
      {
         var self:SelfInfo = PlayerManager.Instance.Self;
         var tmpSelfData:ConsortiaBattlePlayerInfo = new ConsortiaBattlePlayerInfo();
         tmpSelfData.id = self.ID;
         tmpSelfData.tombstoneEndTime = pkg.readDate();
         tmpSelfData.pos = new Point(pkg.readInt(),pkg.readInt());
         tmpSelfData.clothIndex = 1;
         tmpSelfData.selfOrEnemy = 1;
         tmpSelfData.consortiaName = self.ConsortiaName;
         tmpSelfData.MountsType = self.MountsType;
         tmpSelfData.PetsID = self.PetsID;
         tmpSelfData.sex = self.Sex;
         tmpSelfData.Style = self.Style;
         tmpSelfData.Colors = self.Colors;
         tmpSelfData.isSelf = self.isSelf;
         _playerDataList = new DictionaryData();
         _playerDataList.add(self.ID,tmpSelfData);
         _curHp = pkg.readInt();
         _victoryCount = pkg.readInt();
         _winningStreak = pkg.readInt();
         _score = pkg.readInt();
         _isPowerFullUsed = pkg.readBoolean();
         _isDoubleScoreUsed = pkg.readBoolean();
      }
      
      public function getPlayerInfo(id:int) : ConsortiaBattlePlayerInfo
      {
         return _playerDataList[id];
      }
      
      public function clearPlayerInfo() : void
      {
         var tmp:ConsortiaBattlePlayerInfo = _playerDataList[PlayerManager.Instance.Self.ID];
         _playerDataList = new DictionaryData();
         if(tmp)
         {
            _playerDataList.add(tmp.id,tmp);
         }
         _buffPlayerList = new DictionaryData();
         _buffCreatePlayerList = new DictionaryData();
      }
      
      private function openOrCloseHandler(pkg:PackageIn) : void
      {
         if(pkg.readBoolean())
         {
            _startTime = pkg.readDate();
            _endTime = pkg.readDate();
            _isCanEnter = pkg.readBoolean();
            open();
         }
         else
         {
            _isOpen = false;
            _startTime = null;
            _endTime = null;
            _isCanEnter = false;
            _isHadShowOpenTip = false;
            dispatchEvent(new Event("consortiaBattleClose"));
            DdtActivityIconManager.Instance.currObj = null;
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortiaBattle.closePromptTxt"),0,true);
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("ddt.consortiaBattle.closePromptTxt"));
         }
      }
      
      private function open() : void
      {
         _isOpen = true;
         _isLoadMapComplete = false;
         _isLoadIconComplete = false;
         if(_isCanEnter)
         {
            loadMap();
         }
         else
         {
            _isLoadMapComplete = true;
         }
         loadIcon();
      }
      
      private function loadMap() : void
      {
         var mapLoader:BaseLoader = LoadResourceManager.Instance.createLoader(resourcePrUrl + "map/factionwarmap.swf",4);
         mapLoader.addEventListener("complete",onMapLoadComplete);
         LoadResourceManager.Instance.startLoad(mapLoader);
      }
      
      private function loadIcon() : void
      {
         var iconLoader:BaseLoader = LoadResourceManager.Instance.createLoader(resourcePrUrl + "icon/factionwaricon.swf",4);
         iconLoader.addEventListener("complete",onIconLoadComplete);
         LoadResourceManager.Instance.startLoad(iconLoader);
      }
      
      private function onIconLoadComplete(event:LoaderEvent) : void
      {
         event.loader.removeEventListener("complete",onIconLoadComplete);
         _isLoadIconComplete = true;
         if(isLoadIconMapComplete)
         {
            dispatchEvent(new Event("consBatIconMapComplete"));
            if(!_isHadShowOpenTip)
            {
               ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("ddt.consortiaBattle.openPromptTxt"));
               _isHadShowOpenTip = true;
            }
         }
      }
      
      private function onMapLoadComplete(event:LoaderEvent) : void
      {
         event.loader.removeEventListener("complete",onMapLoadComplete);
         _isLoadMapComplete = true;
         if(isLoadIconMapComplete)
         {
            dispatchEvent(new Event("consBatIconMapComplete"));
            if(!_isHadShowOpenTip)
            {
               ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("ddt.consortiaBattle.openPromptTxt"));
               _isHadShowOpenTip = true;
            }
         }
      }
      
      public function createLoader(url:String) : BitmapLoader
      {
         var bl:BitmapLoader = LoadResourceManager.Instance.createLoader(url,0);
         return bl;
      }
   }
}
