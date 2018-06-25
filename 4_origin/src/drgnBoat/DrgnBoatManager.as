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
         var nowDate:Date = TimeManager.Instance.Now();
         var nowHours:Number = nowDate.hours;
         var nowMin:Number = nowDate.minutes;
         var startHour:int = _doubleTimeArray[0];
         var startMin:int = _doubleTimeArray[1];
         var endHour:int = _doubleTimeArray[2];
         var endMin:int = _doubleTimeArray[3];
         var startHour2:int = _doubleTimeArray[4];
         var startMin2:int = _doubleTimeArray[5];
         var endHour2:int = _doubleTimeArray[6];
         var endMin2:int = _doubleTimeArray[7];
         if((nowHours > startHour || nowHours == startHour && nowMin >= startMin) && (nowHours < endHour || nowHours == endHour && nowMin < endMin) || (nowHours > startHour2 || nowHours == startHour2 && nowMin >= startMin2) && (nowHours < endHour2 || nowHours == endHour2 && nowMin < endMin2))
         {
            return true;
         }
         return false;
      }
      
      public function get startGameNeedMoney() : int
      {
         return _startGameNeedMoney;
      }
      
      public function getBuyRecordStatus(index:int) : Object
      {
         var i:int = 0;
         var obj:* = null;
         if(!_buyRecordStatus)
         {
            _buyRecordStatus = [];
            for(i = 0; i < 6; )
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
      
      private function pkgHandler(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var cmd:int = pkg.readByte();
         var _loc4_:* = cmd;
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
                                                                              playLaunchMissileMC(pkg);
                                                                           }
                                                                        }
                                                                        else
                                                                        {
                                                                           DrgnBoatBuildManager.instance.receiveHelpToBuild(pkg);
                                                                        }
                                                                     }
                                                                     else
                                                                     {
                                                                        DrgnBoatBuildManager.instance.receiveCommitResult(pkg);
                                                                     }
                                                                  }
                                                                  else
                                                                  {
                                                                     DrgnBoatBuildManager.instance.updateBuildInfo(pkg);
                                                                  }
                                                               }
                                                               else
                                                               {
                                                                  DrgnBoatBuildManager.instance.initBuildingStatus(pkg);
                                                               }
                                                            }
                                                            else
                                                            {
                                                               dispatchEvent(new Event("drgnBoatCancelGame"));
                                                            }
                                                         }
                                                         else
                                                         {
                                                            refreshItemFreeCountHandler(pkg);
                                                         }
                                                      }
                                                      else
                                                      {
                                                         refreshEnterCountHandler(pkg);
                                                      }
                                                   }
                                                   else
                                                   {
                                                      refreshFightStateHandler(pkg);
                                                   }
                                                }
                                                else
                                                {
                                                   canEnterHandler(pkg);
                                                }
                                             }
                                             else
                                             {
                                                reEnterAllInfoHandler(pkg);
                                             }
                                          }
                                          else
                                          {
                                             destroyHandler(pkg);
                                          }
                                       }
                                       else
                                       {
                                          arriveHandler(pkg);
                                       }
                                    }
                                    else
                                    {
                                       rankListHandler(pkg);
                                    }
                                 }
                                 else
                                 {
                                    useSkillHandler(pkg);
                                 }
                              }
                              else
                              {
                                 refreshBuffHandler(pkg);
                              }
                           }
                           else
                           {
                              refreshItemHandler(pkg);
                           }
                        }
                        else
                        {
                           moveHandler(pkg);
                        }
                     }
                     else
                     {
                        allReadyHandler(pkg);
                     }
                  }
                  else
                  {
                     enterGameHandler(pkg);
                  }
               }
               else
               {
                  startGameHandler(pkg);
               }
            }
            else
            {
               changeCarStatus(pkg);
            }
         }
         else
         {
            openOrCloseHandler(pkg);
         }
      }
      
      private function playLaunchMissileMC(pkg:PackageIn) : void
      {
         var userId:int = pkg.readInt();
         var zoneId:int = pkg.readInt();
         var event:DrgnBoatEvent = new DrgnBoatEvent("launchMissile");
         event.data = {
            "id":userId,
            "zoneId":zoneId
         };
         dispatchEvent(event);
      }
      
      private function refreshItemFreeCountHandler(pkg:PackageIn) : void
      {
         _itemFreeCountList[0] = pkg.readInt();
         _itemFreeCountList[1] = pkg.readInt();
         _itemFreeCountList[2] = pkg.readInt();
         _itemFreeCountList[3] = pkg.readInt();
         dispatchEvent(new Event("drgnBoatRefreshItemCount"));
      }
      
      private function refreshEnterCountHandler(pkg:PackageIn) : void
      {
         _freeCount = pkg.readInt();
         _usableCount = pkg.readInt();
         dispatchEvent(new Event("drgnBoatRefreshEnterCount"));
      }
      
      private function refreshFightStateHandler(pkg:PackageIn) : void
      {
         var id:int = pkg.readInt();
         var zoneId:int = pkg.readInt();
         var fightState:int = pkg.readInt();
         var posX:int = pkg.readInt();
         var tmpEvent:DrgnBoatEvent = new DrgnBoatEvent("drgnBoatFightStateChange");
         tmpEvent.data = {
            "id":id,
            "zoneId":zoneId,
            "fightState":fightState,
            "posX":posX
         };
         dispatchEvent(tmpEvent);
      }
      
      private function canEnterHandler(pkg:PackageIn) : void
      {
         _isInGame = pkg.readBoolean();
         if(_isInGame)
         {
            dispatchEvent(new DrgnBoatEvent("drgnBoatCanEnter"));
         }
         else
         {
            show();
         }
      }
      
      private function reEnterAllInfoHandler(pkg:PackageIn) : void
      {
         var i:int = 0;
         var tmp:* = null;
         var endTime:Date = pkg.readDate();
         _playerList = new Vector.<DrgnBoatPlayerInfo>();
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            tmp = new DrgnBoatPlayerInfo();
            tmp.index = i;
            tmp.id = pkg.readInt();
            tmp.zoneId = pkg.readInt();
            tmp.name = pkg.readUTF();
            tmp.level = pkg.readInt();
            tmp.vipType = pkg.readInt();
            tmp.vipLevel = pkg.readInt();
            tmp.carType = pkg.readInt();
            tmp.posX = pkg.readInt();
            tmp.fightState = pkg.readInt();
            tmp.acceleEndTime = pkg.readDate();
            tmp.deceleEndTime = pkg.readDate();
            tmp.invisiEndTime = pkg.readDate();
            tmp.missileEndTime = pkg.readDate();
            tmp.missileHitEndTime = new Date(TimeManager.Instance.Now().getTime() + 1000);
            if(tmp.zoneId == PlayerManager.Instance.Self.ZoneID && tmp.id == PlayerManager.Instance.Self.ID)
            {
               tmp.isSelf = true;
            }
            else
            {
               tmp.isSelf = false;
            }
            _playerList.push(tmp);
            i++;
         }
         dispatchEvent(new Event("drgnBoatReEnterAllInfo"));
         refreshItemHandler(pkg);
         rankListHandler(pkg);
         var sprintEndTime:Date = pkg.readDate();
         var tmpEvent:DrgnBoatEvent = new DrgnBoatEvent("drgnBoatAllReady");
         tmpEvent.data = {
            "endTime":endTime,
            "isShowStartCountDown":false,
            "sprintEndTime":sprintEndTime
         };
         dispatchEvent(tmpEvent);
      }
      
      private function destroyHandler(pkg:PackageIn) : void
      {
         _isInGame = false;
         _carStatus = 0;
         dispatchEvent(new DrgnBoatEvent("drgnBoatDestroy"));
      }
      
      private function arriveHandler(pkg:PackageIn) : void
      {
         var id:int = pkg.readInt();
         var zoneId:int = pkg.readInt();
         if(zoneId == PlayerManager.Instance.Self.ZoneID && id == PlayerManager.Instance.Self.ID)
         {
            _isInGame = false;
            _carStatus = 0;
         }
         var tmpEvent:DrgnBoatEvent = new DrgnBoatEvent("drgnBoatArrive");
         tmpEvent.data = {
            "id":id,
            "zoneId":zoneId
         };
         dispatchEvent(tmpEvent);
      }
      
      private function rankListHandler(pkg:PackageIn) : void
      {
         var i:int = 0;
         var rank:int = 0;
         var name:* = null;
         var carType:int = 0;
         var id:int = 0;
         var zoneId:int = 0;
         var count:int = pkg.readInt();
         var rankList:Array = [];
         for(i = 0; i < count; )
         {
            rank = pkg.readInt();
            name = pkg.readUTF();
            carType = pkg.readInt();
            id = pkg.readInt();
            zoneId = pkg.readInt();
            pkg.readBoolean();
            rankList.push({
               "rank":rank,
               "name":name,
               "carType":carType,
               "id":id,
               "zoneId":zoneId
            });
            i++;
         }
         rankList.sortOn("rank",16);
         var tmpEvent:DrgnBoatEvent = new DrgnBoatEvent("");
         tmpEvent.data = rankList;
         dispatchEvent(tmpEvent);
      }
      
      private function useSkillHandler(pkg:PackageIn) : void
      {
         var id:int = pkg.readInt();
         var zoneId:int = pkg.readInt();
         var leapX:int = pkg.readInt();
         trace("leapX=====" + leapX);
         var tmpEvent:DrgnBoatEvent = new DrgnBoatEvent("drgnBoatUseSkill");
         tmpEvent.data = {
            "id":id,
            "zoneId":zoneId,
            "leapX":leapX,
            "sound":true
         };
         dispatchEvent(tmpEvent);
      }
      
      private function refreshBuffHandler(pkg:PackageIn) : void
      {
         var id:int = pkg.readInt();
         var zoneId:int = pkg.readInt();
         var acceleEndTime:Date = pkg.readDate();
         var deceleEndTime:Date = pkg.readDate();
         var invisiEndTime:Date = pkg.readDate();
         var missileEndTime:Date = pkg.readDate();
         var tmpEvent:DrgnBoatEvent = new DrgnBoatEvent("drgnBoatRefreshBuff");
         tmpEvent.data = {
            "id":id,
            "zoneId":zoneId,
            "acceleEndTime":acceleEndTime,
            "deceleEndTime":deceleEndTime,
            "invisiEndTime":invisiEndTime,
            "missileEndTime":missileEndTime
         };
         dispatchEvent(tmpEvent);
      }
      
      private function refreshItemHandler(pkg:PackageIn) : void
      {
         var i:int = 0;
         var index:int = 0;
         var type:int = 0;
         var posX:int = 0;
         var tag:int = 0;
         var count:int = pkg.readInt();
         var itemList:Array = [];
         for(i = 0; i < count; )
         {
            index = pkg.readInt();
            type = pkg.readInt();
            posX = pkg.readInt();
            tag = pkg.readInt();
            itemList.push({
               "index":index,
               "type":type,
               "posX":posX,
               "tag":tag
            });
            i++;
         }
         var tmpEvent:DrgnBoatEvent = new DrgnBoatEvent("drgnBoatAppearItem");
         tmpEvent.data = {"itemList":itemList};
         dispatchEvent(tmpEvent);
      }
      
      private function moveHandler(pkg:PackageIn) : void
      {
         var id:int = pkg.readInt();
         var zoneId:int = pkg.readInt();
         var destX:Number = pkg.readInt();
         var tmpEvent:DrgnBoatEvent = new DrgnBoatEvent("drgnBoatMove");
         tmpEvent.data = {
            "zoneId":zoneId,
            "id":id,
            "destX":destX
         };
         dispatchEvent(tmpEvent);
      }
      
      private function allReadyHandler(pkg:PackageIn) : void
      {
         var endTime:Date = pkg.readDate();
         var sprintEndTime:Date = pkg.readDate();
         var tmpEvent:DrgnBoatEvent = new DrgnBoatEvent("drgnBoatAllReady");
         tmpEvent.data = {
            "endTime":endTime,
            "isShowStartCountDown":true,
            "sprintEndTime":sprintEndTime
         };
         dispatchEvent(tmpEvent);
      }
      
      private function enterGameHandler(pkg:PackageIn) : void
      {
         var i:int = 0;
         var tmp:* = null;
         _playerList = new Vector.<DrgnBoatPlayerInfo>();
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            tmp = new DrgnBoatPlayerInfo();
            tmp.index = i;
            tmp.zoneId = pkg.readInt();
            tmp.id = pkg.readInt();
            tmp.carType = pkg.readInt();
            tmp.name = pkg.readUTF();
            tmp.level = pkg.readInt();
            tmp.vipType = pkg.readInt();
            tmp.vipLevel = pkg.readInt();
            if(tmp.zoneId == PlayerManager.Instance.Self.ZoneID && tmp.id == PlayerManager.Instance.Self.ID)
            {
               tmp.isSelf = true;
            }
            else
            {
               tmp.isSelf = false;
            }
            _playerList.push(tmp);
            i++;
         }
         _isInGame = true;
         dispatchEvent(new Event("drgnBoatEnterGame"));
      }
      
      private function startGameHandler(pkg:PackageIn) : void
      {
         dispatchEvent(new Event("drgnBoatStartGame"));
      }
      
      private function changeCarStatus(pkg:PackageIn) : void
      {
         _carStatus = pkg.readInt();
         dispatchEvent(new Event("drgnBoatCarStatusChange"));
      }
      
      private function openOrCloseHandler(pkg:PackageIn) : void
      {
         var count:int = 0;
         var i:int = 0;
         var tmp:* = null;
         var tmpLen:int = 0;
         var k:int = 0;
         var tmpId:int = 0;
         var tmpCount:int = 0;
         var j:int = 0;
         var tmpStr:* = null;
         var tmpTimeArray:* = null;
         var tmpArray:* = null;
         var tmpArray2:* = null;
         var tmpArray3:* = null;
         var tmpArray4:* = null;
         var tmpArray5:* = null;
         var tmpArray6:* = null;
         var endTimeInfo:* = null;
         var endTimeArray:* = null;
         var endTimeArray2:* = null;
         var endTimeArray3:* = null;
         var tmpEndTime:* = null;
         pkg.readInt();
         _isStart = pkg.readBoolean();
         if(_isStart)
         {
            dataInfo = new DrgnBoatInfoVo();
            _isInGame = pkg.readBoolean();
            _freeCount = pkg.readInt();
            pkg.readInt();
            _usableCount = 0;
            _carStatus = pkg.readInt();
            dataInfo.carInfo = {};
            count = pkg.readInt();
            for(i = 0; i < count; )
            {
               tmp = new DrgnBoatCarInfo();
               tmp.type = pkg.readInt();
               tmp.needMoney = pkg.readInt();
               tmp.speed = pkg.readInt();
               tmpLen = pkg.readInt();
               for(k = 0; k < tmpLen; )
               {
                  tmpId = pkg.readInt();
                  tmpCount = pkg.readInt();
                  tmp.awardArr.push({
                     "templateId":tmpId,
                     "count":tmpCount
                  });
                  k++;
               }
               dataInfo.carInfo[tmp.type] = tmp;
               i++;
            }
            dataInfo.useSkillNeedMoney = [];
            dataInfo.useSkillNeedMoney.push(pkg.readInt());
            dataInfo.useSkillNeedMoney.push(pkg.readInt());
            dataInfo.useSkillNeedMoney.push(pkg.readInt());
            dataInfo.useSkillNeedMoney.push(pkg.readInt());
            _rankAddInfo = [];
            count = pkg.readInt();
            for(j = 0; j < count; )
            {
               _rankAddInfo.push(pkg.readInt());
               j++;
            }
            _accelerateRate = pkg.readInt();
            _decelerateRate = pkg.readInt();
            _startGameNeedMoney = pkg.readInt();
            tmpStr = pkg.readUTF();
            tmpTimeArray = tmpStr.split("|");
            tmpArray = tmpTimeArray[0].split(",");
            tmpArray2 = tmpArray[0].split(":");
            tmpArray3 = tmpArray[1].split(":");
            tmpArray4 = tmpTimeArray[1].split(",");
            tmpArray5 = tmpArray4[0].split(":");
            tmpArray6 = tmpArray4[1].split(":");
            _doubleTimeArray = tmpArray2.concat(tmpArray3).concat(tmpArray5).concat(tmpArray6);
            _sprintAwardInfo = pkg.readUTF().split(",");
            _timer = new Timer(1000);
            _timer.addEventListener("timer",timerHandler,false,0,true);
            _timer.start();
            open();
            endTimeInfo = ServerConfigManager.instance.findInfoByName("FiveYearCarEndDate");
            endTimeArray = endTimeInfo.Value.split(" ");
            if((endTimeArray[0] as String).indexOf("-") > 0)
            {
               endTimeArray2 = endTimeArray[0].split("-");
            }
            else
            {
               endTimeArray2 = endTimeArray[0].split("/");
            }
            endTimeArray3 = endTimeArray[1].split(":");
            tmpEndTime = new Date(endTimeArray2[0],int(endTimeArray2[1]) - 1,endTimeArray2[2],endTimeArray3[0],endTimeArray3[1],endTimeArray3[2]);
            _endTime = tmpEndTime.getTime() / 1000;
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
      
      private function loadIconCompleteHandler(event:UIModuleEvent) : void
      {
         if(event.module == "drgnBoaticon")
         {
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",loadIconCompleteHandler);
            _isLoadIconComplete = true;
            dispatchEvent(new Event("drgnBoatIconResLoadComplete"));
         }
      }
      
      private function timerHandler(event:TimerEvent) : void
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
         var fastTime:int = ServerConfigManager.instance.dragonBoatFastTime;
         return int(Math.floor(33600 / fastTime / 25));
      }
      
      public function getPlayerResUrl(isSelf:Boolean, carType:int) : String
      {
         return PathManager.SITE_MAIN + "image/drgnBoat/drgnBoat" + carType + ".swf";
      }
      
      public function loadSound() : void
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.SITE_MAIN + "image/escort/escortAudio.swf",4);
         loader.addEventListener("complete",loadSoundCompleteHandler);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      private function loadSoundCompleteHandler(event:LoaderEvent) : void
      {
         event.loader.removeEventListener("complete",loadSoundCompleteHandler);
         SoundManager.instance.initEscortSound();
      }
   }
}
