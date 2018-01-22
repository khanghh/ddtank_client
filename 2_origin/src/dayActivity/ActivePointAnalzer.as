package dayActivity
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class ActivePointAnalzer extends DataAnalyzer
   {
       
      
      public var itemList:Vector.<DayActiveData>;
      
      public function ActivePointAnalzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc6_:int = 0;
         var _loc2_:* = null;
         itemList = new Vector.<DayActiveData>();
         XML.ignoreWhitespace = true;
         var _loc3_:XML = new XML(param1);
         var _loc5_:int = _loc3_.item.length();
         var _loc4_:XMLList = _loc3_..item;
         _loc6_ = 0;
         while(_loc6_ < _loc4_.length())
         {
            _loc2_ = new DayActiveData();
            ObjectUtils.copyPorpertiesByXML(_loc2_,_loc4_[_loc6_]);
            _loc2_.setLong();
            itemList.push(_loc2_);
            _loc6_++;
         }
         onAnalyzeComplete();
      }
   }
}
