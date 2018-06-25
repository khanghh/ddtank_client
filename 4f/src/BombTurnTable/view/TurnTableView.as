package BombTurnTable.view{   import BombTurnTable.BombTurnTableControls;   import BombTurnTable.data.BombTurnTableFactory;   import BombTurnTable.data.BombTurnTableInfo;   import BombTurnTable.event.TurnTableEvent;   import BombTurnTable.view.quality.BaseTurnTable;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.ServerConfigManager;   import flash.display.Sprite;      public class TurnTableView extends Sprite implements Disposeable   {                   private var _curTurnTable:BaseTurnTable = null;            private var _curData:BombTurnTableInfo = null;            private var _control:BombTurnTableControls;            public function TurnTableView(control:BombTurnTableControls) { super(); }
            public function updateView(data:BombTurnTableInfo) : void { }
            public function updateLotteryTicket(value:int) : void { }
            protected function clickLottery_Handler(evt:TurnTableEvent) : void { }
            public function startLottery(id:int) : void { }
            public function updateTurnTableBtnStatus(isContinuons:Boolean) : void { }
            public function lotteryComplate_Handler(evt:TurnTableEvent) : void { }
            public function dispose() : void { }
   }}