package ddt
{
   import AvatarCollection.AvatarCollectionManager;
   import BombTurnTable.BombTurnTableManager;
   import BraveDoor.BraveDoorManager;
   import DDPlay.DDPlayManaer;
   import HappyRecharge.HappyRechargeManager;
   import Indiana.IndianaDataManager;
   import LanternFestival2015.LanternFestivalManager;
   import academy.AcademyManager;
   import accumulativeLogin.AccumulativeManager;
   import anotherDimension.controller.AnotherDimensionManager;
   import bagAndInfo.BagAndInfoManager;
   import bank.BankManager;
   import battleSkill.BattleSkillManager;
   import beadSystem.beadSystemManager;
   import boguAdventure.BoguAdventureManager;
   import calendar.CalendarManager;
   import campbattle.CampBattleManager;
   import cardCollectAward.CardCollectAwardManager;
   import catchInsect.CatchInsectManager;
   import catchbeast.CatchBeastManager;
   import chickActivation.ChickActivationManager;
   import christmas.ChristmasCoreManager;
   import church.ChurchManager;
   import cityBattle.CityBattleManager;
   import cityWide.CityWideManager;
   import cloudBuyLottery.CloudBuyLotteryManager;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.StringUtils;
   import conRecharge.ConRechargeManager;
   import condiscount.CondiscountManager;
   import consortion.guard.ConsortiaGuardControl;
   import consortionBattle.ConsortiaBattleManager;
   import cryptBoss.CryptBossManager;
   import dayActivity.DayActivityManager;
   import ddQiYuan.DDQiYuanManager;
   import ddt.dailyRecord.DailyRecordControl;
   import ddt.data.AccountInfo;
   import ddt.data.ColorEnum;
   import ddt.data.ConfigParaser;
   import ddt.data.PathInfo;
   import ddt.events.StartupEvent;
   import ddt.loader.StartupResourceLoader;
   import ddt.manager.BattleGroudManager;
   import ddt.manager.CSMBoxManager;
   import ddt.manager.ChatManager;
   import ddt.manager.DesktopManager;
   import ddt.manager.DraftManager;
   import ddt.manager.DynamicManager;
   import ddt.manager.EdictumManager;
   import ddt.manager.EffortManager;
   import ddt.manager.EnthrallManager;
   import ddt.manager.ExitPromptManager;
   import ddt.manager.GradeExaltClewManager;
   import ddt.manager.HotSpringManager;
   import ddt.manager.IMManager;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MapManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.PlayerStateManager;
   import ddt.manager.PolarRegionManager;
   import ddt.manager.PyramidManager;
   import ddt.manager.QQtipsManager;
   import ddt.manager.QuestionInfoMannager;
   import ddt.manager.QueueManager;
   import ddt.manager.RandomSuitCardManager;
   import ddt.manager.RouletteManager;
   import ddt.manager.SevenDoubleEscortManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StageFocusManager;
   import ddt.manager.StateManager;
   import ddt.manager.SurvivalModeManager;
   import ddt.manager.SystemPostManager;
   import ddt.manager.TimeManager;
   import ddt.states.StateCreater;
   import ddt.utils.CrytoUtils;
   import ddt.view.ComponentEmbed;
   import ddt.view.chat.ChatBugleView;
   import ddtBuried.BuriedManager;
   import ddtDeed.DeedManager;
   import ddtKingLettersCollect.DdtKingLettersCollectManager;
   import ddtKingWay.DDTKingWayManager;
   import ddtmatch.manager.DDTMatchManager;
   import defendisland.DefendislandManager;
   import demonChiYou.DemonChiYouManager;
   import devilTurn.DevilTurnManager;
   import dice.DiceManager;
   import dragonBoat.DragonBoatManager;
   import dreamlandChallenge.DreamlandChallengeManager;
   import drgnBoat.DrgnBoatManager;
   import entertainmentMode.EntertainmentModeManager;
   import escort.EscortManager;
   import farm.FarmModelController;
   import fightLib.FightLibManager;
   import firstRecharge.FirstRechargeManger;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flashP2P.FlashP2PManager;
   import foodActivity.FoodActivityManager;
   import game.GameManager;
   import gemstone.GemstoneManager;
   import godCardRaise.GodCardRaiseManager;
   import godOfWealth.GodOfWealthManager;
   import goldmine.GoldmineManager;
   import gradeBuy.GradeBuyManager;
   import groupPurchase.GroupPurchaseManager;
   import growthPackage.GrowthPackageManager;
   import guildMemberWeek.manager.GuildMemberWeekManager;
   import gypsyShop.ctrl.GypsyShopManager;
   import hallIcon.HallIconManager;
   import halloween.HalloweenManager;
   import horse.HorseManager;
   import horseRace.controller.HorseRaceManager;
   import invite.InviteManager;
   import itemActivityGift.ItemActivityGiftManager;
   import kingBless.KingBlessManager;
   import lanternriddles.LanternRiddlesManager;
   import latentEnergy.LatentEnergyManager;
   import latentEnergy.LatentRemainTimeNotice;
   import league.LeagueManager;
   import levelFund.LevelFundManager;
   import littleGame.LittleControl;
   import littleGame.character.LittleGameCharacter;
   import loginDevice.LoginDeviceManager;
   import lotteryTicket.LotteryManager;
   import luckStar.manager.LuckStarManager;
   import magicHouse.MagicHouseManager;
   import magpieBridge.MagpieBridgeManager;
   import mark.MarkMgr;
   import memoryGame.MemoryGameManager;
   import midAutumnWorshipTheMoon.WorshipTheMoonManager;
   import mines.MinesManager;
   import moneyTree.MoneyTreeManager;
   import mysteriousRoullete.MysteriousManager;
   import newChickenBox.NewChickenBoxManager;
   import newOldPlayer.NewOldPlayerManager;
   import newTitle.NewTitleManager;
   import newYearRice.NewYearRiceManager;
   import oldPlayerComeBack.OldPlayerComeBackManager;
   import org.aswing.KeyboardManager;
   import panicBuying.PanicBuyingManager;
   import petIsland.PetIslandManager;
   import petsBag.PetsBagManager;
   import playerDress.PlayerDressManager;
   import powerUp.PowerUpMovieManager;
   import pvePowerBuff.PvePowerBuffManager;
   import quest.TrusteeshipManager;
   import questionAward.QuestionAwardManager;
   import rank.RankManager;
   import redEnvelope.RedEnvelopeManager;
   import rescue.RescueManager;
   import roleRecharge.RoleRechargeMgr;
   import room.RoomManager;
   import roulette.LeftGunRouletteManager;
   import sanXiao.SanXiaoManager;
   import sevenDouble.SevenDoubleManager;
   import signActivity.SignActivityMgr;
   import signBuff.SignBuffManager;
   import stock.StockMgr;
   import team.TeamManager;
   import totem.TotemManager;
   import trainer.controller.LevelRewardManager;
   import trainer.controller.WeakGuildManager;
   import treasureHunting.TreasureManager;
   import treasurePuzzle.controller.TreasurePuzzleManager;
   import uiModeManager.bombUI.HappyLittleGameManager;
   import wasteRecycle.WasteRecycleManager;
   import welfareCenter.WelfareCenterManager;
   import welfareCenter.callBackFund.CallBackFundManager;
   import welfareCenter.callBackLotteryDraw.CallBackLotteryDrawManager;
   import wishingTree.WishingTreeManager;
   import witchBlessing.WitchBlessingManager;
   import wonderfulActivity.WonderfulActivityManager;
   import worldboss.WorldBossManager;
   import worldcup.WorldcupManager;
   import zodiac.ZodiacManager;
   
   public class DDT
   {
      
      public static var REQUEST_BY_DEVICE:String;
      
      public static var SERVER_ID:int = -1;
      
      public static const THE_HIGHEST_LV:int = 60;
      
      public static var isMaster:Boolean = false;
       
      
      private var _alerLayer:Sprite;
      
      private var _allowMulti:Boolean;
      
      private var _gameLayer:Sprite;
      
      private var _musicList:Array;
      
      private var _pass:String;
      
      private var _user:String;
      
      private var _rid:String;
      
      private var numCh:Number;
      
      private var _loaded:Boolean = false;
      
      public function DDT()
      {
         super();
      }
      
      private function handleDebugSystem() : void
      {
      }
      
      private function onClick(event:MouseEvent) : void
      {
         var i:int = 0;
         var ch:* = null;
         numCh = 0;
         for(i = 0; i < StageReferance.stage.numChildren; )
         {
            ch = StageReferance.stage.getChildAt(i);
            ch.visible = true;
            numCh = Number(numCh) + 1;
            if(ch is DisplayObjectContainer)
            {
               show(DisplayObjectContainer(ch));
            }
            i++;
         }
      }
      
      private function show(dis:DisplayObjectContainer) : void
      {
         var i:int = 0;
         var ch:* = null;
         for(i = 0; i < dis.numChildren; )
         {
            ch = dis.getChildAt(i);
            ch.visible = true;
            numCh = Number(numCh) + 1;
            if(ch is DisplayObjectContainer)
            {
               show(DisplayObjectContainer(ch));
            }
            i++;
         }
      }
      
      public function lunch(config:XML, username:String, password:String, mode:int, rid:String = "", $baiduEnterCode:String = "", newPlayerIsMaster:Boolean = false, requestUa:String = "") : void
      {
         handleDebugSystem();
         App.init(StageReferance.stage,DisplayLoader.Context.applicationDomain);
         isMaster = newPlayerIsMaster;
         DesktopManager.Instance.checkIsDesktop();
         PlayerManager.Instance.Self.baiduEnterCode = $baiduEnterCode;
         REQUEST_BY_DEVICE = requestUa;
         if(!_loaded)
         {
            _user = username;
            _pass = password;
            _rid = rid;
            PlayerManager.Instance.Self.rid = _rid;
            ConfigParaser.paras(config,StageReferance.stage.loaderInfo,_user);
            setup();
            StartupResourceLoader.Instance.addEventListener("coreSetupLoadComplete",__onCoreSetupLoadComplete);
            StartupResourceLoader.Instance.start(mode);
         }
         else if(StartupResourceLoader.Instance._queueIsComplete)
         {
            __onCoreSetupLoadComplete(null);
         }
         else
         {
            StartupResourceLoader.Instance.addEventListener("coreSetupLoadComplete",__onCoreSetupLoadComplete);
         }
      }
      
      public function startLoad(config:XML, username:String, password:String, mode:int, rid:String = "") : void
      {
         _loaded = true;
         _user = username;
         _pass = password;
         _rid = rid;
         PlayerManager.Instance.Self.rid = _rid;
         ConfigParaser.paras(config,StageReferance.stage.loaderInfo,_user);
         setup();
         StartupResourceLoader.Instance.start(mode);
      }
      
      private function __onCoreSetupLoadComplete(event:StartupEvent) : void
      {
         StartupResourceLoader.Instance.removeEventListener("coreSetupLoadComplete",__onCoreSetupLoadComplete);
         ChatManager.Instance.setup();
         ChatBugleView.instance.setup();
         StageFocusManager.getInstance().setup(StageReferance.stage);
         StateManager.setState("login");
         FightLibManager.Instance.setup();
         PlayerStateManager.Instance.setup();
         WeakGuildManager.Instance.setup();
         GemstoneManager.Instance.initEvent();
         GemstoneManager.Instance.loaderData();
         FirstRechargeManger.Instance.setup();
         AccumulativeManager.instance.setup();
         KingBlessManager.instance.setup();
         TrusteeshipManager.instance.setup();
         DayActivityManager.Instance.setup();
         WonderfulActivityManager.Instance.setup();
         BombTurnTableManager.instance.setup();
         CityBattleManager.instance.setup();
         BraveDoorManager.instance.setup();
         DreamlandChallengeManager.instance.setup();
         BuriedManager.Instance.setup();
         LatentRemainTimeNotice.getInstance().init();
         FoodActivityManager.Instance.setUp();
         PlayerDressManager.instance.setup();
         if(PathManager.flashP2PEbable)
         {
            FlashP2PManager.Instance.connect();
         }
         DeedManager.instance.setup();
         TotemManager.instance.setup();
         GypsyShopManager.getInstance().setup();
         WishingTreeManager.instance.setup();
         RandomSuitCardManager.getInstance().setup();
         IndianaDataManager.instance.setup();
      }
      
      private function setup() : void
      {
         var m1:* = null;
         var m2:* = null;
         var acc:* = null;
         if(StringUtils.isEmpty(_user))
         {
            LeavePageManager.leaveToLoginPath();
         }
         else
         {
            setupComponent();
            m1 = "zRSdzFcnZjOCxDMkWUbuRgiOZIQlk7frZMhElQ0a7VqZI9VgU3+lwo0ghZLU3Gg63kOY2UyJ5vFpQdwJUQydsF337ZAUJz4rwGRt/MNL70wm71nGfmdPv4ING+DyJ3ZxFawwE1zSMjMOqQtY4IV8his/HlgXuUfIHVDK87nMNLc=";
            m2 = "AQAB";
            acc = new AccountInfo();
            acc.Account = _user;
            acc.Password = _pass;
            acc.Key = CrytoUtils.generateRsaKey(m1,m2);
            WonderfulActivityManager.Instance.addWAIcon = initWonderfulIcon;
            WonderfulActivityManager.Instance.deleWAIcon = deleWAIcon;
            PlayerManager.Instance.setup(acc);
            ShowTipManager.Instance.setup();
            QueueManager.setup(StageReferance.stage);
            TimeManager.Instance.setup();
            SoundManager.instance.setup(PathInfo.MUSIC_LIST,PathManager.SITE_MAIN);
            IMManager.Instance.setup();
            SharedManager.Instance.setup();
            LittleControl.Instance.setup();
            CalendarManager.getInstance().initialize();
            RoomManager.Instance.setup();
            BagAndInfoManager.Instance.setup();
            BattleGroudManager.Instance.setup();
            GameManager.instance.setup();
            KeyboardManager.getInstance().init(StageReferance.stage);
            ChurchManager.instance.setup();
            GradeExaltClewManager.getInstance().setup();
            PowerUpMovieManager.Instance.setup();
            HotSpringManager.instance.setup();
            RouletteManager.instance.setup();
            AcademyManager.Instance.setup();
            EffortManager.Instance.setup();
            ColorEnum.initColor();
            StateManager.setup(LayerManager.Instance.getLayerByType(5),new StateCreater());
            EnthrallManager.getInstance().setup();
            ExitPromptManager.Instance.init();
            CityWideManager.Instance.init();
            LevelRewardManager.Instance.setup();
            QQtipsManager.instance.setup();
            LittleGameCharacter.setup();
            EdictumManager.Instance.setup();
            LeftGunRouletteManager.instance.init();
            LeagueManager.instance.initLeagueStartNoticeEvent();
            FarmModelController.instance.setup();
            PetsBagManager.instance().setup();
            beadSystemManager.Instance.setup();
            WorldBossManager.Instance.setup();
            if(PathManager.CommunityExist())
            {
               DynamicManager.Instance.initialize();
            }
            HallIconManager.instance.setup();
            NewChickenBoxManager.instance.setup();
            PetIslandManager.instance.setup();
            EntertainmentModeManager.instance.setup();
            AnotherDimensionManager.Instance.setup();
            DDTMatchManager.instance.setup();
            DiceManager.Instance.setup();
            LatentEnergyManager.instance.setup();
            ConsortiaBattleManager.instance.setup();
            CampBattleManager.instance.setup();
            CardCollectAwardManager.Instance.setup();
            QuestionAwardManager.instance.setup();
            OldPlayerComeBackManager.instance.setup();
            GroupPurchaseManager.instance.setup();
            SevenDoubleManager.instance.setup();
            EscortManager.instance.setup();
            SevenDoubleEscortManager.instance.setup();
            DrgnBoatManager.instance.setup();
            TreasureManager.instance.setup();
            MysteriousManager.instance.setup();
            ChristmasCoreManager.instance.setup();
            CatchBeastManager.instance.setup();
            AvatarCollectionManager.instance.setup();
            LanternRiddlesManager.instance.setup();
            HorseManager.instance.setup();
            MagpieBridgeManager.instance.setup();
            CryptBossManager.instance.setUp();
            CatchInsectManager.instance.setup();
            RescueManager.instance.setup();
            NewTitleManager.instance.setup();
            DragonBoatManager.instance.setup();
            WorshipTheMoonManager.getInstance().init();
            HalloweenManager.instance.setup();
            LevelFundManager.instance.setup();
            PanicBuyingManager.instance.setup();
            QuestionInfoMannager.Instance.setup();
            LanternFestivalManager.getInstance().setup();
            PyramidManager.instance.setup();
            PolarRegionManager.Instance.setup();
            SystemPostManager.Instance.setup();
            DraftManager.instance.setup();
            HorseRaceManager.Instance.setup();
            DdtKingLettersCollectManager.getInstance().setup();
            HappyRechargeManager.instance.setup();
            CSMBoxManager.instance.setup();
            GradeBuyManager.getInstance().setup();
            SanXiaoManager.getInstance().setUp();
            GodOfWealthManager.getInstance().setup();
            SurvivalModeManager.Instance.setup();
            BoguAdventureManager.instance.setup();
            MemoryGameManager.instance.setup();
            GodCardRaiseManager.Instance.setup();
            CloudBuyLotteryManager.Instance.setup();
            NewYearRiceManager.instance.setup();
            MoneyTreeManager.getInstance().setup();
            LuckStarManager.Instance.setup();
            ChickActivationManager.instance.setup();
            DDPlayManaer.Instance.setup();
            ItemActivityGiftManager.instance.setup();
            MapManager.Instance.setup();
            MagicHouseManager.instance.setup();
            ZodiacManager.instance.setup();
            TreasurePuzzleManager.Instance.setup();
            RedEnvelopeManager.instance.setup();
            SignBuffManager.instance.setup();
            WitchBlessingManager.Instance.setup();
            GuildMemberWeekManager.instance.setup();
            GrowthPackageManager.instance.setup();
            DDQiYuanManager.instance.setup();
            CallBackFundManager.instance.setup();
            CallBackLotteryDrawManager.instance.setup();
            BattleSkillManager.instance.setup();
            RankManager.instance.setup();
            CityBattleManager.instance.setup();
            RoleRechargeMgr.instance.setup();
            LoginDeviceManager.instance().setup();
            WasteRecycleManager.Instance.setup();
            WelfareCenterManager.instance.setup();
            SignActivityMgr.instance.setup();
            DemonChiYouManager.instance.setup();
            GoldmineManager.Instance.setup();
            LotteryManager.instance.setup();
            ConsortiaGuardControl.Instance.setup();
            HappyLittleGameManager.instance.setUp();
            CondiscountManager.instance.setup();
            DefendislandManager.instance.setup();
            PvePowerBuffManager.instance.setup();
            ConRechargeManager.instance.setup();
            BankManager.instance.setup();
            StockMgr.inst.setup();
            MinesManager.instance.setup();
            InviteManager.Instance.setup();
            TeamManager.instance.setup();
            DDTKingWayManager.instance.setup();
            MarkMgr.inst.setup();
            DevilTurnManager.instance.setup();
            WorldcupManager.instance.setup();
            DailyRecordControl.Instance.setup();
            NewOldPlayerManager.instance.stup();
         }
      }
      
      private function initWonderfulIcon() : void
      {
         WonderfulActivityManager.Instance.hasActivity = true;
      }
      
      private function deleWAIcon() : void
      {
         WonderfulActivityManager.Instance.hasActivity = false;
      }
      
      private function setupComponent() : void
      {
         ComponentEmbed;
         ComponentSetting.COMBOX_LIST_LAYER = LayerManager.Instance.getLayerByType(0);
         ComponentSetting.PLAY_SOUND_FUNC = SoundManager.instance.play;
         ComponentSetting.SEND_USELOG_ID = SocketManager.Instance.out.sendUseLog;
         var alertInfo:AlertInfo = new AlertInfo();
         alertInfo.mutiline = true;
         alertInfo.buttonGape = 15;
         alertInfo.autoDispose = true;
         alertInfo.sound = "008";
         AlertManager.Instance.setup(1,alertInfo);
      }
      
      private function soundPlay() : void
      {
         SoundManager.instance.play("008");
      }
   }
}
