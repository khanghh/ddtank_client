package beadSystem.tips{   import beadSystem.views.BeadUpgradeTipView;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.BeadTemplateManager;   import ddt.view.tips.GoodTip;   import ddt.view.tips.GoodTipInfo;      public class BeadUpgradeTip extends GoodTip   {                   private var _upgradeBeadTip:BeadUpgradeTipView;            public function BeadUpgradeTip() { super(); }
            override protected function init() : void { }
            override protected function addChildren() : void { }
            override public function set tipData(data:Object) : void { }
            override public function showTip(info:ItemTemplateInfo, typeIsSecond:Boolean = false) : void { }
            private function beadUpgradeTip(pTipInfo:GoodTipInfo) : void { }
            override public function dispose() : void { }
   }}