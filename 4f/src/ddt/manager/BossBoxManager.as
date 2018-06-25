package ddt.manager{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import ddt.data.ServerConfigInfo;   import ddt.data.analyze.BoxTempInfoAnalyzer;   import ddt.data.analyze.UserBoxInfoAnalyzer;   import ddt.data.box.BoxGoodsTempInfo;   import ddt.data.box.GradeBoxInfo;   import ddt.data.box.TimeBoxInfo;   import ddt.events.CrazyTankSocketEvent;   import ddt.events.PkgEvent;   import ddt.events.PlayerPropertyEvent;   import ddt.view.bossbox.AwardsView;   import ddt.view.bossbox.BossBoxView;   import ddt.view.bossbox.TimeBoxEvent;   import ddt.view.bossbox.TimeCountDown;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.utils.Dictionary;   import road7th.comm.PackageIn;   import road7th.data.DictionaryData;      public class BossBoxManager extends EventDispatcher   {            public static const GradeBox:int = 1;            public static const FightLibAwardBox:int = 3;            public static const HighTimeBoxBegin:String = "HighTimeBoxBegin";            public static const HighTimeBoxEnd:String = "HighTimeBoxEnd";            public static const SignAward:int = 4;            private static var _instance:BossBoxManager;            public static const LOADUSERBOXINFO_COMPLETE:String = "loadUserBoxInfo_complete";            public static var DataLoaded:Boolean = false;                   private var _time:TimeCountDown;            private var _delayBox:int = 1;            private var _startDelayTime:Boolean = true;            private var _isShowGradeBox:Boolean;            private var _isBoxShowedNow:Boolean = false;            private var _boxShowArray:Array;            private var _delaySumTime:int = 0;            private var _isTimeBoxOver:Boolean = false;            private var _boxButtonShowType:int = 1;            private var _currentGrade:int;            private var _selectedBoxID:String = null;            public var timeBoxList:DictionaryData;            public var gradeBoxList:DictionaryData;            public var caddyBoxGoodsInfo:Vector.<BoxGoodsTempInfo>;            public var boxTemplateID:Dictionary;            public var inventoryItemList:DictionaryData;            public var boxTempIDList:DictionaryData;            public var beadTempInfoList:DictionaryData;            public var cityBattleTempInfoList:DictionaryData;            public var exploitTemplateIDs:Dictionary;            private var _countdown:int = 0;            public var _receieGrade:int;            public var _needGetBoxTime:int;            public function BossBoxManager() { super(); }
            public static function get instance() : BossBoxManager { return null; }
            private function init() : void { }
            private function initExploitTemplateIDs() : void { }
            private function initEvent() : void { }
            protected function _getTimeBoxInfo(event:CrazyTankSocketEvent) : void { }
            public function setup() : void { }
            public function setupBoxInfo(analyzer:UserBoxInfoAnalyzer) : void { }
            public function setupBoxTempInfo(analyzer:BoxTempInfoAnalyzer) : void { }
            public function startDelayTime() : void { }
            private function resetTime() : void { }
            public function continueTime() : void { }
            public function startGradeChangeEvent() : void { }
            private function _updateGradeII(e:PlayerPropertyEvent) : void { }
            private function _checkeGradeForBox(prevGrade:int, NowGrade:int) : Boolean { return false; }
            public function showSignAward(signCount:int, awardids:Array) : void { }
            public function showFightLibAwardBox(type:int, level:int, awardids:Array) : void { }
            public function showBoxOfGrade() : void { }
            private function removeEvent() : void { }
            private function _getTimeBox(evt:CrazyTankSocketEvent) : void { }
            private function currentTimeBoxGrade() : int { return 0; }
            public function _findBoxIdByTime_II(time:int) : void { }
            private function _findGetedBoxByTime(time:int) : void { }
            private function _findGetedBoxGrade(prevGrade:int, NowGrade:int) : Boolean { return false; }
            public function _showOtherBox() : void { }
            private function _timeOver(e:Event) : void { }
            private function _timeOne(e:Event) : void { }
            private function _getShowBoxID(boxType:String) : int { return 0; }
            public function showTimeBox() : void { }
            public function showGradeBox() : void { }
            public function _showBox(boxType:int, _id:int, goodsIDs:Array, fightLibType:int = -1, fightLibLevel:int = -1) : void { }
            public function showOtherGradeBox() : void { }
            public function isShowBoxButton() : Boolean { return false; }
            public function deleteBoxButton() : void { }
            public function stopShowTimeBox(ID:int) : void { }
            public function set receieGrade(value:int) : void { }
            public function set needGetBoxTime(value:int) : void { }
            public function set receiebox(value:int) : void { }
            public function set isShowGradeBox(value:Boolean) : void { }
            public function get isShowGradeBox() : Boolean { return false; }
            public function set currentGrade(value:int) : void { }
            public function get currentGrade() : int { return 0; }
            public function set boxButtonShowType(value:int) : void { }
            public function get boxButtonShowType() : int { return 0; }
            public function set delaySumTime(value:int) : void { }
            public function get delaySumTime() : int { return 0; }
            public function set startDelayTimeB(value:Boolean) : void { }
            public function get startDelayTimeB() : Boolean { return false; }
   }}