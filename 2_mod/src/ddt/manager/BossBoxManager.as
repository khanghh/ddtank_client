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

        public function BossBoxManager() {super();}

        public static function get instance():BossBoxManager {return null;}

        private function init():void {}

        private function initExploitTemplateIDs():void {}

        private function initEvent():void {}

        protected function _getTimeBoxInfo(param1:CrazyTankSocketEvent):void {}

        public function setup():void {}

        public function setupBoxInfo(param1:UserBoxInfoAnalyzer):void {}

        public function setupBoxTempInfo(param1:BoxTempInfoAnalyzer):void {}

        public function startDelayTime():void {}

        private function resetTime():void {}

        public function continueTime():void {}

        public function startGradeChangeEvent():void {}

        private function _updateGradeII(param1:PlayerPropertyEvent):void {}

        private function _checkeGradeForBox(param1:int, param2:int):Boolean {return false;}

        public function showSignAward(param1:int, param2:Array):void {}

        public function showFightLibAwardBox(param1:int, param2:int, param3:Array):void {}

        public function showBoxOfGrade():void {}

        private function removeEvent():void {}

        private function _getTimeBox(param1:CrazyTankSocketEvent):void {}

        private function currentTimeBoxGrade():int {return 0;}

        public function _findBoxIdByTime_II(param1:int):void {}

        private function _findGetedBoxByTime(param1:int):void {}

        private function _findGetedBoxGrade(param1:int, param2:int):Boolean {return false;}

        public function _showOtherBox():void {}

        private function _timeOne(param1:Event):void {}

        private function _getShowBoxID(param1:String):int {return 0;}

        public function showTimeBox():void {}

        public function showGradeBox():void {}

        public function _showBox(param1:int, param2:int, param3:Array, param4:int = -1, param5:int = -1):void {}

        public function showOtherGradeBox():void {}

        public function isShowBoxButton():Boolean {return false;}

        public function deleteBoxButton():void {}

        public function stopShowTimeBox(param1:int):void {}

        public function set receieGrade(param1:int):void {}

        public function set receiebox(param1:int):void {}

        public function set isShowGradeBox(param1:Boolean):void {}

        public function get isShowGradeBox():Boolean {return false;}

        public function set currentGrade(param1:int):void {}

        public function get currentGrade():int {return 0;}

        public function set boxButtonShowType(param1:int):void {}

        public function get boxButtonShowType():int {return 0;}

        public function set delaySumTime(param1:int):void {}

        public function get delaySumTime():int {return 0;}

        public function set startDelayTimeB(param1:Boolean):void {}

        public function get startDelayTimeB():Boolean {return false;}

        private function _timeOver(param1:Event):void {}

        public function set needGetBoxTime(value:int):void
        {
            _needGetBoxTime = value;
            if (_needGetBoxTime > 0)
            {
                _findGetedBoxByTime(_needGetBoxTime);
                if (startDelayTimeB)
                {
                    startDelayTimeB = false;
                    if (_boxShowArray.indexOf(_delayBox + ",time") == -1)
                    {
                        _boxShowArray.push(_delayBox + ",time");
                    }
                    boxButtonShowType = 3;
                    SocketManager.Instance.out.sendGetTimeBox(1, 0);
                }
            }
        }
    }
}
