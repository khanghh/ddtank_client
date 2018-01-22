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
      
      public function TeamManager()
      {
         super();
      }
      
      public static function get instance() : TeamManager
      {
         if(_instance == null)
         {
            _instance = new TeamManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _model = new TeamModel();
         SocketManager.Instance.addEventListener(PkgEvent.format(390,1),__onUpdateTeamInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(390,19),__onTeamMember);
         SocketManager.Instance.addEventListener(PkgEvent.format(390,15),__onGetInviteList);
         SocketManager.Instance.addEventListener(PkgEvent.format(390,9),__onGetRecord);
         SocketManager.Instance.addEventListener(PkgEvent.format(390,4),__onInviteRepeal);
         SocketManager.Instance.addEventListener(PkgEvent.format(390,10),__onGetTeamActive);
         SocketManager.Instance.addEventListener(PkgEvent.format(390,12),__onUpdateDayActive);
         SocketManager.Instance.addEventListener(PkgEvent.format(390,16),__onGetSelfActive);
         SocketManager.Instance.addEventListener(PkgEvent.format(390,3),__onInviteFrame);
         SocketManager.Instance.addEventListener(PkgEvent.format(390,14),__showOrHideIcon);
      }
      
      private function __showOrHideIcon(param1:PkgEvent) : void
      {
         _isOpen = param1.pkg.readBoolean();
         checkIcon();
      }
      
      public function checkIcon() : void
      {
         if(PlayerManager.Instance.Self.Grade < 26)
         {
            return;
         }
         HallIconManager.instance.updateSwitchHandler("teamBattle",_isOpen);
      }
      
      public function show() : void
      {
         AssetModuleLoader.addModelLoader("ddtroom",6);
         AssetModuleLoader.addModelLoader("ddtcorescalebitmap",4);
         AssetModuleLoader.addModelLoader("chatball",4);
         AssetModuleLoader.startCodeLoader(createRoom);
      }
      
      private function createRoom() : void
      {
         GameInSocketOut.sendCreateRoom(LanguageMgr.GetTranslation("teamBattle.roomName"),58,2);
      }
      
      private function __onUpdateTeamInfo(param1:PkgEvent) : void
      {
         var _loc3_:TeamInfo = new TeamInfo();
         _loc3_.division = param1.pkg.readInt();
         _loc3_.teamID = param1.pkg.readInt();
         _loc3_.name = param1.pkg.readUTF();
         _loc3_.tag = param1.pkg.readUTF();
         _loc3_.grade = param1.pkg.readInt();
         _loc3_.totalActive = param1.pkg.readInt();
         _loc3_.active = param1.pkg.readInt();
         _loc3_.maxActive = param1.pkg.readInt();
         _loc3_.winTime = param1.pkg.readInt();
         _loc3_.totalTime = param1.pkg.readInt();
         _loc3_.createDate = param1.pkg.readDate();
         _loc3_.socre = param1.pkg.readInt();
         _loc3_.member = param1.pkg.readInt();
         _loc3_.totalMember = param1.pkg.readInt();
         _loc3_.season = param1.pkg.readInt();
         var _loc2_:String = param1.pkg.readUTF();
         if(_loc2_ == "")
         {
            _loc3_.seasonInfo = [];
         }
         else
         {
            _loc3_.seasonInfo = _loc2_.split("|");
         }
         var _loc4_:int = param1.pkg.readInt();
         if(_loc3_.teamID == PlayerManager.Instance.Self.teamID)
         {
            PlayerManager.Instance.Self.teamDuty = _loc4_;
         }
         var _loc5_:Date = param1.pkg.readDate();
         if(_loc3_.teamID == PlayerManager.Instance.Self.teamID)
         {
            PlayerManager.Instance.Self.teamLoginDate = _loc5_;
         }
         _model.addTeamInfo(_loc3_.teamID,_loc3_);
         dispatchEvent(new TeamEvent("updateteaminfo",_loc3_.teamID));
      }
      
      private function __onTeamMember(param1:PkgEvent) : void
      {
         LoadResourceManager.Instance.startLoad(LoaderCreate.Instance.createTeamMemeberLoader());
      }
      
      private function __onGetInviteList(param1:PkgEvent) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc2_:int = 0;
         var _loc3_:Array = [];
         var _loc4_:int = param1.pkg.readInt();
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = new TeamInvitedMemberInfo();
            _loc5_.id = param1.pkg.readInt();
            _loc5_.name = param1.pkg.readUTF();
            _loc5_.date = param1.pkg.readDate();
            _loc2_ = param1.pkg.readInt();
            _loc5_.isVip = _loc2_ >= 1;
            _loc3_.push(_loc5_);
            _loc6_++;
         }
         _model.addTeamInviteList(PlayerManager.Instance.Self.teamID,_loc3_);
         dispatchEvent(new TeamEvent("updateinvitelist"));
      }
      
      private function __onGetRecord(param1:PkgEvent) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc3_:Array = [];
         var _loc2_:int = param1.pkg.readInt();
         var _loc4_:int = param1.pkg.readInt();
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = new TeamRecordInfo();
            _loc5_.isWin = param1.pkg.readBoolean();
            _loc5_.active = param1.pkg.readInt();
            _loc5_.date = param1.pkg.readDate();
            _loc5_.teamName = param1.pkg.readUTF();
            _loc5_.teamZone = param1.pkg.readUTF();
            _loc5_.teamKill = param1.pkg.readInt();
            _loc5_.teamSurvival = param1.pkg.readInt();
            _loc5_.teamMemberInfo = param1.pkg.readUTF();
            _loc5_.enemyName = param1.pkg.readUTF();
            _loc5_.enemyZone = param1.pkg.readUTF();
            _loc5_.enemyKill = param1.pkg.readInt();
            _loc5_.enemySurvival = param1.pkg.readInt();
            _loc5_.enemyMemberInfo = param1.pkg.readUTF();
            _loc3_.push(_loc5_);
            _loc6_++;
         }
         _loc3_.reverse();
         _model.addTeamRecordList(_loc2_,_loc3_);
         dispatchEvent(new TeamEvent("updatercordlist",_loc2_));
      }
      
      private function __onInviteRepeal(param1:PkgEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         _model.removeTeamInviteList(PlayerManager.Instance.Self.teamID,_loc2_);
         dispatchEvent(new TeamEvent("updateinvitelist"));
      }
      
      private function __onGetTeamActive(param1:PkgEvent) : void
      {
         var _loc8_:int = 0;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:* = null;
         var _loc5_:Array = [];
         var _loc6_:int = param1.pkg.readInt();
         _loc8_ = 0;
         while(_loc8_ < _loc6_)
         {
            _loc3_ = param1.pkg.readUTF();
            _loc4_ = param1.pkg.readInt();
            _loc7_ = param1.pkg.readInt();
            _loc2_ = LanguageMgr.GetTranslation("team.active.record" + _loc7_,_loc3_,_loc4_);
            _loc5_.push(_loc2_);
            _loc8_++;
         }
         _model.addTeamActiveList(PlayerManager.Instance.Self.teamID,_loc5_);
         dispatchEvent(new TeamEvent("updateactivelist"));
      }
      
      private function __onGetSelfActive(param1:PkgEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = param1.pkg.readInt();
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc4_ = param1.pkg.readInt();
            _loc3_ = param1.pkg.readInt();
            if(_model.activeList.hasKey(_loc4_))
            {
               _model.activeList[_loc4_].haveScore = _loc3_;
            }
            else
            {
               trace("战队活跃个人活跃信息出错");
            }
            _loc5_++;
         }
         dispatchEvent(new TeamEvent("updateselfactive"));
      }
      
      private function __onUpdateDayActive(param1:PkgEvent) : void
      {
         _model.selfScore = param1.pkg.readInt();
         _model.selfActive = param1.pkg.readInt();
         _model.selfAllActive = param1.pkg.readInt();
         dispatchEvent(new TeamEvent("updateselfinfo"));
      }
      
      private function __onInviteFrame(param1:PkgEvent) : void
      {
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc4_:int = param1.pkg.readInt();
         var _loc7_:int = param1.pkg.readInt();
         var _loc6_:String = param1.pkg.readUTF();
         var _loc2_:String = param1.pkg.readUTF();
         if(TeamInviteFrame.hasAlert(_loc7_))
         {
            _loc5_ = {
               "TeamID":_loc7_,
               "PlayerID":_loc4_,
               "UserName":_loc6_,
               "TeamName":_loc2_
            };
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("team.invite.alertFrame");
            _loc3_.setupData(_loc5_);
            if(CacheSysManager.isLock("alertInFight"))
            {
               CacheSysManager.getInstance().cache("alertInFight",new AlertAction(_loc3_,3,1,"018",true));
            }
            else
            {
               LayerManager.Instance.addToLayer(_loc3_,3,true,1);
            }
         }
      }
      
      public function showTeamFrame() : void
      {
         if(PlayerManager.Instance.Self.teamID != 0)
         {
            showTeamMainFrame();
         }
         else
         {
            showCreateTeamFrame();
         }
      }
      
      public function showCreateTeamFrame() : void
      {
         AssetModuleLoader.addModelLoader("teamcreate",4);
         AssetModuleLoader.addModelLoader("team",3);
         AssetModuleLoader.startCodeLoader(createTeamFrame);
      }
      
      private function createTeamFrame() : void
      {
         var _loc1_:Frame = ComponentFactory.Instance.creatComponentByStylename("team.create.mainFrame");
         _loc1_.titleText = LanguageMgr.GetTranslation("team.create.title");
         LayerManager.Instance.addToLayer(_loc1_,3,true,1);
      }
      
      public function showTeamMainFrame() : void
      {
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createTeamMemeberLoader(),true);
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.creatFriendListLoader(),true);
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createTeamShopLoader());
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createTeamAcviteListLoader());
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createTeamLevelListLoader());
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createTeamBattleSegmentLoader());
         AssetModuleLoader.addModelLoader("team",7);
         AssetModuleLoader.startCodeLoader(teamMainFrame);
      }
      
      private function teamMainFrame() : void
      {
         SocketManager.Instance.out.sendTeamGetInfo(PlayerManager.Instance.Self.teamID);
         var _loc1_:Frame = ComponentFactory.Instance.creatComponentByStylename("team.mainFrame");
         _loc1_.titleText = LanguageMgr.GetTranslation("team.main.title");
         LayerManager.Instance.addToLayer(_loc1_,3,true,1);
      }
      
      public function showTeamBattleFrame() : void
      {
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createTeamBattleSeasonLoader());
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createTeamBattleSegmentLoader());
         AssetModuleLoader.addModelLoader("teamBattle",4);
         AssetModuleLoader.addModelLoader("team",7);
         AssetModuleLoader.startCodeLoader(teamBattleFrame);
      }
      
      private function teamBattleFrame() : void
      {
         var _loc1_:* = ComponentFactory.Instance.creatCustomObject("teamBattle.mainFrame");
         LayerManager.Instance.addToLayer(_loc1_,3,true,1);
      }
      
      public function showTeamRankFrame() : void
      {
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createTheServerTeamRankLoader());
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createCrossServerTeamRankLoader());
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createTeamLevelListLoader());
         AssetModuleLoader.addModelLoader("team",7);
         AssetModuleLoader.startCodeLoader(teamRankFrame);
      }
      
      private function teamRankFrame() : void
      {
         var _loc1_:* = null;
         if(model.rankList.length > 1 && model.rankList[0].length > 0)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("team.rankFrame");
            _loc1_.titleText = LanguageMgr.GetTranslation("team.rank.title");
            LayerManager.Instance.addToLayer(_loc1_,3,true,1);
            return;
         }
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.team.noServerTeamRank"));
      }
      
      public function refreshRank(param1:int) : void
      {
         dispatchEvent(new TeamEvent("updateteamrank",param1));
      }
      
      public function analyzeMemberList(param1:TeamMemberAnalyze) : void
      {
         _model.addTeamMemberInfo(param1.id,param1.list);
         dispatchEvent(new TeamEvent("updateteammember"));
      }
      
      public function analyzeShopList(param1:TeamShopAnalyze) : void
      {
         _model.shopList = param1.data;
         _model.buyLimitLv = param1.buyLimitLv;
      }
      
      public function analzeActiveList(param1:TeamActiveAnalyze) : void
      {
         _model.activeList = param1.data;
      }
      
      public function analyzeRankList(param1:TeamRankAnalyze) : void
      {
         _model.rankList.push(param1.data.list);
      }
      
      public function analyzeLevelList(param1:TeamLevelAnalyze) : void
      {
         _model.teamLevelList = param1.data;
      }
      
      public function analyzeSeasonList(param1:TeamBattleSeasonAnalyzer) : void
      {
         _model.teamBattleSeasonList = param1.data;
      }
      
      public function analyzeSegmentList(param1:TeamBattleSegmentAnalyzer) : void
      {
         _model.teamBattleSegmentList = param1.data;
      }
      
      public function hasTeamInvitePlayer(param1:int) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < _model.selfTeamInviteList.length)
         {
            _loc2_ = _model.selfTeamInviteList[_loc3_] as TeamInvitedMemberInfo;
            if(_loc2_.id == param1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function get model() : TeamModel
      {
         return _model;
      }
   }
}
