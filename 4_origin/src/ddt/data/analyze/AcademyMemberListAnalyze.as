package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import ddt.data.player.AcademyPlayerInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.data.player.PlayerState;
   
   public class AcademyMemberListAnalyze extends DataAnalyzer
   {
       
      
      public var academyMemberList:Vector.<AcademyPlayerInfo>;
      
      public var totalPage:int;
      
      public var selfIsRegister:Boolean;
      
      public var selfDescribe:String;
      
      public var isAlter:Boolean;
      
      public var isSelfPublishEquip:Boolean;
      
      public function AcademyMemberListAnalyze(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc5_:XML = new XML(param1);
         academyMemberList = new Vector.<AcademyPlayerInfo>();
         if(_loc5_.@value == "true")
         {
            _loc6_ = _loc5_..Info;
            _loc7_ = 0;
            while(_loc7_ < _loc6_.length())
            {
               _loc3_ = new PlayerInfo();
               _loc3_.beginChanges();
               _loc3_.ID = _loc6_[_loc7_].@UserID;
               _loc3_.NickName = _loc6_[_loc7_].@NickName;
               _loc3_.ConsortiaID = _loc6_[_loc7_].@ConsortiaID;
               _loc3_.ConsortiaName = _loc6_[_loc7_].@ConsortiaName;
               _loc3_.Sex = converBoolean(_loc6_[_loc7_].@Sex);
               _loc3_.WinCount = _loc6_[_loc7_].@Win;
               _loc3_.TotalCount = _loc6_[_loc7_].@Total;
               _loc3_.EscapeCount = _loc6_[_loc7_].@Escape;
               _loc3_.GP = _loc6_[_loc7_].@GP;
               _loc3_.Style = _loc6_[_loc7_].@Style;
               _loc3_.Colors = _loc6_[_loc7_].@Colors;
               _loc3_.Hide = _loc6_[_loc7_].@Hide;
               _loc3_.Grade = _loc6_[_loc7_].@Grade;
               _loc3_.playerState = new PlayerState(int(_loc6_[_loc7_].@State));
               _loc3_.Repute = _loc6_[_loc7_].@Repute;
               _loc3_.Skin = _loc6_[_loc7_].@Skin;
               _loc3_.Offer = _loc6_[_loc7_].@Offer;
               _loc3_.IsMarried = converBoolean(_loc6_[_loc7_].@IsMarried);
               _loc3_.Nimbus = int(_loc6_[_loc7_].@Nimbus);
               _loc3_.DutyName = _loc6_[_loc7_].@DutyName;
               _loc3_.FightPower = _loc6_[_loc7_].@FightPower;
               _loc3_.AchievementPoint = _loc6_[_loc7_].@AchievementPoint;
               _loc3_.honor = _loc6_[_loc7_].@Rank;
               _loc3_.typeVIP = _loc6_[_loc7_].@typeVIP;
               _loc3_.VIPLevel = _loc6_[_loc7_].@VIPLevel;
               _loc3_.SpouseID = _loc6_[_loc7_].@SpouseID;
               _loc3_.SpouseName = _loc6_[_loc7_].@SpouseName;
               _loc3_.WeaponID = _loc6_[_loc7_].@WeaponID;
               _loc3_.graduatesCount = _loc6_[_loc7_].@GraduatesCount;
               _loc3_.honourOfMaster = _loc6_[_loc7_].@HonourOfMaster;
               _loc3_.badgeID = _loc6_[_loc7_].@BadgeID;
               _loc3_.isOld = int(_loc6_[_loc7_].@OldPlayer) == 1;
               _loc3_.isAttest = converBoolean(_loc6_[_loc7_].@IsBeauty);
               _loc4_ = new PlayerState(_loc6_[_loc7_].@State);
               _loc3_.playerState = _loc4_;
               _loc2_ = new AcademyPlayerInfo();
               _loc2_.IsPublishEquip = converBoolean(_loc6_[_loc7_].@IsPublishEquip);
               _loc2_.Introduction = _loc6_[_loc7_].@Introduction;
               _loc2_.info = _loc3_;
               academyMemberList.push(_loc2_);
               _loc3_.commitChanges();
               _loc7_++;
            }
            totalPage = Math.ceil(int(_loc5_.@total) / 9);
            selfIsRegister = converBoolean(_loc5_.@isPlayerRegeisted);
            if(_loc5_.@isPlayerRegeisted == "")
            {
               isAlter = false;
            }
            else
            {
               isAlter = true;
            }
            selfDescribe = _loc5_.@selfMessage;
            isSelfPublishEquip = converBoolean(_loc5_.@isSelfPublishEquip);
            onAnalyzeComplete();
         }
         else
         {
            message = _loc5_.@message;
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
