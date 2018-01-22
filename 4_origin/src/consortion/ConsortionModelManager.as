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
      
      protected function onTaskInfoChange(param1:ConsortiaTaskEvent) : void
      {
         var _loc2_:ConsortiaTaskInfo = _taskModel.taskInfo;
         if(_loc2_ != null && _loc2_.beginTime != null)
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
      
      protected function onTaskTimerTimer(param1:Event) : void
      {
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:* = null;
         var _loc3_:Number = NaN;
         var _loc7_:* = null;
         var _loc2_:int = 0;
         if(_taskModel.taskInfo && _taskModel.taskInfo.beginTime)
         {
            _loc4_ = true;
            _loc6_ = _taskModel.taskInfo.itemList.length;
            _loc8_ = 0;
            while(_loc8_ < _loc6_)
            {
               if(_taskModel.taskInfo.itemList[_loc8_].currenValue - _taskModel.taskInfo.itemList[_loc8_].targetValue < 0)
               {
                  _loc4_ = false;
                  break;
               }
               _loc8_++;
            }
            if(_loc4_)
            {
               return;
            }
            _loc5_ = ConsortionModelManager.Instance.TaskModel.taskInfo.beginTime;
            _loc3_ = ConsortionModelManager.Instance.TaskModel.taskInfo.time * 60 - int(TimeManager.Instance.TotalSecondToNow(_loc5_)) + 60;
            if(_loc3_ <= 0)
            {
               return;
            }
            _loc3_ = _loc3_ * 1000;
            _loc6_ = _alertFlagList.length;
            _loc8_ = 0;
            while(_loc8_ < _loc6_)
            {
               if(_loc3_ <= _alertFlagList[_loc8_])
               {
                  if(_alertStatusList[_loc8_] == false)
                  {
                     _alertStatusList[_loc8_] = true;
                     if(_firstShow)
                     {
                        _firstShow = false;
                        _loc7_ = _loc8_ > 1?_alertMsgList[1]:_alertMsgList[0];
                        _loc2_ = _loc8_ > 1?Math.round(_loc3_ / 60000):int(_loc3_ / 1000);
                        ChatManager.Instance.sysChatConsortia(LanguageMgr.GetTranslation(_loc7_,_loc2_));
                     }
                     else
                     {
                        _loc7_ = _loc8_ > 0?_alertMsgList[1]:_alertMsgList[0];
                        _loc2_ = _loc8_ > 0?Math.round(_alertFlagList[_loc8_] / 60000):30;
                        ChatManager.Instance.sysChatConsortia(LanguageMgr.GetTranslation(_loc7_,_loc2_));
                     }
                  }
                  break;
               }
               _loc8_++;
            }
         }
      }
      
      private function __consortiaResponse(param1:PkgEvent) : void
      {
         var _loc16_:int = 0;
         var _loc19_:* = null;
         var _loc6_:* = null;
         var _loc36_:Boolean = false;
         var _loc24_:int = 0;
         var _loc28_:* = null;
         var _loc11_:int = 0;
         var _loc2_:* = null;
         var _loc35_:int = 0;
         var _loc25_:Boolean = false;
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc22_:int = 0;
         var _loc20_:* = null;
         var _loc21_:int = 0;
         var _loc33_:* = null;
         var _loc7_:int = 0;
         var _loc30_:* = null;
         var _loc43_:* = null;
         var _loc40_:* = null;
         var _loc8_:int = 0;
         var _loc37_:* = null;
         var _loc23_:int = 0;
         var _loc42_:int = 0;
         var _loc15_:int = 0;
         var _loc41_:int = 0;
         var _loc27_:* = null;
         var _loc29_:int = 0;
         var _loc12_:* = null;
         var _loc10_:int = 0;
         var _loc31_:int = 0;
         var _loc34_:* = null;
         var _loc4_:* = null;
         var _loc13_:* = null;
         var _loc9_:* = null;
         var _loc17_:int = 0;
         var _loc44_:int = 0;
         var _loc18_:* = null;
         var _loc38_:int = 0;
         var _loc26_:* = null;
         var _loc39_:int = 0;
         var _loc32_:PackageIn = param1.pkg;
         var _loc14_:int = _loc32_.readByte();
         switch(int(_loc14_) - 1)
         {
            case 0:
               _loc6_ = new ConsortiaPlayerInfo();
               _loc6_.privateID = _loc32_.readInt();
               _loc36_ = _loc32_.readBoolean();
               _loc6_.ConsortiaID = _loc32_.readInt();
               _loc6_.ConsortiaName = _loc32_.readUTF();
               _loc6_.ID = _loc32_.readInt();
               _loc6_.NickName = _loc32_.readUTF();
               _loc24_ = _loc32_.readInt();
               _loc28_ = _loc32_.readUTF();
               _loc6_.DutyID = _loc32_.readInt();
               _loc6_.DutyName = _loc32_.readUTF();
               _loc6_.Offer = _loc32_.readInt();
               _loc6_.RichesOffer = _loc32_.readInt();
               _loc6_.RichesRob = _loc32_.readInt();
               _loc6_.LastDate = _loc32_.readDateString();
               _loc6_.Grade = _loc32_.readInt();
               _loc6_.DutyLevel = _loc32_.readInt();
               _loc11_ = _loc32_.readInt();
               _loc6_.playerState = new PlayerState(_loc11_);
               _loc6_.Sex = _loc32_.readBoolean();
               _loc6_.Right = _loc32_.readInt();
               _loc6_.WinCount = _loc32_.readInt();
               _loc6_.TotalCount = _loc32_.readInt();
               _loc6_.EscapeCount = _loc32_.readInt();
               _loc6_.Repute = _loc32_.readInt();
               _loc6_.LoginName = _loc32_.readUTF();
               _loc6_.FightPower = _loc32_.readInt();
               _loc6_.AchievementPoint = _loc32_.readInt();
               _loc6_.honor = _loc32_.readUTF();
               _loc6_.UseOffer = _loc32_.readInt();
               if(!(_loc36_ && _loc6_.ID == PlayerManager.Instance.Self.ID))
               {
                  if(_loc6_.ID == PlayerManager.Instance.Self.ID)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.PlayerManager.one",_loc6_.ConsortiaName));
                  }
               }
               _loc2_ = "";
               if(_loc6_.ID == PlayerManager.Instance.Self.ID)
               {
                  setPlayerConsortia(_loc6_.ConsortiaID,_loc6_.ConsortiaName);
                  getConsortionMember(memberListComplete);
                  getConsortionList(selfConsortionComplete,1,6,_loc6_.ConsortiaName,-1,-1,-1,_loc6_.ConsortiaID);
                  if(_loc36_)
                  {
                     _loc2_ = LanguageMgr.GetTranslation("tank.manager.PlayerManager.isInvent.msg",_loc6_.ConsortiaName);
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("tank.manager.PlayerManager.pass",_loc6_.ConsortiaName);
                  }
                  if(StateManager.currentStateType == "consortia")
                  {
                     dispatchEvent(new ConsortionEvent("consortionStateChange"));
                  }
                  TaskManager.instance.requestClubTask();
                  if(PathManager.solveExternalInterfaceEnabel())
                  {
                     ExternalInterfaceManager.sendToAgent(5,PlayerManager.Instance.Self.ID,PlayerManager.Instance.Self.NickName,ServerManager.Instance.zoneName,-1,_loc6_.ConsortiaName);
                  }
               }
               else
               {
                  _model.addMember(_loc6_);
                  _loc2_ = LanguageMgr.GetTranslation("tank.manager.PlayerManager.player",_loc6_.NickName);
               }
               _loc2_ = StringHelper.rePlaceHtmlTextField(_loc2_);
               ChatManager.Instance.sysChatYellow(_loc2_);
               if(_loc6_.ConsortiaID == 0)
               {
                  ConsortionModelManager.Instance.TaskModel.taskInfo = null;
               }
               break;
            case 1:
               _loc16_ = _loc32_.readInt();
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
               _loc16_ = _loc32_.readInt();
               _loc35_ = _loc32_.readInt();
               _loc25_ = _loc32_.readBoolean();
               _loc19_ = _loc32_.readUTF();
               _loc5_ = _loc32_.readUTF();
               if(PlayerManager.Instance.Self.ID == _loc16_)
               {
                  setPlayerConsortia();
                  getConsortionMember();
                  TaskManager.instance.onGuildUpdate();
                  _loc3_ = "";
                  if(_loc25_)
                  {
                     this.dispatchEvent(new ConsortionEvent("kick_consortion"));
                     _loc3_ = LanguageMgr.GetTranslation("tank.manager.PlayerManager.delect",_loc5_);
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.PlayerManager.hit"));
                  }
                  else
                  {
                     _loc3_ = LanguageMgr.GetTranslation("tank.manager.PlayerManager.leave");
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
                  _loc3_ = StringHelper.rePlaceHtmlTextField(_loc3_);
                  ChatManager.Instance.sysChatRed(_loc3_);
               }
               else
               {
                  removeConsortiaMember(_loc16_,_loc25_,_loc5_);
               }
               if(_loc19_ == PlayerManager.Instance.Self.NickName)
               {
                  ConsortionModelManager.Instance.TaskModel.taskInfo = null;
               }
               break;
            case 3:
               _invateID = _loc32_.readInt();
               _loc22_ = _loc32_.readInt();
               _loc20_ = _loc32_.readUTF();
               _loc21_ = _loc32_.readInt();
               _loc33_ = _loc32_.readUTF();
               _loc7_ = _loc32_.readInt();
               _loc30_ = _loc32_.readUTF();
               if(SharedManager.Instance.showCI)
               {
                  if(str != _loc33_)
                  {
                     SoundManager.instance.play("018");
                     _loc43_ = _loc33_ + LanguageMgr.GetTranslation("tank.manager.PlayerManager.come",_loc30_);
                     _loc43_ = StringHelper.rePlaceHtmlTextField(_loc43_);
                     _loc40_ = StageReferance.stage.focus;
                     if(_enterConfirm)
                     {
                        _enterConfirm.removeEventListener("response",__enterConsortiaConfirm);
                        ObjectUtils.disposeObject(_enterConfirm);
                        _enterConfirm = null;
                     }
                     _enterConfirm = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.manager.PlayerManager.request"),_loc43_,LanguageMgr.GetTranslation("tank.manager.PlayerManager.sure"),LanguageMgr.GetTranslation("tank.manager.PlayerManager.refuse"),false,true,true,2,"alertInFight");
                     _enterConfirm.addEventListener("response",__enterConsortiaConfirm);
                     str = _loc33_;
                     if(_loc40_ is TextField)
                     {
                        if(TextField(_loc40_).type == "input")
                        {
                           StageReferance.stage.focus = _loc40_;
                        }
                     }
                  }
               }
               break;
            case 4:
               break;
            case 5:
               _loc8_ = _loc32_.readInt();
               _loc37_ = _loc32_.readUTF();
               _loc23_ = _loc32_.readInt();
               if(PlayerManager.Instance.Self.ConsortiaID == _loc8_)
               {
                  PlayerManager.Instance.Self.consortiaInfo.Level = _loc23_;
                  ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("tank.manager.PlayerManager.upgrade",_loc23_,_model.getLevelData(_loc23_).Count));
                  TaskManager.instance.requestClubTask();
                  SoundManager.instance.play("1001");
                  getConsortionList(selfConsortionComplete,1,6,PlayerManager.Instance.Self.ConsortiaName,-1,-1,-1,PlayerManager.Instance.Self.ConsortiaID);
                  TaskManager.instance.onGuildUpdate();
               }
               break;
            case 6:
               break;
            case 7:
               _loc42_ = _loc32_.readByte();
               _loc15_ = _loc32_.readInt();
               _loc41_ = _loc32_.readInt();
               _loc27_ = _loc32_.readUTF();
               _loc29_ = _loc32_.readInt();
               _loc12_ = _loc32_.readUTF();
               _loc10_ = _loc32_.readInt();
               _loc31_ = _loc32_.readInt();
               _loc34_ = _loc32_.readUTF();
               if(_loc42_ != 1)
               {
                  if(_loc42_ == 2)
                  {
                     updateDutyInfo(_loc29_,_loc12_,_loc10_);
                  }
                  else if(_loc42_ == 3)
                  {
                     upDateSelfDutyInfo(_loc29_,_loc12_,_loc10_);
                  }
                  else if(_loc42_ == 4)
                  {
                     upDateSelfDutyInfo(_loc29_,_loc12_,_loc10_);
                  }
                  else if(_loc42_ == 5)
                  {
                     upDateSelfDutyInfo(_loc29_,_loc12_,_loc10_);
                  }
                  else if(_loc42_ == 6)
                  {
                     updateConsortiaMemberDuty(_loc41_,_loc29_,_loc12_,_loc10_);
                     _loc4_ = "";
                     if(_loc41_ == PlayerManager.Instance.Self.ID)
                     {
                        _loc4_ = LanguageMgr.GetTranslation("tank.manager.PlayerManager.youUpgrade",_loc34_,_loc12_);
                     }
                     else if(_loc41_ == _loc31_)
                     {
                        _loc4_ = LanguageMgr.GetTranslation("tank.manager.PlayerManager.upgradeSelf",_loc27_,_loc12_);
                     }
                     else
                     {
                        _loc4_ = LanguageMgr.GetTranslation("tank.manager.PlayerManager.upgradeOther",_loc34_,_loc27_,_loc12_);
                     }
                     _loc4_ = StringHelper.rePlaceHtmlTextField(_loc4_);
                     ChatManager.Instance.sysChatYellow(_loc4_);
                  }
                  else if(_loc42_ == 7)
                  {
                     updateConsortiaMemberDuty(_loc41_,_loc29_,_loc12_,_loc10_);
                     _loc13_ = "";
                     if(_loc41_ == PlayerManager.Instance.Self.ID)
                     {
                        _loc13_ = LanguageMgr.GetTranslation("tank.manager.PlayerManager.youDemotion",_loc34_,_loc12_);
                     }
                     else if(_loc41_ == _loc31_)
                     {
                        _loc13_ = LanguageMgr.GetTranslation("tank.manager.PlayerManager.demotionSelf",_loc27_,_loc12_);
                     }
                     else
                     {
                        _loc13_ = LanguageMgr.GetTranslation("tank.manager.PlayerManager.demotionOther",_loc34_,_loc27_,_loc12_);
                     }
                     _loc13_ = StringHelper.rePlaceHtmlTextField(_loc13_);
                     ChatManager.Instance.sysChatYellow(_loc13_);
                  }
                  else if(_loc42_ == 8)
                  {
                     updateConsortiaMemberDuty(_loc41_,_loc29_,_loc12_,_loc10_);
                     SoundManager.instance.play("1001");
                  }
                  else if(_loc42_ == 9)
                  {
                     updateConsortiaMemberDuty(_loc41_,_loc29_,_loc12_,_loc10_);
                     PlayerManager.Instance.Self.consortiaInfo.ChairmanName = _loc27_;
                     _loc9_ = "<" + _loc27_ + ">" + LanguageMgr.GetTranslation("tank.manager.PlayerManager.up") + _loc12_;
                     _loc9_ = StringHelper.rePlaceHtmlTextField(_loc9_);
                     ChatManager.Instance.sysChatYellow(_loc9_);
                     SoundManager.instance.play("1001");
                  }
               }
               break;
            case 8:
               _loc17_ = _loc32_.readInt();
               _loc44_ = _loc32_.readInt();
               _loc18_ = _loc32_.readUTF();
               _loc38_ = _loc32_.readInt();
               if(_loc17_ != PlayerManager.Instance.Self.ConsortiaID)
               {
                  return;
               }
               _loc26_ = "";
               if(PlayerManager.Instance.Self.ID == _loc44_)
               {
                  _loc26_ = LanguageMgr.GetTranslation("tank.manager.PlayerManager.contributionSelf",_loc38_);
               }
               else
               {
                  _loc26_ = LanguageMgr.GetTranslation("tank.manager.PlayerManager.contributionOther",_loc18_,_loc38_);
               }
               ChatManager.Instance.sysChatYellow(_loc26_);
               break;
            case 9:
               consortiaUpLevel(10,_loc32_.readInt(),_loc32_.readUTF(),_loc32_.readInt());
               break;
            case 10:
               consortiaUpLevel(11,_loc32_.readInt(),_loc32_.readUTF(),_loc32_.readInt());
               break;
            case 11:
               consortiaUpLevel(12,_loc32_.readInt(),_loc32_.readUTF(),_loc32_.readInt());
               break;
            case 12:
               consortiaUpLevel(13,_loc32_.readInt(),_loc32_.readUTF(),_loc32_.readInt());
               break;
            case 13:
               _loc39_ = _loc32_.readInt();
               switch(int(_loc39_) - 1)
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
               _loc32_.readInt();
               ChatManager.Instance.sysChatYellow(_loc32_.readUTF());
               break;
            case 15:
               getConsortionList(selfConsortionComplete,1,6,PlayerManager.Instance.Self.ConsortiaName,-1,-1,-1,PlayerManager.Instance.Self.ConsortiaID);
         }
      }
      
      private function consortiaUpLevel(param1:int, param2:int, param3:String, param4:int) : void
      {
         if(param2 != PlayerManager.Instance.Self.ConsortiaID)
         {
            return;
         }
         SoundManager.instance.play("1001");
         var _loc5_:String = "";
         if(param1 == 10)
         {
            if(PlayerManager.Instance.Self.DutyLevel == 1)
            {
               _loc5_ = LanguageMgr.GetTranslation("tank.manager.PlayerManager.consortiaShop",param4);
            }
            else
            {
               _loc5_ = LanguageMgr.GetTranslation("tank.manager.PlayerManager.consortiaShop2",param4);
            }
            PlayerManager.Instance.Self.consortiaInfo.ShopLevel = param4;
         }
         else if(param1 == 11)
         {
            if(PlayerManager.Instance.Self.DutyLevel == 1)
            {
               _loc5_ = LanguageMgr.GetTranslation("tank.manager.PlayerManager.consortiaStore",param4);
            }
            else
            {
               _loc5_ = LanguageMgr.GetTranslation("tank.manager.PlayerManager.consortiaStore2",param4);
            }
            PlayerManager.Instance.Self.consortiaInfo.SmithLevel = param4;
         }
         else if(param1 == 12)
         {
            if(PlayerManager.Instance.Self.DutyLevel == 1)
            {
               _loc5_ = LanguageMgr.GetTranslation("tank.manager.PlayerManager.consortiaSmith",param4);
            }
            else
            {
               _loc5_ = LanguageMgr.GetTranslation("tank.manager.PlayerManager.consortiaSmith2",param4);
            }
            PlayerManager.Instance.Self.consortiaInfo.StoreLevel = param4;
         }
         else if(param1 == 13)
         {
            if(PlayerManager.Instance.Self.DutyLevel == 1)
            {
               _loc5_ = LanguageMgr.GetTranslation("tank.manager.PlayerManager.consortiaSkill",param4);
            }
            else
            {
               _loc5_ = LanguageMgr.GetTranslation("tank.manager.PlayerManager.consortiaSkill2",param4);
            }
            PlayerManager.Instance.Self.consortiaInfo.BufferLevel = param4;
         }
         ChatManager.Instance.sysChatYellow(_loc5_);
         getConsortionList(selfConsortionComplete,1,6,PlayerManager.Instance.Self.ConsortiaName,-1,-1,-1,PlayerManager.Instance.Self.ConsortiaID);
         TaskManager.instance.onGuildUpdate();
      }
      
      private function updateDutyInfo(param1:int, param2:String, param3:int) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = _model.memberList;
         for each(var _loc4_ in _model.memberList)
         {
            if(_loc4_.DutyLevel == param1)
            {
               _loc4_.DutyLevel == param1;
               _loc4_.DutyName = param2;
               _loc4_.Right = param3;
               _model.updataMember(_loc4_);
            }
         }
      }
      
      private function upDateSelfDutyInfo(param1:int, param2:String, param3:int) : void
      {
         var _loc7_:int = 0;
         var _loc6_:* = _model.memberList;
         for each(var _loc4_ in _model.memberList)
         {
            if(_loc4_.ID == PlayerManager.Instance.Self.ID)
            {
               PlayerManager.Instance.Self.beginChanges();
               var _loc5_:* = param1;
               PlayerManager.Instance.Self.DutyLevel = _loc5_;
               _loc4_.DutyLevel = _loc5_;
               _loc5_ = param2;
               PlayerManager.Instance.Self.DutyName = _loc5_;
               _loc4_.DutyName = _loc5_;
               _loc5_ = param3;
               PlayerManager.Instance.Self.Right = _loc5_;
               _loc4_.Right = _loc5_;
               PlayerManager.Instance.Self.commitChanges();
               _model.updataMember(_loc4_);
            }
         }
      }
      
      private function updateConsortiaMemberDuty(param1:int, param2:int, param3:String, param4:int) : void
      {
         var _loc7_:int = 0;
         var _loc6_:* = _model.memberList;
         for each(var _loc5_ in _model.memberList)
         {
            if(_loc5_.ID == param1)
            {
               _loc5_.beginChanges();
               _loc5_.DutyLevel = param2;
               _loc5_.DutyName = param3;
               _loc5_.Right = param4;
               if(_loc5_.ID == PlayerManager.Instance.Self.ID)
               {
                  PlayerManager.Instance.Self.beginChanges();
                  PlayerManager.Instance.Self.DutyLevel = param2;
                  PlayerManager.Instance.Self.DutyName = param3;
                  PlayerManager.Instance.Self.Right = param4;
                  PlayerManager.Instance.Self.consortiaInfo.Level = PlayerManager.Instance.Self.consortiaInfo.Level == 0?1:PlayerManager.Instance.Self.consortiaInfo.Level;
                  PlayerManager.Instance.Self.commitChanges();
                  getConsortionList(selfConsortionComplete,1,6,PlayerManager.Instance.Self.consortiaInfo.ConsortiaName,-1,-1,-1,PlayerManager.Instance.Self.consortiaInfo.ConsortiaID);
               }
               _loc5_.commitChanges();
               _model.updataMember(_loc5_);
            }
         }
      }
      
      private function removeConsortiaMember(param1:int, param2:Boolean, param3:String) : void
      {
         var _loc4_:* = null;
         var _loc7_:int = 0;
         var _loc6_:* = _model.memberList;
         for each(var _loc5_ in _model.memberList)
         {
            if(_loc5_.ID == param1)
            {
               _loc4_ = "";
               if(param2)
               {
                  _loc4_ = LanguageMgr.GetTranslation("tank.manager.PlayerManager.consortia",param3,_loc5_.NickName);
               }
               else
               {
                  _loc4_ = LanguageMgr.GetTranslation("tank.manager.PlayerManager.leaveconsortia",_loc5_.NickName);
               }
               _loc4_ = StringHelper.rePlaceHtmlTextField(_loc4_);
               ChatManager.Instance.sysChatYellow(_loc4_);
               _model.removeMember(_loc5_);
            }
         }
      }
      
      private function __enterConsortiaConfirm(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__enterConsortiaConfirm);
         if(_loc2_)
         {
            ObjectUtils.disposeObject(_loc2_);
            _loc2_ = null;
         }
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            accpetConsortiaInvent();
         }
         if(param1.responseCode == 0 || param1.responseCode == 4)
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
      
      private function __givceOffer(param1:PkgEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         var _loc3_:Boolean = param1.pkg.readBoolean();
         var _loc4_:String = param1.pkg.readUTF();
         MessageTipManager.getInstance().show(_loc4_);
         if(_loc3_)
         {
            PlayerManager.Instance.Self.consortiaInfo.Riches = PlayerManager.Instance.Self.consortiaInfo.Riches + Math.floor(Number(_loc2_ / 2));
            _model.getConsortiaMemberInfo(PlayerManager.Instance.Self.ID).RichesOffer = _model.getConsortiaMemberInfo(PlayerManager.Instance.Self.ID).RichesOffer + Math.floor(Number(_loc2_ / 2));
            TaskManager.instance.onGuildUpdate();
         }
      }
      
      private function __onConsortiaEquipControl(param1:PkgEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc4_:int = 0;
         var _loc3_:Boolean = param1.pkg.readBoolean();
         if(_loc3_)
         {
            _loc2_ = new Vector.<ConsortiaAssetLevelOffer>();
            _loc4_ = 0;
            while(_loc4_ < 7)
            {
               _loc2_[_loc4_] = new ConsortiaAssetLevelOffer();
               if(_loc4_ < 5)
               {
                  _loc2_[_loc4_].Type = 1;
                  _loc2_[_loc4_].Level = _loc4_ + 1;
               }
               else if(_loc4_ == 5)
               {
                  _loc2_[_loc4_].Type = 2;
               }
               else
               {
                  _loc2_[_loc4_].Type = 3;
               }
               _loc4_++;
            }
            _loc2_[0].Riches = param1.pkg.readInt();
            _loc2_[1].Riches = param1.pkg.readInt();
            _loc2_[2].Riches = param1.pkg.readInt();
            _loc2_[3].Riches = param1.pkg.readInt();
            _loc2_[4].Riches = param1.pkg.readInt();
            _loc2_[5].Riches = param1.pkg.readInt();
            _loc2_[6].Riches = param1.pkg.readInt();
            if(PlayerManager.Instance.Self.ID == PlayerManager.Instance.Self.consortiaInfo.ChairmanID)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.onConsortiaEquipControl.executeSuccess"));
            }
            _model.useConditionList = _loc2_;
         }
         else if(PlayerManager.Instance.Self.ID == PlayerManager.Instance.Self.consortiaInfo.ChairmanID)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.onConsortiaEquipControl.executeFail"));
         }
      }
      
      private function __consortiaTryIn(param1:PkgEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         var _loc3_:Boolean = param1.pkg.readBoolean();
         var _loc4_:String = param1.pkg.readUTF();
         MessageTipManager.getInstance().show(_loc4_);
         if(_loc3_)
         {
            getApplyRecordList(applyListComplete,PlayerManager.Instance.Self.ID);
         }
      }
      
      private function __tryInDel(param1:PkgEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         var _loc4_:Boolean = param1.pkg.readBoolean();
         var _loc3_:String = param1.pkg.readUTF();
         MessageTipManager.getInstance().show(_loc3_);
         if(_loc4_)
         {
            _model.deleteOneApplyRecord(_loc2_);
         }
      }
      
      private function __consortiaTryInPass(param1:PkgEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         var _loc3_:Boolean = param1.pkg.readBoolean();
         var _loc4_:String = param1.pkg.readUTF();
         MessageTipManager.getInstance().show(_loc4_);
         if(_loc3_)
         {
            _model.deleteOneApplyRecord(_loc2_);
         }
      }
      
      private function __consortiaInvate(param1:PkgEvent) : void
      {
         var _loc2_:String = param1.pkg.readUTF();
         var _loc3_:Boolean = param1.pkg.readBoolean();
         var _loc4_:String = param1.pkg.readUTF();
         MessageTipManager.getInstance().show(_loc4_);
      }
      
      private function __consortiaInvitePass(param1:PkgEvent) : void
      {
         var _loc5_:int = param1.pkg.readInt();
         var _loc4_:Boolean = param1.pkg.readBoolean();
         var _loc2_:int = param1.pkg.readInt();
         var _loc3_:String = param1.pkg.readUTF();
         MessageTipManager.getInstance().show(param1.pkg.readUTF());
         if(_loc4_)
         {
            setPlayerConsortia(_loc2_,_loc3_);
            getConsortionMember(memberListComplete);
            getConsortionList(selfConsortionComplete,1,6,_loc3_,-1,-1,-1,_loc2_);
         }
      }
      
      private function __consortiaCreate(param1:PkgEvent) : void
      {
         var _loc5_:String = param1.pkg.readUTF();
         var _loc4_:Boolean = param1.pkg.readBoolean();
         var _loc2_:int = param1.pkg.readInt();
         var _loc7_:String = param1.pkg.readUTF();
         var _loc9_:String = param1.pkg.readUTF();
         MessageTipManager.getInstance().show(_loc9_);
         var _loc3_:int = param1.pkg.readInt();
         var _loc6_:String = param1.pkg.readUTF();
         var _loc8_:int = param1.pkg.readInt();
         if(_loc4_)
         {
            setPlayerConsortia(_loc2_,_loc5_);
            getConsortionMember(memberListComplete);
            getConsortionList(selfConsortionComplete,1,6,_loc5_,-1,-1,-1,_loc2_);
            dispatchEvent(new ConsortionEvent("consortionStateChange"));
            TaskManager.instance.requestClubTask();
            if(PathManager.solveExternalInterfaceEnabel())
            {
               ExternalInterfaceManager.sendToAgent(4,PlayerManager.Instance.Self.ID,PlayerManager.Instance.Self.NickName,ServerManager.Instance.zoneName,-1,_loc7_);
            }
         }
      }
      
      private function __consortiaDisband(param1:PkgEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         if(param1.pkg.readBoolean())
         {
            if(param1.pkg.readInt() == PlayerManager.Instance.Self.ID)
            {
               setPlayerConsortia();
               if(StateManager.currentStateType == "consortia")
               {
                  StateManager.back();
               }
               ChatManager.Instance.sysChatRed(LanguageMgr.GetTranslation("tank.manager.PlayerManager.msg"));
               MessageTipManager.getInstance().show(param1.pkg.readUTF());
            }
         }
         else
         {
            _loc2_ = param1.pkg.readInt();
            _loc3_ = param1.pkg.readUTF();
            MessageTipManager.getInstance().show(_loc3_);
         }
      }
      
      private function __consortiaPlacardUpdate(param1:PkgEvent) : void
      {
         PlayerManager.Instance.Self.consortiaInfo.Placard = param1.pkg.readUTF();
         var _loc2_:Boolean = param1.pkg.readBoolean();
         var _loc3_:String = param1.pkg.readUTF();
         MessageTipManager.getInstance().show(_loc3_);
      }
      
      private function __renegadeUser(param1:PkgEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         var _loc3_:Boolean = param1.pkg.readBoolean();
         var _loc4_:String = param1.pkg.readUTF();
         MessageTipManager.getInstance().show(_loc4_);
         PlayerManager.Instance.Self.consortiaInfo.StoreLevel = 0;
      }
      
      private function __onConsortiaLevelUp(param1:PkgEvent) : void
      {
         var _loc4_:int = param1.pkg.readByte();
         var _loc2_:int = param1.pkg.readByte();
         var _loc3_:Boolean = param1.pkg.readBoolean();
         var _loc5_:String = param1.pkg.readUTF();
         MessageTipManager.getInstance().show(_loc5_);
         if(_loc3_)
         {
            switch(int(_loc4_) - 1)
            {
               case 0:
                  PlayerManager.Instance.Self.consortiaInfo.Level = _loc2_;
                  break;
               case 1:
                  PlayerManager.Instance.Self.consortiaInfo.StoreLevel = _loc2_;
                  break;
               case 2:
                  PlayerManager.Instance.Self.consortiaInfo.ShopLevel = _loc2_;
                  break;
               case 3:
                  PlayerManager.Instance.Self.consortiaInfo.SmithLevel = _loc2_;
                  break;
               case 4:
                  PlayerManager.Instance.Self.consortiaInfo.BufferLevel = _loc2_;
            }
            dispatchEvent(new Event("event_consortia_level_up"));
         }
      }
      
      private function __oncharmanChange(param1:PkgEvent) : void
      {
         var _loc2_:String = param1.pkg.readUTF();
         var _loc3_:Boolean = param1.pkg.readBoolean();
         var _loc4_:String = param1.pkg.readUTF();
         MessageTipManager.getInstance().show(_loc4_);
      }
      
      private function __consortiaUserUpGrade(param1:PkgEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         var _loc3_:Boolean = param1.pkg.readBoolean();
         var _loc4_:Boolean = param1.pkg.readBoolean();
         var _loc5_:String = param1.pkg.readUTF();
         if(_loc3_)
         {
            if(_loc4_)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.PlayerManager.upsuccess"));
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.PlayerManager.upfalse"));
            }
         }
         else if(_loc4_)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.PlayerManager.downsuccess"));
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.PlayerManager.downfalse"));
         }
      }
      
      private function __consortiaDescriptionUpdate(param1:PkgEvent) : void
      {
         var _loc2_:String = param1.pkg.readUTF();
         var _loc3_:Boolean = param1.pkg.readBoolean();
         var _loc4_:String = param1.pkg.readUTF();
         MessageTipManager.getInstance().show(_loc4_);
         if(_loc3_)
         {
            PlayerManager.Instance.Self.consortiaInfo.Description = _loc2_;
         }
      }
      
      private function __skillChangehandler(param1:PkgEvent) : void
      {
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc6_:* = null;
         var _loc4_:int = 0;
         var _loc5_:int = param1.pkg.readInt();
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc2_ = param1.pkg.readInt();
            _loc3_ = param1.pkg.readBoolean();
            _loc6_ = param1.pkg.readDate();
            _loc4_ = param1.pkg.readInt();
            _model.updateSkillInfo(_loc2_,_loc3_,_loc6_,_loc4_);
            _loc7_++;
         }
         if(_loc5_ > 0)
         {
            getConsortionList(selfConsortionComplete,1,6,PlayerManager.Instance.Self.ConsortiaName,-1,-1,-1,PlayerManager.Instance.Self.ConsortiaID);
         }
         dispatchEvent(new ConsortionEvent("skillStateChange"));
      }
      
      private function __consortiaMailMessage(param1:PkgEvent) : void
      {
         var _loc3_:String = param1.pkg.readUTF();
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc3_,LanguageMgr.GetTranslation("ok"),"",false,true,true,1);
         _loc2_.moveEnable = false;
         _loc2_.addEventListener("response",__quitConsortiaResponse);
         PlayerManager.Instance.Self.consortiaInfo.StoreLevel = 0;
      }
      
      private function __quitConsortiaResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__quitConsortiaResponse);
         _loc2_.dispose();
         _loc2_ = null;
      }
      
      private function setPlayerConsortia(param1:uint = 0, param2:String = "") : void
      {
         PlayerManager.Instance.Self.ConsortiaName = param2;
         PlayerManager.Instance.Self.ConsortiaID = param1;
         if(param1 == 0)
         {
            PlayerManager.Instance.Self.consortiaInfo.Level = 0;
         }
      }
      
      public function memberListComplete(param1:ConsortionMemberAnalyer) : void
      {
         _model.memberList = param1.consortionMember;
         TaskManager.instance.onGuildUpdate();
      }
      
      public function clubSearchConsortions(param1:ConsortionListAnalyzer) : void
      {
         _model.consortionList = param1.consortionList;
         _model.consortionsListTotalCount = Math.ceil(param1.consortionsTotalCount / 6);
      }
      
      public function selfConsortionComplete(param1:ConsortionListAnalyzer) : void
      {
         if(param1.consortionList.length > 0)
         {
            PlayerManager.Instance.Self.consortiaInfo = param1.consortionList[0] as ConsortiaInfo;
         }
      }
      
      public function applyListComplete(param1:ConsortionApplyListAnalyzer) : void
      {
         _model.myApplyList = param1.applyList;
         _model.applyListTotalCount = param1.totalCount;
      }
      
      public function InventListComplete(param1:ConsortionInventListAnalyzer) : void
      {
         _model.inventList = param1.inventList;
         _model.inventListTotalCount = param1.totalCount;
      }
      
      private function levelUpInfoComplete(param1:ConsortionLevelUpAnalyzer) : void
      {
         _model.levelUpData = param1.levelUpData;
      }
      
      public function eventListComplete(param1:ConsortionEventListAnalyzer) : void
      {
         _model.eventList = param1.eventList;
      }
      
      public function useConditionListComplete(param1:ConsortionBuildingUseConditionAnalyer) : void
      {
         _model.useConditionList = param1.useConditionList;
      }
      
      public function dutyListComplete(param1:ConsortionDutyListAnalyzer) : void
      {
         _model.dutyList = param1.dutyList;
      }
      
      public function pollListComplete(param1:ConsortionPollListAnalyzer) : void
      {
         _model.pollList = param1.pollList;
      }
      
      public function skillInfoListComplete(param1:ConsortionSkillInfoAnalyzer) : void
      {
         _model.skillInfoList = param1.skillInfoList;
      }
      
      public function analyzeRichRank(param1:ConsortiaRichRankAnalyze) : void
      {
         _model.richRankList = param1.dataList;
      }
      
      public function analyzeWeekReward(param1:ConsortiaWeekRewardAnalyze) : void
      {
         _model.weekReward = param1.dataList;
      }
      
      public function getConsortionList(param1:Function, param2:int = 1, param3:int = 6, param4:String = "", param5:int = -1, param6:int = -1, param7:int = -1, param8:int = -1) : void
      {
         var _loc9_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc9_["page"] = param2;
         _loc9_["size"] = param3;
         _loc9_["name"] = param4;
         _loc9_["level"] = param7;
         _loc9_["ConsortiaID"] = param8;
         _loc9_["order"] = param5;
         _loc9_["openApply"] = param6;
         var _loc10_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaList.ashx"),7,_loc9_);
         _loc10_.loadErrorMessage = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.LoadMyconsortiaListError");
         _loc10_.analyzer = new ConsortionListAnalyzer(param1);
         LoadResourceManager.Instance.startLoad(_loc10_);
      }
      
      public function getApplyRecordList(param1:Function, param2:int = -1, param3:int = -1) : void
      {
         var _loc4_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc4_["page"] = 1;
         _loc4_["size"] = 1000;
         _loc4_["order"] = -1;
         _loc4_["consortiaID"] = param3;
         _loc4_["applyID"] = -1;
         _loc4_["userID"] = param2;
         _loc4_["userLevel"] = -1;
         var _loc5_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaApplyUsersList.ashx"),6,_loc4_);
         _loc5_.loadErrorMessage = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.LoadApplyRecordError");
         _loc5_.analyzer = new ConsortionApplyListAnalyzer(param1);
         LoadResourceManager.Instance.startLoad(_loc5_);
      }
      
      public function getInviteRecordList(param1:Function) : void
      {
         var _loc2_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc2_["page"] = 1;
         _loc2_["size"] = 1000;
         _loc2_["order"] = -1;
         _loc2_["userID"] = PlayerManager.Instance.Self.ID;
         _loc2_["inviteID"] = -1;
         var _loc3_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaInviteUsersList.ashx"),6,_loc2_);
         _loc3_.loadErrorMessage = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.LoadApplyRecordError");
         _loc3_.analyzer = new ConsortionInventListAnalyzer(param1);
         LoadResourceManager.Instance.startLoad(_loc3_);
      }
      
      public function getConsortionMember(param1:Function = null) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(PlayerManager.Instance.Self.ConsortiaID == 0)
         {
            _model.memberList.clear();
         }
         else
         {
            _loc2_ = RequestVairableCreater.creatWidthKey(true);
            _loc2_["page"] = 1;
            _loc2_["size"] = 10000;
            _loc2_["order"] = -1;
            _loc2_["consortiaID"] = PlayerManager.Instance.Self.ConsortiaID;
            _loc2_["userID"] = -1;
            _loc2_["state"] = -1;
            _loc2_["rnd"] = Math.random();
            _loc3_ = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaUsersList.ashx"),7,_loc2_);
            _loc3_.loadErrorMessage = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.LoadMemberInfoError");
            _loc3_.analyzer = new ConsortionMemberAnalyer(param1);
            LoadResourceManager.Instance.startLoad(_loc3_);
         }
      }
      
      public function getLevelUpInfo() : BaseLoader
      {
         var _loc1_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         var _loc2_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaLevelList.xml"),7,_loc1_);
         _loc2_.loadErrorMessage = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.LoadMyconsortiaLevelError");
         _loc2_.analyzer = new ConsortionLevelUpAnalyzer(levelUpInfoComplete);
         return _loc2_;
      }
      
      public function loadEventList(param1:Function, param2:int = -1) : void
      {
         var _loc3_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc3_["page"] = 1;
         _loc3_["size"] = 50;
         _loc3_["order"] = -1;
         _loc3_["consortiaID"] = param2;
         var _loc4_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaEventList.ashx"),6,_loc3_);
         _loc4_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.consortion.loadEventList.fail");
         _loc4_.analyzer = new ConsortionEventListAnalyzer(param1);
         LoadResourceManager.Instance.startLoad(_loc4_);
      }
      
      public function loadUseConditionList(param1:Function, param2:int = -1) : void
      {
         var _loc3_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc3_["consortiaID"] = param2;
         _loc3_["level"] = -1;
         _loc3_["type"] = -1;
         var _loc4_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaEquipControlList.ashx"),6,_loc3_);
         _loc4_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.consortion.loadUseCondition.fail");
         _loc4_.analyzer = new ConsortionBuildingUseConditionAnalyer(param1);
         LoadResourceManager.Instance.startLoad(_loc4_);
      }
      
      public function loadDutyList(param1:Function, param2:int = -1, param3:int = -1) : void
      {
         var _loc5_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc5_["page"] = 1;
         _loc5_["size"] = 1000;
         _loc5_["ConsortiaID"] = param2;
         _loc5_["order"] = -1;
         _loc5_["dutyID"] = param3;
         var _loc4_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaDutyList.ashx"),6,_loc5_);
         _loc4_.loadErrorMessage = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.LoadDutyListError");
         _loc4_.analyzer = new ConsortionDutyListAnalyzer(param1);
         LoadResourceManager.Instance.startLoad(_loc4_);
      }
      
      public function loadPollList(param1:int) : void
      {
         var _loc2_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc2_["ConsortiaID"] = param1;
         var _loc3_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaCandidateList.ashx"),6,_loc2_);
         _loc3_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.consortion.pollload.error");
         _loc3_.analyzer = new ConsortionPollListAnalyzer(pollListComplete);
         LoadResourceManager.Instance.startLoad(_loc3_);
      }
      
      public function loadSkillInfoList() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaBufferTemp.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.consortion.skillInfo.loadError");
         _loc1_.analyzer = new ConsortionSkillInfoAnalyzer(skillInfoListComplete);
         return _loc1_;
      }
      
      private function __buyBadgeHandler(param1:PkgEvent) : void
      {
         var _loc7_:* = null;
         var _loc6_:PackageIn = param1.pkg;
         var _loc8_:int = _loc6_.readInt();
         var _loc4_:int = _loc6_.readInt();
         var _loc3_:int = _loc6_.readInt();
         var _loc5_:Date = _loc6_.readDate();
         var _loc2_:Boolean = _loc6_.readBoolean();
         if(_loc8_ == PlayerManager.Instance.Self.ConsortiaID)
         {
            PlayerManager.Instance.Self.consortiaInfo.BadgeBuyTime = DateUtils.dateFormat(_loc5_);
            PlayerManager.Instance.Self.consortiaInfo.BadgeID = _loc4_;
            PlayerManager.Instance.Self.consortiaInfo.ValidDate = _loc3_;
            PlayerManager.Instance.Self.badgeID = _loc4_;
            _loc7_ = BadgeInfoManager.instance.getBadgeInfoByID(_loc4_);
            PlayerManager.Instance.Self.consortiaInfo.Riches = PlayerManager.Instance.Self.consortiaInfo.Riches - _loc7_.Cost;
         }
      }
      
      public function getPerRank() : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.UserID = PlayerManager.Instance.Self.ID;
         _loc2_.ConsortiaID = PlayerManager.Instance.Self.ConsortiaID;
         var _loc1_:BaseLoader = LoadResourceManager.Instance.creatAndStartLoad(PathManager.solveRequestPath("ConsortiaWarPlayerRank.ashx"),6,_loc2_);
         _loc1_.analyzer = new PersonalRankAnalyze(perRankPayHander);
      }
      
      private function perRankPayHander(param1:PersonalRankAnalyze) : void
      {
         ConsortionModelManager.Instance.dispatchEvent(new ConsortionEvent("club_per_list",param1.dataList));
      }
      
      public function getConsortionRank() : void
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.creatAndStartLoad(PathManager.solveRequestPath("ConsortiaWarConsortiaRank.ashx"),6);
         _loc1_.analyzer = new ConsortiaAnalyze(ConsortiaRankPayHander);
      }
      
      private function ConsortiaRankPayHander(param1:ConsortiaAnalyze) : void
      {
         ConsortionModelManager.Instance.dispatchEvent(new ConsortionEvent("club_rank_list",param1.dataList));
      }
      
      public function getConsortionTaskRank() : void
      {
         var _loc2_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc2_.ConsortiaID = PlayerManager.Instance.Self.ConsortiaID;
         var _loc1_:BaseLoader = LoadResourceManager.Instance.creatAndStartLoad(PathManager.solveRequestPath("ConsortiaMissionList.ashx"),7,_loc2_);
         _loc1_.analyzer = new ConsortiaTaskRankAnalyzer(ConsortiaTaskRankHander);
      }
      
      private function ConsortiaTaskRankHander(param1:ConsortiaTaskRankAnalyzer) : void
      {
         ConsortionModelManager.Instance.dispatchEvent(new ConsortionEvent("task_rank_list",param1.dataList));
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
      
      public function bossConfigDataSetup(param1:ConsortiaBossDataAnalyzer) : void
      {
         _bossConfigDataList = param1.dataList;
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
      
      public function getCallExtendBossCostRich(param1:int, param2:int = 0) : int
      {
         var _loc3_:* = 0;
         var _loc7_:int = 0;
         var _loc5_:ConsortiaInfo = PlayerManager.Instance.Self.consortiaInfo;
         if(param2 == 0)
         {
            _loc3_ = int(_loc5_.Level + _loc5_.SmithLevel + _loc5_.ShopLevel + _loc5_.StoreLevel + _loc5_.BufferLevel);
         }
         else
         {
            _loc3_ = param2;
         }
         var _loc4_:int = 100001;
         var _loc6_:int = _bossConfigDataList.length;
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            if(_loc3_ >= _bossConfigDataList[_loc7_].level)
            {
               if(param1 == 1)
               {
                  _loc4_ = _bossConfigDataList[_loc7_].callBossRich;
               }
               else
               {
                  _loc4_ = _bossConfigDataList[_loc7_].extendTimeRich;
               }
               _loc7_++;
               continue;
            }
            break;
         }
         return _loc4_;
      }
      
      public function getCallBossCostRich(param1:int) : int
      {
         return _bossConfigDataList[param1 - 1].callBossRich;
      }
      
      public function getCanCallBossMaxLevel(param1:int = 0) : int
      {
         var _loc3_:* = 0;
         var _loc6_:int = 0;
         var _loc4_:ConsortiaInfo = PlayerManager.Instance.Self.consortiaInfo;
         if(param1 == 0)
         {
            _loc3_ = int(_loc4_.Level + _loc4_.SmithLevel + _loc4_.ShopLevel + _loc4_.StoreLevel + _loc4_.BufferLevel);
         }
         else
         {
            _loc3_ = param1;
         }
         var _loc5_:int = _bossConfigDataList.length;
         var _loc2_:int = 1;
         _loc6_ = _loc5_ - 1;
         while(_loc6_ >= 0)
         {
            if(_loc3_ >= _bossConfigDataList[_loc6_].level)
            {
               _loc2_ = _loc6_ + 1;
               break;
            }
            _loc6_--;
         }
         return _loc2_;
      }
      
      public function getRequestCallBossLevel(param1:int) : int
      {
         return _bossConfigDataList[param1 - 1].level;
      }
      
      private function bossOpenCloseHandler(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         var _loc3_:int = _loc2_.readByte();
         if(_loc3_ == 0)
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
         else if(_loc3_ == 3)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortia.bossExtendTipTxt"));
            ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("ddt.consortia.bossExtendTipTxt"));
         }
         else
         {
            isShowBossOpenTip = false;
            isBossOpen = false;
            if(_loc3_ == 1)
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
      
      public function showEnterBtnInHallStateView(param1:IHallStateView) : void
      {
         if(_enterBtn == null)
         {
            _enterBtn = ComponentFactory.Instance.creat("hall.consortia.btn");
         }
         param1.leftTopGbox.addChild(_enterBtn);
         param1.arrangeLeftGrid();
         _enterBtn.addEventListener("click",onEnterBtnClick);
      }
      
      public function hideEnterBtnInHallStateView(param1:IHallStateView) : void
      {
         if(_enterBtn != null && _enterBtn.parent != null)
         {
            param1.leftTopGbox.removeChild(_enterBtn);
            param1.leftTopGbox.arrange();
            _enterBtn.removeEventListener("click",onEnterBtnClick);
         }
         ObjectUtils.disposeObject(_enterBtn);
         _enterBtn = null;
      }
      
      protected function onEnterBtnClick(param1:MouseEvent) : void
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
      
      private function onConSortiaBackAward(param1:PkgEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg;
         var _loc3_:int = _loc4_.readInt();
         var _loc2_:CallBackModel = _model.callBackModel;
         _loc2_.awardStateMap[_loc3_.toString()] = 1;
         dispatchEvent(new Event("event_consortia_back_award"));
      }
      
      private function onConSortiaBackInfo(param1:PkgEvent) : void
      {
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc13_:int = 0;
         var _loc11_:* = null;
         var _loc10_:* = null;
         var _loc9_:int = 0;
         var _loc4_:PackageIn = param1.pkg;
         var _loc7_:CallBackModel = _model.callBackModel;
         _loc7_.startTime = _loc4_.readDate();
         _loc7_.endTime = _loc4_.readDate();
         _loc7_.callBackCount = _loc4_.readInt();
         _loc7_.awardArr = [];
         var _loc14_:int = _loc4_.readInt();
         _loc6_ = 0;
         while(_loc6_ < _loc14_)
         {
            _loc8_ = _loc4_.readInt();
            _loc5_ = _loc4_.readInt();
            _loc2_ = _loc4_.readInt();
            _loc3_ = _loc4_.readInt();
            _loc13_ = _loc4_.readInt();
            _loc11_ = ItemManager.Instance.getTemplateById(_loc5_);
            _loc10_ = new InventoryItemInfo();
            ObjectUtils.copyProperties(_loc10_,_loc11_);
            _loc10_.ValidDate = _loc3_;
            _loc10_.Count = _loc2_;
            _loc10_.IsBinds = true;
            _loc10_.Property5 = "1";
            _loc7_.awardArr.push({
               "itemTemplateInfo":_loc10_,
               "awardID":_loc8_,
               "backCount":_loc13_
            });
            _loc6_++;
         }
         _loc7_.awardStateMap = {};
         var _loc12_:int = _loc4_.readInt();
         _loc6_ = 0;
         while(_loc6_ < _loc12_)
         {
            _loc9_ = _loc4_.readInt();
            _loc7_.awardStateMap[_loc9_] = _loc4_.readInt();
            _loc6_++;
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
      
      private function onConSortionActiveTargetSchedule(param1:PkgEvent) : void
      {
         var _loc3_:int = param1.pkg.readInt();
         var _loc7_:int = param1.pkg.readInt();
         var _loc5_:int = param1.pkg.readInt();
         var _loc2_:int = param1.pkg.readInt();
         var _loc11_:int = 0;
         var _loc10_:* = _model.activeTargetDic;
         for each(var _loc6_ in _model.activeTargetDic)
         {
            var _loc9_:int = 0;
            var _loc8_:* = _loc6_;
            for each(var _loc4_ in _loc6_)
            {
               if(_loc4_.targetId == 1)
               {
                  _loc4_.processValue = _loc3_;
               }
               else if(_loc4_.targetId == 2)
               {
                  _loc4_.processValue = _loc7_;
               }
               else if(_loc4_.targetId == 3)
               {
                  _loc4_.processValue = _loc5_;
               }
               else if(_loc4_.targetId == 4)
               {
                  _loc4_.processValue = _loc2_;
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
      
      public function requestConsortionActiveTagertReward(param1:int) : void
      {
         SocketManager.Instance.out.sendConsortionActiveTagertReward(param1);
      }
      
      private function onConSortionActiveTargetStatus(param1:PkgEvent) : void
      {
         var _loc7_:int = 0;
         var _loc2_:int = param1.pkg.readInt();
         ConsortionModelManager.Instance.model.rewardLv = _loc2_;
         var _loc6_:Vector.<ConsortionActiveTargetData> = null;
         var _loc5_:Boolean = true;
         var _loc4_:* = 0;
         _loc7_ = 1;
         while(_loc7_ <= 3)
         {
            if(_loc7_ <= _loc2_)
            {
               _model.activeTargetStautsDic[_loc7_] = 3;
               _loc4_ = _loc2_;
            }
            else
            {
               _loc6_ = ConsortionModelManager.Instance.model.activeTargetDic[_loc7_];
               var _loc9_:int = 0;
               var _loc8_:* = _loc6_;
               for each(var _loc3_ in _loc6_)
               {
                  if(_loc3_.processValue < _loc3_.conditionValue)
                  {
                     _loc5_ = false;
                     break;
                  }
               }
               if(_loc5_)
               {
                  _model.activeTargetStautsDic[_loc7_] = 2;
                  _loc4_ = _loc7_;
               }
               else if(_loc7_ >= 1 && _loc4_ == _loc7_ - 1)
               {
                  _model.activeTargetStautsDic[_loc7_] = 1;
               }
               else
               {
                  _model.activeTargetStautsDic[_loc7_] = 0;
               }
            }
            _loc7_++;
         }
         ConsortionModelManager.Instance.dispatchEvent(new CEvent("updateActiveTargetStatus"));
      }
      
      public function initConsortionActiveTarget() : void
      {
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         if(_model.hasActiveTargetInited)
         {
            return;
         }
         var _loc4_:String = ServerConfigManager.instance.consortionActiveTarget;
         var _loc2_:Array = _loc4_.split("|");
         var _loc1_:Array = null;
         var _loc3_:ConsortionActiveTargetData = null;
         var _loc6_:Vector.<ConsortionActiveTargetData> = null;
         _loc7_ = 1;
         while(_loc7_ <= _loc2_.length)
         {
            _loc6_ = new Vector.<ConsortionActiveTargetData>();
            _model.activeTargetDic[_loc7_] = _loc6_;
            _loc1_ = String(_loc2_[_loc7_ - 1]).split(",");
            _loc5_ = 1;
            while(_loc5_ <= _loc1_.length)
            {
               _loc3_ = new ConsortionActiveTargetData();
               _loc3_.targetId = _loc5_;
               _loc3_.conditionValue = _loc1_[_loc5_ - 1];
               _loc3_.targetLv = _loc7_;
               _loc6_.push(_loc3_);
               _loc5_++;
            }
            _loc7_++;
         }
         _model.hasActiveTargetInited = true;
      }
      
      public function checkRewardStauts() : Boolean
      {
         var _loc6_:int = 0;
         var _loc1_:int = ConsortionModelManager.Instance.model.rewardLv;
         var _loc5_:Vector.<ConsortionActiveTargetData> = null;
         var _loc2_:int = 0;
         var _loc4_:Boolean = true;
         _loc6_ = 1;
         while(_loc6_ <= 3)
         {
            if(_loc6_ <= _loc1_)
            {
               _loc2_ = _loc2_ + 0;
            }
            else
            {
               _loc5_ = ConsortionModelManager.Instance.model.activeTargetDic[_loc6_];
               var _loc8_:int = 0;
               var _loc7_:* = _loc5_;
               for each(var _loc3_ in _loc5_)
               {
                  if(_loc3_.processValue < _loc3_.conditionValue)
                  {
                     _loc4_ = false;
                     break;
                  }
               }
               if(_loc4_)
               {
                  _loc2_ = _loc2_ + 1;
               }
               else
               {
                  _loc2_ = _loc2_ + 0;
               }
            }
            _loc6_++;
         }
         return _loc2_ > 0;
      }
   }
}
