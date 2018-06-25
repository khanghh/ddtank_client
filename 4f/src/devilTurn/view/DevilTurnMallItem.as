package devilTurn.view{   import bagAndInfo.cell.BagCell;   import baglocked.BaglockedManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import devilTurn.DevilTurnManager;   import devilTurn.event.DevilTurnEvent;   import devilTurn.model.DevilTurnPointShopItem;   import devilTurn.view.mornui.DevilTurnMallItemUI;   import morn.core.handlers.Handler;      public class DevilTurnMallItem extends DevilTurnMallItemUI   {                   private var _info:DevilTurnPointShopItem;            private var _giftCell:BagCell;            private var _lotteryCount:int;            public function DevilTurnMallItem() { super(); }
            override protected function initialize() : void { }
            private function onClickGetGift() : void { }
            public function set info(value:DevilTurnPointShopItem) : void { }
            private function updateView() : void { }
            private function __onUpdateInfo(e:DevilTurnEvent) : void { }
            override public function dispose() : void { }
   }}