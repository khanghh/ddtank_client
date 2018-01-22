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
      
      public function ConsortiaBattleManager(param1:IEventDispatcher = null)
      {
         super(param1);
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
      
      private function timerHandler(param1:Event) : void
      {
         if(_buffCreatePlayerList.length <= 0)
         {
            _timer.stop();
            return;
         }
         var _loc2_:ConsortiaBattlePlayerInfo = _buffCreatePlayerList.list[0];
         _buffCreatePlayerList.remove(_loc2_.id);
         if(_playerDataList.length < 80)
         {
            _playerDataList.add(_loc2_.id,_loc2_);
         }
      }
      
      public function judgeCreatePlayer(param1:Number, param2:Number) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc5_:* = null;
         var _loc8_:Array = [];
         var _loc10_:int = 0;
         var _loc9_:* = _buffPlayerList;
         for each(var _loc4_ in _buffPlayerList)
         {
            _loc6_ = _loc4_.pos.x + param1;
            _loc7_ = _loc4_.pos.y + param2;
            if(_loc6_ > 0 && _loc6_ < 1000 && _loc7_ > 10 && _loc7_ <= 650)
            {
               _loc8_.push(_loc4_.id);
            }
         }
         var _loc12_:int = 0;
         var _loc11_:* = _loc8_;
         for each(var _loc3_ in _loc8_)
         {
            _loc5_ = _buffPlayerList[_loc3_];
            _buffPlayerList.remove(_loc3_);
            _buffCreatePlayerList.add(_loc5_.id,_loc5_);
         }
         if(_loc8_.length > 0 && !_timer.running)
         {
            _timer.start();
         }
      }
      
      public function getBuyRecordStatus(param1:int) : Object
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         if(!_buyRecordStatus)
         {
            _buyRecordStatus = [];
            _loc3_ = 0;
            while(_loc3_ < 4)
            {
               _loc2_ = {};
               _loc2_.isNoPrompt = false;
               _loc2_.isBand = false;
               _buyRecordStatus.push(_loc2_);
               _loc3_++;
            }
         }
         return _buyRecordStatus[param1];
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
      
      private function getDateHourTime(param1:Date) : int
      {
         return int(param1.hours * 3600 + param1.minutes * 60 + param1.seconds);
      }
      
      public function changeHideRecord(param1:int, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         if(param2)
         {
            if(param1 == 1)
            {
               _loc3_ = 4;
            }
            else if(param1 == 2)
            {
               _loc3_ = 2;
            }
            else
            {
               _loc3_ = 1;
            }
            _hideRecord = _hideRecord | _loc3_;
         }
         else
         {
            if(param1 == 1)
            {
               _loc3_ = 3;
            }
            else if(param1 == 2)
            {
               _loc3_ = 5;
            }
            else
            {
               _loc3_ = 6;
            }
            _hideRecord = _hideRecord & _loc3_;
         }
         dispatchEvent(new Event("consortiaBattleHideRecordChange"));
      }
      
      public function isHide(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         if(param1 == 1)
         {
            _loc2_ = 4;
         }
         else if(param1 == 2)
         {
            _loc2_ = 2;
         }
         else
         {
            _loc2_ = 1;
         }
         if((_hideRecord & _loc2_) == 0)
         {
            return false;
         }
         return true;
      }
      
      public function addEntryBtn(param1:Boolean, param2:String = null) : void
      {
         ConsortiaBattleManager.instance.addEventListener("consortiaBattleClose",closeHandler);
         if(param2 != "" && param2 != null)
         {
            HallIconManager.instance.updateSwitchHandler("consortiabattle",param1,param2);
         }
         if(ConsortiaBattleManager.instance.isLoadIconMapComplete)
         {
            HallIconManager.instance.updateSwitchHandler("consortiabattle",param1,param2);
         }
         if(!_isHadLoadRes)
         {
            loadMap();
            _isHadLoadRes = true;
         }
      }
      
      private function closeHandler(param1:Event) : void
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
      
      private function pkgHandler(param1:PkgEvent) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = _loc4_.readByte();
         switch(int(_loc2_) - 1)
         {
            case 0:
               openOrCloseHandler(_loc4_);
               break;
            case 1:
               _loc3_ = _loc4_.readBoolean();
               initSelfInfo(_loc4_);
               if(_loc3_)
               {
                  StateManager.setState("consortiaBattleScene");
               }
               break;
            case 2:
               addPlayerInfo(_loc4_);
               break;
            case 3:
               movePlayer(_loc4_);
               break;
            case 4:
               deletePlayer(_loc4_);
               break;
            default:
               deletePlayer(_loc4_);
               break;
            case 6:
               updatePlayerStatus(_loc4_);
               break;
            case 7:
               splitMergeHandler();
               break;
            case 8:
               updateSceneInfo(_loc4_);
               break;
            default:
               updateSceneInfo(_loc4_);
               break;
            default:
               updateSceneInfo(_loc4_);
               break;
            default:
               updateSceneInfo(_loc4_);
               break;
            default:
               updateSceneInfo(_loc4_);
               break;
            default:
               updateSceneInfo(_loc4_);
               break;
            default:
               updateSceneInfo(_loc4_);
               break;
            case 15:
               updateScore(_loc4_);
               break;
            default:
               updateScore(_loc4_);
               break;
            default:
               updateScore(_loc4_);
               break;
            case 18:
               broadcastHandler(_loc4_);
         }
      }
      
      private function broadcastHandler(param1:PackageIn) : void
      {
         if(!isInMainView)
         {
            return;
         }
         var _loc2_:ConsBatEvent = new ConsBatEvent("consortiaBattleBroadcast");
         _loc2_.data = param1;
         dispatchEvent(_loc2_);
      }
      
      private function splitMergeHandler() : void
      {
         if(!isInMainView)
         {
            return;
         }
         var _loc3_:int = 0;
         var _loc2_:* = _playerDataList;
         for(var _loc1_ in _playerDataList)
         {
            if(int(_loc1_) != PlayerManager.Instance.Self.ID)
            {
               _playerDataList.remove(_loc1_);
            }
         }
         _buffPlayerList = new DictionaryData();
         _buffCreatePlayerList = new DictionaryData();
         SocketManager.Instance.out.sendConsBatRequestPlayerInfo();
      }
      
      private function updateScore(param1:PackageIn) : void
      {
         if(!isInMainView)
         {
            return;
         }
         var _loc2_:ConsBatEvent = new ConsBatEvent("consortiaBattleUpdateScore");
         _loc2_.data = param1;
         dispatchEvent(_loc2_);
      }
      
      private function updateSceneInfo(param1:PackageIn) : void
      {
         _curHp = param1.readInt();
         _victoryCount = param1.readInt();
         _winningStreak = param1.readInt();
         _score = param1.readInt();
         _isPowerFullUsed = param1.readBoolean();
         _isDoubleScoreUsed = param1.readBoolean();
         var _loc2_:ConsortiaBattlePlayerInfo = _playerDataList[PlayerManager.Instance.Self.ID] as ConsortiaBattlePlayerInfo;
         if(_loc2_)
         {
            _loc2_.tombstoneEndTime = param1.readDate();
         }
         dispatchEvent(new Event("consortiaBattleUpdateSceneInfo"));
      }
      
      private function updatePlayerStatus(param1:PackageIn) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = param1.readInt();
         if(!isInMainView && _loc2_ != PlayerManager.Instance.Self.ID)
         {
            return;
         }
         if(_playerDataList[_loc2_])
         {
            _loc3_ = _playerDataList[_loc2_];
         }
         else if(_buffPlayerList[_loc2_])
         {
            _loc3_ = _buffPlayerList[_loc2_];
         }
         else
         {
            _loc3_ = _buffCreatePlayerList[_loc2_];
         }
         if(_loc3_)
         {
            _loc3_.tombstoneEndTime = param1.readDate();
            _loc3_.status = param1.readByte();
            _loc3_.pos = new Point(param1.readInt(),param1.readInt());
            _loc3_.winningStreak = param1.readInt();
            _loc3_.failBuffCount = param1.readInt();
            _loc3_.MountsType = param1.readInt();
            _loc3_.PetsID = param1.readInt();
            _loc3_.Sex = param1.readBoolean();
            _loc3_.Style = param1.readUTF();
            _loc3_.Colors = param1.readUTF();
            if(_loc3_ == _playerDataList[_loc2_])
            {
               _playerDataList.add(_loc3_.id,_loc3_);
            }
         }
      }
      
      private function deletePlayer(param1:PackageIn) : void
      {
         var _loc2_:int = param1.readInt();
         if(_loc2_ == PlayerManager.Instance.Self.ID)
         {
            StateManager.setState("main");
            return;
         }
         if(isInMainView)
         {
            _playerDataList.remove(_loc2_);
            _buffPlayerList.remove(_loc2_);
            _buffCreatePlayerList.remove(_loc2_);
         }
      }
      
      private function movePlayer(param1:PackageIn) : void
      {
         var _loc11_:* = 0;
         var _loc8_:* = null;
         var _loc7_:* = null;
         var _loc3_:* = null;
         if(!isInMainView)
         {
            return;
         }
         var _loc2_:int = param1.readInt();
         var _loc6_:int = param1.readInt();
         var _loc4_:int = param1.readInt();
         var _loc10_:String = param1.readUTF();
         if(_loc2_ == PlayerManager.Instance.Self.ID)
         {
            return;
         }
         var _loc5_:Array = _loc10_.split(",");
         var _loc9_:Array = [];
         _loc11_ = uint(0);
         while(_loc11_ < _loc5_.length)
         {
            _loc8_ = new Point(_loc5_[_loc11_],_loc5_[_loc11_ + 1]);
            _loc9_.push(_loc8_);
            _loc11_ = uint(_loc11_ + 2);
         }
         if(_playerDataList[_loc2_])
         {
            _loc7_ = new ConsBatEvent("consortiaBattleMovePlayer");
            _loc7_.data = {
               "id":_loc2_,
               "path":_loc9_
            };
            dispatchEvent(_loc7_);
         }
         else
         {
            if(_buffPlayerList[_loc2_])
            {
               _loc3_ = _buffPlayerList[_loc2_];
            }
            else
            {
               _loc3_ = _buffCreatePlayerList[_loc2_];
            }
            if(_loc3_)
            {
               _loc3_.pos = _loc9_[_loc9_.length - 1];
            }
         }
      }
      
      private function addPlayerInfo(param1:PackageIn) : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc4_:int = 0;
         if(!isInMainView)
         {
            return;
         }
         var _loc3_:int = param1.readInt();
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc2_ = new ConsortiaBattlePlayerInfo();
            _loc2_.id = param1.readInt();
            _loc2_.tombstoneEndTime = param1.readDate();
            _loc2_.status = param1.readByte();
            _loc2_.pos = new Point(param1.readInt(),param1.readInt());
            _loc2_.sex = param1.readBoolean();
            _loc4_ = param1.readInt();
            if(_loc4_ == PlayerManager.Instance.Self.ConsortiaID)
            {
               _loc2_.selfOrEnemy = 1;
            }
            else
            {
               _loc2_.selfOrEnemy = 2;
            }
            _loc2_.clothIndex = 2;
            _loc2_.consortiaName = param1.readUTF();
            _loc2_.winningStreak = param1.readInt();
            _loc2_.failBuffCount = param1.readInt();
            _loc2_.MountsType = param1.readInt();
            _loc2_.PetsID = param1.readInt();
            _loc2_.Sex = param1.readBoolean();
            _loc2_.Style = param1.readUTF();
            _loc2_.Colors = param1.readUTF();
            if(_loc2_.id != PlayerManager.Instance.Self.ID)
            {
               _buffPlayerList.add(_loc2_.id,_loc2_);
            }
            _loc5_++;
         }
      }
      
      private function initSelfInfo(param1:PackageIn) : void
      {
         var _loc2_:SelfInfo = PlayerManager.Instance.Self;
         var _loc3_:ConsortiaBattlePlayerInfo = new ConsortiaBattlePlayerInfo();
         _loc3_.id = _loc2_.ID;
         _loc3_.tombstoneEndTime = param1.readDate();
         _loc3_.pos = new Point(param1.readInt(),param1.readInt());
         _loc3_.clothIndex = 1;
         _loc3_.selfOrEnemy = 1;
         _loc3_.consortiaName = _loc2_.ConsortiaName;
         _loc3_.MountsType = _loc2_.MountsType;
         _loc3_.PetsID = _loc2_.PetsID;
         _loc3_.sex = _loc2_.Sex;
         _loc3_.Style = _loc2_.Style;
         _loc3_.Colors = _loc2_.Colors;
         _loc3_.isSelf = _loc2_.isSelf;
         _playerDataList = new DictionaryData();
         _playerDataList.add(_loc2_.ID,_loc3_);
         _curHp = param1.readInt();
         _victoryCount = param1.readInt();
         _winningStreak = param1.readInt();
         _score = param1.readInt();
         _isPowerFullUsed = param1.readBoolean();
         _isDoubleScoreUsed = param1.readBoolean();
      }
      
      public function getPlayerInfo(param1:int) : ConsortiaBattlePlayerInfo
      {
         return _playerDataList[param1];
      }
      
      public function clearPlayerInfo() : void
      {
         var _loc1_:ConsortiaBattlePlayerInfo = _playerDataList[PlayerManager.Instance.Self.ID];
         _playerDataList = new DictionaryData();
         if(_loc1_)
         {
            _playerDataList.add(_loc1_.id,_loc1_);
         }
         _buffPlayerList = new DictionaryData();
         _buffCreatePlayerList = new DictionaryData();
      }
      
      private function openOrCloseHandler(param1:PackageIn) : void
      {
         if(param1.readBoolean())
         {
            _startTime = param1.readDate();
            _endTime = param1.readDate();
            _isCanEnter = param1.readBoolean();
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
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(resourcePrUrl + "map/factionwarmap.swf",4);
         _loc1_.addEventListener("complete",onMapLoadComplete);
         LoadResourceManager.Instance.startLoad(_loc1_);
      }
      
      private function loadIcon() : void
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(resourcePrUrl + "icon/factionwaricon.swf",4);
         _loc1_.addEventListener("complete",onIconLoadComplete);
         LoadResourceManager.Instance.startLoad(_loc1_);
      }
      
      private function onIconLoadComplete(param1:LoaderEvent) : void
      {
         param1.loader.removeEventListener("complete",onIconLoadComplete);
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
      
      private function onMapLoadComplete(param1:LoaderEvent) : void
      {
         param1.loader.removeEventListener("complete",onMapLoadComplete);
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
      
      public function createLoader(param1:String) : BitmapLoader
      {
         var _loc2_:BitmapLoader = LoadResourceManager.Instance.createLoader(param1,0);
         return _loc2_;
      }
   }
}
