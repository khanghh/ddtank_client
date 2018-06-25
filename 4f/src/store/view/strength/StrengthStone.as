package store.view.strength{   import bagAndInfo.cell.DragEffect;   import baglocked.BaglockedManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.DragManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import store.StoneCell;      public class StrengthStone extends StoneCell   {                   private var _stoneType:String = "";            private var _itemType:int = -1;            private var _aler:StrengthSelectNumAlertFrame;            public function StrengthStone(stoneType:Array, i:int) { super(null,null); }
            public function set itemType(value:int) : void { }
            public function get itemType() : int { return 0; }
            public function get stoneType() : String { return null; }
            public function set stoneType(value:String) : void { }
            override public function dragDrop(effect:DragEffect) : void { }
            private function showNumAlert(info:InventoryItemInfo, index:int) : void { }
            private function sellFunction(_nowNum:int, goodsinfo:InventoryItemInfo, index:int) : void { }
            private function notSellFunction() : void { }
            private function reset() : void { }
            override public function dispose() : void { }
   }}