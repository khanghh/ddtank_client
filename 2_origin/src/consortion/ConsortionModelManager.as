package consortion
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.analyze.ConsortiaAnalyze;
   import consortion.analyze.ConsortiaBossDataAnalyzer;
   import consortion.analyze.ConsortiaRichRankAnalyze;
   import consortion.analyze.ConsortiaTaskRankAnalyzer;
   import consortion.analyze.ConsortiaWeekRewardAnalyze;
   import consortion.analyze.ConsortionApplyListAnalyzer;
   import consortion.analyze.ConsortionBuildingUseConditionAnalyer;
   import consortion.analyze.ConsortionDutyListAnalyzer;
   import consortion.analyze.ConsortionEventListAnalyzer;
   import consortion.analyze.ConsortionInventListAnalyzer;
   import consortion.analyze.ConsortionLevelUpAnalyzer;
   import consortion.analyze.ConsortionListAnalyzer;
   import consortion.analyze.ConsortionMemberAnalyer;
   import consortion.analyze.ConsortionPollListAnalyzer;
   import consortion.analyze.ConsortionSkillInfoAnalyzer;
   import consortion.analyze.PersonalRankAnalyze;
   import consortion.data.BadgeInfo;
   import consortion.data.CallBackModel;
   import consortion.data.ConsortiaAssetLevelOffer;
   import consortion.data.ConsortionActiveTargetData;
   import consortion.event.ConsortionEvent;
   import consortion.view.selfConsortia.consortiaTask.ConsortiaTaskEvent;
   import consortion.view.selfConsortia.consortiaTask.ConsortiaTaskInfo;
   import consortion.view.selfConsortia.consortiaTask.ConsortiaTaskModel;
   import ddt.data.ConsortiaInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.ConsortiaPlayerInfo;
   import ddt.data.player.PlayerState;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.BadgeInfoManager;
   import ddt.manager.ChatManager;
   import ddt.manager.ExternalInterfaceManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.ServerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelperDataModuleLoad;
   import ddt.utils.RequestVairableCreater;
   import email.MailManager;
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.net.URLVariables;
   import flash.text.TextField;
   import hall.IHallStateView;
   import quest.TaskManager;
   import redPackage.RedPackageManager;
   import road7th.comm.PackageIn;
   import road7th.utils.DateUtils;
   import road7th.utils.StringHelper;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   import trainer.controller.SystemOpenPromptManager;
   import trainer.controller.WeakGuildManager;
   
   public class ConsortionModelManager extends EventDispatcher
   {
      
      public static const ALERT_RED_PACKAGE:String = "cmctrl_alert_redpackage";
      
      public static const ALERT_TAX:String = "cmctrl_alert_tax";
      
      public static const ALERT_MANAGER:String = "cmctrl_alert_manager";
      
      public static const RANK:String = "cmctrl_rank";
      
      public static const ALERT_SHOP:String = "cmctrl_alert_shop";
      
      public static const ALERT_BANK:String = "cmctrl_alert_bank";
      
      public static const HIDE_BANK:String = "cmctrl_hide_bank";
      
      public static const ALERT_TAKEIN:String = "cmctrl_alert_takein";
      
      public static const ALERT_QUIT:String = "cmctrl_alert_quit";
      
      public static const OPEN_BOSS:String = "cmctrl_open_boss";
      
      public static const CLEAR_REFERENCE:String = "cmctrl_clear_reference";
      
      public static const EVENT_CONSORTIA_BACK_INFO:String = "event_consortia_back_info";
      
      public static const EVENT_CONSORTIA_BACK_AWARD:String = "event_consortia_back_award";
      
      public static const EVENT_CONSORTIA_LEVEL_UP:String = "event_consortia_level_up";
      
      public static const LEAVE_CALL_BACK_VIEW:String = "leave_call_back_view";
      
      private static var _instance:ConsortionModelManager;
       
      
      private var _model:ConsortionModel;
      
      private var _taskModel:ConsortiaTaskModel;
      
      private var _timer:TimerJuggler;
      
      private var _alertFlagList:Array;
      
      private var _alertStatusList:Array;
      
      private var _alertMsgList:Array;
      
      private var _firstShow:Boolean = true;
      
      private var str:String;
      
      private var _invateID:int;
      
      private var _enterConfirm:BaseAlerFrame;
      
      private var _bossConfigDataList:Array;
      
      public var isShowBossOpenTip:Boolean = false;
      
      public var isBossOpen:Boolean = false;
      
      private var _enterBtn:SimpleBitmapButton;
      
      public var isClickConsortionBuyGiftTask:Boolean;
      
      public function ConsortionModelManager()
      {
         _alertFlagList = [30000,60000,120000,300000,600000,1200000,1800000,3600000];
         _alertStatusList = [false,false,false,false,false,false,false,false];
         _alertMsgList = ["consortia.task.remainSeconds","consortia.task.remainMinutes"];
         super();
         _model = new ConsortionModel();
         _taskModel = new ConsortiaTaskModel();
         addEvent();
      }
      
      public static function get Instance() : ConsortionModelManager
      {
         if(_instance == null)
         {
            _instance = new ConsortionModelManager();
         }
         return _instance;
      }
      
      public function get model() : ConsortionModel
      {
         return _model;
      }
      
      public function get TaskModel() : ConsortiaTaskModel
      {
         return _taskModel;
      }
      
      public function setup() : void
      {
         ConsortionModelManager.Instance.initConsortionActiveTarget();
         requestSortionActiveTargetSchedule();
      }
      
      private function addEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(129,0),__consortiaTryIn);
         SocketManager.Instance.addEventListener(PkgEvent.format(129,5),__tryInDel);
         SocketManager.Instance.addEventListener(PkgEvent.format(129,4),__consortiaTryInPass);
         SocketManager.Instance.addEventListener(PkgEvent.format(129,2),__consortiaDisband);
         SocketManager.Instance.addEventListener(PkgEvent.format(129,11),__consortiaInvate);
         SocketManager.Instance.addEventListener(PkgEvent.format(129,12),__consortiaInvitePass);
         SocketManager.Instance.addEventListener(PkgEvent.format(129,1),__consortiaCreate);
         SocketManager.Instance.addEventListener(PkgEvent.format(129,15),__consortiaPlacardUpdate);
         SocketManager.Instance.addEventListener(PkgEvent.format(129,24),__onConsortiaEquipControl);
         SocketManager.Instance.addEventListener(PkgEvent.format(129,6),__givceOffer);
         SocketManager.Instance.addEventListener(PkgEvent.format(128),__consortiaResponse);
         SocketManager.Instance.addEventListener(PkgEvent.format(129,3),__renegadeUser);
         SocketManager.Instance.addEventListener(PkgEvent.format(129,21),__onConsortiaLevelUp);
         SocketManager.Instance.addEventListener(PkgEvent.format(129,19),__oncharmanChange);
         SocketManager.Instance.addEventListener(PkgEvent.format(129,18),__consortiaUserUpGrade);
         SocketManager.Instance.addEventListener(PkgEvent.format(129,14),__consortiaDescriptionUpdate);
         SocketManager.Instance.addEventListener(PkgEvent.format(129,26),__skillChangehandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(43),__consortiaMailMessage);
         SocketManager.Instance.addEventListener(PkgEvent.format(129,28),__buyBadgeHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(129,31),bossOpenCloseHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(343,5),onConSortiaBackAward);
         SocketManager.Instance.addEventListener(PkgEvent.format(343,6),onConSortiaBackInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(412,1),onConSortionActiveTargetSchedule);
         SocketManager.Instance.addEventListener(PkgEvent.format(412,2),onConSortionActiveTargetStatus);
         _taskModel.addEventListener("getConsortiaTaskInfo",onTaskInfoChange);
      }
      
      protected function onTaskInfoChange(e:ConsortiaTaskEvent) : void
      {
         var __taskInfo:ConsortiaTaskInfo = _taskModel.taskInfo;
         if(__taskInfo != null && __taskInfo.beginTime != null)
         {
            if(_timer == null)
            {
               _timer = TimerManager.getInstance().addTimerJuggler(2000);
               _timer.addEventListener("timer",onTaskTimerTimer);
               _timer.start();
            }
         }
         else if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",onTaskTimerTimer);
            TimerManager.getInstance().removeJugglerByTimer(_timer);
            _timer = null;
            _alertStatusList = [false,false,false,false,false,false,false,false];
         }
      }
      
      protected function onTaskTimerTimer(e:Event) : void
      {
         var len:int = 0;
         var i:int = 0;
         var isFinished:Boolean = false;
         var bg:* = null;
         var remainTime:Number = NaN;
         var __MsgText:* = null;
         var __MsgNumber:int = 0;
         if(_taskModel.taskInfo && _taskModel.taskInfo.beginTime)
         {
            isFinished = true;
            len = _taskModel.taskInfo.itemList.length;
            for(i = 0; i < len; )
            {
               if(_taskModel.taskInfo.itemList[i].currenValue - _taskModel.taskInfo.itemList[i].targetValue < 0)
               {
                  isFinished = false;
                  break;
               }
               i++;
            }
            if(isFinished)
            {
               return;
            }
            bg = ConsortionModelManager.Instance.TaskModel.taskInfo.beginTime;
            remainTime = ConsortionModelManager.Instance.TaskModel.taskInfo.time * 60 - int(TimeManager.Instance.TotalSecondToNow(bg)) + 60;
            if(remainTime <= 0)
            {
               return;
            }
            remainTime = remainTime * 1000;
            len = _alertFlagList.length;
            for(i = 0; i < len; )
            {
               if(remainTime <= _alertFlagList[i])
               {
                  if(_alertStatusList[i] == false)
                  {
                     _alertStatusList[i] = true;
                     if(_firstShow)
                     {
                        _firstShow = false;
                        __MsgText = i > 1?_alertMsgList[1]:_alertMsgList[0];
                        __MsgNumber = i > 1?Math.round(remainTime / 60000):int(remainTime / 1000);
                        ChatManager.Instance.sysChatConsortia(LanguageMgr.GetTranslation(__MsgText,__MsgNumber));
                     }
                     else
                     {
                        __MsgText = i > 0?_alertMsgList[1]:_alertMsgList[0];
                        __MsgNumber = i > 0?Math.round(_alertFlagList[i] / 60000):30;
                        ChatManager.Instance.sysChatConsortia(LanguageMgr.GetTranslation(__MsgText,__MsgNumber));
                     }
                  }
                  break;
               }
               i++;
            }
         }
      }
      
      private function __consortiaResponse(event:PkgEvent) : void
      {
         var id:int = 0;
         var name:* = null;
         var memberInfo:* = null;
         var isInvent:Boolean = false;
         var inventID:int = 0;
         var inventName:* = null;
         var state:int = 0;
         var msgTxt1:* = null;
         var consortiaID:int = 0;
         var isKick:Boolean = false;
         var kickName:* = null;
         var msgTxt5:* = null;
         var unkwon1:int = 0;
         var unkwon2:* = null;
         var unkwon3:int = 0;
         var intviteName:* = null;
         var unkwon4:int = 0;
         var consortiaName:* = null;
         var context:* = null;
         var lastFocusObject:* = null;
         var myid:int = 0;
         var myname:* = null;
         var myLevel:int = 0;
         var subType:int = 0;
         var consortiaId:int = 0;
         var playerId:int = 0;
         var playerName:* = null;
         var dutyLeve:int = 0;
         var dName:* = null;
         var rights:int = 0;
         var handleID:int = 0;
         var handleName:* = null;
         var msgTxt6:* = null;
         var msgTxt7:* = null;
         var msgTxt9:* = null;
         var consortiaId9:int = 0;
         var playerId9:int = 0;
         var playerName9:* = null;
         var riches:int = 0;
         var msgTxt10:* = null;
         var t:int = 0;
         var pkg:PackageIn = event.pkg;
         var type:int = pkg.readByte();
         switch(int(type) - 1)
         {
            case 0:
               memberInfo = new ConsortiaPlayerInfo();
               memberInfo.privateID = pkg.readInt();
               isInvent = pkg.readBoolean();
               memberInfo.ConsortiaID = pkg.readInt();
               memberInfo.ConsortiaName = pkg.readUTF();
               memberInfo.ID = pkg.readInt();
               memberInfo.NickName = pkg.readUTF();
               inventID = pkg.readInt();
               inventName = pkg.readUTF();
               memberInfo.DutyID = pkg.readInt();
               memberInfo.DutyName = pkg.readUTF();
               memberInfo.Offer = pkg.readInt();
               memberInfo.RichesOffer = pkg.readInt();
               memberInfo.RichesRob = pkg.readInt();
               memberInfo.LastDate = pkg.readDateString();
               memberInfo.Grade = pkg.readInt();
               memberInfo.DutyLevel = pkg.readInt();
               state = pkg.readInt();
               memberInfo.playerState = new PlayerState(state);
               memberInfo.Sex = pkg.readBoolean();
               memberInfo.Right = pkg.readInt();
               memberInfo.WinCount = pkg.readInt();
               memberInfo.TotalCount = pkg.readInt();
               memberInfo.EscapeCount = pkg.readInt();
               memberInfo.Repute = pkg.readInt();
               memberInfo.LoginName = pkg.readUTF();
               memberInfo.FightPower = pkg.readInt();
               memberInfo.AchievementPoint = pkg.readInt();
               memberInfo.honor = pkg.readUTF();
               memberInfo.UseOffer = pkg.readInt();
               if(!(isInvent && memberInfo.ID == PlayerManager.Instance.Self.ID))
               {
                  if(memberInfo.ID == PlayerManager.Instance.Self.ID)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.PlayerManager.one",memberInfo.ConsortiaName));
                  }
               }
               msgTxt1 = "";
               if(memberInfo.ID == PlayerManager.Instance.Self.ID)
               {
                  setPlayerConsortia(memberInfo.ConsortiaID,memberInfo.ConsortiaName);
                  getConsortionMember(memberListComplete);
                  getConsortionList(selfConsortionComplete,1,6,memberInfo.ConsortiaName,-1,-1,-1,memberInfo.ConsortiaID);
                  if(isInvent)
                  {
                     msgTxt1 = LanguageMgr.GetTranslation("tank.manager.PlayerManager.isInvent.msg",memberInfo.ConsortiaName);
                  }
                  else
                  {
                     msgTxt1 = LanguageMgr.GetTranslation("tank.manager.PlayerManager.pass",memberInfo.ConsortiaName);
                  }
                  if(StateManager.currentStateType == "consortia")
                  {
                     dispatchEvent(new ConsortionEvent("consortionStateChange"));
                  }
                  TaskManager.instance.requestClubTask();
                  if(PathManager.solveExternalInterfaceEnabel())
                  {
                     ExternalInterfaceManager.sendToAgent(5,PlayerManager.Instance.Self.ID,PlayerManager.Instance.Self.NickName,ServerManager.Instance.zoneName,-1,memberInfo.ConsortiaName);
                  }
               }
               else
               {
                  _model.addMember(memberInfo);
                  msgTxt1 = LanguageMgr.GetTranslation("tank.manager.PlayerManager.player",memberInfo.NickName);
               }
               msgTxt1 = StringHelper.rePlaceHtmlTextField(msgTxt1);
               ChatManager.Instance.sysChatYellow(msgTxt1);
               if(memberInfo.ConsortiaID == 0)
               {
                  ConsortionModelManager.Instance.TaskModel.taskInfo = null;
               }
               break;
            case 1:
               id = pkg.readInt();
               PlayerManager.Instance.Self.consortiaInfo.Level = 0;
               setPlayerConsortia();
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.PlayerManager.your"));
               getConsortionMember();
               ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("tank.manager.PlayerManager.disband"));
               if(StateManager.currentStateType == "consortia")
               {
                  StateManager.back();
               }
               ConsortionModelManager.Instance.TaskModel.taskInfo = null;
               break;
            case 2:
               id = pkg.readInt();
               consortiaID = pkg.readInt();
               isKick = pkg.readBoolean();
               name = pkg.readUTF();
               kickName = pkg.readUTF();
               if(PlayerManager.Instance.Self.ID == id)
               {
                  setPlayerConsortia();
                  getConsortionMember();
                  TaskManager.instance.onGuildUpdate();
                  msgTxt5 = "";
                  if(isKick)
                  {
                     this.dispatchEvent(new ConsortionEvent("kick_consortion"));
                     msgTxt5 = LanguageMgr.GetTranslation("tank.manager.PlayerManager.delect",kickName);
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.PlayerManager.hit"));
                  }
                  else
                  {
                     msgTxt5 = LanguageMgr.GetTranslation("tank.manager.PlayerManager.leave");
                  }
                  if(StateManager.currentStateType == "consortia")
                  {
                     StateManager.back();
                  }
                  else if(StateManager.currentStateType == "consortiaGuard")
                  {
                     StateManager.setState("main");
                  }
                  PlayerManager.Instance.Self.consortiaInfo.StoreLevel = 0;
                  msgTxt5 = StringHelper.rePlaceHtmlTextField(msgTxt5);
                  ChatManager.Instance.sysChatRed(msgTxt5);
               }
               else
               {
                  removeConsortiaMember(id,isKick,kickName);
               }
               if(name == PlayerManager.Instance.Self.NickName)
               {
                  ConsortionModelManager.Instance.TaskModel.taskInfo = null;
               }
               break;
            case 3:
               _invateID = pkg.readInt();
               unkwon1 = pkg.readInt();
               unkwon2 = pkg.readUTF();
               unkwon3 = pkg.readInt();
               intviteName = pkg.readUTF();
               unkwon4 = pkg.readInt();
               consortiaName = pkg.readUTF();
               if(SharedManager.Instance.showCI)
               {
                  if(str != intviteName)
                  {
                     SoundManager.instance.play("018");
                     context = intviteName + LanguageMgr.GetTranslation("tank.manager.PlayerManager.come",consortiaName);
                     context = StringHelper.rePlaceHtmlTextField(context);
                     lastFocusObject = StageReferance.stage.focus;
                     if(_enterConfirm)
                     {
                        _enterConfirm.removeEventListener("response",__enterConsortiaConfirm);
                        ObjectUtils.disposeObject(_enterConfirm);
                        _enterConfirm = null;
                     }
                     _enterConfirm = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.manager.PlayerManager.request"),context,LanguageMgr.GetTranslation("tank.manager.PlayerManager.sure"),LanguageMgr.GetTranslation("tank.manager.PlayerManager.refuse"),false,true,true,2,"alertInFight");
                     _enterConfirm.addEventListener("response",__enterConsortiaConfirm);
                     str = intviteName;
                     if(lastFocusObject is TextField)
                     {
                        if(TextField(lastFocusObject).type == "input")
                        {
                           StageReferance.stage.focus = lastFocusObject;
                        }
                     }
                  }
               }
               break;
            case 4:
               break;
            case 5:
               myid = pkg.readInt();
               myname = pkg.readUTF();
               myLevel = pkg.readInt();
               if(PlayerManager.Instance.Self.ConsortiaID == myid)
               {
                  PlayerManager.Instance.Self.consortiaInfo.Level = myLevel;
                  ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("tank.manager.PlayerManager.upgrade",myLevel,_model.getLevelData(myLevel).Count));
                  TaskManager.instance.requestClubTask();
                  SoundManager.instance.play("1001");
                  getConsortionList(selfConsortionComplete,1,6,PlayerManager.Instance.Self.ConsortiaName,-1,-1,-1,PlayerManager.Instance.Self.ConsortiaID);
                  TaskManager.instance.onGuildUpdate();
               }
               break;
            case 6:
               break;
            case 7:
               subType = pkg.readByte();
               consortiaId = pkg.readInt();
               playerId = pkg.readInt();
               playerName = pkg.readUTF();
               dutyLeve = pkg.readInt();
               dName = pkg.readUTF();
               rights = pkg.readInt();
               handleID = pkg.readInt();
               handleName = pkg.readUTF();
               if(subType != 1)
               {
                  if(subType == 2)
                  {
                     updateDutyInfo(dutyLeve,dName,rights);
                  }
                  else if(subType == 3)
                  {
                     upDateSelfDutyInfo(dutyLeve,dName,rights);
                  }
                  else if(subType == 4)
                  {
                     upDateSelfDutyInfo(dutyLeve,dName,rights);
                  }
                  else if(subType == 5)
                  {
                     upDateSelfDutyInfo(dutyLeve,dName,rights);
                  }
                  else if(subType == 6)
                  {
                     updateConsortiaMemberDuty(playerId,dutyLeve,dName,rights);
                     msgTxt6 = "";
                     if(playerId == PlayerManager.Instance.Self.ID)
                     {
                        msgTxt6 = LanguageMgr.GetTranslation("tank.manager.PlayerManager.youUpgrade",handleName,dName);
                     }
                     else if(playerId == handleID)
                     {
                        msgTxt6 = LanguageMgr.GetTranslation("tank.manager.PlayerManager.upgradeSelf",playerName,dName);
                     }
                     else
                     {
                        msgTxt6 = LanguageMgr.GetTranslation("tank.manager.PlayerManager.upgradeOther",handleName,playerName,dName);
                     }
                     msgTxt6 = StringHelper.rePlaceHtmlTextField(msgTxt6);
                     ChatManager.Instance.sysChatYellow(msgTxt6);
                  }
                  else if(subType == 7)
                  {
                     updateConsortiaMemberDuty(playerId,dutyLeve,dName,rights);
                     msgTxt7 = "";
                     if(playerId == PlayerManager.Instance.Self.ID)
                     {
                        msgTxt7 = LanguageMgr.GetTranslation("tank.manager.PlayerManager.youDemotion",handleName,dName);
                     }
                     else if(playerId == handleID)
                     {
                        msgTxt7 = LanguageMgr.GetTranslation("tank.manager.PlayerManager.demotionSelf",playerName,dName);
                     }
                     else
                     {
                        msgTxt7 = LanguageMgr.GetTranslation("tank.manager.PlayerManager.demotionOther",handleName,playerName,dName);
                     }
                     msgTxt7 = StringHelper.rePlaceHtmlTextField(msgTxt7);
                     ChatManager.Instance.sysChatYellow(msgTxt7);
                  }
                  else if(subType == 8)
                  {
                     updateConsortiaMemberDuty(playerId,dutyLeve,dName,rights);
                     SoundManager.instance.play("1001");
                  }
                  else if(subType == 9)
                  {
                     updateConsortiaMemberDuty(playerId,dutyLeve,dName,rights);
                     PlayerManager.Instance.Self.consortiaInfo.ChairmanName = playerName;
                     msgTxt9 = "<" + playerName + ">" + LanguageMgr.GetTranslation("tank.manager.PlayerManager.up") + dName;
                     msgTxt9 = StringHelper.rePlaceHtmlTextField(msgTxt9);
                     ChatManager.Instance.sysChatYellow(msgTxt9);
                     SoundManager.instance.play("1001");
                  }
               }
               break;
            case 8:
               consortiaId9 = pkg.readInt();
               playerId9 = pkg.readInt();
               playerName9 = pkg.readUTF();
               riches = pkg.readInt();
               if(consortiaId9 != PlayerManager.Instance.Self.ConsortiaID)
               {
                  return;
               }
               msgTxt10 = "";
               if(PlayerManager.Instance.Self.ID == playerId9)
               {
                  msgTxt10 = LanguageMgr.GetTranslation("tank.manager.PlayerManager.contributionSelf",riches);
               }
               else
               {
                  msgTxt10 = LanguageMgr.GetTranslation("tank.manager.PlayerManager.contributionOther",playerName9,riches);
               }
               ChatManager.Instance.sysChatYellow(msgTxt10);
               break;
            case 9:
               consortiaUpLevel(10,pkg.readInt(),pkg.readUTF(),pkg.readInt());
               break;
            case 10:
               consortiaUpLevel(11,pkg.readInt(),pkg.readUTF(),pkg.readInt());
               break;
            case 11:
               consortiaUpLevel(12,pkg.readInt(),pkg.readUTF(),pkg.readInt());
               break;
            case 12:
               consortiaUpLevel(13,pkg.readInt(),pkg.readUTF(),pkg.readInt());
               break;
            case 13:
               t = pkg.readInt();
               switch(int(t) - 1)
               {
                  case 0:
                     PlayerManager.Instance.Self.consortiaInfo.IsVoting = true;
                     break;
                  case 1:
                     PlayerManager.Instance.Self.consortiaInfo.IsVoting = false;
                     break;
                  case 2:
                     PlayerManager.Instance.Self.consortiaInfo.IsVoting = false;
               }
               break;
            case 14:
               pkg.readInt();
               ChatManager.Instance.sysChatYellow(pkg.readUTF());
               break;
            case 15:
               getConsortionList(selfConsortionComplete,1,6,PlayerManager.Instance.Self.ConsortiaName,-1,-1,-1,PlayerManager.Instance.Self.ConsortiaID);
         }
      }
      
      private function consortiaUpLevel(type:int, id:int, name:String, level:int) : void
      {
         if(id != PlayerManager.Instance.Self.ConsortiaID)
         {
            return;
         }
         SoundManager.instance.play("1001");
         var tipText:String = "";
         if(type == 10)
         {
            if(PlayerManager.Instance.Self.DutyLevel == 1)
            {
               tipText = LanguageMgr.GetTranslation("tank.manager.PlayerManager.consortiaShop",level);
            }
            else
            {
               tipText = LanguageMgr.GetTranslation("tank.manager.PlayerManager.consortiaShop2",level);
            }
            PlayerManager.Instance.Self.consortiaInfo.ShopLevel = level;
         }
         else if(type == 11)
         {
            if(PlayerManager.Instance.Self.DutyLevel == 1)
            {
               tipText = LanguageMgr.GetTranslation("tank.manager.PlayerManager.consortiaStore",level);
            }
            else
            {
               tipText = LanguageMgr.GetTranslation("tank.manager.PlayerManager.consortiaStore2",level);
            }
            PlayerManager.Instance.Self.consortiaInfo.SmithLevel = level;
         }
         else if(type == 12)
         {
            if(PlayerManager.Instance.Self.DutyLevel == 1)
            {
               tipText = LanguageMgr.GetTranslation("tank.manager.PlayerManager.consortiaSmith",level);
            }
            else
            {
               tipText = LanguageMgr.GetTranslation("tank.manager.PlayerManager.consortiaSmith2",level);
            }
            PlayerManager.Instance.Self.consortiaInfo.StoreLevel = level;
         }
         else if(type == 13)
         {
            if(PlayerManager.Instance.Self.DutyLevel == 1)
            {
               tipText = LanguageMgr.GetTranslation("tank.manager.PlayerManager.consortiaSkill",level);
            }
            else
            {
               tipText = LanguageMgr.GetTranslation("tank.manager.PlayerManager.consortiaSkill2",level);
            }
            PlayerManager.Instance.Self.consortiaInfo.BufferLevel = level;
         }
         ChatManager.Instance.sysChatYellow(tipText);
         getConsortionList(selfConsortionComplete,1,6,PlayerManager.Instance.Self.ConsortiaName,-1,-1,-1,PlayerManager.Instance.Self.ConsortiaID);
         TaskManager.instance.onGuildUpdate();
      }
      
      private function updateDutyInfo(dutyLevel:int, dutyName:String, right:int) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = _model.memberList;
         for each(var i in _model.memberList)
         {
            if(i.DutyLevel == dutyLevel)
            {
               i.DutyLevel == dutyLevel;
               i.DutyName = dutyName;
               i.Right = right;
               _model.updataMember(i);
            }
         }
      }
      
      private function upDateSelfDutyInfo(dutyLevel:int, dutyName:String, right:int) : void
      {
         var _loc7_:int = 0;
         var _loc6_:* = _model.memberList;
         for each(var i in _model.memberList)
         {
            if(i.ID == PlayerManager.Instance.Self.ID)
            {
               PlayerManager.Instance.Self.beginChanges();
               var _loc5_:* = dutyLevel;
               PlayerManager.Instance.Self.DutyLevel = _loc5_;
               i.DutyLevel = _loc5_;
               _loc5_ = dutyName;
               PlayerManager.Instance.Self.DutyName = _loc5_;
               i.DutyName = _loc5_;
               _loc5_ = right;
               PlayerManager.Instance.Self.Right = _loc5_;
               i.Right = _loc5_;
               PlayerManager.Instance.Self.commitChanges();
               _model.updataMember(i);
            }
         }
      }
      
      private function updateConsortiaMemberDuty(playerId:int, dutyLevel:int, dutyName:String, right:int) : void
      {
         var _loc7_:int = 0;
         var _loc6_:* = _model.memberList;
         for each(var i in _model.memberList)
         {
            if(i.ID == playerId)
            {
               i.beginChanges();
               i.DutyLevel = dutyLevel;
               i.DutyName = dutyName;
               i.Right = right;
               if(i.ID == PlayerManager.Instance.Self.ID)
               {
                  PlayerManager.Instance.Self.beginChanges();
                  PlayerManager.Instance.Self.DutyLevel = dutyLevel;
                  PlayerManager.Instance.Self.DutyName = dutyName;
                  PlayerManager.Instance.Self.Right = right;
                  PlayerManager.Instance.Self.consortiaInfo.Level = PlayerManager.Instance.Self.consortiaInfo.Level == 0?1:PlayerManager.Instance.Self.consortiaInfo.Level;
                  PlayerManager.Instance.Self.commitChanges();
                  getConsortionList(selfConsortionComplete,1,6,PlayerManager.Instance.Self.consortiaInfo.ConsortiaName,-1,-1,-1,PlayerManager.Instance.Self.consortiaInfo.ConsortiaID);
               }
               i.commitChanges();
               _model.updataMember(i);
            }
         }
      }
      
      private function removeConsortiaMember(id:int, isKick:Boolean, kickName:String) : void
      {
         var msgTxt:* = null;
         var _loc7_:int = 0;
         var _loc6_:* = _model.memberList;
         for each(var i in _model.memberList)
         {
            if(i.ID == id)
            {
               msgTxt = "";
               if(isKick)
               {
                  msgTxt = LanguageMgr.GetTranslation("tank.manager.PlayerManager.consortia",kickName,i.NickName);
               }
               else
               {
                  msgTxt = LanguageMgr.GetTranslation("tank.manager.PlayerManager.leaveconsortia",i.NickName);
               }
               msgTxt = StringHelper.rePlaceHtmlTextField(msgTxt);
               ChatManager.Instance.sysChatYellow(msgTxt);
               _model.removeMember(i);
            }
         }
      }
      
      private function __enterConsortiaConfirm(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var frame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__enterConsortiaConfirm);
         if(frame)
         {
            ObjectUtils.disposeObject(frame);
            frame = null;
         }
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            accpetConsortiaInvent();
         }
         if(evt.responseCode == 0 || evt.responseCode == 4)
         {
            rejectConsortiaInvent();
         }
      }
      
      private function accpetConsortiaInvent() : void
      {
         SocketManager.Instance.out.sendConsortiaInvatePass(_invateID);
         str = "";
      }
      
      private function rejectConsortiaInvent() : void
      {
         SocketManager.Instance.out.sendConsortiaInvateDelete(_invateID);
         str = "";
      }
      
      private function __givceOffer(e:PkgEvent) : void
      {
         var num:int = e.pkg.readInt();
         var isSuccess:Boolean = e.pkg.readBoolean();
         var msg:String = e.pkg.readUTF();
         MessageTipManager.getInstance().show(msg);
         if(isSuccess)
         {
            PlayerManager.Instance.Self.consortiaInfo.Riches = PlayerManager.Instance.Self.consortiaInfo.Riches + Math.floor(Number(num / 2));
            _model.getConsortiaMemberInfo(PlayerManager.Instance.Self.ID).RichesOffer = _model.getConsortiaMemberInfo(PlayerManager.Instance.Self.ID).RichesOffer + Math.floor(Number(num / 2));
            TaskManager.instance.onGuildUpdate();
         }
      }
      
      private function __onConsortiaEquipControl(evt:PkgEvent) : void
      {
         var list:* = undefined;
         var i:int = 0;
         var isSuccess:Boolean = evt.pkg.readBoolean();
         if(isSuccess)
         {
            list = new Vector.<ConsortiaAssetLevelOffer>();
            for(i = 0; i < 7; )
            {
               list[i] = new ConsortiaAssetLevelOffer();
               if(i < 5)
               {
                  list[i].Type = 1;
                  list[i].Level = i + 1;
               }
               else if(i == 5)
               {
                  list[i].Type = 2;
               }
               else
               {
                  list[i].Type = 3;
               }
               i++;
            }
            list[0].Riches = evt.pkg.readInt();
            list[1].Riches = evt.pkg.readInt();
            list[2].Riches = evt.pkg.readInt();
            list[3].Riches = evt.pkg.readInt();
            list[4].Riches = evt.pkg.readInt();
            list[5].Riches = evt.pkg.readInt();
            list[6].Riches = evt.pkg.readInt();
            if(PlayerManager.Instance.Self.ID == PlayerManager.Instance.Self.consortiaInfo.ChairmanID)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.onConsortiaEquipControl.executeSuccess"));
            }
            _model.useConditionList = list;
         }
         else if(PlayerManager.Instance.Self.ID == PlayerManager.Instance.Self.consortiaInfo.ChairmanID)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.onConsortiaEquipControl.executeFail"));
         }
      }
      
      private function __consortiaTryIn(evt:PkgEvent) : void
      {
         var id:int = evt.pkg.readInt();
         var isScuess:Boolean = evt.pkg.readBoolean();
         var msg:String = evt.pkg.readUTF();
         MessageTipManager.getInstance().show(msg);
         if(isScuess)
         {
            getApplyRecordList(applyListComplete,PlayerManager.Instance.Self.ID);
         }
      }
      
      private function __tryInDel(evt:PkgEvent) : void
      {
         var id:int = evt.pkg.readInt();
         var isScuss:Boolean = evt.pkg.readBoolean();
         var msg:String = evt.pkg.readUTF();
         MessageTipManager.getInstance().show(msg);
         if(isScuss)
         {
            _model.deleteOneApplyRecord(id);
         }
      }
      
      private function __consortiaTryInPass(e:PkgEvent) : void
      {
         var id:int = e.pkg.readInt();
         var isSuccess:Boolean = e.pkg.readBoolean();
         var msg:String = e.pkg.readUTF();
         MessageTipManager.getInstance().show(msg);
         if(isSuccess)
         {
            _model.deleteOneApplyRecord(id);
         }
      }
      
      private function __consortiaInvate(evt:PkgEvent) : void
      {
         var name:String = evt.pkg.readUTF();
         var isSuccess:Boolean = evt.pkg.readBoolean();
         var msg:String = evt.pkg.readUTF();
         MessageTipManager.getInstance().show(msg);
      }
      
      private function __consortiaInvitePass(evt:PkgEvent) : void
      {
         var unkwon:int = evt.pkg.readInt();
         var success:Boolean = evt.pkg.readBoolean();
         var id:int = evt.pkg.readInt();
         var name:String = evt.pkg.readUTF();
         MessageTipManager.getInstance().show(evt.pkg.readUTF());
         if(success)
         {
            setPlayerConsortia(id,name);
            getConsortionMember(memberListComplete);
            getConsortionList(selfConsortionComplete,1,6,name,-1,-1,-1,id);
         }
      }
      
      private function __consortiaCreate(evt:PkgEvent) : void
      {
         var n:String = evt.pkg.readUTF();
         var isSucuess:Boolean = evt.pkg.readBoolean();
         var id:int = evt.pkg.readInt();
         var cName:String = evt.pkg.readUTF();
         var msg:String = evt.pkg.readUTF();
         MessageTipManager.getInstance().show(msg);
         var level:int = evt.pkg.readInt();
         var dutyName:String = evt.pkg.readUTF();
         var right:int = evt.pkg.readInt();
         if(isSucuess)
         {
            setPlayerConsortia(id,n);
            getConsortionMember(memberListComplete);
            getConsortionList(selfConsortionComplete,1,6,n,-1,-1,-1,id);
            dispatchEvent(new ConsortionEvent("consortionStateChange"));
            TaskManager.instance.requestClubTask();
            if(PathManager.solveExternalInterfaceEnabel())
            {
               ExternalInterfaceManager.sendToAgent(4,PlayerManager.Instance.Self.ID,PlayerManager.Instance.Self.NickName,ServerManager.Instance.zoneName,-1,cName);
            }
         }
      }
      
      private function __consortiaDisband(evt:PkgEvent) : void
      {
         var id:int = 0;
         var msgii:* = null;
         if(evt.pkg.readBoolean())
         {
            if(evt.pkg.readInt() == PlayerManager.Instance.Self.ID)
            {
               setPlayerConsortia();
               if(StateManager.currentStateType == "consortia")
               {
                  StateManager.back();
               }
               ChatManager.Instance.sysChatRed(LanguageMgr.GetTranslation("tank.manager.PlayerManager.msg"));
               MessageTipManager.getInstance().show(evt.pkg.readUTF());
            }
         }
         else
         {
            id = evt.pkg.readInt();
            msgii = evt.pkg.readUTF();
            MessageTipManager.getInstance().show(msgii);
         }
      }
      
      private function __consortiaPlacardUpdate(evt:PkgEvent) : void
      {
         PlayerManager.Instance.Self.consortiaInfo.Placard = evt.pkg.readUTF();
         var isSuccess:Boolean = evt.pkg.readBoolean();
         var msg:String = evt.pkg.readUTF();
         MessageTipManager.getInstance().show(msg);
      }
      
      private function __renegadeUser(e:PkgEvent) : void
      {
         var id:int = e.pkg.readInt();
         var isSuccess:Boolean = e.pkg.readBoolean();
         var msg:String = e.pkg.readUTF();
         MessageTipManager.getInstance().show(msg);
         PlayerManager.Instance.Self.consortiaInfo.StoreLevel = 0;
      }
      
      private function __onConsortiaLevelUp(e:PkgEvent) : void
      {
         var type:int = e.pkg.readByte();
         var level:int = e.pkg.readByte();
         var isSuccess:Boolean = e.pkg.readBoolean();
         var msg:String = e.pkg.readUTF();
         MessageTipManager.getInstance().show(msg);
         if(isSuccess)
         {
            switch(int(type) - 1)
            {
               case 0:
                  PlayerManager.Instance.Self.consortiaInfo.Level = level;
                  break;
               case 1:
                  PlayerManager.Instance.Self.consortiaInfo.StoreLevel = level;
                  break;
               case 2:
                  PlayerManager.Instance.Self.consortiaInfo.ShopLevel = level;
                  break;
               case 3:
                  PlayerManager.Instance.Self.consortiaInfo.SmithLevel = level;
                  break;
               case 4:
                  PlayerManager.Instance.Self.consortiaInfo.BufferLevel = level;
            }
            dispatchEvent(new Event("event_consortia_level_up"));
         }
      }
      
      private function __oncharmanChange(e:PkgEvent) : void
      {
         var nick:String = e.pkg.readUTF();
         var isSuccess:Boolean = e.pkg.readBoolean();
         var msg:String = e.pkg.readUTF();
         MessageTipManager.getInstance().show(msg);
      }
      
      private function __consortiaUserUpGrade(e:PkgEvent) : void
      {
         var id:int = e.pkg.readInt();
         var isUpGrade:Boolean = e.pkg.readBoolean();
         var isSuccess:Boolean = e.pkg.readBoolean();
         var msg:String = e.pkg.readUTF();
         if(isUpGrade)
         {
            if(isSuccess)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.PlayerManager.upsuccess"));
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.PlayerManager.upfalse"));
            }
         }
         else if(isSuccess)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.PlayerManager.downsuccess"));
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.PlayerManager.downfalse"));
         }
      }
      
      private function __consortiaDescriptionUpdate(evt:PkgEvent) : void
      {
         var description:String = evt.pkg.readUTF();
         var isSuccess:Boolean = evt.pkg.readBoolean();
         var msg:String = evt.pkg.readUTF();
         MessageTipManager.getInstance().show(msg);
         if(isSuccess)
         {
            PlayerManager.Instance.Self.consortiaInfo.Description = description;
         }
      }
      
      private function __skillChangehandler(evt:PkgEvent) : void
      {
         var i:int = 0;
         var id:int = 0;
         var b:Boolean = false;
         var beginDate:* = null;
         var validDay:int = 0;
         var len:int = evt.pkg.readInt();
         for(i = 0; i < len; )
         {
            id = evt.pkg.readInt();
            b = evt.pkg.readBoolean();
            beginDate = evt.pkg.readDate();
            validDay = evt.pkg.readInt();
            _model.updateSkillInfo(id,b,beginDate,validDay);
            i++;
         }
         if(len > 0)
         {
            getConsortionList(selfConsortionComplete,1,6,PlayerManager.Instance.Self.ConsortiaName,-1,-1,-1,PlayerManager.Instance.Self.ConsortiaID);
         }
         dispatchEvent(new ConsortionEvent("skillStateChange"));
      }
      
      private function __consortiaMailMessage(evt:PkgEvent) : void
      {
         var str:String = evt.pkg.readUTF();
         var quitConsortiaConfirm:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),str,LanguageMgr.GetTranslation("ok"),"",false,true,true,1);
         quitConsortiaConfirm.moveEnable = false;
         quitConsortiaConfirm.addEventListener("response",__quitConsortiaResponse);
         PlayerManager.Instance.Self.consortiaInfo.StoreLevel = 0;
      }
      
      private function __quitConsortiaResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var frame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__quitConsortiaResponse);
         frame.dispose();
         frame = null;
      }
      
      private function setPlayerConsortia(id:uint = 0, name:String = "") : void
      {
         PlayerManager.Instance.Self.ConsortiaName = name;
         PlayerManager.Instance.Self.ConsortiaID = id;
         if(id == 0)
         {
            PlayerManager.Instance.Self.consortiaInfo.Level = 0;
         }
      }
      
      public function memberListComplete(analyzer:ConsortionMemberAnalyer) : void
      {
         _model.memberList = analyzer.consortionMember;
         TaskManager.instance.onGuildUpdate();
      }
      
      public function clubSearchConsortions(anlyzer:ConsortionListAnalyzer) : void
      {
         _model.consortionList = anlyzer.consortionList;
         _model.consortionsListTotalCount = Math.ceil(anlyzer.consortionsTotalCount / 6);
      }
      
      public function selfConsortionComplete(anlyzer:ConsortionListAnalyzer) : void
      {
         if(anlyzer.consortionList.length > 0)
         {
            PlayerManager.Instance.Self.consortiaInfo = anlyzer.consortionList[0] as ConsortiaInfo;
         }
      }
      
      public function applyListComplete(anlyzer:ConsortionApplyListAnalyzer) : void
      {
         _model.myApplyList = anlyzer.applyList;
         _model.applyListTotalCount = anlyzer.totalCount;
      }
      
      public function InventListComplete(anlyzer:ConsortionInventListAnalyzer) : void
      {
         _model.inventList = anlyzer.inventList;
         _model.inventListTotalCount = anlyzer.totalCount;
      }
      
      private function levelUpInfoComplete(anlyzer:ConsortionLevelUpAnalyzer) : void
      {
         _model.levelUpData = anlyzer.levelUpData;
      }
      
      public function eventListComplete(anlyzer:ConsortionEventListAnalyzer) : void
      {
         _model.eventList = anlyzer.eventList;
      }
      
      public function useConditionListComplete(anlyzer:ConsortionBuildingUseConditionAnalyer) : void
      {
         _model.useConditionList = anlyzer.useConditionList;
      }
      
      public function dutyListComplete(anlyzer:ConsortionDutyListAnalyzer) : void
      {
         _model.dutyList = anlyzer.dutyList;
      }
      
      public function pollListComplete(anlyzer:ConsortionPollListAnalyzer) : void
      {
         _model.pollList = anlyzer.pollList;
      }
      
      public function skillInfoListComplete(anlyzer:ConsortionSkillInfoAnalyzer) : void
      {
         _model.skillInfoList = anlyzer.skillInfoList;
      }
      
      public function analyzeRichRank(e:ConsortiaRichRankAnalyze) : void
      {
         _model.richRankList = e.dataList;
      }
      
      public function analyzeWeekReward(e:ConsortiaWeekRewardAnalyze) : void
      {
         _model.weekReward = e.dataList;
      }
      
      public function getConsortionList(callBackFun:Function, page:int = 1, size:int = 6, name:String = "", order:int = -1, openApply:int = -1, level:int = -1, ConsortiaID:int = -1) : void
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["page"] = page;
         args["size"] = size;
         args["name"] = name;
         args["level"] = level;
         args["ConsortiaID"] = ConsortiaID;
         args["order"] = order;
         args["openApply"] = openApply;
         var loadConsortias:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaList.ashx"),7,args);
         loadConsortias.loadErrorMessage = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.LoadMyconsortiaListError");
         loadConsortias.analyzer = new ConsortionListAnalyzer(callBackFun);
         LoadResourceManager.Instance.startLoad(loadConsortias);
      }
      
      public function getApplyRecordList(callBackFun:Function, playerID:int = -1, consortiaID:int = -1) : void
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["page"] = 1;
         args["size"] = 1000;
         args["order"] = -1;
         args["consortiaID"] = consortiaID;
         args["applyID"] = -1;
         args["userID"] = playerID;
         args["userLevel"] = -1;
         var loadConsortiaApplyUsersList:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaApplyUsersList.ashx"),6,args);
         loadConsortiaApplyUsersList.loadErrorMessage = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.LoadApplyRecordError");
         loadConsortiaApplyUsersList.analyzer = new ConsortionApplyListAnalyzer(callBackFun);
         LoadResourceManager.Instance.startLoad(loadConsortiaApplyUsersList);
      }
      
      public function getInviteRecordList(callBackFun:Function) : void
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["page"] = 1;
         args["size"] = 1000;
         args["order"] = -1;
         args["userID"] = PlayerManager.Instance.Self.ID;
         args["inviteID"] = -1;
         var loadConsortiaInventList:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaInviteUsersList.ashx"),6,args);
         loadConsortiaInventList.loadErrorMessage = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.LoadApplyRecordError");
         loadConsortiaInventList.analyzer = new ConsortionInventListAnalyzer(callBackFun);
         LoadResourceManager.Instance.startLoad(loadConsortiaInventList);
      }
      
      public function getConsortionMember(callBackFun:Function = null) : void
      {
         var args:* = null;
         var loadSelfConsortiaMemberList:* = null;
         if(PlayerManager.Instance.Self.ConsortiaID == 0)
         {
            _model.memberList.clear();
         }
         else
         {
            args = RequestVairableCreater.creatWidthKey(true);
            args["page"] = 1;
            args["size"] = 10000;
            args["order"] = -1;
            args["consortiaID"] = PlayerManager.Instance.Self.ConsortiaID;
            args["userID"] = -1;
            args["state"] = -1;
            args["rnd"] = Math.random();
            loadSelfConsortiaMemberList = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaUsersList.ashx"),7,args);
            loadSelfConsortiaMemberList.loadErrorMessage = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.LoadMemberInfoError");
            loadSelfConsortiaMemberList.analyzer = new ConsortionMemberAnalyer(callBackFun);
            LoadResourceManager.Instance.startLoad(loadSelfConsortiaMemberList);
         }
      }
      
      public function getLevelUpInfo() : BaseLoader
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         var loadConsortiaLevelData:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaLevelList.xml"),7,args);
         loadConsortiaLevelData.loadErrorMessage = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.LoadMyconsortiaLevelError");
         loadConsortiaLevelData.analyzer = new ConsortionLevelUpAnalyzer(levelUpInfoComplete);
         return loadConsortiaLevelData;
      }
      
      public function loadEventList(callBackFun:Function, consortiaID:int = -1) : void
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["page"] = 1;
         args["size"] = 50;
         args["order"] = -1;
         args["consortiaID"] = consortiaID;
         var eventList:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaEventList.ashx"),6,args);
         eventList.loadErrorMessage = LanguageMgr.GetTranslation("ddt.consortion.loadEventList.fail");
         eventList.analyzer = new ConsortionEventListAnalyzer(callBackFun);
         LoadResourceManager.Instance.startLoad(eventList);
      }
      
      public function loadUseConditionList(callBackFun:Function, consortionID:int = -1) : void
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["consortiaID"] = consortionID;
         args["level"] = -1;
         args["type"] = -1;
         var loadConsortiaAssetRight:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaEquipControlList.ashx"),6,args);
         loadConsortiaAssetRight.loadErrorMessage = LanguageMgr.GetTranslation("ddt.consortion.loadUseCondition.fail");
         loadConsortiaAssetRight.analyzer = new ConsortionBuildingUseConditionAnalyer(callBackFun);
         LoadResourceManager.Instance.startLoad(loadConsortiaAssetRight);
      }
      
      public function loadDutyList(callBackFun:Function, consortiaID:int = -1, dutyID:int = -1) : void
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["page"] = 1;
         args["size"] = 1000;
         args["ConsortiaID"] = consortiaID;
         args["order"] = -1;
         args["dutyID"] = dutyID;
         var loadConsortiaDutyList:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaDutyList.ashx"),6,args);
         loadConsortiaDutyList.loadErrorMessage = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.LoadDutyListError");
         loadConsortiaDutyList.analyzer = new ConsortionDutyListAnalyzer(callBackFun);
         LoadResourceManager.Instance.startLoad(loadConsortiaDutyList);
      }
      
      public function loadPollList(consortionID:int) : void
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["ConsortiaID"] = consortionID;
         var pollListLoader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaCandidateList.ashx"),6,args);
         pollListLoader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.consortion.pollload.error");
         pollListLoader.analyzer = new ConsortionPollListAnalyzer(pollListComplete);
         LoadResourceManager.Instance.startLoad(pollListLoader);
      }
      
      public function loadSkillInfoList() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaBufferTemp.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.consortion.skillInfo.loadError");
         loader.analyzer = new ConsortionSkillInfoAnalyzer(skillInfoListComplete);
         return loader;
      }
      
      private function __buyBadgeHandler(event:PkgEvent) : void
      {
         var badgeInfo:* = null;
         var pkg:PackageIn = event.pkg;
         var consortiaID:int = pkg.readInt();
         var badgeID:int = pkg.readInt();
         var validdate:int = pkg.readInt();
         var beginTime:Date = pkg.readDate();
         var result:Boolean = pkg.readBoolean();
         if(consortiaID == PlayerManager.Instance.Self.ConsortiaID)
         {
            PlayerManager.Instance.Self.consortiaInfo.BadgeBuyTime = DateUtils.dateFormat(beginTime);
            PlayerManager.Instance.Self.consortiaInfo.BadgeID = badgeID;
            PlayerManager.Instance.Self.consortiaInfo.ValidDate = validdate;
            PlayerManager.Instance.Self.badgeID = badgeID;
            badgeInfo = BadgeInfoManager.instance.getBadgeInfoByID(badgeID);
            PlayerManager.Instance.Self.consortiaInfo.Riches = PlayerManager.Instance.Self.consortiaInfo.Riches - badgeInfo.Cost;
         }
      }
      
      public function getPerRank() : void
      {
         var urlVariables:URLVariables = new URLVariables();
         urlVariables.UserID = PlayerManager.Instance.Self.ID;
         urlVariables.ConsortiaID = PlayerManager.Instance.Self.ConsortiaID;
         var loader:BaseLoader = LoadResourceManager.Instance.creatAndStartLoad(PathManager.solveRequestPath("ConsortiaWarPlayerRank.ashx"),6,urlVariables);
         loader.analyzer = new PersonalRankAnalyze(perRankPayHander);
      }
      
      private function perRankPayHander(analyze:PersonalRankAnalyze) : void
      {
         ConsortionModelManager.Instance.dispatchEvent(new ConsortionEvent("club_per_list",analyze.dataList));
      }
      
      public function getConsortionRank() : void
      {
         var loader:BaseLoader = LoadResourceManager.Instance.creatAndStartLoad(PathManager.solveRequestPath("ConsortiaWarConsortiaRank.ashx"),6);
         loader.analyzer = new ConsortiaAnalyze(ConsortiaRankPayHander);
      }
      
      private function ConsortiaRankPayHander(analyze:ConsortiaAnalyze) : void
      {
         ConsortionModelManager.Instance.dispatchEvent(new ConsortionEvent("club_rank_list",analyze.dataList));
      }
      
      public function getConsortionTaskRank() : void
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args.ConsortiaID = PlayerManager.Instance.Self.ConsortiaID;
         var loader:BaseLoader = LoadResourceManager.Instance.creatAndStartLoad(PathManager.solveRequestPath("ConsortiaMissionList.ashx"),7,args);
         loader.analyzer = new ConsortiaTaskRankAnalyzer(ConsortiaTaskRankHander);
      }
      
      private function ConsortiaTaskRankHander(analyze:ConsortiaTaskRankAnalyzer) : void
      {
         ConsortionModelManager.Instance.dispatchEvent(new ConsortionEvent("task_rank_list",analyze.dataList));
      }
      
      public function alertTaxFrame() : void
      {
         dispatchEvent(new CEvent("cmctrl_alert_tax"));
      }
      
      public function alertRedPackageFrame() : void
      {
         RedPackageManager.getInstance().showView("red_pkg_consortia_select");
      }
      
      public function alertManagerFrame() : void
      {
         dispatchEvent(new CEvent("cmctrl_alert_manager"));
         loadUseConditionList(useConditionListComplete,PlayerManager.Instance.Self.ConsortiaID);
      }
      
      public function rankFrame() : void
      {
         dispatchEvent(new CEvent("cmctrl_rank"));
         getPerRank();
      }
      
      public function alertShopFrame() : void
      {
         dispatchEvent(new CEvent("cmctrl_alert_shop"));
         loadUseConditionList(useConditionListComplete,PlayerManager.Instance.Self.ConsortiaID);
      }
      
      public function alertBankFrame() : void
      {
         dispatchEvent(new CEvent("cmctrl_alert_bank"));
      }
      
      public function hideBankFrame() : void
      {
         dispatchEvent(new CEvent("cmctrl_hide_bank"));
      }
      
      public function clearReference() : void
      {
         dispatchEvent(new CEvent("cmctrl_clear_reference"));
      }
      
      public function alertTakeInFrame() : void
      {
         dispatchEvent(new CEvent("cmctrl_alert_takein"));
         getApplyRecordList(applyListComplete,-1,PlayerManager.Instance.Self.ConsortiaID);
      }
      
      public function alertQuitFrame() : void
      {
         dispatchEvent(new CEvent("cmctrl_alert_quit"));
      }
      
      public function bossConfigDataSetup(analyzer:ConsortiaBossDataAnalyzer) : void
      {
         _bossConfigDataList = analyzer.dataList;
      }
      
      public function get bossMaxLv() : int
      {
         return !!_bossConfigDataList?_bossConfigDataList.length:0;
      }
      
      public function get bossCallCondition() : int
      {
         if(_bossConfigDataList && _bossConfigDataList.length > 0)
         {
            return _bossConfigDataList[0].level;
         }
         return 3;
      }
      
      public function getCallExtendBossCostRich(type:int, totalLevel:int = 0) : int
      {
         var tmpTotalLevel:* = 0;
         var i:int = 0;
         var conInfo:ConsortiaInfo = PlayerManager.Instance.Self.consortiaInfo;
         if(totalLevel == 0)
         {
            tmpTotalLevel = int(conInfo.Level + conInfo.SmithLevel + conInfo.ShopLevel + conInfo.StoreLevel + conInfo.BufferLevel);
         }
         else
         {
            tmpTotalLevel = totalLevel;
         }
         var rich:int = 100001;
         var len:int = _bossConfigDataList.length;
         for(i = 0; i < len; )
         {
            if(tmpTotalLevel >= _bossConfigDataList[i].level)
            {
               if(type == 1)
               {
                  rich = _bossConfigDataList[i].callBossRich;
               }
               else
               {
                  rich = _bossConfigDataList[i].extendTimeRich;
               }
               i++;
               continue;
            }
            break;
         }
         return rich;
      }
      
      public function getCallBossCostRich(level:int) : int
      {
         return _bossConfigDataList[level - 1].callBossRich;
      }
      
      public function getCanCallBossMaxLevel(totalLevel:int = 0) : int
      {
         var tmpTotalLevel:* = 0;
         var i:int = 0;
         var conInfo:ConsortiaInfo = PlayerManager.Instance.Self.consortiaInfo;
         if(totalLevel == 0)
         {
            tmpTotalLevel = int(conInfo.Level + conInfo.SmithLevel + conInfo.ShopLevel + conInfo.StoreLevel + conInfo.BufferLevel);
         }
         else
         {
            tmpTotalLevel = totalLevel;
         }
         var len:int = _bossConfigDataList.length;
         var tmpMax:int = 1;
         for(i = len - 1; i >= 0; )
         {
            if(tmpTotalLevel >= _bossConfigDataList[i].level)
            {
               tmpMax = i + 1;
               break;
            }
            i--;
         }
         return tmpMax;
      }
      
      public function getRequestCallBossLevel(level:int) : int
      {
         return _bossConfigDataList[level - 1].level;
      }
      
      private function bossOpenCloseHandler(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var type:int = pkg.readByte();
         if(type == 0)
         {
            isShowBossOpenTip = true;
            isBossOpen = true;
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortia.bossOpenTipTxt"));
            ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("ddt.consortia.bossOpenTipTxt"));
            if(StateManager.currentStateType == "main")
            {
               SystemOpenPromptManager.instance.showFrame();
            }
         }
         else if(type == 3)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortia.bossExtendTipTxt"));
            ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("ddt.consortia.bossExtendTipTxt"));
         }
         else
         {
            isShowBossOpenTip = false;
            isBossOpen = false;
            if(type == 1)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortia.bossCloseTipTxt"));
               ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("ddt.consortia.bossCloseTipTxt"));
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortia.bossCloseTipTxt2"));
               ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("ddt.consortia.bossCloseTipTxt2"));
            }
            LoadResourceManager.Instance.startLoad(MailManager.Instance.getAllEmailLoader());
         }
      }
      
      public function showEnterBtnInHallStateView($parent:IHallStateView) : void
      {
         if(_enterBtn == null)
         {
            _enterBtn = ComponentFactory.Instance.creat("hall.consortia.btn");
         }
         $parent.leftTopGbox.addChild(_enterBtn);
         $parent.arrangeLeftGrid();
         _enterBtn.addEventListener("click",onEnterBtnClick);
      }
      
      public function hideEnterBtnInHallStateView($parent:IHallStateView) : void
      {
         if(_enterBtn != null && _enterBtn.parent != null)
         {
            $parent.leftTopGbox.removeChild(_enterBtn);
            $parent.leftTopGbox.arrange();
            _enterBtn.removeEventListener("click",onEnterBtnClick);
         }
         ObjectUtils.disposeObject(_enterBtn);
         _enterBtn = null;
      }
      
      protected function onEnterBtnClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.createConsortiaBossTemplateLoader],gotoConsortia);
      }
      
      private function gotoConsortia() : void
      {
         if(!WeakGuildManager.Instance.checkOpen(15,17))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",17));
            return;
         }
         StateManager.setState("consortia");
         ComponentSetting.SEND_USELOG_ID(5);
      }
      
      public function openBossFrame() : void
      {
         dispatchEvent(new CEvent("cmctrl_open_boss"));
      }
      
      private function onConSortiaBackAward(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var awardId:int = pkg.readInt();
         var callBackModel:CallBackModel = _model.callBackModel;
         callBackModel.awardStateMap[awardId.toString()] = 1;
         dispatchEvent(new Event("event_consortia_back_award"));
      }
      
      private function onConSortiaBackInfo(event:PkgEvent) : void
      {
         var i:int = 0;
         var awardID:int = 0;
         var TemplateID:int = 0;
         var Count:int = 0;
         var VaildDate:int = 0;
         var BackCount:int = 0;
         var templeteInfo:* = null;
         var inventoryItemInfo:* = null;
         var awardID2:int = 0;
         var pkg:PackageIn = event.pkg;
         var callBackModel:CallBackModel = _model.callBackModel;
         callBackModel.startTime = pkg.readDate();
         callBackModel.endTime = pkg.readDate();
         callBackModel.callBackCount = pkg.readInt();
         callBackModel.awardArr = [];
         var awardArrLength:int = pkg.readInt();
         for(i = 0; i < awardArrLength; )
         {
            awardID = pkg.readInt();
            TemplateID = pkg.readInt();
            Count = pkg.readInt();
            VaildDate = pkg.readInt();
            BackCount = pkg.readInt();
            templeteInfo = ItemManager.Instance.getTemplateById(TemplateID);
            inventoryItemInfo = new InventoryItemInfo();
            ObjectUtils.copyProperties(inventoryItemInfo,templeteInfo);
            inventoryItemInfo.ValidDate = VaildDate;
            inventoryItemInfo.Count = Count;
            inventoryItemInfo.IsBinds = true;
            inventoryItemInfo.Property5 = "1";
            callBackModel.awardArr.push({
               "itemTemplateInfo":inventoryItemInfo,
               "awardID":awardID,
               "backCount":BackCount
            });
            i++;
         }
         callBackModel.awardStateMap = {};
         var awardStateMapLength:int = pkg.readInt();
         for(i = 0; i < awardStateMapLength; )
         {
            awardID2 = pkg.readInt();
            callBackModel.awardStateMap[awardID2] = pkg.readInt();
            i++;
         }
         dispatchEvent(new Event("event_consortia_back_info"));
      }
      
      public function enterConsortiaState() : void
      {
         new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.createConsortiaBossTemplateLoader],gotoConsortia);
      }
      
      public function requestSortionActiveTargetSchedule() : void
      {
         SocketManager.Instance.out.sendConsortionActiveTargetSchedule();
      }
      
      private function onConSortionActiveTargetSchedule(pkg:PkgEvent) : void
      {
         var missionCnt:int = pkg.pkg.readInt();
         var onlineCnt:int = pkg.pkg.readInt();
         var contributionValue:int = pkg.pkg.readInt();
         var assets:int = pkg.pkg.readInt();
         var _loc11_:int = 0;
         var _loc10_:* = _model.activeTargetDic;
         for each(var targets in _model.activeTargetDic)
         {
            var _loc9_:int = 0;
            var _loc8_:* = targets;
            for each(var target in targets)
            {
               if(target.targetId == 1)
               {
                  target.processValue = missionCnt;
               }
               else if(target.targetId == 2)
               {
                  target.processValue = onlineCnt;
               }
               else if(target.targetId == 3)
               {
                  target.processValue = contributionValue;
               }
               else if(target.targetId == 4)
               {
                  target.processValue = assets;
               }
            }
         }
         ConsortionModelManager.Instance.requestConsortionActiveTagertStatus();
         dispatchEvent(new CEvent("updatectiveTargetSchedule"));
      }
      
      public function requestConsortionActiveTagertStatus() : void
      {
         SocketManager.Instance.out.sendConsortionActiveTagertStatus();
      }
      
      public function requestConsortionActiveTagertReward(lv:int) : void
      {
         SocketManager.Instance.out.sendConsortionActiveTagertReward(lv);
      }
      
      private function onConSortionActiveTargetStatus(pkg:PkgEvent) : void
      {
         var i:int = 0;
         var level:int = pkg.pkg.readInt();
         ConsortionModelManager.Instance.model.rewardLv = level;
         var targets:Vector.<ConsortionActiveTargetData> = null;
         var isCompeleted:Boolean = true;
         var lastCompleteIdx:* = 0;
         for(i = 1; i <= 3; )
         {
            if(i <= level)
            {
               _model.activeTargetStautsDic[i] = 3;
               lastCompleteIdx = level;
            }
            else
            {
               targets = ConsortionModelManager.Instance.model.activeTargetDic[i];
               var _loc9_:int = 0;
               var _loc8_:* = targets;
               for each(var target in targets)
               {
                  if(target.processValue < target.conditionValue)
                  {
                     isCompeleted = false;
                     break;
                  }
               }
               if(isCompeleted)
               {
                  _model.activeTargetStautsDic[i] = 2;
                  lastCompleteIdx = i;
               }
               else if(i >= 1 && lastCompleteIdx == i - 1)
               {
                  _model.activeTargetStautsDic[i] = 1;
               }
               else
               {
                  _model.activeTargetStautsDic[i] = 0;
               }
            }
            i++;
         }
         ConsortionModelManager.Instance.dispatchEvent(new CEvent("updateActiveTargetStatus"));
      }
      
      public function initConsortionActiveTarget() : void
      {
         var i:int = 0;
         var j:int = 0;
         if(_model.hasActiveTargetInited)
         {
            return;
         }
         var cfg:String = ServerConfigManager.instance.consortionActiveTarget;
         var levelCfg:Array = cfg.split("|");
         var targetCfg:Array = null;
         var target:ConsortionActiveTargetData = null;
         var targets:Vector.<ConsortionActiveTargetData> = null;
         for(i = 1; i <= levelCfg.length; )
         {
            targets = new Vector.<ConsortionActiveTargetData>();
            _model.activeTargetDic[i] = targets;
            targetCfg = String(levelCfg[i - 1]).split(",");
            for(j = 1; j <= targetCfg.length; )
            {
               target = new ConsortionActiveTargetData();
               target.targetId = j;
               target.conditionValue = targetCfg[j - 1];
               target.targetLv = i;
               targets.push(target);
               j++;
            }
            i++;
         }
         _model.hasActiveTargetInited = true;
      }
      
      public function checkRewardStauts() : Boolean
      {
         var i:int = 0;
         var level:int = ConsortionModelManager.Instance.model.rewardLv;
         var targets:Vector.<ConsortionActiveTargetData> = null;
         var rewardCnt:int = 0;
         var isCompeleted:Boolean = true;
         for(i = 1; i <= 3; )
         {
            if(i <= level)
            {
               rewardCnt = rewardCnt + 0;
            }
            else
            {
               targets = ConsortionModelManager.Instance.model.activeTargetDic[i];
               var _loc8_:int = 0;
               var _loc7_:* = targets;
               for each(var target in targets)
               {
                  if(target.processValue < target.conditionValue)
                  {
                     isCompeleted = false;
                     break;
                  }
               }
               if(isCompeleted)
               {
                  rewardCnt = rewardCnt + 1;
               }
               else
               {
                  rewardCnt = rewardCnt + 0;
               }
            }
            i++;
         }
         return rewardCnt > 0;
      }
   }
}
