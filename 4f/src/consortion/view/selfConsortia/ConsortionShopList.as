package consortion.view.selfConsortia{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ShopItemInfo;   import flash.display.Sprite;      public class ConsortionShopList extends Sprite implements Disposeable   {                   private var _shopId:int;            private var _items:Array;            private var _list:VBox;            private var _panel:ScrollPanel;            public function ConsortionShopList() { super(); }
            private function init() : void { }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
            public function list($list:Vector.<ShopItemInfo>, shopId:int, richNum:int, enable:Boolean = false) : void { }
            private function clearList() : void { }
   }}