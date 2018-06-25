package dreamlandChallenge{   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.map.DungeonInfo;   import ddt.events.CEvent;   import ddt.events.CrazyTankSocketEvent;   import ddt.manager.GameInSocketOut;   import ddt.manager.LanguageMgr;   import ddt.manager.MapManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.CheckMoneyUtils;   import dreamlandChallenge.view.logicView.DCMainView;   import flash.events.Event;   import room.RoomManager;      public class DreamlandChallengeControl   {            private static var _instance:DreamlandChallengeControl;                   private var _confirmFrame:BaseAlerFrame;            private var _difficultyForLev:Array;            private var _sendRoomSet:Boolean = false;            private var _mainFrame:DCMainView;            private var _clickNum:Number = 0;            public function DreamlandChallengeControl() { super(); }
            public static function get instance() : DreamlandChallengeControl { return null; }
            public function get difficultyForLev() : Array { return null; }
            public function set difficultyForLev(value:Array) : void { }
            public function setup() : void { }
            private function __openViewHandler(evt:CEvent) : void { }
            public function getDupInfoById(index:int) : DungeonInfo { return null; }
            public function getAwardsByDiffcultyType(type:int) : Array { return null; }
            public function startChallenge(difficulty:int, info:DungeonInfo) : void { }
            public function checkLevMeet(difficulty:int) : Boolean { return false; }
            public function getLevByDifficlty(difficulty:int) : Object { return null; }
            private function sendStart(mapID:int, difficulty:int, type:int = 0) : void { }
            private function cannotChallengeAlert(difficulty:int) : void { }
            private function challengeCountBuyAlert() : void { }
            public function showBuychallengeCountFrame() : void { }
            private function __confirmBuy(evt:FrameEvent) : void { }
            private function __activeStateChangeHandler(evt:Event) : void { }
            public function get disableChallengeBtn() : Boolean { return false; }
            private function getViewData() : void { }
            public function getRankData(pageNum:int, type:int) : void { }
            public function get isClick() : Boolean { return false; }
            public function reset() : void { }
   }}