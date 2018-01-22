package team
{
   import com.pickgliss.action.AlertAction;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import ddt.CoreManager;
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.AssetModuleLoader;
   import flash.events.EventDispatcher;
   import hall.HallStateView;
   import hallIcon.HallIconManager;
   import team.analyze.TeamActiveAnalyze;
   import team.analyze.TeamBattleSeasonAnalyzer;
   import team.analyze.TeamBattleSegmentAnalyzer;
   import team.analyze.TeamLevelAnalyze;
   import team.analyze.TeamMemberAnalyze;
   import team.analyze.TeamRankAnalyze;
   import team.analyze.TeamShopAnalyze;
   import team.event.TeamEvent;
   import team.model.TeamInfo;
   import team.model.TeamInvitedMemberInfo;
   import team.model.TeamModel;
   import team.model.TeamRecordInfo;
   import team.view.TeamInviteFrame;
   
   public class TeamManager extends EventDispatcher
   {
      
      private static var _instance:TeamManager;
       
      
      private var _model:TeamModel;
      
      private var _coreManager:CoreManager;
      
      private var _showType:int;
      
      private var _isOpen:Boolean;
      
      private var _teamBattleIcon:BaseButton;
      
      private var _hall:HallStateView;
      
      public function TeamManager(){super();}
      
      public static function get instance() : TeamManager{return null;}
      
      public function setup() : void{}
      
      private function __showOrHideIcon(param1:PkgEvent) : void{}
      
      public function checkIcon() : void{}
      
      public function show() : void{}
      
      private function createRoom() : void{}
      
      private function __onUpdateTeamInfo(param1:PkgEvent) : void{}
      
      private function __onTeamMember(param1:PkgEvent) : void{}
      
      private function __onGetInviteList(param1:PkgEvent) : void{}
      
      private function __onGetRecord(param1:PkgEvent) : void{}
      
      private function __onInviteRepeal(param1:PkgEvent) : void{}
      
      private function __onGetTeamActive(param1:PkgEvent) : void{}
      
      private function __onGetSelfActive(param1:PkgEvent) : void{}
      
      private function __onUpdateDayActive(param1:PkgEvent) : void{}
      
      private function __onInviteFrame(param1:PkgEvent) : void{}
      
      public function showTeamFrame() : void{}
      
      public function showCreateTeamFrame() : void{}
      
      private function createTeamFrame() : void{}
      
      public function showTeamMainFrame() : void{}
      
      private function teamMainFrame() : void{}
      
      public function showTeamBattleFrame() : void{}
      
      private function teamBattleFrame() : void{}
      
      public function showTeamRankFrame() : void{}
      
      private function teamRankFrame() : void{}
      
      public function refreshRank(param1:int) : void{}
      
      public function analyzeMemberList(param1:TeamMemberAnalyze) : void{}
      
      public function analyzeShopList(param1:TeamShopAnalyze) : void{}
      
      public function analzeActiveList(param1:TeamActiveAnalyze) : void{}
      
      public function analyzeRankList(param1:TeamRankAnalyze) : void{}
      
      public function analyzeLevelList(param1:TeamLevelAnalyze) : void{}
      
      public function analyzeSeasonList(param1:TeamBattleSeasonAnalyzer) : void{}
      
      public function analyzeSegmentList(param1:TeamBattleSegmentAnalyzer) : void{}
      
      public function hasTeamInvitePlayer(param1:int) : Boolean{return false;}
      
      public function get model() : TeamModel{return null;}
   }
}
