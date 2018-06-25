package explorerManual.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import explorerManual.data.model.ManualLevelInfo;
   import road7th.data.DictionaryData;
   
   public class ManualLevelAnalyzer extends DataAnalyzer
   {
       
      
      private var _data:DictionaryData;
      
      public function ManualLevelAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var tmpVo:* = null;
         _data = new DictionaryData();
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               tmpVo = new ManualLevelInfo();
               ObjectUtils.copyPorpertiesByXML(tmpVo,xmllist[i]);
               _data.add(tmpVo.level,tmpVo);
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
         }
         _data = null;
      }
      
      public function get data() : DictionaryData
      {
         return _data;
      }
   }
}
