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
      
      public function set dataInfo(value:DDTKingFloatInfoVo) : void
      {
         _dataInfo = value;
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
      
      private function __onOpenView(e:DDTKingFloatEvent) : void
      {
         if(e.savePkg != null)
         {
            pkgHandler(e.savePkg);
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
         var list:Array = ["ddtKingFloatgame","ddtroom"];
         new HelperUIModuleLoad().loadUIModule(list,loadGameComplete);
      }
      
      private function loadGameComplete() : void
      {
         StateManager.setState("ddtKingFloat");
      }
      
      private function __onSocketMessage(e:DDTKingFloatEvent) : void
      {
         pkgHandler(e.savePkg);
      }
      
      private function pkgHandler(value:PackageIn) : void
      {
         var pkg:* = value;
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
                                                               if(43 === _loc4_)
                                                               {
                                                                  playLaunchMissileMC(pkg);
                                                               }
                                                            }
                                                            else
                                                            {
                                                               dispatchEvent(new Event("floatParadeCancelGame"));
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
                                                SocketManager.Instance.out.sendUpdateSysDate();
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
                     SocketManager.Instance.out.sendUpdateSysDate();
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
         var event:DDTKingFloatEvent = new DDTKingFloatEvent("launchMissile");
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
         dispatchEvent(new Event("floatParadeRefreshItemCount"));
      }
      
      private function refreshEnterCountHandler(pkg:PackageIn) : void
      {
         _freeCount = pkg.readInt();
         _usableCount = pkg.readInt();
         dispatchEvent(new Event("floatParadeRefreshEnterCount"));
      }
      
      private function refreshFightStateHandler(pkg:PackageIn) : void
      {
         var id:int = pkg.readInt();
         var zoneId:int = pkg.readInt();
         var fightState:int = pkg.readInt();
         var posX:int = pkg.readInt();
         var tmpEvent:DDTKingFloatEvent = new DDTKingFloatEvent("floatParadeFightStateChange");
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
            enterGame();
         }
         else
         {
            showDDTKingFloatFrame();
         }
      }
      
      private function showDDTKingFloatFrame() : void
      {
         var frame:DDTKingFloatFrame = ComponentFactory.Instance.creatComponentByStylename("ddtking.race.ddtkingFrame");
         LayerManager.Instance.addToLayer(frame,3,true,1);
      }
      
      private function reEnterAllInfoHandler(pkg:PackageIn) : void
      {
         var i:int = 0;
         var tmp:* = null;
         var endTime:Date = pkg.readDate();
         _playerList = new Vector.<DDTKingFloatPlayerInfo>();
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            tmp = new DDTKingFloatPlayerInfo();
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
         dispatchEvent(new Event("floatParadeReEnterAllInfo"));
         refreshItemHandler(pkg);
         rankListHandler(pkg);
         var sprintEndTime:Date = pkg.readDate();
         var tmpEvent:DDTKingFloatEvent = new DDTKingFloatEvent("floatParadeAllReady");
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
         dispatchEvent(new DDTKingFloatEvent("floatParadeDestroy"));
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
         var tmpEvent:DDTKingFloatEvent = new DDTKingFloatEvent("floatParadeArrive");
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
         var tmpEvent:DDTKingFloatEvent = new DDTKingFloatEvent("");
         tmpEvent.data = rankList;
         dispatchEvent(tmpEvent);
      }
      
      private function useSkillHandler(pkg:PackageIn) : void
      {
         var id:int = pkg.readInt();
         var zoneId:int = pkg.readInt();
         var leapX:int = pkg.readInt();
         trace("leapX=====" + leapX);
         var tmpEvent:DDTKingFloatEvent = new DDTKingFloatEvent("floatParadeUseSkill");
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
         var tmpEvent:DDTKingFloatEvent = new DDTKingFloatEvent("floatParadeRefreshBuff");
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
         var tmpEvent:DDTKingFloatEvent = new DDTKingFloatEvent("floatParadeAppearItem");
         tmpEvent.data = {"itemList":itemList};
         dispatchEvent(tmpEvent);
      }
      
      private function moveHandler(pkg:PackageIn) : void
      {
         var id:int = pkg.readInt();
         var zoneId:int = pkg.readInt();
         var destX:Number = pkg.readInt();
         var tmpEvent:DDTKingFloatEvent = new DDTKingFloatEvent("floatParadeMove");
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
         var tmpEvent:DDTKingFloatEvent = new DDTKingFloatEvent("floatParadeAllReady");
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
         _itemFreeCountList = [0,0,0,0];
         _playerList = new Vector.<DDTKingFloatPlayerInfo>();
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            tmp = new DDTKingFloatPlayerInfo();
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
         dispatchEvent(new Event("floatParadeEnterGame"));
      }
      
      private function startGameHandler(pkg:PackageIn) : void
      {
         dispatchEvent(new Event("floatParadeStartGame"));
      }
      
      private function changeCarStatus(pkg:PackageIn) : void
      {
         _carStatus = pkg.readInt();
         dispatchEvent(new Event("floatParadeCarStatusChange"));
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
         pkg.readInt();
         _isStart = pkg.readBoolean();
         if(_isStart)
         {
            dataInfo = new DDTKingFloatInfoVo();
            _isInGame = pkg.readBoolean();
            _freeCount = pkg.readInt();
            pkg.readInt();
            _usableCount = 0;
            _carStatus = pkg.readInt();
            dataInfo.carInfo = {};
            count = pkg.readInt();
            for(i = 0; i < count; )
            {
               tmp = new DDTKingFloatCarInfo();
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
      
      private function timerHandler(event:TimerEvent) : void
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
         var fastTime:int = ServerConfigManager.instance.dragonBoatFastTime;
         return int(Math.floor(33600 / fastTime / 25));
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
      
      private function loadIconCompleteHandler(event:UIModuleEvent) : void
      {
         if(event.module == "ddtKingFloaticon")
         {
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",loadIconCompleteHandler);
            dispatchEvent(new Event("floatParadeIconResLoadComplete"));
         }
      }
      
      public function getPlayerResUrl(isSelf:Boolean, carType:int) : String
      {
         return PathManager.SITE_MAIN + "image/ddtKingFloat/floatParade" + carType + ".swf";
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
