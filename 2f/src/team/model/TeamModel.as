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
      
      public function TeamModel(){super();}
      
      public function getTeamInfoByID(param1:int) : TeamInfo{return null;}
      
      public function addTeamInfo(param1:int, param2:TeamInfo) : void{}
      
      public function addTeamMemberInfo(param1:int, param2:Array) : void{}
      
      public function addTeamRecordList(param1:int, param2:Array) : void{}
      
      public function addTeamInviteList(param1:int, param2:Array) : void{}
      
      public function removeTeamInviteList(param1:int, param2:int = -1) : void{}
      
      public function addTeamActiveList(param1:int, param2:Array) : void{}
      
      public function get selfTeamMember() : Array{return null;}
      
      public function get selfTeamInfo() : TeamInfo{return null;}
      
      public function get selfTeamMemberInfo() : TeamMemberInfo{return null;}
      
      public function get selfTeamRecordList() : Array{return null;}
      
      public function get selfTeamInviteList() : Array{return null;}
      
      public function get selfTeamActiveList() : Array{return null;}
      
      public function get teamFriendList() : Array{return null;}
      
      public function get teamFriendListOnline() : Array{return null;}
      
      private function hasTeamInvitePlayer(param1:int) : Boolean{return false;}
      
      private function hasTeamMemberPlayer(param1:int) : Boolean{return false;}
      
      public function get onlineTeamMemberList() : Array{return null;}
      
      public function get offlineTeamMemberList() : Array{return null;}
      
      public function get teamIMInfo() : Array{return null;}
      
      public function teamLevelInfoByLevel(param1:int) : TeamLevelInfo{return null;}
      
      public function get teamBattleSeasonInfo() : TeamBattleSeasonInfo{return null;}
      
      public function getTeamBattleSegmentInfo(param1:int) : TeamBattleSegmentInfo{return null;}
      
      public function set teamBattleSeasonList(param1:DictionaryData) : void{}
      
      public function set teamBattleSegmentList(param1:DictionaryData) : void{}
      
      public function getTeamBattleSegment(param1:int) : int{return 0;}
   }
}
