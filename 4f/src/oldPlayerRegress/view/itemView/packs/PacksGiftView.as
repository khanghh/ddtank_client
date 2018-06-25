package oldPlayerRegress.view.itemView.packs{   import bagAndInfo.cell.BagCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.image.ScaleBitmapImage;   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.ItemManager;      public class PacksGiftView extends Frame   {                   private var _packsGiftBgArray:Array;            private var _giftContentList:Vector.<BagCell>;            private var _getGiftData:Vector.<GiftData>;            public function PacksGiftView(giftData:Vector.<GiftData> = null) { super(); }
            private function _init() : void { }
            private function initData() : void { }
            private function initView() : void { }
            public function setGoods(id:int) : InventoryItemInfo { return null; }
            public function setGiftInfo() : void { }
            public function removeGiftChild() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
            public function get getGiftData() : Vector.<GiftData> { return null; }
            public function set getGiftData(value:Vector.<GiftData>) : void { }
   }}