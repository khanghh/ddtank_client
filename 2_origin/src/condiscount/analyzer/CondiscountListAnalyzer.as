package condiscount.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import condiscount.data.CondiscountInfo;
   
   public class CondiscountListAnalyzer extends DataAnalyzer
   {
       
      
      public var itemList:Vector.<CondiscountInfo>;
      
      public function CondiscountListAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc6_:int = 0;
         var _loc2_:* = null;
         itemList = new Vector.<CondiscountInfo>();
         var _loc3_:XML = new XML(param1);
         var _loc5_:int = _loc3_.Item.length();
         var _loc4_:XMLList = _loc3_..Item;
         _loc6_ = 0;
         while(_loc6_ < _loc4_.length())
         {
            _loc2_ = new CondiscountInfo();
            itemList.push(_loc2_);
            _loc6_++;
         }
         onAnalyzeComplete();
      }
   }
}
