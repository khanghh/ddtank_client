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
      
      protected function _getTimeBoxInfo(event:CrazyTankSocketEvent) : void
      {
         receiebox = event.pkg.readInt();
         receieGrade = event.pkg.readInt();
         needGetBoxTime = event.pkg.readInt();
         _countdown = event.pkg.readInt();
         currentGrade = PlayerManager.Instance.Self.Grade;
         startGradeChangeEvent();
         startDelayTime();
      }
      
      public function setup() : void
      {
         init();
         initEvent();
      }
      
      public function setupBoxInfo(analyzer:UserBoxInfoAnalyzer) : void
      {
         timeBoxList = analyzer.timeBoxList;
         gradeBoxList = analyzer.gradeBoxList;
         boxTemplateID = analyzer.boxTemplateID;
         CSMBoxManager.instance.CSMBoxList = analyzer.CSMBoxList;
         DataLoaded = true;
         dispatchEvent(new Event("loadUserBoxInfo_complete"));
      }
      
      public function setupBoxTempInfo(analyzer:BoxTempInfoAnalyzer) : void
      {
         inventoryItemList = analyzer.inventoryItemList;
         boxTempIDList = analyzer.caddyTempIDList;
         beadTempInfoList = analyzer.beadTempInfoList;
         caddyBoxGoodsInfo = analyzer.caddyBoxGoodsInfo;
         cityBattleTempInfoList = analyzer.cityBattleTempInfoList;
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
      
      private function _updateGradeII(e:PlayerPropertyEvent) : void
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
      
      private function _checkeGradeForBox(prevGrade:int, NowGrade:int) : Boolean
      {
         currentGrade = PlayerManager.Instance.Self.Grade;
         return _findGetedBoxGrade(prevGrade,NowGrade);
      }
      
      public function showSignAward(signCount:int, awardids:Array) : void
      {
         _showBox(4,signCount,awardids);
      }
      
      public function showFightLibAwardBox(type:int, level:int, awardids:Array) : void
      {
         if(StateManager.currentStateType != "fighting")
         {
            isShowGradeBox = false;
            _showBox(3,1,awardids,type,level);
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
      
      private function _getTimeBox(evt:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         var isGet:Boolean = pkg.readBoolean();
         var nextBoxTime:int = pkg.readInt();
         if(isGet)
         {
            _isBoxShowedNow = false;
            _selectedBoxID = null;
            _findBoxIdByTime_II(nextBoxTime);
            continueTime();
            _showOtherBox();
         }
         else
         {
            _isBoxShowedNow = false;
            _selectedBoxID = null;
            _findBoxIdByTime_II(nextBoxTime);
            continueTime();
            _showOtherBox();
         }
      }
      
      private function currentTimeBoxGrade() : int
      {
         var currentGrade:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = timeBoxList;
         for each(var info in timeBoxList)
         {
            if(PlayerManager.Instance.Self.Grade <= info.Level)
            {
               if(currentGrade == 0 || currentGrade > info.Level)
               {
                  currentGrade = info.Level;
               }
            }
         }
         return currentGrade;
      }
      
      public function _findBoxIdByTime_II(time:int) : void
      {
         var minBoxInfo:* = null;
         var boxGrade:int = currentTimeBoxGrade();
         var _loc6_:int = 0;
         var _loc5_:* = timeBoxList;
         for each(var info in timeBoxList)
         {
            if(info.Condition > time)
            {
               if(info.Level == boxGrade)
               {
                  if(minBoxInfo == null)
                  {
                     minBoxInfo = info;
                  }
                  if(info.Condition < minBoxInfo.Condition)
                  {
                     minBoxInfo = info;
                  }
               }
            }
         }
         if(minBoxInfo)
         {
            _delayBox = minBoxInfo.ID;
            startDelayTimeB = true;
         }
         else
         {
            startDelayTimeB = false;
            _isTimeBoxOver = true;
            boxButtonShowType = 4;
         }
      }
      
      private function _findGetedBoxByTime(time:int) : void
      {
         var boxGrade:int = currentTimeBoxGrade();
         var _loc5_:int = 0;
         var _loc4_:* = timeBoxList;
         for each(var info in timeBoxList)
         {
            if(time <= info.Condition && info.Level == boxGrade)
            {
               _delayBox = info.ID;
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
      
      private function _findGetedBoxGrade(prevGrade:int, NowGrade:int) : Boolean
      {
         var bool:Boolean = false;
         var _loc6_:int = 0;
         var _loc5_:* = gradeBoxList;
         for each(var info in gradeBoxList)
         {
            if(PlayerManager.Instance.Self.Sex)
            {
               if(info.Level > prevGrade && info.Level <= NowGrade && info.Condition)
               {
                  if(_boxShowArray.indexOf(info.ID + ",grade") == -1)
                  {
                     _boxShowArray.push(info.ID + ",grade");
                  }
                  bool = true;
               }
            }
            else if(info.Level > prevGrade && info.Level <= NowGrade && !info.Condition)
            {
               if(_boxShowArray.indexOf(info.ID + ",grade") == -1)
               {
                  _boxShowArray.push(info.ID + ",grade");
               }
               bool = true;
            }
         }
         return bool;
      }
      
      public function _showOtherBox() : void
      {
         var i:int = 0;
         for(i = 0; i < _boxShowArray.length; )
         {
            if(String(_boxShowArray[i]).indexOf("grade") > 0)
            {
               showGradeBox();
               return;
            }
            i++;
         }
      }
      
      private function _timeOver(e:Event) : void
      {
         if(timeBoxList[_delayBox])
         {
            _boxShowArray.push(_delayBox + ",time");
            boxButtonShowType = 3;
            SocketManager.Instance.out.sendGetTimeBox(0,timeBoxList[_delayBox].Condition);
         }
      }
      
      private function _timeOne(e:Event) : void
      {
         delaySumTime = Number(delaySumTime) - 1;
      }
      
      private function _getShowBoxID(boxType:String) : int
      {
         var i:int = 0;
         var id:int = 0;
         for(i = 0; i < _boxShowArray.length; )
         {
            if(String(_boxShowArray[i]).indexOf(boxType) > 0)
            {
               id = String(_boxShowArray[i]).split(",")[0];
               _selectedBoxID = _boxShowArray.splice(i,1);
               return id;
            }
            i++;
         }
         return 0;
      }
      
      public function showTimeBox() : void
      {
         var id:int = 0;
         var awards:* = null;
         if(!_isBoxShowedNow)
         {
            id = _getShowBoxID("time");
            if(id != 0)
            {
               _showBox(0,id,inventoryItemList[timeBoxList[id].TemplateID]);
            }
            else
            {
               awards = ComponentFactory.Instance.creat("bossbox.AwardsViewAsset");
               awards.boxType = 0;
               awards.goodsList = inventoryItemList[timeBoxList[_delayBox].TemplateID];
               awards.setCheck();
               LayerManager.Instance.addToLayer(awards,3,true,1);
            }
         }
      }
      
      public function showGradeBox() : void
      {
      }
      
      public function _showBox(boxType:int, _id:int, goodsIDs:Array, fightLibType:int = -1, fightLibLevel:int = -1) : void
      {
         _isBoxShowedNow = true;
         LayerManager.Instance.addToLayer(new BossBoxView(boxType,_id,goodsIDs,fightLibType,fightLibLevel),3);
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
         var today:Date = TimeManager.Instance.Now();
         var begin:ServerConfigInfo = ServerConfigManager.instance.serverConfigInfo["HighTimeBoxBegin"];
         var end:ServerConfigInfo = ServerConfigManager.instance.serverConfigInfo["HighTimeBoxEnd"];
         var benginDayArr:Array = begin.Value.split(" ");
         var bengintimeArr:Array = end.Value.split(" ");
         var beginDArr:Array = benginDayArr[0].split("/");
         var endDArr:Array = bengintimeArr[0].split("/");
         var beginTArr:Array = benginDayArr[1].split(":");
         var endTArr:Array = bengintimeArr[1].split(":");
         var beginData:Date = new Date(beginDArr[0],int(beginDArr[1]) - 1,beginDArr[2],beginTArr[0],beginTArr[1],beginTArr[2]);
         var endData:Date = new Date(endDArr[0],int(endDArr[1]) - 1,endDArr[2],endTArr[0],endTArr[1],endTArr[2]);
         if(today.getTime() < beginData.getTime() || today.getTime() > endData.getTime())
         {
            return false;
         }
         return true;
      }
      
      public function deleteBoxButton() : void
      {
         stopShowTimeBox(_delayBox);
      }
      
      public function stopShowTimeBox(ID:int) : void
      {
         if(_isBoxShowedNow && _selectedBoxID != null)
         {
            _boxShowArray.push(_selectedBoxID);
         }
         _isBoxShowedNow = false;
      }
      
      public function set receieGrade(value:int) : void
      {
         _receieGrade = value;
         if(_findGetedBoxGrade(_receieGrade,PlayerManager.Instance.Self.Grade))
         {
            isShowGradeBox = true;
         }
      }
      
      public function set needGetBoxTime(value:int) : void
      {
         _needGetBoxTime = value;
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
      
      public function set receiebox(value:int) : void
      {
         _findBoxIdByTime_II(value);
      }
      
      public function set isShowGradeBox(value:Boolean) : void
      {
         _isShowGradeBox = value;
      }
      
      public function get isShowGradeBox() : Boolean
      {
         return _isShowGradeBox;
      }
      
      public function set currentGrade(value:int) : void
      {
         _currentGrade = value;
         var _loc4_:int = 0;
         var _loc3_:* = timeBoxList;
         for each(var info in timeBoxList)
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
      
      public function set boxButtonShowType(value:int) : void
      {
         _boxButtonShowType = value;
         var evt:TimeBoxEvent = new TimeBoxEvent("update_smallBoxButton_state");
         evt.boxButtonShowType = _boxButtonShowType;
         dispatchEvent(evt);
      }
      
      public function get boxButtonShowType() : int
      {
         return _boxButtonShowType;
      }
      
      public function set delaySumTime(value:int) : void
      {
         _delaySumTime = value;
         _delaySumTime = _delaySumTime < 0?0:_delaySumTime;
         var evt:TimeBoxEvent = new TimeBoxEvent("updateTimeCount");
         evt.delaySumTime = _delaySumTime;
         dispatchEvent(evt);
      }
      
      public function get delaySumTime() : int
      {
         return _delaySumTime;
      }
      
      public function set startDelayTimeB(value:Boolean) : void
      {
         _startDelayTime = value;
      }
      
      public function get startDelayTimeB() : Boolean
      {
         return _startDelayTime;
      }
   }
}
