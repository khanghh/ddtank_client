package ddt.loader{   import AvatarCollection.AvatarCollectionManager;   import AvatarCollection.data.AvatarCollectionItemDataAnalyzer;   import AvatarCollection.data.AvatarCollectionUnitDataAnalyzer;   import BraveDoor.BraveDoorManager;   import GodSyah.SyahAnalyzer;   import GodSyah.SyahManager;   import Indiana.IndianaDataManager;   import Indiana.analyzer.IndianaGoodsItemAnalyzer;   import Indiana.analyzer.IndianaShopItemsAnalyzer;   import accumulativeLogin.AccumulativeLoginAnalyer;   import accumulativeLogin.AccumulativeManager;   import angelInvestment.AngelInvestmentManager;   import angelInvestment.data.AngelInvestmentDataAnalyzer;   import bagAndInfo.BagAndInfoManager;   import bagAndInfo.amulet.EquipAmuletActivateGradeDataAnalyzer;   import bagAndInfo.amulet.EquipAmuletDataAnalyzer;   import bagAndInfo.amulet.EquipAmuletManager;   import bagAndInfo.amulet.EquipAmuletPhaseDataAnalyzer;   import bagAndInfo.bag.ring.data.RingDataAnalyzer;   import bagAndInfo.ddtKingGrade.DDTKingGradeAnalyzer;   import bagAndInfo.ddtKingGrade.DDTKingGradeManager;   import bagAndInfo.energyData.EnergyDataAnalyzer;   import bank.BankManager;   import bank.analyzer.BankInvestmentDataAnalyzer;   import battleSkill.BattleSkillManager;   import battleSkill.analyzer.BattleSKillUpdateTemplateAnalyzer;   import battleSkill.analyzer.BattleSkillSkillTemplateAnalyzer;   import calendar.CalendarManager;   import campbattle.CampBattleManager;   import campbattle.data.CampBattleAwardsDataAnalyzer;   import cardSystem.CardManager;   import cardSystem.CardTemplateInfoManager;   import cardSystem.GrooveInfoManager;   import cardSystem.analyze.CardAchievementAnalyze;   import cardSystem.analyze.CardTemplateAnalyzer;   import cardSystem.analyze.SetsPropertiesAnalyzer;   import cardSystem.analyze.SetsSortRuleAnalyzer;   import chickActivation.ChickActivationManager;   import cityBattle.CityBattleManager;   import cityBattle.analyze.CityBattleAnalyze;   import cloudBuyLottery.CloudBuyLotteryManager;   import collectionTask.CollectionTaskManager;   import collectionTask.model.CollectionTaskAnalyzer;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.events.LoaderResourceEvent;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderManager;   import com.pickgliss.loader.LoaderSavingManager;   import com.pickgliss.loader.ModuleLoader;   import com.pickgliss.loader.RequestLoader;   import com.pickgliss.loader.TextLoader;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.utils.ObjectUtils;   import consortion.ConsortionModelManager;   import consortion.analyze.ConsortiaBossDataAnalyzer;   import consortion.analyze.ConsortiaRichRankAnalyze;   import consortion.analyze.ConsortiaWeekRewardAnalyze;   import consortion.analyze.ConsortionListAnalyzer;   import consortion.analyze.ConsortionMemberAnalyer;   import dayActivity.ActivePointAnalzer;   import dayActivity.ActivityAnalyzer;   import dayActivity.ActivityRewardAnalyzer;   import dayActivity.DayActivityManager;   import ddt.data.Experience;   import ddt.data.GoodsAdditioner;   import ddt.data.PetExperience;   import ddt.data.analyze.ActivitySystemItemsDataAnalyzer;   import ddt.data.analyze.AdvanceBeadAnalyzer;   import ddt.data.analyze.BadgeInfoAnalyzer;   import ddt.data.analyze.BallInfoAnalyzer;   import ddt.data.analyze.BeadAnalyzer;   import ddt.data.analyze.BoxTempInfoAnalyzer;   import ddt.data.analyze.BraveDoorDuplicateAnalyzer;   import ddt.data.analyze.CardGrooveEventAnalyzer;   import ddt.data.analyze.DailyLeagueAwardAnalyzer;   import ddt.data.analyze.DailyLeagueLevelAnalyzer;   import ddt.data.analyze.DaylyGiveAnalyzer;   import ddt.data.analyze.DungeonAnalyzer;   import ddt.data.analyze.EquipSuitTempleteAnalyzer;   import ddt.data.analyze.ExpericenceAnalyze;   import ddt.data.analyze.FilterWordAnalyzer;   import ddt.data.analyze.FineSuitAnalyze;   import ddt.data.analyze.FriendListAnalyzer;   import ddt.data.analyze.GoodCategoryAnalyzer;   import ddt.data.analyze.GoodsAdditionAnalyer;   import ddt.data.analyze.InventoryItemAnalyzer;   import ddt.data.analyze.ItemTempleteAnalyzer;   import ddt.data.analyze.LoginSelectListAnalyzer;   import ddt.data.analyze.MapAnalyzer;   import ddt.data.analyze.MovingNotificationAnalyzer;   import ddt.data.analyze.MyAcademyPlayersAnalyze;   import ddt.data.analyze.PetAllSkillAnalyzer;   import ddt.data.analyze.PetExpericenceAnalyze;   import ddt.data.analyze.PetInfoAnalyzer;   import ddt.data.analyze.PetMoePropertyAnalyzer;   import ddt.data.analyze.PetSkillAnalyzer;   import ddt.data.analyze.PetconfigAnalyzer;   import ddt.data.analyze.PetsEvolutionDataAnalyzer;   import ddt.data.analyze.PetsFormDataAnalyzer;   import ddt.data.analyze.PyramidAnalyze;   import ddt.data.analyze.QuestListAnalyzer;   import ddt.data.analyze.QuestionInfoAnalyze;   import ddt.data.analyze.RegisterAnalyzer;   import ddt.data.analyze.ServerConfigAnalyz;   import ddt.data.analyze.ServerListAnalyzer;   import ddt.data.analyze.ShopItemAnalyzer;   import ddt.data.analyze.ShopItemDisCountAnalyzer;   import ddt.data.analyze.ShopItemSortAnalyzer;   import ddt.data.analyze.SuitTempleteAnalyzer;   import ddt.data.analyze.TexpExpAnalyze;   import ddt.data.analyze.UserBoxInfoAnalyzer;   import ddt.data.analyze.VoteInfoAnalyzer;   import ddt.data.analyze.VoteSubmitAnalyzer;   import ddt.data.analyze.WeaponBallInfoAnalyze;   import ddt.data.analyze.WeekOpenMapAnalyze;   import ddt.data.analyze.WishInfoAnalyzer;   import ddt.manager.BadgeInfoManager;   import ddt.manager.BallManager;   import ddt.manager.BeadTemplateManager;   import ddt.manager.BossBoxManager;   import ddt.manager.DailyLeagueManager;   import ddt.manager.FineSuitManager;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.MapManager;   import ddt.manager.PathManager;   import ddt.manager.PetAllSkillManager;   import ddt.manager.PetInfoManager;   import ddt.manager.PetSkillManager;   import ddt.manager.PlayerManager;   import ddt.manager.PyramidManager;   import ddt.manager.QuestionInfoMannager;   import ddt.manager.SelectListManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.ServerManager;   import ddt.manager.ShopManager;   import ddt.manager.VoteManager;   import ddt.manager.WeaponBallManager;   import ddt.utils.FilterWordManager;   import ddt.utils.RequestVairableCreater;   import ddt.view.caddyII.CaddyAwardDataAnalyzer;   import ddt.view.caddyII.CaddyAwardModel;   import ddtBuried.BuriedManager;   import ddtBuried.analyer.SearchGoodsPayAnalyer;   import ddtBuried.analyer.UpdateStarAnalyer;   import ddtKingWay.DDTKingWayManager;   import ddtKingWay.analyzer.DDTKingWayDataAnalyzer;   import defendisland.DefendislandManager;   import devilTurn.DevilTurnManager;   import devilTurn.analyze.DevilTurnBoxConvertAnalyzer;   import devilTurn.analyze.DevilTurnGoodsItemAnalyzer;   import devilTurn.analyze.DevilTurnPointShopAnalyzer;   import devilTurn.analyze.DevilTurnRankRewardAnalyzer;   import dragonBoat.DragonBoatManager;   import dragonBoat.analyzer.DragonBoatActiveDataAnalyzer;   import dreamlandChallenge.DreamlandChallengeManager;   import dreamlandChallenge.analyzer.UnrealRankRewardAnalyzer;   import enchant.EnchantInfoAnalyzer;   import enchant.EnchantManager;   import explorerManual.ExplorerManualManager;   import explorerManual.analyzer.ChapterItemAnalyzer;   import explorerManual.analyzer.ManualDebrisAnalyzer;   import explorerManual.analyzer.ManualItemAnalyzer;   import explorerManual.analyzer.ManualPageItemAnalyzer;   import explorerManual.analyzer.ManualUpgradeAnalyzer;   import farm.FarmModelController;   import farm.analyzer.FarmTreePoultryListAnalyzer;   import farm.analyzer.FoodComposeListAnalyzer;   import farm.control.FarmComposeHouseController;   import feedback.FeedbackManager;   import feedback.analyze.LoadFeedbackReplyAnalyzer;   import firstRecharge.FirstRechargeManger;   import firstRecharge.analyer.RechargeAnalyer;   import flash.net.URLVariables;   import flash.utils.getDefinitionByName;   import godCardRaise.GodCardRaiseManager;   import godCardRaise.analyzer.GodCardListAnalyzer;   import godCardRaise.analyzer.GodCardListGroupAnalyzer;   import godCardRaise.analyzer.GodCardPointRewardListAnalyzer;   import godsRoads.analyze.GodsRoadsDataAnalyzer;   import godsRoads.manager.GodsRoadsManager;   import groupPurchase.GroupPurchaseManager;   import groupPurchase.analyzer.GroupPurchaseAwardAnalyzer;   import growthPackage.GrowthPackageManager;   import guardCore.GuardCoreManager;   import guardCore.analyzer.GuardCoreAnalyzer;   import guardCore.analyzer.GuardCoreLevelAnayzer;   import guildMemberWeek.manager.GuildMemberWeekManager;   import horse.HorseAmuletManager;   import horse.HorseManager;   import horse.analyzer.HorseAmuletDataAnalyzer;   import horse.analyzer.HorsePicCherishAnalyzer;   import horse.analyzer.HorseSkillDataAnalyzer;   import horse.analyzer.HorseSkillElementDataAnalyzer;   import horse.analyzer.HorseSkillGetDataAnalyzer;   import horse.analyzer.HorseTemplateDataAnalyzer;   import horseRace.controller.HorseRaceManager;   import lanternriddles.LanternRiddlesManager;   import lanternriddles.analyzer.LanternDataAnalyzer;   import loginDevice.LoginDeviceManager;   import lotteryTicket.LotteryManager;   import magicHouse.MagicBoxDataAnalyzer;   import magicHouse.MagicHouseManager;   import magicStone.MagicStoneManager;   import magicStone.data.MagicStoneTempAnalyer;   import mainbutton.data.HallIconDataAnalyz;   import mainbutton.data.MainButtonManager;   import mark.MarkMgr;   import mark.analyzer.MarkChipAnalyzer;   import mark.analyzer.MarkHammerAnalyzer;   import mark.analyzer.MarkProAnalyzer;   import mark.analyzer.MarkSetAnalyzer;   import mark.analyzer.MarkSuitAnalyzer;   import mark.analyzer.MarkTransferAnalyzer;   import memoryGame.MemoryGameManager;   import memoryGame.analyzer.MemoryGameAnalyzer;   import mines.MinesManager;   import mines.analyzer.MinesDropAnalyzer;   import mines.analyzer.MinesLevelAnalyzer;   import newTitle.NewTitleManager;   import newTitle.analyzer.NewTitleDataAnalyz;   import newYearRice.NewYearRiceManager;   import particleSystem.EmitterInfoAnalyzer;   import particleSystem.ParticleManager;   import petsBag.PetsBagManager;   import petsBag.data.PetAtlasAnalyzer;   import petsBag.petsAdvanced.PetsAdvancedManager;   import petsBag.petsAdvanced.PetsCellUnlocakPriceAnalyzer;   import petsBag.petsAdvanced.PetsRisingStarDataAnalyzer;   import quest.TaskManager;   import rank.RankManager;   import rank.analyzer.RankingListAwardAnalyzer;   import redEnvelope.RedEnvelopeManager;   import rescue.RescueManager;   import rescue.analyzer.RescueRewardAnalyzer;   import roomList.movingNotification.MovingNotificationManager;   import sanXiao.SanXiaoManager;   import sanXiao.model.SanXiaoScoreRewardAnalyzer;   import sanXiao.model.SanXiaoStoreItemAnalyzer;   import sevenDayTarget.controller.SevenDayTargetManager;   import sevenDayTarget.dataAnalyzer.SevenDayTargetDataAnalyzer;   import signBuff.SignBuffManager;   import stock.analyzer.StockAnalyzer;   import stock.analyzer.StockNewsAnalyzer;   import store.FineEvolutionManager;   import store.analyze.EvolutionDataAnalyzer;   import store.analyze.StoreEquipExpericenceAnalyze;   import store.data.StoreEquipExperience;   import store.equipGhost.EquipGhostManager;   import store.equipGhost.data.GhostDataAnalyzer;   import store.forge.wishBead.WishBeadManager;   import store.newFusion.FusionNewManager;   import store.newFusion.data.FusionNewDataAnalyzer;   import store.view.strength.analyzer.ItemStrengthenGoodsInfoAnalyzer;   import store.view.strength.manager.ItemStrengthenGoodsInfoManager;   import superWinner.analyze.SuperWinnerAnalyze;   import superWinner.manager.SuperWinnerManager;   import team.TeamManager;   import team.analyze.TeamActiveAnalyze;   import team.analyze.TeamBattleSeasonAnalyzer;   import team.analyze.TeamBattleSegmentAnalyzer;   import team.analyze.TeamLevelAnalyze;   import team.analyze.TeamMemberAnalyze;   import team.analyze.TeamRankAnalyze;   import team.analyze.TeamShopAnalyze;   import texpSystem.controller.TexpManager;   import totem.HonorUpManager;   import totem.TotemManager;   import totem.data.HonorUpDataAnalyz;   import totem.data.TotemDataAnalyz;   import totem.data.TotemUpGradeAnalyz;   import uiModeManager.bombUI.BombGameFixedMapAnalyzer;   import uiModeManager.bombUI.HappyLittleGameManager;   import uiModeManager.bombUI.model.bomb.BombGameRandomMapAnalyzer;   import uiModeManager.bombUI.model.rank.HappyLittleGameRankAnalyzer;   import welfareCenter.callBackFund.CallBackFundManager;   import witchBlessing.WitchBlessingManager;   import wonderfulActivity.WonderfulActivityManager;   import wonderfulActivity.analyer.WonderfulActAnalyer;   import wonderfulActivity.analyer.WonderfulGMActAnalyer;      public class LoaderCreate   {            private static var _instance:LoaderCreate;                   private var _reloadCount:int = 0;            private var _reloadQuestCount:int = 0;            public function LoaderCreate() { super(); }
            public static function get Instance() : LoaderCreate { return null; }
            public function createAudioILoader() : BaseLoader { return null; }
            public function createAudioIILoader() : BaseLoader { return null; }
            public function createAudioLiteLoader() : BaseLoader { return null; }
            public function createAudioBattleLoader() : BaseLoader { return null; }
            public function loadExppression(fun:Function) : void { }
            public function creatBallInfoLoader() : BaseLoader { return null; }
            public function creatBoxTempInfoLoader() : BaseLoader { return null; }
            public function creatDungeonInfoLoader() : BaseLoader { return null; }
            public function creatFriendListLoader() : BaseLoader { return null; }
            public function creatMyacademyPlayerListLoader() : BaseLoader { return null; }
            public function creatGoodCategoryLoader() : BaseLoader { return null; }
            public function creatItemTempleteLoader() : BaseLoader { return null; }
            public function creatItemTempleteReload() : BaseLoader { return null; }
            public function creatSuitTempleteLoader() : BaseLoader { return null; }
            public function creatEquipSuitTempleteLoader() : BaseLoader { return null; }
            public function creatBadgeInfoLoader() : BaseLoader { return null; }
            public function creatMovingNotificationLoader() : BaseLoader { return null; }
            public function creatDailyInfoLoader() : BaseLoader { return null; }
            public function creatMapInfoLoader() : BaseLoader { return null; }
            public function creatOpenMapInfoLoader() : BaseLoader { return null; }
            public function creatQuestTempleteLoader() : BaseLoader { return null; }
            public function creatQuestTempleteReload() : BaseLoader { return null; }
            public function creatRegisterLoader() : BaseLoader { return null; }
            public function creatSelectListLoader() : BaseLoader { return null; }
            public function creatServerListLoader() : BaseLoader { return null; }
            public function createCardSetsSortRule() : BaseLoader { return null; }
            public function createCardSetsProperties() : BaseLoader { return null; }
            public function creatShopTempleteLoader() : BaseLoader { return null; }
            public function creatGoodsAdditionLoader() : BaseLoader { return null; }
            public function creatShopSortLoader() : BaseLoader { return null; }
            public function creatAllQuestionInfoLoader() : BaseLoader { return null; }
            public function creatUserBoxInfoLoader() : BaseLoader { return null; }
            public function creatZhanLoader() : BaseLoader { return null; }
            public function createConsortiaLoader() : BaseLoader { return null; }
            public function createCalendarRequest() : BaseLoader { return null; }
            public function getMyConsortiaData() : BaseLoader { return null; }
            public function creatFeedbackInfoLoader() : BaseLoader { return null; }
            public function creatExpericenceAnalyzeLoader() : BaseLoader { return null; }
            public function creatPetExpericenceAnalyzeLoader() : BaseLoader { return null; }
            public function creatTexpExpLoader() : BaseLoader { return null; }
            public function creatRingSystemLoader() : BaseLoader { return null; }
            public function creatWeaponBallAnalyzeLoader() : BaseLoader { return null; }
            public function creatDailyLeagueAwardLoader() : BaseLoader { return null; }
            public function creatDailyLeagueLevelLoader() : BaseLoader { return null; }
            public function createWishInfoLader() : BaseLoader { return null; }
            public function creatServerConfigLoader() : BaseLoader { return null; }
            public function creatPetInfoLoader() : BaseLoader { return null; }
            public function creatPetSkillLoader() : BaseLoader { return null; }
            public function creatFarmPoultryInfo() : BaseLoader { return null; }
            public function creatFoodComposeLoader() : BaseLoader { return null; }
            public function creatPetConfigLoader() : BaseLoader { return null; }
            public function creatPetSkillTemplateInfoLoader() : BaseLoader { return null; }
            public function creatActiveInfoLoader() : BaseLoader { return null; }
            public function creatActionExchangeInfoLoader() : BaseLoader { return null; }
            public function creatShopDisCountRealTimesLoader() : BaseLoader { return null; }
            public function creatVoteSubmit() : BaseLoader { return null; }
            public function createStoreEquipConfigLoader() : BaseLoader { return null; }
            public function creatCardGrooveLoader() : BaseLoader { return null; }
            public function creatCardTemplateLoader() : BaseLoader { return null; }
            public function creatItemStrengthenGoodsInfoLoader() : BaseLoader { return null; }
            public function createBeadTemplateLoader() : BaseLoader { return null; }
            public function createBeadAdvanceTemplateLoader() : BaseLoader { return null; }
            public function creatHallIcon() : BaseLoader { return null; }
            public function createTotemTemplateLoader() : BaseLoader { return null; }
            public function createHonorUpTemplateLoader() : BaseLoader { return null; }
            public function createRankingListAwardLoader() : BaseLoader { return null; }
            public function createConsortiaBossTemplateLoader() : BaseLoader { return null; }
            public function creatActiveLoader() : BaseLoader { return null; }
            public function creatActivePointLoader() : BaseLoader { return null; }
            public function creatRewardLoader() : BaseLoader { return null; }
            public function creatOneYuanBuyGoodsLoader() : BaseLoader { return null; }
            public function creatOneYuanBuySaleItemLoader() : BaseLoader { return null; }
            public function loaderSearchGoodsTemp() : BaseLoader { return null; }
            public function loaderSearchGoodsPayMoney() : BaseLoader { return null; }
            public function creatWondActiveLoader() : BaseLoader { return null; }
            public function firstRechargeLoader() : BaseLoader { return null; }
            public function accumulativeLoginLoader() : BaseLoader { return null; }
            public function createCommunalActiveLoader() : BaseLoader { return null; }
            public function createCaddyAwardsLoader() : BaseLoader { return null; }
            public function createNewFusionDataLoader() : BaseLoader { return null; }
            public function createEnergyDataLoader() : BaseLoader { return null; }
            public function createGroupPurchaseAwardInfoLoader() : BaseLoader { return null; }
            private function loadVoteXml(anlyzer:VoteSubmitAnalyzer) : void { }
            public function loadWonderfulActivityXml() : BaseLoader { return null; }
            public function loadLanternRiddlesXml() : BaseLoader { return null; }
            public function createAvatarCollectionUnitDataLoader() : BaseLoader { return null; }
            public function createAvatarCollectionItemDataLoader() : BaseLoader { return null; }
            public function createSanXiaoStoreDataLoader() : BaseLoader { return null; }
            public function createSanXiaoScoreRewardDataLoader() : BaseLoader { return null; }
            public function createPetCellUnlockPriceLoader() : BaseLoader { return null; }
            public function createPetsRisingStarDataLoader() : BaseLoader { return null; }
            public function createPetsEvolutionDataLoader() : BaseLoader { return null; }
            public function getPetsFormDataLoader() : BaseLoader { return null; }
            public function loadMagicStoneTemplate() : BaseLoader { return null; }
            public function createHorseTemplateDataLoader() : BaseLoader { return null; }
            public function createHorseSkillGetDataLoader() : BaseLoader { return null; }
            public function createHorseSkillDataLoader() : BaseLoader { return null; }
            public function createHorseSkillElementDataLoader() : BaseLoader { return null; }
            public function createCollectionRebortDataLoader() : BaseLoader { return null; }
            public function createHorsePicCherishDataLoader() : BaseLoader { return null; }
            public function createNewTitleDataLoader() : BaseLoader { return null; }
            public function createRescueRewardLoader() : BaseLoader { return null; }
            public function createEnchantMagicInfoLoader() : BaseLoader { return null; }
            public function createFineSuitInfoLoader() : BaseLoader { return null; }
            public function creatRouletteTempleteLoader(call:Function) : BaseLoader { return null; }
            public function creatPyramidLoader() : BaseLoader { return null; }
            public function creatConsortiaWeekRewardLoader() : BaseLoader { return null; }
            public function creatConsortiaRichRankLoader() : BaseLoader { return null; }
            public function creatMemoryGameAwardLoader() : BaseLoader { return null; }
            public function lodaPetAtlasTemplate() : BaseLoader { return null; }
            public function creatGuardCoreLevelTemplate() : BaseLoader { return null; }
            public function creatGuardCoreTemplate() : BaseLoader { return null; }
            public function creatGodCardListTemplate() : BaseLoader { return null; }
            public function creatGodCardListGroup() : BaseLoader { return null; }
            public function creatGodCardPointRewardList() : BaseLoader { return null; }
            public function createBattleSkillTemplate() : BaseLoader { return null; }
            public function createBattleSkillUpdateTemplate() : BaseLoader { return null; }
            public function createBraveDoorDuplicateTemplate() : BaseLoader { return null; }
            public function createCardAchievementTemplate() : BaseLoader { return null; }
            public function createDDTKingGradeTemplate() : BaseLoader { return null; }
            public function createBombFixedMapData() : BaseLoader { return null; }
            public function createEvolutionData() : BaseLoader { return null; }
            public function createHorseAmuletTemplate() : BaseLoader { return null; }
            public function createBombRandomMapData() : BaseLoader { return null; }
            public function createEquipAmuletGradeTemplate() : BaseLoader { return null; }
            public function createEquipAmuletPhaseTemplate() : BaseLoader { return null; }
            public function createEquipAmuletTemplate() : BaseLoader { return null; }
            public function createDDTKingWayTemplate() : BaseLoader { return null; }
            public function createManaualDebrisData() : BaseLoader { return null; }
            public function createChapterItemData() : BaseLoader { return null; }
            public function createManualItemData() : BaseLoader { return null; }
            public function createManualUpgradeData() : BaseLoader { return null; }
            public function createPageItemData() : BaseLoader { return null; }
            public function CreateMiniGameRankRewardCfgLoader() : BaseLoader { return null; }
            public function createCityOccupationSystemsLoader() : BaseLoader { return null; }
            public function __onLoadError(event:LoaderResourceEvent) : void { }
            public function createLoadPetMoePropertyLoader() : BaseLoader { return null; }
            private function __onAlertResponse(event:FrameEvent) : void { }
            public function createActivitySystemItemsLoader() : BaseLoader { return null; }
            private function activitySystemItemsDataHandler(analyzer:DataAnalyzer) : void { }
            public function createMagicBoxDataLoader() : BaseLoader { return null; }
            public function creatGodSyahLoader(type:int = 7) : BaseLoader { return null; }
            public function createGodsRoadsLoader() : BaseLoader { return null; }
            public function creatSuperWinnerLoader() : BaseLoader { return null; }
            public function createSevenDayTargetLoader() : BaseLoader { return null; }
            public function createCampBattleAwardGoodsLoader() : BaseLoader { return null; }
            public function creatParticlesLoader() : BaseLoader { return null; }
            public function createBankLoader() : BaseLoader { return null; }
            public function createEquipGhostLoader() : BaseLoader { return null; }
            public function createStockLoader() : BaseLoader { return null; }
            public function createStockNewsLoader() : BaseLoader { return null; }
            public function createMinesDropLoader() : BaseLoader { return null; }
            public function createMinesLevelLoader() : BaseLoader { return null; }
            public function createTeamMemeberLoader() : BaseLoader { return null; }
            public function createTeamShopLoader() : BaseLoader { return null; }
            public function createTeamAcviteListLoader() : BaseLoader { return null; }
            public function createTeamBattleSeasonLoader() : BaseLoader { return null; }
            public function createTeamBattleSegmentLoader() : BaseLoader { return null; }
            public function createTheServerTeamRankLoader() : BaseLoader { return null; }
            public function createCrossServerTeamRankLoader() : BaseLoader { return null; }
            public function createTeamLevelListLoader() : BaseLoader { return null; }
            public function createAngelInvestmentLoader() : BaseLoader { return null; }
            public function createMarkChipLoader() : BaseLoader { return null; }
            public function createMarkSuitLoader() : BaseLoader { return null; }
            public function createMarkSetLoader() : BaseLoader { return null; }
            public function createMarkHammerLoader() : BaseLoader { return null; }
            public function createMarkProInfoLoader() : BaseLoader { return null; }
            public function createMarkTransferLoader() : BaseLoader { return null; }
            public function createDevilTurnGoodsItemLoader() : BaseLoader { return null; }
            public function createDevilTurnBoxConvertLoader() : BaseLoader { return null; }
            public function createDevilTurnPointShopLoader() : BaseLoader { return null; }
            public function createDevilTurnRankAewardLoader() : BaseLoader { return null; }
            public function createUnrealRankRewardLoader() : BaseLoader { return null; }
            public function createTotemUpGradeTemplateLoader() : BaseLoader { return null; }
   }}