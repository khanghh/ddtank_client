package consortion.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import consortion.ConsortionModelManager;
   import ddt.data.player.ConsortiaPlayerInfo;
   import ddt.data.player.PlayerState;
   import ddt.manager.PlayerManager;
   import road7th.data.DictionaryData;
   
   public class ConsortionMemberAnalyer extends DataAnalyzer
   {
       
      
      public var consortionMember:DictionaryData;
      
      public function ConsortionMemberAnalyer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc3_:XML = new XML(param1);
         consortionMember = new DictionaryData();
         if(_loc3_.@value == "true")
         {
            ConsortionModelManager.Instance.model.systemDate = XML(_loc3_).@currentDate;
            _loc4_ = _loc3_..Item;
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length())
            {
               _loc5_ = new ConsortiaPlayerInfo();
               _loc5_.beginChanges();
               _loc5_.IsVote = converBoolean(_loc4_[_loc6_].@IsVote);
               _loc5_.privateID = _loc4_[_loc6_].@ID;
               _loc5_.ConsortiaID = PlayerManager.Instance.Self.ConsortiaID;
               _loc5_.ConsortiaName = PlayerManager.Instance.Self.ConsortiaName;
               _loc5_.DutyID = _loc4_[_loc6_].@DutyID;
               _loc5_.DutyName = _loc4_[_loc6_].@DutyName;
               _loc5_.GP = _loc4_[_loc6_].@GP;
               _loc5_.Grade = _loc4_[_loc6_].@Grade;
               _loc5_.FightPower = _loc4_[_loc6_].@FightPower;
               _loc5_.AchievementPoint = _loc4_[_loc6_].@AchievementPoint;
               _loc5_.honor = _loc4_[_loc6_].@Rank;
               _loc5_.IsChat = converBoolean(_loc4_[_loc6_].@IsChat);
               _loc5_.IsDiplomatism = converBoolean(_loc4_[_loc6_].@IsDiplomatism);
               _loc5_.IsDownGrade = converBoolean(_loc4_[_loc6_].@IsDownGrade);
               _loc5_.IsEditorDescription = converBoolean(_loc4_[_loc6_].@IsEditorDescription);
               _loc5_.IsEditorPlacard = converBoolean(_loc4_[_loc6_].@IsEditorPlacard);
               _loc5_.IsEditorUser = converBoolean(_loc4_[_loc6_].@IsEditorUser);
               _loc5_.IsExpel = converBoolean(_loc4_[_loc6_].@IsExpel);
               _loc5_.IsInvite = converBoolean(_loc4_[_loc6_].@IsInvite);
               _loc5_.IsManageDuty = converBoolean(_loc4_[_loc6_].@IsManageDuty);
               _loc5_.IsRatify = converBoolean(_loc4_[_loc6_].@IsRatify);
               _loc5_.IsUpGrade = converBoolean(_loc4_[_loc6_].@IsUpGrade);
               _loc5_.IsBandChat = converBoolean(_loc4_[_loc6_].@IsBanChat);
               _loc5_.Offer = int(_loc4_[_loc6_].@Offer);
               _loc5_.RatifierID = _loc4_[_loc6_].@RatifierID;
               _loc5_.RatifierName = _loc4_[_loc6_].@RatifierName;
               _loc5_.Remark = _loc4_[_loc6_].@Remark;
               _loc5_.Repute = _loc4_[_loc6_].@Repute;
               _loc2_ = new PlayerState(int(_loc4_[_loc6_].@State));
               _loc5_.playerState = _loc2_;
               _loc5_.LastDate = _loc4_[_loc6_].@LastDate;
               _loc5_.ID = _loc4_[_loc6_].@UserID;
               _loc5_.NickName = _loc4_[_loc6_].@UserName;
               _loc5_.typeVIP = _loc4_[_loc6_].@typeVIP;
               _loc5_.VIPLevel = _loc4_[_loc6_].@VIPLevel;
               _loc5_.LoginName = _loc4_[_loc6_].@LoginName;
               _loc5_.Sex = converBoolean(_loc4_[_loc6_].@Sex);
               _loc5_.isAttest = converBoolean(_loc4_[_loc6_].@IsBeauty);
               _loc5_.EscapeCount = _loc4_[_loc6_].@EscapeCount;
               _loc5_.Right = _loc4_[_loc6_].@Right;
               _loc5_.WinCount = _loc4_[_loc6_].@WinCount;
               _loc5_.TotalCount = _loc4_[_loc6_].@TotalCount;
               _loc5_.RichesOffer = _loc4_[_loc6_].@RichesOffer;
               _loc5_.RichesRob = _loc4_[_loc6_].@RichesRob;
               _loc5_.UseOffer = _loc4_[_loc6_].@TotalRichesOffer;
               _loc5_.DutyLevel = _loc4_[_loc6_].@DutyLevel;
               _loc5_.LastWeekRichesOffer = parseInt(_loc4_[_loc6_].@LastWeekRichesOffer);
               _loc5_.isOld = int(_loc4_[_loc6_].@OldPlayer) == 1;
               _loc5_.commitChanges();
               consortionMember.add(_loc5_.ID,_loc5_);
               if(_loc5_.ID == PlayerManager.Instance.Self.ID)
               {
                  PlayerManager.Instance.Self.ConsortiaID = _loc5_.ConsortiaID;
                  PlayerManager.Instance.Self.DutyLevel = _loc5_.DutyLevel;
                  PlayerManager.Instance.Self.DutyName = _loc5_.DutyName;
                  PlayerManager.Instance.Self.Right = _loc5_.Right;
               }
               _loc6_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc3_.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
      
      private function converBoolean(param1:String) : Boolean
      {
         return param1 == "true"?true:false;
      }
   }
}
