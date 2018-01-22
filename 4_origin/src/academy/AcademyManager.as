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
      
      private function __apprenticeSystemAnswer(param1:PkgEvent) : void
      {
         var _loc7_:int = 0;
         var _loc14_:* = null;
         var _loc8_:* = null;
         var _loc15_:int = 0;
         var _loc9_:* = null;
         var _loc3_:* = null;
         var _loc10_:int = 0;
         var _loc16_:int = 0;
         var _loc12_:int = 0;
         var _loc11_:* = null;
         var _loc2_:int = 0;
         var _loc13_:* = null;
         var _loc5_:* = null;
         var _loc4_:Boolean = false;
         var _loc6_:int = param1.pkg.readByte();
         switch(int(_loc6_) - 4)
         {
            case 0:
               _loc7_ = param1.pkg.readInt();
               _loc14_ = param1.pkg.readUTF();
               _loc8_ = param1.pkg.readUTF();
               if(SharedManager.Instance.unAcceptAnswer.indexOf(_loc7_) < 0)
               {
                  AcademyFrameManager.Instance.showAcademyAnswerMasterFrame(_loc7_,_loc14_,_loc8_);
               }
               break;
            case 1:
               _loc15_ = param1.pkg.readInt();
               _loc9_ = param1.pkg.readUTF();
               _loc3_ = param1.pkg.readUTF();
               if(PlayerManager.Instance.Self.apprenticeshipState == 1)
               {
                  return;
               }
               if(SharedManager.Instance.unAcceptAnswer.indexOf(_loc15_) < 0)
               {
                  AcademyFrameManager.Instance.showAcademyAnswerApprenticeFrame(_loc15_,_loc9_,_loc3_);
               }
               break;
            case 2:
            case 3:
               _loc2_ = param1.pkg.readInt();
               _loc13_ = param1.pkg.readUTF();
               break;
            default:
               _loc2_ = param1.pkg.readInt();
               _loc13_ = param1.pkg.readUTF();
               break;
            default:
               _loc2_ = param1.pkg.readInt();
               _loc13_ = param1.pkg.readUTF();
               break;
            case 6:
               PlayerManager.Instance.Self.apprenticeshipState = param1.pkg.readInt();
               PlayerManager.Instance.Self.masterID = param1.pkg.readInt();
               PlayerManager.Instance.Self.setMasterOrApprentices(param1.pkg.readUTF());
               _loc10_ = param1.pkg.readInt();
               PlayerManager.Instance.Self.graduatesCount = param1.pkg.readInt();
               PlayerManager.Instance.Self.honourOfMaster = param1.pkg.readUTF();
               PlayerManager.Instance.Self.freezesDate = param1.pkg.readDate();
               if(_myAcademyPlayers && _loc10_ != -1)
               {
                  _myAcademyPlayers.remove(_loc10_);
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
               _loc16_ = param1.pkg.readInt();
               _loc12_ = param1.pkg.readInt();
               _loc11_ = param1.pkg.readUTF();
               if(_loc16_ == 0)
               {
                  AcademyFrameManager.Instance.showApprenticeGraduate();
               }
               else if(_loc16_ == 1)
               {
                  AcademyFrameManager.Instance.showMasterGraduate(_loc11_);
               }
               break;
            default:
               _loc16_ = param1.pkg.readInt();
               _loc12_ = param1.pkg.readInt();
               _loc11_ = param1.pkg.readUTF();
               if(_loc16_ == 0)
               {
                  AcademyFrameManager.Instance.showApprenticeGraduate();
               }
               else if(_loc16_ == 1)
               {
                  AcademyFrameManager.Instance.showMasterGraduate(_loc11_);
               }
               break;
            default:
               _loc16_ = param1.pkg.readInt();
               _loc12_ = param1.pkg.readInt();
               _loc11_ = param1.pkg.readUTF();
               if(_loc16_ == 0)
               {
                  AcademyFrameManager.Instance.showApprenticeGraduate();
               }
               else if(_loc16_ == 1)
               {
                  AcademyFrameManager.Instance.showMasterGraduate(_loc11_);
               }
               break;
            default:
               _loc16_ = param1.pkg.readInt();
               _loc12_ = param1.pkg.readInt();
               _loc11_ = param1.pkg.readUTF();
               if(_loc16_ == 0)
               {
                  AcademyFrameManager.Instance.showApprenticeGraduate();
               }
               else if(_loc16_ == 1)
               {
                  AcademyFrameManager.Instance.showMasterGraduate(_loc11_);
               }
               break;
            default:
               _loc16_ = param1.pkg.readInt();
               _loc12_ = param1.pkg.readInt();
               _loc11_ = param1.pkg.readUTF();
               if(_loc16_ == 0)
               {
                  AcademyFrameManager.Instance.showApprenticeGraduate();
               }
               else if(_loc16_ == 1)
               {
                  AcademyFrameManager.Instance.showMasterGraduate(_loc11_);
               }
               break;
            default:
               _loc16_ = param1.pkg.readInt();
               _loc12_ = param1.pkg.readInt();
               _loc11_ = param1.pkg.readUTF();
               if(_loc16_ == 0)
               {
                  AcademyFrameManager.Instance.showApprenticeGraduate();
               }
               else if(_loc16_ == 1)
               {
                  AcademyFrameManager.Instance.showMasterGraduate(_loc11_);
               }
               break;
            case 13:
               _loc5_ = param1.pkg.readUTF();
               _loc4_ = param1.pkg.readBoolean();
               academyAlert(_loc5_,_loc4_);
         }
      }
      
      private function academyAlert(param1:String, param2:Boolean) : void
      {
         var _loc3_:* = null;
         if(param2)
         {
            AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),param1,LanguageMgr.GetTranslation("ok"),"",false,false,false,2).addEventListener("response",__onCancel);
         }
         else if(!isFighting())
         {
            _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),param1,LanguageMgr.GetTranslation("ddt.manager.AcademyManager.alertSubmit"),"",false,false,false,2);
            _loc3_.addEventListener("response",__frameEvent);
         }
         else if(StateManager.currentStateType == "hotSpringRoom" || StateManager.currentStateType == "churchRoom")
         {
            AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),param1,LanguageMgr.GetTranslation("ok"),"",false,false,false,2).addEventListener("response",__onCancel);
         }
      }
      
      private function __onCancel(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",__frameEvent);
         (param1.currentTarget as BaseAlerFrame).dispose();
      }
      
      private function __frameEvent(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",__frameEvent);
         (param1.currentTarget as BaseAlerFrame).dispose();
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               StateManager.setState("academyRegistration");
         }
      }
      
      public function loadAcademyMemberList(param1:Function, param2:Boolean = true, param3:Boolean = false, param4:int = 1, param5:String = "", param6:int = 0, param7:Boolean = true, param8:Boolean = false) : void
      {
         var _loc10_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc10_["requestType"] = param2;
         _loc10_["appshipStateType"] = param3;
         _loc10_["page"] = param4;
         _loc10_["name"] = param5;
         _loc10_["Grade"] = param6;
         _loc10_["sex"] = param7;
         _loc10_["isReturnSelf"] = param8;
         var _loc9_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ApprenticeshipClubList.ashx"),6,_loc10_,"GET",null,true,true);
         _loc9_.loadErrorMessage = LanguageMgr.GetTranslation("civil.frame.CivilRegisterFrame.infoError");
         _loc9_.analyzer = new AcademyMemberListAnalyze(param1);
         LoadResourceManager.Instance.startLoad(_loc9_);
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
      
      private function __recommendPlayersComplete(param1:AcademyMemberListAnalyze) : void
      {
         _recommendPlayers = param1.academyMemberList;
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
         var _loc2_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc2_["RelationshipID"] = PlayerManager.Instance.Self.masterID;
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("UserApprenticeshipInfoList.ashx"),6,_loc2_);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.data.analyze.MyAcademyPlayersAnalyze");
         _loc1_.analyzer = new MyAcademyPlayersAnalyze(__myAcademyPlayersComplete);
         LoadResourceManager.Instance.startLoad(_loc1_);
      }
      
      private function __myAcademyPlayersComplete(param1:MyAcademyPlayersAnalyze) : void
      {
         _myAcademyPlayers = param1.myAcademyPlayers;
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
      
      public function compareState(param1:BasePlayer, param2:PlayerInfo) : Boolean
      {
         if(param2.Grade < 8)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.manager.AcademyManager.warning6"));
            return false;
         }
         if(param1.Grade < 8)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.manager.AcademyManager.warningII"));
            return false;
         }
         if(param2.apprenticeshipState == 1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.manager.AcademyManager.WarningApprenticeState"));
            return false;
         }
         if(param2.apprenticeshipState == 3)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.manager.AcademyManager.WarningMasterFullState"));
            return false;
         }
         if(param2.Grade >= 21)
         {
            if(param1.Grade >= 21)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.manager.AcademyManager.warningIII"));
               return false;
            }
            if(param2.Grade - param1.Grade >= 5)
            {
               return true;
            }
            if(param2.Grade - param1.Grade < 5)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.manager.AcademyManager.warning"));
               return false;
            }
         }
         else
         {
            if(param1.Grade < 21)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.manager.AcademyManager.warningIIII"));
               return false;
            }
            if(param1.Grade - param2.Grade >= 5)
            {
               return true;
            }
            if(param1.Grade - param2.Grade < 5)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.manager.AcademyManager.warningI"));
               return false;
            }
         }
         return false;
      }
      
      public function gotoAcademyState() : void
      {
         var _loc1_:* = null;
         if(StateManager.currentStateType == "matchRoom" || StateManager.currentStateType == "missionResult" || StateManager.currentStateType == "dungeonRoom" || StateManager.currentStateType == "freshmanRoom1" || StateManager.currentStateType == "freshmanRoom2")
         {
            _loc1_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.manager.AcademyManager.warning10"),LanguageMgr.GetTranslation("ok"),"",false,false,false,2);
            _loc1_.addEventListener("response",__onResponse);
         }
         else
         {
            StateManager.setState("academyRegistration");
         }
      }
      
      private function __onResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",__onResponse);
         (param1.currentTarget as BaseAlerFrame).dispose();
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               StateManager.setState("academyRegistration");
         }
      }
      
      public function getMasterHonorLevel(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < GRADUATE_NUM.length)
         {
            if(param1 >= GRADUATE_NUM[_loc3_])
            {
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function isFreezes(param1:Boolean) : Boolean
      {
         var _loc2_:Date = TimeManager.Instance.serverDate;
         if(PlayerManager.Instance.Self.freezesDate > _loc2_)
         {
            if(param1)
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
      
      public function set messgers(param1:Vector.<SimpleMessger>) : void
      {
         _messgers = param1;
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
      
      public function isOpenSpace(param1:BasePlayer) : Boolean
      {
         return param1.Grade < 21 && param1.Grade > 8;
      }
      
      public function get selfDescribe() : String
      {
         return _selfDescribe;
      }
      
      public function set selfDescribe(param1:String) : void
      {
         _selfDescribe = param1;
         dispatchEvent(new Event("selfDescribe"));
      }
   }
}
