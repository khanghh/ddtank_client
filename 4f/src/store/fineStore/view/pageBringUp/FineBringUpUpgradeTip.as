package store.fineStore.view.pageBringUp{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.image.Image;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.ItemManager;   import ddt.view.tips.GoodTip;   import ddt.view.tips.GoodTipInfo;   import flash.display.Bitmap;      public class FineBringUpUpgradeTip extends GoodTip   {                   private var _upgradeBeadTip:GoodTip;            public function FineBringUpUpgradeTip() { super(); }
            override protected function init() : void { }
            override protected function addChildren() : void { }
            override public function set tipData(data:Object) : void { }
            override public function showTip(info:ItemTemplateInfo, typeIsSecond:Boolean = false) : void { }
            private function bringUpUpgradeTip(pTipInfo:GoodTipInfo) : void { }
            override public function dispose() : void { }
   }}