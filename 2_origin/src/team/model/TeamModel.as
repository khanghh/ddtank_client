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
      
      public function getTeamInfoByID(id:int) : TeamInfo
      {
         return _teamInfoList[id] as TeamInfo;
      }
      
      public function addTeamInfo(id:int, info:TeamInfo) : void
      {
         _teamInfoList.add(id,info);
      }
      
      public function addTeamMemberInfo(id:int, list:Array) : void
      {
         _teamMemberList.add(id,list);
      }
      
      public function addTeamRecordList(id:int, list:Array) : void
      {
         _teamRecordList.add(id,list);
      }
      
      public function addTeamInviteList(id:int, list:Array) : void
      {
         _teamInviteList.add(id,list);
      }
      
      public function removeTeamInviteList(id:int, userid:int = -1) : void
      {
         var list:* = null;
         var i:int = 0;
         var item:* = null;
         if(userid == -1)
         {
            _teamInviteList.remove(id);
         }
         else
         {
            list = _teamInviteList[id];
            for(i = 0; i < list.length; )
            {
               item = list[i] as TeamInvitedMemberInfo;
               if(item.id == userid)
               {
                  list.splice(i,1);
                  return;
               }
               i++;
            }
         }
      }
      
      public function addTeamActiveList(id:int, list:Array) : void
      {
         _teamActiveList.add(id,list);
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
         var list:Array = selfTeamMember;
         var _loc4_:int = 0;
         var _loc3_:* = list;
         for each(var info in list)
         {
            if(info.ID == PlayerManager.Instance.Self.ID)
            {
               return info;
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
         var flist:Array = PlayerManager.Instance.friendList.list;
         var list:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = flist;
         for each(var info in flist)
         {
            if(!hasTeamInvitePlayer(info.ID) && !hasTeamMemberPlayer(info.ID))
            {
               list.push(info);
            }
         }
         list.sortOn("StateID",16 | 2);
         return list;
      }
      
      public function get teamFriendListOnline() : Array
      {
         var flist:Array = PlayerManager.Instance.friendList.list;
         var list:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = flist;
         for each(var info in flist)
         {
            if(info.playerState.StateID != 0 && !hasTeamInvitePlayer(info.ID) && !hasTeamMemberPlayer(info.ID))
            {
               list.push(info);
            }
         }
         return list;
      }
      
      private function hasTeamInvitePlayer(userid:int) : Boolean
      {
         var i:int = 0;
         var item:* = null;
         for(i = 0; i < selfTeamInviteList.length; )
         {
            item = selfTeamInviteList[i] as TeamInvitedMemberInfo;
            if(item.id == userid)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      private function hasTeamMemberPlayer(userid:int) : Boolean
      {
         var i:int = 0;
         var item:* = null;
         for(i = 0; i < selfTeamMember.length; )
         {
            item = selfTeamMember[i] as TeamMemberInfo;
            if(item.ID == userid)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      public function get onlineTeamMemberList() : Array
      {
         var temp:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = selfTeamMember;
         for each(var i in selfTeamMember)
         {
            if(i.playerState.StateID != 0)
            {
               temp.push(i);
            }
         }
         return temp;
      }
      
      public function get offlineTeamMemberList() : Array
      {
         var temp:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = selfTeamMember;
         for each(var i in selfTeamMember)
         {
            if(i.playerState.StateID == 0)
            {
               temp.push(i);
            }
         }
         return temp;
      }
      
      public function get teamIMInfo() : Array
      {
         var temp:Array = [];
         var onlineTemp:Array = onlineTeamMemberList;
         var teamTitleInfo:TeamMemberInfo = new TeamMemberInfo();
         teamTitleInfo.type = 0;
         teamTitleInfo.isSelected = true;
         teamTitleInfo.RatifierName = LanguageMgr.GetTranslation("tank.team.teamNumber",onlineTemp.length,this.selfTeamMember.length);
         temp.push(teamTitleInfo);
         return temp;
      }
      
      public function teamLevelInfoByLevel(level:int) : TeamLevelInfo
      {
         return teamLevelList[level];
      }
      
      public function get teamBattleSeasonInfo() : TeamBattleSeasonInfo
      {
         return _teamBattleSeasonList.list[_teamBattleSeasonList.length - 1];
      }
      
      public function getTeamBattleSegmentInfo(segmentID:int) : TeamBattleSegmentInfo
      {
         return _teamBattleSegmentList[segmentID];
      }
      
      public function set teamBattleSeasonList(value:DictionaryData) : void
      {
         _teamBattleSeasonList = value;
      }
      
      public function set teamBattleSegmentList(value:DictionaryData) : void
      {
         _teamBattleSegmentList = value;
      }
      
      public function getTeamBattleSegment(score:int) : int
      {
         var segment:int = 0;
         var i:int = 0;
         for(i = 1; i <= 5; )
         {
            if(i != 5)
            {
               if(score >= _teamBattleSegmentList[i].NeedScore && score < _teamBattleSegmentList[i + 1].NeedScore)
               {
                  return i;
               }
            }
            else if(score >= _teamBattleSegmentList[i].NeedScore)
            {
               return i;
            }
            i++;
         }
         return 0;
      }
   }
}
