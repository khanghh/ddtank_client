package giftSystem.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.container.HBox;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ShopItemInfo;   import flash.display.Sprite;   import giftSystem.element.GiftGoodItem;      public class GiftGoodsListView extends Sprite implements Disposeable   {                   private var _containerAll:VBox;            private var _container:Vector.<HBox>;            public function GiftGoodsListView() { super(); }
            private function initView() : void { }
            public function setList(list:Vector.<ShopItemInfo>) : void { }
            private function clear() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}