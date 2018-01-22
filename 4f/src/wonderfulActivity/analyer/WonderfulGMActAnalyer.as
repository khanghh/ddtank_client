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
      
      public function WonderfulGMActAnalyer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      private function giftRewardArrsort(param1:GiftRewardInfo, param2:GiftRewardInfo) : int{return 0;}
      
      public function get ActivityData() : Dictionary{return null;}
   }
}
