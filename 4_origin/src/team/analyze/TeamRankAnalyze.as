package team.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import team.TeamManager;
   import team.model.TeamRankInfo;
   import team.model.TeamRankListData;
   
   public class TeamRankAnalyze extends DataAnalyzer
   {
       
      
      public var data:TeamRankListData;
      
      public function TeamRankAnalyze(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var xmllist2:* = null;
         var list2:* = null;
         var j:int = 0;
         var info:* = null;
         var xml:XML = new XML(data);
         this.data = new TeamRankListData();
         this.data.lastUpdateTime = xml.@date;
         var list:Array = [];
         if(TeamManager.instance.model.currentAreaName == null || TeamManager.instance.model.currentAreaName == "")
         {
            TeamManager.instance.model.currentAreaName = xml.@AreaName;
         }
         if(xml.@value == "true")
         {
            xmllist = xml..RankSegment;
            for(i = 0; i < xmllist.length(); )
            {
               xmllist2 = xmllist[i]..Item;
               list2 = [];
               for(j = 0; j < xmllist2.length(); )
               {
                  info = new TeamRankInfo();
                  ObjectUtils.copyPorpertiesByXML(info,xmllist2[j]);
                  list2.push(info);
                  j++;
               }
               list[i] = list2;
               i++;
            }
            this.data.list = list;
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
