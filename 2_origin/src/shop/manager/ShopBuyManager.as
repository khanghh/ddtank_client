package shop.manager
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemPrice;
   import ddt.data.goods.ShopCarItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.ShopManager;
   import farm.viewx.shop.FarmShopPayPnl;
   import flash.display.DisplayObject;
   import shop.view.BuyMultiGoodsView;
   import shop.view.BuySingleGoodsView;
   
   public class ShopBuyManager
   {
      
      private static var _instance:ShopBuyManager;
      
      public static var crrItemId:int;
       
      
      private var view:DisplayObject;
      
      private var farmview:DisplayObject;
      
      public function ShopBuyManager()
      {
         super();
      }
      
      public static function get Instance() : ShopBuyManager
      {
         if(_instance == null)
         {
            _instance = new ShopBuyManager();
         }
         return _instance;
      }
      
      public static function calcPrices(param1:Vector.<ShopCarItemInfo>, param2:Array = null) : Array
      {
         var _loc7_:int = 0;
         var _loc8_:ItemPrice = new ItemPrice(null,null,null);
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < param1.length)
         {
            if(param2 && param2[_loc7_])
            {
               _loc8_.addItemPrice(param1[_loc7_].getCurrentPrice(),param2[_loc7_]);
            }
            else
            {
               _loc8_.addItemPrice(param1[_loc7_].getCurrentPrice());
            }
            _loc7_++;
         }
         _loc3_ = _loc8_.goldValue;
         _loc6_ = _loc8_.bothMoneyValue;
         _loc5_ = _loc8_.ddtPetScoreValue;
         _loc4_ = _loc8_.bandDdtMoneyValue;
         return [_loc3_,_loc6_,_loc5_,_loc4_];
      }
      
      public function buy(param1:int, param2:int = 1, param3:int = 1, param4:Boolean = false) : void
      {
         view = new BuySingleGoodsView(param3);
         LayerManager.Instance.addToLayer(view,3,true,1);
         BuySingleGoodsView(view).isDisCount = param2 == 1?false:true;
         BuySingleGoodsView(view).isSale = param4;
         BuySingleGoodsView(view).goodsID = param1;
      }
      
      public function buyFarmShop(param1:int) : void
      {
         farmview = ComponentFactory.Instance.creatComponentByStylename("farm.farmShopPayPnl.shopPay");
         FarmShopPayPnl(farmview).goodsID = param1;
         LayerManager.Instance.addToLayer(farmview,3,true,1);
      }
      
      public function buyAvatar(param1:PlayerInfo) : void
      {
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc2_:Array = [];
         var _loc5_:Vector.<ShopCarItemInfo> = new Vector.<ShopCarItemInfo>();
         if(param1.Bag.items[0])
         {
            _loc2_.push(param1.Bag.items[0]);
         }
         if(param1.Bag.items[1])
         {
            _loc2_.push(param1.Bag.items[1]);
         }
         if(param1.Bag.items[2])
         {
            _loc2_.push(param1.Bag.items[2]);
         }
         if(param1.Bag.items[3])
         {
            _loc2_.push(param1.Bag.items[3]);
         }
         if(param1.Bag.items[4])
         {
            _loc2_.push(param1.Bag.items[4]);
         }
         if(param1.Bag.items[5])
         {
            _loc2_.push(param1.Bag.items[5]);
         }
         if(param1.Bag.items[11])
         {
            _loc2_.push(param1.Bag.items[11]);
         }
         if(param1.Bag.items[13])
         {
            _loc2_.push(param1.Bag.items[13]);
         }
         var _loc8_:int = 0;
         var _loc7_:* = _loc2_;
         for each(var _loc3_ in _loc2_)
         {
            _loc4_ = ShopManager.Instance.getMoneyShopItemByTemplateID(_loc3_.TemplateID,true);
            if(_loc4_ == null)
            {
               _loc4_ = ShopManager.Instance.getGiftShopItemByTemplateID(_loc3_.TemplateID,true);
            }
            if(_loc4_ != null)
            {
               _loc6_ = new ShopCarItemInfo(_loc4_.GoodsID,_loc4_.TemplateID);
               ObjectUtils.copyProperties(_loc6_,_loc4_);
               _loc6_.Color = _loc3_.Color;
               _loc6_.skin = _loc3_.Skin;
               _loc5_.push(_loc6_);
            }
         }
         if(_loc5_.length == 0 || _loc5_.length < _loc2_.length)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.buyAvatarFail"));
         }
         if(_loc5_.length > 0)
         {
            buyMutiGoods(_loc5_);
         }
      }
      
      public function buyMutiGoods(param1:Vector.<ShopCarItemInfo>) : void
      {
         view = new BuyMultiGoodsView();
         BuyMultiGoodsView(view).setGoods(param1);
         BuyMultiGoodsView(view).show();
      }
      
      public function get isShow() : Boolean
      {
         return view && view.parent;
      }
      
      public function dispose() : void
      {
         if(view && view.parent)
         {
            Disposeable(view).dispose();
            view = null;
         }
         if(farmview && farmview.parent)
         {
            Disposeable(farmview).dispose();
            farmview = null;
         }
      }
   }
}
