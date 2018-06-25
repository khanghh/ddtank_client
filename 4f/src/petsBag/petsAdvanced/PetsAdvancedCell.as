package petsBag.petsAdvanced{   import bagAndInfo.cell.BagCell;   import baglocked.BaglockedManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.command.QuickBuyAlertBase;   import ddt.data.BagInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ShopItemInfo;   import ddt.events.BagEvent;   import ddt.manager.ItemManager;   import ddt.manager.PlayerManager;   import ddt.manager.ShopManager;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.utils.Dictionary;      public class PetsAdvancedCell extends Sprite implements Disposeable   {            public static const UPDATEED:String = "pac_updated";                   private var _buyBtn:SimpleBitmapButton;            private var _bagCell:BagCell;            private var _count:int;            public function PetsAdvancedCell() { super(); }
            private function initView() : void { }
            public function set info(value:InventoryItemInfo) : void { }
            public function getExpOfBagcell() : int { return 0; }
            public function getTempleteId() : int { return 0; }
            public function getPropName() : String { return null; }
            public function getCount() : int { return 0; }
            public function updateCount() : void { }
            private function addEvent() : void { }
            protected function __updateBag(event:BagEvent) : void { }
            protected function __outHandler(event:MouseEvent) : void { }
            protected function __overHandler(event:MouseEvent) : void { }
            protected function __buyHandler(event:MouseEvent) : void { }
            private function removeEvent() : void { }
            public function get buyBtn() : SimpleBitmapButton { return null; }
            public function set buyBtn(value:SimpleBitmapButton) : void { }
            public function dispose() : void { }
   }}