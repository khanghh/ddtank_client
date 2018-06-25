package sevenDouble
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.data.ServerConfigInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.TimeManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import sevenDouble.data.SevenDoubleCarInfo;
   import sevenDouble.data.SevenDoubleInfoVo;
   import sevenDouble.data.SevenDoublePlayerInfo;
   import sevenDouble.event.SevenDoubleEvent;
   import sevenDouble.view.SevenDoubleBuyConfirmView;
   import sevenDouble.view.SevenDoubleFrame;
   import sevenDouble.view.SevenDoubleMainView;
   
   public class SevenDoubleControl extends EventDispatcher
   {
      
      public static const CAR_STATUS_CHANGE:String = "sevenDoubleCarStatusChange";
      
      public static const START_GAME:String = "sevenDoubleStartGame";
      
      public static const ENTER_GAME:String = "sevenDoubleEnterGame";
      
      public static const ALL_READY:String = "sevenDoubleAllReady";
      
      public static const MOVE:String = "sevenDoubleMove";
      
      public static const REFRESH_ITEM:String = "sevenDoubleAppearItem";
      
      public static const REFRESH_BUFF:String = "sevenDoubleRefreshBuff";
      
      public static const USE_SKILL:String = "sevenDoubleUseSkill";
      
      public static const RANK_LIST:String = "sevenDoubleRankList";
      
      public static const RANK_ARRIVE_LIST:String = "";
      
      public static const ARRIVE:String = "sevenDoubleArrive";
      
      public static const DESTROY:String = "sevenDoubleDestroy";
      
      public static const RE_ENTER_ALL_INFO:String = "sevenDoubleReEnterAllInfo";
      
      public static const FIGHT_STATE_CHANGE:String = "sevenDoubleFightStateChange";
      
      public static const LEAP_PROMPT_SHOW_HIDE:String = "sevenDoubleLeapPromptShowHide";
      
      public static const REFRESH_ENTER_COUNT:String = "sevenDoubleRefreshEnterCount";
      
      public static const REFRESH_ITEM_FREE_COUNT:String = "sevenDoubleRefreshItemCount";
      
      public static const CANCEL_GAME:String = "sevenDoubleCancelGame";
      
      private static var _instance:SevenDoubleControl;
       
      
      public var dataInfo:SevenDoubleInfoVo;
      
      private var _carStatus:int;
      
      private var _freeCount:int;
      
      private var _usableCount:int;
      
      private var _rankAddInfo:Array;
      
      private var _playerList:Vector.<SevenDoublePlayerInfo>;
      
      private var _accelerateRate:int;
      
      private var _decelerateRate:int;
      
      private var _buyRecordStatus:Array;
      
      private var _startGameNeedMoney:int;
      
      private var _doubleTimeArray:Array;
      
      private var _timer:Timer;
      
      private var _sprintAwardInfo:Array;
      
      private var _itemFreeCountList:Array;
      
      private var _endTime:int = -1;
      
      private var _hasPrompted:DictionaryData;
      
      private var _isPromptDoubleTime:Boolean = false;
      
      public function SevenDoubleControl(target:IEventDispatcher = null)
      {
         _doubleTimeArray = [];
         _itemFreeCountList = [0,0,0];
         super(target);
         SevenDoubleMainView;
      }
      
      public static function get instance() : SevenDoubleControl
      {
         if(_instance == null)
         {
            _instance = new SevenDoubleControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SevenDoubleManager.instance.addEventListener("showFrame",__showFrameHandler);
         SevenDoubleManager.instance.addEventListener("sevenDoubleEnd",__endHandler);
         SevenDoubleManager.instance.addEventListener("leaveMainView",__leaveMainViewHandler);
         SevenDoubleManager.instance.addEventListener("seven_double",pkgHandler);
      }
      
      private function pkgHandler(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var cmd:int = pkg.readByte();
         var _loc4_:* = cmd;
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
                                             if(36 !== _loc4_)
                                             {
                                                if(39 !== _loc4_)
                                                {
                                                   if(40 === _loc4_)
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
      
      public function get sprintAwardInfo() : Array
      {
         return _sprintAwardInfo;
      }
      
      public function get itemFreeCountList() : Array
      {
         return _itemFreeCountList;
      }
      
      private function refreshItemFreeCountHandler(pkg:PackageIn) : void
      {
         _itemFreeCountList[0] = pkg.readInt();
         _itemFreeCountList[1] = pkg.readInt();
         _itemFreeCountList[2] = pkg.readInt();
         dispatchEvent(new Event("sevenDoubleRefreshItemCount"));
      }
      
      private function __endHandler(event:Event) : void
      {
         if(_timer)
         {
            _timer.removeEventListener("timer",timerHandler);
            _timer.stop();
            _timer = null;
         }
      }
      
      private function __showFrameHandler(event:Event) : void
      {
         checkInitData();
         var frame:SevenDoubleFrame = ComponentFactory.Instance.creatComponentByStylename("SevenDoubleFrame");
         LayerManager.Instance.addToLayer(frame,3,true,1);
      }
      
      public function checkInitData() : void
      {
         var i:int = 0;
         var tmp:* = null;
         var tmpLen:int = 0;
         var k:int = 0;
         var tmpId:int = 0;
         var tmpCount:int = 0;
         var j:int = 0;
         var endTimeArray2:* = null;
         var pkg:PackageIn = SevenDoubleManager.instance.pkgs["showFrame"];
         if(pkg == null)
         {
            return;
         }
         dataInfo = new SevenDoubleInfoVo();
         _freeCount = pkg.readInt();
         _usableCount = pkg.readInt();
         _carStatus = pkg.readInt();
         dataInfo.carInfo = {};
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            tmp = new SevenDoubleCarInfo();
            tmp.type = pkg.readInt();
            tmp.needMoney = pkg.readInt();
            tmp.speed = pkg.readInt();
            tmpLen = pkg.readInt();
            for(k = 0; k < tmpLen; )
            {
               tmpId = pkg.readInt();
               tmpCount = pkg.readInt();
               if(tmpId == -1300)
               {
                  tmp.prestige = tmpCount;
               }
               else
               {
                  tmp.itemId = tmpId;
                  tmp.itemCount = tmpCount;
               }
               k++;
            }
            dataInfo.carInfo[tmp.type] = tmp;
            i++;
         }
         dataInfo.useSkillNeedMoney = [];
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
         var tmpStr:String = pkg.readUTF();
         var tmpArray:Array = tmpStr.split("|");
         var tmpArray2:Array = tmpArray[0].split(":");
         var tmpArray3:Array = tmpArray[1].split(":");
         _doubleTimeArray = tmpArray2.concat(tmpArray3);
         _sprintAwardInfo = pkg.readUTF().split(",");
         _timer = new Timer(1000);
         _timer.addEventListener("timer",timerHandler,false,0,true);
         _timer.start();
         var endTimeInfo:ServerConfigInfo = ServerConfigManager.instance.findInfoByName("Activity77EndDate");
         var endTimeArray:Array = endTimeInfo.Value.split(" ");
         if((endTimeArray[0] as String).indexOf("-") > 0)
         {
            endTimeArray2 = endTimeArray[0].split("-");
         }
         else
         {
            endTimeArray2 = endTimeArray[0].split("/");
         }
         var endTimeArray3:Array = endTimeArray[1].split(":");
         var tmpEndTime:Date = new Date(endTimeArray2[0],int(endTimeArray2[1]) - 1,endTimeArray2[2],endTimeArray3[0],endTimeArray3[1],endTimeArray3[2]);
         _endTime = tmpEndTime.getTime() / 1000;
         _hasPrompted = new DictionaryData();
         SevenDoubleManager.instance.pkgs["showFrame"] = null;
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
         if((nowHours > startHour || nowHours == startHour && nowMin >= startMin) && (nowHours < endHour || nowHours == endHour && nowMin < endMin))
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
            for(i = 0; i < 5; )
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
      
      public function get playerList() : Vector.<SevenDoublePlayerInfo>
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
      
      private function refreshEnterCountHandler(pkg:PackageIn) : void
      {
         _freeCount = pkg.readInt();
         _usableCount = pkg.readInt();
         SevenDoubleManager.instance.dispatchEvent(new Event("sevenDoubleRefreshEnterCount"));
      }
      
      private function refreshFightStateHandler(pkg:PackageIn) : void
      {
         var id:int = pkg.readInt();
         var zoneId:int = pkg.readInt();
         var fightState:int = pkg.readInt();
         var posX:int = pkg.readInt();
         var tmpEvent:SevenDoubleEvent = new SevenDoubleEvent("sevenDoubleFightStateChange");
         tmpEvent.data = {
            "id":id,
            "zoneId":zoneId,
            "fightState":fightState,
            "posX":posX
         };
         SevenDoubleManager.instance.dispatchEvent(tmpEvent);
      }
      
      private function reEnterAllInfoHandler(pkg:PackageIn) : void
      {
         var i:int = 0;
         var tmp:* = null;
         var endTime:Date = pkg.readDate();
         _playerList = new Vector.<SevenDoublePlayerInfo>();
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            tmp = new SevenDoublePlayerInfo();
            tmp.index = i;
            tmp.id = pkg.readInt();
            tmp.zoneId = pkg.readInt();
            tmp.name = pkg.readUTF();
            tmp.carType = pkg.readInt();
            tmp.posX = pkg.readInt();
            tmp.fightState = pkg.readInt();
            tmp.acceleEndTime = pkg.readDate();
            tmp.deceleEndTime = pkg.readDate();
            tmp.invisiEndTime = pkg.readDate();
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
         SevenDoubleManager.instance.dispatchEvent(new Event("sevenDoubleReEnterAllInfo"));
         refreshItemHandler(pkg);
         rankListHandler(pkg);
         var sprintEndTime:Date = pkg.readDate();
         var tmpEvent:SevenDoubleEvent = new SevenDoubleEvent("sevenDoubleAllReady");
         tmpEvent.data = {
            "endTime":endTime,
            "isShowStartCountDown":false,
            "sprintEndTime":sprintEndTime
         };
         SevenDoubleManager.instance.dispatchEvent(tmpEvent);
      }
      
      private function destroyHandler(pkg:PackageIn) : void
      {
         SevenDoubleManager.instance.isInGame = false;
         _carStatus = 0;
         SevenDoubleManager.instance.dispatchEvent(new SevenDoubleEvent("sevenDoubleDestroy"));
      }
      
      private function arriveHandler(pkg:PackageIn) : void
      {
         var id:int = pkg.readInt();
         var zoneId:int = pkg.readInt();
         if(zoneId == PlayerManager.Instance.Self.ZoneID && id == PlayerManager.Instance.Self.ID)
         {
            SevenDoubleManager.instance.isInGame = false;
            _carStatus = 0;
         }
         var tmpEvent:SevenDoubleEvent = new SevenDoubleEvent("sevenDoubleArrive");
         tmpEvent.data = {
            "id":id,
            "zoneId":zoneId
         };
         SevenDoubleManager.instance.dispatchEvent(tmpEvent);
      }
      
      private function rankListHandler(pkg:PackageIn) : void
      {
         var i:int = 0;
         var rank:int = 0;
         var name:* = null;
         var carType:int = 0;
         var id:int = 0;
         var zoneId:int = 0;
         var isSprint:Boolean = false;
         var count:int = pkg.readInt();
         var rankList:Array = [];
         for(i = 0; i < count; )
         {
            rank = pkg.readInt();
            name = pkg.readUTF();
            carType = pkg.readInt();
            id = pkg.readInt();
            zoneId = pkg.readInt();
            isSprint = pkg.readBoolean();
            rankList.push({
               "rank":rank,
               "name":name,
               "carType":carType,
               "id":id,
               "zoneId":zoneId,
               "isSprint":isSprint
            });
            i++;
         }
         rankList.sortOn("rank",16);
         var tmpEvent:SevenDoubleEvent = new SevenDoubleEvent("");
         tmpEvent.data = rankList;
         SevenDoubleManager.instance.dispatchEvent(tmpEvent);
      }
      
      private function useSkillHandler(pkg:PackageIn) : void
      {
         var id:int = pkg.readInt();
         var zoneId:int = pkg.readInt();
         var leapX:int = pkg.readInt();
         var tmpEvent:SevenDoubleEvent = new SevenDoubleEvent("sevenDoubleUseSkill");
         tmpEvent.data = {
            "id":id,
            "zoneId":zoneId,
            "leapX":leapX,
            "sound":true
         };
         SevenDoubleManager.instance.dispatchEvent(tmpEvent);
      }
      
      private function refreshBuffHandler(pkg:PackageIn) : void
      {
         var id:int = pkg.readInt();
         var zoneId:int = pkg.readInt();
         var acceleEndTime:Date = pkg.readDate();
         var deceleEndTime:Date = pkg.readDate();
         var invisiEndTime:Date = pkg.readDate();
         var tmpEvent:SevenDoubleEvent = new SevenDoubleEvent("sevenDoubleRefreshBuff");
         tmpEvent.data = {
            "id":id,
            "zoneId":zoneId,
            "acceleEndTime":acceleEndTime,
            "deceleEndTime":deceleEndTime,
            "invisiEndTime":invisiEndTime
         };
         SevenDoubleManager.instance.dispatchEvent(tmpEvent);
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
         var tmpEvent:SevenDoubleEvent = new SevenDoubleEvent("sevenDoubleAppearItem");
         tmpEvent.data = {"itemList":itemList};
         SevenDoubleManager.instance.dispatchEvent(tmpEvent);
      }
      
      private function moveHandler(pkg:PackageIn) : void
      {
         var id:int = pkg.readInt();
         var zoneId:int = pkg.readInt();
         var destX:Number = pkg.readInt();
         var tmpEvent:SevenDoubleEvent = new SevenDoubleEvent("sevenDoubleMove");
         tmpEvent.data = {
            "zoneId":zoneId,
            "id":id,
            "destX":destX
         };
         SevenDoubleManager.instance.dispatchEvent(tmpEvent);
      }
      
      private function allReadyHandler(pkg:PackageIn) : void
      {
         var endTime:Date = pkg.readDate();
         var sprintEndTime:Date = pkg.readDate();
         var tmpEvent:SevenDoubleEvent = new SevenDoubleEvent("sevenDoubleAllReady");
         tmpEvent.data = {
            "endTime":endTime,
            "isShowStartCountDown":true,
            "sprintEndTime":sprintEndTime
         };
         SevenDoubleManager.instance.dispatchEvent(tmpEvent);
      }
      
      private function enterGameHandler(pkg:PackageIn) : void
      {
         var i:int = 0;
         var tmp:* = null;
         _playerList = new Vector.<SevenDoublePlayerInfo>();
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            tmp = new SevenDoublePlayerInfo();
            tmp.index = i;
            tmp.zoneId = pkg.readInt();
            tmp.id = pkg.readInt();
            tmp.carType = pkg.readInt();
            tmp.name = pkg.readUTF();
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
         SevenDoubleManager.instance.isInGame = true;
         SevenDoubleManager.instance.dispatchEvent(new Event("sevenDoubleEnterGame"));
      }
      
      private function startGameHandler(pkg:PackageIn) : void
      {
         SevenDoubleManager.instance.dispatchEvent(new Event("sevenDoubleStartGame"));
      }
      
      private function changeCarStatus(pkg:PackageIn) : void
      {
         _carStatus = pkg.readInt();
         SevenDoubleManager.instance.dispatchEvent(new Event("sevenDoubleCarStatusChange"));
      }
      
      private function timerHandler(event:TimerEvent) : void
      {
         var nowTimeSec:int = 0;
         var diff:int = 0;
         var residue:int = 0;
         var onTime:int = 0;
         if(isInDoubleTime)
         {
            if(!_isPromptDoubleTime)
            {
               ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("sevenDouble.doubleTime.startTipTxt"));
               _isPromptDoubleTime = true;
            }
         }
         else if(_isPromptDoubleTime)
         {
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("sevenDouble.doubleTime.endTipTxt"));
            _isPromptDoubleTime = false;
         }
         if(_endTime > 0)
         {
            nowTimeSec = TimeManager.Instance.Now().getTime() / 1000;
            diff = _endTime - nowTimeSec;
            if(diff > 0)
            {
               residue = diff % 3600;
               if(residue < 5)
               {
                  onTime = diff / 3600;
                  if(onTime <= 48 && onTime > 0 && !_hasPrompted.hasKey(onTime))
                  {
                     ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("escort.willEnd.promptTxt",onTime));
                     _hasPrompted.add(onTime,1);
                  }
               }
            }
         }
      }
      
      private function __leaveMainViewHandler(event:Event) : void
      {
         _playerList = null;
      }
   }
}
