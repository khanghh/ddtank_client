package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public class VoteSubmitAnalyzer extends DataAnalyzer
   {
      
      public static const FILENAME:String = "vote.xml";
       
      
      public var result:String = "";
      
      public function VoteSubmitAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         if(data != -1)
         {
            result = data;
            onAnalyzeComplete();
         }
         else
         {
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
