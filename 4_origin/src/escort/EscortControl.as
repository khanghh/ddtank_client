package escort
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
   import escort.data.EscortCarInfo;
   import escort.data.EscortInfoVo;
   import escort.data.EscortPlayerInfo;
   import escort.event.EscortEvent;
   import escort.view.EscortBuyConfirmView;
   import escort.view.EscortFrame;
   import escort.view.EscortMainView;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   
   public class EscortControl extends EventDispatcher
   {
      
      public static const CAR_STATUS_CHANGE:String = "escortCarStatusChange";
      
      public static const START_GAME:String = "escortStartGame";
      
      public static const ENTER_GAME:String = "escortEnterGame";
      
      public static const ALL_READY:String = "escortAllReady";
      
      public static const MOVE:String = "escortMove";
      
      public static const REFRESH_ITEM:String = "escortAppearItem";
      
      public static const REFRESH_BUFF:String = "escortRefreshBuff";
      
      public static const USE_SKILL:String = "escortUseSkill";
      
      public static const RANK_LIST:String = "escortRankList";
      
      public static const RANK_ARRIVE_LIST:String = "";
      
      public static const ARRIVE:String = "escortArrive";
      
      public static const DESTROY:String = "escortDestroy";
      
      public static const RE_ENTER_ALL_INFO:String = "escortReEnterAllInfo";
      
      public static const FIGHT_STATE_CHANGE:String = "escortFightStateChange";
      
      public static const LEAP_PROMPT_SHOW_HIDE:String = "escortLeapPromptShowHide";
      
      public static const REFRESH_ENTER_COUNT:String = "escortRefreshEnterCount";
      
      public static const REFRESH_ITEM_FREE_COUNT:String = "escortRefreshItemCount";
      
      public static const ICON_RES_LOAD_COMPLETE:String = "iconresloadcomplete";
      
      private static var _instance:EscortControl;
       
      
      public var dataInfo:EscortInfoVo;
      
      private var _carStatus:int;
      
      private var _freeCount:int;
      
      private var _usableCount:int;
      
      private var _rankAddInfo:Array;
      
      private var _playerList:Vector.<EscortPlayerInfo>;
      
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
      
      private var _isPromptDoubleTime:Boolean = false;
      
      public function EscortControl(target:IEventDispatcher = null)
      {
         _doubleTimeArray = [];
         _itemFreeCountList = [0,0,0];
         super(target);
         EscortMainView;
      }
      
      public static function get instance() : EscortControl
      {
         if(_instance == null)
         {
            _instance = new EscortControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         EscortManager.instance.addEventListener("show_frame",__showFrameHandler);
         EscortManager.instance.addEventListener("escortEnd",__endHandler);
         EscortManager.instance.addEventListener("leaveMainView",__leaveMainViewHandler);
         EscortManager.instance.addEventListener("escort",pkgHandler);
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
      
      private function refreshItemFreeCountHandler(pkg:PackageIn) : void
      {
         _itemFreeCountList[0] = pkg.readInt();
         _itemFreeCountList[1] = pkg.readInt();
         _itemFreeCountList[2] = pkg.readInt();
         pkg.readInt();
         EscortManager.instance.dispatchEvent(new Event("escortRefreshItemCount"));
      }
      
      private function refreshEnterCountHandler(pkg:PackageIn) : void
      {
         _freeCount = pkg.readInt();
         pkg.readInt();
         _usableCount = 0;
         EscortManager.instance.dispatchEvent(new Event("escortRefreshEnterCount"));
      }
      
      private function refreshFightStateHandler(pkg:PackageIn) : void
      {
         var id:int = pkg.readInt();
         var zoneId:int = pkg.readInt();
         var fightState:int = pkg.readInt();
         var posX:int = pkg.readInt();
         var tmpEvent:EscortEvent = new EscortEvent("escortFightStateChange");
         tmpEvent.data = {
            "id":id,
            "zoneId":zoneId,
            "fightState":fightState,
            "posX":posX
         };
         EscortManager.instance.dispatchEvent(tmpEvent);
      }
      
      private function reEnterAllInfoHandler(pkg:PackageIn) : void
      {
         var i:int = 0;
         var tmp:* = null;
         var endTime:Date = pkg.readDate();
         _playerList = new Vector.<EscortPlayerInfo>();
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            tmp = new EscortPlayerInfo();
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
            pkg.readDate();
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
         EscortManager.instance.dispatchEvent(new Event("escortReEnterAllInfo"));
         refreshItemHandler(pkg);
         rankListHandler(pkg);
         var sprintEndTime:Date = pkg.readDate();
         var tmpEvent:EscortEvent = new EscortEvent("escortAllReady");
         tmpEvent.data = {
            "endTime":endTime,
            "isShowStartCountDown":false,
            "sprintEndTime":sprintEndTime
         };
         EscortManager.instance.dispatchEvent(tmpEvent);
      }
      
      private function destroyHandler(pkg:PackageIn) : void
      {
         EscortManager.instance.isInGame = false;
         _carStatus = 0;
         EscortManager.instance.dispatchEvent(new EscortEvent("escortDestroy"));
      }
      
      private function arriveHandler(pkg:PackageIn) : void
      {
         var id:int = pkg.readInt();
         var zoneId:int = pkg.readInt();
         if(zoneId == PlayerManager.Instance.Self.ZoneID && id == PlayerManager.Instance.Self.ID)
         {
            EscortManager.instance.isInGame = false;
            _carStatus = 0;
         }
         var tmpEvent:EscortEvent = new EscortEvent("escortArrive");
         tmpEvent.data = {
            "id":id,
            "zoneId":zoneId
         };
         EscortManager.instance.dispatchEvent(tmpEvent);
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
         var tmpEvent:EscortEvent = new EscortEvent("");
         tmpEvent.data = rankList;
         EscortManager.instance.dispatchEvent(tmpEvent);
      }
      
      private function useSkillHandler(pkg:PackageIn) : void
      {
         var id:int = pkg.readInt();
         var zoneId:int = pkg.readInt();
         var leapX:int = pkg.readInt();
         var tmpEvent:EscortEvent = new EscortEvent("escortUseSkill");
         tmpEvent.data = {
            "id":id,
            "zoneId":zoneId,
            "leapX":leapX,
            "sound":true
         };
         EscortManager.instance.dispatchEvent(tmpEvent);
      }
      
      private function refreshBuffHandler(pkg:PackageIn) : void
      {
         var id:int = pkg.readInt();
         var zoneId:int = pkg.readInt();
         var acceleEndTime:Date = pkg.readDate();
         var deceleEndTime:Date = pkg.readDate();
         var invisiEndTime:Date = pkg.readDate();
         pkg.readDate();
         var tmpEvent:EscortEvent = new EscortEvent("escortRefreshBuff");
         tmpEvent.data = {
            "id":id,
            "zoneId":zoneId,
            "acceleEndTime":acceleEndTime,
            "deceleEndTime":deceleEndTime,
            "invisiEndTime":invisiEndTime
         };
         EscortManager.instance.dispatchEvent(tmpEvent);
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
         var tmpEvent:EscortEvent = new EscortEvent("escortAppearItem");
         tmpEvent.data = {"itemList":itemList};
         EscortManager.instance.dispatchEvent(tmpEvent);
      }
      
      private function moveHandler(pkg:PackageIn) : void
      {
         var id:int = pkg.readInt();
         var zoneId:int = pkg.readInt();
         var destX:Number = pkg.readInt();
         var tmpEvent:EscortEvent = new EscortEvent("escortMove");
         tmpEvent.data = {
            "zoneId":zoneId,
            "id":id,
            "destX":destX
         };
         EscortManager.instance.dispatchEvent(tmpEvent);
      }
      
      private function allReadyHandler(pkg:PackageIn) : void
      {
         var endTime:Date = pkg.readDate();
         var sprintEndTime:Date = pkg.readDate();
         var tmpEvent:EscortEvent = new EscortEvent("escortAllReady");
         tmpEvent.data = {
            "endTime":endTime,
            "isShowStartCountDown":true,
            "sprintEndTime":sprintEndTime
         };
         EscortManager.instance.dispatchEvent(tmpEvent);
      }
      
      private function enterGameHandler(pkg:PackageIn) : void
      {
         var i:int = 0;
         var tmp:* = null;
         _playerList = new Vector.<EscortPlayerInfo>();
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            tmp = new EscortPlayerInfo();
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
         EscortManager.instance.isInGame = true;
         EscortManager.instance.dispatchEvent(new Event("escortEnterGame"));
      }
      
      private function startGameHandler(pkg:PackageIn) : void
      {
         EscortManager.instance.dispatchEvent(new Event("escortStartGame"));
      }
      
      private function changeCarStatus(pkg:PackageIn) : void
      {
         _carStatus = pkg.readInt();
         EscortManager.instance.dispatchEvent(new Event("escortCarStatusChange"));
      }
      
      private function __showFrameHandler(event:Event) : void
      {
         checkInitData();
         var frame:EscortFrame = ComponentFactory.Instance.creatComponentByStylename("EscortFrame");
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
         var pkg:PackageIn = EscortManager.instance.pkgs["show_frame"];
         if(pkg == null)
         {
            return;
         }
         dataInfo = new EscortInfoVo();
         _freeCount = pkg.readInt();
         pkg.readInt();
         _usableCount = 0;
         _carStatus = pkg.readInt();
         dataInfo.carInfo = {};
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            tmp = new EscortCarInfo();
            tmp.type = pkg.readInt();
            tmp.needMoney = pkg.readInt();
            tmp.speed = pkg.readInt();
            tmpLen = pkg.readInt();
            for(k = 0; k < tmpLen; )
            {
               tmpId = pkg.readInt();
               tmpCount = pkg.readInt();
               if(tmpId == 11772)
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
         pkg.readInt();
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
         var tmpTimeArray:Array = tmpStr.split("|");
         var tmpArray:Array = tmpTimeArray[0].split(",");
         var tmpArray2:Array = tmpArray[0].split(":");
         var tmpArray3:Array = tmpArray[1].split(":");
         var tmpArray4:Array = tmpTimeArray[1].split(",");
         var tmpArray5:Array = tmpArray4[0].split(":");
         var tmpArray6:Array = tmpArray4[1].split(":");
         _doubleTimeArray = tmpArray2.concat(tmpArray3).concat(tmpArray5).concat(tmpArray6);
         _sprintAwardInfo = pkg.readUTF().split(",");
         _timer = new Timer(1000);
         _timer.addEventListener("timer",timerHandler,false,0,true);
         _timer.start();
         EscortManager.instance.dispatchEvent(new Event("iconresloadcomplete"));
         var endTimeInfo:ServerConfigInfo = ServerConfigManager.instance.findInfoByName("FiveYearCarEndDate");
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
         EscortManager.instance.pkgs["show_frame"] = null;
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
      
      private function __leaveMainViewHandler(event:Event) : void
      {
         _playerList = null;
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
      
      public function get playerList() : Vector.<EscortPlayerInfo>
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
               ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("escort.doubleTime.startTipTxt"));
               _isPromptDoubleTime = true;
            }
         }
         else if(_isPromptDoubleTime)
         {
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("escort.doubleTime.endTipTxt"));
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
   }
}
