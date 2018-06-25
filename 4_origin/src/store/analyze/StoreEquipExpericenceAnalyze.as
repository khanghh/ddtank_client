package store.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import road7th.data.DictionaryData;
   
   public class StoreEquipExpericenceAnalyze extends DataAnalyzer
   {
       
      
      public var expericence:Array;
      
      public var necklaceStrengthExpList:DictionaryData;
      
      public var necklaceStrengthPlusList:DictionaryData;
      
      public function StoreEquipExpericenceAnalyze(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var NecklaceStrengthExp:int = 0;
         var necklaceStrengthPlus:int = 0;
         var xml:XML = new XML(data);
         expericence = [];
         necklaceStrengthExpList = new DictionaryData();
         necklaceStrengthPlusList = new DictionaryData();
         if(xml.@value == "true")
         {
            xmllist = xml..item;
            for(i = 0; i < xmllist.length(); )
            {
               expericence[i] = int(xmllist[i].@Exp);
               NecklaceStrengthExp = xmllist[i].@NecklaceStrengthExp;
               necklaceStrengthPlus = xmllist[i].@NecklaceStrengthPlus;
               necklaceStrengthExpList.add(i,NecklaceStrengthExp);
               necklaceStrengthPlusList.add(i,necklaceStrengthPlus);
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
