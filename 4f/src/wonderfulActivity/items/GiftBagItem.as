package wonderfulActivity.items{   import bagAndInfo.cell.BagCell;   import beadSystem.model.BeadInfo;   import com.greensock.TweenLite;   import com.greensock.easing.Quad;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Component;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.EquipType;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.data.goods.QualityType;   import ddt.manager.BeadTemplateManager;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PetInfoManager;   import ddt.view.tips.GoodTipInfo;   import flash.display.Bitmap;   import flash.display.Shape;   import flash.display.Sprite;   import flash.filters.GlowFilter;   import pet.data.PetTemplateInfo;   import wonderfulActivity.data.GiftRewardInfo;      public class GiftBagItem extends Sprite implements Disposeable   {            public static const MOUSE_ON_GLOW_FILTER:Array = [new GlowFilter(16776960,1,8,8,2,2)];                   private var _type:int;            private var _index:int;            private var _bg:Bitmap;            private var _giftBagIcon:Bitmap;            private var _tipSprite:Component;            private var _baseTip:GoodTipInfo;            private var _cell:BagCell;            public function GiftBagItem(type:int, index:int) { super(); }
            private function initView() : void { }
            private function initGiftView() : void { }
            public function set selected(flag:Boolean) : void { }
            public function setData(giftBagVec:Vector.<GiftRewardInfo>) : void { }
            private function updateGoodsView(goods:GiftRewardInfo) : void { }
            private function updateGiftView(giftBagVec:Vector.<GiftRewardInfo>) : void { }
            public function dispose() : void { }
            private function addEvents() : void { }
            private function removeEvents() : void { }
            public function get index() : int { return 0; }
   }}