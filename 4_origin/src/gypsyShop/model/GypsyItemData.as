package gypsyShop.model
{
   public class GypsyItemData
   {
       
      
      public var id:int;
      
      public var infoID:int;
      
      public var num:int = 0;
      
      public var type:int = 0;
      
      public var unit:int = 0;
      
      public var canBuy:int = 0;
      
      public var price:int = 1;
      
      public var quality:int = 0;
      
      public function GypsyItemData($id:int, $unit:int, $price:int, $type:int, $infoID:int, $num:int, $canBuy:int, $quality:int)
      {
         super();
         id = $id;
         unit = $unit;
         infoID = $infoID;
         num = $num;
         type = $type;
         price = $price;
         canBuy = $canBuy;
         quality = $quality;
      }
   }
}
