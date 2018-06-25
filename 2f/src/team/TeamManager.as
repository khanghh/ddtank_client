package team{   import com.pickgliss.action.AlertAction;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.manager.CacheSysManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.utils.ObjectUtils;   import ddt.CoreManager;   import ddt.events.PkgEvent;   import ddt.loader.LoaderCreate;   import ddt.manager.GameInSocketOut;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.StateManager;   import ddt.utils.AssetModuleLoader;   import flash.events.EventDispatcher;   import hall.HallStateView;   import hallIcon.HallIconManager;   import invite.InviteManager;   import team.analyze.TeamActiveAnalyze;   import team.analyze.TeamBattleSeasonAnalyzer;   import team.analyze.TeamBattleSegmentAnalyzer;   import team.analyze.TeamLevelAnalyze;   import team.analyze.TeamMemberAnalyze;   import team.analyze.TeamRankAnalyze;   import team.analyze.TeamShopAnalyze;   import team.event.TeamEvent;   import team.model.TeamInfo;   import team.model.TeamInvitedMemberInfo;   import team.model.TeamModel;   import team.model.TeamRecordInfo;   import team.view.TeamInviteFrame;      public class TeamManager extends EventDispatcher   {            private static var _instance:TeamManager;                   private var _model:TeamModel;            private var _coreManager:CoreManager;            private var _showType:int;            private var _isOpen:Boolean;            private var _teamBattleIcon:BaseButton;            private var _hall:HallStateView;            private var _frame:Frame;            public function TeamManager() { super(); }
            public static function get instance() : TeamManager { return null; }
            public function setup() : void { }
            private function __onCaptainTransfer(e:PkgEvent) : void { }
            private function __showOrHideIcon(e:PkgEvent) : void { }
            public function checkIcon() : void { }
            public function show() : void { }
            private function createRoom() : void { }
            private function __onUpdateTeamInfo(e:PkgEvent) : void { }
            private function __onTeamMember(e:PkgEvent) : void { }
            private function __onGetInviteList(e:PkgEvent) : void { }
            private function __onGetRecord(e:PkgEvent) : void { }
            private function __onInviteRepeal(e:PkgEvent) : void { }
            private function __onGetTeamActive(e:PkgEvent) : void { }
            private function __onGetSelfActive(e:PkgEvent) : void { }
            private function __onUpdateDayActive(e:PkgEvent) : void { }
            private function __onInviteFrame(e:PkgEvent) : void { }
            public function showTeamFrame() : void { }
            public function showCreateTeamFrame() : void { }
            private function createTeamFrame() : void { }
            public function showTeamMainFrame() : void { }
            private function teamMainFrame() : void { }
            public function disposeTeamMainFrame() : void { }
            public function showTeamBattleFrame() : void { }
            private function teamBattleFrame() : void { }
            public function showTeamRankFrame() : void { }
            private function teamRankFrame() : void { }
            public function refreshRank(type:int) : void { }
            public function analyzeMemberList(e:TeamMemberAnalyze) : void { }
            public function analyzeShopList(e:TeamShopAnalyze) : void { }
            public function analzeActiveList(e:TeamActiveAnalyze) : void { }
            public function analyzeRankList(e:TeamRankAnalyze) : void { }
            public function analyzeLevelList(e:TeamLevelAnalyze) : void { }
            public function analyzeSeasonList(e:TeamBattleSeasonAnalyzer) : void { }
            public function analyzeSegmentList(e:TeamBattleSegmentAnalyzer) : void { }
            public function hasTeamInvitePlayer(userid:int) : Boolean { return false; }
            public function get model() : TeamModel { return null; }
   }}