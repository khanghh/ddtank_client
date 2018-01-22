package vip.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import flash.utils.Dictionary;
   import vip.data.VipModelInfo;
   
   public class PlayerVIPLevleInfoAnalyzer extends DataAnalyzer
   {
       
      
      public var info:VipModelInfo;
      
      public function PlayerVIPLevleInfoAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc2_:* = null;
         info = new VipModelInfo();
         var _loc4_:XML = new XML(param1);
         if(_loc4_.@value == "true")
         {
            info.maxExp = _loc4_.@maxExp;
            info.ExpForEachDay = _loc4_.@ExpForEachDay;
            info.ExpDecreaseForEachDay = _loc4_.@ExpDecreaseForEachDay;
            info.upRuleDescription = _loc4_.@Description;
            info.RewardDescription = _loc4_.@RewardInfo;
            _loc3_ = _loc4_..Levels;
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length())
            {
               _loc2_ = new Dictionary();
               _loc2_["level"] = _loc3_[_loc5_].@Level;
               _loc2_["ExpNeeded"] = _loc3_[_loc5_].@ExpNeeded;
               _loc2_["Description"] = _loc3_[_loc5_].@Description;
               info.levelInfo[_loc5_] = _loc2_;
               _loc5_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc4_.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
