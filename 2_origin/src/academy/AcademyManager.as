package academy
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.data.analyze.AcademyMemberListAnalyze;
   import ddt.data.analyze.MyAcademyPlayersAnalyze;
   import ddt.data.player.AcademyPlayerInfo;
   import ddt.data.player.BasePlayer;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.AcademyFrameManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddt.utils.RequestVairableCreater;
   import ddt.view.academyCommon.data.SimpleMessger;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.net.URLVariables;
   import quest.TaskManager;
   import road7th.data.DictionaryData;
   import road7th.utils.DateUtils;
   
   public class AcademyManager extends EventDispatcher
   {
      
      public static const SELF_DESCRIBE:String = "selfDescribe";
      
      public static const LEVEL_GAP:int = 5;
      
      public static const TARGET_PLAYER_MIN_LEVEL:int = 8;
      
      public static const FARM_PLAYER_MIN_LEVEL:int = 25;
      
      public static const ACADEMY_LEVEL_MIN:int = 21;
      
      public static const ACADEMY_LEVEL_MAX:int = 8;
      
      public static const RECOMMEND_MAX_NUM:int = 3;
      
      public static const GRADUATE_NUM:Array = [1,5,10,50,99];
      
      public static const MASTER:Boolean = false;
      
      public static const APPSHIP:Boolean = true;
      
      public static const ACADEMY:Boolean = true;
      
      public static const RECOMMEND:Boolean = false;
      
      public static const NONE_STATE:int = 0;
      
      public static const APPRENTICE_STATE:int = 1;
      
      public static const MASTER_STATE:int = 2;
      
      public static const MASTER_FULL_STATE:int = 3;
      
      private static var _instance:AcademyManager;
       
      
      public var isShowRecommend:Boolean = true;
      
      public var freezesDate:Date;
      
      public var selfIsRegister:Boolean;
      
      public var isSelfPublishEquip:Boolean;
      
      private var _showMessage:Boolean = true;
      
      private var _recommendPlayers:Vector.<AcademyPlayerInfo>;
      
      private var _myAcademyPlayers:DictionaryData;
      
      private var _messgers:Vector.<SimpleMessger>;
      
      private var _selfDescribe:String;
      
      public function AcademyManager()
      {
         super();
      }
      
      public static function get Instance() : AcademyManager
      {
         if(_instance == null)
         {
            _instance = new AcademyManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
         _messgers = new Vector.<SimpleMessger>();
      }
      
      private function initEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(141),__apprenticeSystemAnswer);
      }
      
      private function __apprenticeSystemAnswer(event:PkgEvent) : void
      {
         var id:int = 0;
         var name:* = null;
         var message:* = null;
         var ID:int = 0;
         var Name:* = null;
         var Message:* = null;
         var removeID:int = 0;
         var graduateType:int = 0;
         var graduateID:int = 0;
         var graduateName:* = null;
         var masetrOrApprentceID:int = 0;
         var nickName:* = null;
         var messageI:* = null;
         var isGotoAcademy:Boolean = false;
         var type:int = event.pkg.readByte();
         switch(int(type) - 4)
         {
            case 0:
               id = event.pkg.readInt();
               name = event.pkg.readUTF();
               message = event.pkg.readUTF();
               if(SharedManager.Instance.unAcceptAnswer.indexOf(id) < 0)
               {
                  AcademyFrameManager.Instance.showAcademyAnswerMasterFrame(id,name,message);
               }
               break;
            case 1:
               ID = event.pkg.readInt();
               Name = event.pkg.readUTF();
               Message = event.pkg.readUTF();
               if(PlayerManager.Instance.Self.apprenticeshipState == 1)
               {
                  return;
               }
               if(SharedManager.Instance.unAcceptAnswer.indexOf(ID) < 0)
               {
                  AcademyFrameManager.Instance.showAcademyAnswerApprenticeFrame(ID,Name,Message);
               }
               break;
            case 2:
            case 3:
               masetrOrApprentceID = event.pkg.readInt();
               nickName = event.pkg.readUTF();
               break;
            default:
               masetrOrApprentceID = event.pkg.readInt();
               nickName = event.pkg.readUTF();
               break;
            default:
               masetrOrApprentceID = event.pkg.readInt();
               nickName = event.pkg.readUTF();
               break;
            case 6:
               PlayerManager.Instance.Self.apprenticeshipState = event.pkg.readInt();
               PlayerManager.Instance.Self.masterID = event.pkg.readInt();
               PlayerManager.Instance.Self.setMasterOrApprentices(event.pkg.readUTF());
               removeID = event.pkg.readInt();
               PlayerManager.Instance.Self.graduatesCount = event.pkg.readInt();
               PlayerManager.Instance.Self.honourOfMaster = event.pkg.readUTF();
               PlayerManager.Instance.Self.freezesDate = event.pkg.readDate();
               if(_myAcademyPlayers && removeID != -1)
               {
                  _myAcademyPlayers.remove(removeID);
               }
               if(_myAcademyPlayers && PlayerManager.Instance.Self.apprenticeshipState == 0)
               {
                  _myAcademyPlayers.clear();
               }
               if(PlayerManager.Instance.Self.apprenticeshipState != 0)
               {
                  TaskManager.instance.requestCanAcceptTask();
               }
               break;
            case 7:
               graduateType = event.pkg.readInt();
               graduateID = event.pkg.readInt();
               graduateName = event.pkg.readUTF();
               if(graduateType == 0)
               {
                  AcademyFrameManager.Instance.showApprenticeGraduate();
               }
               else if(graduateType == 1)
               {
                  AcademyFrameManager.Instance.showMasterGraduate(graduateName);
               }
               break;
            default:
               graduateType = event.pkg.readInt();
               graduateID = event.pkg.readInt();
               graduateName = event.pkg.readUTF();
               if(graduateType == 0)
               {
                  AcademyFrameManager.Instance.showApprenticeGraduate();
               }
               else if(graduateType == 1)
               {
                  AcademyFrameManager.Instance.showMasterGraduate(graduateName);
               }
               break;
            default:
               graduateType = event.pkg.readInt();
               graduateID = event.pkg.readInt();
               graduateName = event.pkg.readUTF();
               if(graduateType == 0)
               {
                  AcademyFrameManager.Instance.showApprenticeGraduate();
               }
               else if(graduateType == 1)
               {
                  AcademyFrameManager.Instance.showMasterGraduate(graduateName);
               }
               break;
            default:
               graduateType = event.pkg.readInt();
               graduateID = event.pkg.readInt();
               graduateName = event.pkg.readUTF();
               if(graduateType == 0)
               {
                  AcademyFrameManager.Instance.showApprenticeGraduate();
               }
               else if(graduateType == 1)
               {
                  AcademyFrameManager.Instance.showMasterGraduate(graduateName);
               }
               break;
            default:
               graduateType = event.pkg.readInt();
               graduateID = event.pkg.readInt();
               graduateName = event.pkg.readUTF();
               if(graduateType == 0)
               {
                  AcademyFrameManager.Instance.showApprenticeGraduate();
               }
               else if(graduateType == 1)
               {
                  AcademyFrameManager.Instance.showMasterGraduate(graduateName);
               }
               break;
            default:
               graduateType = event.pkg.readInt();
               graduateID = event.pkg.readInt();
               graduateName = event.pkg.readUTF();
               if(graduateType == 0)
               {
                  AcademyFrameManager.Instance.showApprenticeGraduate();
               }
               else if(graduateType == 1)
               {
                  AcademyFrameManager.Instance.showMasterGraduate(graduateName);
               }
               break;
            case 13:
               messageI = event.pkg.readUTF();
               isGotoAcademy = event.pkg.readBoolean();
               academyAlert(messageI,isGotoAcademy);
         }
      }
      
      private function academyAlert(message:String, isGotoAcademy:Boolean) : void
      {
         var alert:* = null;
         if(isGotoAcademy)
         {
            AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),message,LanguageMgr.GetTranslation("ok"),"",false,false,false,2).addEventListener("response",__onCancel);
         }
         else if(!isFighting())
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),message,LanguageMgr.GetTranslation("ddt.manager.AcademyManager.alertSubmit"),"",false,false,false,2);
            alert.addEventListener("response",__frameEvent);
         }
         else if(StateManager.currentStateType == "hotSpringRoom" || StateManager.currentStateType == "churchRoom")
         {
            AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),message,LanguageMgr.GetTranslation("ok"),"",false,false,false,2).addEventListener("response",__onCancel);
         }
      }
      
      private function __onCancel(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (event.currentTarget as BaseAlerFrame).removeEventListener("response",__frameEvent);
         (event.currentTarget as BaseAlerFrame).dispose();
      }
      
      private function __frameEvent(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (event.currentTarget as BaseAlerFrame).removeEventListener("response",__frameEvent);
         (event.currentTarget as BaseAlerFrame).dispose();
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               StateManager.setState("academyRegistration");
         }
      }
      
      public function loadAcademyMemberList(callback:Function, requestType:Boolean = true, appshipStateType:Boolean = false, page:int = 1, name:String = "", grade:int = 0, sex:Boolean = true, isReturnSelf:Boolean = false) : void
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["requestType"] = requestType;
         args["appshipStateType"] = appshipStateType;
         args["page"] = page;
         args["name"] = name;
         args["Grade"] = grade;
         args["sex"] = sex;
         args["isReturnSelf"] = isReturnSelf;
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ApprenticeshipClubList.ashx"),6,args,"GET",null,true,true);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("civil.frame.CivilRegisterFrame.infoError");
         loader.analyzer = new AcademyMemberListAnalyze(callback);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      public function recommend() : void
      {
         if(isOpenSpace(PlayerManager.Instance.Self) || !isRecommend())
         {
            return;
         }
         if(!DateUtils.isToday(new Date(PlayerManager.Instance.Self.LastDate)) || !SharedManager.Instance.isRecommend)
         {
            _showMessage = false;
            if(PlayerManager.Instance.Self.Grade < 21)
            {
               loadAcademyMemberList(__recommendPlayersComplete,false,false,1,"",PlayerManager.Instance.Self.Grade,PlayerManager.Instance.Self.Sex);
            }
            else
            {
               loadAcademyMemberList(__recommendPlayersComplete,false,true,1,"",PlayerManager.Instance.Self.Grade,PlayerManager.Instance.Self.Sex);
            }
         }
      }
      
      public function recommends() : void
      {
         if(isOpenSpace(PlayerManager.Instance.Self))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.manager.AcademyManager.warning8"));
            return;
         }
         _showMessage = true;
         if(PlayerManager.Instance.Self.Grade < 21)
         {
            loadAcademyMemberList(__recommendPlayersComplete,false,false,1,"",PlayerManager.Instance.Self.Grade,PlayerManager.Instance.Self.Sex);
         }
         else
         {
            loadAcademyMemberList(__recommendPlayersComplete,false,true,1,"",PlayerManager.Instance.Self.Grade,PlayerManager.Instance.Self.Sex);
         }
      }
      
      private function __recommendPlayersComplete(action:AcademyMemberListAnalyze) : void
      {
         _recommendPlayers = action.academyMemberList;
         if(_recommendPlayers.length >= 3)
         {
            if(PlayerManager.Instance.Self.Grade < 21)
            {
               AcademyFrameManager.Instance.showAcademyApprenticeMainFrame();
            }
            else
            {
               AcademyFrameManager.Instance.showAcademyMasterMainFrame();
            }
         }
         else if(_showMessage)
         {
            if(PlayerManager.Instance.Self.Grade >= 21)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.data.analyze.AcademyMemberListAnalyze.info"));
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.data.analyze.AcademyMemberListAnalyze.infoI"));
            }
         }
         isShowRecommend = false;
      }
      
      public function get recommendPlayers() : Vector.<AcademyPlayerInfo>
      {
         return _recommendPlayers;
      }
      
      public function get myAcademyPlayers() : DictionaryData
      {
         return _myAcademyPlayers;
      }
      
      public function myAcademy() : void
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["RelationshipID"] = PlayerManager.Instance.Self.masterID;
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("UserApprenticeshipInfoList.ashx"),6,args);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.data.analyze.MyAcademyPlayersAnalyze");
         loader.analyzer = new MyAcademyPlayersAnalyze(__myAcademyPlayersComplete);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      private function __myAcademyPlayersComplete(action:MyAcademyPlayersAnalyze) : void
      {
         _myAcademyPlayers = action.myAcademyPlayers;
         if(_myAcademyPlayers.length == 0)
         {
            return;
         }
         if(PlayerManager.Instance.Self.Grade < 21)
         {
            AcademyFrameManager.Instance.showMyAcademyApprenticeFrame();
         }
         else
         {
            AcademyFrameManager.Instance.showMyAcademyMasterFrame();
         }
      }
      
      public function compareState(targetPlayer:BasePlayer, currentPlayer:PlayerInfo) : Boolean
      {
         if(currentPlayer.Grade < 8)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.manager.AcademyManager.warning6"));
            return false;
         }
         if(targetPlayer.Grade < 8)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.manager.AcademyManager.warningII"));
            return false;
         }
         if(currentPlayer.apprenticeshipState == 1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.manager.AcademyManager.WarningApprenticeState"));
            return false;
         }
         if(currentPlayer.apprenticeshipState == 3)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.manager.AcademyManager.WarningMasterFullState"));
            return false;
         }
         if(currentPlayer.Grade >= 21)
         {
            if(targetPlayer.Grade >= 21)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.manager.AcademyManager.warningIII"));
               return false;
            }
            if(currentPlayer.Grade - targetPlayer.Grade >= 5)
            {
               return true;
            }
            if(currentPlayer.Grade - targetPlayer.Grade < 5)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.manager.AcademyManager.warning"));
               return false;
            }
         }
         else
         {
            if(targetPlayer.Grade < 21)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.manager.AcademyManager.warningIIII"));
               return false;
            }
            if(targetPlayer.Grade - currentPlayer.Grade >= 5)
            {
               return true;
            }
            if(targetPlayer.Grade - currentPlayer.Grade < 5)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.manager.AcademyManager.warningI"));
               return false;
            }
         }
         return false;
      }
      
      public function gotoAcademyState() : void
      {
         var alert:* = null;
         if(StateManager.currentStateType == "matchRoom" || StateManager.currentStateType == "missionResult" || StateManager.currentStateType == "dungeonRoom" || StateManager.currentStateType == "freshmanRoom1" || StateManager.currentStateType == "freshmanRoom2")
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.manager.AcademyManager.warning10"),LanguageMgr.GetTranslation("ok"),"",false,false,false,2);
            alert.addEventListener("response",__onResponse);
         }
         else
         {
            StateManager.setState("academyRegistration");
         }
      }
      
      private function __onResponse(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (event.currentTarget as BaseAlerFrame).removeEventListener("response",__onResponse);
         (event.currentTarget as BaseAlerFrame).dispose();
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               StateManager.setState("academyRegistration");
         }
      }
      
      public function getMasterHonorLevel(value:int) : int
      {
         var i:int = 0;
         var level:int = 0;
         for(i = 0; i < GRADUATE_NUM.length; )
         {
            if(value >= GRADUATE_NUM[i])
            {
               level++;
            }
            i++;
         }
         return level;
      }
      
      public function isFreezes(requestType:Boolean) : Boolean
      {
         var serverDate:Date = TimeManager.Instance.serverDate;
         if(PlayerManager.Instance.Self.freezesDate > serverDate)
         {
            if(requestType)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.manager.academyManager.Freezes"));
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.manager.academyManager.FreezesII"));
            }
            return false;
         }
         return true;
      }
      
      public function set messgers(value:Vector.<SimpleMessger>) : void
      {
         _messgers = value;
      }
      
      public function get messgers() : Vector.<SimpleMessger>
      {
         return _messgers;
      }
      
      public function showAlert() : void
      {
         while(messgers.length != 0)
         {
            if(messgers[0] && messgers[0].type == 1)
            {
               AcademyFrameManager.Instance.showAcademyAnswerApprenticeFrame(messgers[0].id,messgers[0].name,messgers[0].messger);
            }
            else
            {
               AcademyFrameManager.Instance.showAcademyAnswerMasterFrame(messgers[0].id,messgers[0].name,messgers[0].messger);
            }
            messgers.shift();
         }
      }
      
      public function isFighting() : Boolean
      {
         if(StateManager.currentStateType != "fightLabGameView" && StateManager.currentStateType != "fighting" && StateManager.currentStateType != "hotSpringRoom" && StateManager.currentStateType != "churchRoom" && StateManager.currentStateType != "littleGame")
         {
            return false;
         }
         return true;
      }
      
      public function isRecommend() : Boolean
      {
         return AcademyManager.Instance.isShowRecommend && !SharedManager.Instance.isRecommend && PlayerManager.Instance.Self.Grade >= 8 && (PlayerManager.Instance.Self.apprenticeshipState == 0 || PlayerManager.Instance.Self.apprenticeshipState == 2);
      }
      
      public function isOpenSpace(info:BasePlayer) : Boolean
      {
         return info.Grade < 21 && info.Grade > 8;
      }
      
      public function get selfDescribe() : String
      {
         return _selfDescribe;
      }
      
      public function set selfDescribe(value:String) : void
      {
         _selfDescribe = value;
         dispatchEvent(new Event("selfDescribe"));
      }
   }
}
