package room.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.IconButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ShopCarItemInfo;   import ddt.data.goods.ShopItemInfo;   import ddt.manager.ShopManager;   import ddt.manager.SoundManager;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.MouseEvent;   import room.RoomManager;   import shop.ShopController;   import shop.ShopModel;   import shop.ShopTicketView;   import shop.manager.ShopGiftsManager;   import shop.view.BuySingleGoodsView;      public class RoomTicketView extends Sprite implements Disposeable   {                   private var _bg:ScaleBitmapImage;            private var _buyBtn:IconButton;            private var _giftBtn:IconButton;            private var _buyLight:MovieClip;            private var _giftLight:MovieClip;            private var _shopView:ShopTicketView;            private var _shopController:ShopController;            private var _shopModel:ShopModel;            private var _level:int;            private var _ticketsID:Array;            private var _ticketsFootballID:Array;            private var _view:BuySingleGoodsView;            public function RoomTicketView() { super(); }
            private function preInitializer() : void { }
            private function initializer() : void { }
            private function initialEvent() : void { }
            private function __onBuyBtnClick(event:MouseEvent) : void { }
            private function __onGiftBtnClick(event:MouseEvent) : void { }
            private function removeEvent() : void { }
            public function giftBtnEnable() : void { }
            private function popupShopCard(value:Boolean) : void { }
            private function __onGiftButtonClick(event:MouseEvent) : void { }
            public function setLevel(value:int = -1) : void { }
            public function dispose() : void { }
   }}