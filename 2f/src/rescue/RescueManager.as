package rescue{   import ddt.CoreManager;   import ddt.events.PkgEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.TimeManager;   import flash.events.Event;   import hallIcon.HallIconManager;   import rescue.analyzer.RescueRewardAnalyzer;   import road7th.comm.PackageIn;      public class RescueManager extends CoreManager   {            public static const RESCUE_OPENVIEW:String = "rescueOpenView";            private static var _instance:RescueManager;                   private var _isBegin:Boolean;            public var rewardArr:Array;            public function RescueManager() { super(); }
            public static function get instance() : RescueManager { return null; }
            public function setup() : void { }
            protected function __addRescueBtn(event:PkgEvent) : void { }
            public function createRescueBtn(flag:Boolean) : void { }
            public function setupRewardList(analyzer:RescueRewardAnalyzer) : void { }
            public function isSpringShowTop() : Boolean { return false; }
            public function isSpringBegin() : Boolean { return false; }
            override protected function start() : void { }
            public function get isBegin() : Boolean { return false; }
            public function set isBegin(value:Boolean) : void { }
   }}