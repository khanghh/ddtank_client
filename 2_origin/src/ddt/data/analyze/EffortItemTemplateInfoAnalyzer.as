package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import ddt.data.effort.EffortInfo;
   import ddt.data.effort.EffortQualificationInfo;
   import ddt.data.effort.EffortRewardInfo;
   import road7th.data.DictionaryData;
   
   public class EffortItemTemplateInfoAnalyzer extends DataAnalyzer
   {
      
      private static const PATH:String = "AchievementList.xml";
       
      
      public var list:DictionaryData;
      
      public function EffortItemTemplateInfoAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var x:* = null;
         var effortInfo:* = null;
         var conditions:* = null;
         var j:int = 0;
         var effortQualificationInfo:* = null;
         var rewards:* = null;
         var k:int = 0;
         var effortRewardInfo:* = null;
         var xml:XML = new XML(data);
         list = new DictionaryData();
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               x = xmllist[i];
               effortInfo = new EffortInfo();
               effortInfo.ID = x.@ID;
               effortInfo.PlaceID = x.@PlaceID;
               effortInfo.Title = x.@Title;
               effortInfo.Detail = x.@Detail;
               effortInfo.NeedMinLevel = x.@NeedMinLevel;
               effortInfo.NeedMaxLevel = x.@NeedMaxLevel;
               effortInfo.PreAchievementID = x.@PreAchievementID;
               effortInfo.IsOther = getBoolean(x.@IsOther);
               effortInfo.AchievementType = x.@AchievementType;
               effortInfo.CanHide = getBoolean(x.@CanHide);
               effortInfo.picId = x.@PicID;
               effortInfo.StartDate = new Date(String(x.@StartDate).substr(5,2) + "/" + String(x.@StartDate).substr(8,2) + "/" + String(x.@StartDate).substr(0,4));
               effortInfo.EndDate = new Date(String(x.@StartDate).substr(5,2) + "/" + String(x.@StartDate).substr(8,2) + "/" + String(x.@StartDate).substr(0,4));
               effortInfo.AchievementPoint = x.@AchievementPoint;
               conditions = x..Item_Condiction;
               for(j = 0; j < conditions.length(); )
               {
                  effortQualificationInfo = new EffortQualificationInfo();
                  effortQualificationInfo.AchievementID = conditions[j].@AchievementID;
                  effortQualificationInfo.CondictionID = conditions[j].@CondictionID;
                  effortQualificationInfo.CondictionType = conditions[j].@CondictionType;
                  effortQualificationInfo.Condiction_Para1 = conditions[j].@Condiction_Para1;
                  effortQualificationInfo.Condiction_Para2 = conditions[j].@Condiction_Para2;
                  effortInfo.addEffortQualification(effortQualificationInfo);
                  j++;
               }
               rewards = x..Item_Reward;
               for(k = 0; k < rewards.length(); )
               {
                  effortRewardInfo = new EffortRewardInfo();
                  effortRewardInfo.AchievementID = rewards[k].@AchievementID;
                  effortRewardInfo.RewardCount = rewards[k].@RewardCount;
                  effortRewardInfo.RewardPara = rewards[k].@RewardPara;
                  effortRewardInfo.RewardType = rewards[k].@RewardType;
                  effortRewardInfo.RewardValueId = rewards[k].@RewardValueId;
                  effortInfo.addEffortReward(effortRewardInfo);
                  k++;
               }
               list[effortInfo.ID] = effortInfo;
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
      
      private function getBoolean(value:String) : Boolean
      {
         if(value == "true" || value == "1")
         {
            return true;
         }
         return false;
      }
   }
}
