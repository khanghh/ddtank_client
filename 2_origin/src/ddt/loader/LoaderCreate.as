package ddt.loader
{
   import AvatarCollection.AvatarCollectionManager;
   import AvatarCollection.data.AvatarCollectionItemDataAnalyzer;
   import AvatarCollection.data.AvatarCollectionUnitDataAnalyzer;
   import BraveDoor.BraveDoorManager;
   import GodSyah.SyahAnalyzer;
   import GodSyah.SyahManager;
   import Indiana.IndianaDataManager;
   import Indiana.analyzer.IndianaGoodsItemAnalyzer;
   import Indiana.analyzer.IndianaShopItemsAnalyzer;
   import accumulativeLogin.AccumulativeLoginAnalyer;
   import accumulativeLogin.AccumulativeManager;
   import angelInvestment.AngelInvestmentManager;
   import angelInvestment.data.AngelInvestmentDataAnalyzer;
   import bagAndInfo.BagAndInfoManager;
   import bagAndInfo.amulet.EquipAmuletActivateGradeDataAnalyzer;
   import bagAndInfo.amulet.EquipAmuletDataAnalyzer;
   import bagAndInfo.amulet.EquipAmuletManager;
   import bagAndInfo.amulet.EquipAmuletPhaseDataAnalyzer;
   import bagAndInfo.bag.ring.data.RingDataAnalyzer;
   import bagAndInfo.ddtKingGrade.DDTKingGradeAnalyzer;
   import bagAndInfo.ddtKingGrade.DDTKingGradeManager;
   import bagAndInfo.energyData.EnergyDataAnalyzer;
   import bank.BankManager;
   import bank.analyzer.BankInvestmentDataAnalyzer;
   import battleSkill.BattleSkillManager;
   import battleSkill.analyzer.BattleSKillUpdateTemplateAnalyzer;
   import battleSkill.analyzer.BattleSkillSkillTemplateAnalyzer;
   import calendar.CalendarManager;
   import campbattle.CampBattleManager;
   import campbattle.data.CampBattleAwardsDataAnalyzer;
   import cardSystem.CardManager;
   import cardSystem.CardTemplateInfoManager;
   import cardSystem.GrooveInfoManager;
   import cardSystem.analyze.CardAchievementAnalyze;
   import cardSystem.analyze.CardTemplateAnalyzer;
   import cardSystem.analyze.SetsPropertiesAnalyzer;
   import cardSystem.analyze.SetsSortRuleAnalyzer;
   import chickActivation.ChickActivationManager;
   import cityBattle.CityBattleManager;
   import cityBattle.analyze.CityBattleAnalyze;
   import cloudBuyLottery.CloudBuyLotteryManager;
   import collectionTask.CollectionTaskManager;
   import collectionTask.model.CollectionTaskAnalyzer;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.LoaderResourceEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderManager;
   import com.pickgliss.loader.LoaderSavingManager;
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.loader.RequestLoader;
   import com.pickgliss.loader.TextLoader;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import consortion.analyze.ConsortiaBossDataAnalyzer;
   import consortion.analyze.ConsortiaRichRankAnalyze;
   import consortion.analyze.ConsortiaWeekRewardAnalyze;
   import consortion.analyze.ConsortionListAnalyzer;
   import consortion.analyze.ConsortionMemberAnalyer;
   import dayActivity.ActivePointAnalzer;
   import dayActivity.ActivityAnalyzer;
   import dayActivity.ActivityRewardAnalyzer;
   import dayActivity.DayActivityManager;
   import ddt.data.Experience;
   import ddt.data.GoodsAdditioner;
   import ddt.data.PetExperience;
   import ddt.data.analyze.ActivitySystemItemsDataAnalyzer;
   import ddt.data.analyze.AdvanceBeadAnalyzer;
   import ddt.data.analyze.BadgeInfoAnalyzer;
   import ddt.data.analyze.BallInfoAnalyzer;
   import ddt.data.analyze.BeadAnalyzer;
   import ddt.data.analyze.BoxTempInfoAnalyzer;
   import ddt.data.analyze.BraveDoorDuplicateAnalyzer;
   import ddt.data.analyze.CardGrooveEventAnalyzer;
   import ddt.data.analyze.DailyLeagueAwardAnalyzer;
   import ddt.data.analyze.DailyLeagueLevelAnalyzer;
   import ddt.data.analyze.DaylyGiveAnalyzer;
   import ddt.data.analyze.DungeonAnalyzer;
   import ddt.data.analyze.EquipSuitTempleteAnalyzer;
   import ddt.data.analyze.ExpericenceAnalyze;
   import ddt.data.analyze.FilterWordAnalyzer;
   import ddt.data.analyze.FineSuitAnalyze;
   import ddt.data.analyze.FriendListAnalyzer;
   import ddt.data.analyze.GoodCategoryAnalyzer;
   import ddt.data.analyze.GoodsAdditionAnalyer;
   import ddt.data.analyze.InventoryItemAnalyzer;
   import ddt.data.analyze.ItemTempleteAnalyzer;
   import ddt.data.analyze.LoginSelectListAnalyzer;
   import ddt.data.analyze.MapAnalyzer;
   import ddt.data.analyze.MovingNotificationAnalyzer;
   import ddt.data.analyze.MyAcademyPlayersAnalyze;
   import ddt.data.analyze.PetAllSkillAnalyzer;
   import ddt.data.analyze.PetExpericenceAnalyze;
   import ddt.data.analyze.PetInfoAnalyzer;
   import ddt.data.analyze.PetMoePropertyAnalyzer;
   import ddt.data.analyze.PetSkillAnalyzer;
   import ddt.data.analyze.PetconfigAnalyzer;
   import ddt.data.analyze.PetsEvolutionDataAnalyzer;
   import ddt.data.analyze.PetsFormDataAnalyzer;
   import ddt.data.analyze.PyramidAnalyze;
   import ddt.data.analyze.QuestListAnalyzer;
   import ddt.data.analyze.QuestionInfoAnalyze;
   import ddt.data.analyze.RegisterAnalyzer;
   import ddt.data.analyze.ServerConfigAnalyz;
   import ddt.data.analyze.ServerListAnalyzer;
   import ddt.data.analyze.ShopItemAnalyzer;
   import ddt.data.analyze.ShopItemDisCountAnalyzer;
   import ddt.data.analyze.ShopItemSortAnalyzer;
   import ddt.data.analyze.SuitTempleteAnalyzer;
   import ddt.data.analyze.TexpExpAnalyze;
   import ddt.data.analyze.UserBoxInfoAnalyzer;
   import ddt.data.analyze.VoteInfoAnalyzer;
   import ddt.data.analyze.VoteSubmitAnalyzer;
   import ddt.data.analyze.WeaponBallInfoAnalyze;
   import ddt.data.analyze.WeekOpenMapAnalyze;
   import ddt.data.analyze.WishInfoAnalyzer;
   import ddt.manager.BadgeInfoManager;
   import ddt.manager.BallManager;
   import ddt.manager.BeadTemplateManager;
   import ddt.manager.BossBoxManager;
   import ddt.manager.DailyLeagueManager;
   import ddt.manager.FineSuitManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MapManager;
   import ddt.manager.PathManager;
   import ddt.manager.PetAllSkillManager;
   import ddt.manager.PetInfoManager;
   import ddt.manager.PetSkillManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.PyramidManager;
   import ddt.manager.QuestionInfoMannager;
   import ddt.manager.SelectListManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.ServerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.VoteManager;
   import ddt.manager.WeaponBallManager;
   import ddt.utils.FilterWordManager;
   import ddt.utils.RequestVairableCreater;
   import ddt.view.caddyII.CaddyAwardDataAnalyzer;
   import ddt.view.caddyII.CaddyAwardModel;
   import ddtBuried.BuriedManager;
   import ddtBuried.analyer.SearchGoodsPayAnalyer;
   import ddtBuried.analyer.UpdateStarAnalyer;
   import ddtKingWay.DDTKingWayManager;
   import ddtKingWay.analyzer.DDTKingWayDataAnalyzer;
   import defendisland.DefendislandManager;
   import devilTurn.DevilTurnManager;
   import devilTurn.analyze.DevilTurnBoxConvertAnalyzer;
   import devilTurn.analyze.DevilTurnGoodsItemAnalyzer;
   import devilTurn.analyze.DevilTurnPointShopAnalyzer;
   import devilTurn.analyze.DevilTurnRankRewardAnalyzer;
   import dragonBoat.DragonBoatManager;
   import dragonBoat.analyzer.DragonBoatActiveDataAnalyzer;
   import dreamlandChallenge.DreamlandChallengeManager;
   import dreamlandChallenge.analyzer.UnrealRankRewardAnalyzer;
   import enchant.EnchantInfoAnalyzer;
   import enchant.EnchantManager;
   import explorerManual.ExplorerManualManager;
   import explorerManual.analyzer.ChapterItemAnalyzer;
   import explorerManual.analyzer.ManualDebrisAnalyzer;
   import explorerManual.analyzer.ManualItemAnalyzer;
   import explorerManual.analyzer.ManualPageItemAnalyzer;
   import explorerManual.analyzer.ManualUpgradeAnalyzer;
   import farm.FarmModelController;
   import farm.analyzer.FarmTreePoultryListAnalyzer;
   import farm.analyzer.FoodComposeListAnalyzer;
   import farm.control.FarmComposeHouseController;
   import feedback.FeedbackManager;
   import feedback.analyze.LoadFeedbackReplyAnalyzer;
   import firstRecharge.FirstRechargeManger;
   import firstRecharge.analyer.RechargeAnalyer;
   import flash.net.URLVariables;
   import flash.utils.getDefinitionByName;
   import godCardRaise.GodCardRaiseManager;
   import godCardRaise.analyzer.GodCardListAnalyzer;
   import godCardRaise.analyzer.GodCardListGroupAnalyzer;
   import godCardRaise.analyzer.GodCardPointRewardListAnalyzer;
   import godsRoads.analyze.GodsRoadsDataAnalyzer;
   import godsRoads.manager.GodsRoadsManager;
   import groupPurchase.GroupPurchaseManager;
   import groupPurchase.analyzer.GroupPurchaseAwardAnalyzer;
   import growthPackage.GrowthPackageManager;
   import guardCore.GuardCoreManager;
   import guardCore.analyzer.GuardCoreAnalyzer;
   import guardCore.analyzer.GuardCoreLevelAnayzer;
   import guildMemberWeek.manager.GuildMemberWeekManager;
   import horse.HorseAmuletManager;
   import horse.HorseManager;
   import horse.analyzer.HorseAmuletDataAnalyzer;
   import horse.analyzer.HorsePicCherishAnalyzer;
   import horse.analyzer.HorseSkillDataAnalyzer;
   import horse.analyzer.HorseSkillElementDataAnalyzer;
   import horse.analyzer.HorseSkillGetDataAnalyzer;
   import horse.analyzer.HorseTemplateDataAnalyzer;
   import horseRace.controller.HorseRaceManager;
   import lanternriddles.LanternRiddlesManager;
   import lanternriddles.analyzer.LanternDataAnalyzer;
   import loginDevice.LoginDeviceManager;
   import lotteryTicket.LotteryManager;
   import magicHouse.MagicBoxDataAnalyzer;
   import magicHouse.MagicHouseManager;
   import magicStone.MagicStoneManager;
   import magicStone.data.MagicStoneTempAnalyer;
   import mainbutton.data.HallIconDataAnalyz;
   import mainbutton.data.MainButtonManager;
   import mark.MarkMgr;
   import mark.analyzer.MarkChipAnalyzer;
   import mark.analyzer.MarkHammerAnalyzer;
   import mark.analyzer.MarkProAnalyzer;
   import mark.analyzer.MarkSetAnalyzer;
   import mark.analyzer.MarkSuitAnalyzer;
   import mark.analyzer.MarkTransferAnalyzer;
   import memoryGame.MemoryGameManager;
   import memoryGame.analyzer.MemoryGameAnalyzer;
   import mines.MinesManager;
   import mines.analyzer.MinesDropAnalyzer;
   import mines.analyzer.MinesLevelAnalyzer;
   import newTitle.NewTitleManager;
   import newTitle.analyzer.NewTitleDataAnalyz;
   import newYearRice.NewYearRiceManager;
   import particleSystem.EmitterInfoAnalyzer;
   import particleSystem.ParticleManager;
   import petsBag.PetsBagManager;
   import petsBag.data.PetAtlasAnalyzer;
   import petsBag.petsAdvanced.PetsAdvancedManager;
   import petsBag.petsAdvanced.PetsCellUnlocakPriceAnalyzer;
   import petsBag.petsAdvanced.PetsRisingStarDataAnalyzer;
   import quest.TaskManager;
   import rank.RankManager;
   import rank.analyzer.RankingListAwardAnalyzer;
   import redEnvelope.RedEnvelopeManager;
   import rescue.RescueManager;
   import rescue.analyzer.RescueRewardAnalyzer;
   import roomList.movingNotification.MovingNotificationManager;
   import sanXiao.SanXiaoManager;
   import sanXiao.model.SanXiaoScoreRewardAnalyzer;
   import sanXiao.model.SanXiaoStoreItemAnalyzer;
   import sevenDayTarget.controller.SevenDayTargetManager;
   import sevenDayTarget.dataAnalyzer.SevenDayTargetDataAnalyzer;
   import signBuff.SignBuffManager;
   import stock.analyzer.StockAnalyzer;
   import stock.analyzer.StockNewsAnalyzer;
   import store.FineEvolutionManager;
   import store.analyze.EvolutionDataAnalyzer;
   import store.analyze.StoreEquipExpericenceAnalyze;
   import store.data.StoreEquipExperience;
   import store.equipGhost.EquipGhostManager;
   import store.equipGhost.data.GhostDataAnalyzer;
   import store.forge.wishBead.WishBeadManager;
   import store.newFusion.FusionNewManager;
   import store.newFusion.data.FusionNewDataAnalyzer;
   import store.view.strength.analyzer.ItemStrengthenGoodsInfoAnalyzer;
   import store.view.strength.manager.ItemStrengthenGoodsInfoManager;
   import superWinner.analyze.SuperWinnerAnalyze;
   import superWinner.manager.SuperWinnerManager;
   import team.TeamManager;
   import team.analyze.TeamActiveAnalyze;
   import team.analyze.TeamBattleSeasonAnalyzer;
   import team.analyze.TeamBattleSegmentAnalyzer;
   import team.analyze.TeamLevelAnalyze;
   import team.analyze.TeamMemberAnalyze;
   import team.analyze.TeamRankAnalyze;
   import team.analyze.TeamShopAnalyze;
   import texpSystem.controller.TexpManager;
   import totem.HonorUpManager;
   import totem.TotemManager;
   import totem.data.HonorUpDataAnalyz;
   import totem.data.TotemDataAnalyz;
   import totem.data.TotemUpGradeAnalyz;
   import uiModeManager.bombUI.BombGameFixedMapAnalyzer;
   import uiModeManager.bombUI.HappyLittleGameManager;
   import uiModeManager.bombUI.model.bomb.BombGameRandomMapAnalyzer;
   import uiModeManager.bombUI.model.rank.HappyLittleGameRankAnalyzer;
   import welfareCenter.callBackFund.CallBackFundManager;
   import witchBlessing.WitchBlessingManager;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.analyer.WonderfulActAnalyer;
   import wonderfulActivity.analyer.WonderfulGMActAnalyer;
   
   public class LoaderCreate
   {
      
      private static var _instance:LoaderCreate;
       
      
      private var _reloadCount:int = 0;
      
      private var _reloadQuestCount:int = 0;
      
      public function LoaderCreate()
      {
         super();
         LoadResourceManager.Instance.addEventListener("loadError",__onLoadError);
      }
      
      public static function get Instance() : LoaderCreate
      {
         if(_instance == null)
         {
            _instance = new LoaderCreate();
         }
         return _instance;
      }
      
      public function createAudioILoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveSoundSwf(),4);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingAudioIFail");
         return loader;
      }
      
      public function createAudioIILoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveSoundSwf2(),4);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingAudioIIFail");
         return loader;
      }
      
      public function createAudioLiteLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveSoundSwf3(),4);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingAudioIIFail");
         return loader;
      }
      
      public function createAudioBattleLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveSoundSwfBattle(),4);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingAudioBattleFail");
         return loader;
      }
      
      public function loadExppression(fun:Function) : void
      {
         var loader:ModuleLoader = LoadResourceManager.Instance.createLoader(PathManager.getExpressionPath(),4);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingExpressionResourcesFailure");
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      public function creatBallInfoLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("BallList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingBombMetadataFailure");
         loader.analyzer = new BallInfoAnalyzer(BallManager.instance.setup);
         return loader;
      }
      
      public function creatBoxTempInfoLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoadBoxTemp.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingChestsListFailure");
         loader.analyzer = new BoxTempInfoAnalyzer(BossBoxManager.instance.setupBoxTempInfo);
         return loader;
      }
      
      public function creatDungeonInfoLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoadPVEItems.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingCopyMapsInformationFailure");
         loader.analyzer = new DungeonAnalyzer(MapManager.setupDungeonInfo);
         return loader;
      }
      
      public function creatFriendListLoader() : BaseLoader
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["id"] = PlayerManager.Instance.Self.ID;
         args["uname"] = PlayerManager.Instance.Account.Account;
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("IMListLoad.ashx"),7,args);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingBuddyListFailure");
         loader.analyzer = new FriendListAnalyzer(PlayerManager.Instance.setupFriendList);
         return loader;
      }
      
      public function creatMyacademyPlayerListLoader() : BaseLoader
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["RelationshipID"] = PlayerManager.Instance.Self.masterID;
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("UserApprenticeshipInfoList.ashx"),6,args);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.data.analyze.MyAcademyPlayersAnalyze");
         loader.analyzer = new MyAcademyPlayersAnalyze(PlayerManager.Instance.setupMyacademyPlayers);
         return loader;
      }
      
      public function creatGoodCategoryLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoadItemsCategory.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingItemTypeFailure");
         loader.analyzer = new GoodCategoryAnalyzer(ItemManager.Instance.setupGoodsCategory);
         return loader;
      }
      
      public function creatItemTempleteLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("TemplateAllList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingGoodsTemplateFailure");
         loader.analyzer = new ItemTempleteAnalyzer(ItemManager.Instance.setupGoodsTemplates);
         return loader;
      }
      
      public function creatItemTempleteReload() : BaseLoader
      {
         _reloadCount = _reloadCount + 1;
         var variables:URLVariables = new URLVariables();
         variables["lv"] = LoaderSavingManager.Version + _reloadCount;
         variables["rnd"] = TextLoader.TextLoaderKey + _reloadCount.toString();
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ShopBox.xml"),2,variables);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingNewGoodsTemplateFailure");
         loader.analyzer = new ItemTempleteAnalyzer(ItemManager.Instance.addGoodsTemplates);
         return loader;
      }
      
      public function creatSuitTempleteLoader() : BaseLoader
      {
         var loader:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("SuitTemplateInfoList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingGoodsTemplateFailure");
         loader.analyzer = new SuitTempleteAnalyzer(ItemManager.Instance.setupSuitTemplates);
         return loader;
      }
      
      public function creatEquipSuitTempleteLoader() : BaseLoader
      {
         var loader:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("SuitPartEquipInfoList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingGoodsTemplateFailure");
         loader.analyzer = new EquipSuitTempleteAnalyzer(ItemManager.Instance.setupEquipSuitTemplates);
         return loader;
      }
      
      public function creatBadgeInfoLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaBadgeConfig.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingBadgeInfoFailure");
         loader.analyzer = new BadgeInfoAnalyzer(BadgeInfoManager.instance.setup);
         return loader;
      }
      
      public function creatMovingNotificationLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.getMovingNotificationPath(),2);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingAnnouncementFailure");
         loader.analyzer = new MovingNotificationAnalyzer(MovingNotificationManager.Instance.setup);
         return loader;
      }
      
      public function creatDailyInfoLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("DailyAwardList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingLoginFailedRewardInformation");
         loader.analyzer = new DaylyGiveAnalyzer(CalendarManager.getInstance().setDailyInfo);
         return loader;
      }
      
      public function creatMapInfoLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoadMapsItems.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadMapInformationFailure");
         loader.analyzer = new MapAnalyzer(MapManager.setupMapInfo);
         return loader;
      }
      
      public function creatOpenMapInfoLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("MapServerList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingOpenMapListFailure");
         loader.analyzer = new WeekOpenMapAnalyze(MapManager.setupOpenMapInfo);
         return loader;
      }
      
      public function creatQuestTempleteLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("QuestList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingTaskListFailure");
         loader.analyzer = new QuestListAnalyzer(TaskManager.instance.setup);
         return loader;
      }
      
      public function creatQuestTempleteReload() : BaseLoader
      {
         _reloadQuestCount = _reloadQuestCount + 1;
         var variables:URLVariables = new URLVariables();
         variables["lv"] = LoaderSavingManager.Version + _reloadQuestCount;
         variables["rnd"] = TextLoader.TextLoaderKey + _reloadQuestCount.toString();
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("QuestList.xml"),5,variables);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingTaskListFailure");
         loader.analyzer = new QuestListAnalyzer(TaskManager.instance.reloadNewQuest);
         return loader;
      }
      
      public function creatRegisterLoader() : BaseLoader
      {
         var RegisterState:* = getDefinitionByName("register.RegisterState");
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["Sex"] = RegisterState.SelectedSex;
         args["NickName"] = RegisterState.Nickname;
         args["Name"] = PlayerManager.Instance.Account.Account;
         args["Pass"] = PlayerManager.Instance.Account.Password;
         args["site"] = "";
         var loader:RequestLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("VisualizeRegister.ashx"),6,args);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.FailedToRegister");
         loader.analyzer = new RegisterAnalyzer(null);
         return loader;
      }
      
      public function creatSelectListLoader() : BaseLoader
      {
         var args:URLVariables = new URLVariables();
         args["rnd"] = Math.random();
         args["username"] = PlayerManager.Instance.Account.Account;
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoginSelectList.ashx"),6,args);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingRoleListFailure");
         loader.analyzer = new LoginSelectListAnalyzer(SelectListManager.Instance.setup);
         return loader;
      }
      
      public function creatServerListLoader() : BaseLoader
      {
         var args:URLVariables = new URLVariables();
         args["rnd"] = Math.random();
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ServerList.ashx"),6,args);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingServerListFailure");
         loader.analyzer = new ServerListAnalyzer(ServerManager.Instance.setup);
         return loader;
      }
      
      public function createCardSetsSortRule() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("CardInfoList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.cardSystem.loadfail.setsSortRule");
         loader.analyzer = new SetsSortRuleAnalyzer(CardManager.Instance.initSetsSortRule);
         return loader;
      }
      
      public function createCardSetsProperties() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("CardBuffList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.cardSystem.loadfail.setsProperties");
         loader.analyzer = new SetsPropertiesAnalyzer(CardManager.Instance.initSetsProperties);
         return loader;
      }
      
      public function creatShopTempleteLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ShopItemList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingStoreItemsFail");
         loader.analyzer = new ShopItemAnalyzer(ShopManager.Instance.setup);
         return loader;
      }
      
      public function creatGoodsAdditionLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ItemStrengthenPlusData.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingGoodsAdditionFail");
         loader.analyzer = new GoodsAdditionAnalyer(GoodsAdditioner.Instance.addGoodsAddition);
         return loader;
      }
      
      public function creatShopSortLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ShopGoodsShowList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.TheClassificationOfGoodsLoadingShopFailure");
         loader.analyzer = new ShopItemSortAnalyzer(ShopManager.Instance.sortShopItems);
         return loader;
      }
      
      public function creatAllQuestionInfoLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoadAllQuestions.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingTestFailure");
         loader.analyzer = new QuestionInfoAnalyze(QuestionInfoMannager.Instance.analyzer);
         return loader;
      }
      
      public function creatUserBoxInfoLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoadUserBox.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingChestsInformationFailure");
         loader.analyzer = new UserBoxInfoAnalyzer(BossBoxManager.instance.setupBoxInfo);
         return loader;
      }
      
      public function creatZhanLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.getZhanPath(),2);
         loader.loadErrorMessage = "LoadingDirtyCharacterSheetsFailure";
         loader.analyzer = new FilterWordAnalyzer(FilterWordManager.setup);
         return loader;
      }
      
      public function createConsortiaLoader() : BaseLoader
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["id"] = PlayerManager.Instance.Self.ID;
         args["page"] = 1;
         args["size"] = 10000;
         args["order"] = -1;
         args["consortiaID"] = PlayerManager.Instance.Self.ConsortiaID;
         args["userID"] = -1;
         args["state"] = -1;
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaUsersList.ashx"),7,args);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingGuildMembersListFailure");
         loader.analyzer = new ConsortionMemberAnalyer(ConsortionModelManager.Instance.memberListComplete);
         return loader;
      }
      
      public function createCalendarRequest() : BaseLoader
      {
         return CalendarManager.getInstance().request();
      }
      
      public function getMyConsortiaData() : BaseLoader
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["page"] = 1;
         args["size"] = 1;
         args["name"] = "";
         args["level"] = -1;
         args["ConsortiaID"] = PlayerManager.Instance.Self.ConsortiaID;
         args["order"] = -1;
         args["openApply"] = -1;
         var loadConsortias:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaList.ashx"),7,args);
         loadConsortias.loadErrorMessage = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.LoadMyconsortiaInfoError");
         loadConsortias.analyzer = new ConsortionListAnalyzer(ConsortionModelManager.Instance.selfConsortionComplete);
         return loadConsortias;
      }
      
      public function creatFeedbackInfoLoader() : BaseLoader
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["userid"] = PlayerManager.Instance.Self.ID;
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("AdvanceQuestionRead.ashx"),6,args);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingComplainInformationFailure");
         loader.analyzer = new LoadFeedbackReplyAnalyzer(FeedbackManager.instance.setupFeedbackData);
         return loader;
      }
      
      public function creatExpericenceAnalyzeLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LevelList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingAchievementTemplateFormFailure");
         loader.analyzer = new ExpericenceAnalyze(Experience.setup);
         return loader;
      }
      
      public function creatPetExpericenceAnalyzeLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("PetLevelInfo.xml"),2);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingPetExpirenceTemplateFormFailure");
         loader.analyzer = new PetExpericenceAnalyze(PetExperience.setup);
         return loader;
      }
      
      public function creatTexpExpLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ExerciseInfoList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingTexpExpFailure");
         loader.analyzer = new TexpExpAnalyze(TexpManager.Instance.setup);
         return loader;
      }
      
      public function creatRingSystemLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoveLeveList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingRingSystemFailure");
         loader.analyzer = new RingDataAnalyzer(BagAndInfoManager.Instance.loadRingSystemInfo);
         return loader;
      }
      
      public function creatWeaponBallAnalyzeLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("BombConfig.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingWeaponBallListFormFailure");
         loader.analyzer = new WeaponBallInfoAnalyze(WeaponBallManager.setup);
         return loader;
      }
      
      public function creatDailyLeagueAwardLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("DailyLeagueAward.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingDailyLeagueAwardFailure");
         loader.analyzer = new DailyLeagueAwardAnalyzer(DailyLeagueManager.Instance.setup);
         return loader;
      }
      
      public function creatDailyLeagueLevelLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("DailyLeagueLevel.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingDailyLeagueLevelFailure");
         loader.analyzer = new DailyLeagueLevelAnalyzer(DailyLeagueManager.Instance.setup);
         return loader;
      }
      
      public function createWishInfoLader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("GoldEquipTemplateLoad.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingDailyLeagueLevelFailure");
         loader.analyzer = new WishInfoAnalyzer(WishBeadManager.instance.getwishInfo);
         return loader;
      }
      
      public function creatServerConfigLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ServerConfig.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingDailyLeagueLevelFailure");
         loader.analyzer = new ServerConfigAnalyz(ServerConfigManager.instance.getserverConfigInfo);
         return loader;
      }
      
      public function creatPetInfoLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("PetTemplateInfo.xml"),2);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadPetInfoFail");
         loader.analyzer = new PetInfoAnalyzer(PetInfoManager.setup);
         return loader;
      }
      
      public function creatPetSkillLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("Petskillinfo.xml"),2);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadPetSkillFail");
         loader.analyzer = new PetSkillAnalyzer(PetSkillManager.setup);
         return loader;
      }
      
      public function creatFarmPoultryInfo() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("TreeTemplateList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.getPoultryFail");
         loader.analyzer = new FarmTreePoultryListAnalyzer(FarmModelController.instance.getTreePoultryListData);
         return loader;
      }
      
      public function creatFoodComposeLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("FoodComposeList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadFoodComposeListFail");
         loader.analyzer = new FoodComposeListAnalyzer(FarmComposeHouseController.instance().setupFoodComposeList);
         return loader;
      }
      
      public function creatPetConfigLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("PetConfigInfo.xml"),2);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadPetConfigFail");
         loader.analyzer = new PetconfigAnalyzer(null);
         return loader;
      }
      
      public function creatPetSkillTemplateInfoLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("PetSkillTemplateInfo.xml"),2);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadPetAllSkillFail");
         loader.analyzer = new PetAllSkillAnalyzer(PetAllSkillManager.setup);
         return loader;
      }
      
      public function creatActiveInfoLoader() : BaseLoader
      {
         return CalendarManager.getInstance().requestActiveEvent();
      }
      
      public function creatActionExchangeInfoLoader() : BaseLoader
      {
         return CalendarManager.getInstance().requestActionExchange();
      }
      
      public function creatShopDisCountRealTimesLoader() : BaseLoader
      {
         var args:URLVariables = new URLVariables();
         args["rnd"] = Math.random();
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ShopCheapItemList.ashx"),6,args);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.ShopDisCountRealTimesFailure");
         loader.analyzer = new ShopItemDisCountAnalyzer(ShopManager.Instance.updateRealTimesItemsByDisCount);
         return loader;
      }
      
      public function creatVoteSubmit() : BaseLoader
      {
         var args:URLVariables = new URLVariables();
         args["userId"] = PlayerManager.Instance.Self.ID;
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("VoteSubmit.ashx"),6,args);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.vip.loadVip.error");
         loader.analyzer = new VoteSubmitAnalyzer(loadVoteXml);
         return loader;
      }
      
      public function createStoreEquipConfigLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoadStrengthExp.xml"),2);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadStoreEquipExperienceAllFail");
         loader.analyzer = new StoreEquipExpericenceAnalyze(StoreEquipExperience.setup);
         return loader;
      }
      
      public function creatCardGrooveLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("CardGrooveUpdateList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadCardGrooveFail");
         loader.analyzer = new CardGrooveEventAnalyzer(GrooveInfoManager.instance.setup);
         return loader;
      }
      
      public function creatCardTemplateLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("CardTemplateInfo.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadCardTemplateInfoFail");
         loader.analyzer = new CardTemplateAnalyzer(CardTemplateInfoManager.instance.setup);
         return loader;
      }
      
      public function creatItemStrengthenGoodsInfoLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ItemStrengthenGoodsInfo.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadItemStrengthenGoodsInfoListFail");
         loader.analyzer = new ItemStrengthenGoodsInfoAnalyzer(ItemStrengthenGoodsInfoManager.setup);
         return loader;
      }
      
      public function createBeadTemplateLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("RuneTemplateList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadBeadInfoFail");
         loader.analyzer = new BeadAnalyzer(BeadTemplateManager.Instance.setup);
         return loader;
      }
      
      public function createBeadAdvanceTemplateLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("RuneAdvanceTemplateList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadBeadAdvanceInfoFail");
         loader.analyzer = new AdvanceBeadAnalyzer(BeadTemplateManager.Instance.setupAdvanceBead);
         return loader;
      }
      
      public function creatHallIcon() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ButtonConfig.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadHallIconFail");
         loader.analyzer = new HallIconDataAnalyz(MainButtonManager.instance.gethallIconInfo);
         return loader;
      }
      
      public function createTotemTemplateLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("TotemInfo.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadTotemInfoFail");
         loader.analyzer = new TotemDataAnalyz(TotemManager.instance.inittotmeData);
         return loader;
      }
      
      public function createHonorUpTemplateLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("TotemHonorTemplate.xml"),2);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadHonorUpInfoFail");
         loader.analyzer = new HonorUpDataAnalyz(HonorUpManager.instance.setup);
         return loader;
      }
      
      public function createRankingListAwardLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("RankingListAwardList.xml"),5);
         loader.loadErrorMessage = "RankingListAwardList";
         loader.analyzer = new RankingListAwardAnalyzer(RankManager.instance.activityAwardComp);
         return loader;
      }
      
      public function createConsortiaBossTemplateLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaBossConfigLoad.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadConsortiaBossInfoFail");
         loader.analyzer = new ConsortiaBossDataAnalyzer(ConsortionModelManager.Instance.bossConfigDataSetup);
         return loader;
      }
      
      public function creatActiveLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("EveryDayActivePointTemplateInfoList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadEveryDayActFail");
         loader.analyzer = new ActivityAnalyzer(DayActivityManager.Instance.everyDayActive);
         return loader;
      }
      
      public function creatActivePointLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("EveryDayActiveProgressInfoList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.actInfoFail");
         loader.analyzer = new ActivePointAnalzer(DayActivityManager.Instance.everyDayActivePoint);
         return loader;
      }
      
      public function creatRewardLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("EveryDayActiveRewardTemplateInfoList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("Indiana.loader.error");
         loader.analyzer = new ActivityRewardAnalyzer(DayActivityManager.Instance.activityRewardComp);
         return loader;
      }
      
      public function creatOneYuanBuyGoodsLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("OneYuanBuyAllGoodsTemplate.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("Indiana.loaderAll.error");
         loader.analyzer = new IndianaGoodsItemAnalyzer(IndianaDataManager.instance.goodsItemAnalyzer);
         return loader;
      }
      
      public function creatOneYuanBuySaleItemLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("OneYuanBuyOnSaleGoodsTemplate.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("Indiana.loaderSale.error");
         loader.analyzer = new IndianaShopItemsAnalyzer(IndianaDataManager.instance.shopItemAnalyzer);
         return loader;
      }
      
      public function loaderSearchGoodsTemp() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("SearchGoodsTemp.xml"),2);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.starUpdataInfoFail");
         loader.analyzer = new UpdateStarAnalyer(BuriedManager.Instance.SearchGoodsTempHander);
         return loader;
      }
      
      public function loaderSearchGoodsPayMoney() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("SearchGoodsPayMoney.xml"),2);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.starUpDataCountInfoFail");
         loader.analyzer = new SearchGoodsPayAnalyer(BuriedManager.Instance.searchGoodsPayHander);
         return loader;
      }
      
      public function creatWondActiveLoader() : BaseLoader
      {
         var variables:URLVariables = new URLVariables();
         variables["rnd"] = TextLoader.TextLoaderKey + new Date().time;
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoadChargeActiveTemplate.xml"),5,variables);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.wondActInfoFail");
         loader.analyzer = new WonderfulActAnalyer(WonderfulActivityManager.Instance.wonderfulActiveType);
         return loader;
      }
      
      public function firstRechargeLoader() : BaseLoader
      {
         var variables:URLVariables = new URLVariables();
         variables["rnd"] = TextLoader.TextLoaderKey + new Date().time;
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ChargeSpendRewardTemplateInfoList.xml"),5,variables);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.firstRechargeInfoFail");
         loader.analyzer = new RechargeAnalyer(FirstRechargeManger.Instance.completeHander);
         return loader;
      }
      
      public function accumulativeLoginLoader() : BaseLoader
      {
         var variables:URLVariables = new URLVariables();
         variables["rnd"] = TextLoader.TextLoaderKey + new Date().time;
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoginAwardItemTemplate.xml"),5,variables);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.accumulativeLoginInfoFail");
         loader.analyzer = new AccumulativeLoginAnalyer(AccumulativeManager.instance.loadTempleteDataComplete);
         return loader;
      }
      
      public function createCommunalActiveLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("CommunalActive.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.dragonBoatActiveInfoFail");
         loader.analyzer = new DragonBoatActiveDataAnalyzer(DragonBoatManager.instance.templateDataSetup);
         return loader;
      }
      
      public function createCaddyAwardsLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LotteryShowTemplate.xml"),5);
         loader.analyzer = new CaddyAwardDataAnalyzer(CaddyAwardModel.getInstance().setUp);
         return loader;
      }
      
      public function createNewFusionDataLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("FusionInfoLoad.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.newFusionDataInfoFail");
         loader.analyzer = new FusionNewDataAnalyzer(FusionNewManager.instance.setup);
         return loader;
      }
      
      public function createEnergyDataLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("MissionEnergyPrice.xml"),2);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.energyInfoFail");
         loader.analyzer = new EnergyDataAnalyzer(PlayerManager.Instance.setupEnergyData);
         return loader;
      }
      
      public function createGroupPurchaseAwardInfoLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("TeamBuyActiveAwardInfo.ashx"),6);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.groupPurchaseDataInfoFail");
         loader.analyzer = new GroupPurchaseAwardAnalyzer(GroupPurchaseManager.instance.awardAnalyComplete);
         return loader;
      }
      
      private function loadVoteXml(anlyzer:VoteSubmitAnalyzer) : void
      {
         var loadVoteInfo:* = null;
         if(anlyzer.result == "vote.xml")
         {
            loadVoteInfo = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("vote.xml"),2);
            loadVoteInfo.loadErrorMessage = LanguageMgr.GetTranslation("ddt.view.vote.loadXMLError");
            loadVoteInfo.analyzer = new VoteInfoAnalyzer(VoteManager.Instance.loadCompleted);
            LoadResourceManager.Instance.startLoad(loadVoteInfo);
         }
      }
      
      public function loadWonderfulActivityXml() : BaseLoader
      {
         var variables:URLVariables = new URLVariables();
         variables["rnd"] = TextLoader.TextLoaderKey + new Date().time;
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("GmActivityInfo.xml"),5,variables);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.wonderfulActiveInfoFail");
         loader.analyzer = new WonderfulGMActAnalyer(WonderfulActivityManager.Instance.wonderfulGMActiveInfo);
         return loader;
      }
      
      public function loadLanternRiddlesXml() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LightRiddleQuest.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.lanternRiddlesInfoFail");
         loader.analyzer = new LanternDataAnalyzer(LanternRiddlesManager.instance.questionInfo);
         return loader;
      }
      
      public function createAvatarCollectionUnitDataLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ClothPropertyTemplateInfo.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.AvatarCollectionUnitDataFail");
         loader.analyzer = new AvatarCollectionUnitDataAnalyzer(AvatarCollectionManager.instance.unitListDataSetup);
         return loader;
      }
      
      public function createAvatarCollectionItemDataLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ClothGroupTemplateInfo.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.AvatarCollectionItemDataFail");
         loader.analyzer = new AvatarCollectionItemDataAnalyzer(AvatarCollectionManager.instance.itemListDataSetup);
         return loader;
      }
      
      public function createSanXiaoStoreDataLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("MiniGameShopTemplate.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.SXStoreDataFail");
         loader.analyzer = new SanXiaoStoreItemAnalyzer(SanXiaoManager.getInstance().onSXStoreItemData);
         return loader;
      }
      
      public function createSanXiaoScoreRewardDataLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ThreeCleanPointAward.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.SXScoreRewardDataFail");
         loader.analyzer = new SanXiaoScoreRewardAnalyzer(SanXiaoManager.getInstance().onSXScoreRewardData);
         return loader;
      }
      
      public function createPetCellUnlockPriceLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("PetCellUnlockPrice.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.PetsCellUnlockFail");
         loader.analyzer = new PetsCellUnlocakPriceAnalyzer(PetsBagManager.instance().onPetCellUnlockPrice);
         return loader;
      }
      
      public function createPetsRisingStarDataLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoadPetStarExp.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.PetsAdvancedDataFail");
         loader.analyzer = new PetsRisingStarDataAnalyzer(PetsAdvancedManager.Instance.risingStarDataComplete);
         return loader;
      }
      
      public function createPetsEvolutionDataLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoadPetFightProperty.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.PetsAdvancedDataFail");
         loader.analyzer = new PetsEvolutionDataAnalyzer(PetsAdvancedManager.Instance.evolutionDataComplete);
         return loader;
      }
      
      public function getPetsFormDataLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoadPetFormData.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.PetsFormDataFail");
         loader.analyzer = new PetsFormDataAnalyzer(PetsAdvancedManager.Instance.formDataComplete);
         return loader;
      }
      
      public function loadMagicStoneTemplate() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("MagicStoneTemplate.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.magicStoneTempFail");
         loader.analyzer = new MagicStoneTempAnalyer(MagicStoneManager.instance.loadMgStoneTempComplete);
         return loader;
      }
      
      public function createHorseTemplateDataLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("MountTemplate.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.horseTemplateDataFail");
         loader.analyzer = new HorseTemplateDataAnalyzer(HorseManager.instance.horseTemplateDataSetup);
         return loader;
      }
      
      public function createHorseSkillGetDataLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("MountSkillGetTemplate.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.horseSkillGetDataFail");
         loader.analyzer = new HorseSkillGetDataAnalyzer(HorseManager.instance.horseSkillGetDataSetup);
         return loader;
      }
      
      public function createHorseSkillDataLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("MountSkillTemplate.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.horseSkillDataFail");
         loader.analyzer = new HorseSkillDataAnalyzer(HorseManager.instance.horseSkillDataSetup);
         return loader;
      }
      
      public function createHorseSkillElementDataLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("MountSkillElementTemplate.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.horseSkillElementDataFail");
         loader.analyzer = new HorseSkillElementDataAnalyzer(HorseManager.instance.horseSkillElementDataSetup);
         return loader;
      }
      
      public function createCollectionRebortDataLoader() : BaseLoader
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["id"] = PlayerManager.Instance.Self.ID;
         args["uname"] = PlayerManager.Instance.Account.Account;
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("SceneCollecRandomNpc.ashx"),7,args);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.collectionRobertDataFail");
         loader.analyzer = new CollectionTaskAnalyzer(CollectionTaskManager.Instance.robertDataSetup);
         return loader;
      }
      
      public function createHorsePicCherishDataLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("MountDrawTemplate.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.horsePicCherishDataFail");
         loader.analyzer = new HorsePicCherishAnalyzer(HorseManager.instance.horsePicCherishDataSetup);
         return loader;
      }
      
      public function createNewTitleDataLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("NewTitleInfo.xml"),2);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.newTitleDataFail");
         loader.analyzer = new NewTitleDataAnalyz(NewTitleManager.instance.newTitleDataSetup);
         return loader;
      }
      
      public function createRescueRewardLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("HelpGameReward.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.rescueRewardFail");
         loader.analyzer = new RescueRewardAnalyzer(RescueManager.instance.setupRewardList);
         return loader;
      }
      
      public function createEnchantMagicInfoLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("MagicItemTemp.xml"),2);
         loader.analyzer = new EnchantInfoAnalyzer(EnchantManager.instance.setupInfoList);
         return loader;
      }
      
      public function createFineSuitInfoLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("SetsBuildTemp.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadSuitInfoFail");
         loader.analyzer = new FineSuitAnalyze(FineSuitManager.Instance.setup);
         return loader;
      }
      
      public function creatRouletteTempleteLoader(call:Function) : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("User_LotteryRank.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingGoodsTemplateFailure");
         loader.analyzer = new InventoryItemAnalyzer(call);
         return loader;
      }
      
      public function creatPyramidLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("PyramidActivityItem.xml"),5);
         loader.analyzer = new PyramidAnalyze(PyramidManager.instance.templateDataSetup);
         return loader;
      }
      
      public function creatConsortiaWeekRewardLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaWeekReward.xml"),5);
         loader.analyzer = new ConsortiaWeekRewardAnalyze(ConsortionModelManager.Instance.analyzeWeekReward);
         return loader;
      }
      
      public function creatConsortiaRichRankLoader() : BaseLoader
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["consortiaID"] = PlayerManager.Instance.Self.ConsortiaID;
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaRichRankList.ashx"),6,args);
         loader.analyzer = new ConsortiaRichRankAnalyze(ConsortionModelManager.Instance.analyzeRichRank);
         return loader;
      }
      
      public function creatMemoryGameAwardLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("PairUpPointAward.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("memoryGame.loaderError");
         loader.analyzer = new MemoryGameAnalyzer(MemoryGameManager.instance.analyzer);
         return loader;
      }
      
      public function lodaPetAtlasTemplate() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("PetCollectPropertyTemplate.xml"),5);
         loader.analyzer = new PetAtlasAnalyzer(PetsBagManager.instance().petAtlasAnalyzer);
         return loader;
      }
      
      public function creatGuardCoreLevelTemplate() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("GuardCoreLevelTemplate.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("guardCore.GuardCoreLevelTemplate.error");
         loader.analyzer = new GuardCoreLevelAnayzer(GuardCoreManager.instance.analyzerLevel);
         return loader;
      }
      
      public function creatGuardCoreTemplate() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("GuardCoreTemplate.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("guardCore.GuardCoreTemplate.error");
         loader.analyzer = new GuardCoreAnalyzer(GuardCoreManager.instance.analyzer);
         return loader;
      }
      
      public function creatGodCardListTemplate() : BaseLoader
      {
         var args:URLVariables = new URLVariables();
         args["rnd"] = Math.random();
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("GodCardList.xml"),5,args);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.godCardListTemplate.error");
         loader.analyzer = new GodCardListAnalyzer(GodCardRaiseManager.Instance.loadGodCardListTemplate);
         return loader;
      }
      
      public function creatGodCardListGroup() : BaseLoader
      {
         var args:URLVariables = new URLVariables();
         args["rnd"] = Math.random();
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("GodCardListGroup.ashx"),7,args);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.godCardListGroup.error");
         loader.analyzer = new GodCardListGroupAnalyzer(GodCardRaiseManager.Instance.loadGodCardListGroup);
         return loader;
      }
      
      public function creatGodCardPointRewardList() : BaseLoader
      {
         var args:URLVariables = new URLVariables();
         args["rnd"] = Math.random();
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("GodCardPointRewardList.ashx"),7,args);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.godCardPointRewardList.error");
         loader.analyzer = new GodCardPointRewardListAnalyzer(GodCardRaiseManager.Instance.loadGodCardPointRewardList);
         return loader;
      }
      
      public function createBattleSkillTemplate() : BaseLoader
      {
         var args:URLVariables = new URLVariables();
         args["rnd"] = Math.random();
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("FairBattleSkillGetTemplate.xml"),5,args);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.battleSkillSkillTemplate.error");
         loader.analyzer = new BattleSkillSkillTemplateAnalyzer(BattleSkillManager.instance.loadSkillTemplateList);
         return loader;
      }
      
      public function createBattleSkillUpdateTemplate() : BaseLoader
      {
         var args:URLVariables = new URLVariables();
         args["rnd"] = Math.random();
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("FairBattleSkillMaterialTemplate.xml"),5,args);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.battleSkillSkillUpdateTemplate.error");
         loader.analyzer = new BattleSKillUpdateTemplateAnalyzer(BattleSkillManager.instance.loadSkillUpdateTemplateList);
         return loader;
      }
      
      public function createBraveDoorDuplicateTemplate() : BaseLoader
      {
         var args:URLVariables = new URLVariables();
         args["rnd"] = Math.random();
         var loader:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.getBraveDoorDuplicateTemplete("braveDoorDuplicate"),2);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("game.braveDoor.duplicateTempLoadError");
         loader.analyzer = new BraveDoorDuplicateAnalyzer(BraveDoorManager.instance.setupDuplicateTemplate);
         LoadResourceManager.Instance.startLoad(loader);
         return loader;
      }
      
      public function createCardAchievementTemplate() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("CardAchievement.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("tank.card.achievementLoaderError");
         loader.analyzer = new CardAchievementAnalyze(CardManager.Instance.initCardAchievement);
         return loader;
      }
      
      public function createDDTKingGradeTemplate() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("MaxLevelTemplate.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddtKingGrade.breakFailLoaderError");
         loader.analyzer = new DDTKingGradeAnalyzer(DDTKingGradeManager.Instance.analyzer);
         return loader;
      }
      
      public function createBombFixedMapData() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("SpaRoomFixedBomb.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.bombgame.mapdata.FailLoaderError");
         loader.analyzer = new BombGameFixedMapAnalyzer(HappyLittleGameManager.instance.bombManager.FixedAnalyzer);
         return loader;
      }
      
      public function createEvolutionData() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("SubWeaponEvolutionTemplate.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("store.view.evolution.FailLoaderError");
         loader.analyzer = new EvolutionDataAnalyzer(FineEvolutionManager.Instance.EvolutionAnalyzer);
         return loader;
      }
      
      public function createHorseAmuletTemplate() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("MountTalismansInfoList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("tank.horseAmulet.loaderTemplateFiale");
         loader.analyzer = new HorseAmuletDataAnalyzer(HorseAmuletManager.instance.analyzer);
         return loader;
      }
      
      public function createBombRandomMapData() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("SpaRoomRandomBomb.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.bombgame.mapdata.FailLoaderError");
         loader.analyzer = new BombGameRandomMapAnalyzer(HappyLittleGameManager.instance.bombManager.RandomAnalyzer);
         return loader;
      }
      
      public function createEquipAmuletGradeTemplate() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("AmuletGradeItemList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("tank.equipAmulet.loadGradeTemplateError");
         loader.analyzer = new EquipAmuletActivateGradeDataAnalyzer(EquipAmuletManager.Instance.analyzerActivateGrade);
         return loader;
      }
      
      public function createEquipAmuletPhaseTemplate() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("AmuletPhaseItemList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("tank.equipAmulet.loadPhaseTemplateError");
         loader.analyzer = new EquipAmuletPhaseDataAnalyzer(EquipAmuletManager.Instance.analyzerPhase);
         return loader;
      }
      
      public function createEquipAmuletTemplate() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("AmuletInfoItemList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("tank.equipAmulet.loadTemplateError");
         loader.analyzer = new EquipAmuletDataAnalyzer(EquipAmuletManager.Instance.analyzer);
         return loader;
      }
      
      public function createDDTKingWayTemplate() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("KingOfRoadQuestInfoList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.DDTKingWayDataFail");
         loader.analyzer = new DDTKingWayDataAnalyzer(DDTKingWayManager.instance.analyzer);
         return loader;
      }
      
      public function createManaualDebrisData() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("JampsDebrisItemList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("explorerManual.manualTempleteData.loadFail") + "_碎片";
         loader.analyzer = new ManualDebrisAnalyzer(ExplorerManualManager.instance.initDebrisData);
         return loader;
      }
      
      public function createChapterItemData() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("JampsChapterItemList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("explorerManual.manualTempleteData.loadFail") + "_章节";
         loader.analyzer = new ChapterItemAnalyzer(ExplorerManualManager.instance.initChapterData);
         return loader;
      }
      
      public function createManualItemData() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("JampsManualItemList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("explorerManual.manualTempleteData.loadFail") + "_手册项";
         loader.analyzer = new ManualItemAnalyzer(ExplorerManualManager.instance.initManualItemData);
         return loader;
      }
      
      public function createManualUpgradeData() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("JampsUpgradeItemList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("explorerManual.manualTempleteData.loadFail") + "_升级";
         loader.analyzer = new ManualUpgradeAnalyzer(ExplorerManualManager.instance.initManualUpgradeData);
         return loader;
      }
      
      public function createPageItemData() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("JampsPageItemList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("explorerManual.manualTempleteData.loadFail") + "_页";
         loader.analyzer = new ManualPageItemAnalyzer(ExplorerManualManager.instance.initPageItemData);
         return loader;
      }
      
      public function CreateMiniGameRankRewardCfgLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("SpaGameWeekAwardInfoList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.miniGameRankFail");
         loader.analyzer = new HappyLittleGameRankAnalyzer(HappyLittleGameManager.instance.onAnalyzeRankRewardCfg);
         return loader;
      }
      
      public function createCityOccupationSystemsLoader() : BaseLoader
      {
         var loader:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("CityOccupationSystems.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.activitySystemItemsInfoFail");
         loader.analyzer = new CityBattleAnalyze(CityBattleManager.instance.CityBattleSystemsHandler);
         return loader;
      }
      
      public function __onLoadError(event:LoaderResourceEvent) : void
      {
         var loader:BaseLoader = event.data as BaseLoader;
         if(loader.type != 2 && loader.type != 5 && loader.type != 6 && loader.type != 7)
         {
            return;
         }
         var msg:String = loader.loadErrorMessage;
         if(loader.analyzer)
         {
            if(loader.analyzer.message != null)
            {
               msg = loader.loadErrorMessage + "\n" + loader.analyzer.message;
            }
         }
         if(msg == null || msg == "" || msg == "null")
         {
            msg = PathManager.getLoaderFileName(loader.url);
         }
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("alert"),msg,LanguageMgr.GetTranslation("tank.room.RoomIIView2.affirm"));
         alert.addEventListener("response",__onAlertResponse);
      }
      
      public function createLoadPetMoePropertyLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoadPetMoeProperty.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.rescueRewardFail");
         loader.analyzer = new PetMoePropertyAnalyzer(PetsAdvancedManager.Instance.moePropertyComplete);
         return loader;
      }
      
      private function __onAlertResponse(event:FrameEvent) : void
      {
         event.currentTarget.removeEventListener("response",__onAlertResponse);
         ObjectUtils.disposeObject(event.currentTarget);
         LeavePageManager.leaveToLoginPath();
      }
      
      public function createActivitySystemItemsLoader() : BaseLoader
      {
         var loader:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("ActivitySystemItems.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.activitySystemItemsInfoFail");
         loader.analyzer = new ActivitySystemItemsDataAnalyzer(activitySystemItemsDataHandler);
         return loader;
      }
      
      private function activitySystemItemsDataHandler(analyzer:DataAnalyzer) : void
      {
         var tempDataAnalyzer:* = null;
         if(analyzer is ActivitySystemItemsDataAnalyzer)
         {
            tempDataAnalyzer = analyzer as ActivitySystemItemsDataAnalyzer;
            PyramidManager.instance.templateDataSetup(tempDataAnalyzer.pyramidSystemDataList);
            GuildMemberWeekManager.instance.templateDataSetup(tempDataAnalyzer.guildMemberWeekDataList);
            GrowthPackageManager.instance.templateDataSetup(tempDataAnalyzer.growthPackageDataList);
            ChickActivationManager.instance.templateDataSetup(tempDataAnalyzer.chickActivationDataList);
            WitchBlessingManager.Instance.templateDataSetup(tempDataAnalyzer.witchBlessingDataList);
            NewYearRiceManager.instance.templateDataSetup(tempDataAnalyzer.newYearRiceDataList);
            HorseRaceManager.Instance.templateDataSetup(tempDataAnalyzer.horseRaceDataList);
            CloudBuyLotteryManager.Instance.templateDataSetup(tempDataAnalyzer.happyBuyBbyBuyDataList);
            RedEnvelopeManager.instance.templateDataSetup(tempDataAnalyzer.redEnvelopeDataList);
            LoginDeviceManager.instance().templateDataSetup(tempDataAnalyzer.loginDeviceDataList);
            SignBuffManager.instance.templateDataSetup(tempDataAnalyzer.signBuffDataList);
            CallBackFundManager.instance.templateDataSetup(tempDataAnalyzer.callbackDataList);
            LotteryManager.instance.templateDataSetup(tempDataAnalyzer.lotteryDataList);
            DefendislandManager.instance.templateDataSetup(tempDataAnalyzer.defendislandDataList);
         }
      }
      
      public function createMagicBoxDataLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("MagicFusionData.xml"),5);
         loader.analyzer = new MagicBoxDataAnalyzer(MagicHouseManager.instance.setupMagicBoxData);
         return loader;
      }
      
      public function creatGodSyahLoader(type:int = 7) : BaseLoader
      {
         if(type != 7)
         {
            return null;
         }
         var variables:URLVariables = new URLVariables();
         variables["rnd"] = TextLoader.TextLoaderKey + Math.random().toString();
         var loader:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("SubActiveList.ashx"),6,variables);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingGodSyahFailure");
         loader.analyzer = new SyahAnalyzer(SyahManager.Instance.godSyahLoaderCompleted);
         return loader;
      }
      
      public function createGodsRoadsLoader() : BaseLoader
      {
         var loader:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("ActivityQuestList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.godsRoads.cuowu");
         loader.analyzer = new GodsRoadsDataAnalyzer(GodsRoadsManager.instance.templateDataSetup);
         return loader;
      }
      
      public function creatSuperWinnerLoader() : BaseLoader
      {
         var loader:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("DiceGameAwardItem.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.superWinner.loadAwardsError");
         loader.analyzer = new SuperWinnerAnalyze(SuperWinnerManager.instance.awardsLoadCompleted);
         return loader;
      }
      
      public function createSevenDayTargetLoader() : BaseLoader
      {
         var loader:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("ActivityQuestList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.sevenDayTargetInfoFail");
         loader.analyzer = new SevenDayTargetDataAnalyzer(SevenDayTargetManager.Instance.templateDataSetup);
         return loader;
      }
      
      public function createCampBattleAwardGoodsLoader() : BaseLoader
      {
         var loader:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("CampWarItems.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.activitySystemItemsInfoFail");
         loader.analyzer = new CampBattleAwardsDataAnalyzer(CampBattleManager.instance.templateDataSetup);
         return loader;
      }
      
      public function creatParticlesLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.getParticlesPath(),2);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingParticlesError");
         loader.analyzer = new EmitterInfoAnalyzer(ParticleManager.Instance.loadConfig);
         return loader;
      }
      
      public function createBankLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("BankTemplateInfo.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.BankInvestmentDataFail");
         loader.analyzer = new BankInvestmentDataAnalyzer(BankManager.instance.onDataComplete);
         return loader;
      }
      
      public function createEquipGhostLoader() : BaseLoader
      {
         var loader:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("SpiritInfoList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.activitySystemItemsInfoFail");
         loader.analyzer = new GhostDataAnalyzer(EquipGhostManager.getInstance().analyzerCompleteHandler);
         return loader;
      }
      
      public function createStockLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("StockTemplateInfo.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("stockTemplateLoadError");
         loader.analyzer = new StockAnalyzer();
         return loader;
      }
      
      public function createStockNewsLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("StockNoticeList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("stockNoticesTemplateLoadError");
         loader.analyzer = new StockNewsAnalyzer();
         return loader;
      }
      
      public function createMinesDropLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("OnlineArmDropItem.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.OnlineArmDropItemError");
         loader.analyzer = new MinesDropAnalyzer(MinesManager.instance.templateDropDataSetup);
         return loader;
      }
      
      public function createMinesLevelLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("OnlineArmLevelInfo.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.OnlineArmLevelInfoError");
         loader.analyzer = new MinesLevelAnalyzer(MinesManager.instance.templateLevelDataSetup);
         return loader;
      }
      
      public function createTeamMemeberLoader() : BaseLoader
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["teamid"] = PlayerManager.Instance.Self.teamID;
         var loader:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("BattleTeamIMLoadServlet.ashx"),6,args);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("team.load.memeberError");
         loader.analyzer = new TeamMemberAnalyze(TeamManager.instance.analyzeMemberList);
         return loader;
      }
      
      public function createTeamShopLoader() : BaseLoader
      {
         var loader:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("BattleTeamShopItemList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("team.load.shopError");
         loader.analyzer = new TeamShopAnalyze(TeamManager.instance.analyzeShopList);
         return loader;
      }
      
      public function createTeamAcviteListLoader() : BaseLoader
      {
         var loader:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("BattleTeamActiveTemplateList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("team.load.activeError");
         loader.analyzer = new TeamActiveAnalyze(TeamManager.instance.analzeActiveList);
         return loader;
      }
      
      public function createTeamBattleSeasonLoader() : BaseLoader
      {
         var loader:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("BattleTeamSeasonList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("teamBattle.load.sessionError");
         loader.analyzer = new TeamBattleSeasonAnalyzer(TeamManager.instance.analyzeSeasonList);
         return loader;
      }
      
      public function createTeamBattleSegmentLoader() : BaseLoader
      {
         var loader:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("BattleTeamSegmentList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("teamBattle.load.segmentError");
         loader.analyzer = new TeamBattleSegmentAnalyzer(TeamManager.instance.analyzeSegmentList);
         return loader;
      }
      
      public function createTheServerTeamRankLoader() : BaseLoader
      {
         var loader:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("CelebByBattleTeamSegmentRank.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("team.load.rankError");
         loader.analyzer = new TeamRankAnalyze(TeamManager.instance.analyzeRankList);
         return loader;
      }
      
      public function createCrossServerTeamRankLoader() : BaseLoader
      {
         var loader:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("AreaCelebByBattleTeamSegmentRank.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("team.load.rankError");
         loader.analyzer = new TeamRankAnalyze(TeamManager.instance.analyzeRankList);
         return loader;
      }
      
      public function createTeamLevelListLoader() : BaseLoader
      {
         var loader:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("BattleTeamLevelList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("team.load.rankError");
         loader.analyzer = new TeamLevelAnalyze(TeamManager.instance.analyzeLevelList);
         return loader;
      }
      
      public function createAngelInvestmentLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("MonthCardGoodInfo.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.AngelInvestmentDataFail");
         loader.analyzer = new AngelInvestmentDataAnalyzer(AngelInvestmentManager.instance.onDataComplete);
         return loader;
      }
      
      public function createMarkChipLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("EngraveDebrisInfo.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("mark.chipTemplateLoadError");
         loader.analyzer = new MarkChipAnalyzer(MarkMgr.inst.setMarkChipTempalte);
         return loader;
      }
      
      public function createMarkSuitLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("EngraveSetElementInfo.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("mark.suitTemplateLoadError");
         loader.analyzer = new MarkSuitAnalyzer(MarkMgr.inst.setMarkSuitTempalte);
         return loader;
      }
      
      public function createMarkSetLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("EngraveSetInfo.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("mark.suitTemplateLoadError");
         loader.analyzer = new MarkSetAnalyzer(MarkMgr.inst.setMarkSetTempalte);
         return loader;
      }
      
      public function createMarkHammerLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("EngraveTemperConfigInfo.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("mark.hammerTemplateLoadError");
         loader.analyzer = new MarkHammerAnalyzer(MarkMgr.inst.setMarkHammerTempalte);
         return loader;
      }
      
      public function createMarkProInfoLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("DebrisPropertyConfig.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("mark.chipTemplateLoadError");
         loader.analyzer = new MarkProAnalyzer(MarkMgr.inst.setMarkProInfo);
         return loader;
      }
      
      public function createMarkTransferLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("EngraveRefineryConfigInfo.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("mark.transferTemplateLoadError");
         loader.analyzer = new MarkTransferAnalyzer(MarkMgr.inst.setMarkTransferTempalte);
         return loader;
      }
      
      public function createDevilTurnGoodsItemLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("DevilTreasItemList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("tank.devilTurn.loadGoodsItemError");
         loader.analyzer = new DevilTurnGoodsItemAnalyzer(DevilTurnManager.instance.loadGoodsItemComplete);
         return loader;
      }
      
      public function createDevilTurnBoxConvertLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("DevilTreasSarahToBoxList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("tank.devilTurn.loadBoxConvertError");
         loader.analyzer = new DevilTurnBoxConvertAnalyzer(DevilTurnManager.instance.loadBoxConvertItemComplete);
         return loader;
      }
      
      public function createDevilTurnPointShopLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("DevilTreasPointsList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("tank.devilTurn.loadPointShopError");
         loader.analyzer = new DevilTurnPointShopAnalyzer(DevilTurnManager.instance.loadPointsShopItemComplete);
         return loader;
      }
      
      public function createDevilTurnRankAewardLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("DevilTreasRankRewardList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("tank.devilTurn.loadRankAewardError");
         loader.analyzer = new DevilTurnRankRewardAnalyzer(DevilTurnManager.instance.loadRankAwardItemComplete);
         return loader;
      }
      
      public function createUnrealRankRewardLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("UnrealRankRewardList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("tank.dreamLand.loadUnrealRankAewardError");
         loader.analyzer = new UnrealRankRewardAnalyzer(DreamlandChallengeManager.instance.loadUnrealRankAwardComplete);
         return loader;
      }
      
      public function createTotemUpGradeTemplateLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("TS_UpgradeTemplate.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadTotem.upGradeFail");
         loader.analyzer = new TotemUpGradeAnalyz(TotemManager.instance.upGradeData);
         return loader;
      }
   }
}
