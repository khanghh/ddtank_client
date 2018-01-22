package Indiana.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class IndianaShopItemsAnalyzer extends DataAnalyzer
   {
       
      
      public var itemList:Vector.<IndianaShopItemInfo>;
      
      public function IndianaShopItemsAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc2_:* = null;
         var _loc6_:int = 0;
         XML.ignoreWhitespace = true;
         itemList = new Vector.<IndianaShopItemInfo>();
         var _loc3_:XML = new XML(param1);
         var _loc5_:int = _loc3_.item.length();
         var _loc4_:XMLList = _loc3_..Item;
         _loc6_ = 0;
         while(_loc6_ < _loc4_.length())
         {
            _loc2_ = new IndianaShopItemInfo();
            ObjectUtils.copyPorpertiesByXML(_loc2_,_loc4_[_loc6_]);
            itemList.push(_loc2_);
            _loc6_++;
         }
         onAnalyzeComplete();
      }
      
      public function get data() : Vector.<IndianaShopItemInfo>
      {
         return itemList;
      }
   }
}
