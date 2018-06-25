package devilTurn.view{   import bagAndInfo.cell.BagCell;   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.PkgEvent;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.CheckMoneyUtils;   import ddt.utils.ConfirmAlertData;   import ddt.utils.HelperBuyAlert;   import ddt.utils.PositionUtils;   import devilTurn.DevilTurnManager;   import devilTurn.view.mornui.DevilTurnDiceViewUI;   import flash.display.MovieClip;   import flash.display.Shape;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.utils.Timer;   import flash.utils.getTimer;   import morn.core.handlers.Handler;      public class DevilTurnDiceView extends DevilTurnDiceViewUI   {            private static const RANGE_WIDTH:int = 42;            private static var _buyConfirmAlertData:ConfirmAlertData = new ConfirmAlertData();                   private var _cellList:Vector.<BagCell>;            private var _boxList:Array;            private var _id:int;            private var _currentTime:int;            private var _phase:int;            private var _rateCell:BagCell;            private var _isFreeDice:Boolean;            private var _state:int;            private var _money:int;            private var _leftDice:MovieClip;            private var _rightDice:MovieClip;            private var _actionRunning:Boolean;            private var _time:int;            private var _actionTimer:Timer;            private var _leftDiceValue:int;            private var _rightDiceValue:int;            public function DevilTurnDiceView(id:int) { super(); }
            override protected function initialize() : void { }
            private function onClickContinue() : void { }
            private function onClickAbandon() : void { }
            private function __onAlertAbandonView(e:FrameEvent) : void { }
            private function onClickGet() : void { }
            private function __onAlertGetView(e:FrameEvent) : void { }
            private function __onDiceResult(e:PkgEvent) : void { }
            private function playAction(num:int) : void { }
            private function __onPlayRightAction(e:TimerEvent) : void { }
            private function __onAcitonComplate(e:TimerEvent) : void { }
            private function __onUpdateDiceView(e:PkgEvent) : void { }
            private function updateIndex(index:int) : void { }
            private function updateState(state:int) : void { }
            private function updateBoxPhase(phase:int) : void { }
            private function updateRate(rate:int, count:int) : void { }
            private function __onDiceRange(e:PkgEvent) : void { }
            private function updateDiceRange(begin:int, end:int) : void { }
            private function onClickStart() : void { }
            private function getCellBg() : Shape { return null; }
            private function onClickClose() : void { }
            override public function dispose() : void { }
   }}