package AvatarCollection.data
{
   import AvatarCollection.AvatarCollectionManager;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   
   public class AvatarCollectionItemVo
   {
       
      
      public var id:int;
      
      public var itemId:int;
      
      public var OtherTemplateID:String = "";
      
      public var sex:int;
      
      public var proArea:String;
      
      public var selected:Boolean = false;
      
      public var needGold:int;
      
      public var isActivity:Boolean;
      
      public var buyPrice:int = -1;
      
      public var isDiscount:int = -1;
      
      public var goodsId:int = -1;
      
      private var _canBuyStatus:int = -1;
      
      public var Type:int;
      
      public function AvatarCollectionItemVo()
      {
         super();
      }
      
      public function get activateItem() : InventoryItemInfo
      {
         var i:int = 0;
         var list:Array = OtherTemplateID == ""?[]:OtherTemplateID.split("|");
         var equipBag:BagInfo = PlayerManager.Instance.Self.getBag(0);
         var info:InventoryItemInfo = null;
         list.unshift(itemId);
         for(i = 0; i < list.length; )
         {
            if(int(list[i]) != 0)
            {
               info = equipBag.getItemByTemplateId(int(list[i]));
               if(info != null)
               {
                  break;
               }
            }
            i++;
         }
         return info;
      }
      
      public function get isHas() : Boolean
      {
         return activateItem != null;
      }
      
      public function get itemInfo() : ItemTemplateInfo
      {
         return ItemManager.Instance.getTemplateById(itemId);
      }
      
      public function get canBuyStatus() : int
      {
         var tmp:* = null;
         if(_canBuyStatus == -1)
         {
            tmp = AvatarCollectionManager.instance.getShopItemInfoByItemId(itemId,sex,Type);
            if(tmp)
            {
               _canBuyStatus = 1;
               buyPrice = tmp.getItemPrice(1).moneyValue;
               if(buyPrice <= 0)
               {
                  buyPrice = tmp.getItemPrice(1).bothMoneyValue;
               }
               isDiscount = tmp.isDiscount;
               goodsId = tmp.GoodsID;
            }
            else
            {
               _canBuyStatus = 0;
            }
         }
         return _canBuyStatus;
      }
      
      public function get priceType() : int
      {
         var type:int = 1;
         var tmp:ShopItemInfo = ShopManager.Instance.getGoodsByTempId(itemId);
         if(tmp)
         {
            type = tmp.APrice1 == -8?0:type;
            0;
         }
         return type;
      }
      
      public function set canBuyStatus(value:int) : void
      {
         _canBuyStatus = value;
      }
      
      public function get typeToString() : String
      {
         if(Type == 1)
         {
            return LanguageMgr.GetTranslation("avatarCollection.select.decorate");
         }
         return LanguageMgr.GetTranslation("avatarCollection.select.weapon");
      }
   }
}
