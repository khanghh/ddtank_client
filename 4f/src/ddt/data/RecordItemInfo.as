package ddt.data
{
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.ShopManager;
   
   public class RecordItemInfo
   {
       
      
      public var name:String = "";
      
      public var playerID:int;
      
      public var TemplateID:int = 0;
      
      public var Receive:int;
      
      public var count:int = 0;
      
      public function RecordItemInfo(){super();}
      
      public function get info() : ShopItemInfo{return null;}
   }
}
