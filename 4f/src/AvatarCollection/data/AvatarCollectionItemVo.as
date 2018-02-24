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
      
      public function AvatarCollectionItemVo(){super();}
      
      public function get activateItem() : InventoryItemInfo{return null;}
      
      public function get isHas() : Boolean{return false;}
      
      public function get itemInfo() : ItemTemplateInfo{return null;}
      
      public function get canBuyStatus() : int{return 0;}
      
      public function get priceType() : int{return 0;}
      
      public function set canBuyStatus(param1:int) : void{}
      
      public function get typeToString() : String{return null;}
   }
}
