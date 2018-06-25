package devilTurn.view{   import bagAndInfo.cell.BagCell;   import baglocked.BaglockedManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import devilTurn.DevilTurnManager;   import devilTurn.model.DevilTurnBoxItem;   import devilTurn.model.DevilTurnModel;   import devilTurn.view.mornui.DevilTurnBoxConvertItemUI;   import flash.display.Shape;   import morn.core.components.Box;   import morn.core.components.Clip;   import morn.core.components.Label;   import morn.core.handlers.Handler;      public class DevilTurnBoxConvertItem extends DevilTurnBoxConvertItemUI   {                   private var _model:DevilTurnModel;            private var _giftCell:BagCell;            private var _info:DevilTurnBoxItem;            public function DevilTurnBoxConvertItem() { super(); }
            override protected function preinitialize() : void { }
            override protected function initialize() : void { }
            private function onBeadListRender(item:Box, index:int) : void { }
            public function set info(value:DevilTurnBoxItem) : void { }
            private function get beadConverList() : Array { return null; }
            private function onClickConvertBtn() : void { }
            override public function dispose() : void { }
   }}