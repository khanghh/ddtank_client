package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public class VoteSubmitResultAnalyzer extends DataAnalyzer
   {
       
      
      public var result:int;
      
      public function VoteSubmitResultAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         result = data;
         onAnalyzeComplete();
      }
   }
}
