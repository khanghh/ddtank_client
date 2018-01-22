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
      
      public function SevenDoubleControl(param1:IEventDispatcher = null)
      {
         _doubleTimeArray = [];
         _itemFreeCountList = [0,0,0];
         super(param1);
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
      
      private function pkgHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readByte();
         var _loc4_:* = _loc2_;
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
      
      public function get sprintAwardInfo() : Array
      {
         return _sprintAwardInfo;
      }
      
      public function get itemFreeCountList() : Array
      {
         return _itemFreeCountList;
      }
      
      private function refreshItemFreeCountHandler(param1:PackageIn) : void
      {
         _itemFreeCountList[0] = param1.readInt();
         _itemFreeCountList[1] = param1.readInt();
         _itemFreeCountList[2] = param1.readInt();
         dispatchEvent(new Event("sevenDoubleRefreshItemCount"));
      }
      
      private function __endHandler(param1:Event) : void
      {
         if(_timer)
         {
            _timer.removeEventListener("timer",timerHandler);
            _timer.stop();
            _timer = null;
         }
      }
      
      private function __showFrameHandler(param1:Event) : void
      {
         checkInitData();
         var _loc2_:SevenDoubleFrame = ComponentFactory.Instance.creatComponentByStylename("SevenDoubleFrame");
         LayerManager.Instance.addToLayer(_loc2_,3,true,1);
      }
      
      public function checkInitData() : void
      {
         var _loc10_:int = 0;
         var _loc16_:* = null;
         var _loc3_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         var _loc13_:* = null;
         var _loc5_:PackageIn = SevenDoubleManager.instance.pkgs["showFrame"];
         if(_loc5_ == null)
         {
            return;
         }
         dataInfo = new SevenDoubleInfoVo();
         _freeCount = _loc5_.readInt();
         _usableCount = _loc5_.readInt();
         _carStatus = _loc5_.readInt();
         dataInfo.carInfo = {};
         var _loc2_:int = _loc5_.readInt();
         _loc10_ = 0;
         while(_loc10_ < _loc2_)
         {
            _loc16_ = new SevenDoubleCarInfo();
            _loc16_.type = _loc5_.readInt();
            _loc16_.needMoney = _loc5_.readInt();
            _loc16_.speed = _loc5_.readInt();
            _loc3_ = _loc5_.readInt();
            _loc8_ = 0;
            while(_loc8_ < _loc3_)
            {
               _loc6_ = _loc5_.readInt();
               _loc9_ = _loc5_.readInt();
               if(_loc6_ == -1300)
               {
                  _loc16_.prestige = _loc9_;
               }
               else
               {
                  _loc16_.itemId = _loc6_;
                  _loc16_.itemCount = _loc9_;
               }
               _loc8_++;
            }
            dataInfo.carInfo[_loc16_.type] = _loc16_;
            _loc10_++;
         }
         dataInfo.useSkillNeedMoney = [];
         dataInfo.useSkillNeedMoney.push(_loc5_.readInt());
         dataInfo.useSkillNeedMoney.push(_loc5_.readInt());
         dataInfo.useSkillNeedMoney.push(_loc5_.readInt());
         _rankAddInfo = [];
         _loc2_ = _loc5_.readInt();
         _loc7_ = 0;
         while(_loc7_ < _loc2_)
         {
            _rankAddInfo.push(_loc5_.readInt());
            _loc7_++;
         }
         _accelerateRate = _loc5_.readInt();
         _decelerateRate = _loc5_.readInt();
         _startGameNeedMoney = _loc5_.readInt();
         var _loc1_:String = _loc5_.readUTF();
         var _loc18_:Array = _loc1_.split("|");
         var _loc15_:Array = _loc18_[0].split(":");
         var _loc17_:Array = _loc18_[1].split(":");
         _doubleTimeArray = _loc15_.concat(_loc17_);
         _sprintAwardInfo = _loc5_.readUTF().split(",");
         _timer = new Timer(1000);
         _timer.addEventListener("timer",timerHandler,false,0,true);
         _timer.start();
         var _loc14_:ServerConfigInfo = ServerConfigManager.instance.findInfoByName("Activity77EndDate");
         var _loc11_:Array = _loc14_.Value.split(" ");
         if((_loc11_[0] as String).indexOf("-") > 0)
         {
            _loc13_ = _loc11_[0].split("-");
         }
         else
         {
            _loc13_ = _loc11_[0].split("/");
         }
         var _loc12_:Array = _loc11_[1].split(":");
         var _loc4_:Date = new Date(_loc13_[0],int(_loc13_[1]) - 1,_loc13_[2],_loc12_[0],_loc12_[1],_loc12_[2]);
         _endTime = _loc4_.getTime() / 1000;
         _hasPrompted = new DictionaryData();
         SevenDoubleManager.instance.pkgs["showFrame"] = null;
      }
      
      public function get isInDoubleTime() : Boolean
      {
         var _loc3_:Date = TimeManager.Instance.Now();
         var _loc2_:Number = _loc3_.hours;
         var _loc4_:Number = _loc3_.minutes;
         var _loc5_:int = _doubleTimeArray[0];
         var _loc1_:int = _doubleTimeArray[1];
         var _loc7_:int = _doubleTimeArray[2];
         var _loc6_:int = _doubleTimeArray[3];
         if((_loc2_ > _loc5_ || _loc2_ == _loc5_ && _loc4_ >= _loc1_) && (_loc2_ < _loc7_ || _loc2_ == _loc7_ && _loc4_ < _loc6_))
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
            while(_loc3_ < 5)
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
      
      private function refreshEnterCountHandler(param1:PackageIn) : void
      {
         _freeCount = param1.readInt();
         _usableCount = param1.readInt();
         SevenDoubleManager.instance.dispatchEvent(new Event("sevenDoubleRefreshEnterCount"));
      }
      
      private function refreshFightStateHandler(param1:PackageIn) : void
      {
         var _loc2_:int = param1.readInt();
         var _loc6_:int = param1.readInt();
         var _loc4_:int = param1.readInt();
         var _loc3_:int = param1.readInt();
         var _loc5_:SevenDoubleEvent = new SevenDoubleEvent("sevenDoubleFightStateChange");
         _loc5_.data = {
            "id":_loc2_,
            "zoneId":_loc6_,
            "fightState":_loc4_,
            "posX":_loc3_
         };
         SevenDoubleManager.instance.dispatchEvent(_loc5_);
      }
      
      private function reEnterAllInfoHandler(param1:PackageIn) : void
      {
         var _loc7_:int = 0;
         var _loc5_:* = null;
         var _loc6_:Date = param1.readDate();
         _playerList = new Vector.<SevenDoublePlayerInfo>();
         var _loc3_:int = param1.readInt();
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            _loc5_ = new SevenDoublePlayerInfo();
            _loc5_.index = _loc7_;
            _loc5_.id = param1.readInt();
            _loc5_.zoneId = param1.readInt();
            _loc5_.name = param1.readUTF();
            _loc5_.carType = param1.readInt();
            _loc5_.posX = param1.readInt();
            _loc5_.fightState = param1.readInt();
            _loc5_.acceleEndTime = param1.readDate();
            _loc5_.deceleEndTime = param1.readDate();
            _loc5_.invisiEndTime = param1.readDate();
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
         SevenDoubleManager.instance.dispatchEvent(new Event("sevenDoubleReEnterAllInfo"));
         refreshItemHandler(param1);
         rankListHandler(param1);
         var _loc2_:Date = param1.readDate();
         var _loc4_:SevenDoubleEvent = new SevenDoubleEvent("sevenDoubleAllReady");
         _loc4_.data = {
            "endTime":_loc6_,
            "isShowStartCountDown":false,
            "sprintEndTime":_loc2_
         };
         SevenDoubleManager.instance.dispatchEvent(_loc4_);
      }
      
      private function destroyHandler(param1:PackageIn) : void
      {
         SevenDoubleManager.instance.isInGame = false;
         _carStatus = 0;
         SevenDoubleManager.instance.dispatchEvent(new SevenDoubleEvent("sevenDoubleDestroy"));
      }
      
      private function arriveHandler(param1:PackageIn) : void
      {
         var _loc2_:int = param1.readInt();
         var _loc4_:int = param1.readInt();
         if(_loc4_ == PlayerManager.Instance.Self.ZoneID && _loc2_ == PlayerManager.Instance.Self.ID)
         {
            SevenDoubleManager.instance.isInGame = false;
            _carStatus = 0;
         }
         var _loc3_:SevenDoubleEvent = new SevenDoubleEvent("sevenDoubleArrive");
         _loc3_.data = {
            "id":_loc2_,
            "zoneId":_loc4_
         };
         SevenDoubleManager.instance.dispatchEvent(_loc3_);
      }
      
      private function rankListHandler(param1:PackageIn) : void
      {
         var _loc11_:int = 0;
         var _loc5_:int = 0;
         var _loc8_:* = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc10_:int = 0;
         var _loc4_:Boolean = false;
         var _loc7_:int = param1.readInt();
         var _loc6_:Array = [];
         _loc11_ = 0;
         while(_loc11_ < _loc7_)
         {
            _loc5_ = param1.readInt();
            _loc8_ = param1.readUTF();
            _loc3_ = param1.readInt();
            _loc2_ = param1.readInt();
            _loc10_ = param1.readInt();
            _loc4_ = param1.readBoolean();
            _loc6_.push({
               "rank":_loc5_,
               "name":_loc8_,
               "carType":_loc3_,
               "id":_loc2_,
               "zoneId":_loc10_,
               "isSprint":_loc4_
            });
            _loc11_++;
         }
         _loc6_.sortOn("rank",16);
         var _loc9_:SevenDoubleEvent = new SevenDoubleEvent("");
         _loc9_.data = _loc6_;
         SevenDoubleManager.instance.dispatchEvent(_loc9_);
      }
      
      private function useSkillHandler(param1:PackageIn) : void
      {
         var _loc2_:int = param1.readInt();
         var _loc5_:int = param1.readInt();
         var _loc3_:int = param1.readInt();
         var _loc4_:SevenDoubleEvent = new SevenDoubleEvent("sevenDoubleUseSkill");
         _loc4_.data = {
            "id":_loc2_,
            "zoneId":_loc5_,
            "leapX":_loc3_,
            "sound":true
         };
         SevenDoubleManager.instance.dispatchEvent(_loc4_);
      }
      
      private function refreshBuffHandler(param1:PackageIn) : void
      {
         var _loc2_:int = param1.readInt();
         var _loc7_:int = param1.readInt();
         var _loc5_:Date = param1.readDate();
         var _loc3_:Date = param1.readDate();
         var _loc6_:Date = param1.readDate();
         var _loc4_:SevenDoubleEvent = new SevenDoubleEvent("sevenDoubleRefreshBuff");
         _loc4_.data = {
            "id":_loc2_,
            "zoneId":_loc7_,
            "acceleEndTime":_loc5_,
            "deceleEndTime":_loc3_,
            "invisiEndTime":_loc6_
         };
         SevenDoubleManager.instance.dispatchEvent(_loc4_);
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
         var _loc7_:SevenDoubleEvent = new SevenDoubleEvent("sevenDoubleAppearItem");
         _loc7_.data = {"itemList":_loc6_};
         SevenDoubleManager.instance.dispatchEvent(_loc7_);
      }
      
      private function moveHandler(param1:PackageIn) : void
      {
         var _loc2_:int = param1.readInt();
         var _loc5_:int = param1.readInt();
         var _loc3_:Number = param1.readInt();
         var _loc4_:SevenDoubleEvent = new SevenDoubleEvent("sevenDoubleMove");
         _loc4_.data = {
            "zoneId":_loc5_,
            "id":_loc2_,
            "destX":_loc3_
         };
         SevenDoubleManager.instance.dispatchEvent(_loc4_);
      }
      
      private function allReadyHandler(param1:PackageIn) : void
      {
         var _loc4_:Date = param1.readDate();
         var _loc2_:Date = param1.readDate();
         var _loc3_:SevenDoubleEvent = new SevenDoubleEvent("sevenDoubleAllReady");
         _loc3_.data = {
            "endTime":_loc4_,
            "isShowStartCountDown":true,
            "sprintEndTime":_loc2_
         };
         SevenDoubleManager.instance.dispatchEvent(_loc3_);
      }
      
      private function enterGameHandler(param1:PackageIn) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         _playerList = new Vector.<SevenDoublePlayerInfo>();
         var _loc2_:int = param1.readInt();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = new SevenDoublePlayerInfo();
            _loc3_.index = _loc4_;
            _loc3_.zoneId = param1.readInt();
            _loc3_.id = param1.readInt();
            _loc3_.carType = param1.readInt();
            _loc3_.name = param1.readUTF();
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
         SevenDoubleManager.instance.isInGame = true;
         SevenDoubleManager.instance.dispatchEvent(new Event("sevenDoubleEnterGame"));
      }
      
      private function startGameHandler(param1:PackageIn) : void
      {
         SevenDoubleManager.instance.dispatchEvent(new Event("sevenDoubleStartGame"));
      }
      
      private function changeCarStatus(param1:PackageIn) : void
      {
         _carStatus = param1.readInt();
         SevenDoubleManager.instance.dispatchEvent(new Event("sevenDoubleCarStatusChange"));
      }
      
      private function timerHandler(param1:TimerEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
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
            _loc4_ = TimeManager.Instance.Now().getTime() / 1000;
            _loc3_ = _endTime - _loc4_;
            if(_loc3_ > 0)
            {
               _loc5_ = _loc3_ % 3600;
               if(_loc5_ < 5)
               {
                  _loc2_ = _loc3_ / 3600;
                  if(_loc2_ <= 48 && _loc2_ > 0 && !_hasPrompted.hasKey(_loc2_))
                  {
                     ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("escort.willEnd.promptTxt",_loc2_));
                     _hasPrompted.add(_loc2_,1);
                  }
               }
            }
         }
      }
      
      private function __leaveMainViewHandler(param1:Event) : void
      {
         _playerList = null;
      }
   }
}
