package horseRace.controller{   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import ddt.events.CrazyTankSocketEvent;   import ddt.manager.ChatManager;   import ddt.manager.LanguageMgr;   import ddt.manager.SocketManager;   import ddt.view.UIModuleSmallLoading;   import ddt.view.chat.ChatData;   import flash.events.Event;   import flash.events.EventDispatcher;   import hallIcon.HallIconManager;   import horseRace.events.HorseRaceEvents;   import horseRace.view.HorseRaceMatchView;   import horseRace.view.HorseRaceView;   import road7th.comm.PackageIn;      public class HorseRaceManager extends EventDispatcher   {            private static var _instance:HorseRaceManager;            public static var loadComplete:Boolean = false;                   private var _isShowIcon:Boolean;            private var _matchView:HorseRaceMatchView;            public var showBuyCountFram:Boolean = true;            public var showPingzhangBuyFram:Boolean = true;            private var _horseRaceView:HorseRaceView;            public var horseRaceCanRaceTime:int = 0;            public var itemInfoList:Array;            public var buffCD:int;            public function HorseRaceManager() { super(); }
            public static function get Instance() : HorseRaceManager { return null; }
            public function setup() : void { }
            public function templateDataSetup(dataList:Array) : void { }
            private function pkgHandler(event:CrazyTankSocketEvent) : void { }
            private function updateCount(pkg:PackageIn) : void { }
            private function show_msg(pkg:PackageIn) : void { }
            private function flush_buffItem(pkg:PackageIn) : void { }
            private function syn_onesecond(pkg:PackageIn) : void { }
            private function allPlayerRaceEnd(pkg:PackageIn) : void { }
            private function initPlayerData(pkg:PackageIn) : void { }
            private function startFiveCountDown(pkg:PackageIn) : void { }
            private function beginRace(pkg:PackageIn) : void { }
            private function playerSpeedChange(pkg:PackageIn) : void { }
            private function playerRaceEnd(pkg:PackageIn) : void { }
            private function _open_close(event:CrazyTankSocketEvent) : void { }
            public function get isShowIcon() : Boolean { return false; }
            private function openOrclose(pkg:PackageIn) : void { }
            public function enterView() : void { }
            private function showMatchView() : void { }
            public function showRaceView() : void { }
            public function addEnterIcon() : void { }
            private function disposeEnterIcon() : void { }
            protected function __onClose(event:Event) : void { }
            private function __progressShow(event:UIModuleEvent) : void { }
            private function __completeShow(event:UIModuleEvent) : void { }
   }}