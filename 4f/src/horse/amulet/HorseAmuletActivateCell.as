package horse.amulet{   import bagAndInfo.cell.DragEffect;   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.utils.DoubleClickManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.BagInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.BagEvent;   import ddt.manager.DragManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.display.Shape;   import flash.utils.Dictionary;   import horse.HorseAmuletManager;   import horse.data.HorseAmuletVo;      public class HorseAmuletActivateCell extends HorseAmuletCell   {                   private var _bag:BagInfo;            private var _alertFrame:BaseAlerFrame;            private var _oldPlace:int;            private var _newPlace:int;            public function HorseAmuletActivateCell() { super(null,null,null); }
            private function init() : void { }
            override public function dragDrop(effect:DragEffect) : void { }
            private function __updateGoods(evt:BagEvent) : void { }
            protected function __doubleClickHandler(evt:InteractiveEvent) : void { }
            private function __onClickFrame(e:FrameEvent) : void { }
            private function disposeAlertFrame() : void { }
            private function getBagCellIndex() : int { return 0; }
            private function createBg() : Shape { return null; }
            override public function dispose() : void { }
   }}