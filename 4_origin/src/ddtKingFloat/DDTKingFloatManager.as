package ddtKingFloat
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.CoreManager;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelperUIModuleLoad;
   import ddtKingFloat.data.DDTKingFloatCarInfo;
   import ddtKingFloat.data.DDTKingFloatInfoVo;
   import ddtKingFloat.data.DDTKingFloatPlayerInfo;
   import ddtKingFloat.player.DDTKingFloatGamePlayer;
   import ddtKingFloat.views.DDTKingFloatFrame;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import road7th.comm.PackageIn;
   import road7th.utils.DateUtils;
   
   public class DDTKingFloatManager extends CoreManager
   {
      
      public static const ICON_RES_LOAD_COMPLETE:String = "floatParadeIconResLoadComplete";
      
      public static const CAR_STATUS_CHANGE:String = "floatParadeCarStatusChange";
      
      public static const START_GAME:String = "floatParadeStartGame";
      
      public static const ENTER_GAME:String = "floatParadeEnterGame";
      
      public static const ALL_READY:String = "floatParadeAllReady";
      
      public static const MOVE:String = "floatParadeMove";
      
      public static const REFRESH_ITEM:String = "floatParadeAppearItem";
      
      public static const REFRESH_BUFF:String = "floatParadeRefreshBuff";
      
      public static const USE_SKILL:String = "floatParadeUseSkill";
      
      public static const RANK_LIST:String = "floatParadeRankList";
      
      public static const RANK_ARRIVE_LIST:String = "";
      
      public static const ARRIVE:String = "floatParadeArrive";
      
      public static const DESTROY:String = "floatParadeDestroy";
      
      public static const RE_ENTER_ALL_INFO:String = "floatParadeReEnterAllInfo";
      
      public static const CAN_ENTER:String = "floatParadeCanEnter";
      
      public static const FIGHT_STATE_CHANGE:String = "floatParadeFightStateChange";
      
      public static const LEAP_PROMPT_SHOW_HIDE:String = "floatParadeLeapPromptShowHide";
      
      public static const END:String = "floatParadeEnd";
      
      public static const REFRESH_ENTER_COUNT:String = "floatParadeRefreshEnterCount";
      
      public static const REFRESH_ITEM_FREE_COUNT:String = "floatParadeRefreshItemCount";
      
      public static const CANCEL_GAME:String = "floatParadeCancelGame";
      
      public static const LAUNCH_MISSILE:String = "launchMissile";
      
      private static var _instance:DDTKingFloatManager;
       
      
      private var _dataInfo:DDTKingFloatInfoVo;
      
      public var isShowDungeonTip:Boolean = true;
      
      private var _isStart:Boolean;
      
      private var _isInGame:Boolean;
      
      private var _carStatus:int;
      
      private var _freeCount:int;
      
      private var _usableCount:int;
      
      private var _rankAddInfo:Array;
      
      private var _playerList:Vector.<DDTKingFloatPlayerInfo>;
      
      private var _accelerateRate:int;
      
      private var _decelerateRate:int;
      
      private var _buyRecordStatus:Array;
      
      private var _startGameNeedMoney:int;
      
      private var _doubleTimeArray:Array;
      
      private var _timer:Timer;
      
      private var _itemFreeCountList:Array;
      
      private var _sprintAwardInfo:Array;
      
      public var missileArgArr:Array;
      
      public var selfPlayer:DDTKingFloatGamePlayer;
      
      private var _isPromptDoubleTime:Boolean = false;
      
      public function DDTKingFloatManager()
      {
         _doubleTimeArray = [];
         _itemFreeCountList = [0,0,0,0];
         super();
      }
      
      public static function get instance() : DDTKingFloatManager
      {
         if(!_instance)
         {
            _instance = new DDTKingFloatManager();
         }
         return _instance;
      }
      
      public function get dataInfo() : DDTKingFloatInfoVo
      {
         return _dataInfo;
      }
      
      public function set dataInfo(param1:DDTKingFloatInfoVo) : void
      {
         _dataInfo = param1;
      }
      
      public function get sprintAwardInfo() : Array
      {
         return _sprintAwardInfo;
      }
      
      public function get itemFreeCountList() : Array
      {
         return _itemFreeCountList;
      }
      
      public function get isInDoubleTime() : Boolean
      {
         var _loc3_:Date = TimeManager.Instance.Now();
         var _loc2_:Number = _loc3_.hours;
         var _loc5_:Number = _loc3_.minutes;
         var _loc7_:int = _doubleTimeArray[0];
         var _loc1_:int = _doubleTimeArray[1];
         var _loc11_:int = _doubleTimeArray[2];
         var _loc9_:int = _doubleTimeArray[3];
         var _loc8_:int = _doubleTimeArray[4];
         var _loc6_:int = _doubleTimeArray[5];
         var _loc10_:int = _doubleTimeArray[6];
         var _loc4_:int = _doubleTimeArray[7];
         if((_loc2_ > _loc7_ || _loc2_ == _loc7_ && _loc5_ >= _loc1_) && (_loc2_ < _loc11_ || _loc2_ == _loc11_ && _loc5_ < _loc9_) || (_loc2_ > _loc8_ || _loc2_ == _loc8_ && _loc5_ >= _loc6_) && (_loc2_ < _loc10_ || _loc2_ == _loc10_ && _loc5_ < _loc4_))
         {
            return true;
         }
         return false;
      }
      
      public function get startGameNeedMoney() : int
      {
         return _startGameNeedMoney;
      }
      
      public function getBuyRecordStatus(param1:int) : Object
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         if(!_buyRecordStatus)
         {
            _buyRecordStatus = [];
            _loc3_ = 0;
            while(_loc3_ < 6)
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
      
      public function get rankAddInfo() : Array
      {
         return _rankAddInfo;
      }
      
      public function get decelerateRate() : int
      {
         return _decelerateRate;
      }
      
      public function get accelerateRate() : int
      {
         return _accelerateRate;
      }
      
      public function get playerList() : Vector.<DDTKingFloatPlayerInfo>
      {
         return _playerList;
      }
      
      public function get usableCount() : int
      {
         return _usableCount;
      }
      
      public function get freeCount() : int
      {
         return _freeCount;
      }
      
      public function get carStatus() : int
      {
         return _carStatus;
      }
      
      public function get isInGame() : Boolean
      {
         return _isInGame;
      }
      
      public function get isStart() : Boolean
      {
         return _isStart;
      }
      
      public function setup() : void
      {
         DDTKingFloatIconManager.instance.addEventListener("floatparadeOpenView",__onOpenView);
         DDTKingFloatIconManager.instance.addEventListener("floatparadepkg",__onSocketMessage);
      }
      
      private function __onOpenView(param1:DDTKingFloatEvent) : void
      {
         if(param1.savePkg != null)
         {
            pkgHandler(param1.savePkg);
         }
         new HelperUIModuleLoad().loadUIModule(["ddtKingFloatframe"],loadComplete);
      }
      
      private function loadComplete() : void
      {
         if(DDTKingFloatManager.instance.isInGame)
         {
            SocketManager.Instance.out.sendEscortCanEnter();
         }
         else
         {
            showDDTKingFloatFrame();
         }
      }
      
      public function enterGame() : void
      {
         var _loc1_:Array = ["ddtKingFloatgame","ddtroom"];
         new HelperUIModuleLoad().loadUIModule(_loc1_,loadGameComplete);
      }
      
      private function loadGameComplete() : void
      {
         StateManager.setState("ddtKingFloat");
      }
      
      private function __onSocketMessage(param1:DDTKingFloatEvent) : void
      {
         pkgHandler(param1.savePkg);
      }
      
      private function pkgHandler(param1:PackageIn) : void
      {
         var _loc3_:* = param1;
         var _loc2_:int = _loc3_.readByte();
         var _loc4_:* = _loc2_;
         if(1 !== _loc4_)
         {
            if(3 !== _loc4_)
            {
               if(6 !== _loc4_)
               {
                  if(8 !== _loc4_)
                  {
                     if(16 !== _loc4_)
                     {
                        if(17 !== _loc4_)
                        {
                           if(19 !== _loc4_)
                           {
                              if(20 !== _loc4_)
                              {
                                 if(21 !== _loc4_)
                                 {
                                    if(24 !== _loc4_)
                                    {
                                       if(23 !== _loc4_)
                                       {
                                          if(22 !== _loc4_)
                                          {
                                             if(34 !== _loc4_)
                                             {
                                                if(35 !== _loc4_)
                                                {
                                                   if(36 !== _loc4_)
                                                   {
                                                      if(39 !== _loc4_)
                                                      {
                                                         if(40 !== _loc4_)
                                                         {
                                                            if(7 !== _loc4_)
                                                            {
                                                               if(43 === _loc4_)
                                                               {
                                                                  playLaunchMissileMC(_loc3_);
                                                               }
                                                            }
                                                            else
                                                            {
                                                               dispatchEvent(new Event("floatParadeCancelGame"));
                                                            }
                                                         }
                                                         else
                                                         {
                                                            refreshItemFreeCountHandler(_loc3_);
                                                         }
                                                      }
                                                      else
                                                      {
                                                         refreshEnterCountHandler(_loc3_);
                                                      }
                                                   }
                                                   else
                                                   {
                                                      refreshFightStateHandler(_loc3_);
                                                   }
                                                }
                                                else
                                                {
                                                   canEnterHandler(_loc3_);
                                                }
                                             }
                                             else
                                             {
                                                SocketManager.Instance.out.sendUpdateSysDate();
                                                reEnterAllInfoHandler(_loc3_);
                                             }
                                          }
                                          else
                                          {
                                             destroyHandler(_loc3_);
                                          }
                                       }
                                       else
                                       {
                                          arriveHandler(_loc3_);
                                       }
                                    }
                                    else
                                    {
                                       rankListHandler(_loc3_);
                                    }
                                 }
                                 else
                                 {
                                    useSkillHandler(_loc3_);
                                 }
                              }
                              else
                              {
                                 refreshBuffHandler(_loc3_);
                              }
                           }
                           else
                           {
                              refreshItemHandler(_loc3_);
                           }
                        }
                        else
                        {
                           moveHandler(_loc3_);
                        }
                     }
                     else
                     {
                        allReadyHandler(_loc3_);
                     }
                  }
                  else
                  {
                     SocketManager.Instance.out.sendUpdateSysDate();
                     enterGameHandler(_loc3_);
                  }
               }
               else
               {
                  startGameHandler(_loc3_);
               }
            }
            else
            {
               changeCarStatus(_loc3_);
            }
         }
         else
         {
            openOrCloseHandler(_loc3_);
         }
      }
      
      private function playLaunchMissileMC(param1:PackageIn) : void
      {
         var _loc3_:int = param1.readInt();
         var _loc4_:int = param1.readInt();
         var _loc2_:DDTKingFloatEvent = new DDTKingFloatEvent("launchMissile");
         _loc2_.data = {
            "id":_loc3_,
            "zoneId":_loc4_
         };
         dispatchEvent(_loc2_);
      }
      
      private function refreshItemFreeCountHandler(param1:PackageIn) : void
      {
         _itemFreeCountList[0] = param1.readInt();
         _itemFreeCountList[1] = param1.readInt();
         _itemFreeCountList[2] = param1.readInt();
         _itemFreeCountList[3] = param1.readInt();
         dispatchEvent(new Event("floatParadeRefreshItemCount"));
      }
      
      private function refreshEnterCountHandler(param1:PackageIn) : void
      {
         _freeCount = param1.readInt();
         _usableCount = param1.readInt();
         dispatchEvent(new Event("floatParadeRefreshEnterCount"));
      }
      
      private function refreshFightStateHandler(param1:PackageIn) : void
      {
         var _loc2_:int = param1.readInt();
         var _loc6_:int = param1.readInt();
         var _loc4_:int = param1.readInt();
         var _loc3_:int = param1.readInt();
         var _loc5_:DDTKingFloatEvent = new DDTKingFloatEvent("floatParadeFightStateChange");
         _loc5_.data = {
            "id":_loc2_,
            "zoneId":_loc6_,
            "fightState":_loc4_,
            "posX":_loc3_
         };
         dispatchEvent(_loc5_);
      }
      
      private function canEnterHandler(param1:PackageIn) : void
      {
         _isInGame = param1.readBoolean();
         if(_isInGame)
         {
            enterGame();
         }
         else
         {
            showDDTKingFloatFrame();
         }
      }
      
      private function showDDTKingFloatFrame() : void
      {
         var _loc1_:DDTKingFloatFrame = ComponentFactory.Instance.creatComponentByStylename("ddtking.race.ddtkingFrame");
         LayerManager.Instance.addToLayer(_loc1_,3,true,1);
      }
      
      private function reEnterAllInfoHandler(param1:PackageIn) : void
      {
         var _loc7_:int = 0;
         var _loc5_:* = null;
         var _loc6_:Date = param1.readDate();
         _playerList = new Vector.<DDTKingFloatPlayerInfo>();
         var _loc3_:int = param1.readInt();
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            _loc5_ = new DDTKingFloatPlayerInfo();
            _loc5_.index = _loc7_;
            _loc5_.id = param1.readInt();
            _loc5_.zoneId = param1.readInt();
            _loc5_.name = param1.readUTF();
            _loc5_.level = param1.readInt();
            _loc5_.vipType = param1.readInt();
            _loc5_.vipLevel = param1.readInt();
            _loc5_.carType = param1.readInt();
            _loc5_.posX = param1.readInt();
            _loc5_.fightState = param1.readInt();
            _loc5_.acceleEndTime = param1.readDate();
            _loc5_.deceleEndTime = param1.readDate();
            _loc5_.invisiEndTime = param1.readDate();
            _loc5_.missileEndTime = param1.readDate();
            _loc5_.missileHitEndTime = new Date(TimeManager.Instance.Now().getTime() + 1000);
            if(_loc5_.zoneId == PlayerManager.Instance.Self.ZoneID && _loc5_.id == PlayerManager.Instance.Self.ID)
            {
               _loc5_.isSelf = true;
            }
            else
            {
               _loc5_.isSelf = false;
            }
            _playerList.push(_loc5_);
            _loc7_++;
         }
         dispatchEvent(new Event("floatParadeReEnterAllInfo"));
         refreshItemHandler(param1);
         rankListHandler(param1);
         var _loc2_:Date = param1.readDate();
         var _loc4_:DDTKingFloatEvent = new DDTKingFloatEvent("floatParadeAllReady");
         _loc4_.data = {
            "endTime":_loc6_,
            "isShowStartCountDown":false,
            "sprintEndTime":_loc2_
         };
         dispatchEvent(_loc4_);
      }
      
      private function destroyHandler(param1:PackageIn) : void
      {
         _isInGame = false;
         _carStatus = 0;
         dispatchEvent(new DDTKingFloatEvent("floatParadeDestroy"));
      }
      
      private function arriveHandler(param1:PackageIn) : void
      {
         var _loc2_:int = param1.readInt();
         var _loc4_:int = param1.readInt();
         if(_loc4_ == PlayerManager.Instance.Self.ZoneID && _loc2_ == PlayerManager.Instance.Self.ID)
         {
            _isInGame = false;
            _carStatus = 0;
         }
         var _loc3_:DDTKingFloatEvent = new DDTKingFloatEvent("floatParadeArrive");
         _loc3_.data = {
            "id":_loc2_,
            "zoneId":_loc4_
         };
         dispatchEvent(_loc3_);
      }
      
      private function rankListHandler(param1:PackageIn) : void
      {
         var _loc10_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:* = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc9_:int = 0;
         var _loc6_:int = param1.readInt();
         var _loc5_:Array = [];
         _loc10_ = 0;
         while(_loc10_ < _loc6_)
         {
            _loc4_ = param1.readInt();
            _loc7_ = param1.readUTF();
            _loc3_ = param1.readInt();
            _loc2_ = param1.readInt();
            _loc9_ = param1.readInt();
            param1.readBoolean();
            _loc5_.push({
               "rank":_loc4_,
               "name":_loc7_,
               "carType":_loc3_,
               "id":_loc2_,
               "zoneId":_loc9_
            });
            _loc10_++;
         }
         _loc5_.sortOn("rank",16);
         var _loc8_:DDTKingFloatEvent = new DDTKingFloatEvent("");
         _loc8_.data = _loc5_;
         dispatchEvent(_loc8_);
      }
      
      private function useSkillHandler(param1:PackageIn) : void
      {
         var _loc2_:int = param1.readInt();
         var _loc5_:int = param1.readInt();
         var _loc3_:int = param1.readInt();
         trace("leapX=====" + _loc3_);
         var _loc4_:DDTKingFloatEvent = new DDTKingFloatEvent("floatParadeUseSkill");
         _loc4_.data = {
            "id":_loc2_,
            "zoneId":_loc5_,
            "leapX":_loc3_,
            "sound":true
         };
         dispatchEvent(_loc4_);
      }
      
      private function refreshBuffHandler(param1:PackageIn) : void
      {
         var _loc2_:int = param1.readInt();
         var _loc8_:int = param1.readInt();
         var _loc6_:Date = param1.readDate();
         var _loc4_:Date = param1.readDate();
         var _loc7_:Date = param1.readDate();
         var _loc3_:Date = param1.readDate();
         var _loc5_:DDTKingFloatEvent = new DDTKingFloatEvent("floatParadeRefreshBuff");
         _loc5_.data = {
            "id":_loc2_,
            "zoneId":_loc8_,
            "acceleEndTime":_loc6_,
            "deceleEndTime":_loc4_,
            "invisiEndTime":_loc7_,
            "missileEndTime":_loc3_
         };
         dispatchEvent(_loc5_);
      }
      
      private function refreshItemHandler(param1:PackageIn) : void
      {
         var _loc9_:int = 0;
         var _loc2_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = param1.readInt();
         var _loc6_:Array = [];
         _loc9_ = 0;
         while(_loc9_ < _loc3_)
         {
            _loc2_ = param1.readInt();
            _loc8_ = param1.readInt();
            _loc4_ = param1.readInt();
            _loc5_ = param1.readInt();
            _loc6_.push({
               "index":_loc2_,
               "type":_loc8_,
               "posX":_loc4_,
               "tag":_loc5_
            });
            _loc9_++;
         }
         var _loc7_:DDTKingFloatEvent = new DDTKingFloatEvent("floatParadeAppearItem");
         _loc7_.data = {"itemList":_loc6_};
         dispatchEvent(_loc7_);
      }
      
      private function moveHandler(param1:PackageIn) : void
      {
         var _loc2_:int = param1.readInt();
         var _loc5_:int = param1.readInt();
         var _loc3_:Number = param1.readInt();
         var _loc4_:DDTKingFloatEvent = new DDTKingFloatEvent("floatParadeMove");
         _loc4_.data = {
            "zoneId":_loc5_,
            "id":_loc2_,
            "destX":_loc3_
         };
         dispatchEvent(_loc4_);
      }
      
      private function allReadyHandler(param1:PackageIn) : void
      {
         var _loc4_:Date = param1.readDate();
         var _loc2_:Date = param1.readDate();
         var _loc3_:DDTKingFloatEvent = new DDTKingFloatEvent("floatParadeAllReady");
         _loc3_.data = {
            "endTime":_loc4_,
            "isShowStartCountDown":true,
            "sprintEndTime":_loc2_
         };
         dispatchEvent(_loc3_);
      }
      
      private function enterGameHandler(param1:PackageIn) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         _itemFreeCountList = [0,0,0,0];
         _playerList = new Vector.<DDTKingFloatPlayerInfo>();
         var _loc2_:int = param1.readInt();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = new DDTKingFloatPlayerInfo();
            _loc3_.index = _loc4_;
            _loc3_.zoneId = param1.readInt();
            _loc3_.id = param1.readInt();
            _loc3_.carType = param1.readInt();
            _loc3_.name = param1.readUTF();
            _loc3_.level = param1.readInt();
            _loc3_.vipType = param1.readInt();
            _loc3_.vipLevel = param1.readInt();
            if(_loc3_.zoneId == PlayerManager.Instance.Self.ZoneID && _loc3_.id == PlayerManager.Instance.Self.ID)
            {
               _loc3_.isSelf = true;
            }
            else
            {
               _loc3_.isSelf = false;
            }
            _playerList.push(_loc3_);
            _loc4_++;
         }
         _isInGame = true;
         dispatchEvent(new Event("floatParadeEnterGame"));
      }
      
      private function startGameHandler(param1:PackageIn) : void
      {
         dispatchEvent(new Event("floatParadeStartGame"));
      }
      
      private function changeCarStatus(param1:PackageIn) : void
      {
         _carStatus = param1.readInt();
         dispatchEvent(new Event("floatParadeCarStatusChange"));
      }
      
      private function openOrCloseHandler(param1:PackageIn) : void
      {
         var _loc3_:int = 0;
         var _loc9_:int = 0;
         var _loc12_:* = null;
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc15_:* = null;
         var _loc17_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc16_:* = null;
         param1.readInt();
         _isStart = param1.readBoolean();
         if(_isStart)
         {
            dataInfo = new DDTKingFloatInfoVo();
            _isInGame = param1.readBoolean();
            _freeCount = param1.readInt();
            param1.readInt();
            _usableCount = 0;
            _carStatus = param1.readInt();
            dataInfo.carInfo = {};
            _loc3_ = param1.readInt();
            _loc9_ = 0;
            while(_loc9_ < _loc3_)
            {
               _loc12_ = new DDTKingFloatCarInfo();
               _loc12_.type = param1.readInt();
               _loc12_.needMoney = param1.readInt();
               _loc12_.speed = param1.readInt();
               _loc4_ = param1.readInt();
               _loc7_ = 0;
               while(_loc7_ < _loc4_)
               {
                  _loc5_ = param1.readInt();
                  _loc8_ = param1.readInt();
                  _loc12_.awardArr.push({
                     "templateId":_loc5_,
                     "count":_loc8_
                  });
                  _loc7_++;
               }
               dataInfo.carInfo[_loc12_.type] = _loc12_;
               _loc9_++;
            }
            dataInfo.useSkillNeedMoney = [];
            dataInfo.useSkillNeedMoney.push(param1.readInt());
            dataInfo.useSkillNeedMoney.push(param1.readInt());
            dataInfo.useSkillNeedMoney.push(param1.readInt());
            dataInfo.useSkillNeedMoney.push(param1.readInt());
            _rankAddInfo = [];
            _loc3_ = param1.readInt();
            _loc6_ = 0;
            while(_loc6_ < _loc3_)
            {
               _rankAddInfo.push(param1.readInt());
               _loc6_++;
            }
            _accelerateRate = param1.readInt();
            _decelerateRate = param1.readInt();
            _startGameNeedMoney = param1.readInt();
            _loc2_ = param1.readUTF();
            _loc15_ = _loc2_.split("|");
            _loc17_ = _loc15_[0].split(",");
            _loc10_ = _loc17_[0].split(":");
            _loc11_ = _loc17_[1].split(":");
            _loc13_ = _loc15_[1].split(",");
            _loc14_ = _loc13_[0].split(":");
            _loc16_ = _loc13_[1].split(":");
            _doubleTimeArray = _loc10_.concat(_loc11_).concat(_loc14_).concat(_loc16_);
            _sprintAwardInfo = param1.readUTF().split(",");
            _timer = new Timer(1000);
            _timer.addEventListener("timer",timerHandler,false,0,true);
            _timer.start();
         }
         else
         {
            _isInGame = false;
            if(_timer)
            {
               _timer.removeEventListener("timer",timerHandler);
               _timer.stop();
               _timer = null;
            }
         }
      }
      
      private function timerHandler(param1:TimerEvent) : void
      {
         if(isInDoubleTime)
         {
            if(!_isPromptDoubleTime)
            {
               ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("floatParade.doubleTime.startTipTxt"));
               _isPromptDoubleTime = true;
            }
         }
         else if(_isPromptDoubleTime)
         {
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("floatParade.doubleTime.endTipTxt"));
            _isPromptDoubleTime = false;
         }
      }
      
      public function get npcSpeed() : int
      {
         var _loc1_:int = ServerConfigManager.instance.dragonBoatFastTime;
         return int(Math.floor(33600 / _loc1_ / 25));
      }
      
      public function leaveMainViewHandler() : void
      {
         _playerList = null;
      }
      
      public function open() : void
      {
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadIconCompleteHandler);
         UIModuleLoader.Instance.addUIModuleImp("ddtKingFloaticon");
      }
      
      private function loadIconCompleteHandler(param1:UIModuleEvent) : void
      {
         if(param1.module == "ddtKingFloaticon")
         {
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",loadIconCompleteHandler);
            dispatchEvent(new Event("floatParadeIconResLoadComplete"));
         }
      }
      
      public function getPlayerResUrl(param1:Boolean, param2:int) : String
      {
         return PathManager.SITE_MAIN + "image/ddtKingFloat/floatParade" + param2 + ".swf";
      }
      
      public function loadSound() : void
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.SITE_MAIN + "image/escort/escortAudio.swf",4);
         _loc1_.addEventListener("complete",loadSoundCompleteHandler);
         LoadResourceManager.Instance.startLoad(_loc1_);
      }
      
      private function loadSoundCompleteHandler(param1:LoaderEvent) : void
      {
         param1.loader.removeEventListener("complete",loadSoundCompleteHandler);
         SoundManager.instance.initEscortSound();
      }
      
      public function get activityBeginTime() : Date
      {
         return DateUtils.getDateByStr(ServerConfigManager.instance.findInfoByName("NewYearEscortBeginDate").Value);
      }
      
      public function get activityEndTime() : Date
      {
         return DateUtils.getDateByStr(ServerConfigManager.instance.findInfoByName("NewYearEscortEndDate").Value);
      }
   }
}
