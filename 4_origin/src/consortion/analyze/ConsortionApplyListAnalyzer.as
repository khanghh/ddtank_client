package consortion.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.data.ConsortiaApplyInfo;
   
   public class ConsortionApplyListAnalyzer extends DataAnalyzer
   {
       
      
      public var applyList:Vector.<ConsortiaApplyInfo>;
      
      public var totalCount:int;
      
      public function ConsortionApplyListAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         applyList = new Vector.<ConsortiaApplyInfo>();
         var _loc2_:XML = new XML(param1);
         if(_loc2_.@value == "true")
         {
            totalCount = int(_loc2_.@total);
            _loc3_ = XML(_loc2_)..Item;
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length())
            {
               _loc4_ = new ConsortiaApplyInfo();
               ObjectUtils.copyPorpertiesByXML(_loc4_,_loc3_[_loc5_]);
               _loc4_.IsOld = int(_loc3_[_loc5_].@OldPlayer) == 1;
               _loc4_.ddtKingGrade = int(_loc3_[_loc5_].@MaxLevelLevel);
               applyList.push(_loc4_);
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
