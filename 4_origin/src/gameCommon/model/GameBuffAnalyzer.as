package gameCommon.model
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import road7th.data.DictionaryData;
   
   public class GameBuffAnalyzer extends DataAnalyzer
   {
       
      
      private var _data:DictionaryData;
      
      public function GameBuffAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            _data = new DictionaryData();
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new GameBuffInfo();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               _data.add(info.ID,info);
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
            onAnalyzeError();
         }
      }
      
      public function get data() : DictionaryData
      {
         return _data;
      }
   }
}
