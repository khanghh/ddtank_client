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
      
      public function ConsortionModelManager(){super();}
      
      public static function get Instance() : ConsortionModelManager{return null;}
      
      public function get model() : ConsortionModel{return null;}
      
      public function get TaskModel() : ConsortiaTaskModel{return null;}
      
      public function setup() : void{}
      
      private function addEvent() : void{}
      
      protected function onTaskInfoChange(param1:ConsortiaTaskEvent) : void{}
      
      protected function onTaskTimerTimer(param1:Event) : void{}
      
      private function __consortiaResponse(param1:PkgEvent) : void{}
      
      private function consortiaUpLevel(param1:int, param2:int, param3:String, param4:int) : void{}
      
      private function updateDutyInfo(param1:int, param2:String, param3:int) : void{}
      
      private function upDateSelfDutyInfo(param1:int, param2:String, param3:int) : void{}
      
      private function updateConsortiaMemberDuty(param1:int, param2:int, param3:String, param4:int) : void{}
      
      private function removeConsortiaMember(param1:int, param2:Boolean, param3:String) : void{}
      
      private function __enterConsortiaConfirm(param1:FrameEvent) : void{}
      
      private function accpetConsortiaInvent() : void{}
      
      private function rejectConsortiaInvent() : void{}
      
      private function __givceOffer(param1:PkgEvent) : void{}
      
      private function __onConsortiaEquipControl(param1:PkgEvent) : void{}
      
      private function __consortiaTryIn(param1:PkgEvent) : void{}
      
      private function __tryInDel(param1:PkgEvent) : void{}
      
      private function __consortiaTryInPass(param1:PkgEvent) : void{}
      
      private function __consortiaInvate(param1:PkgEvent) : void{}
      
      private function __consortiaInvitePass(param1:PkgEvent) : void{}
      
      private function __consortiaCreate(param1:PkgEvent) : void{}
      
      private function __consortiaDisband(param1:PkgEvent) : void{}
      
      private function __consortiaPlacardUpdate(param1:PkgEvent) : void{}
      
      private function __renegadeUser(param1:PkgEvent) : void{}
      
      private function __onConsortiaLevelUp(param1:PkgEvent) : void{}
      
      private function __oncharmanChange(param1:PkgEvent) : void{}
      
      private function __consortiaUserUpGrade(param1:PkgEvent) : void{}
      
      private function __consortiaDescriptionUpdate(param1:PkgEvent) : void{}
      
      private function __skillChangehandler(param1:PkgEvent) : void{}
      
      private function __consortiaMailMessage(param1:PkgEvent) : void{}
      
      private function __quitConsortiaResponse(param1:FrameEvent) : void{}
      
      private function setPlayerConsortia(param1:uint = 0, param2:String = "") : void{}
      
      public function memberListComplete(param1:ConsortionMemberAnalyer) : void{}
      
      public function clubSearchConsortions(param1:ConsortionListAnalyzer) : void{}
      
      public function selfConsortionComplete(param1:ConsortionListAnalyzer) : void{}
      
      public function applyListComplete(param1:ConsortionApplyListAnalyzer) : void{}
      
      public function InventListComplete(param1:ConsortionInventListAnalyzer) : void{}
      
      private function levelUpInfoComplete(param1:ConsortionLevelUpAnalyzer) : void{}
      
      public function eventListComplete(param1:ConsortionEventListAnalyzer) : void{}
      
      public function useConditionListComplete(param1:ConsortionBuildingUseConditionAnalyer) : void{}
      
      public function dutyListComplete(param1:ConsortionDutyListAnalyzer) : void{}
      
      public function pollListComplete(param1:ConsortionPollListAnalyzer) : void{}
      
      public function skillInfoListComplete(param1:ConsortionSkillInfoAnalyzer) : void{}
      
      public function analyzeRichRank(param1:ConsortiaRichRankAnalyze) : void{}
      
      public function analyzeWeekReward(param1:ConsortiaWeekRewardAnalyze) : void{}
      
      public function getConsortionList(param1:Function, param2:int = 1, param3:int = 6, param4:String = "", param5:int = -1, param6:int = -1, param7:int = -1, param8:int = -1) : void{}
      
      public function getApplyRecordList(param1:Function, param2:int = -1, param3:int = -1) : void{}
      
      public function getInviteRecordList(param1:Function) : void{}
      
      public function getConsortionMember(param1:Function = null) : void{}
      
      public function getLevelUpInfo() : BaseLoader{return null;}
      
      public function loadEventList(param1:Function, param2:int = -1) : void{}
      
      public function loadUseConditionList(param1:Function, param2:int = -1) : void{}
      
      public function loadDutyList(param1:Function, param2:int = -1, param3:int = -1) : void{}
      
      public function loadPollList(param1:int) : void{}
      
      public function loadSkillInfoList() : BaseLoader{return null;}
      
      private function __buyBadgeHandler(param1:PkgEvent) : void{}
      
      public function getPerRank() : void{}
      
      private function perRankPayHander(param1:PersonalRankAnalyze) : void{}
      
      public function getConsortionRank() : void{}
      
      private function ConsortiaRankPayHander(param1:ConsortiaAnalyze) : void{}
      
      public function getConsortionTaskRank() : void{}
      
      private function ConsortiaTaskRankHander(param1:ConsortiaTaskRankAnalyzer) : void{}
      
      public function alertTaxFrame() : void{}
      
      public function alertRedPackageFrame() : void{}
      
      public function alertManagerFrame() : void{}
      
      public function rankFrame() : void{}
      
      public function alertShopFrame() : void{}
      
      public function alertBankFrame() : void{}
      
      public function hideBankFrame() : void{}
      
      public function clearReference() : void{}
      
      public function alertTakeInFrame() : void{}
      
      public function alertQuitFrame() : void{}
      
      public function bossConfigDataSetup(param1:ConsortiaBossDataAnalyzer) : void{}
      
      public function get bossMaxLv() : int{return 0;}
      
      public function get bossCallCondition() : int{return 0;}
      
      public function getCallExtendBossCostRich(param1:int, param2:int = 0) : int{return 0;}
      
      public function getCallBossCostRich(param1:int) : int{return 0;}
      
      public function getCanCallBossMaxLevel(param1:int = 0) : int{return 0;}
      
      public function getRequestCallBossLevel(param1:int) : int{return 0;}
      
      private function bossOpenCloseHandler(param1:PkgEvent) : void{}
      
      public function showEnterBtnInHallStateView(param1:IHallStateView) : void{}
      
      public function hideEnterBtnInHallStateView(param1:IHallStateView) : void{}
      
      protected function onEnterBtnClick(param1:MouseEvent) : void{}
      
      private function gotoConsortia() : void{}
      
      public function openBossFrame() : void{}
      
      private function onConSortiaBackAward(param1:PkgEvent) : void{}
      
      private function onConSortiaBackInfo(param1:PkgEvent) : void{}
      
      public function enterConsortiaState() : void{}
      
      public function requestSortionActiveTargetSchedule() : void{}
      
      private function onConSortionActiveTargetSchedule(param1:PkgEvent) : void{}
      
      public function requestConsortionActiveTagertStatus() : void{}
      
      public function requestConsortionActiveTagertReward(param1:int) : void{}
      
      private function onConSortionActiveTargetStatus(param1:PkgEvent) : void{}
      
      public function initConsortionActiveTarget() : void{}
      
      public function checkRewardStauts() : Boolean{return false;}
   }
}
