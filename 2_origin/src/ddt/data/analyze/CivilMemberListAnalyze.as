package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import ddt.data.player.CivilPlayerInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.data.player.PlayerState;
   
   public class CivilMemberListAnalyze extends DataAnalyzer
   {
      
      public static const PATH:String = "MarryInfoPageList.ashx";
       
      
      public var civilMemberList:Array;
      
      public var _page:int;
      
      public var _name:String;
      
      public var _sex:Boolean;
      
      public var _totalPage:int;
      
      public function CivilMemberListAnalyze(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc5_:* = null;
         civilMemberList = [];
         var _loc3_:XML = new XML(param1);
         if(_loc3_.@value == "true")
         {
            _loc4_ = _loc3_..Info;
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length())
            {
               _loc2_ = new PlayerInfo();
               _loc2_.beginChanges();
               _loc2_.ID = _loc4_[_loc6_].@UserID;
               _loc2_.NickName = _loc4_[_loc6_].@NickName;
               _loc2_.ConsortiaID = _loc4_[_loc6_].@ConsortiaID;
               _loc2_.ConsortiaName = _loc4_[_loc6_].@ConsortiaName;
               _loc2_.Sex = converBoolean(_loc4_[_loc6_].@Sex);
               _loc2_.WinCount = _loc4_[_loc6_].@Win;
               _loc2_.TotalCount = _loc4_[_loc6_].@Total;
               _loc2_.EscapeCount = _loc4_[_loc6_].@Escape;
               _loc2_.GP = _loc4_[_loc6_].@GP;
               _loc2_.Style = _loc4_[_loc6_].@Style;
               _loc2_.Colors = _loc4_[_loc6_].@Colors;
               _loc2_.Hide = _loc4_[_loc6_].@Hide;
               _loc2_.Grade = _loc4_[_loc6_].@Grade;
               _loc2_.ddtKingGrade = int(_loc4_[_loc6_].@MaxLevelLevel);
               _loc2_.playerState = new PlayerState(int(_loc4_[_loc6_].@State));
               _loc2_.Repute = _loc4_[_loc6_].@Repute;
               _loc2_.Skin = _loc4_[_loc6_].@Skin;
               _loc2_.Offer = _loc4_[_loc6_].@Offer;
               _loc2_.IsMarried = converBoolean(_loc4_[_loc6_].@IsMarried);
               _loc2_.Nimbus = int(_loc4_[_loc6_].@Nimbus);
               _loc2_.DutyName = _loc4_[_loc6_].@DutyName;
               _loc2_.FightPower = _loc4_[_loc6_].@FightPower;
               _loc2_.AchievementPoint = _loc4_[_loc6_].@AchievementPoint;
               _loc2_.honor = _loc4_[_loc6_].@Rank;
               _loc2_.typeVIP = _loc4_[_loc6_].@typeVIP;
               _loc2_.VIPLevel = _loc4_[_loc6_].@VIPLevel;
               _loc2_.isOld = int(_loc4_[_loc6_].@OldPlayer) == 1;
               _loc2_.isAttest = converBoolean(_loc4_[_loc6_].@IsBeauty);
               _loc5_ = new CivilPlayerInfo();
               _loc5_.UserId = _loc2_.ID;
               _loc5_.MarryInfoID = _loc4_[_loc6_].@ID;
               _loc5_.IsPublishEquip = converBoolean(_loc4_[_loc6_].@IsPublishEquip);
               _loc5_.Introduction = _loc4_[_loc6_].@Introduction;
               _loc5_.IsConsortia = converBoolean(_loc4_[_loc6_].@IsConsortia);
               _loc5_.info = _loc2_;
               civilMemberList.push(_loc5_);
               _loc2_.commitChanges();
               _loc6_++;
            }
            _totalPage = Math.ceil(int(_loc3_.@total) / 12);
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
         if(param1 == "true")
         {
            return true;
         }
         return false;
      }
   }
}
