package consortion.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.data.ConsortiaLevelInfo;
   
   public class ConsortionLevelUpAnalyzer extends DataAnalyzer
   {
       
      
      public var levelUpData:Vector.<ConsortiaLevelInfo>;
      
      public function ConsortionLevelUpAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc2_:XML = new XML(param1);
         levelUpData = new Vector.<ConsortiaLevelInfo>();
         if(_loc2_.@value == "true")
         {
            _loc3_ = XML(_loc2_)..Item;
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length())
            {
               _loc4_ = new ConsortiaLevelInfo();
               ObjectUtils.copyPorpertiesByXML(_loc4_,_loc3_[_loc5_]);
               levelUpData.push(_loc4_);
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
