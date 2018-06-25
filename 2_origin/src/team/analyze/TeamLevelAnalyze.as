package team.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import road7th.data.DictionaryData;
   import team.model.TeamLevelInfo;
   
   public class TeamLevelAnalyze extends DataAnalyzer
   {
       
      
      public var data:DictionaryData;
      
      public function TeamLevelAnalyze(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(value:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         var xml:XML = new XML(value);
         data = new DictionaryData();
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new TeamLevelInfo();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               data.add(info.Level,info);
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
   }
}
