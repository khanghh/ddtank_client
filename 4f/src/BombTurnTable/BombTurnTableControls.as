package BombTurnTable{   import BombTurnTable.data.BombTurnTableGoodInfo;   import BombTurnTable.data.BombTurnTableInfo;   import BombTurnTable.event.TurnTableEvent;   import BombTurnTable.view.BombTurnTableFrame;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.BagInfo;   import ddt.events.CEvent;   import ddt.events.PkgEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.events.EventDispatcher;   import road7th.comm.PackageIn;      public class BombTurnTableControls extends EventDispatcher   {            private static var _instance:BombTurnTableControls;                   private var _manager:BombTurnTableManager;            private var _frame:BombTurnTableFrame;            private var _curTurnTableInfo:BombTurnTableInfo;            private var _isStart:Boolean = false;            private var _isSingleLottery:Boolean = true;            private var _curLotteryStatus:int = 1;            public function BombTurnTableControls() { super(); }
            public static function get instance() : BombTurnTableControls { return null; }
            public function setup() : void { }
            private function onShowView(evt:CEvent) : void { }
            protected function viewData_Handler(evt:PkgEvent) : void { }
            public function myDelayedFunction() : void { }
            protected function winningInfo_Handler(evt:PkgEvent) : void { }
            private function lottery_Handler(evt:TurnTableEvent) : void { }
            private function checkLotteryCondition() : Boolean { return false; }
            private function sendStartLottery() : void { }
            private function updateBtnState(value:Boolean = false) : void { }
            private function addEvents() : void { }
            private function removeEvents() : void { }
            private function __responseHandler(evt:FrameEvent) : void { }
            private function _turntableEnd_Handler(evt:TurnTableEvent) : void { }
            public function getLotteryTicket(id:int = 12554) : int { return 0; }
            private function _lotteryComplate_Handler(evt:TurnTableEvent) : void { }
            private function get isSingleLottery() : Boolean { return false; }
            private function set isSingleLottery(value:Boolean) : void { }
            public function get curLotteryStatus() : int { return 0; }
   }}