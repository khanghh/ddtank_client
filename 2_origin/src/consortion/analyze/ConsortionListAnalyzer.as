package consortion.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.ConsortiaInfo;
   
   public class ConsortionListAnalyzer extends DataAnalyzer
   {
       
      
      public var consortionList:Vector.<ConsortiaInfo>;
      
      public var consortionsTotalCount:int;
      
      public function ConsortionListAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         consortionList = new Vector.<ConsortiaInfo>();
         var _loc2_:XML = new XML(param1);
         if(_loc2_.@value == "true")
         {
            consortionsTotalCount = int(_loc2_.@total);
            _loc3_ = _loc2_..Item;
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length())
            {
               _loc4_ = new ConsortiaInfo();
               _loc4_.beginChanges();
               ObjectUtils.copyPorpertiesByXML(_loc4_,_loc3_[_loc5_]);
               _loc4_.commitChanges();
               consortionList.push(_loc4_);
               _loc5_++;
            }
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
