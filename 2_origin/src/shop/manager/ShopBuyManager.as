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
      
      public static function calcPrices(list:Vector.<ShopCarItemInfo>, isBindList:Array = null) : Array
      {
         var i:int = 0;
         var totalPrice:ItemPrice = new ItemPrice(null,null,null);
         var g:int = 0;
         var m:int = 0;
         var l:int = 0;
         var b:int = 0;
         for(i = 0; i < list.length; )
         {
            if(isBindList && isBindList[i])
            {
               totalPrice.addItemPrice(list[i].getCurrentPrice(),isBindList[i]);
            }
            else
            {
               totalPrice.addItemPrice(list[i].getCurrentPrice());
            }
            i++;
         }
         g = totalPrice.goldValue;
         m = totalPrice.bothMoneyValue;
         l = totalPrice.ddtPetScoreValue;
         b = totalPrice.bandDdtMoneyValue;
         return [g,m,l,b];
      }
      
      public function buy($goodsID:int, isDiscount:int = 1, type:int = 1, isSale:Boolean = false) : void
      {
         view = new BuySingleGoodsView(type);
         LayerManager.Instance.addToLayer(view,3,true,1);
         BuySingleGoodsView(view).isDisCount = isDiscount == 1?false:true;
         BuySingleGoodsView(view).isSale = isSale;
         BuySingleGoodsView(view).goodsID = $goodsID;
      }
      
      public function buyFarmShop($goodsID:int) : void
      {
         farmview = ComponentFactory.Instance.creatComponentByStylename("farm.farmShopPayPnl.shopPay");
         FarmShopPayPnl(farmview).goodsID = $goodsID;
         LayerManager.Instance.addToLayer(farmview,3,true,1);
      }
      
      public function buyAvatar(info:PlayerInfo) : void
      {
         var shopitem:* = null;
         var shopCarItem:* = null;
         var items:Array = [];
         var buyArr:Vector.<ShopCarItemInfo> = new Vector.<ShopCarItemInfo>();
         if(info.Bag.items[0])
         {
            items.push(info.Bag.items[0]);
         }
         if(info.Bag.items[1])
         {
            items.push(info.Bag.items[1]);
         }
         if(info.Bag.items[2])
         {
            items.push(info.Bag.items[2]);
         }
         if(info.Bag.items[3])
         {
            items.push(info.Bag.items[3]);
         }
         if(info.Bag.items[4])
         {
            items.push(info.Bag.items[4]);
         }
         if(info.Bag.items[5])
         {
            items.push(info.Bag.items[5]);
         }
         if(info.Bag.items[11])
         {
            items.push(info.Bag.items[11]);
         }
         if(info.Bag.items[13])
         {
            items.push(info.Bag.items[13]);
         }
         var _loc8_:int = 0;
         var _loc7_:* = items;
         for each(var item in items)
         {
            shopitem = ShopManager.Instance.getMoneyShopItemByTemplateID(item.TemplateID,true);
            if(shopitem == null)
            {
               shopitem = ShopManager.Instance.getGiftShopItemByTemplateID(item.TemplateID,true);
            }
            if(shopitem != null)
            {
               shopCarItem = new ShopCarItemInfo(shopitem.GoodsID,shopitem.TemplateID);
               ObjectUtils.copyProperties(shopCarItem,shopitem);
               shopCarItem.Color = item.Color;
               shopCarItem.skin = item.Skin;
               buyArr.push(shopCarItem);
            }
         }
         if(buyArr.length == 0 || buyArr.length < items.length)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.buyAvatarFail"));
         }
         if(buyArr.length > 0)
         {
            buyMutiGoods(buyArr);
         }
      }
      
      public function buyMutiGoods(goods:Vector.<ShopCarItemInfo>) : void
      {
         view = new BuyMultiGoodsView();
         BuyMultiGoodsView(view).setGoods(goods);
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
