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
      
      public function EffortItemTemplateInfoAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc8_:* = null;
         var _loc12_:int = 0;
         var _loc11_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc9_:int = 0;
         var _loc7_:* = null;
         var _loc5_:* = null;
         var _loc10_:int = 0;
         var _loc4_:* = null;
         var _loc6_:XML = new XML(param1);
         list = new DictionaryData();
         if(_loc6_.@value == "true")
         {
            _loc8_ = _loc6_..Item;
            _loc12_ = 0;
            while(_loc12_ < _loc8_.length())
            {
               _loc11_ = _loc8_[_loc12_];
               _loc3_ = new EffortInfo();
               _loc3_.ID = _loc11_.@ID;
               _loc3_.PlaceID = _loc11_.@PlaceID;
               _loc3_.Title = _loc11_.@Title;
               _loc3_.Detail = _loc11_.@Detail;
               _loc3_.NeedMinLevel = _loc11_.@NeedMinLevel;
               _loc3_.NeedMaxLevel = _loc11_.@NeedMaxLevel;
               _loc3_.PreAchievementID = _loc11_.@PreAchievementID;
               _loc3_.IsOther = getBoolean(_loc11_.@IsOther);
               _loc3_.AchievementType = _loc11_.@AchievementType;
               _loc3_.CanHide = getBoolean(_loc11_.@CanHide);
               _loc3_.picId = _loc11_.@PicID;
               _loc3_.StartDate = new Date(String(_loc11_.@StartDate).substr(5,2) + "/" + String(_loc11_.@StartDate).substr(8,2) + "/" + String(_loc11_.@StartDate).substr(0,4));
               _loc3_.EndDate = new Date(String(_loc11_.@StartDate).substr(5,2) + "/" + String(_loc11_.@StartDate).substr(8,2) + "/" + String(_loc11_.@StartDate).substr(0,4));
               _loc3_.AchievementPoint = _loc11_.@AchievementPoint;
               _loc2_ = _loc11_..Item_Condiction;
               _loc9_ = 0;
               while(_loc9_ < _loc2_.length())
               {
                  _loc7_ = new EffortQualificationInfo();
                  _loc7_.AchievementID = _loc2_[_loc9_].@AchievementID;
                  _loc7_.CondictionID = _loc2_[_loc9_].@CondictionID;
                  _loc7_.CondictionType = _loc2_[_loc9_].@CondictionType;
                  _loc7_.Condiction_Para1 = _loc2_[_loc9_].@Condiction_Para1;
                  _loc7_.Condiction_Para2 = _loc2_[_loc9_].@Condiction_Para2;
                  _loc3_.addEffortQualification(_loc7_);
                  _loc9_++;
               }
               _loc5_ = _loc11_..Item_Reward;
               _loc10_ = 0;
               while(_loc10_ < _loc5_.length())
               {
                  _loc4_ = new EffortRewardInfo();
                  _loc4_.AchievementID = _loc5_[_loc10_].@AchievementID;
                  _loc4_.RewardCount = _loc5_[_loc10_].@RewardCount;
                  _loc4_.RewardPara = _loc5_[_loc10_].@RewardPara;
                  _loc4_.RewardType = _loc5_[_loc10_].@RewardType;
                  _loc4_.RewardValueId = _loc5_[_loc10_].@RewardValueId;
                  _loc3_.addEffortReward(_loc4_);
                  _loc10_++;
               }
               list[_loc3_.ID] = _loc3_;
               _loc12_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc6_.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
      
      private function getBoolean(param1:String) : Boolean
      {
         if(param1 == "true" || param1 == "1")
         {
            return true;
         }
         return false;
      }
   }
}
