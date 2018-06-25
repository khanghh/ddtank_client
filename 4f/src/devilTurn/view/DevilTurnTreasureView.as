package devilTurn.view{   import baglocked.BaglockedManager;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.EquipType;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import ddt.utils.CheckMoneyUtils;   import ddt.utils.ConfirmAlertData;   import ddt.utils.HelperBuyAlert;   import ddt.utils.PositionUtils;   import ddt.view.tips.GoodTipInfo;   import devilTurn.DevilTurnManager;   import devilTurn.event.DevilTurnEvent;   import devilTurn.model.DevilTurnBoxItem;   import devilTurn.model.DevilTurnModel;   import devilTurn.model.DevilTurnRankInfo;   import devilTurn.model.DevilTurnRankRewardItem;   import devilTurn.view.mornui.DevilTurnTreasureViewUI;   import flash.events.TimerEvent;   import flash.utils.Timer;   import flash.utils.getTimer;   import morn.core.components.Box;   import morn.core.components.Label;   import morn.core.handlers.Handler;   import road7th.utils.DateUtils;      public class DevilTurnTreasureView extends DevilTurnTreasureViewUI   {            private static var _buyConfirmAlertData:ConfirmAlertData = new ConfirmAlertData();                   private var _model:DevilTurnModel;            private var _lotteryView:DevilTurnLotteryView;            private var _totalFreeLotteryTimes:int;            private var _timer:Timer;            private var _currentTime:int;            private var _jackpotTimer:Timer;            private var _type:int;            public function DevilTurnTreasureView() { super(); }
            override protected function preinitialize() : void { }
            override protected function initialize() : void { }
            private function onContinuousClick() : void { }
            private function __onUpdateActivityState(e:DevilTurnEvent) : void { }
            private function _onJackpotTimer(e:TimerEvent) : void { }
            private function __onTimer(e:TimerEvent) : void { }
            private function updateViewInfo() : void { }
            private function __onUpdateInfo(e:DevilTurnEvent) : void { }
            private function __onUpdateRankInfo(e:DevilTurnEvent) : void { }
            private function __onUpdateJackpot(e:DevilTurnEvent) : void { }
            private function onRenderBoxConver(item:Box, index:int) : void { }
            private function onRenderRankList(item:Box, index:int) : void { }
            private function onRenderRankAwardList(item:Box, index:int) : void { }
            private function onOpenShopView() : void { }
            private function onOpenBoxConversionView() : void { }
            private function onClickSelectRankList(index:int) : void { }
            private function onClickSacrifice(type:int) : void { }
            public function get isRunning() : Boolean { return false; }
            public function get isContinue() : Boolean { return false; }
            public function continueLottery() : void { }
            override public function dispose() : void { }
   }}