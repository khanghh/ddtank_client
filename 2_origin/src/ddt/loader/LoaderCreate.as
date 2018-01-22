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
   import dragonBoat.DragonBoatManager;
   import dragonBoat.analyzer.DragonBoatActiveDataAnalyzer;
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
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveSoundSwf(),4);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingAudioIFail");
         return _loc1_;
      }
      
      public function createAudioIILoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveSoundSwf2(),4);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingAudioIIFail");
         return _loc1_;
      }
      
      public function createAudioLiteLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveSoundSwf3(),4);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingAudioIIFail");
         return _loc1_;
      }
      
      public function loadExppression(param1:Function) : void
      {
         var _loc2_:ModuleLoader = LoadResourceManager.Instance.createLoader(PathManager.getExpressionPath(),4);
         _loc2_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingExpressionResourcesFailure");
         LoadResourceManager.Instance.startLoad(_loc2_);
      }
      
      public function creatBallInfoLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("BallList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingBombMetadataFailure");
         _loc1_.analyzer = new BallInfoAnalyzer(BallManager.instance.setup);
         return _loc1_;
      }
      
      public function creatBoxTempInfoLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoadBoxTemp.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingChestsListFailure");
         _loc1_.analyzer = new BoxTempInfoAnalyzer(BossBoxManager.instance.setupBoxTempInfo);
         return _loc1_;
      }
      
      public function creatDungeonInfoLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoadPVEItems.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingCopyMapsInformationFailure");
         _loc1_.analyzer = new DungeonAnalyzer(MapManager.setupDungeonInfo);
         return _loc1_;
      }
      
      public function creatFriendListLoader() : BaseLoader
      {
         var _loc2_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc2_["id"] = PlayerManager.Instance.Self.ID;
         _loc2_["uname"] = PlayerManager.Instance.Account.Account;
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("IMListLoad.ashx"),7,_loc2_);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingBuddyListFailure");
         _loc1_.analyzer = new FriendListAnalyzer(PlayerManager.Instance.setupFriendList);
         return _loc1_;
      }
      
      public function creatMyacademyPlayerListLoader() : BaseLoader
      {
         var _loc2_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc2_["RelationshipID"] = PlayerManager.Instance.Self.masterID;
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("UserApprenticeshipInfoList.ashx"),6,_loc2_);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.data.analyze.MyAcademyPlayersAnalyze");
         _loc1_.analyzer = new MyAcademyPlayersAnalyze(PlayerManager.Instance.setupMyacademyPlayers);
         return _loc1_;
      }
      
      public function creatGoodCategoryLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoadItemsCategory.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingItemTypeFailure");
         _loc1_.analyzer = new GoodCategoryAnalyzer(ItemManager.Instance.setupGoodsCategory);
         return _loc1_;
      }
      
      public function creatItemTempleteLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("TemplateAllList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingGoodsTemplateFailure");
         _loc1_.analyzer = new ItemTempleteAnalyzer(ItemManager.Instance.setupGoodsTemplates);
         return _loc1_;
      }
      
      public function creatItemTempleteReload() : BaseLoader
      {
         _reloadCount = _reloadCount + 1;
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["lv"] = LoaderSavingManager.Version + _reloadCount;
         _loc2_["rnd"] = TextLoader.TextLoaderKey + _reloadCount.toString();
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ShopBox.xml"),2,_loc2_);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingNewGoodsTemplateFailure");
         _loc1_.analyzer = new ItemTempleteAnalyzer(ItemManager.Instance.addGoodsTemplates);
         return _loc1_;
      }
      
      public function creatSuitTempleteLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("SuitTemplateInfoList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingGoodsTemplateFailure");
         _loc1_.analyzer = new SuitTempleteAnalyzer(ItemManager.Instance.setupSuitTemplates);
         return _loc1_;
      }
      
      public function creatEquipSuitTempleteLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("SuitPartEquipInfoList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingGoodsTemplateFailure");
         _loc1_.analyzer = new EquipSuitTempleteAnalyzer(ItemManager.Instance.setupEquipSuitTemplates);
         return _loc1_;
      }
      
      public function creatBadgeInfoLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaBadgeConfig.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingBadgeInfoFailure");
         _loc1_.analyzer = new BadgeInfoAnalyzer(BadgeInfoManager.instance.setup);
         return _loc1_;
      }
      
      public function creatMovingNotificationLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.getMovingNotificationPath(),2);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingAnnouncementFailure");
         _loc1_.analyzer = new MovingNotificationAnalyzer(MovingNotificationManager.Instance.setup);
         return _loc1_;
      }
      
      public function creatDailyInfoLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("DailyAwardList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingLoginFailedRewardInformation");
         _loc1_.analyzer = new DaylyGiveAnalyzer(CalendarManager.getInstance().setDailyInfo);
         return _loc1_;
      }
      
      public function creatMapInfoLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoadMapsItems.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadMapInformationFailure");
         _loc1_.analyzer = new MapAnalyzer(MapManager.setupMapInfo);
         return _loc1_;
      }
      
      public function creatOpenMapInfoLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("MapServerList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingOpenMapListFailure");
         _loc1_.analyzer = new WeekOpenMapAnalyze(MapManager.setupOpenMapInfo);
         return _loc1_;
      }
      
      public function creatQuestTempleteLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("QuestList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingTaskListFailure");
         _loc1_.analyzer = new QuestListAnalyzer(TaskManager.instance.setup);
         return _loc1_;
      }
      
      public function creatQuestTempleteReload() : BaseLoader
      {
         _reloadQuestCount = _reloadQuestCount + 1;
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["lv"] = LoaderSavingManager.Version + _reloadQuestCount;
         _loc2_["rnd"] = TextLoader.TextLoaderKey + _reloadQuestCount.toString();
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("QuestList.xml"),5,_loc2_);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingTaskListFailure");
         _loc1_.analyzer = new QuestListAnalyzer(TaskManager.instance.reloadNewQuest);
         return _loc1_;
      }
      
      public function creatRegisterLoader() : BaseLoader
      {
         var _loc1_:* = getDefinitionByName("register.RegisterState");
         var _loc3_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc3_["Sex"] = _loc1_.SelectedSex;
         _loc3_["NickName"] = _loc1_.Nickname;
         _loc3_["Name"] = PlayerManager.Instance.Account.Account;
         _loc3_["Pass"] = PlayerManager.Instance.Account.Password;
         _loc3_["site"] = "";
         var _loc2_:RequestLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("VisualizeRegister.ashx"),6,_loc3_);
         _loc2_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.FailedToRegister");
         _loc2_.analyzer = new RegisterAnalyzer(null);
         return _loc2_;
      }
      
      public function creatSelectListLoader() : BaseLoader
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["rnd"] = Math.random();
         _loc2_["username"] = PlayerManager.Instance.Account.Account;
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoginSelectList.ashx"),6,_loc2_);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingRoleListFailure");
         _loc1_.analyzer = new LoginSelectListAnalyzer(SelectListManager.Instance.setup);
         return _loc1_;
      }
      
      public function creatServerListLoader() : BaseLoader
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["rnd"] = Math.random();
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ServerList.ashx"),6,_loc2_);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingServerListFailure");
         _loc1_.analyzer = new ServerListAnalyzer(ServerManager.Instance.setup);
         return _loc1_;
      }
      
      public function createCardSetsSortRule() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("CardInfoList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.cardSystem.loadfail.setsSortRule");
         _loc1_.analyzer = new SetsSortRuleAnalyzer(CardManager.Instance.initSetsSortRule);
         return _loc1_;
      }
      
      public function createCardSetsProperties() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("CardBuffList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.cardSystem.loadfail.setsProperties");
         _loc1_.analyzer = new SetsPropertiesAnalyzer(CardManager.Instance.initSetsProperties);
         return _loc1_;
      }
      
      public function creatShopTempleteLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ShopItemList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingStoreItemsFail");
         _loc1_.analyzer = new ShopItemAnalyzer(ShopManager.Instance.setup);
         return _loc1_;
      }
      
      public function creatGoodsAdditionLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ItemStrengthenPlusData.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingGoodsAdditionFail");
         _loc1_.analyzer = new GoodsAdditionAnalyer(GoodsAdditioner.Instance.addGoodsAddition);
         return _loc1_;
      }
      
      public function creatShopSortLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ShopGoodsShowList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.TheClassificationOfGoodsLoadingShopFailure");
         _loc1_.analyzer = new ShopItemSortAnalyzer(ShopManager.Instance.sortShopItems);
         return _loc1_;
      }
      
      public function creatAllQuestionInfoLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoadAllQuestions.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingTestFailure");
         _loc1_.analyzer = new QuestionInfoAnalyze(QuestionInfoMannager.Instance.analyzer);
         return _loc1_;
      }
      
      public function creatUserBoxInfoLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoadUserBox.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingChestsInformationFailure");
         _loc1_.analyzer = new UserBoxInfoAnalyzer(BossBoxManager.instance.setupBoxInfo);
         return _loc1_;
      }
      
      public function creatZhanLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.getZhanPath(),2);
         _loc1_.loadErrorMessage = "LoadingDirtyCharacterSheetsFailure";
         _loc1_.analyzer = new FilterWordAnalyzer(FilterWordManager.setup);
         return _loc1_;
      }
      
      public function createConsortiaLoader() : BaseLoader
      {
         var _loc2_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc2_["id"] = PlayerManager.Instance.Self.ID;
         _loc2_["page"] = 1;
         _loc2_["size"] = 10000;
         _loc2_["order"] = -1;
         _loc2_["consortiaID"] = PlayerManager.Instance.Self.ConsortiaID;
         _loc2_["userID"] = -1;
         _loc2_["state"] = -1;
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaUsersList.ashx"),7,_loc2_);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingGuildMembersListFailure");
         _loc1_.analyzer = new ConsortionMemberAnalyer(ConsortionModelManager.Instance.memberListComplete);
         return _loc1_;
      }
      
      public function createCalendarRequest() : BaseLoader
      {
         return CalendarManager.getInstance().request();
      }
      
      public function getMyConsortiaData() : BaseLoader
      {
         var _loc1_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc1_["page"] = 1;
         _loc1_["size"] = 1;
         _loc1_["name"] = "";
         _loc1_["level"] = -1;
         _loc1_["ConsortiaID"] = PlayerManager.Instance.Self.ConsortiaID;
         _loc1_["order"] = -1;
         _loc1_["openApply"] = -1;
         var _loc2_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaList.ashx"),7,_loc1_);
         _loc2_.loadErrorMessage = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.LoadMyconsortiaInfoError");
         _loc2_.analyzer = new ConsortionListAnalyzer(ConsortionModelManager.Instance.selfConsortionComplete);
         return _loc2_;
      }
      
      public function creatFeedbackInfoLoader() : BaseLoader
      {
         var _loc2_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc2_["userid"] = PlayerManager.Instance.Self.ID;
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("AdvanceQuestionRead.ashx"),6,_loc2_);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingComplainInformationFailure");
         _loc1_.analyzer = new LoadFeedbackReplyAnalyzer(FeedbackManager.instance.setupFeedbackData);
         return _loc1_;
      }
      
      public function creatExpericenceAnalyzeLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LevelList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingAchievementTemplateFormFailure");
         _loc1_.analyzer = new ExpericenceAnalyze(Experience.setup);
         return _loc1_;
      }
      
      public function creatPetExpericenceAnalyzeLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("PetLevelInfo.xml"),2);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingPetExpirenceTemplateFormFailure");
         _loc1_.analyzer = new PetExpericenceAnalyze(PetExperience.setup);
         return _loc1_;
      }
      
      public function creatTexpExpLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ExerciseInfoList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingTexpExpFailure");
         _loc1_.analyzer = new TexpExpAnalyze(TexpManager.Instance.setup);
         return _loc1_;
      }
      
      public function creatRingSystemLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoveLeveList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingRingSystemFailure");
         _loc1_.analyzer = new RingDataAnalyzer(BagAndInfoManager.Instance.loadRingSystemInfo);
         return _loc1_;
      }
      
      public function creatWeaponBallAnalyzeLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("BombConfig.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingWeaponBallListFormFailure");
         _loc1_.analyzer = new WeaponBallInfoAnalyze(WeaponBallManager.setup);
         return _loc1_;
      }
      
      public function creatDailyLeagueAwardLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("DailyLeagueAward.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingDailyLeagueAwardFailure");
         _loc1_.analyzer = new DailyLeagueAwardAnalyzer(DailyLeagueManager.Instance.setup);
         return _loc1_;
      }
      
      public function creatDailyLeagueLevelLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("DailyLeagueLevel.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingDailyLeagueLevelFailure");
         _loc1_.analyzer = new DailyLeagueLevelAnalyzer(DailyLeagueManager.Instance.setup);
         return _loc1_;
      }
      
      public function createWishInfoLader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("GoldEquipTemplateLoad.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingDailyLeagueLevelFailure");
         _loc1_.analyzer = new WishInfoAnalyzer(WishBeadManager.instance.getwishInfo);
         return _loc1_;
      }
      
      public function creatServerConfigLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ServerConfig.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingDailyLeagueLevelFailure");
         _loc1_.analyzer = new ServerConfigAnalyz(ServerConfigManager.instance.getserverConfigInfo);
         return _loc1_;
      }
      
      public function creatPetInfoLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("PetTemplateInfo.xml"),2);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadPetInfoFail");
         _loc1_.analyzer = new PetInfoAnalyzer(PetInfoManager.setup);
         return _loc1_;
      }
      
      public function creatPetSkillLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("Petskillinfo.xml"),2);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadPetSkillFail");
         _loc1_.analyzer = new PetSkillAnalyzer(PetSkillManager.setup);
         return _loc1_;
      }
      
      public function creatFarmPoultryInfo() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("TreeTemplateList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.getPoultryFail");
         _loc1_.analyzer = new FarmTreePoultryListAnalyzer(FarmModelController.instance.getTreePoultryListData);
         return _loc1_;
      }
      
      public function creatFoodComposeLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("FoodComposeList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadFoodComposeListFail");
         _loc1_.analyzer = new FoodComposeListAnalyzer(FarmComposeHouseController.instance().setupFoodComposeList);
         return _loc1_;
      }
      
      public function creatPetConfigLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("PetConfigInfo.xml"),2);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadPetConfigFail");
         _loc1_.analyzer = new PetconfigAnalyzer(null);
         return _loc1_;
      }
      
      public function creatPetSkillTemplateInfoLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("PetSkillTemplateInfo.xml"),2);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadPetAllSkillFail");
         _loc1_.analyzer = new PetAllSkillAnalyzer(PetAllSkillManager.setup);
         return _loc1_;
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
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["rnd"] = Math.random();
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ShopCheapItemList.ashx"),6,_loc2_);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.ShopDisCountRealTimesFailure");
         _loc1_.analyzer = new ShopItemDisCountAnalyzer(ShopManager.Instance.updateRealTimesItemsByDisCount);
         return _loc1_;
      }
      
      public function creatVoteSubmit() : BaseLoader
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["userId"] = PlayerManager.Instance.Self.ID;
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("VoteSubmit.ashx"),6,_loc2_);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.vip.loadVip.error");
         _loc1_.analyzer = new VoteSubmitAnalyzer(loadVoteXml);
         return _loc1_;
      }
      
      public function createStoreEquipConfigLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoadStrengthExp.xml"),2);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadStoreEquipExperienceAllFail");
         _loc1_.analyzer = new StoreEquipExpericenceAnalyze(StoreEquipExperience.setup);
         return _loc1_;
      }
      
      public function creatCardGrooveLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("CardGrooveUpdateList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadCardGrooveFail");
         _loc1_.analyzer = new CardGrooveEventAnalyzer(GrooveInfoManager.instance.setup);
         return _loc1_;
      }
      
      public function creatCardTemplateLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("CardTemplateInfo.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadCardTemplateInfoFail");
         _loc1_.analyzer = new CardTemplateAnalyzer(CardTemplateInfoManager.instance.setup);
         return _loc1_;
      }
      
      public function creatItemStrengthenGoodsInfoLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ItemStrengthenGoodsInfo.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadItemStrengthenGoodsInfoListFail");
         _loc1_.analyzer = new ItemStrengthenGoodsInfoAnalyzer(ItemStrengthenGoodsInfoManager.setup);
         return _loc1_;
      }
      
      public function createBeadTemplateLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("RuneTemplateList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadBeadInfoFail");
         _loc1_.analyzer = new BeadAnalyzer(BeadTemplateManager.Instance.setup);
         return _loc1_;
      }
      
      public function createBeadAdvanceTemplateLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("RuneAdvanceTemplateList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadBeadAdvanceInfoFail");
         _loc1_.analyzer = new AdvanceBeadAnalyzer(BeadTemplateManager.Instance.setupAdvanceBead);
         return _loc1_;
      }
      
      public function creatHallIcon() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ButtonConfig.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadHallIconFail");
         _loc1_.analyzer = new HallIconDataAnalyz(MainButtonManager.instance.gethallIconInfo);
         return _loc1_;
      }
      
      public function createTotemTemplateLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("TotemInfo.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadTotemInfoFail");
         _loc1_.analyzer = new TotemDataAnalyz(TotemManager.instance.setup);
         return _loc1_;
      }
      
      public function createHonorUpTemplateLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("TotemHonorTemplate.xml"),2);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadHonorUpInfoFail");
         _loc1_.analyzer = new HonorUpDataAnalyz(HonorUpManager.instance.setup);
         return _loc1_;
      }
      
      public function createRankingListAwardLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("RankingListAwardList.xml"),5);
         _loc1_.loadErrorMessage = "RankingListAwardList";
         _loc1_.analyzer = new RankingListAwardAnalyzer(RankManager.instance.activityAwardComp);
         return _loc1_;
      }
      
      public function createConsortiaBossTemplateLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaBossConfigLoad.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadConsortiaBossInfoFail");
         _loc1_.analyzer = new ConsortiaBossDataAnalyzer(ConsortionModelManager.Instance.bossConfigDataSetup);
         return _loc1_;
      }
      
      public function creatActiveLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("EveryDayActivePointTemplateInfoList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadEveryDayActFail");
         _loc1_.analyzer = new ActivityAnalyzer(DayActivityManager.Instance.everyDayActive);
         return _loc1_;
      }
      
      public function creatActivePointLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("EveryDayActiveProgressInfoList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.actInfoFail");
         _loc1_.analyzer = new ActivePointAnalzer(DayActivityManager.Instance.everyDayActivePoint);
         return _loc1_;
      }
      
      public function creatRewardLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("EveryDayActiveRewardTemplateInfoList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("Indiana.loader.error");
         _loc1_.analyzer = new ActivityRewardAnalyzer(DayActivityManager.Instance.activityRewardComp);
         return _loc1_;
      }
      
      public function creatOneYuanBuyGoodsLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("OneYuanBuyAllGoodsTemplate.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("Indiana.loaderAll.error");
         _loc1_.analyzer = new IndianaGoodsItemAnalyzer(IndianaDataManager.instance.goodsItemAnalyzer);
         return _loc1_;
      }
      
      public function creatOneYuanBuySaleItemLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("OneYuanBuyOnSaleGoodsTemplate.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("Indiana.loaderSale.error");
         _loc1_.analyzer = new IndianaShopItemsAnalyzer(IndianaDataManager.instance.shopItemAnalyzer);
         return _loc1_;
      }
      
      public function loaderSearchGoodsTemp() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("SearchGoodsTemp.xml"),2);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.starUpdataInfoFail");
         _loc1_.analyzer = new UpdateStarAnalyer(BuriedManager.Instance.SearchGoodsTempHander);
         return _loc1_;
      }
      
      public function loaderSearchGoodsPayMoney() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("SearchGoodsPayMoney.xml"),2);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.starUpDataCountInfoFail");
         _loc1_.analyzer = new SearchGoodsPayAnalyer(BuriedManager.Instance.searchGoodsPayHander);
         return _loc1_;
      }
      
      public function creatWondActiveLoader() : BaseLoader
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["rnd"] = TextLoader.TextLoaderKey + new Date().time;
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoadChargeActiveTemplate.xml"),5,_loc2_);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.wondActInfoFail");
         _loc1_.analyzer = new WonderfulActAnalyer(WonderfulActivityManager.Instance.wonderfulActiveType);
         return _loc1_;
      }
      
      public function firstRechargeLoader() : BaseLoader
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["rnd"] = TextLoader.TextLoaderKey + new Date().time;
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ChargeSpendRewardTemplateInfoList.xml"),5,_loc2_);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.firstRechargeInfoFail");
         _loc1_.analyzer = new RechargeAnalyer(FirstRechargeManger.Instance.completeHander);
         return _loc1_;
      }
      
      public function accumulativeLoginLoader() : BaseLoader
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["rnd"] = TextLoader.TextLoaderKey + new Date().time;
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoginAwardItemTemplate.xml"),5,_loc2_);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.accumulativeLoginInfoFail");
         _loc1_.analyzer = new AccumulativeLoginAnalyer(AccumulativeManager.instance.loadTempleteDataComplete);
         return _loc1_;
      }
      
      public function createCommunalActiveLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("CommunalActive.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.dragonBoatActiveInfoFail");
         _loc1_.analyzer = new DragonBoatActiveDataAnalyzer(DragonBoatManager.instance.templateDataSetup);
         return _loc1_;
      }
      
      public function createCaddyAwardsLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LotteryShowTemplate.xml"),5);
         _loc1_.analyzer = new CaddyAwardDataAnalyzer(CaddyAwardModel.getInstance().setUp);
         return _loc1_;
      }
      
      public function createNewFusionDataLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("FusionInfoLoad.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.newFusionDataInfoFail");
         _loc1_.analyzer = new FusionNewDataAnalyzer(FusionNewManager.instance.setup);
         return _loc1_;
      }
      
      public function createEnergyDataLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("MissionEnergyPrice.xml"),2);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.energyInfoFail");
         _loc1_.analyzer = new EnergyDataAnalyzer(PlayerManager.Instance.setupEnergyData);
         return _loc1_;
      }
      
      public function createGroupPurchaseAwardInfoLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("TeamBuyActiveAwardInfo.ashx"),6);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.groupPurchaseDataInfoFail");
         _loc1_.analyzer = new GroupPurchaseAwardAnalyzer(GroupPurchaseManager.instance.awardAnalyComplete);
         return _loc1_;
      }
      
      private function loadVoteXml(param1:VoteSubmitAnalyzer) : void
      {
         var _loc2_:* = null;
         if(param1.result == "vote.xml")
         {
            _loc2_ = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("vote.xml"),2);
            _loc2_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.view.vote.loadXMLError");
            _loc2_.analyzer = new VoteInfoAnalyzer(VoteManager.Instance.loadCompleted);
            LoadResourceManager.Instance.startLoad(_loc2_);
         }
      }
      
      public function loadWonderfulActivityXml() : BaseLoader
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["rnd"] = TextLoader.TextLoaderKey + new Date().time;
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("GmActivityInfo.xml"),5,_loc2_);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.wonderfulActiveInfoFail");
         _loc1_.analyzer = new WonderfulGMActAnalyer(WonderfulActivityManager.Instance.wonderfulGMActiveInfo);
         return _loc1_;
      }
      
      public function loadLanternRiddlesXml() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LightRiddleQuest.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.lanternRiddlesInfoFail");
         _loc1_.analyzer = new LanternDataAnalyzer(LanternRiddlesManager.instance.questionInfo);
         return _loc1_;
      }
      
      public function createAvatarCollectionUnitDataLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ClothPropertyTemplateInfo.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.AvatarCollectionUnitDataFail");
         _loc1_.analyzer = new AvatarCollectionUnitDataAnalyzer(AvatarCollectionManager.instance.unitListDataSetup);
         return _loc1_;
      }
      
      public function createAvatarCollectionItemDataLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ClothGroupTemplateInfo.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.AvatarCollectionItemDataFail");
         _loc1_.analyzer = new AvatarCollectionItemDataAnalyzer(AvatarCollectionManager.instance.itemListDataSetup);
         return _loc1_;
      }
      
      public function createSanXiaoStoreDataLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("MiniGameShopTemplate.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.SXStoreDataFail");
         _loc1_.analyzer = new SanXiaoStoreItemAnalyzer(SanXiaoManager.getInstance().onSXStoreItemData);
         return _loc1_;
      }
      
      public function createSanXiaoScoreRewardDataLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ThreeCleanPointAward.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.SXScoreRewardDataFail");
         _loc1_.analyzer = new SanXiaoScoreRewardAnalyzer(SanXiaoManager.getInstance().onSXScoreRewardData);
         return _loc1_;
      }
      
      public function createPetCellUnlockPriceLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("PetCellUnlockPrice.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.PetsCellUnlockFail");
         _loc1_.analyzer = new PetsCellUnlocakPriceAnalyzer(PetsBagManager.instance().onPetCellUnlockPrice);
         return _loc1_;
      }
      
      public function createPetsRisingStarDataLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoadPetStarExp.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.PetsAdvancedDataFail");
         _loc1_.analyzer = new PetsRisingStarDataAnalyzer(PetsAdvancedManager.Instance.risingStarDataComplete);
         return _loc1_;
      }
      
      public function createPetsEvolutionDataLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoadPetFightProperty.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.PetsAdvancedDataFail");
         _loc1_.analyzer = new PetsEvolutionDataAnalyzer(PetsAdvancedManager.Instance.evolutionDataComplete);
         return _loc1_;
      }
      
      public function getPetsFormDataLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoadPetFormData.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.PetsFormDataFail");
         _loc1_.analyzer = new PetsFormDataAnalyzer(PetsAdvancedManager.Instance.formDataComplete);
         return _loc1_;
      }
      
      public function loadMagicStoneTemplate() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("MagicStoneTemplate.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.magicStoneTempFail");
         _loc1_.analyzer = new MagicStoneTempAnalyer(MagicStoneManager.instance.loadMgStoneTempComplete);
         return _loc1_;
      }
      
      public function createHorseTemplateDataLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("MountTemplate.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.horseTemplateDataFail");
         _loc1_.analyzer = new HorseTemplateDataAnalyzer(HorseManager.instance.horseTemplateDataSetup);
         return _loc1_;
      }
      
      public function createHorseSkillGetDataLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("MountSkillGetTemplate.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.horseSkillGetDataFail");
         _loc1_.analyzer = new HorseSkillGetDataAnalyzer(HorseManager.instance.horseSkillGetDataSetup);
         return _loc1_;
      }
      
      public function createHorseSkillDataLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("MountSkillTemplate.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.horseSkillDataFail");
         _loc1_.analyzer = new HorseSkillDataAnalyzer(HorseManager.instance.horseSkillDataSetup);
         return _loc1_;
      }
      
      public function createHorseSkillElementDataLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("MountSkillElementTemplate.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.horseSkillElementDataFail");
         _loc1_.analyzer = new HorseSkillElementDataAnalyzer(HorseManager.instance.horseSkillElementDataSetup);
         return _loc1_;
      }
      
      public function createCollectionRebortDataLoader() : BaseLoader
      {
         var _loc2_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc2_["id"] = PlayerManager.Instance.Self.ID;
         _loc2_["uname"] = PlayerManager.Instance.Account.Account;
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("SceneCollecRandomNpc.ashx"),7,_loc2_);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.collectionRobertDataFail");
         _loc1_.analyzer = new CollectionTaskAnalyzer(CollectionTaskManager.Instance.robertDataSetup);
         return _loc1_;
      }
      
      public function createHorsePicCherishDataLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("MountDrawTemplate.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.horsePicCherishDataFail");
         _loc1_.analyzer = new HorsePicCherishAnalyzer(HorseManager.instance.horsePicCherishDataSetup);
         return _loc1_;
      }
      
      public function createNewTitleDataLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("NewTitleInfo.xml"),2);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.newTitleDataFail");
         _loc1_.analyzer = new NewTitleDataAnalyz(NewTitleManager.instance.newTitleDataSetup);
         return _loc1_;
      }
      
      public function createRescueRewardLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("HelpGameReward.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.rescueRewardFail");
         _loc1_.analyzer = new RescueRewardAnalyzer(RescueManager.instance.setupRewardList);
         return _loc1_;
      }
      
      public function createEnchantMagicInfoLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("MagicItemTemp.xml"),2);
         _loc1_.analyzer = new EnchantInfoAnalyzer(EnchantManager.instance.setupInfoList);
         return _loc1_;
      }
      
      public function createFineSuitInfoLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("SetsBuildTemp.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadSuitInfoFail");
         _loc1_.analyzer = new FineSuitAnalyze(FineSuitManager.Instance.setup);
         return _loc1_;
      }
      
      public function creatRouletteTempleteLoader(param1:Function) : BaseLoader
      {
         var _loc2_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("User_LotteryRank.xml"),5);
         _loc2_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingGoodsTemplateFailure");
         _loc2_.analyzer = new InventoryItemAnalyzer(param1);
         return _loc2_;
      }
      
      public function creatPyramidLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("PyramidActivityItem.xml"),5);
         _loc1_.analyzer = new PyramidAnalyze(PyramidManager.instance.templateDataSetup);
         return _loc1_;
      }
      
      public function creatConsortiaWeekRewardLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaWeekReward.xml"),5);
         _loc1_.analyzer = new ConsortiaWeekRewardAnalyze(ConsortionModelManager.Instance.analyzeWeekReward);
         return _loc1_;
      }
      
      public function creatConsortiaRichRankLoader() : BaseLoader
      {
         var _loc2_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc2_["consortiaID"] = PlayerManager.Instance.Self.ConsortiaID;
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaRichRankList.ashx"),6,_loc2_);
         _loc1_.analyzer = new ConsortiaRichRankAnalyze(ConsortionModelManager.Instance.analyzeRichRank);
         return _loc1_;
      }
      
      public function creatMemoryGameAwardLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("PairUpPointAward.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("memoryGame.loaderError");
         _loc1_.analyzer = new MemoryGameAnalyzer(MemoryGameManager.instance.analyzer);
         return _loc1_;
      }
      
      public function lodaPetAtlasTemplate() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("PetCollectPropertyTemplate.xml"),5);
         _loc1_.analyzer = new PetAtlasAnalyzer(PetsBagManager.instance().petAtlasAnalyzer);
         return _loc1_;
      }
      
      public function creatGuardCoreLevelTemplate() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("GuardCoreLevelTemplate.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("guardCore.GuardCoreLevelTemplate.error");
         _loc1_.analyzer = new GuardCoreLevelAnayzer(GuardCoreManager.instance.analyzerLevel);
         return _loc1_;
      }
      
      public function creatGuardCoreTemplate() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("GuardCoreTemplate.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("guardCore.GuardCoreTemplate.error");
         _loc1_.analyzer = new GuardCoreAnalyzer(GuardCoreManager.instance.analyzer);
         return _loc1_;
      }
      
      public function creatGodCardListTemplate() : BaseLoader
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["rnd"] = Math.random();
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("GodCardList.xml"),5,_loc2_);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.godCardListTemplate.error");
         _loc1_.analyzer = new GodCardListAnalyzer(GodCardRaiseManager.Instance.loadGodCardListTemplate);
         return _loc1_;
      }
      
      public function creatGodCardListGroup() : BaseLoader
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["rnd"] = Math.random();
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("GodCardListGroup.ashx"),7,_loc2_);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.godCardListGroup.error");
         _loc1_.analyzer = new GodCardListGroupAnalyzer(GodCardRaiseManager.Instance.loadGodCardListGroup);
         return _loc1_;
      }
      
      public function creatGodCardPointRewardList() : BaseLoader
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["rnd"] = Math.random();
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("GodCardPointRewardList.ashx"),7,_loc2_);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.godCardPointRewardList.error");
         _loc1_.analyzer = new GodCardPointRewardListAnalyzer(GodCardRaiseManager.Instance.loadGodCardPointRewardList);
         return _loc1_;
      }
      
      public function createBattleSkillTemplate() : BaseLoader
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["rnd"] = Math.random();
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("FairBattleSkillGetTemplate.xml"),5,_loc2_);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.battleSkillSkillTemplate.error");
         _loc1_.analyzer = new BattleSkillSkillTemplateAnalyzer(BattleSkillManager.instance.loadSkillTemplateList);
         return _loc1_;
      }
      
      public function createBattleSkillUpdateTemplate() : BaseLoader
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["rnd"] = Math.random();
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("FairBattleSkillMaterialTemplate.xml"),5,_loc2_);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.battleSkillSkillUpdateTemplate.error");
         _loc1_.analyzer = new BattleSKillUpdateTemplateAnalyzer(BattleSkillManager.instance.loadSkillUpdateTemplateList);
         return _loc1_;
      }
      
      public function createBraveDoorDuplicateTemplate() : BaseLoader
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["rnd"] = Math.random();
         var _loc1_:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.getBraveDoorDuplicateTemplete("braveDoorDuplicate"),2);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("game.braveDoor.duplicateTempLoadError");
         _loc1_.analyzer = new BraveDoorDuplicateAnalyzer(BraveDoorManager.instance.setupDuplicateTemplate);
         LoadResourceManager.Instance.startLoad(_loc1_);
         return _loc1_;
      }
      
      public function createCardAchievementTemplate() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("CardAchievement.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("tank.card.achievementLoaderError");
         _loc1_.analyzer = new CardAchievementAnalyze(CardManager.Instance.initCardAchievement);
         return _loc1_;
      }
      
      public function createDDTKingGradeTemplate() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("MaxLevelTemplate.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddtKingGrade.breakFailLoaderError");
         _loc1_.analyzer = new DDTKingGradeAnalyzer(DDTKingGradeManager.Instance.analyzer);
         return _loc1_;
      }
      
      public function createBombFixedMapData() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("SpaRoomFixedBomb.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.bombgame.mapdata.FailLoaderError");
         _loc1_.analyzer = new BombGameFixedMapAnalyzer(HappyLittleGameManager.instance.bombManager.FixedAnalyzer);
         return _loc1_;
      }
      
      public function createEvolutionData() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("SubWeaponEvolutionTemplate.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("store.view.evolution.FailLoaderError");
         _loc1_.analyzer = new EvolutionDataAnalyzer(FineEvolutionManager.Instance.EvolutionAnalyzer);
         return _loc1_;
      }
      
      public function createHorseAmuletTemplate() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("MountTalismansInfoList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("tank.horseAmulet.loaderTemplateFiale");
         _loc1_.analyzer = new HorseAmuletDataAnalyzer(HorseAmuletManager.instance.analyzer);
         return _loc1_;
      }
      
      public function createBombRandomMapData() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("SpaRoomRandomBomb.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.bombgame.mapdata.FailLoaderError");
         _loc1_.analyzer = new BombGameRandomMapAnalyzer(HappyLittleGameManager.instance.bombManager.RandomAnalyzer);
         return _loc1_;
      }
      
      public function createEquipAmuletGradeTemplate() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("AmuletGradeItemList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("tank.equipAmulet.loadGradeTemplateError");
         _loc1_.analyzer = new EquipAmuletActivateGradeDataAnalyzer(EquipAmuletManager.Instance.analyzerActivateGrade);
         return _loc1_;
      }
      
      public function createEquipAmuletPhaseTemplate() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("AmuletPhaseItemList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("tank.equipAmulet.loadPhaseTemplateError");
         _loc1_.analyzer = new EquipAmuletPhaseDataAnalyzer(EquipAmuletManager.Instance.analyzerPhase);
         return _loc1_;
      }
      
      public function createEquipAmuletTemplate() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("AmuletInfoItemList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("tank.equipAmulet.loadTemplateError");
         _loc1_.analyzer = new EquipAmuletDataAnalyzer(EquipAmuletManager.Instance.analyzer);
         return _loc1_;
      }
      
      public function createDDTKingWayTemplate() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("KingOfRoadQuestInfoList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.DDTKingWayDataFail");
         _loc1_.analyzer = new DDTKingWayDataAnalyzer(DDTKingWayManager.instance.analyzer);
         return _loc1_;
      }
      
      public function createManaualDebrisData() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("JampsDebrisItemList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("explorerManual.manualTempleteData.loadFail") + "_碎片";
         _loc1_.analyzer = new ManualDebrisAnalyzer(ExplorerManualManager.instance.initDebrisData);
         return _loc1_;
      }
      
      public function createChapterItemData() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("JampsChapterItemList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("explorerManual.manualTempleteData.loadFail") + "_章节";
         _loc1_.analyzer = new ChapterItemAnalyzer(ExplorerManualManager.instance.initChapterData);
         return _loc1_;
      }
      
      public function createManualItemData() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("JampsManualItemList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("explorerManual.manualTempleteData.loadFail") + "_手册项";
         _loc1_.analyzer = new ManualItemAnalyzer(ExplorerManualManager.instance.initManualItemData);
         return _loc1_;
      }
      
      public function createManualUpgradeData() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("JampsUpgradeItemList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("explorerManual.manualTempleteData.loadFail") + "_升级";
         _loc1_.analyzer = new ManualUpgradeAnalyzer(ExplorerManualManager.instance.initManualUpgradeData);
         return _loc1_;
      }
      
      public function createPageItemData() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("JampsPageItemList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("explorerManual.manualTempleteData.loadFail") + "_页";
         _loc1_.analyzer = new ManualPageItemAnalyzer(ExplorerManualManager.instance.initPageItemData);
         return _loc1_;
      }
      
      public function CreateMiniGameRankRewardCfgLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("SpaGameWeekAwardInfoList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.miniGameRankFail");
         _loc1_.analyzer = new HappyLittleGameRankAnalyzer(HappyLittleGameManager.instance.onAnalyzeRankRewardCfg);
         return _loc1_;
      }
      
      public function createCityOccupationSystemsLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("CityOccupationSystems.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.activitySystemItemsInfoFail");
         _loc1_.analyzer = new CityBattleAnalyze(CityBattleManager.instance.CityBattleSystemsHandler);
         return _loc1_;
      }
      
      public function __onLoadError(param1:LoaderResourceEvent) : void
      {
         var _loc3_:BaseLoader = param1.data as BaseLoader;
         if(_loc3_.type != 2 && _loc3_.type != 5 && _loc3_.type != 6 && _loc3_.type != 7)
         {
            return;
         }
         var _loc4_:String = _loc3_.loadErrorMessage;
         if(_loc3_.analyzer)
         {
            if(_loc3_.analyzer.message != null)
            {
               _loc4_ = _loc3_.loadErrorMessage + "\n" + _loc3_.analyzer.message;
            }
         }
         if(_loc4_ == null || _loc4_ == "" || _loc4_ == "null")
         {
            _loc4_ = PathManager.getLoaderFileName(_loc3_.url);
         }
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("alert"),_loc4_,LanguageMgr.GetTranslation("tank.room.RoomIIView2.affirm"));
         _loc2_.addEventListener("response",__onAlertResponse);
      }
      
      public function createLoadPetMoePropertyLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoadPetMoeProperty.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.rescueRewardFail");
         _loc1_.analyzer = new PetMoePropertyAnalyzer(PetsAdvancedManager.Instance.moePropertyComplete);
         return _loc1_;
      }
      
      private function __onAlertResponse(param1:FrameEvent) : void
      {
         param1.currentTarget.removeEventListener("response",__onAlertResponse);
         ObjectUtils.disposeObject(param1.currentTarget);
         LeavePageManager.leaveToLoginPath();
      }
      
      public function createActivitySystemItemsLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("ActivitySystemItems.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.activitySystemItemsInfoFail");
         _loc1_.analyzer = new ActivitySystemItemsDataAnalyzer(activitySystemItemsDataHandler);
         return _loc1_;
      }
      
      private function activitySystemItemsDataHandler(param1:DataAnalyzer) : void
      {
         var _loc2_:* = null;
         if(param1 is ActivitySystemItemsDataAnalyzer)
         {
            _loc2_ = param1 as ActivitySystemItemsDataAnalyzer;
            PyramidManager.instance.templateDataSetup(_loc2_.pyramidSystemDataList);
            GuildMemberWeekManager.instance.templateDataSetup(_loc2_.guildMemberWeekDataList);
            GrowthPackageManager.instance.templateDataSetup(_loc2_.growthPackageDataList);
            ChickActivationManager.instance.templateDataSetup(_loc2_.chickActivationDataList);
            WitchBlessingManager.Instance.templateDataSetup(_loc2_.witchBlessingDataList);
            NewYearRiceManager.instance.templateDataSetup(_loc2_.newYearRiceDataList);
            HorseRaceManager.Instance.templateDataSetup(_loc2_.horseRaceDataList);
            CloudBuyLotteryManager.Instance.templateDataSetup(_loc2_.happyBuyBbyBuyDataList);
            RedEnvelopeManager.instance.templateDataSetup(_loc2_.redEnvelopeDataList);
            LoginDeviceManager.instance().templateDataSetup(_loc2_.loginDeviceDataList);
            SignBuffManager.instance.templateDataSetup(_loc2_.signBuffDataList);
            CallBackFundManager.instance.templateDataSetup(_loc2_.callbackDataList);
            LotteryManager.instance.templateDataSetup(_loc2_.lotteryDataList);
            DefendislandManager.instance.templateDataSetup(_loc2_.defendislandDataList);
         }
      }
      
      public function createMagicBoxDataLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("MagicFusionData.xml"),5);
         _loc1_.analyzer = new MagicBoxDataAnalyzer(MagicHouseManager.instance.setupMagicBoxData);
         return _loc1_;
      }
      
      public function creatGodSyahLoader(param1:int = 7) : BaseLoader
      {
         if(param1 != 7)
         {
            return null;
         }
         var _loc3_:URLVariables = new URLVariables();
         _loc3_["rnd"] = TextLoader.TextLoaderKey + Math.random().toString();
         var _loc2_:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("SubActiveList.ashx"),6,_loc3_);
         _loc2_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingGodSyahFailure");
         _loc2_.analyzer = new SyahAnalyzer(SyahManager.Instance.godSyahLoaderCompleted);
         return _loc2_;
      }
      
      public function createGodsRoadsLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("ActivityQuestList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.godsRoads.cuowu");
         _loc1_.analyzer = new GodsRoadsDataAnalyzer(GodsRoadsManager.instance.templateDataSetup);
         return _loc1_;
      }
      
      public function creatSuperWinnerLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("DiceGameAwardItem.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.superWinner.loadAwardsError");
         _loc1_.analyzer = new SuperWinnerAnalyze(SuperWinnerManager.instance.awardsLoadCompleted);
         return _loc1_;
      }
      
      public function createSevenDayTargetLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("ActivityQuestList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.sevenDayTargetInfoFail");
         _loc1_.analyzer = new SevenDayTargetDataAnalyzer(SevenDayTargetManager.Instance.templateDataSetup);
         return _loc1_;
      }
      
      public function createCampBattleAwardGoodsLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("CampWarItems.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.activitySystemItemsInfoFail");
         _loc1_.analyzer = new CampBattleAwardsDataAnalyzer(CampBattleManager.instance.templateDataSetup);
         return _loc1_;
      }
      
      public function creatParticlesLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.getParticlesPath(),2);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingParticlesError");
         _loc1_.analyzer = new EmitterInfoAnalyzer(ParticleManager.Instance.loadConfig);
         return _loc1_;
      }
      
      public function createBankLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("BankTemplateInfo.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.BankInvestmentDataFail");
         _loc1_.analyzer = new BankInvestmentDataAnalyzer(BankManager.instance.onDataComplete);
         return _loc1_;
      }
      
      public function createEquipGhostLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("SpiritInfoList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.activitySystemItemsInfoFail");
         _loc1_.analyzer = new GhostDataAnalyzer(EquipGhostManager.getInstance().analyzerCompleteHandler);
         return _loc1_;
      }
      
      public function createStockLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("StockTemplateInfo.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("stockTemplateLoadError");
         _loc1_.analyzer = new StockAnalyzer();
         return _loc1_;
      }
      
      public function createStockNewsLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("StockNoticeList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("stockNoticesTemplateLoadError");
         _loc1_.analyzer = new StockNewsAnalyzer();
         return _loc1_;
      }
      
      public function createMinesDropLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("OnlineArmDropItem.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.OnlineArmDropItemError");
         _loc1_.analyzer = new MinesDropAnalyzer(MinesManager.instance.templateDropDataSetup);
         return _loc1_;
      }
      
      public function createMinesLevelLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("OnlineArmLevelInfo.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.OnlineArmLevelInfoError");
         _loc1_.analyzer = new MinesLevelAnalyzer(MinesManager.instance.templateLevelDataSetup);
         return _loc1_;
      }
      
      public function createTeamMemeberLoader() : BaseLoader
      {
         var _loc2_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc2_["teamid"] = PlayerManager.Instance.Self.teamID;
         var _loc1_:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("BattleTeamIMLoadServlet.ashx"),6,_loc2_);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("team.load.memeberError");
         _loc1_.analyzer = new TeamMemberAnalyze(TeamManager.instance.analyzeMemberList);
         return _loc1_;
      }
      
      public function createTeamShopLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("BattleTeamShopItemList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("team.load.shopError");
         _loc1_.analyzer = new TeamShopAnalyze(TeamManager.instance.analyzeShopList);
         return _loc1_;
      }
      
      public function createTeamAcviteListLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("BattleTeamActiveTemplateList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("team.load.activeError");
         _loc1_.analyzer = new TeamActiveAnalyze(TeamManager.instance.analzeActiveList);
         return _loc1_;
      }
      
      public function createTeamBattleSeasonLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("BattleTeamSeasonList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("teamBattle.load.sessionError");
         _loc1_.analyzer = new TeamBattleSeasonAnalyzer(TeamManager.instance.analyzeSeasonList);
         return _loc1_;
      }
      
      public function createTeamBattleSegmentLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("BattleTeamSegmentList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("teamBattle.load.segmentError");
         _loc1_.analyzer = new TeamBattleSegmentAnalyzer(TeamManager.instance.analyzeSegmentList);
         return _loc1_;
      }
      
      public function createTheServerTeamRankLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("CelebByBattleTeamSegmentRank.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("team.load.rankError");
         _loc1_.analyzer = new TeamRankAnalyze(TeamManager.instance.analyzeRankList);
         return _loc1_;
      }
      
      public function createCrossServerTeamRankLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("AreaCelebByBattleTeamSegmentRank.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("team.load.rankError");
         _loc1_.analyzer = new TeamRankAnalyze(TeamManager.instance.analyzeRankList);
         return _loc1_;
      }
      
      public function createTeamLevelListLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("BattleTeamLevelList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("team.load.rankError");
         _loc1_.analyzer = new TeamLevelAnalyze(TeamManager.instance.analyzeLevelList);
         return _loc1_;
      }
      
      public function createAngelInvestmentLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("MonthCardGoodInfo.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.AngelInvestmentDataFail");
         _loc1_.analyzer = new AngelInvestmentDataAnalyzer(AngelInvestmentManager.instance.onDataComplete);
         return _loc1_;
      }
      
      public function createMarkChipLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("EngraveDebrisInfo.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("mark.chipTemplateLoadError");
         _loc1_.analyzer = new MarkChipAnalyzer(MarkMgr.inst.setMarkChipTempalte);
         return _loc1_;
      }
      
      public function createMarkSuitLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("EngraveSetElementInfo.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("mark.suitTemplateLoadError");
         _loc1_.analyzer = new MarkSuitAnalyzer(MarkMgr.inst.setMarkSuitTempalte);
         return _loc1_;
      }
      
      public function createMarkSetLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("EngraveSetInfo.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("mark.suitTemplateLoadError");
         _loc1_.analyzer = new MarkSetAnalyzer(MarkMgr.inst.setMarkSetTempalte);
         return _loc1_;
      }
      
      public function createMarkHammerLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("EngraveTemperConfigInfo.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("mark.hammerTemplateLoadError");
         _loc1_.analyzer = new MarkHammerAnalyzer(MarkMgr.inst.setMarkHammerTempalte);
         return _loc1_;
      }
      
      public function createMarkProInfoLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("DebrisPropertyConfig.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("mark.chipTemplateLoadError");
         _loc1_.analyzer = new MarkProAnalyzer(MarkMgr.inst.setMarkProInfo);
         return _loc1_;
      }
      
      public function createMarkTransferLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("EngraveRefineryConfigInfo.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("mark.transferTemplateLoadError");
         _loc1_.analyzer = new MarkTransferAnalyzer(MarkMgr.inst.setMarkTransferTempalte);
         return _loc1_;
      }
   }
}
