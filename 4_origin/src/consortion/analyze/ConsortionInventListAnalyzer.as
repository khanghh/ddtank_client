package consortion.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.data.ConsortiaInventData;
   
   public class ConsortionInventListAnalyzer extends DataAnalyzer
   {
       
      
      public var inventList:Vector.<ConsortiaInventData>;
      
      public var totalCount:int;
      
      public function ConsortionInventListAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc2_:* = null;
         inventList = new Vector.<ConsortiaInventData>();
         var _loc3_:XML = new XML(param1);
         if(_loc3_.@value == "true")
         {
            totalCount = int(_loc3_.@total);
            _loc4_ = XML(_loc3_)..Item;
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length())
            {
               _loc2_ = new ConsortiaInventData();
               ObjectUtils.copyPorpertiesByXML(_loc2_,_loc4_[_loc5_]);
               inventList.push(_loc2_);
               _loc5_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc3_.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
