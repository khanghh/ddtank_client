package kingBless{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.BuffInfo;   import ddt.data.player.SelfInfo;   import ddt.events.PkgEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import ddt.utils.AssetModuleLoader;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.TimerEvent;   import flash.utils.Timer;   import road7th.comm.PackageIn;      public class KingBlessManager extends EventDispatcher   {            public static const KINGBLESS_OPENVIEW:String = "kingBlessOpenView";            public static const UPDATE_BUFF_DATA_EVENT:String = "update_buff_data_event";            public static const UPDATE_MAIN_EVENT:String = "update_main_event";            public static const STRENGTH_ENCHANCE:int = 1;            public static const PET_REFRESH:int = 2;            public static const BEAD_MASTER:int = 3;            public static const HELP_STRAW:int = 4;            public static const DUNGEON_HERO:int = 5;            public static const TASK_SPIRIT:int = 6;            public static const TIME_DEITY:int = 7;            private static var _instance:KingBlessManager;                   private var _openType:int;            private var _endTime:Date;            private var _buffData:Object;            private var _timer:Timer;            private var _count:int;            private var _isChecked:Boolean = false;            private var _confirmFrame:BaseAlerFrame;            public function KingBlessManager() { super(null); }
            public static function get instance() : KingBlessManager { return null; }
            public function get openType() : int { return 0; }
            public function setup() : void { }
            public function clearConfirmFrame() : void { }
            public function checkShowDueAlert() : void { }
            private function __confirmOneDay(evt:FrameEvent) : void { }
            private function __confirmDue(evt:FrameEvent) : void { }
            public function show() : void { }
            private function doOpenKingBlessFrame() : void { }
            public function getRemainTimeTxt() : Object { return null; }
            private function timerHandler(event:TimerEvent) : void { }
            private function updateAllData(event:PkgEvent) : void { }
            private function helpStrawShowHandler() : void { }
            private function updateBuffData(event:PkgEvent) : void { }
            public function getOneBuffData(type:int) : int { return 0; }
   }}