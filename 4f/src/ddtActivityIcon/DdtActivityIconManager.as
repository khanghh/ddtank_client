package ddtActivityIcon{   import dayActivity.DayActiveData;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.TimeManager;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import flash.events.TimerEvent;   import flash.utils.Timer;   import lanternriddles.event.LanternEvent;   import road7th.data.DictionaryData;   import road7th.utils.DateUtils;      public class DdtActivityIconManager extends EventDispatcher   {            private static var _instance:DdtActivityIconManager;            private static const MINI:int = 10000;            private static const HOURS:int = 3600000;            public static const READY_START:String = "ready_start";            public static const START:String = "start";            private static const NO_START:String = "no_start";                   private var _timerList:Vector.<DayActiveData>;            private var _timer:Timer;            private var todayActList:Array;            private var _isOneOpen:Boolean;            private var _isAlreadyOpen:Boolean;            public var currObj:Array;            public function DdtActivityIconManager(target:IEventDispatcher = null) { super(null); }
            public static function get Instance() : DdtActivityIconManager { return null; }
            private function timerHander(e:TimerEvent) : void { }
            private function checkSpecialActivity() : void { }
            private function transformTime(nowTime:String, startTime:String) : String { return null; }
            public function set timerList(list:Vector.<DayActiveData>) : void { }
            public function setup() : void { }
            public function startTime() : void { }
            public function stopTime() : void { }
            private function initToDayActivie() : Array { return null; }
            public function get isOneOpen() : Boolean { return false; }
            public function set isOneOpen(bool:Boolean) : void { }
            private function checkTodayActList() : void { }
            private function checkToday(str:String) : Boolean { return false; }
            private function checkActOpen(obj:Object) : void { }
            private function checkActReady(obj:Object) : void { }
            private function addO(num:Number) : String { return null; }
            private function strToDataArray(str:String, JumpType:int) : Array { return null; }
            private function strToDate(str:String) : Date { return null; }
            public function set isAlreadyOpen(value:Boolean) : void { }
   }}