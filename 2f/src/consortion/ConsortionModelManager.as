package consortion{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ComponentSetting;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.utils.ObjectUtils;   import consortion.analyze.ConsortiaAnalyze;   import consortion.analyze.ConsortiaBossDataAnalyzer;   import consortion.analyze.ConsortiaRichRankAnalyze;   import consortion.analyze.ConsortiaTaskRankAnalyzer;   import consortion.analyze.ConsortiaWeekRewardAnalyze;   import consortion.analyze.ConsortionApplyListAnalyzer;   import consortion.analyze.ConsortionBuildingUseConditionAnalyer;   import consortion.analyze.ConsortionDutyListAnalyzer;   import consortion.analyze.ConsortionEventListAnalyzer;   import consortion.analyze.ConsortionInventListAnalyzer;   import consortion.analyze.ConsortionLevelUpAnalyzer;   import consortion.analyze.ConsortionListAnalyzer;   import consortion.analyze.ConsortionMemberAnalyer;   import consortion.analyze.ConsortionPollListAnalyzer;   import consortion.analyze.ConsortionSkillInfoAnalyzer;   import consortion.analyze.PersonalRankAnalyze;   import consortion.data.BadgeInfo;   import consortion.data.CallBackModel;   import consortion.data.ConsortiaAssetLevelOffer;   import consortion.data.ConsortionActiveTargetData;   import consortion.event.ConsortionEvent;   import consortion.view.selfConsortia.consortiaTask.ConsortiaTaskEvent;   import consortion.view.selfConsortia.consortiaTask.ConsortiaTaskInfo;   import consortion.view.selfConsortia.consortiaTask.ConsortiaTaskModel;   import ddt.data.ConsortiaInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.data.player.ConsortiaPlayerInfo;   import ddt.data.player.PlayerState;   import ddt.events.CEvent;   import ddt.events.PkgEvent;   import ddt.loader.LoaderCreate;   import ddt.manager.BadgeInfoManager;   import ddt.manager.ChatManager;   import ddt.manager.ExternalInterfaceManager;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.ServerManager;   import ddt.manager.SharedManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.manager.TimeManager;   import ddt.utils.HelperDataModuleLoad;   import ddt.utils.RequestVairableCreater;   import email.MailManager;   import flash.display.InteractiveObject;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.MouseEvent;   import flash.net.URLVariables;   import flash.text.TextField;   import hall.IHallStateView;   import quest.TaskManager;   import redPackage.RedPackageManager;   import road7th.comm.PackageIn;   import road7th.utils.DateUtils;   import road7th.utils.StringHelper;   import times.utils.timerManager.TimerJuggler;   import times.utils.timerManager.TimerManager;   import trainer.controller.SystemOpenPromptManager;   import trainer.controller.WeakGuildManager;      public class ConsortionModelManager extends EventDispatcher   {            public static const ALERT_RED_PACKAGE:String = "cmctrl_alert_redpackage";            public static const ALERT_TAX:String = "cmctrl_alert_tax";            public static const ALERT_MANAGER:String = "cmctrl_alert_manager";            public static const RANK:String = "cmctrl_rank";            public static const ALERT_SHOP:String = "cmctrl_alert_shop";            public static const ALERT_BANK:String = "cmctrl_alert_bank";            public static const HIDE_BANK:String = "cmctrl_hide_bank";            public static const ALERT_TAKEIN:String = "cmctrl_alert_takein";            public static const ALERT_QUIT:String = "cmctrl_alert_quit";            public static const OPEN_BOSS:String = "cmctrl_open_boss";            public static const CLEAR_REFERENCE:String = "cmctrl_clear_reference";            public static const EVENT_CONSORTIA_BACK_INFO:String = "event_consortia_back_info";            public static const EVENT_CONSORTIA_BACK_AWARD:String = "event_consortia_back_award";            public static const EVENT_CONSORTIA_LEVEL_UP:String = "event_consortia_level_up";            public static const LEAVE_CALL_BACK_VIEW:String = "leave_call_back_view";            private static var _instance:ConsortionModelManager;                   private var _model:ConsortionModel;            private var _taskModel:ConsortiaTaskModel;            private var _timer:TimerJuggler;            private var _alertFlagList:Array;            private var _alertStatusList:Array;            private var _alertMsgList:Array;            private var _firstShow:Boolean = true;            private var str:String;            private var _invateID:int;            private var _enterConfirm:BaseAlerFrame;            private var _bossConfigDataList:Array;            public var isShowBossOpenTip:Boolean = false;            public var isBossOpen:Boolean = false;            private var _enterBtn:SimpleBitmapButton;            public var isClickConsortionBuyGiftTask:Boolean;            public function ConsortionModelManager() { super(); }
            public static function get Instance() : ConsortionModelManager { return null; }
            public function get model() : ConsortionModel { return null; }
            public function get TaskModel() : ConsortiaTaskModel { return null; }
            public function setup() : void { }
            private function addEvent() : void { }
            protected function onTaskInfoChange(e:ConsortiaTaskEvent) : void { }
            protected function onTaskTimerTimer(e:Event) : void { }
            private function __consortiaResponse(event:PkgEvent) : void { }
            private function consortiaUpLevel(type:int, id:int, name:String, level:int) : void { }
            private function updateDutyInfo(dutyLevel:int, dutyName:String, right:int) : void { }
            private function upDateSelfDutyInfo(dutyLevel:int, dutyName:String, right:int) : void { }
            private function updateConsortiaMemberDuty(playerId:int, dutyLevel:int, dutyName:String, right:int) : void { }
            private function removeConsortiaMember(id:int, isKick:Boolean, kickName:String) : void { }
            private function __enterConsortiaConfirm(evt:FrameEvent) : void { }
            private function accpetConsortiaInvent() : void { }
            private function rejectConsortiaInvent() : void { }
            private function __givceOffer(e:PkgEvent) : void { }
            private function __onConsortiaEquipControl(evt:PkgEvent) : void { }
            private function __consortiaTryIn(evt:PkgEvent) : void { }
            private function __tryInDel(evt:PkgEvent) : void { }
            private function __consortiaTryInPass(e:PkgEvent) : void { }
            private function __consortiaInvate(evt:PkgEvent) : void { }
            private function __consortiaInvitePass(evt:PkgEvent) : void { }
            private function __consortiaCreate(evt:PkgEvent) : void { }
            private function __consortiaDisband(evt:PkgEvent) : void { }
            private function __consortiaPlacardUpdate(evt:PkgEvent) : void { }
            private function __renegadeUser(e:PkgEvent) : void { }
            private function __onConsortiaLevelUp(e:PkgEvent) : void { }
            private function __oncharmanChange(e:PkgEvent) : void { }
            private function __consortiaUserUpGrade(e:PkgEvent) : void { }
            private function __consortiaDescriptionUpdate(evt:PkgEvent) : void { }
            private function __skillChangehandler(evt:PkgEvent) : void { }
            private function __consortiaMailMessage(evt:PkgEvent) : void { }
            private function __quitConsortiaResponse(evt:FrameEvent) : void { }
            private function setPlayerConsortia(id:uint = 0, name:String = "") : void { }
            public function memberListComplete(analyzer:ConsortionMemberAnalyer) : void { }
            public function clubSearchConsortions(anlyzer:ConsortionListAnalyzer) : void { }
            public function selfConsortionComplete(anlyzer:ConsortionListAnalyzer) : void { }
            public function applyListComplete(anlyzer:ConsortionApplyListAnalyzer) : void { }
            public function InventListComplete(anlyzer:ConsortionInventListAnalyzer) : void { }
            private function levelUpInfoComplete(anlyzer:ConsortionLevelUpAnalyzer) : void { }
            public function eventListComplete(anlyzer:ConsortionEventListAnalyzer) : void { }
            public function useConditionListComplete(anlyzer:ConsortionBuildingUseConditionAnalyer) : void { }
            public function dutyListComplete(anlyzer:ConsortionDutyListAnalyzer) : void { }
            public function pollListComplete(anlyzer:ConsortionPollListAnalyzer) : void { }
            public function skillInfoListComplete(anlyzer:ConsortionSkillInfoAnalyzer) : void { }
            public function analyzeRichRank(e:ConsortiaRichRankAnalyze) : void { }
            public function analyzeWeekReward(e:ConsortiaWeekRewardAnalyze) : void { }
            public function getConsortionList(callBackFun:Function, page:int = 1, size:int = 6, name:String = "", order:int = -1, openApply:int = -1, level:int = -1, ConsortiaID:int = -1) : void { }
            public function getApplyRecordList(callBackFun:Function, playerID:int = -1, consortiaID:int = -1) : void { }
            public function getInviteRecordList(callBackFun:Function) : void { }
            public function getConsortionMember(callBackFun:Function = null) : void { }
            public function getLevelUpInfo() : BaseLoader { return null; }
            public function loadEventList(callBackFun:Function, consortiaID:int = -1) : void { }
            public function loadUseConditionList(callBackFun:Function, consortionID:int = -1) : void { }
            public function loadDutyList(callBackFun:Function, consortiaID:int = -1, dutyID:int = -1) : void { }
            public function loadPollList(consortionID:int) : void { }
            public function loadSkillInfoList() : BaseLoader { return null; }
            private function __buyBadgeHandler(event:PkgEvent) : void { }
            public function getPerRank() : void { }
            private function perRankPayHander(analyze:PersonalRankAnalyze) : void { }
            public function getConsortionRank() : void { }
            private function ConsortiaRankPayHander(analyze:ConsortiaAnalyze) : void { }
            public function getConsortionTaskRank() : void { }
            private function ConsortiaTaskRankHander(analyze:ConsortiaTaskRankAnalyzer) : void { }
            public function alertTaxFrame() : void { }
            public function alertRedPackageFrame() : void { }
            public function alertManagerFrame() : void { }
            public function rankFrame() : void { }
            public function alertShopFrame() : void { }
            public function alertBankFrame() : void { }
            public function hideBankFrame() : void { }
            public function clearReference() : void { }
            public function alertTakeInFrame() : void { }
            public function alertQuitFrame() : void { }
            public function bossConfigDataSetup(analyzer:ConsortiaBossDataAnalyzer) : void { }
            public function get bossMaxLv() : int { return 0; }
            public function get bossCallCondition() : int { return 0; }
            public function getCallExtendBossCostRich(type:int, totalLevel:int = 0) : int { return 0; }
            public function getCallBossCostRich(level:int) : int { return 0; }
            public function getCanCallBossMaxLevel(totalLevel:int = 0) : int { return 0; }
            public function getRequestCallBossLevel(level:int) : int { return 0; }
            private function bossOpenCloseHandler(event:PkgEvent) : void { }
            public function showEnterBtnInHallStateView($parent:IHallStateView) : void { }
            public function hideEnterBtnInHallStateView($parent:IHallStateView) : void { }
            protected function onEnterBtnClick(e:MouseEvent) : void { }
            private function gotoConsortia() : void { }
            public function openBossFrame() : void { }
            private function onConSortiaBackAward(event:PkgEvent) : void { }
            private function onConSortiaBackInfo(event:PkgEvent) : void { }
            public function enterConsortiaState() : void { }
            public function requestSortionActiveTargetSchedule() : void { }
            private function onConSortionActiveTargetSchedule(pkg:PkgEvent) : void { }
            public function requestConsortionActiveTagertStatus() : void { }
            public function requestConsortionActiveTagertReward(lv:int) : void { }
            private function onConSortionActiveTargetStatus(pkg:PkgEvent) : void { }
            public function initConsortionActiveTarget() : void { }
            public function checkRewardStauts() : Boolean { return false; }
   }}