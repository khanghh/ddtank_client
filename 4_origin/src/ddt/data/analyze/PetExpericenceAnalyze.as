package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public class PetExpericenceAnalyze extends DataAnalyzer
   {
       
      
      public var expericence:Array;
      
      public function PetExpericenceAnalyze(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var xml:XML = new XML(data);
         expericence = [];
         if(xml.@value == "true")
         {
            xmllist = xml..item;
            for(i = 0; i < xmllist.length(); )
            {
               expericence.push(int(xmllist[i].@GP));
               i++;
            }
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
