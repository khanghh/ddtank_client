package sevenDayTarget.dataAnalyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import sevenDayTarget.model.NewTargetQuestionInfo;
   
   public class SevenDayTargetDataAnalyzer extends DataAnalyzer
   {
       
      
      public var dataList:Array;
      
      public function SevenDayTargetDataAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var questinfo:* = null;
         var questItem:* = null;
         var j:int = 0;
         var xml:XML = new XML(data);
         dataList = [];
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               questinfo = new NewTargetQuestionInfo();
               questinfo.questId = xmllist[i].@ID;
               questinfo.Period = xmllist[i].@Period;
               questItem = xmllist[i]..Item_Condiction;
               for(j = 0; j < questItem.length(); )
               {
                  questinfo.linkId = questItem[j].@IndexType;
                  if(questItem[j].@CondictionID == "1")
                  {
                     questinfo.condition1Title = questItem[j].@CondictionTitle;
                     questinfo.condition1Para = questItem[j].@Para2;
                  }
                  else if(questItem[j].@CondictionID == "2")
                  {
                     questinfo.condition2Title = questItem[j].@CondictionTitle;
                     questinfo.condition2Para = questItem[j].@Para2;
                  }
                  else if(questItem[j].@CondictionID == "3")
                  {
                     questinfo.condition3Title = questItem[j].@CondictionTitle;
                     questinfo.condition3Para = questItem[j].@Para2;
                  }
                  j++;
               }
               dataList.push(questinfo);
               i++;
            }
            onAnalyzeComplete();
         }
      }
   }
}
