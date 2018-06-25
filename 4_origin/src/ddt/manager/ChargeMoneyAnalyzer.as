package ddt.manager
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public class ChargeMoneyAnalyzer extends DataAnalyzer
   {
       
      
      public var result:Boolean;
      
      public function ChargeMoneyAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            result = true;
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
