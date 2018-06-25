package godsRoads.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import godsRoads.data.GodsRoadsMissionInfo;
   import godsRoads.manager.GodsRoadsManager;
   
   public class GodsRoadsDataAnalyzer extends DataAnalyzer
   {
       
      
      public var dataList:Vector.<GodsRoadsMissionInfo>;
      
      public function GodsRoadsDataAnalyzer(onCompleteCall:Function)
      {
         dataList = new Vector.<GodsRoadsMissionInfo>();
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var questinfo:* = null;
         var questItem:* = null;
         var xml:XML = new XML(data);
         GodsRoadsManager.instance.XMLData = xml;
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               if(xmllist[i].@QuestType != 1)
               {
                  questinfo = new GodsRoadsMissionInfo();
                  questItem = xmllist[i]..Item_Condiction;
                  questinfo.questId = xmllist[i].@ID;
                  questinfo.Title = xmllist[i].@Title;
                  questinfo.Detail = xmllist[i].@Detail;
                  questinfo.Objective = xmllist[i].@Objective;
                  questinfo.NeedMinLevel = xmllist[i].@NeedMinLevel;
                  questinfo.NeedMaxLevel = xmllist[i].@NeedMaxLevel;
                  questinfo.Period = xmllist[i].@Period;
                  questinfo.conditiontId = questItem[0].@CondictionID;
                  questinfo.conditiontTitle = questItem[0].@CondictionTitle;
                  questinfo.conditionType = questItem[0].@CondictionType;
                  questinfo.Para1 = questItem[0].@Para1;
                  questinfo.Para2 = questItem[0].@Para2;
                  questinfo.IndexType = questItem[0].@IndexType;
                  dataList.push(questinfo);
               }
               i++;
            }
            onAnalyzeComplete();
         }
      }
   }
}
