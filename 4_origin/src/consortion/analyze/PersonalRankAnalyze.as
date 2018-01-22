package consortion.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.rank.RankData;
   
   public class PersonalRankAnalyze extends DataAnalyzer
   {
       
      
      private var _dataList:Array;
      
      public function PersonalRankAnalyze(param1:Function)
      {
         super(param1);
      }
      
      public function get dataList() : Array
      {
         return _dataList;
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         _dataList = [];
         var _loc3_:XML = new XML(param1);
         var _loc4_:XMLList = _loc3_.Item;
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length())
         {
            _loc2_ = new RankData();
            ObjectUtils.copyPorpertiesByXML(_loc2_,_loc4_[_loc5_]);
            _dataList.push(_loc2_);
            _loc5_++;
         }
         _dataList.sortOn("Rank",16);
         onAnalyzeComplete();
      }
   }
}
