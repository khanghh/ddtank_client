package team.model
{
   import ddt.data.player.FriendListPlayer;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import road7th.data.DictionaryData;
   
   public class TeamModel
   {
       
      
      public var selfScore:int;
      
      public var selfActive:int;
      
      public var selfAllActive:int;
      
      public var shopList:DictionaryData;
      
      public var buyLimitLv:Array;
      
      public var inviteList:Array;
      
      public var activeList:DictionaryData;
      
      private var _teamInfoList:DictionaryData;
      
      private var _teamMemberList:DictionaryData;
      
      private var _teamRecordList:DictionaryData;
      
      private var _teamInviteList:DictionaryData;
      
      private var _teamActiveList:DictionaryData;
      
      public var rankList:Array;
      
      private var _teamBattleSeasonList:DictionaryData;
      
      private var _teamBattleSegmentList:DictionaryData;
      
      public var teamLevelList:DictionaryData;
      
      public var currentAreaName:String;
      
      public function TeamModel()
      {
         inviteList = [];
         rankList = [];
         super();
         _teamInfoList = new DictionaryData();
         _teamMemberList = new DictionaryData();
         _teamRecordList = new DictionaryData();
         _teamInviteList = new DictionaryData();
         _teamActiveList = new DictionaryData();
      }
      
      public function getTeamInfoByID(param1:int) : TeamInfo
      {
         return _teamInfoList[param1] as TeamInfo;
      }
      
      public function addTeamInfo(param1:int, param2:TeamInfo) : void
      {
         _teamInfoList.add(param1,param2);
      }
      
      public function addTeamMemberInfo(param1:int, param2:Array) : void
      {
         _teamMemberList.add(param1,param2);
      }
      
      public function addTeamRecordList(param1:int, param2:Array) : void
      {
         _teamRecordList.add(param1,param2);
      }
      
      public function addTeamInviteList(param1:int, param2:Array) : void
      {
         _teamInviteList.add(param1,param2);
      }
      
      public function removeTeamInviteList(param1:int, param2:int = -1) : void
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc3_:* = null;
         if(param2 == -1)
         {
            _teamInviteList.remove(param1);
         }
         else
         {
            _loc4_ = _teamInviteList[param1];
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               _loc3_ = _loc4_[_loc5_] as TeamInvitedMemberInfo;
               if(_loc3_.id == param2)
               {
                  _loc4_.splice(_loc5_,1);
                  return;
               }
               _loc5_++;
            }
         }
      }
      
      public function addTeamActiveList(param1:int, param2:Array) : void
      {
         _teamActiveList.add(param1,param2);
      }
      
      public function get selfTeamMember() : Array
      {
         return _teamMemberList[PlayerManager.Instance.Self.teamID] || [];
      }
      
      public function get selfTeamInfo() : TeamInfo
      {
         return _teamInfoList[PlayerManager.Instance.Self.teamID];
      }
      
      public function get selfTeamMemberInfo() : TeamMemberInfo
      {
         var _loc1_:Array = selfTeamMember;
         var _loc4_:int = 0;
         var _loc3_:* = _loc1_;
         for each(var _loc2_ in _loc1_)
         {
            if(_loc2_.ID == PlayerManager.Instance.Self.ID)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get selfTeamRecordList() : Array
      {
         return _teamRecordList[PlayerManager.Instance.Self.teamID] || [];
      }
      
      public function get selfTeamInviteList() : Array
      {
         return _teamInviteList[PlayerManager.Instance.Self.teamID] || [];
      }
      
      public function get selfTeamActiveList() : Array
      {
         return _teamActiveList[PlayerManager.Instance.Self.teamID] || [];
      }
      
      public function get teamFriendList() : Array
      {
         var _loc2_:Array = PlayerManager.Instance.friendList.list;
         var _loc1_:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for each(var _loc3_ in _loc2_)
         {
            if(!hasTeamInvitePlayer(_loc3_.ID) && !hasTeamMemberPlayer(_loc3_.ID))
            {
               _loc1_.push(_loc3_);
            }
         }
         _loc1_.sortOn("StateID",16 | 2);
         return _loc1_;
      }
      
      public function get teamFriendListOnline() : Array
      {
         var _loc2_:Array = PlayerManager.Instance.friendList.list;
         var _loc1_:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for each(var _loc3_ in _loc2_)
         {
            if(_loc3_.playerState.StateID != 0 && !hasTeamInvitePlayer(_loc3_.ID) && !hasTeamMemberPlayer(_loc3_.ID))
            {
               _loc1_.push(_loc3_);
            }
         }
         return _loc1_;
      }
      
      private function hasTeamInvitePlayer(param1:int) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < selfTeamInviteList.length)
         {
            _loc2_ = selfTeamInviteList[_loc3_] as TeamInvitedMemberInfo;
            if(_loc2_.id == param1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      private function hasTeamMemberPlayer(param1:int) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < selfTeamMember.length)
         {
            _loc2_ = selfTeamMember[_loc3_] as TeamMemberInfo;
            if(_loc2_.ID == param1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function get onlineTeamMemberList() : Array
      {
         var _loc1_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = selfTeamMember;
         for each(var _loc2_ in selfTeamMember)
         {
            if(_loc2_.playerState.StateID != 0)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function get offlineTeamMemberList() : Array
      {
         var _loc1_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = selfTeamMember;
         for each(var _loc2_ in selfTeamMember)
         {
            if(_loc2_.playerState.StateID == 0)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function get teamIMInfo() : Array
      {
         var _loc1_:Array = [];
         var _loc3_:Array = onlineTeamMemberList;
         var _loc2_:TeamMemberInfo = new TeamMemberInfo();
         _loc2_.type = 0;
         _loc2_.isSelected = true;
         _loc2_.RatifierName = LanguageMgr.GetTranslation("tank.team.teamNumber",_loc3_.length,this.selfTeamMember.length);
         _loc1_.push(_loc2_);
         return _loc1_;
      }
      
      public function teamLevelInfoByLevel(param1:int) : TeamLevelInfo
      {
         return teamLevelList[param1];
      }
      
      public function get teamBattleSeasonInfo() : TeamBattleSeasonInfo
      {
         return _teamBattleSeasonList.list[_teamBattleSeasonList.length - 1];
      }
      
      public function getTeamBattleSegmentInfo(param1:int) : TeamBattleSegmentInfo
      {
         return _teamBattleSegmentList[param1];
      }
      
      public function set teamBattleSeasonList(param1:DictionaryData) : void
      {
         _teamBattleSeasonList = param1;
      }
      
      public function set teamBattleSegmentList(param1:DictionaryData) : void
      {
         _teamBattleSegmentList = param1;
      }
      
      public function getTeamBattleSegment(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = 1;
         while(_loc3_ <= 5)
         {
            if(_loc3_ != 5)
            {
               if(param1 >= _teamBattleSegmentList[_loc3_].NeedScore && param1 < _teamBattleSegmentList[_loc3_ + 1].NeedScore)
               {
                  return _loc3_;
               }
            }
            else if(param1 >= _teamBattleSegmentList[_loc3_].NeedScore)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return 0;
      }
   }
}
