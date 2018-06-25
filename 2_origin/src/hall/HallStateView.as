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
      
      private var _bitmap12:Bitmap;
      
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
      
      private static function onSampleDataHandler(e:SampleDataEvent) : void
      {
         var _loc2_:int = 16384;
         e.data.length = _loc2_;
         e.data.position = _loc2_;
      }
      
      override public function set x(value:Number) : void
      {
         .super.x = value;
      }
      
      private function initEvent() : void
      {
         _timer = new Timer(1000);
         _timer.addEventListener("timer",_checkActivityPer);
         LabyrinthManager.Instance.addEventListener("LabyrinthChat",__labyrinthChat);
      }
      
      private function onKeyUp(evt:KeyboardEvent) : void
      {
         var keyCode:uint = evt.keyCode;
         if(keyCode == 65)
         {
            IndianaDataManager.instance.show();
         }
      }
      
      protected function __labyrinthChat(event:Event) : void
      {
         LayerManager.Instance.addToLayer(ChatManager.Instance.view,3);
      }
      
      private function __getLuckStoneEnable(e:PkgEvent) : void
      {
         var open:Boolean = false;
         var p:PackageIn = e.pkg;
         startDate = p.readDate();
         endDate = p.readDate();
         isActiv = p.readBoolean();
         var nowDate:Date = TimeManager.Instance.Now();
         if(nowDate.getTime() >= startDate.getTime() && nowDate.getTime() <= endDate.getTime())
         {
            open = true;
         }
         WonderfulActivityManager.Instance.rouleEndTime = endDate;
         if(isActiv && open)
         {
            WonderfulActivityManager.Instance.addElement(1);
            WonderfulActivityManager.Instance.hasActivity = true;
         }
         else
         {
            WonderfulActivityManager.Instance.removeElement(1);
         }
      }
      
      private function _checkActivityPer(event:TimerEvent) : void
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
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         var i:int = 0;
         starlingHallScene = HallScene(StarlingMain.instance.currentScene);
         _btnList = [];
         _btnTipList = [];
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(131))
         {
            SocketManager.Instance.out.syncWeakStep(131);
            NoviceDataManager.instance.saveNoviceData(320,PathManager.userName(),PathManager.solveRequestPath());
         }
         KeyboardShortcutsManager.Instance.cancelForbidden();
         super.enter(prev,data);
         if(data is Function)
         {
            data();
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
         i = 0;
         while(i < _needShowOpenTipActArr.length)
         {
            if(!_isShowActTipDic[_needShowOpenTipActArr[i]])
            {
               _isShowActTipDic[_needShowOpenTipActArr[i]] = false;
            }
            i++;
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
      
      protected function __consortiaResponse(e:PkgEvent) : void
      {
         checkConsortionTask();
      }
      
      protected function __renegadeUser(e:PkgEvent) : void
      {
         checkConsortionTask();
      }
      
      protected function __getTaskInfo(e:ConsortiaTaskEvent) : void
      {
         if(e.value == 3 || e.value == 2 || e.value == 4 || e.value == 5)
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
      
      private function __onHallLoadComplete(pEvent:UIModuleEvent) : void
      {
         if(pEvent.module == "ddtcorei")
         {
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onHallLoadComplete);
            initHall();
         }
      }
      
      private function initHall() : void
      {
         var levelIconS:* = null;
         var bm12S:* = null;
         var loaderQueue:* = null;
         var novicePlatinumCard:* = null;
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
            levelIconS = new Component();
            _LevelIcon = ComponentFactory.Instance.creatBitmap("asset.hall.LevelIcon");
            PositionUtils.setPos(levelIconS,"ddt.hall.LevelIconPostPos");
            levelIconS.addChild(_LevelIcon);
            levelIconS.tipStyle = "ddt.view.tips.MultipleLineTip";
            levelIconS.tipGapV = 25;
            levelIconS.tipGapH = 40;
            levelIconS.tipDirctions = "7,6,5";
            levelIconS.tipData = LanguageMgr.GetTranslation("ddt.hall.LevelIconLanguage");
         }
         if(!_bitmap12)
         {
            bm12S = new Component();
            _bitmap12 = ComponentFactory.Instance.creatBitmap("asset.hall.12+bitmap");
            PositionUtils.setPos(bm12S,"ddt.hall.LevelIconPostPos");
            bm12S.addChild(_bitmap12);
            addChild(bm12S);
         }
         var behavior:GypsyNPCBhvr = new GypsyNPCBhvr(null);
         behavior.hallView = this;
         GypsyShopManager.getInstance().npcBehavior = behavior;
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
            loaderQueue = new QueueLoader();
            if(!SoundManager.instance.audioComplete)
            {
               loaderQueue.addLoader(LoaderCreate.Instance.createAudioILoader());
            }
            if(!SoundManager.instance.audioiiComplete)
            {
               loaderQueue.addLoader(LoaderCreate.Instance.createAudioIILoader());
            }
            if(!SoundManager.instance.audioLiteComplete)
            {
               loaderQueue.addLoader(LoaderCreate.Instance.createAudioLiteLoader());
            }
            loaderQueue.addEventListener("complete",__onAudioLoadComplete);
            loaderQueue.start();
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
            novicePlatinumCard = ComponentFactory.Instance.creatComponentByStylename("core.NovicePlatinumCard");
            novicePlatinumCard.setup();
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
         var _loc8_:int = 0;
         var _loc7_:* = _btnList;
         for each(var obj in _btnList)
         {
            obj.alpha = 0;
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
      
      private function showDiceBtn(value:Boolean = false) : void
      {
         if(value)
         {
            DemonChiYouManager.instance.initHall(this);
         }
         ConsortiaDomainManager.instance.initHall(this);
         checkIsMaster();
         var _loc4_:int = 0;
         var _loc3_:* = _btnList;
         for each(var obj in _btnList)
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
      
      private function __checkAvatarCollectionTime(event:Event) : void
      {
         var i:int = 0;
         var data:* = null;
         var endTimestamp:Number = NaN;
         var nowTimestamp:Number = NaN;
         var chatData:* = null;
         if(event)
         {
            AvatarCollectionManager.instance.removeEventListener("avatar_collection_data_complete",__checkAvatarCollectionTime);
         }
         if(!AvatarCollectionManager.instance.maleUnitList)
         {
            return;
         }
         var dataArr:Array = AvatarCollectionManager.instance.maleUnitList;
         dataArr = dataArr.concat(AvatarCollectionManager.instance.femaleUnitList);
         dataArr = dataArr.concat(AvatarCollectionManager.instance.weaponUnitList);
         for(i = 0; i < dataArr.length; )
         {
            data = dataArr[i];
            if(!(!data.endTime || data.totalActivityItemCount < data.totalItemList.length / 2))
            {
               endTimestamp = data.endTime.getTime();
               nowTimestamp = TimeManager.Instance.Now().getTime();
               if(endTimestamp - nowTimestamp <= 0)
               {
                  chatData = new ChatData();
                  chatData.channel = 21;
                  chatData.childChannelArr = [7,14];
                  chatData.type = 108;
                  chatData.msg = LanguageMgr.GetTranslation("avatarCollection.noTime.tipTxt");
                  AvatarCollectionManager.instance.isCheckedAvatarTime = true;
                  ChatManager.Instance.chat(chatData);
                  AvatarCollectionManager.instance.skipId = data.id;
                  break;
               }
            }
            i++;
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
      
      private function __propertyChange(event:PlayerPropertyEvent) : void
      {
         if(event.changedProperties["Grade"])
         {
            initBuild();
            addButtonList();
         }
      }
      
      private function createBuildBtn() : void
      {
         var i:int = 0;
         var buildBtn:* = null;
         var buildTip:* = null;
         var buildObj:* = null;
         for(i = 0; i < 6; )
         {
            buildBtn = ComponentFactory.Instance.creatComponentByStylename("HallMain." + _btnArray[i] + "Btn");
            buildTip = new HallBuildTip();
            buildObj = {};
            buildObj["title"] = LanguageMgr.GetTranslation("ddt.hall.build." + _btnArray[i] + "title");
            buildObj["content"] = LanguageMgr.GetTranslation("ddt.HallStateView." + _btnArray[i]);
            buildTip.tipData = buildObj;
            PositionUtils.setPos(buildTip,"hall.build." + _btnArray[i] + "TipPos");
            _btnTipList.push(buildTip);
            _btnList.push(buildBtn);
            HallTaskTrackManager.instance.btnIndexMap[_btnArray[i]] = i;
            _playerView.touchArea.addChild(buildTip);
            _playerView.touchArea.addChild(buildBtn);
            i++;
         }
      }
      
      private function createNpcBtn() : void
      {
         var i:int = 0;
         var npcBtn:* = null;
         for(i = 6; i < _btnArray.length; )
         {
            npcBtn = ComponentFactory.Instance.creatComponentByStylename("HallMain." + _btnArray[i] + "Btn");
            _btnList.push(npcBtn);
            _playerView.touchArea.addChild(npcBtn);
            HallTaskTrackManager.instance.btnIndexMap[_btnArray[i]] = i;
            i++;
         }
      }
      
      private function initBuild() : void
      {
         var lv:int = PlayerManager.Instance.Self.Grade;
         setBuildState(0,lv >= 10?true:false);
         setBuildState(1,lv >= 3?true:false);
         setBuildState(2,lv >= 30?true:false);
         setBuildState(3,lv >= 19?true:false);
         setBuildState(4,false);
         setBuildState(5,lv >= 45?true:false);
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
      
      public function setNPCBtnEnable($baseBtn:Component, enable:Boolean) : void
      {
         if(enable)
         {
            $baseBtn.addEventListener("mouseMove",__btnOver);
            $baseBtn.addEventListener("mouseOut",__btnOut);
            $baseBtn.addEventListener("click",__btnClick);
         }
         else
         {
            $baseBtn.removeEventListener("mouseMove",__btnOver);
            $baseBtn.removeEventListener("mouseOut",__btnOut);
            $baseBtn.removeEventListener("click",__btnClick);
            onOutEffect(_btnList.indexOf($baseBtn));
         }
      }
      
      private function setBuildState(idx:int, enable:Boolean, flag:Boolean = false) : void
      {
         var baseBtn:Component = _btnList[idx];
         var _loc5_:* = enable;
         baseBtn.mouseEnabled = _loc5_;
         _loc5_ = _loc5_;
         baseBtn.mouseChildren = _loc5_;
         baseBtn.buttonMode = _loc5_;
         if(enable)
         {
            baseBtn.addEventListener("click",__btnClick);
            baseBtn.addEventListener("mouseMove",__btnOver);
            baseBtn.addEventListener("mouseOut",__btnOut);
         }
         if(idx == 7)
         {
            GypsyShopManager.getInstance().npcBehavior.hotArea = baseBtn;
         }
      }
      
      private function __btnOver(evt:MouseEvent) : void
      {
         var btnId:int = _btnList.indexOf(evt.currentTarget as BaseButton);
         if(btnId < 6)
         {
            _btnTipList[btnId].visible = true;
         }
         else
         {
            setCharacterFilter(btnId,true);
         }
      }
      
      protected function setCharacterFilter(btnId:int, value:Boolean) : void
      {
         var staticLayer:* = null;
         if(_notFilter.indexOf(btnId) == -1)
         {
            staticLayer = starlingHallScene.playerView.staticLayer;
            staticLayer.setCharacterFilter(_btnArray[btnId],value);
         }
      }
      
      private function __btnOut(evt:MouseEvent) : void
      {
         var btnId:int = _btnList.indexOf(evt.currentTarget as BaseButton);
         onOutEffect(btnId);
      }
      
      private function onOutEffect(btnId:int) : void
      {
         if(btnId < 6)
         {
            _btnTipList[btnId].visible = false;
         }
         else
         {
            setCharacterFilter(btnId,false);
         }
      }
      
      private function __onFightFlag(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var count:int = pkg.readInt();
         var date:Date = pkg.readDate();
         if(StateManager.currentStateType == "main")
         {
            if(date.time - TimeManager.Instance.Now().time > 0)
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
      
      private function __checkShowWonderfulActivityTip(evnet:WonderfulActivityEvent) : void
      {
         checkShowActTip();
         createActAwardChat();
      }
      
      private function checkShowActTip() : void
      {
         var i:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = WonderfulActivityManager.Instance.stateDic;
         for(var key in WonderfulActivityManager.Instance.stateDic)
         {
            for(i = 0; i < _needShowOpenTipActArr.length; )
            {
               if(key == String(_needShowOpenTipActArr[i]) && !_isShowActTipDic[_needShowOpenTipActArr[i]])
               {
                  ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("wonderfulActivity.startTip" + _needShowOpenTipActArr[i]));
                  _isShowActTipDic[_needShowOpenTipActArr[i]] = true;
               }
               i++;
            }
         }
      }
      
      private function createActAwardChat() : void
      {
         var i:int = 0;
         var chatData:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = WonderfulActivityManager.Instance.stateDic;
         for(var key in WonderfulActivityManager.Instance.stateDic)
         {
            for(i = 0; i < _needShowAwardTipActArr.length; )
            {
               if(key == String(_needShowAwardTipActArr[i]) && WonderfulActivityManager.Instance.stateDic[key])
               {
                  chatData = new ChatData();
                  chatData.channel = 21;
                  chatData.childChannelArr = [7,14];
                  chatData.type = ChatFormats.CLICK_ACT_TIP + _needShowAwardTipActArr[i];
                  chatData.actId = WonderfulActivityManager.Instance.getActIdWithViewId(_needShowAwardTipActArr[i]);
                  chatData.msg = LanguageMgr.GetTranslation("wonderfulActivity.awardTip" + _needShowAwardTipActArr[i]);
                  ChatManager.Instance.chat(chatData);
               }
               i++;
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
      
      private function readyHander(e:ActivitStateEvent) : void
      {
         changeIconState(e.data,false);
      }
      
      private function startHander(e:ActivitStateEvent) : void
      {
         changeIconState(e.data,true);
      }
      
      private function changeIconState(arr:Array, isOpen:Boolean = false) : void
      {
         var JumpType:int = arr[0];
         var worldBossId:int = arr[1] == 4?1:4;
         var tString:String = arr[2];
         if(isOpen)
         {
            tString = "";
         }
         switch(int(JumpType) - 1)
         {
            case 0:
               addBattleIcon(isOpen,tString);
               break;
            default:
               addBattleIcon(isOpen,tString);
               break;
            default:
               addBattleIcon(isOpen,tString);
               break;
            case 3:
               if(isOpen && !WorldBossManager.Instance.isOpen)
               {
                  DdtActivityIconManager.Instance.isOneOpen = false;
                  return;
               }
               WorldBossManager.Instance.creatEnterIcon(isOpen,worldBossId,tString);
               checkShowWorldBossHelper();
               break;
            default:
               if(isOpen && !WorldBossManager.Instance.isOpen)
               {
                  DdtActivityIconManager.Instance.isOneOpen = false;
                  return;
               }
               WorldBossManager.Instance.creatEnterIcon(isOpen,worldBossId,tString);
               checkShowWorldBossHelper();
               break;
            default:
               if(isOpen && !WorldBossManager.Instance.isOpen)
               {
                  DdtActivityIconManager.Instance.isOneOpen = false;
                  return;
               }
               WorldBossManager.Instance.creatEnterIcon(isOpen,worldBossId,tString);
               checkShowWorldBossHelper();
               break;
            default:
               if(isOpen && !WorldBossManager.Instance.isOpen)
               {
                  DdtActivityIconManager.Instance.isOneOpen = false;
                  return;
               }
               WorldBossManager.Instance.creatEnterIcon(isOpen,worldBossId,tString);
               checkShowWorldBossHelper();
               break;
            default:
               if(isOpen && !WorldBossManager.Instance.isOpen)
               {
                  DdtActivityIconManager.Instance.isOneOpen = false;
                  return;
               }
               WorldBossManager.Instance.creatEnterIcon(isOpen,worldBossId,tString);
               checkShowWorldBossHelper();
               break;
            case 8:
               CampBattleManager.instance.addCampBtn(isOpen,tString);
               break;
            case 9:
            case 10:
               addLeagueIcon(isOpen,tString);
               break;
            case 11:
               ConsortiaBattleManager.instance.addEntryBtn(isOpen,tString);
         }
      }
      
      private function campBtnHander(e:MouseEvent) : void
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
      
      private function stopAllMc($mc:MovieClip) : void
      {
         var cMc:* = null;
         var index:int = 0;
         while($mc.numChildren - index)
         {
            if($mc.getChildAt(index) is MovieClip)
            {
               cMc = $mc.getChildAt(index) as MovieClip;
               cMc.stop();
               stopAllMc(cMc);
            }
            index++;
         }
      }
      
      private function playAllMc($mc:MovieClip) : void
      {
         var cMc:* = null;
         var index:int = 0;
         while($mc.numChildren - index)
         {
            if($mc.getChildAt(index) is MovieClip)
            {
               cMc = $mc.getChildAt(index) as MovieClip;
               cMc.play();
               playAllMc(cMc);
            }
            index++;
         }
      }
      
      private function updateWantStrong() : void
      {
         var acitiveDataList:* = undefined;
         var bossDataDic:* = null;
         var findBackDic:* = null;
         var speedActArr:* = null;
         var nowDate:* = null;
         var hours:int = 0;
         var minutes:int = 0;
         var findBackExist:Boolean = false;
         var i:int = 0;
         var activeTime:* = null;
         if(PlayerManager.Instance.Self.Grade >= 8 && PlayerManager.Instance.Self.Grade <= 80)
         {
            acitiveDataList = DayActivityManager.Instance.acitiveDataList;
            bossDataDic = DayActivityManager.Instance.bossDataDic;
            findBackDic = WantStrongManager.Instance.findBackDic;
            speedActArr = DayActivityManager.Instance.speedActArr;
            nowDate = TimeManager.Instance.serverDate;
            findBackExist = false;
            for(i = 0; i < acitiveDataList.length; )
            {
               hours = acitiveDataList[i].ActiveTime.substr(acitiveDataList[i].ActiveTime.length - 5,2);
               minutes = int(acitiveDataList[i].ActiveTime.substr(acitiveDataList[i].ActiveTime.length - 2,2)) + 10;
               switch(int(int(acitiveDataList[i].JumpType)) - 1)
               {
                  case 0:
                     if(compareDay(nowDate.day,acitiveDataList[i].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(acitiveDataList[i].LevelLimit) && compareDate(nowDate,hours,minutes) && !isPassBoss(bossDataDic,speedActArr,5) && !isFindBack(findBackDic,5))
                     {
                        WantStrongManager.Instance.findBackExist = true;
                        findBackExist = true;
                        WantStrongManager.Instance.setFindBackData(3);
                        break;
                     }
                     break;
                  default:
                     if(compareDay(nowDate.day,acitiveDataList[i].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(acitiveDataList[i].LevelLimit) && compareDate(nowDate,hours,minutes) && !isPassBoss(bossDataDic,speedActArr,5) && !isFindBack(findBackDic,5))
                     {
                        WantStrongManager.Instance.findBackExist = true;
                        findBackExist = true;
                        WantStrongManager.Instance.setFindBackData(3);
                        break;
                     }
                     break;
                  default:
                     if(compareDay(nowDate.day,acitiveDataList[i].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(acitiveDataList[i].LevelLimit) && compareDate(nowDate,hours,minutes) && !isPassBoss(bossDataDic,speedActArr,5) && !isFindBack(findBackDic,5))
                     {
                        WantStrongManager.Instance.findBackExist = true;
                        findBackExist = true;
                        WantStrongManager.Instance.setFindBackData(3);
                        break;
                     }
                     break;
                  case 3:
                     if(compareDay(nowDate.day,acitiveDataList[i].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(acitiveDataList[i].LevelLimit) && compareDate(nowDate,hours,minutes) && !isPassBoss(bossDataDic,speedActArr,6) && !isFindBack(findBackDic,6))
                     {
                        WantStrongManager.Instance.findBackExist = true;
                        findBackExist = true;
                        WantStrongManager.Instance.setFindBackData(0);
                     }
                     break;
                  default:
                     if(compareDay(nowDate.day,acitiveDataList[i].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(acitiveDataList[i].LevelLimit) && compareDate(nowDate,hours,minutes) && !isPassBoss(bossDataDic,speedActArr,6) && !isFindBack(findBackDic,6))
                     {
                        WantStrongManager.Instance.findBackExist = true;
                        findBackExist = true;
                        WantStrongManager.Instance.setFindBackData(0);
                     }
                     break;
                  default:
                     if(compareDay(nowDate.day,acitiveDataList[i].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(acitiveDataList[i].LevelLimit) && compareDate(nowDate,hours,minutes) && !isPassBoss(bossDataDic,speedActArr,6) && !isFindBack(findBackDic,6))
                     {
                        WantStrongManager.Instance.findBackExist = true;
                        findBackExist = true;
                        WantStrongManager.Instance.setFindBackData(0);
                     }
                     break;
                  default:
                     if(compareDay(nowDate.day,acitiveDataList[i].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(acitiveDataList[i].LevelLimit) && compareDate(nowDate,hours,minutes) && !isPassBoss(bossDataDic,speedActArr,6) && !isFindBack(findBackDic,6))
                     {
                        WantStrongManager.Instance.findBackExist = true;
                        findBackExist = true;
                        WantStrongManager.Instance.setFindBackData(0);
                     }
                     break;
                  default:
                     if(compareDay(nowDate.day,acitiveDataList[i].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(acitiveDataList[i].LevelLimit) && compareDate(nowDate,hours,minutes) && !isPassBoss(bossDataDic,speedActArr,6) && !isFindBack(findBackDic,6))
                     {
                        WantStrongManager.Instance.findBackExist = true;
                        findBackExist = true;
                        WantStrongManager.Instance.setFindBackData(0);
                     }
                     break;
                  default:
                     if(compareDay(nowDate.day,acitiveDataList[i].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(acitiveDataList[i].LevelLimit) && compareDate(nowDate,hours,minutes) && !isPassBoss(bossDataDic,speedActArr,6) && !isFindBack(findBackDic,6))
                     {
                        WantStrongManager.Instance.findBackExist = true;
                        findBackExist = true;
                        WantStrongManager.Instance.setFindBackData(0);
                     }
                     break;
                  case 9:
                     if(compareDay(nowDate.day,acitiveDataList[i].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(acitiveDataList[i].LevelLimit) && compareDate(nowDate,hours,minutes) && !isPassBoss(bossDataDic,speedActArr,4) && !isFindBack(findBackDic,4))
                     {
                        WantStrongManager.Instance.findBackExist = true;
                        findBackExist = true;
                        WantStrongManager.Instance.setFindBackData(4);
                     }
                     break;
                  case 10:
                     activeTime = acitiveDataList[i].ActiveTime.split("（")[0];
                     hours = activeTime.substr(activeTime.length - 5,2);
                     minutes = int(activeTime.substr(activeTime.length - 2,2)) + 10;
                     if(compareDay(nowDate.day,acitiveDataList[i].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(acitiveDataList[i].LevelLimit) && compareDate(nowDate,hours,minutes) && !isPassBoss(bossDataDic,speedActArr,19) && !isFindBack(findBackDic,19))
                     {
                        WantStrongManager.Instance.findBackExist = true;
                        findBackExist = true;
                        WantStrongManager.Instance.setFindBackData(2);
                     }
               }
               i++;
            }
            if(!findBackExist)
            {
               WantStrongManager.Instance.findBackExist = false;
            }
         }
      }
      
      private function isPassBoss(bossDataDic:Dictionary, speedActArr:Array, type:int) : Boolean
      {
         if(speedActArr.indexOf("" + type) != -1)
         {
            return false;
         }
         if(!bossDataDic[type] || bossDataDic[type] == 0)
         {
            return false;
         }
         return true;
      }
      
      protected function __alreadyUpdateTimeHandler(event:Event) : void
      {
         checkWantStrongFindBack();
      }
      
      private function checkWantStrongFindBack() : void
      {
         var hours:int = 0;
         var minutes:int = 0;
         var i:int = 0;
         var activeTime:* = null;
         var j:int = 0;
         var acitiveDataList:Vector.<DayActiveData> = DayActivityManager.Instance.acitiveDataList;
         var bossDataDic:Dictionary = DayActivityManager.Instance.bossDataDic;
         var findBackDic:Dictionary = WantStrongManager.Instance.findBackDic;
         if(findBackDic == null)
         {
            return;
         }
         var speedActArr:Array = DayActivityManager.Instance.speedActArr;
         var nowDate:Date = TimeManager.Instance.Now();
         var findBackExist:Boolean = false;
         for(i = 0; i < acitiveDataList.length; )
         {
            hours = acitiveDataList[i].ActiveTime.substr(acitiveDataList[i].ActiveTime.length - 5,2);
            minutes = int(acitiveDataList[i].ActiveTime.substr(acitiveDataList[i].ActiveTime.length - 2,2)) + 10;
            switch(int(acitiveDataList[i].ID) - 1)
            {
               case 0:
                  if(compareDay(nowDate.day,acitiveDataList[i].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(acitiveDataList[i].LevelLimit) && compareDate(nowDate,hours,minutes) && isBeatBoss(1) && !isFindBack(findBackDic,18))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     findBackExist = true;
                     WantStrongManager.Instance.setFindBackData(1);
                  }
                  break;
               case 1:
                  if(compareDay(nowDate.day,acitiveDataList[i].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(acitiveDataList[i].LevelLimit) && compareDate(nowDate,hours,minutes) && isBeatBoss(0) && !isFindBack(findBackDic,6))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     findBackExist = true;
                     WantStrongManager.Instance.setFindBackData(0);
                  }
                  break;
               default:
                  if(compareDay(nowDate.day,acitiveDataList[i].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(acitiveDataList[i].LevelLimit) && compareDate(nowDate,hours,minutes) && isBeatBoss(0) && !isFindBack(findBackDic,6))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     findBackExist = true;
                     WantStrongManager.Instance.setFindBackData(0);
                  }
                  break;
               case 3:
                  if(compareDay(nowDate.day,acitiveDataList[i].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(acitiveDataList[i].LevelLimit) && compareDate(nowDate,hours,minutes) && !isPass(bossDataDic,speedActArr,4) && !isFindBack(findBackDic,4))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     findBackExist = true;
                     WantStrongManager.Instance.setFindBackData(4);
                  }
                  break;
               case 4:
                  if(compareDay(nowDate.day,acitiveDataList[i].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(acitiveDataList[i].LevelLimit) && compareDate(nowDate,hours,minutes) && isBeatBoss(3) && !isFindBack(findBackDic,5))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     findBackExist = true;
                     WantStrongManager.Instance.setFindBackData(3);
                     break;
                  }
                  break;
               default:
                  if(compareDay(nowDate.day,acitiveDataList[i].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(acitiveDataList[i].LevelLimit) && compareDate(nowDate,hours,minutes) && isBeatBoss(3) && !isFindBack(findBackDic,5))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     findBackExist = true;
                     WantStrongManager.Instance.setFindBackData(3);
                     break;
                  }
                  break;
               default:
                  if(compareDay(nowDate.day,acitiveDataList[i].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(acitiveDataList[i].LevelLimit) && compareDate(nowDate,hours,minutes) && isBeatBoss(3) && !isFindBack(findBackDic,5))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     findBackExist = true;
                     WantStrongManager.Instance.setFindBackData(3);
                     break;
                  }
                  break;
               default:
                  if(compareDay(nowDate.day,acitiveDataList[i].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(acitiveDataList[i].LevelLimit) && compareDate(nowDate,hours,minutes) && isBeatBoss(3) && !isFindBack(findBackDic,5))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     findBackExist = true;
                     WantStrongManager.Instance.setFindBackData(3);
                     break;
                  }
                  break;
               default:
                  if(compareDay(nowDate.day,acitiveDataList[i].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(acitiveDataList[i].LevelLimit) && compareDate(nowDate,hours,minutes) && isBeatBoss(3) && !isFindBack(findBackDic,5))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     findBackExist = true;
                     WantStrongManager.Instance.setFindBackData(3);
                     break;
                  }
                  break;
               default:
                  if(compareDay(nowDate.day,acitiveDataList[i].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(acitiveDataList[i].LevelLimit) && compareDate(nowDate,hours,minutes) && isBeatBoss(3) && !isFindBack(findBackDic,5))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     findBackExist = true;
                     WantStrongManager.Instance.setFindBackData(3);
                     break;
                  }
                  break;
               default:
                  if(compareDay(nowDate.day,acitiveDataList[i].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(acitiveDataList[i].LevelLimit) && compareDate(nowDate,hours,minutes) && isBeatBoss(3) && !isFindBack(findBackDic,5))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     findBackExist = true;
                     WantStrongManager.Instance.setFindBackData(3);
                     break;
                  }
                  break;
               default:
                  if(compareDay(nowDate.day,acitiveDataList[i].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(acitiveDataList[i].LevelLimit) && compareDate(nowDate,hours,minutes) && isBeatBoss(3) && !isFindBack(findBackDic,5))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     findBackExist = true;
                     WantStrongManager.Instance.setFindBackData(3);
                     break;
                  }
                  break;
               default:
                  if(compareDay(nowDate.day,acitiveDataList[i].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(acitiveDataList[i].LevelLimit) && compareDate(nowDate,hours,minutes) && isBeatBoss(3) && !isFindBack(findBackDic,5))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     findBackExist = true;
                     WantStrongManager.Instance.setFindBackData(3);
                     break;
                  }
                  break;
               default:
                  if(compareDay(nowDate.day,acitiveDataList[i].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(acitiveDataList[i].LevelLimit) && compareDate(nowDate,hours,minutes) && isBeatBoss(3) && !isFindBack(findBackDic,5))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     findBackExist = true;
                     WantStrongManager.Instance.setFindBackData(3);
                     break;
                  }
                  break;
               default:
                  if(compareDay(nowDate.day,acitiveDataList[i].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(acitiveDataList[i].LevelLimit) && compareDate(nowDate,hours,minutes) && isBeatBoss(3) && !isFindBack(findBackDic,5))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     findBackExist = true;
                     WantStrongManager.Instance.setFindBackData(3);
                     break;
                  }
                  break;
               default:
                  if(compareDay(nowDate.day,acitiveDataList[i].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(acitiveDataList[i].LevelLimit) && compareDate(nowDate,hours,minutes) && isBeatBoss(3) && !isFindBack(findBackDic,5))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     findBackExist = true;
                     WantStrongManager.Instance.setFindBackData(3);
                     break;
                  }
                  break;
               default:
                  if(compareDay(nowDate.day,acitiveDataList[i].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(acitiveDataList[i].LevelLimit) && compareDate(nowDate,hours,minutes) && isBeatBoss(3) && !isFindBack(findBackDic,5))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     findBackExist = true;
                     WantStrongManager.Instance.setFindBackData(3);
                     break;
                  }
                  break;
               default:
                  if(compareDay(nowDate.day,acitiveDataList[i].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(acitiveDataList[i].LevelLimit) && compareDate(nowDate,hours,minutes) && isBeatBoss(3) && !isFindBack(findBackDic,5))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     findBackExist = true;
                     WantStrongManager.Instance.setFindBackData(3);
                     break;
                  }
                  break;
               case 18:
                  activeTime = acitiveDataList[i].ActiveTime.split("（")[0];
                  hours = activeTime.substr(activeTime.length - 5,2);
                  minutes = int(activeTime.substr(activeTime.length - 2,2)) + 10;
                  if(compareDay(nowDate.day,acitiveDataList[i].DayOfWeek) && PlayerManager.Instance.Self.Grade >= int(acitiveDataList[i].LevelLimit) && compareDate(nowDate,hours,minutes) && isBeatBoss(2) && !isFindBack(findBackDic,19))
                  {
                     WantStrongManager.Instance.findBackExist = true;
                     findBackExist = true;
                     WantStrongManager.Instance.setFindBackData(2);
                  }
            }
            i++;
         }
         var typeList:Array = [25,30,31];
         for(j = 0; j < typeList.length; )
         {
            if(!isFindBack(findBackDic,typeList[j]))
            {
               WantStrongManager.Instance.findBackExist = true;
               findBackExist = true;
               WantStrongManager.Instance.setFindBackData(j + 5);
            }
            j++;
         }
         if(!findBackExist)
         {
            WantStrongManager.Instance.findBackExist = false;
         }
         if(!WantStrongManager.Instance.findBackExist)
         {
            _wantStrongBtn.movie.gotoAndStop(2);
         }
         else if(isOnceFindBack(findBackDic))
         {
            WantStrongManager.Instance.isPlayMovie = false;
            _wantStrongBtn.movie.gotoAndStop(2);
         }
         else
         {
            _wantStrongBtn.movie.gotoAndStop(1);
         }
      }
      
      private function __alreadyFindBackHandler(event:Event) : void
      {
         _wantStrongBtn.movie.gotoAndStop(2);
      }
      
      private function isOnceFindBack(findBackDic:Dictionary) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:* = findBackDic;
         for each(var itemArr in findBackDic)
         {
            if(itemArr && (itemArr[0] || itemArr[1]))
            {
               return true;
            }
         }
         return false;
      }
      
      private function isFindBack(findBackDic:Dictionary, type:int) : Boolean
      {
         if(findBackDic[type])
         {
            if(findBackDic[type][0] && findBackDic[type][1])
            {
               return true;
            }
         }
         return false;
      }
      
      private function isBeatBoss(dig:int) : Boolean
      {
         var bossFlag:int = WantStrongManager.Instance.bossFlag;
         return (bossFlag & 1 << dig) == 0;
      }
      
      private function isPass(bossDataDic:Dictionary, speedActArr:Array, type:int) : Boolean
      {
         if(speedActArr.indexOf("" + type) != -1)
         {
            return false;
         }
         if(!bossDataDic[type] || bossDataDic[type] == 0)
         {
            return false;
         }
         return true;
      }
      
      private function compareDay(day:int, activeDays:String) : Boolean
      {
         var dayArr:Array = activeDays.split(",");
         if(dayArr.indexOf("" + day) == -1)
         {
            return false;
         }
         return true;
      }
      
      private function compareDate(date1:Date, hours:int, minutes:int) : Boolean
      {
         if(date1.hours < hours)
         {
            return false;
         }
         if(date1.hours == hours)
         {
            if(date1.minutes < minutes)
            {
               return false;
            }
         }
         return true;
      }
      
      private function wantStrongtnHandler(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         WantStrongManager.Instance.showFrame();
      }
      
      private function addLeagueIcon(isUse:Boolean = false, timeStr:String = null) : void
      {
         HallIconManager.instance.updateSwitchHandler("league",true,timeStr);
      }
      
      private function deleLeagueBtn() : void
      {
         HallIconManager.instance.updateSwitchHandler("league",false);
      }
      
      private function addBattleIcon(isUse:Boolean = false, timeStr:String = "") : void
      {
         HallIconManager.instance.updateSwitchHandler("trial",true,timeStr);
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
      
      private function leagueBtnHander(e:MouseEvent) : void
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
      
      private function openWonderfulActivityView(e:MouseEvent) : void
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
         var nowDate:Date = TimeManager.Instance.Now();
         if(!startDate)
         {
            return false;
         }
         if(nowDate.getTime() > startDate.getTime() && nowDate.getTime() < endDate.getTime() && isActiv)
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
      
      protected function openFristrechargeView(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         FirstRechargeManger.Instance.show();
      }
      
      private function __onSignClick(evnet:MouseEvent) : void
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
      
      private function __OpenView(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         MainButtnController.instance.show(MainButtnController.DDT_AWARD);
         MainButtnController.instance.addEventListener(MainButtnController.ICONCLOSE,__iconClose);
      }
      
      private function __openActivityView(event:Event) : void
      {
         SoundManager.instance.play("008");
         DayActivityManager.Instance.show();
      }
      
      private function __iconClose(e:Event) : void
      {
      }
      
      private function __updatePetFarmGuilde(e:UpdatePetFarmGuildeEvent) : void
      {
         PetsBagManager.instance().finishTask();
         var currentGuildeInfo:QuestInfo = e.data as QuestInfo;
         if(currentGuildeInfo.QuestID == 370)
         {
         }
         if(currentGuildeInfo.QuestID == 369)
         {
         }
      }
      
      private function __OpenVipView(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         VipController.instance.show();
      }
      
      private function __OpenBlessView(event:Event) : void
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
      
      private function __leftGunShow(event:RouletteFrameEvent) : void
      {
         addButtonList();
      }
      
      private function __onAudioLoadComplete(event:Event) : void
      {
         event.currentTarget.removeEventListener("complete",__onAudioLoadComplete);
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
      
      private function __littlegameActived(evt:Event = null, isUse:Boolean = false, timeStr:String = null) : void
      {
         if(false)
         {
            HallIconManager.instance.updateSwitchHandler("littlegamenote",true,timeStr);
         }
         else
         {
            HallIconManager.instance.updateSwitchHandler("littlegamenote",false,timeStr);
         }
      }
      
      private function __OpenlittleGame(evnet:MouseEvent) : void
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
      
      private function __taskFrameHide(evt:Event) : void
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
      
      private function sevendoubleEndHandler(event:Event) : void
      {
         HallIconManager.instance.updateSwitchHandler("sevendouble",false);
      }
      
      private function sevenDoubleIconResLoadComplete(event:Event) : void
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
      
      private function escortEndHandler(event:Event) : void
      {
         HallIconManager.instance.updateSwitchHandler("escort",false);
      }
      
      private function escortIconResLoadComplete(event:Event) : void
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
         var msg:* = null;
         var selfInfo:SelfInfo = PlayerManager.Instance.Self;
         if(!selfInfo.isSameDay && !VipController.instance.isRechargePoped)
         {
            VipController.instance.isRechargePoped = true;
            if(selfInfo.IsVIP)
            {
               if(selfInfo.VIPLeftDays <= 3 && selfInfo.VIPLeftDays >= 0 || selfInfo.VIPLeftDays == 7)
               {
                  msg = "";
                  if(selfInfo.VIPLeftDays == 0)
                  {
                     if(selfInfo.VipLeftHours > 0)
                     {
                        msg = LanguageMgr.GetTranslation("ddt.vip.vipView.expiredToday",selfInfo.VipLeftHours);
                     }
                     else if(selfInfo.VipLeftHours == 0)
                     {
                        msg = LanguageMgr.GetTranslation("ddt.vip.vipView.expiredHour");
                     }
                     else
                     {
                        msg = LanguageMgr.GetTranslation("ddt.vip.vipView.expiredTrue");
                     }
                  }
                  else
                  {
                     msg = LanguageMgr.GetTranslation("ddt.vip.vipView.expired",selfInfo.VIPLeftDays);
                  }
                  _renewal = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),msg,LanguageMgr.GetTranslation("ddt.vip.vipView.RenewalNow"),"",false,false,false,2);
                  _renewal.moveEnable = false;
                  _renewal.addEventListener("response",__goRenewal);
               }
            }
            else if(selfInfo.VIPExp > 0)
            {
               if(selfInfo.LastDate.valueOf() < selfInfo.VIPExpireDay.valueOf() && selfInfo.VIPExpireDay.valueOf() <= selfInfo.systemDate.valueOf())
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
         var selfInfo:SelfInfo = PlayerManager.Instance.Self;
         if(!selfInfo.isSameDay && !VipController.instance.isRechargePoped)
         {
            VipController.instance.isRechargePoped = true;
            if(selfInfo.IsVIP)
            {
               if(selfInfo.VIPLeftDays <= 3 && selfInfo.VIPLeftDays >= 0 || selfInfo.VIPLeftDays == 7)
               {
                  VipController.instance.showRechargeAlert();
               }
            }
            else if(selfInfo.VIPExp > 0)
            {
               VipController.instance.showRechargeAlert();
            }
         }
      }
      
      private function __goRenewal(evt:FrameEvent) : void
      {
         _renewal.removeEventListener("response",__goRenewal);
         switch(int(evt.responseCode) - 2)
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
      
      private function __vote(e:Event) : void
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
      
      private function __btnClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("047");
         evt.stopPropagation();
         _btnID = _btnList.indexOf(evt.currentTarget);
         var playerView:starling.scene.hall.HallPlayerView = starlingHallScene.playerView;
         playerView.MapClickFlag = false;
         playerView.setSelfPlayerPos(_selfPosArray[_btnID],true,true);
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
         var infoView:* = null;
         if(WonderfulActivityManager.Instance.hasActivity)
         {
            openWonderfulActivityView(null);
         }
         else
         {
            infoView = new WonderfulInfoView();
            infoView.show(1,LanguageMgr.GetTranslation("wonderfulActivityManager.tittle") + ":",LanguageMgr.GetTranslation("wonderful.activity.infoViewText"));
            LayerManager.Instance.addToLayer(infoView,3,true,1);
         }
      }
      
      private function loadUserGuide() : void
      {
         var result:Boolean = false;
         if(NewHandGuideManager.Instance.progress < 11 && WeakGuildManager.Instance.switchUserGuide)
         {
            if(PathManager.TRAINER_STANDALONE && !PlayerManager.Instance.Self.IsWeakGuildFinish(2))
            {
               SocketManager.Instance.out.syncStep(11,true);
               result = PlayerManager.Instance.Self.IsWeakGuildFinish(144);
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
         var loader:* = null;
         var args:URLVariables = new URLVariables();
         var username:String = PlayerManager.Instance.Self.ID.toString();
         username = encodeURI(username);
         var key:String = "sdkxccjlqaoehtdwjkdycdrw";
         args["username"] = username;
         args["sign"] = MD5.hash(username + key);
         var requestURL:String = PathManager.callLoginInterface();
         if(requestURL)
         {
            loader = LoadResourceManager.Instance.createLoader(requestURL,6,args);
            LoadResourceManager.Instance.startLoad(loader);
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
      
      private function __trainerResponse(event:FrameEvent) : void
      {
         var o1:* = undefined;
         var o2:* = undefined;
         if(event.responseCode == 3 || event.responseCode == 2)
         {
            event.currentTarget.removeEventListener("response",__trainerResponse);
            SoundManager.instance.play("008");
            o1 = PathManager.TRAINER_STANDALONE;
            o2 = PlayerManager.Instance.Self.IsWeakGuildFinish(2);
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
         var img:* = null;
         if(_trainerWelcomeView)
         {
            _trainerWelcomeView.dispose();
            _trainerWelcomeView = null;
         }
         if(PlayerManager.Instance.Self.Sex)
         {
            img = ComponentFactory.Instance.creatBitmap("asset.hall.maleImg");
         }
         else
         {
            img = ComponentFactory.Instance.creatBitmap("asset.hall.femaleImg");
         }
         _dialog = new NewOpenGuideDialogView();
         _dialog.show(LanguageMgr.GetTranslation("newOpenGuide.firstEnterPrompt1"),PlayerManager.Instance.Self.NickName,img,new Point(163,339));
         _dialog.addEventListener("click",dialogNextHandler);
         LayerManager.Instance.addToLayer(_dialog,0);
      }
      
      private function dialogNextHandler(event:MouseEvent) : void
      {
         _dialog.removeEventListener("click",dialogNextHandler);
         _dialog.show(LanguageMgr.GetTranslation("newOpenGuide.firstEnterPrompt2",PlayerManager.Instance.Self.NickName));
         _dialog.addEventListener("click",dialogNextHandler2);
      }
      
      private function dialogNextHandler2(event:MouseEvent) : void
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
         var alert:Frame = ComponentFactory.Instance.creatComponentByStylename("hall.hotSpringAlertFrame");
         alert.addEventListener("response",__onRespose);
         LayerManager.Instance.addToLayer(alert,3,true,1);
      }
      
      private function __onRespose(event:FrameEvent) : void
      {
         var alert:Frame = event.currentTarget as Frame;
         alert.removeEventListener("response",__onRespose);
         alert.dispose();
      }
      
      private function __battleBtnClick(event:MouseEvent) : void
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
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               battleFrameClose();
         }
      }
      
      override public function leaving(next:BaseStateView) : void
      {
         var i:int = 0;
         var j:int = 0;
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
            for(i = 0; i < _btnList.length; )
            {
               _btnList[i].removeEventListener("click",__btnClick);
               _btnList[i].dispose();
               _btnList[i] = null;
               i++;
            }
            _btnList.length = 0;
         }
         _btnList = null;
         if(_btnTipList)
         {
            for(j = 0; j < _btnTipList.length; )
            {
               _btnTipList[j].dispose();
               _btnTipList[j] = null;
               j++;
            }
            _btnTipList.length = 0;
         }
         _btnTipList = null;
         if(_LevelIcon)
         {
            _LevelIcon.bitmapData.dispose();
            _LevelIcon = null;
         }
         if(_bitmap12)
         {
            _bitmap12.bitmapData.dispose();
            _bitmap12 = null;
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
         if(next.getType() != "dungeon" && next.getType() != "roomlist")
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
         super.leaving(next);
      }
      
      override public function prepare() : void
      {
         super.prepare();
         _isFirst = true;
      }
      
      override public function fadingComplete() : void
      {
         var frame:* = null;
         super.fadingComplete();
         if(_isFirst)
         {
            _isFirst = false;
            if(LoaderSavingManager.cacheAble == false && PlayerManager.Instance.Self.IsFirst > 1 && PlayerManager.Instance.Self.LastServerId == -1)
            {
               frame = ComponentFactory.Instance.creatComponentByStylename("hall.SaveFileWidow");
               frame.show();
            }
            LeavePageManager.setFavorite(PlayerManager.Instance.Self.IsFirst <= 1);
         }
      }
      
      private function showBuildOpen(step:int, style:String) : void
      {
         var name:* = null;
         if(StateManager.currentStateType != "main")
         {
            return;
         }
         SocketManager.Instance.out.syncWeakStep(step);
      }
      
      private function __completeGameRoom(evt:Event) : void
      {
         MovieClipWrapper(evt.currentTarget).removeEventListener("complete",__completeGameRoom);
         buildShine(4,"asset.trainer.RoomShineAsset","trainer.posBuildGameRoom");
      }
      
      private function __completeConsortia(evt:Event) : void
      {
         MovieClipWrapper(evt.currentTarget).removeEventListener("complete",__completeConsortia);
         buildShine(65,"asset.trainer.shineConsortia","trainer.posBuildConsortia");
      }
      
      private function __completeDungeon(evt:Event) : void
      {
         MovieClipWrapper(evt.currentTarget).removeEventListener("complete",__completeDungeon);
         buildShine(67,"asset.trainer.shineDungeon","trainer.posBuildDungeon");
      }
      
      private function __completeChurch(evt:Event) : void
      {
         MovieClipWrapper(evt.currentTarget).removeEventListener("complete",__completeChurch);
         buildShine(37,"asset.trainer.shineChurch","trainer.posBuildChurch");
      }
      
      private function __completeToffList(evt:Event) : void
      {
         MovieClipWrapper(evt.currentTarget).removeEventListener("complete",__completeToffList);
         buildShine(78,"asset.trainer.shineToffList","trainer.posBuildToffList");
      }
      
      private function __completeAuction(evt:Event) : void
      {
         MovieClipWrapper(evt.currentTarget).removeEventListener("complete",__completeAuction);
         buildShine(84,"asset.trainer.shineAuction","trainer.posBuildAuction");
      }
      
      private function __onClickServerName(e:MouseEvent) : void
      {
      }
      
      private function buildShine(step:int, style:String, pos:String) : void
      {
      }
      
      override public function refresh() : void
      {
         var curtain:StageCurtain = new StageCurtain();
         curtain.play(25);
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
      
      public function setBgSpriteCenter(posX:int, posY:int) : void
      {
         if(_bgSprite)
         {
            _bgSprite.x = posX;
            _bgSprite.y = posY;
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
