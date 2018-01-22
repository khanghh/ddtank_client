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
      
      public function AuctionAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc2_:* = null;
         list = new Vector.<AuctionGoodsInfo>();
         var _loc3_:XML = new XML(param1);
         var _loc4_:XMLList = _loc3_.Item;
         total = _loc3_.@total;
         if(_loc3_.@value == "true")
         {
            _loc7_ = 0;
            while(_loc7_ < _loc4_.length())
            {
               _loc6_ = new AuctionGoodsInfo();
               ObjectUtils.copyPorpertiesByXML(_loc6_,_loc4_[_loc7_]);
               _loc5_ = _loc4_[_loc7_].Item;
               if(_loc5_.length() > 0)
               {
                  _loc2_ = new InventoryItemInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc2_,_loc5_[0]);
                  ItemManager.fill(_loc2_);
                  _loc6_.BagItemInfo = _loc2_;
                  list.push(_loc6_);
               }
               _loc7_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc3_.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
