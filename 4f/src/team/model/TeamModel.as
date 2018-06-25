package team.model{   import ddt.data.player.FriendListPlayer;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import road7th.data.DictionaryData;      public class TeamModel   {                   public var selfScore:int;            public var selfActive:int;            public var selfAllActive:int;            public var shopList:DictionaryData;            public var buyLimitLv:Array;            public var inviteList:Array;            public var activeList:DictionaryData;            private var _teamInfoList:DictionaryData;            private var _teamMemberList:DictionaryData;            private var _teamRecordList:DictionaryData;            private var _teamInviteList:DictionaryData;            private var _teamActiveList:DictionaryData;            public var rankList:Array;            private var _teamBattleSeasonList:DictionaryData;            private var _teamBattleSegmentList:DictionaryData;            public var teamLevelList:DictionaryData;            public var currentAreaName:String;            public function TeamModel() { super(); }
            public function getTeamInfoByID(id:int) : TeamInfo { return null; }
            public function addTeamInfo(id:int, info:TeamInfo) : void { }
            public function addTeamMemberInfo(id:int, list:Array) : void { }
            public function addTeamRecordList(id:int, list:Array) : void { }
            public function addTeamInviteList(id:int, list:Array) : void { }
            public function removeTeamInviteList(id:int, userid:int = -1) : void { }
            public function addTeamActiveList(id:int, list:Array) : void { }
            public function get selfTeamMember() : Array { return null; }
            public function get selfTeamInfo() : TeamInfo { return null; }
            public function get selfTeamMemberInfo() : TeamMemberInfo { return null; }
            public function get selfTeamRecordList() : Array { return null; }
            public function get selfTeamInviteList() : Array { return null; }
            public function get selfTeamActiveList() : Array { return null; }
            public function get teamFriendList() : Array { return null; }
            public function get teamFriendListOnline() : Array { return null; }
            private function hasTeamInvitePlayer(userid:int) : Boolean { return false; }
            private function hasTeamMemberPlayer(userid:int) : Boolean { return false; }
            public function get onlineTeamMemberList() : Array { return null; }
            public function get offlineTeamMemberList() : Array { return null; }
            public function get teamIMInfo() : Array { return null; }
            public function teamLevelInfoByLevel(level:int) : TeamLevelInfo { return null; }
            public function get teamBattleSeasonInfo() : TeamBattleSeasonInfo { return null; }
            public function getTeamBattleSegmentInfo(segmentID:int) : TeamBattleSegmentInfo { return null; }
            public function set teamBattleSeasonList(value:DictionaryData) : void { }
            public function set teamBattleSegmentList(value:DictionaryData) : void { }
            public function getTeamBattleSegment(score:int) : int { return 0; }
   }}