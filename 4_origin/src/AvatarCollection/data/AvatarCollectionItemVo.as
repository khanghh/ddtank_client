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
         var _loc3_:int = 0;
         var _loc2_:Array = OtherTemplateID == ""?[]:OtherTemplateID.split("|");
         var _loc1_:BagInfo = PlayerManager.Instance.Self.getBag(0);
         var _loc4_:InventoryItemInfo = null;
         _loc2_.unshift(itemId);
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(int(_loc2_[_loc3_]) != 0)
            {
               _loc4_ = _loc1_.getItemByTemplateId(int(_loc2_[_loc3_]));
               if(_loc4_ != null)
               {
                  break;
               }
            }
            _loc3_++;
         }
         return _loc4_;
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
         var _loc1_:* = null;
         if(_canBuyStatus == -1)
         {
            _loc1_ = AvatarCollectionManager.instance.getShopItemInfoByItemId(itemId,sex,Type);
            if(_loc1_)
            {
               _canBuyStatus = 1;
               buyPrice = _loc1_.getItemPrice(1).moneyValue;
               if(buyPrice <= 0)
               {
                  buyPrice = _loc1_.getItemPrice(1).bothMoneyValue;
               }
               isDiscount = _loc1_.isDiscount;
               goodsId = _loc1_.GoodsID;
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
         var _loc2_:int = 1;
         var _loc1_:ShopItemInfo = ShopManager.Instance.getGoodsByTempId(itemId);
         if(_loc1_)
         {
            _loc2_ = _loc1_.APrice1 == -8?0:_loc2_;
            0;
         }
         return _loc2_;
      }
      
      public function set canBuyStatus(param1:int) : void
      {
         _canBuyStatus = param1;
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
