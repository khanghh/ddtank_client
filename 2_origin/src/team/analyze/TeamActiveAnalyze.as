package team.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import road7th.data.DictionaryData;
   import team.model.TeamActiveInfo;
   
   public class TeamActiveAnalyze extends DataAnalyzer
   {
       
      
      private var _data:DictionaryData;
      
      public function TeamActiveAnalyze(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(value:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         _data = new DictionaryData();
         var xml:XML = new XML(value);
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new TeamActiveInfo();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               _data.add(info.Type,info);
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
         }
      }
      
      public function get data() : DictionaryData
      {
         return _data;
      }
   }
}
