package consortion.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.ConsortiaInfo;
   
   public class ConsortionListAnalyzer extends DataAnalyzer
   {
       
      
      public var consortionList:Vector.<ConsortiaInfo>;
      
      public var consortionsTotalCount:int;
      
      public function ConsortionListAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
   }
}
