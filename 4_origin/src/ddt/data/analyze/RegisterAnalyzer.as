package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public class RegisterAnalyzer extends DataAnalyzer
   {
       
      
      public function RegisterAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xml:XML = new XML(data);
         var result:String = xml.@value;
         message = xml.@message;
         if(result == "true")
         {
            onAnalyzeComplete();
         }
         else
         {
            onAnalyzeError();
         }
      }
   }
}
