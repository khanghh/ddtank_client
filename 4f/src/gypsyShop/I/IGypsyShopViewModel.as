package gypsyShop.I
{
   import ddt.data.goods.InventoryItemInfo;
   import gypsyShop.model.GypsyItemData;
   
   public interface IGypsyShopViewModel
   {
       
      
      function getUpdateTime() : String;
      
      function get itemDataList() : Vector.<GypsyItemData>;
      
      function getRareItemsList() : Vector.<InventoryItemInfo>;
      
      function getHonour() : int;
   }
}
