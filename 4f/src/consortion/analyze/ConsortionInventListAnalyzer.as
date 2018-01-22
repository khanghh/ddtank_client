package consortion.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.data.ConsortiaInventData;
   
   public class ConsortionInventListAnalyzer extends DataAnalyzer
   {
       
      
      public var inventList:Vector.<ConsortiaInventData>;
      
      public var totalCount:int;
      
      public function ConsortionInventListAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
   }
}
