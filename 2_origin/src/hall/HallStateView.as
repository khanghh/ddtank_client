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
      
      public function HallStateView()
      {
         _txtArray = ["txt_dungeon_mc","txt_roomList_mc","txt_Labyrinth_mc","txt_home_mc","txt_ringstation_mc","txt_cryptBoss_mc","txt_church_mc"];
         _selfPosArray = [new Point(1684,395),new Point(2129,400),new Point(2981,399),new Point(3218,356),new Point(3595,368),new Point(3499,513),new Point(2785,407),new Point(229,430),new Point(1156,430),new Point(1891,430),new Point(1488,430),new Point(2405,414),new Point(763,430),new Point(629,430),new Point(472,430),new Point(900,472),new Point(935,472),new Point(1057,430),new Point(1200,430),new Point(1330,410),new Point(3364,396)];
         _btnArray = ["dungeon","roomList","labyrinth","home","ringStation","cryptBoss","church","gypsy","guide","constrion","store","auction","redPlatform","bluePlatform","goldPlatform","drgnBoatBuilding","laurel","magicHouse","hotspring","poster"];
         _notFilter = [];
         _needShowOpenTipActArr = [18,19,25,24,41,17];
         _needShowAwardTipActArr = [18,19,25,24,30,33,28,26,35,41,36,32,29,27,31,34,38,37,39,17];
         super();
         try
         {
            WeakGuildManager.Instance.timeStatistics(0,getDefinitionByName("DDT_Loading").time);
            if(PathManager.isStatistics)
            {
               WeakGuildManager.Instance.statistics(3,getDefinitionByName("DDT_Loading").time);
            }
         }
         catch(e:Error)
         {
            trace(e.message);
         }
         initEvent();
      }
      
      private static function onSampleDataHandler(param1:SampleDataEvent) : void
      {
         var _loc2_:int = 16384;
         param1.data.length = _loc2_;
         param1.data.position = _loc2_;
      }
      
      override public function set x(param1:Number) : void
      {
         .super.x = param1;
      }
      
      private function initEvent() : void
      {
         _timer = new Timer(1000);
         _timer.addEventListener("timer",_checkActivityPer);
         LabyrinthManager.Instance.addEventListener("LabyrinthChat",__labyrinthChat);
      }
      
      private function onKeyUp(param1:KeyboardEvent) : void
      {
         var _loc2_:uint = param1.keyCode;
         if(_loc2_ == 65)
         {
            IndianaDataManager.instance.show();
         }
      }
      
      protected function __labyrinthChat(param1:Event) : void
      {
         LayerManager.Instance.addToLayer(ChatManager.Instance.view,3);
      }
      
      private function __getLuckStoneEnable(param1:PkgEvent) : void
      {
         var _loc2_:Boolean = false;
         var _loc4_:PackageIn = param1.pkg;
         startDate = _loc4_.readDate();
         endDate = _loc4_.readDate();
         isActiv = _loc4_.readBoolean();
         var _loc3_:Date = TimeManager.Instance.Now();
         if(_loc3_.getTime() >= startDate.getTime() && _loc3_.getTime() <= endDate.getTime())
         {
            _loc2_ = true;
         }
         WonderfulActivityManager.Instance.rouleEndTime = endDate;
         if(isActiv && _loc2_)
         {
            WonderfulActivityManager.Instance.addElement(1);
            WonderfulActivityManager.Instance.hasActivity = true;
         }
         else
         {
            WonderfulActivityManager.Instance.removeElement(1);
         }
      }
      
      private function _checkActivityPer(param1:TimerEvent) : void
      {
         _checkLimit();
         if(!isInLuckStone && checkLuckStone())
         {
            addButtonList();
         }
         else if(isInLuckStone && !checkLuckStone())
         {
            addButtonList();
         }
         ShopSaleManager.Instance.checkOpenShopSale();
         IndianaDataManager.instance.tickTime();
      }
      
      private function _checkLimit() : void
      {
         if(!_limitAwardButton)
         {
            return;
         }
         if(!CalendarManager.getInstance().checkEventInfo())
         {
            addButtonList();
            return;
         }
      }
      
      override public function getType() : String
      {
         return "main";
      }
      
      override public function getBackType() : String
      {
         return "main";
      }
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         var _loc3_:int = 0;
         starlingHallScene = HallScene(StarlingMain.instance.currentScene);
         _btnList = [];
         _btnTipList = [];
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(131))
         {
            SocketManager.Instance.out.syncWeakStep(131);
            NoviceDataManager.instance.saveNoviceData(320,PathManager.userName(),PathManager.solveRequestPath());
         }
         KeyboardShortcutsManager.Instance.cancelForbidden();
         super.enter(param1,param2);
         if(param2 is Function)
         {
            param2();
         }
         KeyboardShortcutsManager.Instance.setup();
         SocketManager.Instance.out.sendSceneLogin(0);
         BackgoundView.Instance.hide();
         SocketManager.Instance.out.sendUpdateSysDate();
         SocketManager.Instance.out.sendWonderfulActivity(0,-1);
         SocketManager.Instance.out.updateConsumeRank();
         SocketManager.Instance.out.updateRechargeRank();
         SocketManager.Instance.out.getVipAndMerryInfo(1);
         SocketManager.Instance.out.getVipAndMerryInfo(2);
         SocketManager.Instance.out.getVipAndMerryInfo(3);
         if(!_isShowActTipDic)
         {
            _isShowActTipDic = new Dictionary();
         }
         _loc3_ = 0;
         while(_loc3_ < _needShowOpenTipActArr.length)
         {
            if(!_isShowActTipDic[_needShowOpenTipActArr[_loc3_]])
            {
               _isShowActTipDic[_needShowOpenTipActArr[_loc3_]] = false;
            }
            _loc3_++;
         }
         WonderfulActivityManager.Instance.addEventListener("check_activity_state",__checkShowWonderfulActivityTip);
         if(StartupResourceLoader.firstEnterHall)
         {
            StartupResourceLoader.Instance.addThirdGameUI();
            StartupResourceLoader.Instance.startLoadRelatedInfo();
            SocketManager.Instance.out.sendReleaseConsortiaTask(3);
         }
         try
         {
            initHall();
            return;
         }
         catch(e:Error)
         {
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",__onHallLoadComplete);
            UIModuleLoader.Instance.addUIModuleImp("ddtcorei");
            return;
         }
      }
      
      protected function __consortiaResponse(param1:PkgEvent) : void
      {
         checkConsortionTask();
      }
      
      protected function __renegadeUser(param1:PkgEvent) : void
      {
         checkConsortionTask();
      }
      
      protected function __getTaskInfo(param1:ConsortiaTaskEvent) : void
      {
         if(param1.value == 3 || param1.value == 2 || param1.value == 4 || param1.value == 5)
         {
            checkConsortionTask();
         }
      }
      
      private function checkConsortionTask() : void
      {
         if(ConsortionModelManager.Instance.TaskModel.taskInfo == null)
         {
            ConsortionModelManager.Instance.hideEnterBtnInHallStateView(this);
         }
         else
         {
            ConsortionModelManager.Instance.showEnterBtnInHallStateView(this);
         }
      }
      
      private function __onHallLoadComplete(param1:UIModuleEvent) : void
      {
         if(param1.module == "ddtcorei")
         {
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onHallLoadComplete);
            initHall();
         }
      }
      
      private function initHall() : void
      {
         var _loc5_:* = null;
         var _loc1_:* = null;
         var _loc2_:* = null;
         SoundManager.instance.playMusic("062",true,false);
         if(!_bgSprite)
         {
            _bgSprite = new Sprite();
            addChild(_bgSprite);
         }
         if(!_playerInfoView)
         {
            _playerInfoView = new HallPlayerInfoView();
            addChild(_playerInfoView);
         }
         if(!_playerOperateView)
         {
            _playerOperateView = new HallPlayerOperateView();
            addChild(_playerOperateView);
         }
         if(!_playerView)
         {
            _playerView = new hall.player.HallPlayerView(_bgSprite);
         }
         if(!_systemPost)
         {
            _systemPost = new SystemPost();
            PositionUtils.setPos(_systemPost,"ddt.hall.SystemPostPos");
            addChild(_systemPost);
         }
         if(!_LevelIcon)
         {
            _loc5_ = new Component();
            _LevelIcon = ComponentFactory.Instance.creatBitmap("asset.hall.LevelIcon");
            PositionUtils.setPos(_loc5_,"ddt.hall.LevelIconPostPos");
            _loc5_.addChild(_LevelIcon);
            _loc5_.tipStyle = "ddt.view.tips.MultipleLineTip";
            _loc5_.tipGapV = 25;
            _loc5_.tipGapH = 40;
            _loc5_.tipDirctions = "7,6,5";
            _loc5_.tipData = LanguageMgr.GetTranslation("ddt.hall.LevelIconLanguage");
            addChild(_loc5_);
         }
         var _loc3_:GypsyNPCBhvr = new GypsyNPCBhvr(null);
         _loc3_.hallView = this;
         GypsyShopManager.getInstance().npcBehavior = _loc3_;
         GypsyShopManager.getInstance().init(this);
         DailyButtunBar.Insance.show();
         createBuildBtn();
         createNpcBtn();
         initBuild();
         checkIsMaster();
         SocketManager.Instance.out.requestWonderfulActInit(2);
         SocketManager.Instance.out.updateRechargeRank();
         MainToolBar.Instance.show();
         MainToolBar.Instance.btnOpen();
         MainToolBar.Instance.enabled = true;
         MainToolBar.Instance.updateReturnBtn(0);
         MainToolBar.Instance.ExitBtnVisible = true;
         if(!_isAddFrameComplete)
         {
            TaskManager.instance.checkHighLight();
         }
         ChatManager.Instance.state = 0;
         _chatView = ChatManager.Instance.view;
         _chatView.visible = true;
         ChatManager.Instance.lock = ChatManager.HALL_CHAT_LOCK;
         ChatManager.Instance.chatDisabled = false;
         addChild(_chatView);
         HallIconManager.instance.checkDefaultIconShow();
         FoodActivityManager.Instance.checkOpen();
         _hallRightIconView = new HallRightIconView();
         PositionUtils.setPos(_hallRightIconView,"hallIcon.hallRightIconViewPos");
         LayerManager.Instance.addToLayer(_hallRightIconView,4);
         HallIconManager.instance.checkIconCall();
         HallIconManager.instance.checkCacheRightIconShow();
         HallIconManager.instance.checkCacheRightIconTask();
         if(GameManager.exploreOver)
         {
            BagAndInfoManager.Instance.showBagAndInfo();
         }
         if(!_leftTopGbox)
         {
            _leftTopGbox = ComponentFactory.Instance.creat("hall.view.leftTopGridbox");
            _leftTopGbox.columnNumber = 1;
            _leftTopGbox.cellHeght = 90;
            _leftTopGbox.autoSize = 3;
            _leftTopGbox.align = "left";
         }
         addChild(_leftTopGbox);
         RecordManager.Instance.addRecordIcon(this);
         ConsortionModelManager.Instance.TaskModel.addEventListener("getConsortiaTaskInfo",__getTaskInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(129,3),__renegadeUser);
         SocketManager.Instance.addEventListener(PkgEvent.format(128),__consortiaResponse);
         checkConsortionTask();
         StartupResourceLoader.Instance.finishLoadingProgress();
         StartupResourceLoader.Instance.addNotStartupNeededResource();
         if(StartupResourceLoader.firstEnterHall)
         {
            SoundManager.instance.setupAudioResource(["audiolite"]);
         }
         if(!SoundManager.instance.audioAllComplete)
         {
            _loc1_ = new QueueLoader();
            if(!SoundManager.instance.audioComplete)
            {
               _loc1_.addLoader(LoaderCreate.Instance.createAudioILoader());
            }
            if(!SoundManager.instance.audioiiComplete)
            {
               _loc1_.addLoader(LoaderCreate.Instance.createAudioIILoader());
            }
            if(!SoundManager.instance.audioLiteComplete)
            {
               _loc1_.addLoader(LoaderCreate.Instance.createAudioLiteLoader());
            }
            _loc1_.addEventListener("complete",__onAudioLoadComplete);
            _loc1_.start();
         }
         loadUserGuide();
         CacheSysManager.unlock("alertInMarry");
         showFrame();
         CacheSysManager.unlock("alertInFight");
         CacheSysManager.getInstance().singleRelease("alertInFight");
         LeftGunRouletteManager.instance.addEventListener("leftGun_enable",__leftGunShow);
         checkShowStoreFromShop();
         StrengthDataManager.instance.setup();
         if(!_isIMController && PathManager.CommunityExist())
         {
            _isIMController = true;
            IMManager.Instance.createConsortiaLoader();
         }
         if(PlayerManager.Instance.Self.baiduEnterCode == "true")
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("core.NovicePlatinumCard");
            _loc2_.setup();
         }
         TaskManager.instance.addEventListener("taskFrameHide",__taskFrameHide);
         loadWeakGuild();
         CacheSysManager.getInstance().release("alertInHall");
         CacheSysManager.getInstance().singleRelease("alertInHall");
         FriendBirthdayManager.Instance.findFriendBirthday();
         PetsBagManager.instance().addEventListener("finish",__updatePetFarmGuilde);
         petFarmGuilde();
         DrgnBoatBuildManager.instance.setup(_playerView,_btnList[15]);
         DragonBoatManager.instance.setPlayerView(_playerView,_btnList[16]);
         GradeAwardsBoxButtonManager.getInstance().init();
         GradeAwardsBoxButtonManager.getInstance().setHall(this);
         GradeBuyManager.getInstance().setHall(this);
         CSMBoxManager.instance.showBox(this);
         updateWantStrong();
         HallIconManager.instance.checkDefaultIconShow();
         defaultRightWonderfulPlayIconShow();
         defaultRightActivityIconShow();
         addButtonList();
         _timer.reset();
         _timer.start();
         initDdtActiviyIconState();
         if(DdtActivityIconManager.Instance.isOneOpen && DdtActivityIconManager.Instance.currObj)
         {
            changeIconState(DdtActivityIconManager.Instance.currObj,true);
         }
         DdtActivityIconManager.Instance.setup();
         if(PlayerManager.Instance.Self.Grade >= 28)
         {
            SocketManager.Instance.addEventListener(PkgEvent.format(404,6),__onFightFlag);
            SocketManager.Instance.out.sendRingStationFightFlag();
         }
         _taskTrackMainView = new HallTaskTrackMainView(_btnList[8]);
         addChild(_taskTrackMainView);
         _taskTrackMainView.moveInComplete();
         HallTaskTrackManager.instance.btnList = _btnList;
         HallTaskTrackManager.instance.checkOpenCommitView();
         NewOpenGuideManager.instance.checkShow(starlingHallScene.playerView,this);
         BombKingManager.instance.setup(starlingHallScene.playerView);
         BombKingManager.instance.addToHallStateView(this);
         PlayerManager.Instance.Self.addEventListener("propertychange",__propertyChange);
         SocketManager.Instance.addEventListener(PkgEvent.format(165),__getLuckStoneEnable);
         SocketManager.Instance.out.requestForLuckStone();
         if(AvatarCollectionManager.instance.isDataComplete)
         {
            if(!AvatarCollectionManager.instance.isCheckedAvatarTime)
            {
               __checkAvatarCollectionTime(null);
            }
         }
         else
         {
            AvatarCollectionManager.instance.addEventListener("avatar_collection_data_complete",__checkAvatarCollectionTime);
         }
         var _loc7_:int = 0;
         var _loc6_:* = _btnList;
         for each(var _loc4_ in _btnList)
         {
            _loc4_.alpha = 0;
         }
         PlayerManager.Instance.requireBagLockPSWDNeededList();
         if(ServerConfigManager.instance.wealthTreeIsOpen)
         {
            HallIconManager.instance.updateSwitchHandler("moneyTree",true);
         }
         CondiscountManager.instance.showIcon();
         DefendislandManager.instance.showIcon();
         BankManager.instance.showIcon();
         StockMgr.inst.checkStockIcon();
         MinesManager.instance.checkMinesIcon();
      }
      
      private function addAccumulativeLoginAct() : void
      {
         if(PlayerManager.Instance.Self.accumulativeLoginDays >= 7 && PlayerManager.Instance.Self.accumulativeAwardDays >= 7)
         {
            AccumulativeManager.instance.removeAct();
         }
         else
         {
            AccumulativeManager.instance.addAct();
         }
      }
      
      private function defaultRightWonderfulPlayIconShow() : void
      {
         if(LeagueManager.instance.isOpen)
         {
            addLeagueIcon();
         }
         if(ConsortiaBattleManager.instance.isOpen)
         {
            ConsortiaBattleManager.instance.addEntryBtn(true);
         }
         if(CampBattleManager.instance.openFlag)
         {
            CampBattleManager.instance.addCampBtn();
         }
         if(BattleGroudManager.Instance.isShow)
         {
            addBattleIcon();
         }
         if(SevenDoubleManager.instance.isStart && SevenDoubleManager.instance.isLoadIconComplete)
         {
            sevenDoubleIconResLoadComplete(null);
            SevenDoubleManager.instance.addEventListener("sevenDoubleEnd",sevendoubleEndHandler);
         }
         else
         {
            SevenDoubleManager.instance.addEventListener("sevenDoubleIconResLoadComplete",sevenDoubleIconResLoadComplete);
         }
         if(EscortManager.instance.isStart && EscortManager.instance.isLoadIconComplete)
         {
            escortIconResLoadComplete(null);
            EscortManager.instance.addEventListener("escortEnd",escortEndHandler);
         }
         else
         {
            EscortManager.instance.addEventListener("escortIconResLoadComplete",escortIconResLoadComplete);
         }
         checkShowWorldBossEntrance();
         checkShowWorldBossHelper();
         AnotherDimensionManager.Instance.checkShowIcon();
      }
      
      private function defaultRightActivityIconShow() : void
      {
         GrowthPackageManager.instance.showEnterIcon();
         SevendayManager.instance.checkIcon();
         DiceManager.Instance.setup(showDiceBtn);
         if(DiceManager.Instance.isopen)
         {
            showDiceBtn(true);
         }
         addAccumulativeLoginAct();
         LeftGunRouletteManager.instance.addEventListener("leftGun_enable",__leftGunShow);
         if(LeftGunRouletteManager.instance.IsOpen)
         {
            LeftGunRouletteManager.instance.showGunButton();
         }
         WonderfulActivityManager.Instance.setLimitActivities(CalendarManager.getInstance().eventActives);
         WonderfulActivityManager.Instance.addWAIcon = initLimitActivityIcon;
         WonderfulActivityManager.Instance.deleWAIcon = deleteLimitActivityIcon;
         if(PlayerManager.Instance.Self.Grade >= 10)
         {
            if(WonderfulActivityManager.Instance.actList.length > 0)
            {
               initLimitActivityIcon();
            }
         }
         if(AvatarCollectionManager.instance.isDataComplete)
         {
            if(!AvatarCollectionManager.instance.isCheckedAvatarTime)
            {
               __checkAvatarCollectionTime(null);
            }
         }
         else
         {
            AvatarCollectionManager.instance.addEventListener("avatar_collection_data_complete",__checkAvatarCollectionTime);
         }
         SocketManager.Instance.out.sendRegressTicketInfo();
         FlowerGivingManager.instance.checkOpen();
         if(FoodActivityManager.Instance._isStart)
         {
            FoodActivityManager.Instance.initBtn();
         }
         GypsyShopManager.getInstance().refreshNPC();
         if(CloudBuyLotteryManager.Instance.model.isOpen)
         {
            CloudBuyLotteryManager.Instance.initIcon(CloudBuyLotteryManager.Instance.model.isOpen);
         }
         if(NewYearRiceManager.instance.model.isOpen)
         {
            NewYearRiceManager.instance.showEnterIcon(NewYearRiceManager.instance.model.isOpen);
         }
         if(PrayIndianaManager.Instance.isOpen)
         {
            PrayIndianaManager.Instance.showPrayIndianaIcon(PrayIndianaManager.Instance.isOpen);
         }
         if(WorshipTheMoonManager.getInstance()._isOpen)
         {
            WorshipTheMoonManager.getInstance().worshipTheMoonIcon(WorshipTheMoonManager.getInstance()._isOpen);
         }
         ShopSaleManager.Instance.checkOpenShopSale();
         ChickActivationManager.instance.checkShowIcon();
         LevelFundManager.instance.addLevelFundActivityBtn(this);
         CityBattleManager.instance.updateIcon();
         LotteryManager.instance.updataEnterIcon();
         OldPlayerComeBackManager.instance.checkIcon();
         DDTKingWayManager.instance.checkIcon();
         IndianaDataManager.instance.checkIcon();
         ConRechargeManager.instance.showIcon();
      }
      
      private function showDiceBtn(param1:Boolean = false) : void
      {
         if(param1)
         {
            DemonChiYouManager.instance.initHall(this);
         }
         ConsortiaDomainManager.instance.initHall(this);
         checkIsMaster();
         checkGuide();
         var _loc4_:int = 0;
         var _loc3_:* = _btnList;
         for each(var _loc2_ in _btnList)
         {
            if(PlayerManager.Instance.Self.Grade >= 10)
            {
               HallIconManager.instance.updateSwitchHandler("dice",true);
            }
            else
            {
               HallIconManager.instance.executeCacheRightIconLevelLimit("dice",true,10);
            }
         }
      }
      
      private function checkIsMaster() : void
      {
         if(DDT.isMaster)
         {
            IsMaster = true;
            DDT.isMaster = false;
            GameInSocketOut.sendIsMaster();
            SocketManager.Instance.out.syncWeakStep(144);
            SocketManager.Instance.out.syncWeakStep(10);
            SocketManager.Instance.out.syncWeakStep(12);
            SocketManager.Instance.out.syncWeakStep(11);
            SocketManager.Instance.out.syncWeakStep(12);
            SocketManager.Instance.out.syncWeakStep(5);
            SocketManager.Instance.out.syncWeakStep(2);
            SocketManager.Instance.out.syncWeakStep(51);
            SocketManager.Instance.out.syncWeakStep(52);
            SocketManager.Instance.out.syncWeakStep(55);
            SocketManager.Instance.out.syncWeakStep(56);
            SocketManager.Instance.out.syncWeakStep(57);
            SocketManager.Instance.out.syncWeakStep(132);
            NoviceDataManager.instance.saveNoviceData(1130,PathManager.userName(),PathManager.solveRequestPath());
         }
      }
      
      private function hideGuideNpc() : void
      {
         if(PlayerManager.Instance.Self.Grade > 20)
         {
            _btnList[8].visible = false;
         }
      }
      
      private function __checkAvatarCollectionTime(param1:Event) : void
      {
         var _loc7_:int = 0;
         var _loc3_:* = null;
         var _loc6_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc4_:* = null;
         if(param1)
         {
            AvatarCollectionManager.instance.removeEventListener("avatar_collection_data_complete",__checkAvatarCollectionTime);
         }
         if(!AvatarCollectionManager.instance.maleUnitList)
         {
            return;
         }
         var _loc2_:Array = AvatarCollectionManager.instance.maleUnitList;
         _loc2_ = _loc2_.concat(AvatarCollectionManager.instance.femaleUnitList);
         _loc2_ = _loc2_.concat(AvatarCollectionManager.instance.weaponUnitList);
         _loc7_ = 0;
         while(_loc7_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc7_];
            if(!(!_loc3_.endTime || _loc3_.totalActivityItemCount < _loc3_.totalItemList.length / 2))
            {
               _loc6_ = _loc3_.endTime.getTime();
               _loc5_ = TimeManager.Instance.Now().getTime();
               if(_loc6_ - _loc5_ <= 0)
               {
                  _loc4_ = new ChatData();
                  _loc4_.channel = 21;
                  _loc4_.childChannelArr = [7,14];
                  _loc4_.type = 108;
                  _loc4_.msg = LanguageMgr.GetTranslation("avatarCollection.noTime.tipTxt");
                  AvatarCollectionManager.instance.isCheckedAvatarTime = true;
                  ChatManager.Instance.chat(_loc4_);
                  AvatarCollectionManager.instance.skipId = _loc3_.id;
                  break;
               }
            }
            _loc7_++;
         }
      }
      
      private function showFrame() : void
      {
         SystemOpenPromptManager.instance.showFrame();
         checkShowVote();
         checkShowVipAlert_New();
         KingBlessManager.instance.checkShowDueAlert();
         if(!_isAddFrameComplete)
         {
            addFrame();
         }
         TimesManager.Instance.checkOpenUpdateFrame();
         if(SharedManager.Instance.divorceBoolean)
         {
            DivorcePromptFrame.Instance.show();
         }
         CacheSysManager.getInstance().release("alertInHall");
         CacheSysManager.getInstance().singleRelease("alertInHall");
         WonderfulActivityManager.Instance.checkShowSendGiftFrame();
         DemonChiYouManager.instance.askAndCheckIcon();
         ConsortiaDomainManager.instance.askActiveSate();
      }
      
      private function __propertyChange(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["Grade"])
         {
            initBuild();
            addButtonList();
            checkGuide();
         }
         SevendayManager.instance.checkAutoShow();
      }
      
      private function createBuildBtn() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc2_:* = null;
         _loc4_ = 0;
         while(_loc4_ < 6)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("HallMain." + _btnArray[_loc4_] + "Btn");
            _loc1_ = new HallBuildTip();
            _loc2_ = {};
            _loc2_["title"] = LanguageMgr.GetTranslation("ddt.hall.build." + _btnArray[_loc4_] + "title");
            _loc2_["content"] = LanguageMgr.GetTranslation("ddt.HallStateView." + _btnArray[_loc4_]);
            _loc1_.tipData = _loc2_;
            PositionUtils.setPos(_loc1_,"hall.build." + _btnArray[_loc4_] + "TipPos");
            _btnTipList.push(_loc1_);
            _btnList.push(_loc3_);
            HallTaskTrackManager.instance.btnIndexMap[_btnArray[_loc4_]] = _loc4_;
            _playerView.touchArea.addChild(_loc1_);
            _playerView.touchArea.addChild(_loc3_);
            _loc4_++;
         }
      }
      
      private function createNpcBtn() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 6;
         while(_loc2_ < _btnArray.length)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("HallMain." + _btnArray[_loc2_] + "Btn");
            _btnList.push(_loc1_);
            _playerView.touchArea.addChild(_loc1_);
            HallTaskTrackManager.instance.btnIndexMap[_btnArray[_loc2_]] = _loc2_;
            _loc2_++;
         }
      }
      
      private function initBuild() : void
      {
         var _loc1_:int = PlayerManager.Instance.Self.Grade;
         setBuildState(0,_loc1_ >= 10?true:false);
         setBuildState(1,_loc1_ >= 3?true:false);
         setBuildState(2,_loc1_ >= 30?true:false);
         setBuildState(3,_loc1_ >= 19?true:false);
         setBuildState(4,false);
         setBuildState(5,_loc1_ >= 45?true:false);
         setBuildState(6,true);
         setBuildState(7,GypsyNPCModel.getInstance().isStart());
         setBuildState(8,false);
         setBuildState(9,true);
         setBuildState(10,true);
         setBuildState(11,true);
         setBuildState(12,true);
         setBuildState(13,true);
         setBuildState(14,true);
         setBuildState(15,true);
         setBuildState(16,true);
         setBuildState(17,true);
         setBuildState(18,true);
         setBuildState(19,true);
      }
      
      public function setNPCBtnEnable(param1:Component, param2:Boolean) : void
      {
         if(param2)
         {
            param1.addEventListener("mouseMove",__btnOver);
            param1.addEventListener("mouseOut",__btnOut);
            param1.addEventListener("click",__btnClick);
         }
         else
         {
            param1.removeEventListener("mouseMove",__btnOver);
            param1.removeEventListener("mouseOut",__btnOut);
            param1.removeEventListener("click",__btnClick);
            onOutEffect(_btnList.indexOf(param1));
         }
      }
      
      private function setBuildState(param1:int, param2:Boolean, param3:Boolean = false) : void
      {
         var _loc4_:Component = _btnList[param1];
         var _loc5_:* = param2;
         _loc4_.mouseEnabled = _loc5_;
         _loc5_ = _loc5_;
         _loc4_.mouseChildren = _loc5_;
         _loc4_.buttonMode = _loc5_;
         if(param2)
         {
            _loc4_.addEventListener("click",__btnClick);
            _loc4_.addEventListener("mouseMove",__btnOver);
            _loc4_.addEventListener("mouseOut",__btnOut);
         }
         if(param1 == 7)
         {
            GypsyShopManager.getInstance().npcBehavior.hotArea = _loc4_;
         }
      }
      
      private function __btnOver(param1:MouseEvent) : void
      {
         var _loc2_:int = _btnList.indexOf(param1.currentTarget as BaseButton);
         if(_loc2_ < 6)
         {
            _btnTipList[_loc2_].visible = true;
         }
         else
         {
            setCharacterFilter(_loc2_,true);
         }
      }
      
      protected function setCharacterFilter(param1:int, param2:Boolean) : void
      {
         var _loc3_:* = null;
         if(_notFilter.indexOf(param1) == -1)
         {
            _loc3_ = starlingHallScene.playerView.staticLayer;
            _loc3_.setCharacterFilter(_btnArray[param1],param2);
         }
      }
      
      private function __btnOut(param1:MouseEvent) : void
      {
         var _loc2_:int = _btnList.indexOf(param1.currentTarget as BaseButton);
         onOutEffect(_loc2_);
      }
      
      private function onOutEffect(param1:int) : void
      {
         if(param1 < 6)
         {
            _btnTipList[param1].visible = false;
         }
         else
         {
            setCharacterFilter(param1,false);
         }
      }
      
      private function __onFightFlag(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         var _loc4_:Date = _loc3_.readDate();
         if(StateManager.currentStateType == "main")
         {
            if(_loc4_.time - TimeManager.Instance.Now().time > 0)
            {
            }
         }
      }
      
      private function ringStationShow() : void
      {
         if(new Date().time - _ringStationClickDate > 1000)
         {
            _ringStationClickDate = new Date().time;
            SoundManager.instance.playButtonSound();
            RingStationManager.instance.show();
         }
      }
      
      private function showCryptBossFrame() : void
      {
         CryptBossManager.instance.show();
      }
      
      private function __checkShowWonderfulActivityTip(param1:WonderfulActivityEvent) : void
      {
         checkShowActTip();
         createActAwardChat();
      }
      
      private function checkShowActTip() : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = WonderfulActivityManager.Instance.stateDic;
         for(var _loc1_ in WonderfulActivityManager.Instance.stateDic)
         {
            _loc2_ = 0;
            while(_loc2_ < _needShowOpenTipActArr.length)
            {
               if(_loc1_ == String(_needShowOpenTipActArr[_loc2_]) && !_isShowActTipDic[_needShowOpenTipActArr[_loc2_]])
               {
                  ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("wonderfulActivity.startTip" + _needShowOpenTipActArr[_loc2_]));
                  _isShowActTipDic[_needShowOpenTipActArr[_loc2_]] = true;
               }
               _loc2_++;
            }
         }
      }
      
      private function createActAwardChat() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = WonderfulActivityManager.Instance.stateDic;
         for(var _loc2_ in WonderfulActivityManager.Instance.stateDic)
         {
            _loc3_ = 0;
            while(_loc3_ < _needShowAwardTipActArr.length)
            {
               if(_loc2_ == String(_needShowAwardTipActArr[_loc3_]) && WonderfulActivityManager.Instance.stateDic[_loc2_])
               {
                  _loc1_ = new ChatData();
                  _loc1_.channel = 21;
                  _loc1_.childChannelArr = [7,14];
                  _loc1_.type = ChatFormats.CLICK_ACT_TIP + _needShowAwardTipActArr[_loc3_];
                  _loc1_.actId = WonderfulActivityManager.Instance.getActIdWithViewId(_needShowAwardTipActArr[_loc3_]);
                  _loc1_.msg = LanguageMgr.GetTranslation("wonderfulActivity.awardTip" + _needShowAwardTipActArr[_loc3_]);
                  ChatManager.Instance.chat(_loc1_);
               }
               _loc3_++;
            }
         }
      }
      
      private function initDdtActiviyIconState() : void
      {
         DdtActivityIconManager.Instance.addEventListener("ready_start",readyHander);
         DdtActivityIconManager.Instance.addEventListener("start",startHander);
      }
      
      private function removeDdtActiviyIconState() : void
      {
         DdtActivityIconManager.Instance.removeEventListener("ready_start",readyHander);
         DdtActivityIconManager.Instance.removeEventListener("start",startHander);
      }
      
      private function readyHander(param1:ActivitStateEvent) : void
      {
         changeIconState(param1.data,false);
      }
      
      private function startHander(param1:ActivitStateEvent) : void
      {
         changeIconState(param1.data,true);
      }
      
      private function changeIconState(param1:Array, param2:Boolean = false) : void
      {
         var _loc4_:int = param1[0];
         var _loc3_:int = param1[1] == 4?1:4;
         var _loc5_:String = param1[2];
         if(param2)
         {
            _loc5_ = "";
         }
         switch(int(_loc4_) - 1)
         {
            case 0:
               addBattleIcon(param2,_loc5_);
               break;
            default:
               addBattleIcon(param2,_loc5_);
               break;
            default:
               addBattleIcon(param2,_loc5_);
               break;
            case 3:
               if(param2 && !WorldBossManager.Instance.isOpen)
               {
                  DdtActivityIconManager.Instance.isOneOpen = false;
                  return;
               }
               WorldBossManager.Instance.creatEnterIcon(param2,_loc3_,_loc5_);
               checkShowWorldBossHelper();
               break;
            default:
               if(param2 && !WorldBossManager.Instance.isOpen)
               {
                  DdtActivityIconManager.Instance.isOneOpen = false;
                  return;
               }
               WorldBossManager.Instance.creatEnterIcon(param2,_loc3_,_loc5_);
               checkShowWorldBossHelper();
               break;
            default:
               if(param2 && !WorldBossManager.Instance.isOpen)
               {
                  DdtActivityIconManager.Instance.isOneOpen = false;
                  return;
               }
               WorldBossManager.Instance.creatEnterIcon(param2,_loc3_,_loc5_);
               checkShowWorldBossHelper();
               break;
            default:
               if(param2 && !WorldBossManager.Instance.isOpen)
               {
                  DdtActivityIconManager.Instance.isOneOpen = false;
                  return;
               }
               WorldBossManager.Instance.creatEnterIcon(param2,_loc3_,_loc5_);
               checkShowWorldBossHelper();
               break;
            default:
               if(param2 && !WorldBossManager.Instance.isOpen)
               {
                  DdtActivityIconManager.Instance.isOneOpen = false;
                  return;
               }
               WorldBossManager.Instance.creatEnterIcon(param2,_loc3_,_loc5_);
               checkShowWorldBossHelper();
               break;
            case 8:
               CampBattleManager.instance.addCampBtn(param2,_loc5_);
               break;
            case 9:
            case 10:
               addLeagueIcon(param2,_loc5_);
               break;
            case 11:
               ConsortiaBattleManager.instance.addEntryBtn(param2,_loc5_);
         }
      }
      
      private function campBtnHander(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.Grade < 30)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",30));
            return;
         }
         if(PlayerManager.Instance.Self.Bag.getItemAt(6) == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.RoomIIController.weapon"));
            return;
         }
         if(getTimer() - _lastCreatTime > 1000)
         {
            _lastCreatTime = getTimer();
            GameInSocketOut.sendSingleRoomBegin(5);
         }
      }
      
      private function stopAllMc(param1:MovieClip) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         while(param1.numChildren - _loc3_)
         {
            if(param1.getChildAt(_loc3_) is MovieClip)
            {
               _loc2_ = param1.getChildAt(_loc3_) as MovieClip;
               _loc2_.stop();
               stopAllMc(_loc2_);
            }
            _loc3_++;
         }
      }
      
      private function playAllMc(param1:MovieClip) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         while(param1.numChildren - _loc3_)
         {
            if(param1.getChildAt(_loc3_) is MovieClip)
            {
               _loc2_ = param1.getChildAt(_loc3_) as MovieClip;
               _loc2_.play();
               playAllMc(_loc2_);
            }
            _loc3_++;
         }
      }
      
      private function updateWantStrong() : void
      {
         var _loc2_:* = undefined;
         var _loc1_:* = null;
         var _loc9_:* = null;
         var _loc8_:* = null;
         var _loc5_:* = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc7_:Boolean = false;
         var _loc10_:int = 0;
         var _loc6_:* = null;
         if(PlayerManager.Instance.Self.Grade >= 8 && PlayerManager.Instance.Self.Grade <= 80)
         {
            _loc2_ = DayActivityManager.Instance.acitiveDataList;
            _loc1_ = DayActivityManager.Instance.bossDataDic;
            _loc9_ = WantStrongManager.Instance.findBackDic;
            _loc8_ = DayActivityManager.Instance.speedActArr;
            _loc5_ = TimeManager.Instance.serverDate;
            _loc7_ = false;
            _loc10_ = 0;
            while(_loc10_ < _loc2_.length)
            {
               _loc4_ = _loc2_[_loc10_].ActiveTime.substr(_loc2_[_loc10_].ActiveTime.length - 5,2);
               _loc3_ = int(_loc2_[_loc10_].ActiveTime.substr(_loc2_[_loc10_].ActiveTime.length - 2,2)) + 10;
               switch(int(_loc2_[_loc10_].JumpType) - 1)
               {
                  case 0:
                     if(compareDay(_loc5_.day,_loc2_[_loc10_].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(_loc2_[_loc10_].LevelLimit) && compareDate(_loc5_,_loc4_,_loc3_) && !isPassBoss(_loc1_,_loc8_,5) && !isFindBack(_loc9_,5))
                     {
                        WantStrongManager.Instance.findBackExist = true;
                        _loc7_ = true;
                        WantStrongManager.Instance.setFindBackData(3);
                        break;
                     }
                     break;
                  default:
                     if(compareDay(_loc5_.day,_loc2_[_loc10_].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(_loc2_[_loc10_].LevelLimit) && compareDate(_loc5_,_loc4_,_loc3_) && !isPassBoss(_loc1_,_loc8_,5) && !isFindBack(_loc9_,5))
                     {
                        WantStrongManager.Instance.findBackExist = true;
                        _loc7_ = true;
                        WantStrongManager.Instance.setFindBackData(3);
                        break;
                     }
                     break;
                  default:
                     if(compareDay(_loc5_.day,_loc2_[_loc10_].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(_loc2_[_loc10_].LevelLimit) && compareDate(_loc5_,_loc4_,_loc3_) && !isPassBoss(_loc1_,_loc8_,5) && !isFindBack(_loc9_,5))
                     {
                        WantStrongManager.Instance.findBackExist = true;
                        _loc7_ = true;
                        WantStrongManager.Instance.setFindBackData(3);
                        break;
                     }
                     break;
                  case 3:
                     if(compareDay(_loc5_.day,_loc2_[_loc10_].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(_loc2_[_loc10_].LevelLimit) && compareDate(_loc5_,_loc4_,_loc3_) && !isPassBoss(_loc1_,_loc8_,6) && !isFindBack(_loc9_,6))
                     {
                        WantStrongManager.Instance.findBackExist = true;
                        _loc7_ = true;
                        WantStrongManager.Instance.setFindBackData(0);
                     }
                     break;
                  default:
                     if(compareDay(_loc5_.day,_loc2_[_loc10_].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(_loc2_[_loc10_].LevelLimit) && compareDate(_loc5_,_loc4_,_loc3_) && !isPassBoss(_loc1_,_loc8_,6) && !isFindBack(_loc9_,6))
                     {
                        WantStrongManager.Instance.findBackExist = true;
                        _loc7_ = true;
                        WantStrongManager.Instance.setFindBackData(0);
                     }
                     break;
                  default:
                     if(compareDay(_loc5_.day,_loc2_[_loc10_].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(_loc2_[_loc10_].LevelLimit) && compareDate(_loc5_,_loc4_,_loc3_) && !isPassBoss(_loc1_,_loc8_,6) && !isFindBack(_loc9_,6))
                     {
                        WantStrongManager.Instance.findBackExist = true;
                        _loc7_ = true;
                        WantStrongManager.Instance.setFindBackData(0);
                     }
                     break;
                  default:
                     if(compareDay(_loc5_.day,_loc2_[_loc10_].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(_loc2_[_loc10_].LevelLimit) && compareDate(_loc5_,_loc4_,_loc3_) && !isPassBoss(_loc1_,_loc8_,6) && !isFindBack(_loc9_,6))
                     {
                        WantStrongManager.Instance.findBackExist = true;
                        _loc7_ = true;
                        WantStrongManager.Instance.setFindBackData(0);
                     }
                     break;
                  default:
                     if(compareDay(_loc5_.day,_loc2_[_loc10_].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(_loc2_[_loc10_].LevelLimit) && compareDate(_loc5_,_loc4_,_loc3_) && !isPassBoss(_loc1_,_loc8_,6) && !isFindBack(_loc9_,6))
                     {
                        WantStrongManager.Instance.findBackExist = true;
                        _loc7_ = true;
                        WantStrongManager.Instance.setFindBackData(0);
                     }
                     break;
                  default:
                     if(compareDay(_loc5_.day,_loc2_[_loc10_].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(_loc2_[_loc10_].LevelLimit) && compareDate(_loc5_,_loc4_,_loc3_) && !isPassBoss(_loc1_,_loc8_,6) && !isFindBack(_loc9_,6))
                     {
                        WantStrongManager.Instance.findBackExist = true;
                        _loc7_ = true;
                        WantStrongManager.Instance.setFindBackData(0);
                     }
                     break;
                  case 9:
                     if(compareDay(_loc5_.day,_loc2_[_loc10_].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(_loc2_[_loc10_].LevelLimit) && compareDate(_loc5_,_loc4_,_loc3_) && !isPassBoss(_loc1_,_loc8_,4) && !isFindBack(_loc9_,4))
                     {
                        WantStrongManager.Instance.findBackExist = true;
                        _loc7_ = true;
                        WantStrongManager.Instance.setFindBackData(4);
                     }
                     break;
                  case 10:
                     _loc6_ = _loc2_[_loc10_].ActiveTime.split("（")[0];
                     _loc4_ = _loc6_.substr(_loc6_.length - 5,2);
                     _loc3_ = int(_loc6_.substr(_loc6_.length - 2,2)) + 10;
                     if(compareDay(_loc5_.day,_loc2_[_loc10_].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(_loc2_[_loc10_].LevelLimit) && compareDate(_loc5_,_loc4_,_loc3_) && !isPassBoss(_loc1_,_loc8_,19) && !isFindBack(_loc9_,19))
                     {
                        WantStrongManager.Instance.findBackExist = true;
                        _loc7_ = true;
                        WantStrongManager.Instance.setFindBackData(2);
                     }
               }
               _loc10_++;
            }
            if(!_loc7_)
            {
               WantStrongManager.Instance.findBackExist = false;
            }
         }
      }
      
      private function isPassBoss(param1:Dictionary, param2:Array, param3:int) : Boolean
      {
         if(param2.indexOf("" + param3) != -1)
         {
            return false;
         }
         if(!param1[param3] || param1[param3] == 0)
         {
            return false;
         }
         return true;
      }
      
      protected function __alreadyUpdateTimeHandler(param1:Event) : void
      {
         checkWantStrongFindBack();
      }
      
      private function checkWantStrongFindBack() : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc10_:int = 0;
         var _loc6_:* = null;
         var _loc2_:Vector.<DayActiveData> = DayActivityManager.Instance.acitiveDataList;
         var _loc1_:Dictionary = DayActivityManager.Instance.bossDataDic;
         var _loc9_:Dictionary = WantStrongManager.Instance.findBackDic;
         var _loc8_:Array = DayActivityManager.Instance.speedActArr;
         var _loc5_:Date = TimeManager.Instance.Now();
         var _loc7_:Boolean = false;
         _loc10_ = 0;
         while(_loc10_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc10_].ActiveTime.substr(_loc2_[_loc10_].ActiveTime.length - 5,2);
            _loc3_ = int(_loc2_[_loc10_].ActiveTime.substr(_loc2_[_loc10_].ActiveTime.length - 2,2)) + 10;
            switch(int(_loc2_[_loc10_].ID) - 1)
            {
               case 0:
                  if(compareDay(_loc5_.day,_loc2_[_loc10_].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(_loc2_[_loc10_].LevelLimit) && compareDate(_loc5_,_loc4_,_loc3_) && isBeatBoss(1) && !isFindBack(_loc9_,18))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     _loc7_ = true;
                     WantStrongManager.Instance.setFindBackData(1);
                  }
                  break;
               case 1:
                  if(compareDay(_loc5_.day,_loc2_[_loc10_].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(_loc2_[_loc10_].LevelLimit) && compareDate(_loc5_,_loc4_,_loc3_) && isBeatBoss(0) && !isFindBack(_loc9_,6))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     _loc7_ = true;
                     WantStrongManager.Instance.setFindBackData(0);
                  }
                  break;
               default:
                  if(compareDay(_loc5_.day,_loc2_[_loc10_].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(_loc2_[_loc10_].LevelLimit) && compareDate(_loc5_,_loc4_,_loc3_) && isBeatBoss(0) && !isFindBack(_loc9_,6))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     _loc7_ = true;
                     WantStrongManager.Instance.setFindBackData(0);
                  }
                  break;
               case 3:
                  if(compareDay(_loc5_.day,_loc2_[_loc10_].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(_loc2_[_loc10_].LevelLimit) && compareDate(_loc5_,_loc4_,_loc3_) && !isPass(_loc1_,_loc8_,4) && !isFindBack(_loc9_,4))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     _loc7_ = true;
                     WantStrongManager.Instance.setFindBackData(4);
                  }
                  break;
               case 4:
                  if(compareDay(_loc5_.day,_loc2_[_loc10_].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(_loc2_[_loc10_].LevelLimit) && compareDate(_loc5_,_loc4_,_loc3_) && isBeatBoss(5) && !isFindBack(_loc9_,5))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     _loc7_ = true;
                     WantStrongManager.Instance.setFindBackData(3);
                     break;
                  }
                  break;
               default:
                  if(compareDay(_loc5_.day,_loc2_[_loc10_].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(_loc2_[_loc10_].LevelLimit) && compareDate(_loc5_,_loc4_,_loc3_) && isBeatBoss(5) && !isFindBack(_loc9_,5))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     _loc7_ = true;
                     WantStrongManager.Instance.setFindBackData(3);
                     break;
                  }
                  break;
               default:
                  if(compareDay(_loc5_.day,_loc2_[_loc10_].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(_loc2_[_loc10_].LevelLimit) && compareDate(_loc5_,_loc4_,_loc3_) && isBeatBoss(5) && !isFindBack(_loc9_,5))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     _loc7_ = true;
                     WantStrongManager.Instance.setFindBackData(3);
                     break;
                  }
                  break;
               default:
                  if(compareDay(_loc5_.day,_loc2_[_loc10_].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(_loc2_[_loc10_].LevelLimit) && compareDate(_loc5_,_loc4_,_loc3_) && isBeatBoss(5) && !isFindBack(_loc9_,5))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     _loc7_ = true;
                     WantStrongManager.Instance.setFindBackData(3);
                     break;
                  }
                  break;
               default:
                  if(compareDay(_loc5_.day,_loc2_[_loc10_].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(_loc2_[_loc10_].LevelLimit) && compareDate(_loc5_,_loc4_,_loc3_) && isBeatBoss(5) && !isFindBack(_loc9_,5))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     _loc7_ = true;
                     WantStrongManager.Instance.setFindBackData(3);
                     break;
                  }
                  break;
               default:
                  if(compareDay(_loc5_.day,_loc2_[_loc10_].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(_loc2_[_loc10_].LevelLimit) && compareDate(_loc5_,_loc4_,_loc3_) && isBeatBoss(5) && !isFindBack(_loc9_,5))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     _loc7_ = true;
                     WantStrongManager.Instance.setFindBackData(3);
                     break;
                  }
                  break;
               default:
                  if(compareDay(_loc5_.day,_loc2_[_loc10_].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(_loc2_[_loc10_].LevelLimit) && compareDate(_loc5_,_loc4_,_loc3_) && isBeatBoss(5) && !isFindBack(_loc9_,5))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     _loc7_ = true;
                     WantStrongManager.Instance.setFindBackData(3);
                     break;
                  }
                  break;
               default:
                  if(compareDay(_loc5_.day,_loc2_[_loc10_].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(_loc2_[_loc10_].LevelLimit) && compareDate(_loc5_,_loc4_,_loc3_) && isBeatBoss(5) && !isFindBack(_loc9_,5))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     _loc7_ = true;
                     WantStrongManager.Instance.setFindBackData(3);
                     break;
                  }
                  break;
               default:
                  if(compareDay(_loc5_.day,_loc2_[_loc10_].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(_loc2_[_loc10_].LevelLimit) && compareDate(_loc5_,_loc4_,_loc3_) && isBeatBoss(5) && !isFindBack(_loc9_,5))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     _loc7_ = true;
                     WantStrongManager.Instance.setFindBackData(3);
                     break;
                  }
                  break;
               default:
                  if(compareDay(_loc5_.day,_loc2_[_loc10_].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(_loc2_[_loc10_].LevelLimit) && compareDate(_loc5_,_loc4_,_loc3_) && isBeatBoss(5) && !isFindBack(_loc9_,5))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     _loc7_ = true;
                     WantStrongManager.Instance.setFindBackData(3);
                     break;
                  }
                  break;
               default:
                  if(compareDay(_loc5_.day,_loc2_[_loc10_].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(_loc2_[_loc10_].LevelLimit) && compareDate(_loc5_,_loc4_,_loc3_) && isBeatBoss(5) && !isFindBack(_loc9_,5))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     _loc7_ = true;
                     WantStrongManager.Instance.setFindBackData(3);
                     break;
                  }
                  break;
               default:
                  if(compareDay(_loc5_.day,_loc2_[_loc10_].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(_loc2_[_loc10_].LevelLimit) && compareDate(_loc5_,_loc4_,_loc3_) && isBeatBoss(5) && !isFindBack(_loc9_,5))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     _loc7_ = true;
                     WantStrongManager.Instance.setFindBackData(3);
                     break;
                  }
                  break;
               default:
                  if(compareDay(_loc5_.day,_loc2_[_loc10_].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(_loc2_[_loc10_].LevelLimit) && compareDate(_loc5_,_loc4_,_loc3_) && isBeatBoss(5) && !isFindBack(_loc9_,5))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     _loc7_ = true;
                     WantStrongManager.Instance.setFindBackData(3);
                     break;
                  }
                  break;
               default:
                  if(compareDay(_loc5_.day,_loc2_[_loc10_].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(_loc2_[_loc10_].LevelLimit) && compareDate(_loc5_,_loc4_,_loc3_) && isBeatBoss(5) && !isFindBack(_loc9_,5))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     _loc7_ = true;
                     WantStrongManager.Instance.setFindBackData(3);
                     break;
                  }
                  break;
               case 18:
                  _loc6_ = _loc2_[_loc10_].ActiveTime.split("（")[0];
                  _loc4_ = _loc6_.substr(_loc6_.length - 5,2);
                  _loc3_ = int(_loc6_.substr(_loc6_.length - 2,2)) + 10;
                  if(compareDay(_loc5_.day,_loc2_[_loc10_].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(_loc2_[_loc10_].LevelLimit) && compareDate(_loc5_,_loc4_,_loc3_) && isBeatBoss(2) && !isFindBack(_loc9_,19))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     _loc7_ = true;
                     WantStrongManager.Instance.setFindBackData(2);
                  }
            }
            _loc10_++;
         }
         if(!_loc7_)
         {
            WantStrongManager.Instance.findBackExist = false;
         }
         if(!WantStrongManager.Instance.findBackExist)
         {
            _wantStrongBtn.movie.gotoAndStop(2);
         }
         else if(isOnceFindBack(_loc9_))
         {
            WantStrongManager.Instance.isPlayMovie = false;
            _wantStrongBtn.movie.gotoAndStop(2);
         }
         else
         {
            _wantStrongBtn.movie.gotoAndStop(1);
         }
      }
      
      private function __alreadyFindBackHandler(param1:Event) : void
      {
         _wantStrongBtn.movie.gotoAndStop(2);
      }
      
      private function isOnceFindBack(param1:Dictionary) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for each(var _loc2_ in param1)
         {
            if(_loc2_[0] || _loc2_[1])
            {
               return true;
            }
         }
         return false;
      }
      
      private function isFindBack(param1:Dictionary, param2:int) : Boolean
      {
         if(param1[param2])
         {
            if(param1[param2][0] && param1[param2][1])
            {
               return true;
            }
         }
         return false;
      }
      
      private function isBeatBoss(param1:int) : Boolean
      {
         var _loc2_:int = WantStrongManager.Instance.bossFlag;
         return (_loc2_ & 1 << param1) == 0;
      }
      
      private function isPass(param1:Dictionary, param2:Array, param3:int) : Boolean
      {
         if(param2.indexOf("" + param3) != -1)
         {
            return false;
         }
         if(!param1[param3] || param1[param3] == 0)
         {
            return false;
         }
         return true;
      }
      
      private function compareDay(param1:int, param2:String) : Boolean
      {
         var _loc3_:Array = param2.split(",");
         if(_loc3_.indexOf("" + param1) == -1)
         {
            return false;
         }
         return true;
      }
      
      private function compareDate(param1:Date, param2:int, param3:int) : Boolean
      {
         if(param1.hours < param2)
         {
            return false;
         }
         if(param1.hours == param2)
         {
            if(param1.minutes < param3)
            {
               return false;
            }
         }
         return true;
      }
      
      private function wantStrongtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         WantStrongManager.Instance.showFrame();
      }
      
      private function addLeagueIcon(param1:Boolean = false, param2:String = null) : void
      {
         HallIconManager.instance.updateSwitchHandler("league",true,param2);
      }
      
      private function deleLeagueBtn() : void
      {
         HallIconManager.instance.updateSwitchHandler("league",false);
      }
      
      private function addBattleIcon(param1:Boolean = false, param2:String = "") : void
      {
         HallIconManager.instance.updateSwitchHandler("trial",true,param2);
      }
      
      private function delBattleIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("trial",false);
      }
      
      private function initLimitActivityIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("limitActivity",true);
      }
      
      private function deleteLimitActivityIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("limitActivity",false);
      }
      
      private function leagueBtnHander(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(!WeakGuildManager.Instance.checkOpen(1,20))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",20));
            return;
         }
         StateManager.currentStateType = "roomlist";
         RoomListManager.instance.enter();
         ComponentSetting.SEND_USELOG_ID(3);
         if(PlayerManager.Instance.Self.IsWeakGuildFinish(1) && !PlayerManager.Instance.Self.IsWeakGuildFinish(4))
         {
            SocketManager.Instance.out.syncWeakStep(4);
         }
      }
      
      private function addButtonList() : void
      {
         ExchangeActManager.Instance.addWonderfulIcon(this);
         if(PlayerManager.Instance.Self.Grade == 7)
         {
            HallIconManager.instance.updateSwitchHandler("wantstrong",true);
         }
         GradeAwardsBoxButtonManager.getInstance().init();
         GradeAwardsBoxButtonManager.getInstance().setHall(this);
         GradeBuyManager.getInstance().setHall(this);
         GradeBuyManager.getInstance().setHall(this);
         DdtKingLettersCollectManager.getInstance().showIcon(this);
      }
      
      public function arrangeLeftGrid() : void
      {
         _leftTopGbox.arrange();
         _leftTopGbox.x = 16;
         _leftTopGbox.y = 141;
         RecordManager.Instance.resetRecordPos(this);
      }
      
      public function hideRightGrid() : void
      {
         _taskTrackMainView.moveOutClickHandler(null);
      }
      
      public function showRightGrid() : void
      {
         _taskTrackMainView.moveInClickHandler(null);
      }
      
      private function openWonderfulActivityView(param1:MouseEvent) : void
      {
         if(getTimer() - _lastClickTime < 2000)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("wonderfulActivity.npc.clickTip"));
            return;
         }
         _lastClickTime = getTimer();
         SoundManager.instance.play("008");
         WonderfulActivityManager.Instance.clickWonderfulActView = true;
         SocketManager.Instance.out.requestRookieRankInfo();
         SocketManager.Instance.out.requestWonderfulActInit(1);
      }
      
      private function checkLuckStone() : Boolean
      {
         var _loc1_:Date = TimeManager.Instance.Now();
         if(!startDate)
         {
            return false;
         }
         if(_loc1_.getTime() > startDate.getTime() && _loc1_.getTime() < endDate.getTime() && isActiv)
         {
            isInLuckStone = true;
            return true;
         }
         isInLuckStone = false;
         return false;
      }
      
      private function initAngelbless() : void
      {
         if(!_angelblessIcon)
         {
            _angelblessIcon = ComponentFactory.Instance.creat("asset.hallView.angelbless");
         }
         _angelblessIcon.x = 12;
         _angelblessIcon.buttonMode = true;
         _angelblessIcon.addEventListener("click",__OpenBlessView);
      }
      
      protected function openFristrechargeView(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         FirstRechargeManger.Instance.show();
      }
      
      private function __onSignClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         CalendarManager.getInstance().open(1);
      }
      
      private function initAward() : void
      {
         if(!_awardBtn)
         {
            _awardBtn = ComponentFactory.Instance.creat("asset.hallView.ActivityIcon");
         }
         _awardBtn.x = 14;
         _awardBtn.buttonMode = true;
         _awardBtn.addEventListener("click",__OpenView);
      }
      
      private function __OpenView(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         MainButtnController.instance.show(MainButtnController.DDT_AWARD);
         MainButtnController.instance.addEventListener(MainButtnController.ICONCLOSE,__iconClose);
      }
      
      private function __openActivityView(param1:Event) : void
      {
         SoundManager.instance.play("008");
         DayActivityManager.Instance.show();
      }
      
      private function __iconClose(param1:Event) : void
      {
      }
      
      private function __updatePetFarmGuilde(param1:UpdatePetFarmGuildeEvent) : void
      {
         PetsBagManager.instance().finishTask();
         var _loc2_:QuestInfo = param1.data as QuestInfo;
         if(_loc2_.QuestID == 370)
         {
         }
         if(_loc2_.QuestID == 369)
         {
         }
      }
      
      private function __OpenVipView(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         VipController.instance.show();
      }
      
      private function __OpenBlessView(param1:Event) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         RouletteManager.instance.useBless();
      }
      
      private function petFarmGuilde() : void
      {
         if(!PetsBagManager.instance().haveTaskOrderByID(367))
         {
         }
         if(!PetsBagManager.instance().haveTaskOrderByID(368))
         {
         }
         if(!PetsBagManager.instance().haveTaskOrderByID(369))
         {
         }
         if(!PetsBagManager.instance().haveTaskOrderByID(370))
         {
         }
      }
      
      private function __leftGunShow(param1:RouletteFrameEvent) : void
      {
         addButtonList();
      }
      
      private function __onAudioLoadComplete(param1:Event) : void
      {
         param1.currentTarget.removeEventListener("complete",__onAudioLoadComplete);
         SoundManager.instance.setupAudioResource();
         SoundILoaded = true;
         try
         {
            snd = new Sound(new URLRequest(""));
            snd.play();
            snd.close();
            snd.addEventListener("sampleData",onSampleDataHandler,false,0,true);
            sndCh = snd.play();
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      private function __littlegameActived(param1:Event = null, param2:Boolean = false, param3:String = null) : void
      {
         HallIconManager.instance.updateSwitchHandler("littlegamenote",false,param3);
      }
      
      private function __OpenlittleGame(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(LittleControl.Instance.hasActive())
         {
            StateManager.setState("littleHall");
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.labyrinth.LabyrinthBoxIconTips.labelII"));
         }
      }
      
      private function addFrame() : void
      {
         if(_isAddFrameComplete)
         {
            return;
         }
         if(TimeManager.Instance.TotalDaysToNow(PlayerManager.Instance.Self.LastDate as Date) >= 30 && PlayerManager.Instance.Self.isOldPlayerHasValidEquitAtLogin && !PlayerManager.Instance.Self.isOld)
         {
            CacheSysManager.getInstance().cacheFunction("alertInHall",new FunctionAction(new ShopRechargeEquipServer().show));
         }
         else
         {
            InventoryItemInfo.startTimer();
         }
         if(AcademyManager.Instance.isRecommend())
         {
            CacheSysManager.getInstance().cacheFunction("alertInHall",new FunctionAction(AcademyManager.Instance.recommend));
         }
         _isAddFrameComplete = true;
      }
      
      private function loadWeakGuild() : void
      {
         if(!WeakGuildManager.Instance.switchUserGuide || PlayerManager.Instance.Self.IsWeakGuildFinish(950))
         {
            return;
         }
         WeakGuildManager.Instance.checkFunction();
         if(PlayerManager.Instance.Self.IsWeakGuildFinish(1))
         {
            if(!PlayerManager.Instance.Self.IsWeakGuildFinish(3))
            {
               showBuildOpen(3,"asset.trainer.openGameRoom");
            }
            else if(!PlayerManager.Instance.Self.IsWeakGuildFinish(4))
            {
               buildShine(4,"asset.trainer.RoomShineAsset","trainer.posBuildGameRoom");
            }
         }
         if(PlayerManager.Instance.Self.IsWeakGuildFinish(15))
         {
            if(!PlayerManager.Instance.Self.IsWeakGuildFinish(64))
            {
               if(!DragonBoatManager.instance.isStart)
               {
                  showBuildOpen(64,"asset.trainer.openConsortia");
               }
            }
            else if(!PlayerManager.Instance.Self.IsWeakGuildFinish(65))
            {
               if(!DragonBoatManager.instance.isStart)
               {
                  buildShine(65,"asset.trainer.shineConsortia","trainer.posBuildConsortia");
               }
            }
         }
         if(PlayerManager.Instance.Self.IsWeakGuildFinish(16))
         {
            if(!PlayerManager.Instance.Self.IsWeakGuildFinish(66))
            {
               showBuildOpen(66,"asset.trainer.openDungeon");
            }
            else if(!PlayerManager.Instance.Self.IsWeakGuildFinish(67))
            {
               buildShine(67,"asset.trainer.shineDungeon","trainer.posBuildDungeon");
            }
         }
         if(PlayerManager.Instance.Self.IsWeakGuildFinish(35))
         {
            if(!PlayerManager.Instance.Self.IsWeakGuildFinish(36))
            {
               showBuildOpen(36,"asset.trainer.openChurch");
            }
            else if(!PlayerManager.Instance.Self.IsWeakGuildFinish(37))
            {
               buildShine(37,"asset.trainer.shineChurch","trainer.posBuildChurch");
            }
         }
         if(PlayerManager.Instance.Self.IsWeakGuildFinish(76))
         {
            if(!PlayerManager.Instance.Self.IsWeakGuildFinish(77))
            {
               showBuildOpen(77,"asset.trainer.openToffList");
            }
            else if(!PlayerManager.Instance.Self.IsWeakGuildFinish(78))
            {
               buildShine(78,"asset.trainer.shineToffList","trainer.posBuildToffList");
            }
         }
         if(PlayerManager.Instance.Self.IsWeakGuildFinish(82))
         {
            if(!PlayerManager.Instance.Self.IsWeakGuildFinish(83))
            {
               showBuildOpen(83,"asset.trainer.openAuction");
            }
            else if(!PlayerManager.Instance.Self.IsWeakGuildFinish(84))
            {
               buildShine(84,"asset.trainer.shineAuction","trainer.posBuildAuction");
            }
         }
      }
      
      private function __taskFrameHide(param1:Event) : void
      {
         loadWeakGuild();
      }
      
      private function checkShowVote() : void
      {
         if(VoteManager.Instance.showVote)
         {
            VoteManager.Instance.addEventListener(VoteManager.LOAD_COMPLETED,__vote);
            if(VoteManager.Instance.loadOver)
            {
               VoteManager.Instance.removeEventListener(VoteManager.LOAD_COMPLETED,__vote);
               VoteManager.Instance.openVote();
            }
         }
      }
      
      private function sevendoubleEndHandler(param1:Event) : void
      {
         HallIconManager.instance.updateSwitchHandler("sevendouble",false);
      }
      
      private function sevenDoubleIconResLoadComplete(param1:Event) : void
      {
         SevenDoubleManager.instance.removeEventListener("sevenDoubleIconResLoadComplete",sevenDoubleIconResLoadComplete);
         if(SevenDoubleManager.instance.isStart && SevenDoubleManager.instance.isLoadIconComplete)
         {
            HallIconManager.instance.updateSwitchHandler("sevendouble",true);
            SevenDoubleManager.instance.addEventListener("sevenDoubleEnd",sevendoubleEndHandler);
         }
         else
         {
            SevenDoubleManager.instance.addEventListener("sevenDoubleIconResLoadComplete",sevenDoubleIconResLoadComplete);
         }
      }
      
      private function escortEndHandler(param1:Event) : void
      {
         HallIconManager.instance.updateSwitchHandler("escort",false);
      }
      
      private function escortIconResLoadComplete(param1:Event) : void
      {
         EscortManager.instance.removeEventListener("escortIconResLoadComplete",escortIconResLoadComplete);
         if(EscortManager.instance.isStart && EscortManager.instance.isLoadIconComplete)
         {
            HallIconManager.instance.updateSwitchHandler("escort",true);
            EscortManager.instance.addEventListener("escortEnd",escortEndHandler);
         }
         else
         {
            EscortManager.instance.addEventListener("escortIconResLoadComplete",escortIconResLoadComplete);
         }
      }
      
      private function checkShowVipAlert() : void
      {
         var _loc2_:* = null;
         var _loc1_:SelfInfo = PlayerManager.Instance.Self;
         if(!_loc1_.isSameDay && !VipController.instance.isRechargePoped)
         {
            VipController.instance.isRechargePoped = true;
            if(_loc1_.IsVIP)
            {
               if(_loc1_.VIPLeftDays <= 3 && _loc1_.VIPLeftDays >= 0 || _loc1_.VIPLeftDays == 7)
               {
                  _loc2_ = "";
                  if(_loc1_.VIPLeftDays == 0)
                  {
                     if(_loc1_.VipLeftHours > 0)
                     {
                        _loc2_ = LanguageMgr.GetTranslation("ddt.vip.vipView.expiredToday",_loc1_.VipLeftHours);
                     }
                     else if(_loc1_.VipLeftHours == 0)
                     {
                        _loc2_ = LanguageMgr.GetTranslation("ddt.vip.vipView.expiredHour");
                     }
                     else
                     {
                        _loc2_ = LanguageMgr.GetTranslation("ddt.vip.vipView.expiredTrue");
                     }
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("ddt.vip.vipView.expired",_loc1_.VIPLeftDays);
                  }
                  _renewal = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc2_,LanguageMgr.GetTranslation("ddt.vip.vipView.RenewalNow"),"",false,false,false,2);
                  _renewal.moveEnable = false;
                  _renewal.addEventListener("response",__goRenewal);
               }
            }
            else if(_loc1_.VIPExp > 0)
            {
               if(_loc1_.LastDate.valueOf() < _loc1_.VIPExpireDay.valueOf() && _loc1_.VIPExpireDay.valueOf() <= _loc1_.systemDate.valueOf())
               {
                  _renewal = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.vip.vipView.expiredTrue"),LanguageMgr.GetTranslation("ddt.vip.vipView.RenewalNow"),"",false,false,false,2);
                  _renewal.moveEnable = false;
                  _renewal.addEventListener("response",__goRenewal);
               }
            }
         }
      }
      
      private function checkShowVipAlert_New() : void
      {
         var _loc1_:SelfInfo = PlayerManager.Instance.Self;
         if(!_loc1_.isSameDay && !VipController.instance.isRechargePoped)
         {
            VipController.instance.isRechargePoped = true;
            if(_loc1_.IsVIP)
            {
               if(_loc1_.VIPLeftDays <= 3 && _loc1_.VIPLeftDays >= 0 || _loc1_.VIPLeftDays == 7)
               {
                  VipController.instance.showRechargeAlert();
               }
            }
            else if(_loc1_.VIPExp > 0)
            {
               VipController.instance.showRechargeAlert();
            }
         }
      }
      
      private function __goRenewal(param1:FrameEvent) : void
      {
         _renewal.removeEventListener("response",__goRenewal);
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               VipController.instance.show();
         }
         _renewal.dispose();
         if(_renewal.parent)
         {
            _renewal.parent.removeChild(_renewal);
         }
         _renewal = null;
      }
      
      private function __vote(param1:Event) : void
      {
         VoteManager.Instance.removeEventListener(VoteManager.LOAD_COMPLETED,__vote);
         VoteManager.Instance.openVote();
      }
      
      private function checkShowStoreFromShop() : void
      {
         if(BagStore.instance.isFromShop)
         {
            BagStore.instance.isFromShop = false;
            BagStore.instance.openStore();
         }
      }
      
      private function toFightLib() : void
      {
         if(!WeakGuildManager.Instance.checkOpen(85,15))
         {
            WeakGuildManager.Instance.showBuildPreview("campaignLab_mc",LanguageMgr.GetTranslation("tank.hall.ChooseHallView.campaignLabAlert"));
            return;
         }
         if(PlayerManager.Instance.Self.Grade < 15)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",15));
            return;
         }
         if(PathManager.getFightLibEanble())
         {
            StateManager.setState("fightLib");
            ComponentSetting.SEND_USELOG_ID(12);
            if(PlayerManager.Instance.Self.IsWeakGuildFinish(85) && !PlayerManager.Instance.Self.IsWeakGuildFinish(87))
            {
               SocketManager.Instance.out.syncWeakStep(87);
            }
         }
         else
         {
            createBattle();
         }
      }
      
      private function toDungeon() : void
      {
         if(!WeakGuildManager.Instance.checkOpen(16,10))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",10));
            return;
         }
         if(!PlayerManager.Instance.checkEnterDungeon)
         {
            return;
         }
         StateManager.currentStateType = "dungeon";
         DungeonListManager.instance.enter();
         ComponentSetting.SEND_USELOG_ID(4);
         if(PlayerManager.Instance.Self.IsWeakGuildFinish(16) && !PlayerManager.Instance.Self.IsWeakGuildFinish(67))
         {
            NoviceDataManager.instance.saveNoviceData(1030,PathManager.userName(),PathManager.solveRequestPath());
            SocketManager.Instance.out.syncWeakStep(67);
         }
      }
      
      private function __btnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("047");
         param1.stopPropagation();
         _btnID = _btnList.indexOf(param1.currentTarget);
         var _loc2_:starling.scene.hall.HallPlayerView = starlingHallScene.playerView;
         _loc2_.MapClickFlag = false;
         _loc2_.setSelfPlayerPos(_selfPosArray[_btnID],true,true);
         dispatchEvent(new CEvent("hall_area_clicked"));
      }
      
      public function __onBtnClick() : void
      {
         dispatchEvent(new CEvent("hall_player_arrived"));
         var _loc1_:* = _btnID;
         if(0 !== _loc1_)
         {
            if(1 !== _loc1_)
            {
               if(2 !== _loc1_)
               {
                  if(3 !== _loc1_)
                  {
                     if(4 !== _loc1_)
                     {
                        if(5 !== _loc1_)
                        {
                           if(6 !== _loc1_)
                           {
                              if(7 !== _loc1_)
                              {
                                 if(9 !== _loc1_)
                                 {
                                    if(10 !== _loc1_)
                                    {
                                       if(11 !== _loc1_)
                                       {
                                          if(12 !== _loc1_)
                                          {
                                             if(13 !== _loc1_)
                                             {
                                                if(14 !== _loc1_)
                                                {
                                                   if(15 !== _loc1_)
                                                   {
                                                      if(16 !== _loc1_)
                                                      {
                                                         if(17 !== _loc1_)
                                                         {
                                                            if(18 !== _loc1_)
                                                            {
                                                               if(19 === _loc1_)
                                                               {
                                                                  if(!WeakGuildManager.Instance.checkOpen(PlayerManager.Instance.Self.Grade,20))
                                                                  {
                                                                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",20));
                                                                     return;
                                                                  }
                                                                  RewardTaskManager.instance.show();
                                                               }
                                                            }
                                                            else
                                                            {
                                                               HotSpringManager.instance.showStateView();
                                                            }
                                                         }
                                                         else
                                                         {
                                                            MagicHouseModel.instance.viewIndex = 0;
                                                            MagicHouseManager.instance.show();
                                                         }
                                                      }
                                                      else
                                                      {
                                                         DragonBoatManager.instance.show();
                                                      }
                                                   }
                                                   else
                                                   {
                                                      DrgnBoatBuildManager.instance.show();
                                                   }
                                                }
                                                else
                                                {
                                                   BombKingManager.instance.onPlayerClicked(1);
                                                }
                                             }
                                             else
                                             {
                                                BombKingManager.instance.onPlayerClicked(0);
                                             }
                                          }
                                          else
                                          {
                                             BombKingManager.instance.onPlayerClicked(2);
                                          }
                                       }
                                       else
                                       {
                                          if(!WeakGuildManager.Instance.checkOpen(82,18))
                                          {
                                             MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",18));
                                             return;
                                          }
                                          StateManager.setState("auction");
                                          ComponentSetting.SEND_USELOG_ID(7);
                                          if(PlayerManager.Instance.Self.IsWeakGuildFinish(82) && !PlayerManager.Instance.Self.IsWeakGuildFinish(84))
                                          {
                                             SocketManager.Instance.out.syncWeakStep(84);
                                          }
                                       }
                                    }
                                    else
                                    {
                                       if(WeakGuildManager.Instance.switchUserGuide && !PlayerManager.Instance.Self.IsWeakGuildFinish(950))
                                       {
                                          if(PlayerManager.Instance.Self.Grade < 5)
                                          {
                                             MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",5));
                                             return;
                                          }
                                       }
                                       BagStore.instance.openStore("bag_store");
                                       ComponentSetting.SEND_USELOG_ID(2);
                                    }
                                 }
                                 else
                                 {
                                    if(!WeakGuildManager.Instance.checkOpen(15,17))
                                    {
                                       MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",17));
                                       return;
                                    }
                                    new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.createConsortiaBossTemplateLoader],gotoConsortia);
                                 }
                              }
                              else
                              {
                                 GypsyShopManager.getInstance().show();
                              }
                           }
                           else
                           {
                              if(!WeakGuildManager.Instance.checkOpen(35,14))
                              {
                                 MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",14));
                                 return;
                              }
                              StateManager.setState("ddtchurchroomlist");
                              ComponentSetting.SEND_USELOG_ID(6);
                              if(PlayerManager.Instance.Self.IsWeakGuildFinish(35) && !PlayerManager.Instance.Self.IsWeakGuildFinish(37))
                              {
                                 SocketManager.Instance.out.syncWeakStep(37);
                              }
                           }
                        }
                        else
                        {
                           if(!WeakGuildManager.Instance.checkOpen(35,45))
                           {
                              MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",45));
                              return;
                           }
                           showCryptBossFrame();
                        }
                     }
                     else
                     {
                        if(!WeakGuildManager.Instance.checkOpen(35,27))
                        {
                           MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",27));
                           return;
                        }
                        ringStationShow();
                     }
                  }
                  else
                  {
                     FarmModelController.instance.goFarm(PlayerManager.Instance.Self.ID,PlayerManager.Instance.Self.NickName);
                  }
               }
               else
               {
                  if(!WeakGuildManager.Instance.checkOpen(76,30))
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",30));
                     return;
                  }
                  LabyrinthManager.Instance.show();
               }
            }
            else
            {
               if(!WeakGuildManager.Instance.checkOpen(1,2))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",2));
                  return;
               }
               StateManager.currentStateType = "roomlist";
               RoomListManager.instance.enter();
               ComponentSetting.SEND_USELOG_ID(3);
               if(PlayerManager.Instance.Self.IsWeakGuildFinish(1) && !PlayerManager.Instance.Self.IsWeakGuildFinish(4))
               {
                  NoviceDataManager.instance.saveNoviceData(490,PathManager.userName(),PathManager.solveRequestPath());
                  SocketManager.Instance.out.syncWeakStep(4);
               }
            }
         }
         else
         {
            toDungeon();
         }
         _btnID = -1;
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
      
      public function showWonderfulView() : void
      {
         var _loc1_:* = null;
         if(WonderfulActivityManager.Instance.hasActivity)
         {
            openWonderfulActivityView(null);
         }
         else
         {
            _loc1_ = new WonderfulInfoView();
            _loc1_.show(1,LanguageMgr.GetTranslation("wonderfulActivityManager.tittle") + ":",LanguageMgr.GetTranslation("wonderful.activity.infoViewText"));
            LayerManager.Instance.addToLayer(_loc1_,3,true,1);
         }
      }
      
      private function loadUserGuide() : void
      {
         var _loc1_:Boolean = false;
         if(NewHandGuideManager.Instance.progress < 11 && WeakGuildManager.Instance.switchUserGuide)
         {
            if(PathManager.TRAINER_STANDALONE && !PlayerManager.Instance.Self.IsWeakGuildFinish(2))
            {
               SocketManager.Instance.out.syncStep(11,true);
               _loc1_ = PlayerManager.Instance.Self.IsWeakGuildFinish(144);
               if(!PlayerManager.Instance.Self.IsWeakGuildFinish(144))
               {
                  prePopWelcome();
               }
               sendToLoginInterface();
               DuowanInterfaceManage.Instance.dispatchEvent(new DuowanInterfaceEvent("addRole"));
            }
         }
         MainToolBar.Instance.tipTask();
      }
      
      private function sendToLoginInterface() : void
      {
         var _loc2_:* = null;
         var _loc4_:URLVariables = new URLVariables();
         var _loc1_:String = PlayerManager.Instance.Self.ID.toString();
         _loc1_ = encodeURI(_loc1_);
         var _loc5_:String = "sdkxccjlqaoehtdwjkdycdrw";
         _loc4_["username"] = _loc1_;
         _loc4_["sign"] = MD5.hash(_loc1_ + _loc5_);
         var _loc3_:String = PathManager.callLoginInterface();
         if(_loc3_)
         {
            _loc2_ = LoadResourceManager.Instance.createLoader(_loc3_,6,_loc4_);
            LoadResourceManager.Instance.startLoad(_loc2_);
         }
      }
      
      private function prePopWelcome() : void
      {
         if(_PopWelcomeDisplayed)
         {
            return;
         }
         _PopWelcomeDisplayed = true;
         _trainerWelcomeView = ComponentFactory.Instance.creat("trainer.welcome.mainFrame");
         _trainerWelcomeView.addEventListener("response",__trainerResponse);
         _trainerWelcomeView.show();
      }
      
      private function __trainerResponse(param1:FrameEvent) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:* = undefined;
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            param1.currentTarget.removeEventListener("response",__trainerResponse);
            SoundManager.instance.play("008");
            _loc3_ = PathManager.TRAINER_STANDALONE;
            _loc2_ = PlayerManager.Instance.Self.IsWeakGuildFinish(2);
            if(!PathManager.TRAINER_STANDALONE && !PlayerManager.Instance.Self.IsWeakGuildFinish(2))
            {
               NewHandGuideManager.Instance.mapID = 111;
               SocketManager.Instance.out.createUserGuide();
            }
            finPopWelcome();
            NoviceDataManager.instance.saveNoviceData(330,PathManager.userName(),PathManager.solveRequestPath());
         }
      }
      
      private function exePopWelcome() : Boolean
      {
         return RoomManager.Instance.current != null;
      }
      
      private function finPopWelcome() : void
      {
         var _loc1_:* = null;
         if(_trainerWelcomeView)
         {
            _trainerWelcomeView.dispose();
            _trainerWelcomeView = null;
         }
         if(PlayerManager.Instance.Self.Sex)
         {
            _loc1_ = ComponentFactory.Instance.creatBitmap("asset.hall.maleImg");
         }
         else
         {
            _loc1_ = ComponentFactory.Instance.creatBitmap("asset.hall.femaleImg");
         }
         _dialog = new NewOpenGuideDialogView();
         _dialog.show(LanguageMgr.GetTranslation("newOpenGuide.firstEnterPrompt1"),PlayerManager.Instance.Self.NickName,_loc1_,new Point(163,339));
         _dialog.addEventListener("click",dialogNextHandler);
         LayerManager.Instance.addToLayer(_dialog,0);
      }
      
      private function dialogNextHandler(param1:MouseEvent) : void
      {
         _dialog.removeEventListener("click",dialogNextHandler);
         _dialog.show(LanguageMgr.GetTranslation("newOpenGuide.firstEnterPrompt2",PlayerManager.Instance.Self.NickName));
         _dialog.addEventListener("click",dialogNextHandler2);
      }
      
      private function dialogNextHandler2(param1:MouseEvent) : void
      {
         _dialog.removeEventListener("click",dialogNextHandler2);
         ObjectUtils.disposeObject(_dialog);
         _dialog = null;
      }
      
      private function createBattle() : void
      {
         _battleFrame = ComponentFactory.Instance.creatComponentByStylename("hall.battleFrame");
         _battleFrame.titleText = LanguageMgr.GetTranslation("tank.hall.ChooseHallView.campaignLabAlert");
         _battleFrame.addEventListener("response",__frameEventHandler);
         _battlePanel = ComponentFactory.Instance.creatComponentByStylename("hall.battleSrollPanel");
         _battleFrame.addToContent(_battlePanel);
         _battleImg = ComponentFactory.Instance.creatBitmap("asset.hall.battleLABS");
         _battlePanel.setView(_battleImg);
         _battleBtn = ComponentFactory.Instance.creatComponentByStylename("hall.battleBtn");
         _battleBtn.text = LanguageMgr.GetTranslation("tank.room.RoomIIView2.affirm");
         _battleFrame.addToContent(_battleBtn);
         _battleBtn.addEventListener("click",__battleBtnClick);
         LayerManager.Instance.addToLayer(_battleFrame,3,true,1);
      }
      
      private function showSPAAlert() : void
      {
         var _loc1_:Frame = ComponentFactory.Instance.creatComponentByStylename("hall.hotSpringAlertFrame");
         _loc1_.addEventListener("response",__onRespose);
         LayerManager.Instance.addToLayer(_loc1_,3,true,1);
      }
      
      private function __onRespose(param1:FrameEvent) : void
      {
         var _loc2_:Frame = param1.currentTarget as Frame;
         _loc2_.removeEventListener("response",__onRespose);
         _loc2_.dispose();
      }
      
      private function __battleBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         battleFrameClose();
      }
      
      private function battleFrameClose() : void
      {
         _battleFrame.removeEventListener("response",__frameEventHandler);
         _battleBtn.removeEventListener("click",__battleBtnClick);
         _battlePanel = null;
         _battleImg = null;
         _battleFrame.dispose();
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               battleFrameClose();
         }
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         BackgoundView.Instance.show();
         if(_playerInfoView)
         {
            _playerInfoView.dispose();
            _playerInfoView = null;
         }
         if(_playerOperateView)
         {
            _playerOperateView.dispose();
            _playerOperateView = null;
         }
         if(_systemPost)
         {
            _systemPost.dispose();
            _systemPost = null;
         }
         BombKingManager.instance.removeFromeHallStateView(this);
         AngelInvestmentManager.instance.initHall(false);
         GypsyShopManager.getInstance().hideNPC();
         GypsyShopManager.getInstance().dispose();
         LanternFestivalManager.getInstance().dispose();
         WorshipTheMoonManager.getInstance().dispose();
         if(_playerView)
         {
            _playerView.dispose();
            _playerView = null;
         }
         FlowerGivingManager.instance.hallView = null;
         removeDdtActiviyIconState();
         WonderfulActivityManager.Instance.removeEventListener("check_activity_state",__checkShowWonderfulActivityTip);
         LeftGunRouletteManager.instance.removeEventListener("leftGun_enable",__leftGunShow);
         if(_wantStrongBtn)
         {
            _wantStrongBtn.removeEventListener("click",wantStrongtnHandler);
         }
         WantStrongManager.Instance.removeEventListener("alreadyUpdateTime",__alreadyUpdateTimeHandler);
         WantStrongManager.Instance.removeEventListener("alreadyFindBack",__alreadyFindBackHandler);
         LeftGunRouletteManager.instance.hideGunButton();
         VoteManager.Instance.removeEventListener(VoteManager.LOAD_COMPLETED,__vote);
         TaskManager.instance.removeEventListener("taskFrameHide",__taskFrameHide);
         SocketManager.Instance.removeEventListener(PkgEvent.format(165),__getLuckStoneEnable);
         MainToolBar.Instance.hide();
         MainToolBar.Instance.updateReturnBtn(1);
         DailyButtunBar.Insance.hide();
         KingBlessManager.instance.clearConfirmFrame();
         ConsortiaBattleManager.instance.disposeEntryBtn();
         NewHandContainer.Instance.hideGuideCover();
         NewHandContainer.Instance.clearArrowByID(10);
         SystemOpenPromptManager.instance.dispose();
         FirstRechargeManger.Instance.openFun = null;
         if(_firstRechargeBtn && _firstRechargeBtn.backgound)
         {
            (_firstRechargeBtn.backgound as MovieClip).gotoAndStop(5);
         }
         if(_timer && _timer.running)
         {
            _timer.stop();
         }
         LeagueManager.instance.deleLeaIcon = null;
         if(_activityIcon)
         {
            _activityIcon.movie.gotoAndStop(2);
            _activityIcon.removeEventListener("click",__openActivityView);
            _activityIcon.dispose();
         }
         _activityIcon = null;
         if(_firstRechargeBtn)
         {
            _firstRechargeBtn.removeEventListener("click",openFristrechargeView);
            _firstRechargeBtn.dispose();
            _firstRechargeBtn = null;
         }
         if(_shine)
         {
            while(_shine.length > 0)
            {
               _shine.shift().dispose();
            }
            _shine = null;
         }
         if(_black)
         {
            ObjectUtils.disposeObject(_black);
            _black = null;
         }
         if(_btnList)
         {
            _loc3_ = 0;
            while(_loc3_ < _btnList.length)
            {
               _btnList[_loc3_].removeEventListener("click",__btnClick);
               _btnList[_loc3_].dispose();
               _btnList[_loc3_] = null;
               _loc3_++;
            }
            _btnList.length = 0;
         }
         _btnList = null;
         if(_btnTipList)
         {
            _loc2_ = 0;
            while(_loc2_ < _btnTipList.length)
            {
               _btnTipList[_loc2_].dispose();
               _btnTipList[_loc2_] = null;
               _loc2_++;
            }
            _btnTipList.length = 0;
         }
         _btnTipList = null;
         if(_LevelIcon)
         {
            _LevelIcon.bitmapData.dispose();
            _LevelIcon = null;
         }
         if(_leagueBtn)
         {
            _leagueBtn.removeEventListener("click",leagueBtnHander);
            _leagueBtn.gotoAndStop(1);
            ObjectUtils.disposeObject(_leagueBtn);
            _leagueBtn = null;
         }
         if(_campBtn)
         {
            _campBtn.removeEventListener("click",campBtnHander);
            _campBtn.gotoAndStop(1);
            ObjectUtils.disposeObject(_campBtn);
            _campBtn = null;
         }
         ExchangeActManager.Instance.deleteWonderfulIcon();
         WorldBossManager.Instance.disposeEnterBtn();
         if(_goSignBtn)
         {
            ObjectUtils.disposeObject(_goSignBtn);
         }
         _goSignBtn = null;
         if(_awardBtn)
         {
            ObjectUtils.disposeObject(_awardBtn);
         }
         _awardBtn = null;
         if(_angelblessIcon)
         {
            ObjectUtils.disposeObject(_angelblessIcon);
         }
         _angelblessIcon = null;
         GradeAwardsBoxButtonManager.getInstance().dispose();
         ObjectUtils.disposeObject(_wantStrongBtn);
         _wantStrongBtn = null;
         ObjectUtils.disposeObject(_sevenDoubleBtn);
         _sevenDoubleBtn = null;
         ObjectUtils.disposeObject(_escortEntryBtn);
         _escortEntryBtn = null;
         ObjectUtils.disposeObject(_drgnBoatEntryBtn);
         _drgnBoatEntryBtn = null;
         if(_littleGameNote)
         {
            _littleGameNote.removeEventListener("click",__OpenlittleGame);
            ObjectUtils.disposeObject(_littleGameNote);
         }
         _littleGameNote = null;
         if(_limitAwardButton)
         {
            ObjectUtils.disposeObject(_limitAwardButton);
         }
         _limitAwardButton = null;
         if(PathManager.solveWeeklyEnable())
         {
            TimesManager.Instance.hideButton();
         }
         if(param1.getType() != "dungeon" && param1.getType() != "roomlist")
         {
            GameInSocketOut.sendExitScene();
         }
         CatchBeastManager.instance.deleteCatchBeastBtn();
         LanternRiddlesManager.instance.deleteLanternBtn();
         FoodActivityManager.Instance.deleteBtn();
         NationDayManager.instance.deleteNaitonBtn();
         TreasureManager.instance.deleteTreasureIcon();
         DraftManager.instance.deleteDraftIcon();
         RecordManager.Instance.deleteIcon();
         DemonChiYouManager.instance.deleteIcon();
         ConsortiaDomainManager.instance.deleteIcon();
         ObjectUtils.disposeObject(_taskTrackMainView);
         _taskTrackMainView = null;
         HallTaskTrackManager.instance.btnList = null;
         if(_bgSprite)
         {
            ObjectUtils.disposeAllChildren(_bgSprite);
            _bgSprite = null;
         }
         NewOpenGuideManager.instance.closeShow();
         PlayerManager.Instance.Self.removeEventListener("propertychange",__propertyChange);
         HalloweenManager.instance.deleteHallView();
         ConsortionModelManager.Instance.TaskModel.removeEventListener("getConsortiaTaskInfo",__getTaskInfo);
         SocketManager.Instance.removeEventListener(PkgEvent.format(129,3),__renegadeUser);
         SocketManager.Instance.removeEventListener(PkgEvent.format(128),__consortiaResponse);
         ConsortionModelManager.Instance.hideEnterBtnInHallStateView(this);
         FloatParadeIconManager.instance.disposeIcion();
         ObjectUtils.disposeAllChildren(this);
         GradeBuyManager.getInstance().setHall(null);
         if(_hallRightIconView)
         {
            ObjectUtils.disposeObject(_hallRightIconView);
            _hallRightIconView = null;
         }
         if(_leftTopGbox)
         {
            _leftTopGbox.dispose();
            _leftTopGbox = null;
         }
         _ddQiYuanActivityIcon = null;
         starlingHallScene = null;
         _callBackFundIcon = null;
         _callBackLotteryDrawIcon = null;
         super.leaving(param1);
      }
      
      override public function prepare() : void
      {
         super.prepare();
         _isFirst = true;
      }
      
      override public function fadingComplete() : void
      {
         var _loc1_:* = null;
         super.fadingComplete();
         if(_isFirst)
         {
            _isFirst = false;
            if(LoaderSavingManager.cacheAble == false && PlayerManager.Instance.Self.IsFirst > 1 && PlayerManager.Instance.Self.LastServerId == -1)
            {
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("hall.SaveFileWidow");
               _loc1_.show();
            }
            LeavePageManager.setFavorite(PlayerManager.Instance.Self.IsFirst <= 1);
         }
      }
      
      private function showBuildOpen(param1:int, param2:String) : void
      {
         var _loc4_:* = null;
         if(StateManager.currentStateType != "main")
         {
            return;
         }
         SocketManager.Instance.out.syncWeakStep(param1);
      }
      
      private function __completeGameRoom(param1:Event) : void
      {
         MovieClipWrapper(param1.currentTarget).removeEventListener("complete",__completeGameRoom);
         buildShine(4,"asset.trainer.RoomShineAsset","trainer.posBuildGameRoom");
      }
      
      private function __completeConsortia(param1:Event) : void
      {
         MovieClipWrapper(param1.currentTarget).removeEventListener("complete",__completeConsortia);
         buildShine(65,"asset.trainer.shineConsortia","trainer.posBuildConsortia");
      }
      
      private function __completeDungeon(param1:Event) : void
      {
         MovieClipWrapper(param1.currentTarget).removeEventListener("complete",__completeDungeon);
         buildShine(67,"asset.trainer.shineDungeon","trainer.posBuildDungeon");
      }
      
      private function __completeChurch(param1:Event) : void
      {
         MovieClipWrapper(param1.currentTarget).removeEventListener("complete",__completeChurch);
         buildShine(37,"asset.trainer.shineChurch","trainer.posBuildChurch");
      }
      
      private function __completeToffList(param1:Event) : void
      {
         MovieClipWrapper(param1.currentTarget).removeEventListener("complete",__completeToffList);
         buildShine(78,"asset.trainer.shineToffList","trainer.posBuildToffList");
      }
      
      private function __completeAuction(param1:Event) : void
      {
         MovieClipWrapper(param1.currentTarget).removeEventListener("complete",__completeAuction);
         buildShine(84,"asset.trainer.shineAuction","trainer.posBuildAuction");
      }
      
      private function __onClickServerName(param1:MouseEvent) : void
      {
      }
      
      private function buildShine(param1:int, param2:String, param3:String) : void
      {
      }
      
      override public function refresh() : void
      {
         var _loc1_:StageCurtain = new StageCurtain();
         _loc1_.play(25);
         LayerManager.Instance.clearnGameDynamic();
         StateManager.currentStateType = "main";
         ShowTipManager.Instance.removeAllTip();
         ChatManager.Instance.state = 0;
         ChatManager.Instance.view.visible = true;
         ChatManager.Instance.lock = ChatManager.HALL_CHAT_LOCK;
         ChatManager.Instance.chatDisabled = false;
         addChild(ChatManager.Instance.view);
         super.refresh();
      }
      
      private function checkShowWorldBossEntrance() : void
      {
         WorldBossManager.Instance.showEntranceBtn();
      }
      
      private function checkGuide() : void
      {
         checkHorseAmuletGuide();
      }
      
      private function checkHorseAmuletGuide() : void
      {
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(141))
         {
            if(PlayerManager.Instance.Self.Grade >= 31)
            {
               NewHandContainer.Instance.showArrow(100000,0,new Point(747,478),"","",LayerManager.Instance.getLayerByType(2),0,true);
            }
         }
      }
      
      private function checkShowWorldBossHelper() : void
      {
         if(WorldBossManager.Instance.bossInfo && !WorldBossManager.Instance.bossInfo.fightOver && WorldBossHelperManager.Instance.helperOpen && !WorldBossHelperManager.Instance.isInWorldBossHelperFrame && !WorldBossHelperManager.Instance.isHelperInited)
         {
            if(WorldBossHelperManager.Instance.isHelperOnlyOnce)
            {
               if(WorldBossManager.Instance.worldBossNum > 1)
               {
                  return;
               }
               WorldBossHelperManager.Instance.show();
            }
            else
            {
               WorldBossHelperManager.Instance.show();
            }
         }
      }
      
      public function setBgSpriteCenter(param1:int, param2:int) : void
      {
         if(_bgSprite)
         {
            _bgSprite.x = param1;
            _bgSprite.y = param2;
         }
      }
      
      public function get ringStationClickDate() : Number
      {
         return _ringStationClickDate;
      }
      
      public function get leftTopGbox() : GridBox
      {
         return _leftTopGbox;
      }
      
      public function get bgSprite() : Sprite
      {
         return _bgSprite;
      }
   }
}
