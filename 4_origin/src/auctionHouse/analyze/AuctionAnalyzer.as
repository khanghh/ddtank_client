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
         var _loc8_:int = 0;
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         list = new Vector.<AuctionGoodsInfo>();
         var _loc4_:XML = new XML(param1);
         var _loc5_:XMLList = _loc4_.Item;
         total = _loc4_.@total;
         if(_loc4_.@value == "true")
         {
            _loc8_ = 0;
            while(_loc8_ < _loc5_.length())
            {
               _loc7_ = new AuctionGoodsInfo();
               ObjectUtils.copyPorpertiesByXML(_loc7_,_loc5_[_loc8_]);
               _loc6_ = _loc5_[_loc8_].Item;
               if(_loc6_.length() > 0)
               {
                  _loc2_ = new InventoryItemInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc2_,_loc6_[0]);
                  if(_loc2_.BagType != 100)
                  {
                     ItemManager.fill(_loc2_);
                  }
                  else
                  {
                     _loc3_ = ItemManager.fillByID(_loc2_.TemplateID);
                     _loc2_.Name = _loc3_.Name;
                     _loc2_.CategoryID = 74;
                  }
                  _loc7_.BagItemInfo = _loc2_;
                  list.push(_loc7_);
               }
               _loc8_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc4_.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
