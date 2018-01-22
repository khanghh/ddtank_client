package dayActivity
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class ActivityRewardAnalyzer extends DataAnalyzer
   {
       
      
      public var itemList:Vector.<DayRewaidData>;
      
      public function ActivityRewardAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc6_:int = 0;
         var _loc2_:* = null;
         XML.ignoreWhitespace = true;
         itemList = new Vector.<DayRewaidData>();
         var _loc3_:XML = new XML(param1);
         var _loc5_:int = _loc3_.item.length();
         var _loc4_:XMLList = _loc3_..item;
         _loc6_ = 0;
         while(_loc6_ < _loc4_.length())
         {
            _loc2_ = new DayRewaidData();
            ObjectUtils.copyPorpertiesByXML(_loc2_,_loc4_[_loc6_]);
            itemList.push(_loc2_);
            _loc6_++;
         }
         onAnalyzeComplete();
      }
   }
}
