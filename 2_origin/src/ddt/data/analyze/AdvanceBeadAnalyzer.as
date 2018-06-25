package ddt.data.analyze
{
   import beadSystem.model.AdvanceBeadInfo;
   import com.pickgliss.loader.DataAnalyzer;
   import road7th.data.DictionaryData;
   
   public class AdvanceBeadAnalyzer extends DataAnalyzer
   {
       
      
      public var list:DictionaryData;
      
      public function AdvanceBeadAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         var xml:XML = new XML(data);
         list = new DictionaryData();
         if(xml.@value == "true")
         {
            xmllist = xml..RuneAdvance;
            for(i = 0; i < xmllist.length(); )
            {
               info = new AdvanceBeadInfo();
               info.advancedTempId = int(xmllist[i].@AdvancedTempId);
               info.runeName = xmllist[i].@RuneName;
               info.advanceDesc = xmllist[i].@AdvanceDesc;
               info.mainMaterials = xmllist[i].@MainMaterials;
               info.quality = int(xmllist[i].@Quality);
               info.maxLevelTempRunId = int(xmllist[i].@MaxLevelTempRunId);
               info.auxiliaryMaterials = xmllist[i].@AuxiliaryMaterials;
               list.add(info.advancedTempId,info);
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
