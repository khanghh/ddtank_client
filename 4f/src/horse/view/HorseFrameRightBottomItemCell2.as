package horse.view{   import bagAndInfo.cell.BagCell;   import baglocked.BaglockedManager;   import com.greensock.TweenLite;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.BagEvent;   import ddt.manager.ItemManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.geom.Point;   import shop.manager.ShopBuyManager;      public class HorseFrameRightBottomItemCell2 extends Sprite implements Disposeable   {                   private var _itemCell:BagCell;            private var _buyImage:Bitmap;            private var _itemId:int;            private var _goodsId:int;            private var _isBuy:Boolean;            public function HorseFrameRightBottomItemCell2(itemId:int, goodsId:int = 0, isBuy:Boolean = true) { super(); }
            private function initView() : void { }
            private function updateItemCellCount() : void { }
            private function initEvent() : void { }
            private function itemUpdateHandler(event:BagEvent) : void { }
            private function clickHandler(event:MouseEvent) : void { }
            private function overHandler(event:MouseEvent) : void { }
            private function outHandler(event:MouseEvent) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
            public function get itemCell() : BagCell { return null; }
   }}