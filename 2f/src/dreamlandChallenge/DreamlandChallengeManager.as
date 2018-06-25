package dreamlandChallenge{   import ddt.data.player.SelfInfo;   import ddt.events.CEvent;   import ddt.events.PkgEvent;   import ddt.loader.LoaderCreate;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.utils.AssetModuleLoader;   import dreamlandChallenge.analyzer.UnrealRankRewardAnalyzer;   import dreamlandChallenge.data.DCSpeedMatchRankMode;   import dreamlandChallenge.data.DCSpeedMatchRankVo;   import dreamlandChallenge.data.DreamLandModel;   import dreamlandChallenge.data.DreamLandSelfRankVo;   import dreamlandChallenge.data.UnrealRankRewardInfo;   import flash.events.Event;   import flash.events.EventDispatcher;   import hallIcon.HallIconManager;   import road7th.comm.PackageIn;      public class DreamlandChallengeManager extends EventDispatcher   {            public static var OPEN_VIEW:String = "openSupContendView";            public static var ACTIVE_STATECHANGE:String = "activeStateChange";            public static var BOGUID:int = 3000;            public static var XIESHENID:int = 3002;            private static var _instance:DreamlandChallengeManager;                   private var _isOpen:Boolean = false;            private var _awardLists:Array;            private var _mode:DreamLandModel;            private var _curState:int;            public function DreamlandChallengeManager() { super(); }
            public static function get instance() : DreamlandChallengeManager { return null; }
            public function setup() : void { }
            private function __viewStateHandler(evt:PkgEvent) : void { }
            public function get curState() : int { return 0; }
            public function set curState(value:int) : void { }
            public function set isOpen(value:Boolean) : void { }
            public function initHall() : void { }
            private function checkIcon() : void { }
            private function __rankDataHandler(evt:PkgEvent) : void { }
            private function addSelfSpeedMatchRankItem(ranking:int, type:int) : DCSpeedMatchRankVo { return null; }
            private function _selfInfoHandler(evt:PkgEvent) : void { }
            private function _selfRankInfoHandler(evt:PkgEvent) : void { }
            public function preOpenView() : void { }
            private function loadUiResource() : void { }
            private function openView() : void { }
            public function loadUnrealRankAwardComplete(value:UnrealRankRewardAnalyzer) : void { }
            public function getAwardsByDiffcultyType(type:int) : Array { return null; }
            public function get mode() : DreamLandModel { return null; }
   }}