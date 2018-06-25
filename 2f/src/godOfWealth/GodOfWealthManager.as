package godOfWealth{   import ddt.events.CEvent;   import ddt.events.PkgEvent;   import ddt.manager.ChatManager;   import ddt.manager.LanguageMgr;   import ddt.manager.SocketManager;   import ddt.utils.AssetModuleLoader;   import flash.display.MovieClip;   import flash.events.EventDispatcher;   import flash.events.MouseEvent;   import hallIcon.HallIconManager;   import road7th.comm.PackageIn;      public class GodOfWealthManager extends EventDispatcher   {            public static const OPEN_VIEW:String = "gow_open_view";            public static const UPDATE:String = "gow_update";            public static const RESULT_SUC:String = "gow_result_suc";            private static var instance:GodOfWealthManager;                   private var _nextPayNeeded:int;            private var _nextRewardMin:int;            private var _nextRewardMax:int;            private var _reward:int;            private var _dateEndTime:Number = 0;            private var _btnEnter:MovieClip;            private var _isOpen:Boolean = false;            public function GodOfWealthManager(single:inner) { super(); }
            public static function getInstance() : GodOfWealthManager { return null; }
            public function get nextPayNeeded() : int { return 0; }
            public function get nextRewardMin() : int { return 0; }
            public function get nextRewardMax() : int { return 0; }
            public function get reward() : int { return 0; }
            public function setup() : void { }
            protected function onInfo(e:PkgEvent) : void { }
            protected function onPay(e:PkgEvent) : void { }
            protected function onIsOpen(e:PkgEvent) : void { }
            private function onEnterBtnClick(e:MouseEvent) : void { }
            public function show() : void { }
            private function dispatchShow() : void { }
            public function endTime() : Number { return 0; }
   }}class inner{          function inner() { super(); }
}