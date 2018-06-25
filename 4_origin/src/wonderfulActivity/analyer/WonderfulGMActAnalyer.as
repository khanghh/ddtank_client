package wonderfulActivity.analyer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GiftConditionInfo;
   import wonderfulActivity.data.GiftRewardInfo;
   import wonderfulActivity.data.GmActivityInfo;
   
   public class WonderfulGMActAnalyer extends DataAnalyzer
   {
       
      
      private var _activityData:Dictionary;
      
      public function WonderfulGMActAnalyer(onCompleteCall:Function)
      {
         super(onCompleteCall);
         _activityData = new Dictionary();
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var gmActivityData:* = null;
         var giftbagArray:* = null;
         var giftXml:* = null;
         var giftItemList:* = null;
         var j:int = 0;
         var giftBagInfo:* = null;
         var giftConditionArr:* = undefined;
         var giftRewardArr:* = undefined;
         var giftConditionXMLList:* = null;
         var m:int = 0;
         var giftConditionInfo:* = null;
         var giftRewardXMLList:* = null;
         var n:int = 0;
         var giftRewardInfo:* = null;
         var isBind:int = 0;
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = xml..ActiveInfo;
            for(i = 0; i < xmllist.length(); )
            {
               gmActivityData = new GmActivityInfo();
               ObjectUtils.copyPorpertiesByXML(gmActivityData,xmllist[i].Activity[0]);
               gmActivityData.beginShowTime = gmActivityData.beginShowTime.replace(/-/g,"/");
               gmActivityData.beginTime = gmActivityData.beginTime.replace(/-/g,"/");
               gmActivityData.endShowTime = gmActivityData.endShowTime.replace(/-/g,"/");
               gmActivityData.endTime = gmActivityData.endTime.replace(/-/g,"/");
               giftbagArray = [];
               giftXml = xmllist[i].ActiveGiftBag[0];
               if(giftXml)
               {
                  giftItemList = giftXml..Gift;
               }
               else
               {
                  giftItemList = null;
               }
               if(giftXml && giftItemList && giftItemList.length() > 0)
               {
                  for(j = 0; j < giftItemList.length(); )
                  {
                     giftBagInfo = new GiftBagInfo();
                     ObjectUtils.copyPorpertiesByXML(giftBagInfo,giftItemList[j]);
                     if(giftBagInfo.rewardMark != 100)
                     {
                        giftConditionArr = new Vector.<GiftConditionInfo>();
                        giftRewardArr = new Vector.<GiftRewardInfo>();
                        if(giftXml.ActiveCondition.length() > 0)
                        {
                           giftConditionXMLList = giftXml.ActiveCondition[j].Condition;
                           for(m = 0; m < giftConditionXMLList.length(); )
                           {
                              giftConditionInfo = new GiftConditionInfo();
                              ObjectUtils.copyPorpertiesByXML(giftConditionInfo,giftConditionXMLList[m]);
                              giftConditionArr.push(giftConditionInfo);
                              m++;
                           }
                        }
                        if(giftXml.ActiveReward[j] != null && giftXml.ActiveReward.length() > 0)
                        {
                           giftRewardXMLList = giftXml.ActiveReward[j].Reward;
                           for(n = 0; n < giftRewardXMLList.length(); )
                           {
                              giftRewardInfo = new GiftRewardInfo();
                              ObjectUtils.copyPorpertiesByXML(giftRewardInfo,giftRewardXMLList[n]);
                              isBind = giftRewardXMLList[n].@isBind[0];
                              giftRewardInfo.isBind = isBind == 1;
                              giftRewardArr.push(giftRewardInfo);
                              n++;
                           }
                        }
                        giftBagInfo.giftConditionArr = giftConditionArr;
                        giftRewardArr.sort(giftRewardArrsort);
                        giftBagInfo.giftRewardArr = giftRewardArr;
                        giftbagArray.push(giftBagInfo);
                     }
                     j++;
                  }
               }
               giftbagArray.sortOn("giftbagOrder",16);
               gmActivityData.giftbagArray = giftbagArray;
               _activityData[gmActivityData.activityId] = gmActivityData;
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
      
      private function giftRewardArrsort(value1:GiftRewardInfo, value2:GiftRewardInfo) : int
      {
         if(value1.remain2 > value2.remain2)
         {
            return 1;
         }
         if(value1.remain2 < value2.remain2)
         {
            return -1;
         }
         return 0;
      }
      
      public function get ActivityData() : Dictionary
      {
         return _activityData;
      }
   }
}
