package auctionHouse.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.auctionHouse.AuctionGoodsInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   
   public class AuctionAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Vector.<AuctionGoodsInfo>;
      
      public var total:int;
      
      public function AuctionAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
   }
}
