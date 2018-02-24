package hall
{
   import AvatarCollection.AvatarCollectionManager;
   import AvatarCollection.data.AvatarCollectionUnitVo;
   import Indiana.IndianaDataManager;
   import LanternFestival2015.LanternFestivalManager;
   import LimitAward.LimitAwardButton;
   import academy.AcademyManager;
   import accumulativeLogin.AccumulativeManager;
   import angelInvestment.AngelInvestmentManager;
   import anotherDimension.controller.AnotherDimensionManager;
   import bagAndInfo.BagAndInfoManager;
   import baglocked.BaglockedManager;
   import bank.BankManager;
   import bombKing.BombKingManager;
   import calendar.CalendarManager;
   import campbattle.CampBattleManager;
   import catchbeast.CatchBeastManager;
   import chickActivation.ChickActivationManager;
   import church.view.weddingRoomList.DivorcePromptFrame;
   import cityBattle.CityBattleManager;
   import cloudBuyLottery.CloudBuyLotteryManager;
   import com.pickgliss.action.FunctionAction;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderSavingManager;
   import com.pickgliss.loader.QueueLoader;
   import com.pickgliss.loader.RequestLoader;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.manager.NoviceDataManager;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.GridBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.MD5;
   import com.pickgliss.utils.ObjectUtils;
   import conRecharge.ConRechargeManager;
   import condiscount.CondiscountManager;
   import consortiaDomain.ConsortiaDomainManager;
   import consortion.ConsortionModelManager;
   import consortion.view.selfConsortia.consortiaTask.ConsortiaTaskEvent;
   import consortionBattle.ConsortiaBattleManager;
   import cryptBoss.CryptBossManager;
   import dayActivity.DayActiveData;
   import dayActivity.DayActivityManager;
   import ddt.DDT;
   import ddt.bagStore.BagStore;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.player.SelfInfo;
   import ddt.data.quest.QuestInfo;
   import ddt.events.CEvent;
   import ddt.events.DuowanInterfaceEvent;
   import ddt.events.PkgEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.loader.LoaderCreate;
   import ddt.loader.StartupResourceLoader;
   import ddt.manager.BattleGroudManager;
   import ddt.manager.CSMBoxManager;
   import ddt.manager.ChatManager;
   import ddt.manager.DraftManager;
   import ddt.manager.DuowanInterfaceManage;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.HotSpringManager;
   import ddt.manager.IMManager;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.RecordManager;
   import ddt.manager.RouletteManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddt.manager.VoteManager;
   import ddt.states.BaseStateView;
   import ddt.utils.HelperDataModuleLoad;
   import ddt.utils.PositionUtils;
   import ddt.view.BackgoundView;
   import ddt.view.CallBackFundIcon;
   import ddt.view.CallBackLotteryDrawIcon;
   import ddt.view.DDQiYuanIcon;
   import ddt.view.DailyButtunBar;
   import ddt.view.DrgnBoatEntryBtn;
   import ddt.view.LuckeyLotteryDrawIcon;
   import ddt.view.MainToolBar;
   import ddt.view.NovicePlatinumCard;
   import ddt.view.WonderfulInfoView;
   import ddt.view.chat.ChatData;
   import ddt.view.chat.ChatFormats;
   import ddt.view.chat.ChatView;
   import ddt.view.tips.HallBuildTip;
   import ddtActivityIcon.ActivitStateEvent;
   import ddtActivityIcon.DdtActivityIconManager;
   import ddtActivityIcon.DdtIconTxt;
   import ddtKingLettersCollect.DdtKingLettersCollectManager;
   import ddtKingWay.DDTKingWayManager;
   import defendisland.DefendislandManager;
   import demonChiYou.DemonChiYouManager;
   import dice.DiceManager;
   import dragonBoat.DragonBoatManager;
   import drgnBoatBuild.DrgnBoatBuildManager;
   import escort.EscortEntryBtn;
   import escort.EscortManager;
   import exchangeAct.ExchangeActManager;
   import farm.FarmModelController;
   import firstRecharge.FirstRechargeManger;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.SampleDataEvent;
   import flash.events.TimerEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   import floatParade.FloatParadeIconManager;
   import flowerGiving.FlowerGivingManager;
   import foodActivity.FoodActivityManager;
   import game.GameManager;
   import game.view.stage.StageCurtain;
   import gradeAwardsBoxBtn.GradeAwardsBoxButtonManager;
   import gradeBuy.GradeBuyManager;
   import growthPackage.GrowthPackageManager;
   import gypsyShop.ctrl.GypsyShopManager;
   import gypsyShop.model.GypsyNPCModel;
   import gypsyShop.npcBehavior.GypsyNPCBhvr;
   import hall.hallInfo.HallPlayerInfoView;
   import hall.player.HallPlayerOperateView;
   import hall.player.HallPlayerView;
   import hall.systemPost.SystemPost;
   import hall.tasktrack.HallTaskTrackMainView;
   import hall.tasktrack.HallTaskTrackManager;
   import hallIcon.HallIconManager;
   import hallIcon.view.HallRightIconView;
   import halloween.HalloweenManager;
   import kingBless.KingBlessManager;
   import labyrinth.LabyrinthManager;
   import lanternriddles.LanternRiddlesManager;
   import league.LeagueManager;
   import levelFund.LevelFundManager;
   import littleGame.LittleControl;
   import lotteryTicket.LotteryManager;
   import magicHouse.MagicHouseManager;
   import magicHouse.MagicHouseModel;
   import mainbutton.MainButtnController;
   import midAutumnWorshipTheMoon.WorshipTheMoonManager;
   import mines.MinesManager;
   import nationDay.NationDayManager;
   import newOpenGuide.NewOpenGuideDialogView;
   import newOpenGuide.NewOpenGuideManager;
   import newYearRice.NewYearRiceManager;
   import oldPlayerComeBack.OldPlayerComeBackManager;
   import petsBag.PetsBagManager;
   import petsBag.event.UpdatePetFarmGuildeEvent;
   import prayIndiana.PrayIndianaManager;
   import quest.TaskManager;
   import rewardTask.RewardTaskManager;
   import ringStation.RingStationManager;
   import road7th.StarlingMain;
   import road7th.comm.PackageIn;
   import road7th.utils.MovieClipWrapper;
   import room.RoomManager;
   import roomList.pveRoomList.DungeonListManager;
   import roomList.pvpRoomList.RoomListManager;
   import roulette.LeftGunRouletteManager;
   import roulette.RouletteFrameEvent;
   import sevenDouble.SevenDoubleEntryBtn;
   import sevenDouble.SevenDoubleManager;
   import sevenday.SevendayManager;
   import shop.manager.ShopSaleManager;
   import shop.view.ShopRechargeEquipServer;
   import socialContact.friendBirthday.FriendBirthdayManager;
   import starling.scene.hall.HallScene;
   import starling.scene.hall.StaticLayer;
   import stock.StockMgr;
   import store.StrengthDataManager;
   import times.TimesManager;
   import trainer.controller.NewHandGuideManager;
   import trainer.controller.SystemOpenPromptManager;
   import trainer.controller.WeakGuildManager;
   import trainer.view.NewHandContainer;
   import trainer.view.WelcomeView;
   import treasureHunting.TreasureManager;
   import vip.VipController;
   import wantstrong.WantStrongManager;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.event.WonderfulActivityEvent;
   import worldBossHelper.WorldBossHelperManager;
   import worldboss.WorldBossManager;
   
   public class HallStateView extends BaseStateView implements IHallStateView
   {
      
      public static const MOUSE_ON_GLOW_FILTER:Array = [new GlowFilter(16776960,1,8,8,2,2)];
      
      public static const VIP_LEFT_DAY_TO_COMFIRM:int = 3;
      
      public static const VIP_LEFT_DAY_FIRST_PROMPT:int = 7;
      
      public static const BUILDNUM:int = 6;
      
      public static var SoundIILoaded:Boolean = false;
      
      public static var SoundILoaded:Boolean = false;
      
      private static var _firstLoadTimes:Boolean = true;
      
      public static var IsMaster:Boolean = false;
      
      private static var snd:Sound;
      
      private static var sndCh:SoundChannel;
       
      
      private var _black:Shape;
      
      private var _playerInfoView:HallPlayerInfoView;
      
      private var _playerOperateView:HallPlayerOperateView;
      
      private var _bgSprite:Sprite;
      
      private var _OpenAuction:MovieClip;
      
      private var _chatView:ChatView;
      
      private var _btnList:Array;
      
      private var _btnTipList:Array;
      
      private var _btnID:int = -1;
      
      private var _eventActives:Array;
      
      private var _isIMController:Boolean;
      
      private var _renewal:BaseAlerFrame;
      
      private var _isAddFrameComplete:Boolean = false;
      
      private var _littleGameNote:MovieClip;
      
      private var _txtArray:Array;
      
      private var _selfPosArray:Array;
      
      private var _btnArray:Array;
      
      private var _notFilter:Array;
      
      private var _shine:Vector.<MovieClipWrapper>;
      
      private var _hallRightIconView:HallRightIconView;
      
      private var _leftTopGbox:GridBox;
      
      private var _limitAwardButton:LimitAwardButton;
      
      private var _activityIcon:MovieImage;
      
      private var _signBtnContainer:Sprite;
      
      private var _goSignBtn:MovieClip;
      
      private var _awardBtn:MovieClip;
      
      private var _firstRechargeBtn:SimpleBitmapButton;
      
      private var _angelblessIcon:MovieClip;
      
      private var _signShineEffect:IEffect;
      
      private var startDate:Date;
      
      private var endDate:Date;
      
      private var isActiv:Boolean;
      
      private var isInLuckStone:Boolean;
      
      private var _newChickenBoxBtn:MovieClip;
      
      private var _timer:Timer;
      
      private var _wantStrongBtn:MovieImage;
      
      private var _expValue:int;
      
      private var _isShowWonderfulActTip1:Boolean;
      
      private var _isShowWonderfulActTip2:Boolean;
      
      private var _ringStationClickDate:Number = 0;
      
      private var _catchBeastBtn:MovieImage;
      
      private var _nationDayBtn:MovieImage;
      
      private var _lanternRiddles:DdtIconTxt;
      
      private var _rescueBtn:MovieClip;
      
      private var _draftBtn:BaseButton;
      
      private var _polarRegionBtn:BaseButton;
      
      private var _survivalBtn:BaseButton;
      
      private var _pyramidBtn:BaseButton;
      
      private var _treasureBtn:BaseButton;
      
      private var _christmas_Icon:Sprite;
      
      private var _flowerGivingIcon:MovieImage;
      
      private var _escortEntryBtn:EscortEntryBtn;
      
      private var _playerView:hall.player.HallPlayerView;
      
      private var _taskTrackMainView:HallTaskTrackMainView;
      
      private var _sevenDoubleBtn:SevenDoubleEntryBtn;
      
      private var _drgnBoatEntryBtn:DrgnBoatEntryBtn;
      
      private var _catchInsectIcon:Sprite;
      
      private var _ddQiYuanActivityIcon:DDQiYuanIcon;
      
      private var _callBackFundIcon:CallBackFundIcon;
      
      private var _callBackLotteryDrawIcon:CallBackLotteryDrawIcon;
      
      private var _luckeyLotteryDrawIcon:LuckeyLotteryDrawIcon;
      
      private var _panicBuyingIcon:Sprite;
      
      private var _wishingTreeIcon:MovieClip;
      
      private var _lastCreatTime:int;
      
      private var _systemPost:SystemPost;
      
      private var _LevelIcon:Bitmap;
      
      public var starlingHallScene:HallScene;
      
      private var _isShowActTipDic:Dictionary;
      
      private var _needShowOpenTipActArr:Array;
      
      private var _needShowAwardTipActArr:Array;
      
      private var _offsetTopHbox:Number = 50;
      
      private var _lastClickTime:Number;
      
      private var _trainerWelcomeView:WelcomeView;
      
      private var _PopWelcomeDisplayed:Boolean = false;
      
      private var _dialog:NewOpenGuideDialogView;
      
      private var _battleFrame:Frame;
      
      private var _battlePanel:ScrollPanel;
      
      private var _battleImg:Bitmap;
      
      private var _battleBtn:TextButton;
      
      private var _isFirst:Boolean;
      
      private var _leagueBtn:MovieClip;
      
      private var _campBtn:MovieClip;
      
      private var infos:Array;
      
      public function HallStateView(){super();}
      
      private static function onSampleDataHandler(param1:SampleDataEvent) : void{}
      
      override public function set x(param1:Number) : void{}
      
      private function initEvent() : void{}
      
      private function onKeyUp(param1:KeyboardEvent) : void{}
      
      protected function __labyrinthChat(param1:Event) : void{}
      
      private function __getLuckStoneEnable(param1:PkgEvent) : void{}
      
      private function _checkActivityPer(param1:TimerEvent) : void{}
      
      private function _checkLimit() : void{}
      
      override public function getType() : String{return null;}
      
      override public function getBackType() : String{return null;}
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void{}
      
      protected function __consortiaResponse(param1:PkgEvent) : void{}
      
      protected function __renegadeUser(param1:PkgEvent) : void{}
      
      protected function __getTaskInfo(param1:ConsortiaTaskEvent) : void{}
      
      private function checkConsortionTask() : void{}
      
      private function __onHallLoadComplete(param1:UIModuleEvent) : void{}
      
      private function initHall() : void{}
      
      private function addAccumulativeLoginAct() : void{}
      
      private function defaultRightWonderfulPlayIconShow() : void{}
      
      private function defaultRightActivityIconShow() : void{}
      
      private function showDiceBtn(param1:Boolean = false) : void{}
      
      private function checkIsMaster() : void{}
      
      private function hideGuideNpc() : void{}
      
      private function __checkAvatarCollectionTime(param1:Event) : void{}
      
      private function showFrame() : void{}
      
      private function __propertyChange(param1:PlayerPropertyEvent) : void{}
      
      private function createBuildBtn() : void{}
      
      private function createNpcBtn() : void{}
      
      private function initBuild() : void{}
      
      public function setNPCBtnEnable(param1:Component, param2:Boolean) : void{}
      
      private function setBuildState(param1:int, param2:Boolean, param3:Boolean = false) : void{}
      
      private function __btnOver(param1:MouseEvent) : void{}
      
      protected function setCharacterFilter(param1:int, param2:Boolean) : void{}
      
      private function __btnOut(param1:MouseEvent) : void{}
      
      private function onOutEffect(param1:int) : void{}
      
      private function __onFightFlag(param1:PkgEvent) : void{}
      
      private function ringStationShow() : void{}
      
      private function showCryptBossFrame() : void{}
      
      private function __checkShowWonderfulActivityTip(param1:WonderfulActivityEvent) : void{}
      
      private function checkShowActTip() : void{}
      
      private function createActAwardChat() : void{}
      
      private function initDdtActiviyIconState() : void{}
      
      private function removeDdtActiviyIconState() : void{}
      
      private function readyHander(param1:ActivitStateEvent) : void{}
      
      private function startHander(param1:ActivitStateEvent) : void{}
      
      private function changeIconState(param1:Array, param2:Boolean = false) : void{}
      
      private function campBtnHander(param1:MouseEvent) : void{}
      
      private function stopAllMc(param1:MovieClip) : void{}
      
      private function playAllMc(param1:MovieClip) : void{}
      
      private function updateWantStrong() : void{}
      
      private function isPassBoss(param1:Dictionary, param2:Array, param3:int) : Boolean{return false;}
      
      protected function __alreadyUpdateTimeHandler(param1:Event) : void{}
      
      private function checkWantStrongFindBack() : void{}
      
      private function __alreadyFindBackHandler(param1:Event) : void{}
      
      private function isOnceFindBack(param1:Dictionary) : Boolean{return false;}
      
      private function isFindBack(param1:Dictionary, param2:int) : Boolean{return false;}
      
      private function isBeatBoss(param1:int) : Boolean{return false;}
      
      private function isPass(param1:Dictionary, param2:Array, param3:int) : Boolean{return false;}
      
      private function compareDay(param1:int, param2:String) : Boolean{return false;}
      
      private function compareDate(param1:Date, param2:int, param3:int) : Boolean{return false;}
      
      private function wantStrongtnHandler(param1:MouseEvent) : void{}
      
      private function addLeagueIcon(param1:Boolean = false, param2:String = null) : void{}
      
      private function deleLeagueBtn() : void{}
      
      private function addBattleIcon(param1:Boolean = false, param2:String = "") : void{}
      
      private function delBattleIcon() : void{}
      
      private function initLimitActivityIcon() : void{}
      
      private function deleteLimitActivityIcon() : void{}
      
      private function leagueBtnHander(param1:MouseEvent) : void{}
      
      private function addButtonList() : void{}
      
      public function arrangeLeftGrid() : void{}
      
      public function hideRightGrid() : void{}
      
      public function showRightGrid() : void{}
      
      private function openWonderfulActivityView(param1:MouseEvent) : void{}
      
      private function checkLuckStone() : Boolean{return false;}
      
      private function initAngelbless() : void{}
      
      protected function openFristrechargeView(param1:MouseEvent) : void{}
      
      private function __onSignClick(param1:MouseEvent) : void{}
      
      private function initAward() : void{}
      
      private function __OpenView(param1:MouseEvent) : void{}
      
      private function __openActivityView(param1:Event) : void{}
      
      private function __iconClose(param1:Event) : void{}
      
      private function __updatePetFarmGuilde(param1:UpdatePetFarmGuildeEvent) : void{}
      
      private function __OpenVipView(param1:MouseEvent) : void{}
      
      private function __OpenBlessView(param1:Event) : void{}
      
      private function petFarmGuilde() : void{}
      
      private function __leftGunShow(param1:RouletteFrameEvent) : void{}
      
      private function __onAudioLoadComplete(param1:Event) : void{}
      
      private function __littlegameActived(param1:Event = null, param2:Boolean = false, param3:String = null) : void{}
      
      private function __OpenlittleGame(param1:MouseEvent) : void{}
      
      private function addFrame() : void{}
      
      private function loadWeakGuild() : void{}
      
      private function __taskFrameHide(param1:Event) : void{}
      
      private function checkShowVote() : void{}
      
      private function sevendoubleEndHandler(param1:Event) : void{}
      
      private function sevenDoubleIconResLoadComplete(param1:Event) : void{}
      
      private function escortEndHandler(param1:Event) : void{}
      
      private function escortIconResLoadComplete(param1:Event) : void{}
      
      private function checkShowVipAlert() : void{}
      
      private function checkShowVipAlert_New() : void{}
      
      private function __goRenewal(param1:FrameEvent) : void{}
      
      private function __vote(param1:Event) : void{}
      
      private function checkShowStoreFromShop() : void{}
      
      private function toFightLib() : void{}
      
      private function toDungeon() : void{}
      
      private function __btnClick(param1:MouseEvent) : void{}
      
      public function __onBtnClick() : void{}
      
      private function gotoConsortia() : void{}
      
      public function showWonderfulView() : void{}
      
      private function loadUserGuide() : void{}
      
      private function sendToLoginInterface() : void{}
      
      private function prePopWelcome() : void{}
      
      private function __trainerResponse(param1:FrameEvent) : void{}
      
      private function exePopWelcome() : Boolean{return false;}
      
      private function finPopWelcome() : void{}
      
      private function dialogNextHandler(param1:MouseEvent) : void{}
      
      private function dialogNextHandler2(param1:MouseEvent) : void{}
      
      private function createBattle() : void{}
      
      private function showSPAAlert() : void{}
      
      private function __onRespose(param1:FrameEvent) : void{}
      
      private function __battleBtnClick(param1:MouseEvent) : void{}
      
      private function battleFrameClose() : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      override public function leaving(param1:BaseStateView) : void{}
      
      override public function prepare() : void{}
      
      override public function fadingComplete() : void{}
      
      private function showBuildOpen(param1:int, param2:String) : void{}
      
      private function __completeGameRoom(param1:Event) : void{}
      
      private function __completeConsortia(param1:Event) : void{}
      
      private function __completeDungeon(param1:Event) : void{}
      
      private function __completeChurch(param1:Event) : void{}
      
      private function __completeToffList(param1:Event) : void{}
      
      private function __completeAuction(param1:Event) : void{}
      
      private function __onClickServerName(param1:MouseEvent) : void{}
      
      private function buildShine(param1:int, param2:String, param3:String) : void{}
      
      override public function refresh() : void{}
      
      private function checkShowWorldBossEntrance() : void{}
      
      private function checkGuide() : void{}
      
      private function checkHorseAmuletGuide() : void{}
      
      private function checkShowWorldBossHelper() : void{}
      
      public function setBgSpriteCenter(param1:int, param2:int) : void{}
      
      public function get ringStationClickDate() : Number{return 0;}
      
      public function get leftTopGbox() : GridBox{return null;}
      
      public function get bgSprite() : Sprite{return null;}
   }
}
