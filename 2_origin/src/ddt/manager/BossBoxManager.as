package ddt.manager
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.data.ServerConfigInfo;
   import ddt.data.analyze.BoxTempInfoAnalyzer;
   import ddt.data.analyze.UserBoxInfoAnalyzer;
   import ddt.data.box.BoxGoodsTempInfo;
   import ddt.data.box.GradeBoxInfo;
   import ddt.data.box.TimeBoxInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.view.bossbox.AwardsView;
   import ddt.view.bossbox.BossBoxView;
   import ddt.view.bossbox.TimeBoxEvent;
   import ddt.view.bossbox.TimeCountDown;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   
   public class BossBoxManager extends EventDispatcher
   {
      
      public static const GradeBox:int = 1;
      
      public static const FightLibAwardBox:int = 3;
      
      public static const HighTimeBoxBegin:String = "HighTimeBoxBegin";
      
      public static const HighTimeBoxEnd:String = "HighTimeBoxEnd";
      
      public static const SignAward:int = 4;
      
      private static var _instance:BossBoxManager;
      
      public static const LOADUSERBOXINFO_COMPLETE:String = "loadUserBoxInfo_complete";
      
      public static var DataLoaded:Boolean = false;
       
      
      private var _time:TimeCountDown;
      
      private var _delayBox:int = 1;
      
      private var _startDelayTime:Boolean = true;
      
      private var _isShowGradeBox:Boolean;
      
      private var _isBoxShowedNow:Boolean = false;
      
      private var _boxShowArray:Array;
      
      private var _delaySumTime:int = 0;
      
      private var _isTimeBoxOver:Boolean = false;
      
      private var _boxButtonShowType:int = 1;
      
      private var _currentGrade:int;
      
      private var _selectedBoxID:String = null;
      
      public var timeBoxList:DictionaryData;
      
      public var gradeBoxList:DictionaryData;
      
      public var caddyBoxGoodsInfo:Vector.<BoxGoodsTempInfo>;
      
      public var boxTemplateID:Dictionary;
      
      public var inventoryItemList:DictionaryData;
      
      public var boxTempIDList:DictionaryData;
      
      public var beadTempInfoList:DictionaryData;
      
      public var cityBattleTempInfoList:DictionaryData;
      
      public var exploitTemplateIDs:Dictionary;
      
      private var _countdown:int = 0;
      
      public var _receieGrade:int;
      
      public var _needGetBoxTime:int;
      
      public function BossBoxManager()
      {
         super();
         setup();
      }
      
      public static function get instance() : BossBoxManager
      {
         if(_instance == null)
         {
            _instance = new BossBoxManager();
         }
         return _instance;
      }
      
      private function init() : void
      {
         _time = new TimeCountDown(1000);
         _boxShowArray = [];
         initExploitTemplateIDs();
      }
      
      private function initExploitTemplateIDs() : void
      {
         exploitTemplateIDs = new Dictionary();
         exploitTemplateIDs[11252] = new Vector.<BoxGoodsTempInfo>();
         exploitTemplateIDs[11257] = new Vector.<BoxGoodsTempInfo>();
         exploitTemplateIDs[11258] = new Vector.<BoxGoodsTempInfo>();
         exploitTemplateIDs[11259] = new Vector.<BoxGoodsTempInfo>();
         exploitTemplateIDs[11260] = new Vector.<BoxGoodsTempInfo>();
      }
      
      private function initEvent() : void
      {
         _time.addEventListener("TIME_countdown_complete",_timeOver);
         _time.addEventListener("countdown_one",_timeOne);
         SocketManager.Instance.addEventListener(PkgEvent.format(53),_getTimeBox);
         SocketManager.Instance.addEventListener(PkgEvent.format(90),_getTimeBoxInfo);
      }
      
      protected function _getTimeBoxInfo(param1:CrazyTankSocketEvent) : void
      {
         receiebox = param1.pkg.readInt();
         receieGrade = param1.pkg.readInt();
         needGetBoxTime = param1.pkg.readInt();
         _countdown = param1.pkg.readInt();
         currentGrade = PlayerManager.Instance.Self.Grade;
         startGradeChangeEvent();
         startDelayTime();
      }
      
      public function setup() : void
      {
         init();
         initEvent();
      }
      
      public function setupBoxInfo(param1:UserBoxInfoAnalyzer) : void
      {
         timeBoxList = param1.timeBoxList;
         gradeBoxList = param1.gradeBoxList;
         boxTemplateID = param1.boxTemplateID;
         CSMBoxManager.instance.CSMBoxList = param1.CSMBoxList;
         DataLoaded = true;
         dispatchEvent(new Event("loadUserBoxInfo_complete"));
      }
      
      public function setupBoxTempInfo(param1:BoxTempInfoAnalyzer) : void
      {
         inventoryItemList = param1.inventoryItemList;
         boxTempIDList = param1.caddyTempIDList;
         beadTempInfoList = param1.beadTempInfoList;
         caddyBoxGoodsInfo = param1.caddyBoxGoodsInfo;
         cityBattleTempInfoList = param1.cityBattleTempInfoList;
      }
      
      public function startDelayTime() : void
      {
         resetTime();
      }
      
      private function resetTime() : void
      {
         if(timeBoxList == null)
         {
            return;
         }
         if(timeBoxList[_delayBox] && startDelayTimeB && timeBoxList[_delayBox].Level >= currentGrade)
         {
            _time.setTimeOnMinute((timeBoxList[_delayBox].Condition * 60 - _countdown) / 60);
            delaySumTime = timeBoxList[_delayBox].Condition * 60 - _countdown;
            if(delaySumTime <= 0)
            {
               boxButtonShowType = 3;
               _boxShowArray.push(_delayBox + ",time");
               return;
            }
            boxButtonShowType = 2;
         }
      }
      
      public function continueTime() : void
      {
         if(timeBoxList == null)
         {
            return;
         }
         if(timeBoxList[_delayBox] && startDelayTimeB && timeBoxList[_delayBox].Level >= currentGrade)
         {
            _time.setTimeOnMinute(timeBoxList[_delayBox].Condition);
            delaySumTime = timeBoxList[_delayBox].Condition * 60;
            boxButtonShowType = 2;
         }
      }
      
      public function startGradeChangeEvent() : void
      {
         PlayerManager.Instance.Self.addEventListener("propertychange",_updateGradeII);
      }
      
      private function _updateGradeII(param1:PlayerPropertyEvent) : void
      {
         if(PlayerManager.Instance.Self.Grade > currentGrade)
         {
            if(PlayerManager.Instance.Self.Grade == 21)
            {
               _findBoxIdByTime_II(0);
               _countdown = 0;
               startDelayTime();
            }
         }
      }
      
      private function _checkeGradeForBox(param1:int, param2:int) : Boolean
      {
         currentGrade = PlayerManager.Instance.Self.Grade;
         return _findGetedBoxGrade(param1,param2);
      }
      
      public function showSignAward(param1:int, param2:Array) : void
      {
         _showBox(4,param1,param2);
      }
      
      public function showFightLibAwardBox(param1:int, param2:int, param3:Array) : void
      {
         if(StateManager.currentStateType != "fighting")
         {
            isShowGradeBox = false;
            _showBox(3,1,param3,param1,param2);
         }
         else
         {
            isShowGradeBox = true;
         }
      }
      
      public function showBoxOfGrade() : void
      {
         if(StateManager.currentStateType != "fighting")
         {
            isShowGradeBox = false;
            showGradeBox();
         }
         else
         {
            isShowGradeBox = true;
         }
      }
      
      private function removeEvent() : void
      {
         _time.removeEventListener("TIME_countdown_complete",_timeOver);
         _time.removeEventListener("countdown_one",_timeOne);
         SocketManager.Instance.removeEventListener("getTimeBox",_getTimeBox);
         SocketManager.Instance.removeEventListener("getTimeBoxInfo",_getTimeBoxInfo);
      }
      
      private function _getTimeBox(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc4_:Boolean = _loc3_.readBoolean();
         var _loc2_:int = _loc3_.readInt();
         if(_loc4_)
         {
            _isBoxShowedNow = false;
            _selectedBoxID = null;
            _findBoxIdByTime_II(_loc2_);
            continueTime();
            _showOtherBox();
         }
         else
         {
            _isBoxShowedNow = false;
            _selectedBoxID = null;
            _findBoxIdByTime_II(_loc2_);
            continueTime();
            _showOtherBox();
         }
      }
      
      private function currentTimeBoxGrade() : int
      {
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = timeBoxList;
         for each(var _loc2_ in timeBoxList)
         {
            if(PlayerManager.Instance.Self.Grade <= _loc2_.Level)
            {
               if(_loc1_ == 0 || _loc1_ > _loc2_.Level)
               {
                  _loc1_ = _loc2_.Level;
               }
            }
         }
         return _loc1_;
      }
      
      public function _findBoxIdByTime_II(param1:int) : void
      {
         var _loc2_:* = null;
         var _loc4_:int = currentTimeBoxGrade();
         var _loc6_:int = 0;
         var _loc5_:* = timeBoxList;
         for each(var _loc3_ in timeBoxList)
         {
            if(_loc3_.Condition > param1)
            {
               if(_loc3_.Level == _loc4_)
               {
                  if(_loc2_ == null)
                  {
                     _loc2_ = _loc3_;
                  }
                  if(_loc3_.Condition < _loc2_.Condition)
                  {
                     _loc2_ = _loc3_;
                  }
               }
            }
         }
         if(_loc2_)
         {
            _delayBox = _loc2_.ID;
            startDelayTimeB = true;
         }
         else
         {
            startDelayTimeB = false;
            _isTimeBoxOver = true;
            boxButtonShowType = 4;
         }
      }
      
      private function _findGetedBoxByTime(param1:int) : void
      {
         var _loc3_:int = currentTimeBoxGrade();
         var _loc5_:int = 0;
         var _loc4_:* = timeBoxList;
         for each(var _loc2_ in timeBoxList)
         {
            if(param1 <= _loc2_.Condition && _loc2_.Level == _loc3_)
            {
               _delayBox = _loc2_.ID;
               if(timeBoxList[_delayBox])
               {
                  startDelayTimeB = true;
               }
               else
               {
                  startDelayTimeB = false;
               }
               return;
            }
         }
      }
      
      private function _findGetedBoxGrade(param1:int, param2:int) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc6_:int = 0;
         var _loc5_:* = gradeBoxList;
         for each(var _loc4_ in gradeBoxList)
         {
            if(PlayerManager.Instance.Self.Sex)
            {
               if(_loc4_.Level > param1 && _loc4_.Level <= param2 && _loc4_.Condition)
               {
                  if(_boxShowArray.indexOf(_loc4_.ID + ",grade") == -1)
                  {
                     _boxShowArray.push(_loc4_.ID + ",grade");
                  }
                  _loc3_ = true;
               }
            }
            else if(_loc4_.Level > param1 && _loc4_.Level <= param2 && !_loc4_.Condition)
            {
               if(_boxShowArray.indexOf(_loc4_.ID + ",grade") == -1)
               {
                  _boxShowArray.push(_loc4_.ID + ",grade");
               }
               _loc3_ = true;
            }
         }
         return _loc3_;
      }
      
      public function _showOtherBox() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _boxShowArray.length)
         {
            if(String(_boxShowArray[_loc1_]).indexOf("grade") > 0)
            {
               showGradeBox();
               return;
            }
            _loc1_++;
         }
      }
      
      private function _timeOver(param1:Event) : void
      {
         if(timeBoxList[_delayBox])
         {
            _boxShowArray.push(_delayBox + ",time");
            boxButtonShowType = 3;
            SocketManager.Instance.out.sendGetTimeBox(0,timeBoxList[_delayBox].Condition);
         }
      }
      
      private function _timeOne(param1:Event) : void
      {
         delaySumTime = Number(delaySumTime) - 1;
      }
      
      private function _getShowBoxID(param1:String) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _boxShowArray.length)
         {
            if(String(_boxShowArray[_loc3_]).indexOf(param1) > 0)
            {
               _loc2_ = String(_boxShowArray[_loc3_]).split(",")[0];
               _selectedBoxID = _boxShowArray.splice(_loc3_,1);
               return _loc2_;
            }
            _loc3_++;
         }
         return 0;
      }
      
      public function showTimeBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         if(!_isBoxShowedNow)
         {
            _loc1_ = _getShowBoxID("time");
            if(_loc1_ != 0)
            {
               _showBox(0,_loc1_,inventoryItemList[timeBoxList[_loc1_].TemplateID]);
            }
            else
            {
               _loc2_ = ComponentFactory.Instance.creat("bossbox.AwardsViewAsset");
               _loc2_.boxType = 0;
               _loc2_.goodsList = inventoryItemList[timeBoxList[_delayBox].TemplateID];
               _loc2_.setCheck();
               LayerManager.Instance.addToLayer(_loc2_,3,true,1);
            }
         }
      }
      
      public function showGradeBox() : void
      {
      }
      
      public function _showBox(param1:int, param2:int, param3:Array, param4:int = -1, param5:int = -1) : void
      {
         _isBoxShowedNow = true;
         LayerManager.Instance.addToLayer(new BossBoxView(param1,param2,param3,param4,param5),3);
      }
      
      public function showOtherGradeBox() : void
      {
         _isBoxShowedNow = false;
         _showOtherBox();
      }
      
      public function isShowBoxButton() : Boolean
      {
         if(timeBoxList == null || PlayerManager.Instance.Self.Grade < 8)
         {
            return false;
         }
         var _loc9_:Date = TimeManager.Instance.Now();
         var _loc11_:ServerConfigInfo = ServerConfigManager.instance.serverConfigInfo["HighTimeBoxBegin"];
         var _loc10_:ServerConfigInfo = ServerConfigManager.instance.serverConfigInfo["HighTimeBoxEnd"];
         var _loc5_:Array = _loc11_.Value.split(" ");
         var _loc2_:Array = _loc10_.Value.split(" ");
         var _loc1_:Array = _loc5_[0].split("/");
         var _loc8_:Array = _loc2_[0].split("/");
         var _loc3_:Array = _loc5_[1].split(":");
         var _loc4_:Array = _loc2_[1].split(":");
         var _loc7_:Date = new Date(_loc1_[0],int(_loc1_[1]) - 1,_loc1_[2],_loc3_[0],_loc3_[1],_loc3_[2]);
         var _loc6_:Date = new Date(_loc8_[0],int(_loc8_[1]) - 1,_loc8_[2],_loc4_[0],_loc4_[1],_loc4_[2]);
         if(_loc9_.getTime() < _loc7_.getTime() || _loc9_.getTime() > _loc6_.getTime())
         {
            return false;
         }
         return true;
      }
      
      public function deleteBoxButton() : void
      {
         stopShowTimeBox(_delayBox);
      }
      
      public function stopShowTimeBox(param1:int) : void
      {
         if(_isBoxShowedNow && _selectedBoxID != null)
         {
            _boxShowArray.push(_selectedBoxID);
         }
         _isBoxShowedNow = false;
      }
      
      public function set receieGrade(param1:int) : void
      {
         _receieGrade = param1;
         if(_findGetedBoxGrade(_receieGrade,PlayerManager.Instance.Self.Grade))
         {
            isShowGradeBox = true;
         }
      }
      
      public function set needGetBoxTime(param1:int) : void
      {
         _needGetBoxTime = param1;
         if(_needGetBoxTime > 0)
         {
            _findGetedBoxByTime(_needGetBoxTime);
            if(startDelayTimeB)
            {
               startDelayTimeB = false;
               if(_boxShowArray.indexOf(_delayBox + ",time") == -1)
               {
                  _boxShowArray.push(_delayBox + ",time");
               }
               boxButtonShowType = 3;
            }
         }
      }
      
      public function set receiebox(param1:int) : void
      {
         _findBoxIdByTime_II(param1);
      }
      
      public function set isShowGradeBox(param1:Boolean) : void
      {
         _isShowGradeBox = param1;
      }
      
      public function get isShowGradeBox() : Boolean
      {
         return _isShowGradeBox;
      }
      
      public function set currentGrade(param1:int) : void
      {
         _currentGrade = param1;
         var _loc4_:int = 0;
         var _loc3_:* = timeBoxList;
         for each(var _loc2_ in timeBoxList)
         {
            if(_currentGrade > 70)
            {
               startDelayTimeB = false;
               _isTimeBoxOver = true;
               boxButtonShowType = 2;
            }
         }
      }
      
      public function get currentGrade() : int
      {
         return _currentGrade;
      }
      
      public function set boxButtonShowType(param1:int) : void
      {
         _boxButtonShowType = param1;
         var _loc2_:TimeBoxEvent = new TimeBoxEvent("update_smallBoxButton_state");
         _loc2_.boxButtonShowType = _boxButtonShowType;
         dispatchEvent(_loc2_);
      }
      
      public function get boxButtonShowType() : int
      {
         return _boxButtonShowType;
      }
      
      public function set delaySumTime(param1:int) : void
      {
         _delaySumTime = param1;
         _delaySumTime = _delaySumTime < 0?0:_delaySumTime;
         var _loc2_:TimeBoxEvent = new TimeBoxEvent("updateTimeCount");
         _loc2_.delaySumTime = _delaySumTime;
         dispatchEvent(_loc2_);
      }
      
      public function get delaySumTime() : int
      {
         return _delaySumTime;
      }
      
      public function set startDelayTimeB(param1:Boolean) : void
      {
         _startDelayTime = param1;
      }
      
      public function get startDelayTimeB() : Boolean
      {
         return _startDelayTime;
      }
   }
}
