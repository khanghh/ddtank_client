package team.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.StringUtils;
   import ddt.data.player.PlayerState;
   import road7th.utils.DateUtils;
   import team.model.TeamMemberInfo;
   
   public class TeamMemberAnalyze extends DataAnalyzer
   {
       
      
      private var _list:Array;
      
      public var id:int;
      
      public function TeamMemberAnalyze(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc2_:* = null;
         _list = [];
         var _loc3_:XML = new XML(param1);
         if(_loc3_.@value == "true")
         {
            id = _loc3_.@teamID;
            _loc4_ = _loc3_..Item;
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length())
            {
               _loc5_ = new TeamMemberInfo();
               _loc5_.ID = int(_loc4_[_loc6_].@UserID);
               _loc5_.NickName = _loc4_[_loc6_].@NickName;
               _loc5_.Grade = int(_loc4_[_loc6_].@Grade);
               _loc2_ = new PlayerState(int(_loc4_[_loc6_].@State));
               _loc5_.playerState = _loc2_;
               _loc5_.LastLoginDate = DateUtils.dealWithStringDate(_loc4_[_loc6_].@LastDate);
               _loc5_.typeVIP = int(_loc4_[_loc6_].@typeVIP);
               _loc5_.VIPLevel = int(_loc4_[_loc6_].@VIPLevel);
               _loc5_.isOld = StringUtils.converBoolean(String(_loc4_[_loc6_].@OldPlayer));
               _loc5_.activeScore = int(_loc4_[_loc6_].@ActiveScore);
               _loc5_.weekActiveScore = int(_loc4_[_loc6_].@ActiveWeekScore);
               _loc5_.totalActiveScore = int(_loc4_[_loc6_].@ActiveTotalScore);
               _loc5_.seasonActiveScore = int(_loc4_[_loc6_].@ActiveSeasonScore);
               _loc5_.teamSocre = int(_loc4_[_loc6_].@BattleScore);
               _loc5_.totalTiems = int(_loc4_[_loc6_].@BattleNum);
               _loc5_.FightPower = int(_loc4_[_loc6_].@FightPower);
               _loc5_.ddtKingGrade = int(_loc4_[_loc6_].@DdtKingLevel);
               _loc5_.Rank = int(_loc4_[_loc6_].@Rank);
               _loc5_.Offer = int(_loc4_[_loc6_].@Offer);
               _loc5_.WinCount = int(_loc4_[_loc6_].@WinCount);
               _loc5_.EscapeCount = int(_loc4_[_loc6_].@EscapeCount);
               _loc5_.TotalCount = int(_loc4_[_loc6_].@TotalCount);
               _loc5_.isSignToday = int(_loc4_[_loc6_].@IsSignToday) != 0;
               _loc5_.Sex = StringUtils.converBoolean(String(_loc4_[_loc6_].@Sex));
               _loc5_.teamDuty = !!StringUtils.converBoolean(String(_loc4_[_loc6_].@IsCaption))?1:0;
               _list.push(_loc5_);
               _loc6_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc3_.@message;
            onAnalyzeError();
         }
      }
      
      public function get list() : Array
      {
         return _list;
      }
   }
}
