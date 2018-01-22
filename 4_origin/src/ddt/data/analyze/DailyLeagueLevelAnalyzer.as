package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.DailyLeagueLevelInfo;
   
   public class DailyLeagueLevelAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Array;
      
      public function DailyLeagueLevelAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc2_:XML = new XML(param1);
         list = [];
         if(_loc2_.@value == "true")
         {
            _loc3_ = _loc2_..item;
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length())
            {
               _loc4_ = new DailyLeagueLevelInfo();
               ObjectUtils.copyPorpertiesByXML(_loc4_,_loc3_[_loc5_]);
               list.push(_loc4_);
               _loc5_++;
            }
            list.sortOn("Score",16);
            onAnalyzeComplete();
         }
         else
         {
            message = _loc2_.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
