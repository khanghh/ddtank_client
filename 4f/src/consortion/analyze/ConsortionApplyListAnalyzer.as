package consortion.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.data.ConsortiaApplyInfo;
   
   public class ConsortionApplyListAnalyzer extends DataAnalyzer
   {
       
      
      public var applyList:Vector.<ConsortiaApplyInfo>;
      
      public var totalCount:int;
      
      public function ConsortionApplyListAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
   }
}
