package room.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopCarItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import room.RoomManager;
   import shop.ShopController;
   import shop.ShopModel;
   import shop.ShopTicketView;
   import shop.manager.ShopGiftsManager;
   import shop.view.BuySingleGoodsView;
   
   public class RoomTicketView extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _buyBtn:IconButton;
      
      private var _giftBtn:IconButton;
      
      private var _buyLight:MovieClip;
      
      private var _giftLight:MovieClip;
      
      private var _shopView:ShopTicketView;
      
      private var _shopController:ShopController;
      
      private var _shopModel:ShopModel;
      
      private var _level:int;
      
      private var _ticketsID:Array;
      
      private var _ticketsFootballID:Array;
      
      private var _view:BuySingleGoodsView;
      
      public function RoomTicketView()
      {
         _ticketsID = [200619,200620,200621,200622,0,201105];
         _ticketsFootballID = [0,201279,201280,201281,0,0];
         super();
         preInitializer();
         initializer();
         initialEvent();
      }
      
      private function preInitializer() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("asset.warriorsArena.Bg");
         _buyLight = ComponentFactory.Instance.creat("asset.warriorsArena.buyButton.Light");
         _giftLight = ComponentFactory.Instance.creat("asset.warriorsArena.giftButton.Light");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("asset.warriorsArena.buyButton");
         _giftBtn = ComponentFactory.Instance.creatComponentByStylename("asset.warriorsArena.giftButton");
         _shopView = new ShopTicketView();
         _shopController = new ShopController();
         _shopModel = new ShopModel();
      }
      
      private function initializer() : void
      {
         addChild(_bg);
         addChild(_buyBtn);
         addChild(_giftBtn);
         var _loc1_:Boolean = false;
         _buyLight.mouseEnabled = _loc1_;
         _buyLight.mouseChildren = _loc1_;
         _buyLight.x = _buyBtn.x;
         _buyLight.y = _buyBtn.y;
         addChild(_buyLight);
         _loc1_ = false;
         _giftLight.mouseEnabled = _loc1_;
         _giftLight.mouseChildren = _loc1_;
         _giftLight.x = _giftBtn.x;
         _giftLight.y = _giftBtn.y;
         addChild(_giftLight);
      }
      
      private function initialEvent() : void
      {
         _buyBtn.addEventListener("click",__onBuyBtnClick);
         _giftBtn.addEventListener("click",__onGiftBtnClick);
      }
      
      private function __onBuyBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc3_:int = 0;
         if(RoomManager.Instance.current.mapId == 14)
         {
            _loc3_ = _ticketsFootballID[RoomManager.Instance.current.hardLevel];
         }
         else if(RoomManager.Instance.current.mapId == 15001)
         {
            _loc3_ = 201628;
         }
         else if(RoomManager.Instance.current.mapId == 16001)
         {
            _loc3_ = 201629;
         }
         else
         {
            _loc3_ = _ticketsID[RoomManager.Instance.current.hardLevel];
         }
         var _loc2_:ShopItemInfo = ShopManager.Instance.getGoodsByTemplateID(_loc3_);
         _view = new BuySingleGoodsView(_loc2_.APrice1);
         _view.goodsID = _loc3_;
         LayerManager.Instance.addToLayer(_view,3,true,1);
      }
      
      private function __onGiftBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(RoomManager.Instance.current.mapId == 14)
         {
            ShopGiftsManager.Instance.buy(_ticketsFootballID[RoomManager.Instance.current.hardLevel],false,2);
         }
         else if(RoomManager.Instance.current.mapId == 15001)
         {
            ShopGiftsManager.Instance.buy(201628,false,2);
         }
         else if(RoomManager.Instance.current.mapId == 16001)
         {
            ShopGiftsManager.Instance.buy(201629,false,2);
         }
         else
         {
            ShopGiftsManager.Instance.buy(_ticketsID[RoomManager.Instance.current.hardLevel],false,2);
         }
      }
      
      private function removeEvent() : void
      {
         _buyBtn.removeEventListener("click",__onBuyBtnClick);
         _giftBtn.removeEventListener("click",__onGiftBtnClick);
      }
      
      public function giftBtnEnable() : void
      {
         var _loc1_:int = 0;
         if(RoomManager.Instance.current.mapId == 14)
         {
            _loc1_ = _ticketsFootballID[RoomManager.Instance.current.hardLevel];
         }
         else
         {
            _loc1_ = _ticketsID[RoomManager.Instance.current.hardLevel];
         }
         var _loc2_:ShopItemInfo = ShopManager.Instance.getGoodsByTemplateID(_loc1_);
         if(_loc2_ && String(_loc2_.GoodsID).slice(-2) == "02")
         {
            _giftBtn.enable = false;
            _giftLight.visible = false;
            _giftBtn.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
         else
         {
            _giftBtn.enable = true;
            _giftLight.visible = true;
            _giftBtn.filters = null;
         }
      }
      
      private function popupShopCard(param1:Boolean) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         ObjectUtils.disposeObject(_buyLight);
         _buyLight = null;
         var _loc4_:Array = [];
         _loc3_ = ShopManager.Instance.getGoodsByTemplateID(_ticketsID[RoomManager.Instance.current.hardLevel]);
         _loc2_ = new ShopCarItemInfo(_loc3_.GoodsID,_loc3_.TemplateID);
         ObjectUtils.copyProperties(_loc2_,_loc3_);
         _loc4_.push(_loc2_);
         _shopView.initialize(_loc4_);
         _shopView.setType(param1);
         LayerManager.Instance.addToLayer(_shopView,3,true,1);
      }
      
      private function __onGiftButtonClick(param1:MouseEvent) : void
      {
         ObjectUtils.disposeObject(_giftLight);
         _giftLight = null;
      }
      
      public function setLevel(param1:int = -1) : void
      {
         if(param1 > 0 && param1 <= _ticketsID.length)
         {
            _level = param1;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_buyLight);
         _buyLight = null;
         ObjectUtils.disposeObject(_giftLight);
         _giftLight = null;
         removeEvent();
         _view = null;
         if(_buyBtn.parent)
         {
            _buyBtn.parent.removeChild(_buyBtn);
         }
         _buyBtn = null;
         if(_giftBtn.parent)
         {
            _giftBtn.parent.removeChild(_giftBtn);
         }
         _giftBtn = null;
         if(_bg.parent)
         {
            _bg.parent.removeChild(_bg);
         }
         _bg = null;
      }
   }
}
