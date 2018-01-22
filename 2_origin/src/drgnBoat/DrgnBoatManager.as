package drgnBoat
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import ddt.CoreManager;
   import ddt.data.ServerConfigInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import drgnBoat.data.DrgnBoatCarInfo;
   import drgnBoat.data.DrgnBoatInfoVo;
   import drgnBoat.data.DrgnBoatPlayerInfo;
   import drgnBoat.event.DrgnBoatEvent;
   import drgnBoatBuild.DrgnBoatBuildManager;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   
   public class DrgnBoatManager extends CoreManager
   {
      
      public static const LEN:int = 33600;
      
      public static const INIT_X:int = 280;
      
      public static const ICON_RES_LOAD_COMPLETE:String = "drgnBoatIconResLoadComplete";
      
      public static const CAR_STATUS_CHANGE:String = "drgnBoatCarStatusChange";
      
      public static const START_GAME:String = "drgnBoatStartGame";
      
      public static const ENTER_GAME:String = "drgnBoatEnterGame";
      
      public static const ALL_READY:String = "drgnBoatAllReady";
      
      public static const MOVE:String = "drgnBoatMove";
      
      public static const REFRESH_ITEM:String = "drgnBoatAppearItem";
      
      public static const REFRESH_BUFF:String = "drgnBoatRefreshBuff";
      
      public static const USE_SKILL:String = "drgnBoatUseSkill";
      
      public static const RANK_LIST:String = "drgnBoatRankList";
      
      public static const RANK_ARRIVE_LIST:String = "";
      
      public static const ARRIVE:String = "drgnBoatArrive";
      
      public static const DESTROY:String = "drgnBoatDestroy";
      
      public static const RE_ENTER_ALL_INFO:String = "drgnBoatReEnterAllInfo";
      
      public static const CAN_ENTER:String = "drgnBoatCanEnter";
      
      public static const FIGHT_STATE_CHANGE:String = "drgnBoatFightStateChange";
      
      public static const LEAP_PROMPT_SHOW_HIDE:String = "drgnBoatLeapPromptShowHide";
      
      public static const END:String = "drgnBoatEnd";
      
      public static const REFRESH_ENTER_COUNT:String = "drgnBoatRefreshEnterCount";
      
      public static const REFRESH_ITEM_FREE_COUNT:String = "drgnBoatRefreshItemCount";
      
      public static const CANCEL_GAME:String = "drgnBoatCancelGame";
      
      public static const LAUNCH_MISSILE:String = "launchMissile";
      
      private static var _instance:DrgnBoatManager;
       
      
      public var isShowDungeonTip:Boolean = true;
      
      public var dataInfo:DrgnBoatInfoVo;
      
      private var _isStart:Boolean;
      
      private var _isLoadIconComplete:Boolean;
      
      private var _isInGame:Boolean;
      
      private var _carStatus:int;
      
      private var _freeCount:int;
      
      private var _usableCount:int;
      
      private var _playerList:Vector.<DrgnBoatPlayerInfo>;
      
      private var _rankAddInfo:Array;
      
      private var _accelerateRate:int;
      
      private var _decelerateRate:int;
      
      private var _buyRecordStatus:Array;
      
      private var _startGameNeedMoney:int;
      
      private var _doubleTimeArray:Array;
      
      private var _timer:Timer;
      
      private var _itemFreeCountList:Array;
      
      private var _sprintAwardInfo:Array;
      
      private var _endTime:int = -1;
      
      private var _hasPrompted:DictionaryData;
      
      public var missileArgArr:Array;
      
      private var _isPromptDoubleTime:Boolean = false;
      
      public function DrgnBoatManager()
      {
         _doubleTimeArray = [];
         _itemFreeCountList = [0,0,0,0];
         super();
      }
      
      public static function get instance() : DrgnBoatManager
      {
         if(!_instance)
         {
            _instance = new DrgnBoatManager();
         }
         return _instance;
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
      
      public function get playerList() : Vector.<DrgnBoatPlayerInfo>
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
      
      public function get isLoadIconComplete() : Boolean
      {
         return _isLoadIconComplete;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener("drgn_baot",pkgHandler);
      }
      
      private function pkgHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
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
                                                               if(48 !== _loc4_)
                                                               {
                                                                  if(49 !== _loc4_)
                                                                  {
                                                                     if(50 !== _loc4_)
                                                                     {
                                                                        if(51 !== _loc4_)
                                                                        {
                                                                           if(43 === _loc4_)
                                                                           {
                                                                              playLaunchMissileMC(_loc3_);
                                                                           }
                                                                        }
                                                                        else
                                                                        {
                                                                           DrgnBoatBuildManager.instance.receiveHelpToBuild(_loc3_);
                                                                        }
                                                                     }
                                                                     else
                                                                     {
                                                                        DrgnBoatBuildManager.instance.receiveCommitResult(_loc3_);
                                                                     }
                                                                  }
                                                                  else
                                                                  {
                                                                     DrgnBoatBuildManager.instance.updateBuildInfo(_loc3_);
                                                                  }
                                                               }
                                                               else
                                                               {
                                                                  DrgnBoatBuildManager.instance.initBuildingStatus(_loc3_);
                                                               }
                                                            }
                                                            else
                                                            {
                                                               dispatchEvent(new Event("drgnBoatCancelGame"));
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
         var _loc2_:DrgnBoatEvent = new DrgnBoatEvent("launchMissile");
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
         dispatchEvent(new Event("drgnBoatRefreshItemCount"));
      }
      
      private function refreshEnterCountHandler(param1:PackageIn) : void
      {
         _freeCount = param1.readInt();
         _usableCount = param1.readInt();
         dispatchEvent(new Event("drgnBoatRefreshEnterCount"));
      }
      
      private function refreshFightStateHandler(param1:PackageIn) : void
      {
         var _loc2_:int = param1.readInt();
         var _loc6_:int = param1.readInt();
         var _loc4_:int = param1.readInt();
         var _loc3_:int = param1.readInt();
         var _loc5_:DrgnBoatEvent = new DrgnBoatEvent("drgnBoatFightStateChange");
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
            dispatchEvent(new DrgnBoatEvent("drgnBoatCanEnter"));
         }
         else
         {
            show();
         }
      }
      
      private function reEnterAllInfoHandler(param1:PackageIn) : void
      {
         var _loc7_:int = 0;
         var _loc5_:* = null;
         var _loc6_:Date = param1.readDate();
         _playerList = new Vector.<DrgnBoatPlayerInfo>();
         var _loc3_:int = param1.readInt();
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            _loc5_ = new DrgnBoatPlayerInfo();
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
         dispatchEvent(new Event("drgnBoatReEnterAllInfo"));
         refreshItemHandler(param1);
         rankListHandler(param1);
         var _loc2_:Date = param1.readDate();
         var _loc4_:DrgnBoatEvent = new DrgnBoatEvent("drgnBoatAllReady");
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
         dispatchEvent(new DrgnBoatEvent("drgnBoatDestroy"));
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
         var _loc3_:DrgnBoatEvent = new DrgnBoatEvent("drgnBoatArrive");
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
         var _loc8_:DrgnBoatEvent = new DrgnBoatEvent("");
         _loc8_.data = _loc5_;
         dispatchEvent(_loc8_);
      }
      
      private function useSkillHandler(param1:PackageIn) : void
      {
         var _loc2_:int = param1.readInt();
         var _loc5_:int = param1.readInt();
         var _loc3_:int = param1.readInt();
         trace("leapX=====" + _loc3_);
         var _loc4_:DrgnBoatEvent = new DrgnBoatEvent("drgnBoatUseSkill");
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
         var _loc5_:DrgnBoatEvent = new DrgnBoatEvent("drgnBoatRefreshBuff");
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
         var _loc7_:DrgnBoatEvent = new DrgnBoatEvent("drgnBoatAppearItem");
         _loc7_.data = {"itemList":_loc6_};
         dispatchEvent(_loc7_);
      }
      
      private function moveHandler(param1:PackageIn) : void
      {
         var _loc2_:int = param1.readInt();
         var _loc5_:int = param1.readInt();
         var _loc3_:Number = param1.readInt();
         var _loc4_:DrgnBoatEvent = new DrgnBoatEvent("drgnBoatMove");
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
         var _loc3_:DrgnBoatEvent = new DrgnBoatEvent("drgnBoatAllReady");
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
         _playerList = new Vector.<DrgnBoatPlayerInfo>();
         var _loc2_:int = param1.readInt();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = new DrgnBoatPlayerInfo();
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
         dispatchEvent(new Event("drgnBoatEnterGame"));
      }
      
      private function startGameHandler(param1:PackageIn) : void
      {
         dispatchEvent(new Event("drgnBoatStartGame"));
      }
      
      private function changeCarStatus(param1:PackageIn) : void
      {
         _carStatus = param1.readInt();
         dispatchEvent(new Event("drgnBoatCarStatusChange"));
      }
      
      private function openOrCloseHandler(param1:PackageIn) : void
      {
         var _loc3_:int = 0;
         var _loc10_:int = 0;
         var _loc17_:* = null;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:* = null;
         var _loc20_:* = null;
         var _loc22_:* = null;
         var _loc15_:* = null;
         var _loc16_:* = null;
         var _loc18_:* = null;
         var _loc19_:* = null;
         var _loc21_:* = null;
         var _loc14_:* = null;
         var _loc11_:* = null;
         var _loc13_:* = null;
         var _loc12_:* = null;
         var _loc5_:* = null;
         param1.readInt();
         _isStart = param1.readBoolean();
         if(_isStart)
         {
            dataInfo = new DrgnBoatInfoVo();
            _isInGame = param1.readBoolean();
            _freeCount = param1.readInt();
            param1.readInt();
            _usableCount = 0;
            _carStatus = param1.readInt();
            dataInfo.carInfo = {};
            _loc3_ = param1.readInt();
            _loc10_ = 0;
            while(_loc10_ < _loc3_)
            {
               _loc17_ = new DrgnBoatCarInfo();
               _loc17_.type = param1.readInt();
               _loc17_.needMoney = param1.readInt();
               _loc17_.speed = param1.readInt();
               _loc4_ = param1.readInt();
               _loc8_ = 0;
               while(_loc8_ < _loc4_)
               {
                  _loc6_ = param1.readInt();
                  _loc9_ = param1.readInt();
                  _loc17_.awardArr.push({
                     "templateId":_loc6_,
                     "count":_loc9_
                  });
                  _loc8_++;
               }
               dataInfo.carInfo[_loc17_.type] = _loc17_;
               _loc10_++;
            }
            dataInfo.useSkillNeedMoney = [];
            dataInfo.useSkillNeedMoney.push(param1.readInt());
            dataInfo.useSkillNeedMoney.push(param1.readInt());
            dataInfo.useSkillNeedMoney.push(param1.readInt());
            dataInfo.useSkillNeedMoney.push(param1.readInt());
            _rankAddInfo = [];
            _loc3_ = param1.readInt();
            _loc7_ = 0;
            while(_loc7_ < _loc3_)
            {
               _rankAddInfo.push(param1.readInt());
               _loc7_++;
            }
            _accelerateRate = param1.readInt();
            _decelerateRate = param1.readInt();
            _startGameNeedMoney = param1.readInt();
            _loc2_ = param1.readUTF();
            _loc20_ = _loc2_.split("|");
            _loc22_ = _loc20_[0].split(",");
            _loc15_ = _loc22_[0].split(":");
            _loc16_ = _loc22_[1].split(":");
            _loc18_ = _loc20_[1].split(",");
            _loc19_ = _loc18_[0].split(":");
            _loc21_ = _loc18_[1].split(":");
            _doubleTimeArray = _loc15_.concat(_loc16_).concat(_loc19_).concat(_loc21_);
            _sprintAwardInfo = param1.readUTF().split(",");
            _timer = new Timer(1000);
            _timer.addEventListener("timer",timerHandler,false,0,true);
            _timer.start();
            open();
            _loc14_ = ServerConfigManager.instance.findInfoByName("FiveYearCarEndDate");
            _loc11_ = _loc14_.Value.split(" ");
            if((_loc11_[0] as String).indexOf("-") > 0)
            {
               _loc13_ = _loc11_[0].split("-");
            }
            else
            {
               _loc13_ = _loc11_[0].split("/");
            }
            _loc12_ = _loc11_[1].split(":");
            _loc5_ = new Date(_loc13_[0],int(_loc13_[1]) - 1,_loc13_[2],_loc12_[0],_loc12_[1],_loc12_[2]);
            _endTime = _loc5_.getTime() / 1000;
            _hasPrompted = new DictionaryData();
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
            dispatchEvent(new Event("drgnBoatEnd"));
         }
      }
      
      private function open() : void
      {
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadIconCompleteHandler);
         UIModuleLoader.Instance.addUIModuleImp("drgnBoaticon");
      }
      
      private function loadIconCompleteHandler(param1:UIModuleEvent) : void
      {
         if(param1.module == "drgnBoaticon")
         {
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",loadIconCompleteHandler);
            _isLoadIconComplete = true;
            dispatchEvent(new Event("drgnBoatIconResLoadComplete"));
         }
      }
      
      private function timerHandler(param1:TimerEvent) : void
      {
         if(isInDoubleTime)
         {
            if(!_isPromptDoubleTime)
            {
               ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("drgnBoat.doubleTime.startTipTxt"));
               _isPromptDoubleTime = true;
            }
         }
         else if(_isPromptDoubleTime)
         {
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("drgnBoat.doubleTime.endTipTxt"));
            _isPromptDoubleTime = false;
         }
      }
      
      public function enterMainViewHandler() : void
      {
      }
      
      public function leaveMainViewHandler() : void
      {
         _playerList = null;
      }
      
      override protected function start() : void
      {
         dispatchEvent(new DrgnBoatEvent("drgnBoatOpenView"));
      }
      
      public function get npcSpeed() : int
      {
         var _loc1_:int = ServerConfigManager.instance.dragonBoatFastTime;
         return int(Math.floor(33600 / _loc1_ / 25));
      }
      
      public function getPlayerResUrl(param1:Boolean, param2:int) : String
      {
         return PathManager.SITE_MAIN + "image/drgnBoat/drgnBoat" + param2 + ".swf";
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
   }
}
