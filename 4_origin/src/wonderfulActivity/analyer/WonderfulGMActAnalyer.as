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
      
      public function WonderfulGMActAnalyer(param1:Function)
      {
         super(param1);
         _activityData = new Dictionary();
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc18_:* = null;
         var _loc12_:int = 0;
         var _loc8_:* = null;
         var _loc13_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc11_:int = 0;
         var _loc16_:* = null;
         var _loc14_:* = undefined;
         var _loc2_:* = undefined;
         var _loc15_:* = null;
         var _loc10_:int = 0;
         var _loc17_:* = null;
         var _loc4_:* = null;
         var _loc7_:int = 0;
         var _loc3_:* = null;
         var _loc19_:int = 0;
         var _loc9_:XML = new XML(param1);
         if(_loc9_.@value == "true")
         {
            _loc18_ = _loc9_..ActiveInfo;
            _loc12_ = 0;
            while(_loc12_ < _loc18_.length())
            {
               _loc8_ = new GmActivityInfo();
               ObjectUtils.copyPorpertiesByXML(_loc8_,_loc18_[_loc12_].Activity[0]);
               _loc8_.beginShowTime = _loc8_.beginShowTime.replace(/-/g,"/");
               _loc8_.beginTime = _loc8_.beginTime.replace(/-/g,"/");
               _loc8_.endShowTime = _loc8_.endShowTime.replace(/-/g,"/");
               _loc8_.endTime = _loc8_.endTime.replace(/-/g,"/");
               _loc13_ = [];
               _loc5_ = _loc18_[_loc12_].ActiveGiftBag[0];
               if(_loc5_)
               {
                  _loc6_ = _loc5_..Gift;
               }
               else
               {
                  _loc6_ = null;
               }
               if(_loc5_ && _loc6_ && _loc6_.length() > 0)
               {
                  _loc11_ = 0;
                  while(_loc11_ < _loc6_.length())
                  {
                     _loc16_ = new GiftBagInfo();
                     ObjectUtils.copyPorpertiesByXML(_loc16_,_loc6_[_loc11_]);
                     if(_loc16_.rewardMark != 100)
                     {
                        _loc14_ = new Vector.<GiftConditionInfo>();
                        _loc2_ = new Vector.<GiftRewardInfo>();
                        if(_loc5_.ActiveCondition.length() > 0)
                        {
                           _loc15_ = _loc5_.ActiveCondition[_loc11_].Condition;
                           _loc10_ = 0;
                           while(_loc10_ < _loc15_.length())
                           {
                              _loc17_ = new GiftConditionInfo();
                              ObjectUtils.copyPorpertiesByXML(_loc17_,_loc15_[_loc10_]);
                              _loc14_.push(_loc17_);
                              _loc10_++;
                           }
                        }
                        if(_loc5_.ActiveReward[_loc11_] != null && _loc5_.ActiveReward.length() > 0)
                        {
                           _loc4_ = _loc5_.ActiveReward[_loc11_].Reward;
                           _loc7_ = 0;
                           while(_loc7_ < _loc4_.length())
                           {
                              _loc3_ = new GiftRewardInfo();
                              ObjectUtils.copyPorpertiesByXML(_loc3_,_loc4_[_loc7_]);
                              _loc19_ = _loc4_[_loc7_].@isBind[0];
                              _loc3_.isBind = _loc19_ == 1;
                              _loc2_.push(_loc3_);
                              _loc7_++;
                           }
                        }
                        _loc16_.giftConditionArr = _loc14_;
                        _loc2_.sort(giftRewardArrsort);
                        _loc16_.giftRewardArr = _loc2_;
                        _loc13_.push(_loc16_);
                     }
                     _loc11_++;
                  }
               }
               _loc13_.sortOn("giftbagOrder",16);
               _loc8_.giftbagArray = _loc13_;
               _activityData[_loc8_.activityId] = _loc8_;
               _loc12_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc9_.@message;
            onAnalyzeError();
            onAnalyzeError();
         }
      }
      
      private function giftRewardArrsort(param1:GiftRewardInfo, param2:GiftRewardInfo) : int
      {
         if(param1.remain2 > param2.remain2)
         {
            return 1;
         }
         if(param1.remain2 < param2.remain2)
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
