package consortion.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.rank.RankData;
   
   public class ConsortiaAnalyze extends DataAnalyzer
   {
       
      
      private var _dataList:Array;
      
      public function ConsortiaAnalyze(param1:Function)
      {
         super(param1);
      }
      
      public function get dataList() : Array
      {
         return _dataList;
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc6_:int = 0;
         var _loc2_:* = null;
         _dataList = [];
         var _loc4_:XML = new XML(param1);
         var _loc5_:XMLList = _loc4_.Item;
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length())
         {
            _loc2_ = new RankData();
            ObjectUtils.copyPorpertiesByXML(_loc2_,_loc5_[_loc6_]);
            _dataList.push(_loc2_);
            _loc6_++;
         }
         _dataList.sortOn("Rank",16);
         var _loc8_:int = 0;
         var _loc7_:* = _dataList;
         for each(var _loc3_ in _dataList)
         {
            trace("======>" + _loc3_.Rank);
         }
         onAnalyzeComplete();
      }
   }
}
