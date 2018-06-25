package oldPlayerComeBack{   import BombTurnTable.event.TurnTableEvent;   import com.pickgliss.ui.controls.BaseButton;   import ddt.CoreManager;   import ddt.events.CEvent;   import ddt.events.PkgEvent;   import ddt.manager.SocketManager;   import flash.events.Event;   import flash.events.IEventDispatcher;   import hall.HallStateView;   import hallIcon.HallIconManager;   import oldPlayerComeBack.data.AwardItemInfo;   import oldPlayerComeBack.data.ComeBackAwardItemsInfo;   import road7th.comm.PackageIn;   import road7th.utils.DateUtils;      public class OldPlayerComeBackManager extends CoreManager   {            public static const OEPN_VIEW:String = "oldPlayerOpenView";            public static const UPDATE_VIEW:String = "UpdateTurntableView";            public static const ROLL_DICE_RESULT:String = "rollDiceResult";            private static const AWARD_COUNT:int = 35;            private static var _instance:OldPlayerComeBackManager;                   private var _curAwardInfo:ComeBackAwardItemsInfo;            private var _showFlag:Boolean = false;            private var _endDate:Date;            private var _startDate:Date;            private var _hall:HallStateView = null;            private var _iconBtn:BaseButton = null;            public function OldPlayerComeBackManager(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : OldPlayerComeBackManager { return null; }
            public function setup() : void { }
            protected function _isOpen(evt:PkgEvent) : void { }
            public function checkIcon() : void { }
            public function get activityTimeRange() : String { return null; }
            private function __questionInfoHandler(evt:PkgEvent) : void { }
            private function __rollDiceResultHandler(evt:PkgEvent) : void { }
            public function sendRollDice(place:int) : void { }
            public function requestAwardItem() : void { }
            override protected function start() : void { }
            public function get curAwardInfo() : ComeBackAwardItemsInfo { return null; }
            public function set curAwardInfo(value:ComeBackAwardItemsInfo) : void { }
   }}