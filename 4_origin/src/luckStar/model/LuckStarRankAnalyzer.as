package luckStar.model
{
   import com.pickgliss.loader.DataAnalyzer;
   import luckStar.manager.LuckStarManager;
   
   public class LuckStarRankAnalyzer extends DataAnalyzer
   {
      
      private static const MAX_LIST:int = 5;
       
      
      public function LuckStarRankAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc3_:* = undefined;
         var _loc7_:* = null;
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc8_:int = 0;
         var _loc6_:* = null;
         var _loc5_:XML = XML(param1);
         if(_loc5_.@value == "true")
         {
            _loc7_ = _loc5_..rankInfo;
            _loc2_ = [];
            _loc8_ = 0;
            while(_loc8_ < _loc7_.length())
            {
               if(_loc8_ % 5 == 0 || _loc8_ == 0)
               {
                  _loc3_ = new Vector.<LuckStarPlayerInfo>();
                  _loc2_.push(_loc3_);
               }
               _loc4_ = new LuckStarPlayerInfo();
               _loc4_.name = String(_loc7_[_loc8_].@nickName);
               _loc4_.rank = int(_loc7_[_loc8_].@rank);
               _loc4_.starNum = int(_loc7_[_loc8_].@useStarNum);
               _loc4_.isVip = int(_loc7_[_loc8_].@isVip) != 0;
               _loc3_.push(_loc4_);
               _loc8_++;
            }
            _loc6_ = new LuckStarPlayerInfo();
            _loc6_.rank = int(_loc5_.myRank.@rank);
            _loc6_.starNum = int(_loc5_.myRank.@useStarNum);
            LuckStarManager.Instance.model.selfInfo = _loc6_;
            LuckStarManager.Instance.model.lastDate = String(_loc5_.@lastUpdateTime);
            LuckStarManager.Instance.model.rank = _loc2_;
            onAnalyzeComplete();
         }
         else
         {
            message = _loc5_.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
