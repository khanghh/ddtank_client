package team
{
   import com.pickgliss.action.AlertAction;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.CoreManager;
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.utils.AssetModuleLoader;
   import flash.events.EventDispatcher;
   import hall.HallStateView;
   import hallIcon.HallIconManager;
   import invite.InviteManager;
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
      
      private var _frame:Frame;
      
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
         SocketManager.Instance.addEventListener(PkgEvent.format(390,34),__onCaptainTransfer);
      }
      
      private function __onCaptainTransfer(e:PkgEvent) : void
      {
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createTeamMemeberLoader(),true);
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.creatFriendListLoader(),true);
         AssetModuleLoader.startLoader(null);
         SocketManager.Instance.out.sendTeamGetInfo(PlayerManager.Instance.Self.teamID);
      }
      
      private function __showOrHideIcon(e:PkgEvent) : void
      {
         _isOpen = e.pkg.readBoolean();
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
      
      private function __onUpdateTeamInfo(e:PkgEvent) : void
      {
         var teamInfo:TeamInfo = new TeamInfo();
         teamInfo.division = e.pkg.readInt();
         teamInfo.teamID = e.pkg.readInt();
         teamInfo.name = e.pkg.readUTF();
         teamInfo.tag = e.pkg.readUTF();
         teamInfo.grade = e.pkg.readInt();
         teamInfo.totalActive = e.pkg.readInt();
         teamInfo.active = e.pkg.readInt();
         teamInfo.maxActive = e.pkg.readInt();
         teamInfo.winTime = e.pkg.readInt();
         teamInfo.totalTime = e.pkg.readInt();
         teamInfo.createDate = e.pkg.readDate();
         teamInfo.socre = e.pkg.readInt();
         teamInfo.member = e.pkg.readInt();
         teamInfo.totalMember = e.pkg.readInt();
         teamInfo.season = e.pkg.readInt();
         var seasonInfo:String = e.pkg.readUTF();
         if(seasonInfo == "")
         {
            teamInfo.seasonInfo = [];
         }
         else
         {
            teamInfo.seasonInfo = seasonInfo.split("|");
         }
         var duty:int = e.pkg.readInt();
         if(teamInfo.teamID == PlayerManager.Instance.Self.teamID)
         {
            PlayerManager.Instance.Self.teamDuty = duty;
         }
         var loginDate:Date = e.pkg.readDate();
         if(teamInfo.teamID == PlayerManager.Instance.Self.teamID)
         {
            PlayerManager.Instance.Self.teamLoginDate = loginDate;
         }
         _model.addTeamInfo(teamInfo.teamID,teamInfo);
         dispatchEvent(new TeamEvent("updateteaminfo",teamInfo.teamID));
      }
      
      private function __onTeamMember(e:PkgEvent) : void
      {
         LoadResourceManager.Instance.startLoad(LoaderCreate.Instance.createTeamMemeberLoader());
      }
      
      private function __onGetInviteList(e:PkgEvent) : void
      {
         var i:int = 0;
         var info:* = null;
         var vipType:int = 0;
         var list:Array = [];
         var len:int = e.pkg.readInt();
         for(i = 0; i < len; )
         {
            info = new TeamInvitedMemberInfo();
            info.id = e.pkg.readInt();
            info.name = e.pkg.readUTF();
            info.date = e.pkg.readDate();
            vipType = e.pkg.readInt();
            info.isVip = vipType >= 1;
            list.push(info);
            i++;
         }
         _model.addTeamInviteList(PlayerManager.Instance.Self.teamID,list);
         dispatchEvent(new TeamEvent("updateinvitelist"));
      }
      
      private function __onGetRecord(e:PkgEvent) : void
      {
         var i:int = 0;
         var info:* = null;
         var list:Array = [];
         var teamid:int = e.pkg.readInt();
         var len:int = e.pkg.readInt();
         for(i = 0; i < len; )
         {
            info = new TeamRecordInfo();
            info.isWin = e.pkg.readBoolean();
            info.active = e.pkg.readInt();
            info.date = e.pkg.readDate();
            info.teamName = e.pkg.readUTF();
            info.teamZone = e.pkg.readUTF();
            info.teamKill = e.pkg.readInt();
            info.teamSurvival = e.pkg.readInt();
            info.teamMemberInfo = e.pkg.readUTF();
            info.enemyName = e.pkg.readUTF();
            info.enemyZone = e.pkg.readUTF();
            info.enemyKill = e.pkg.readInt();
            info.enemySurvival = e.pkg.readInt();
            info.enemyMemberInfo = e.pkg.readUTF();
            list.push(info);
            i++;
         }
         list.reverse();
         _model.addTeamRecordList(teamid,list);
         dispatchEvent(new TeamEvent("updatercordlist",teamid));
      }
      
      private function __onInviteRepeal(e:PkgEvent) : void
      {
         var userid:int = e.pkg.readInt();
         _model.removeTeamInviteList(PlayerManager.Instance.Self.teamID,userid);
         dispatchEvent(new TeamEvent("updateinvitelist"));
      }
      
      private function __onGetTeamActive(e:PkgEvent) : void
      {
         var i:int = 0;
         var name:* = null;
         var score:int = 0;
         var type:int = 0;
         var str:* = null;
         var list:Array = [];
         var len:int = e.pkg.readInt();
         for(i = 0; i < len; )
         {
            name = e.pkg.readUTF();
            score = e.pkg.readInt();
            type = e.pkg.readInt();
            str = LanguageMgr.GetTranslation("team.active.record" + type,name,score);
            list.push(str);
            i++;
         }
         _model.addTeamActiveList(PlayerManager.Instance.Self.teamID,list);
         dispatchEvent(new TeamEvent("updateactivelist"));
      }
      
      private function __onGetSelfActive(e:PkgEvent) : void
      {
         var i:int = 0;
         var type:int = 0;
         var haveScore:int = 0;
         var len:int = e.pkg.readInt();
         for(i = 0; i < len; )
         {
            type = e.pkg.readInt();
            haveScore = e.pkg.readInt();
            if(_model.activeList.hasKey(type))
            {
               _model.activeList[type].haveScore = haveScore;
            }
            else
            {
               trace("战队活跃个人活跃信息出错");
            }
            i++;
         }
         dispatchEvent(new TeamEvent("updateselfactive"));
      }
      
      private function __onUpdateDayActive(e:PkgEvent) : void
      {
         _model.selfScore = e.pkg.readInt();
         _model.selfActive = e.pkg.readInt();
         _model.selfAllActive = e.pkg.readInt();
         dispatchEvent(new TeamEvent("updateselfinfo"));
      }
      
      private function __onInviteFrame(e:PkgEvent) : void
      {
         var data:* = null;
         var frame:* = null;
         var playerID:int = e.pkg.readInt();
         var teamID:int = e.pkg.readInt();
         var userName:String = e.pkg.readUTF();
         var teamName:String = e.pkg.readUTF();
         if(TeamInviteFrame.hasAlert(teamID))
         {
            data = {
               "TeamID":teamID,
               "PlayerID":playerID,
               "UserName":userName,
               "TeamName":teamName
            };
            frame = ComponentFactory.Instance.creatComponentByStylename("team.invite.alertFrame");
            frame.setupData(data);
            if(CacheSysManager.isLock("alertInFight"))
            {
               CacheSysManager.getInstance().cache("alertInFight",new AlertAction(frame,3,1,"018",true));
            }
            else
            {
               LayerManager.Instance.addToLayer(frame,3,true,1);
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
         var frame:Frame = ComponentFactory.Instance.creatComponentByStylename("team.create.mainFrame");
         frame.titleText = LanguageMgr.GetTranslation("team.create.title");
         LayerManager.Instance.addToLayer(frame,3,true,1);
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
         _frame = ComponentFactory.Instance.creatComponentByStylename("team.mainFrame");
         _frame.titleText = LanguageMgr.GetTranslation("team.main.title");
         LayerManager.Instance.addToLayer(_frame,3,true,1);
         if(StateManager.currentStateType == "main")
         {
            InviteManager.Instance.enabled = false;
         }
      }
      
      public function disposeTeamMainFrame() : void
      {
         if(_frame)
         {
            ObjectUtils.disposeObject(_frame);
         }
         _frame = null;
         if(StateManager.currentStateType == "main")
         {
            InviteManager.Instance.enabled = true;
         }
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
         var frame:* = ComponentFactory.Instance.creatCustomObject("teamBattle.mainFrame");
         LayerManager.Instance.addToLayer(frame,3,true,1);
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
         var frame:* = null;
         if(model.rankList.length > 1 && model.rankList[0].length > 0)
         {
            frame = ComponentFactory.Instance.creatComponentByStylename("team.rankFrame");
            frame.titleText = LanguageMgr.GetTranslation("team.rank.title");
            LayerManager.Instance.addToLayer(frame,3,true,1);
            return;
         }
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.team.noServerTeamRank"));
      }
      
      public function refreshRank(type:int) : void
      {
         dispatchEvent(new TeamEvent("updateteamrank",type));
      }
      
      public function analyzeMemberList(e:TeamMemberAnalyze) : void
      {
         _model.addTeamMemberInfo(e.id,e.list);
         dispatchEvent(new TeamEvent("updateteammember"));
      }
      
      public function analyzeShopList(e:TeamShopAnalyze) : void
      {
         _model.shopList = e.data;
         _model.buyLimitLv = e.buyLimitLv;
      }
      
      public function analzeActiveList(e:TeamActiveAnalyze) : void
      {
         _model.activeList = e.data;
      }
      
      public function analyzeRankList(e:TeamRankAnalyze) : void
      {
         _model.rankList.push(e.data.list);
      }
      
      public function analyzeLevelList(e:TeamLevelAnalyze) : void
      {
         _model.teamLevelList = e.data;
      }
      
      public function analyzeSeasonList(e:TeamBattleSeasonAnalyzer) : void
      {
         _model.teamBattleSeasonList = e.data;
      }
      
      public function analyzeSegmentList(e:TeamBattleSegmentAnalyzer) : void
      {
         _model.teamBattleSegmentList = e.data;
      }
      
      public function hasTeamInvitePlayer(userid:int) : Boolean
      {
         var i:int = 0;
         var item:* = null;
         for(i = 0; i < _model.selfTeamInviteList.length; )
         {
            item = _model.selfTeamInviteList[i] as TeamInvitedMemberInfo;
            if(item.id == userid)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      public function get model() : TeamModel
      {
         return _model;
      }
   }
}
