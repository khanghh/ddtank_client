package ddtBuried.analyer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddtBuried.data.SearchGoodsData;
   
   public class SearchGoodsPayAnalyer extends DataAnalyzer
   {
       
      
      public var itemList:Vector.<SearchGoodsData>;
      
      public function SearchGoodsPayAnalyer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         itemList = new Vector.<SearchGoodsData>();
         var _loc3_:XML = new XML(param1);
         var _loc4_:XMLList = _loc3_.item;
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length())
         {
            _loc2_ = new SearchGoodsData();
            ObjectUtils.copyPorpertiesByXML(_loc2_,_loc4_[_loc5_]);
            itemList.push(_loc2_);
            _loc5_++;
         }
         onAnalyzeComplete();
      }
   }
}
