package ddt.manager{   import ddt.data.ServerConfigInfo;   import ddt.data.analyze.ServerConfigAnalyz;   import flash.utils.Dictionary;   import road7th.data.DictionaryData;   import road7th.utils.DateUtils;      public class ServerConfigManager   {            private static var _instance:ServerConfigManager;            public static const ADD_PLAYER_DRESS:String = "BuyClothGroupCost";            public static const SEVENDAY:String = "SevenDayTargetReward";            public static const MARRT_ROOM_CREATE_MONET:String = "MarryRoomCreateMoney";            public static const PRICE_DIVORCED:String = "DivorcedMoney";            public static const PRICE_DIVORCED_DISCOUNT:String = "DivorcedDiscountMoney";            public static const MISSION_RICHES:String = "MissionRiches";            public static const VIP_RATE_FOR_GP:String = "VIPRateForGP";            public static const VIP_QUEST_STAR:String = "VIPQuestStar";            public static const VIP_LOTTERY_COUNT_MAX_PER_DAY:String = "VIPLotteryCountMaxPerDay";            public static const VIP_TAKE_CARD_DISCOUNT:String = "VIPTakeCardDisCount";            public static const VIP_EXP_NEEDEDFOREACHLV:String = "VIPExpForEachLv";            public static const HOT_SPRING_EXP:String = "HotSpringExp";            public static const VIP_STRENGTHEN_EX:String = "VIPStrengthenEx";            public static const CONSORTIA_STRENGTHEN_EX:String = "ConsortiaStrengthenEx";            public static const VIPEXTTRA_BIND_MOMEYUPPER:String = "VIPExtraBindMoneyUpper";            public static const AWARD_MAX_MONEY:String = "AwardMaxMoney";            public static const VIP_RENEWAL_PRIZE:String = "VIPRenewalPrize";            public static const VIP_DAILY_PACK:String = "VIPDailyPackID";            public static const VIP_PRIVILEGE:String = "VIPPrivilege";            public static const VIP_PAYAIMENERGY:String = "VIPPayAimEnergy";            public static const PAYAIMENERGY:String = "PayAimEnergy";            public static const VIP_QUEST_FINISH_DIRECT:String = "VIPQuestFinishDirect";            public static const CARD_RESETSOUL_VALUE_CARD:String = "CardResetSoulValue";            public static const CARD_GROOVE_REVERT:String = "CardGrooveRevert";            public static const PLAYER_MIN_LEVEL:String = "PlayerMinLevel";            public static const BEAD_UPGRADE_EXP:String = "RuneLevelUpExp";            public static const REQUEST_BEAD_PRICE:String = "OpenRunePackageMoney";            public static const BEAD_HOLE_UP_EXP:String = "HoleLevelUpExpList";            public static const DRAGON_BOAT_BUILD_STAGE:String = "DragonBoatBuildStage";            public static const HORSEGAMEBUFFCONFIG:String = "HorseGameBuffConfig";            public static const PYRAMIDTOPPOINT:String = "PyramidTopPoint";            public static const DDT_KING_FLOAT_FAST_TIME:String = "TankMatchFastTime";            public static const DRAGON_BOAT_FAST_TIME:String = "DragonBoatFastTime";            public static const RESCUE_CLEAN_CD_PRICE:String = "HelpGameCleanCDPrice";            public static const RESCUE_SHOPITEM_PRICE:String = "HelpGameBuffPrice";            public static const DEPOT_BUY_MONEY:String = "DepotBuyMoney";            public static const DDFUNDPRICE:String = "DDFundPrice";            public static const AUCTION_RATE:String = "Cess";            public static const HOMEFIGHT_BOXID:String = "HomeTDHomeBoxID";            public static const HOMEFIGHT_SKILL_PRICE:String = "HomeTDSkillPrice";            public static const HOMEFIGHT_SKILL_EFFECT:String = "HomeTDSkillEffect";            public static const HOMEFIGHT_REVIVE_PRICE:String = "HomeTDRevivePrice";            public static const HOMEFIGHT_LV_LIMIT:String = "HomeLvLimit";            public static const HOMEFIGHT_BLOOD:String = "HomeTDHomeBlood";            public static const CALLSCORELIMIT:String = "CallScoreLimit";            public static const OLDPLAYERSHOPBUYLIMIT:String = "OldPlayerShopBuyLimit";            public static const HOMEBARCLEANCDPRICE:String = "HomeBarCleanCDPrice";            public static const HOUSE_UPDATE_USE:String = "HouseUpgradeUse";            public static const PETDISAPPEAR_PLAYCOUNT:String = "PetDisappearPlayCount";            public static const PETDISAPPEAR_PLAYSONCOUNT:String = "PetDisappearPlaySonCount";            public static const PETDISAPPEAR_USERBLOOD:String = "PetDisappearUserBlood";            public static const PETDISAPPEAR_NPCBLOOD:String = "PetDisappearNPCBlood";            public static const PRAYGOODS_ACTIVITY_CONFIG:String = "PrayGoodsActivityConfig";            public static const ENTERTAINMENT_SCORE:String = "EntertainmentScore";            public static const RECREATIONPVPREFRESHPROP_BINDMONEY:String = "RecreationPvpRefreshPropBindMoney";            public static const RECREATIONPVP_MINLEVEL:String = "RecreationPvpMinLevel";            public static const BUYCARDSOULVALUEMONEY:String = "BuyCardSoulValueMoney";            public static const KINGBUFFPRICE:String = "KingBuffPrice";            public static const KINGBUFFPRICEDISCOUNT:String = "KingBuffPriceDiscount";            public static const ItemDevelopPrice:String = "ItemDevelopPrice";            public static const SENIORMARRY_BEGIN:String = "SeniorMarryBegin";            public static const SENIORMARRY_END:String = "SeniorMarryEnd";            public static const WARRIORFAMRAIDPRICEPERMIN:String = "WarriorFamRaidPricePerMin";            public static const YEARFOODITEMCOUNT:String = "YearFoodItemsCount";            public static const YEARFOODITEMS:String = "YearFoodItems";            public static const YEARFOODITEMPRICES:String = "YearFoodItemPrices";            public static const MAGICSTONECOSTITEM:String = "MagicStoneCostItem";            public static const WORSHIPMOONBEGINDATE:String = "WorshipMoonBeginDate";            public static const WORSHIPMOONENDDATE:String = "WorshipMoonEndDate";            public static const PRIVILEGE_CANBUYFERT:String = "8";            public static const PRIVILEGE_LOTTERYNOTIME:String = "13";            private static var privileges:Dictionary;            public static const LIGHTROAD_MINLEVEL:String = "GoodsCollectMinLevel";            public static const CONSORTIA_MATCH_START_TIME:String = "ConsortiaMatchStartTime";            public static const CONSORTIA_MATCH_END_TIME:String = "ConsortiaMatchEndTime";            public static const LOCAL_CONSORTIA_MATCH_DAYS:String = "LocalConsortiaMatchDays";            public static const AREA_CONSORTIA_MATCH_DAYS:String = "AreaConsortiaMatchDays";            public static const DEED_PRICES:String = "DanDanBuffPrice";            public static const ISCHICKENACTIVEKEYOPEN:String = "IsChickenActiveKeyOpen";            public static const CHICKENACTIVEKEYLVAWARDNEEDPRESTIGE:String = "ChickenActiveKeyLvAwardNeedPrestige";            public static const EVERYDAYOPENPRICE:String = "EveryDayOpenPrice";            public static const TOTEMPROPMONEYOFFSET:String = "TotemPropMoneyOffset";            public static const WITCH_BLESS_GP:String = "WitchBlessGP";            public static const WITCH_BLESS_DOUBLEGP_TIME:String = "WitchBlessDoubleGpTime";            public static const WITCH_BLESS_MONEY:String = "WithcBlessMoney";            public static const DRAGONBOAT_PROP:String = "DragonBoatProp";            public static const ISBUYQUESTENERYNEEDKINGBUFF:String = "IsBuyQuestEnereyNeedKingBuff";            public static const PROMOTEPACKAGEPRICE:String = "PromotePackagePrice";            public static const ISPROMOTEPACKAGEOPEN:String = "IsPromotePackageOpen";            public static const ISOPENWEALTHTREE:String = "IsOpenWealthTree";            public static const CHRISTMAST_GIFTS_GETTIME:String = "ChristmasGiftsGetTime";            public static const UNREALCONTEST_BUYCOST:String = "UnrealContestBuyCost";            public static const UNREALCONTESTLEVELLIMITS:String = "UnrealContestLevelLimits";            public static const UNREALCONTEST_ENDDATE:String = "UnrealContestEndDate";            public static const PETWASH_COST:String = "PetWashCost";            public static const PET_QUALITY_CONFIG:String = "PetQualityConfig";                   private var _serverConfigInfoList:DictionaryData;            private var _BindMoneyMax:Array;            private var _VIPExtraBindMoneyUpper:Array;            private var _activityEnterNum:int;            private var _consortiaTaskDelayInfo:Array;            private var _cryptBossOpenDay:Array;            private var _dailyRewardIDForMonth:Array;            private var _christmasGiftGetTime:String;            private var _catchBatchOpen:DictionaryData;            public function ServerConfigManager() { super(); }
            public static function get instance() : ServerConfigManager { return null; }
            public function getserverConfigInfo(analyzer:ServerConfigAnalyz) : void { }
            public function get raceDayCount() : int { return 0; }
            public function get raceMaxSorce() : int { return 0; }
            public function get getPrestigeTimes() : int { return 0; }
            public function get getDayMaxAddPrestige() : int { return 0; }
            public function get lanternMaxHomeVisits() : int { return 0; }
            public function get buyCardSoulValueMoney() : Number { return 0; }
            public function get lanternMaxHomeVisited() : int { return 0; }
            public function getNeedUseLotteryKicket(quality:int) : int { return 0; }
            public function get lanternCookLanternGold() : int { return 0; }
            public function get serverConfigInfo() : DictionaryData { return null; }
            public function get LightRiddleAnswerTime() : Number { return 0; }
            public function get YearMonsterBeginDate() : String { return null; }
            public function get YearMonsterEndDate() : String { return null; }
            public function get YearMonsterBuyTimes() : int { return 0; }
            public function get YearMonsterBuyPrice() : Array { return null; }
            public function get consortiaTaskDelayInfo() : Array { return null; }
            public function get cryptBossOpenDay() : Array { return null; }
            public function getBindBidLimit(level:int, vipLevel:int = 0) : int { return 0; }
            public function get PayAimEnergy() : int { return 0; }
            public function get VIPPayAimEnergy() : Array { return null; }
            public function get weddingMoney() : Array { return null; }
            public function get MissionRiches() : Array { return null; }
            public function get VIPExpNeededForEachLv() : Array { return null; }
            public function get CardRestSoulValue() : String { return null; }
            public function get cardResetCardSoulMoney() : String { return null; }
            public function get VIPExtraBindMoneyUpper() : Array { return null; }
            public function get HotSpringExp() : Array { return null; }
            public function findInfoByName(name:String) : ServerConfigInfo { return null; }
            public function get VIPStrengthenEx() : Array { return null; }
            public function ConsortiaStrengthenEx() : Array { return null; }
            public function get RouletteMaxTicket() : String { return null; }
            public function get VIPRenewalPrice() : Array { return null; }
            public function get VIPRateForGP() : Array { return null; }
            public function get VIPQuestStar() : Array { return null; }
            public function get VIPLotteryCountMaxPerDay() : Array { return null; }
            public function get VIPTakeCardDisCount() : Array { return null; }
            public function get VIPQuestFinishDirect() : Array { return null; }
            public function analyzeData(field:String) : Array { return null; }
            public function getPrivilegeString(level:int) : String { return null; }
            public function get VIPDailyPack() : Array { return null; }
            public function get VIPRewardCryptCount() : Vector.<String> { return null; }
            public function getPrivilegeMinLevel(type:String) : int { return 0; }
            public function getBeadUpgradeExp() : DictionaryData { return null; }
            public function getRequestBeadPrice() : Array { return null; }
            public function getBeadHoleUpExp() : Array { return null; }
            public function get minOpenPetSystemLevel() : int { return 0; }
            public function get activityEnterNum() : int { return 0; }
            public function get dailyRewardIDForMonth() : Array { return null; }
            public function get christmasGiftGetTime() : String { return null; }
            public function getDragonBoatBuildStage(type:int) : Array { return null; }
            public function get dragonBoatFastTime() : int { return 0; }
            public function get ddtKingFloatFastTime() : int { return 0; }
            public function get magpieBridgeCountPrice() : int { return 0; }
            public function get searchGoodsRewardID() : Array { return null; }
            public function get searchGoodsRewardTimes() : Array { return null; }
            public function get rescueShopItemPrice() : Array { return null; }
            public function get rescueCleanCDPrice() : Array { return null; }
            public function get catchInsectBeginTime() : String { return null; }
            public function get catchInsectEndTime() : String { return null; }
            public function get catchInsectPrizeInfo() : Array { return null; }
            public function get catchInsectLocalTitle() : Array { return null; }
            public function get catchInsectAreaTitle() : Array { return null; }
            public function get nationalDayDropBeginDate() : String { return null; }
            public function get pyramidTopMinMaxPoint() : Array { return null; }
            public function get sevendayProgressGift() : Array { return null; }
            public function get nationalDayDropEndDate() : String { return null; }
            public function get CookPanaxEndDate() : String { return null; }
            public function get CookPanaxBeginDate() : String { return null; }
            public function SanXiaoChangeColorScore() : String { return null; }
            public function SanXiaoChangeColorPrice() : String { return null; }
            public function SanXiaoCrossBombScore() : String { return null; }
            public function SanXiaoCrossBombPrice() : String { return null; }
            public function SanXiaoSquareBombScore() : String { return null; }
            public function SanXiaoSquareBombPrice() : String { return null; }
            public function SanXiaoClearColorScore() : String { return null; }
            public function SanXiaoClearColorPrice() : String { return null; }
            public function SanXiaoStepPrice() : String { return null; }
            public function get halloweenBeginDate() : String { return null; }
            public function get halloweenEndDate() : String { return null; }
            public function get depotBuyMoney() : Array { return null; }
            public function get levelFundPrice() : Array { return null; }
            public function get homeFightBoxIDList() : Array { return null; }
            public function get homeFightSkillPrice() : Array { return null; }
            public function entertainmentScore() : Array { return null; }
            public function entertainmentPrice() : int { return 0; }
            public function entertainmentLevel() : int { return 0; }
            public function get homeFightSkillEffect() : Array { return null; }
            public function get homeFightRevivePrice() : int { return 0; }
            public function get homeFightLvLimit() : int { return 0; }
            public function get homeFightBlood() : String { return null; }
            public function get callScoreLimit() : String { return null; }
            public function get oldPlayerShopBuyLimit() : String { return null; }
            public function get dailyRewardIDList() : Array { return null; }
            public function get homeBarCleanCDPrice() : int { return 0; }
            public function getHouseExtendNeed(next:int) : Array { return null; }
            public function getWishingTreeDisplayRewards() : Array { return null; }
            public function getWishingTreeAccRewards() : Array { return null; }
            public function getWishingTreeEndDate() : String { return null; }
            public function yearMonsterBeginDate() : Date { return null; }
            public function yearMonsterEndDate() : Date { return null; }
            public function rescueSpringBegin() : Date { return null; }
            public function getSeniorMarryMoney(isSale:Boolean) : Array { return null; }
            public function getSeniorMarryGift() : Array { return null; }
            public function getBattleSkillDefaultActivate() : Array { return null; }
            public function getChristmasGiftsGetTime() : Array { return null; }
            public function getSeniorMarryBegin() : Date { return null; }
            public function getSeniorMarryEnd() : Date { return null; }
            public function get AuctionRate() : String { return null; }
            public function getDesertFreeEnterCount() : int { return 0; }
            public function getDesertFeeEnterCount() : int { return 0; }
            public function getMagicHighFamMaxLevel() : int { return 0; }
            public function get firstDivorcedMoney() : String { return null; }
            public function getWarriorHighFamMaxLevel() : int { return 0; }
            public function getVipIntegral() : Array { return null; }
            public function get CreateGuild() : int { return 0; }
            public function getHappyRechargeSpecialItemCount() : Array { return null; }
            public function memoryGameCardMoney() : int { return 0; }
            public function memoryGameResetMoney() : int { return 0; }
            public function get highCardResetSoulValue() : String { return null; }
            public function get cardLockAttrMoney() : Array { return null; }
            public function get BombFixGamePerScore() : int { return 0; }
            public function get BombRandomGamePerScore() : int { return 0; }
            public function get BombFixGamePerBombCountAddCount() : int { return 0; }
            public function get BombRandomGamePerBombCountAddCount() : int { return 0; }
            public function get addPlayerDressModel() : Array { return null; }
            public function get HappyLittleGameOpenList() : String { return null; }
            public function get BombGameDoubleScoreBeginCount() : int { return 0; }
            public function get BombGameDoubleScoreKeepCount() : int { return 0; }
            public function get godCardDailyFreeCount() : int { return 0; }
            public function get godCardOpenOneTimeMoney() : int { return 0; }
            public function get divorcedMoney() : String { return null; }
            public function getTimeControl() : Array { return null; }
            public function getSpaceControl() : Array { return null; }
            public function getLootControl() : Array { return null; }
            public function getLevelUpItemID() : int { return 0; }
            public function getSearchPrice() : int { return 0; }
            public function get godCardOpenFiveTimeMoney() : int { return 0; }
            public function get petDisappearPlaycount() : Array { return null; }
            public function get petDisappearPlaySoncount() : Array { return null; }
            public function get petDisappearPlayerBlood() : Array { return null; }
            public function get petDisappearNPCBlood() : Array { return null; }
            public function get petDisappearRecoverPrice() : int { return 0; }
            public function get petDisappearSkillMoney() : Array { return null; }
            public function get petDisappearSkillMaxTimes() : int { return 0; }
            public function get petDisappearSkillTwoMaxTimes() : int { return 0; }
            public function get petDisappearSkillTwoMoney() : Array { return null; }
            public function get HorseGameEachDayMaxCount() : int { return 0; }
            public function get HorseGameUsePapawMoney() : int { return 0; }
            public function get HorseGameCostMoneyCount() : int { return 0; }
            public function get horseGameBuffConfig() : Array { return null; }
            public function get petDisappearMaxLevel() : int { return 0; }
            public function get petDisappearAddScore() : int { return 0; }
            public function get petDisappearMinLevel() : int { return 0; }
            public function get prayActivityConfig() : Array { return null; }
            public function get kingBuffPrice() : String { return null; }
            public function get kingBuffPriceDiscount() : String { return null; }
            public function get localYearFoodItemsCount() : Array { return null; }
            public function get localYearFoodItems() : Array { return null; }
            public function get cityOccupationAddPrice() : Array { return null; }
            public function get cityOccupationStartDate() : String { return null; }
            public function get cityOccupationEndDate() : String { return null; }
            public function get localYearFoodItemsPrices() : Array { return null; }
            public function get getLightRiddleIsNew() : Boolean { return false; }
            public function get getIsBuyQuestEnereyNeedKingBuff() : Boolean { return false; }
            public function getDDTKingQuizPrize() : int { return 0; }
            public function getDDTKingQuizCityList() : String { return null; }
            public function getDDTKingQuizPersonMaxCount() : String { return null; }
            public function getDDTKingQuizTeamMaxCount() : String { return null; }
            public function getTwoColorBallBeginTime() : String { return null; }
            public function getTwoColorBallEndTime() : String { return null; }
            public function getFairBattleScoreEndTime() : String { return null; }
            public function getFairBattleScoreBeginTime() : String { return null; }
            public function getDDTKingQuizCanJoinEndTime() : String { return null; }
            public function getDDTKingQuizCanJoinBeginTime() : String { return null; }
            public function getSysRedEnvelopePublishInfo() : String { return null; }
            public function getDDTKingQuizEndTime() : String { return null; }
            public function getDDTKingQuizBeginTime() : String { return null; }
            public function getRedEnvelopeEndTime() : String { return null; }
            public function getRedEnvelopeBeginTime() : String { return null; }
            public function getLightRiddleRemoveErrorMoney() : int { return 0; }
            public function getDDTKingQuizLostID() : int { return 0; }
            public function getDDTKingQuizWinID() : int { return 0; }
            public function get magicStoneCostItemNum() : int { return 0; }
            public function get consortiaMatchStartTime() : Array { return null; }
            public function get consortiaMatchEndTime() : Array { return null; }
            public function get localConsortiaMatchDays() : Array { return null; }
            public function get areaConsortiaMatchDays() : Array { return null; }
            public function get getDeedPrices() : Array { return null; }
            public function get worshipMoonBeginDate() : String { return null; }
            public function get worshipMoonEndDate() : String { return null; }
            public function get chickActivationIsOpen() : Boolean { return false; }
            public function get chickenActiveKeyLvAwardNeedPrestige() : Array { return null; }
            public function getToyMachinePrice() : Array { return null; }
            public function getRedEnvelopeCount(type:int) : int { return 0; }
            public function get getEveryDayOpenPrice() : Array { return null; }
            public function get magicHouseJuniorAddAttribute() : Array { return null; }
            public function get magicHouseMidAddAttribute() : Array { return null; }
            public function get magicHouseSeniorAddAttribute() : Array { return null; }
            public function get magicHouseJuniorWeaponList() : Array { return null; }
            public function get magicHouseMidWeaponList() : Array { return null; }
            public function get magicHouseSeniorWeaponList() : Array { return null; }
            public function get magicHouseBoxNeedMonry() : int { return 0; }
            public function get magicHouseOpenDepotNeedMoney() : int { return 0; }
            public function get magicHouseDepotPromoteNeedMoney() : int { return 0; }
            public function get magicHouseLevelUpNumber() : Array { return null; }
            public function get zodiacAddPrice() : int { return 0; }
            public function firstSeniorMarryMoney() : String { return null; }
            public function get totemSignDiscount() : Number { return 0; }
            public function get getWitchBlessItemId() : String { return null; }
            public function get getWitchBlessDoubleGpTime() : String { return null; }
            public function get getWitchBlessGP() : Array { return null; }
            public function get getWitchBlessMoney() : int { return 0; }
            public function get getDragonboatProp() : int { return 0; }
            public function get WarriorFamRaidPricePerMin() : Number { return 0; }
            public function get getThreeCleanBuyCost() : Number { return 0; }
            public function get growthPackagePrice() : Number { return 0; }
            public function get growthPackageIsOpen() : Boolean { return false; }
            public function get wealthTreeIsOpen() : Boolean { return false; }
            public function get trialBuffTipPropertyValue() : String { return null; }
            public function get trialfubenBuffTipPropertyValue() : String { return null; }
            public function get trialBattleLevelLimit() : int { return 0; }
            public function get weaponShellNormalAdd() : int { return 0; }
            public function get ddqyOfferCostMoneyArr() : Array { return null; }
            public function get ddqyOpenTreasureboxCostMoney() : int { return 0; }
            public function get angelInvestmentAllPrice() : int { return 0; }
            public function get angelInvestmentDiscount() : int { return 0; }
            public function get angelInvestmentDay() : int { return 0; }
            public function get storeExaltRestorePrice() : int { return 0; }
            public function get wasteRecycleAwardIdList() : Array { return null; }
            public function get wasteRecycleLotteryScore() : int { return 0; }
            public function get wasteRecycleLimit() : int { return 0; }
            public function get fireWorksList() : Array { return null; }
            public function get maxLevelAllResetCost() : int { return 0; }
            public function get maxLevelResetCost() : int { return 0; }
            public function get rewardTaskPrice() : int { return 0; }
            public function get rewardMultiplePrice() : int { return 0; }
            public function get addRewardTaskPrice() : int { return 0; }
            public function get taskNumber() : int { return 0; }
            public function get addTaskNumPrice() : int { return 0; }
            public function get consortiaGuardReviveRiches() : int { return 0; }
            public function get consortiaGuardOpenRiches() : int { return 0; }
            public function get consortiaGuardReviveTime() : int { return 0; }
            public function get consortiaGuardBuyCost() : int { return 0; }
            public function get consortiaGuardBuyBuffMaxLevel() : int { return 0; }
            public function get battleDungeonLimitCount() : int { return 0; }
            public function get nightmareDungeonLimitTimes() : int { return 0; }
            public function get nightmareDungeonLimitPower() : int { return 0; }
            public function get equipAmuletBuyDustMax() : int { return 0; }
            public function get AmuletBuyDustCountAndNeedMoney() : Array { return null; }
            public function get WorshipMoonBeginDate() : String { return null; }
            public function get WorshipMoonEndDate() : String { return null; }
            public function get batchOpenConfig() : DictionaryData { return null; }
            public function get cubeGameRow() : int { return 0; }
            public function get cubeGameColumn() : int { return 0; }
            public function get strongDestroyScore() : int { return 0; }
            public function get extraDestroyScore() : int { return 0; }
            public function get emptyColumnScore() : int { return 0; }
            public function get cubeGameCostEnergy() : int { return 0; }
            public function get nationDayGetMaxTimes() : Array { return null; }
            public function get pvePowerBuffLevelLimit() : int { return 0; }
            public function get pvePowerBuffRefreshPrice() : int { return 0; }
            public function get pvePowerBuffGetBuffPrice() : int { return 0; }
            public function get ItemDevelopPrice() : int { return 0; }
            public function get stockLoanRechageRate() : int { return 0; }
            public function get StockOpenTime() : String { return null; }
            public function get StockStartDate() : String { return null; }
            public function get StockEndDate() : String { return null; }
            public function get StockOverDate() : String { return null; }
            public function get StockScoreAward() : String { return null; }
            public function get consortionActiveTarget() : String { return null; }
            public function get getTeamCreateCoin() : int { return 0; }
            public function get getTeamDonatePrice() : int { return 0; }
            public function get getOnlineArmCostEnergy() : int { return 0; }
            public function get FreeInviteLevelMin() : int { return 0; }
            public function get FreeInviteLevelMax() : int { return 0; }
            public function get FreeInviteCount() : int { return 0; }
            public function get markOpenLevel() : int { return 0; }
            public function get EngraveSaleStarConfig() : int { return 0; }
            public function get EngraveSaleTemperConsumeConfig() : int { return 0; }
            public function get getEngraveVaults() : Array { return null; }
            public function get getEngraveVaultsFreeTimes() : int { return 0; }
            public function get devilTurnCfgBox() : Array { return null; }
            public function get devilTurnTemplateID() : int { return 0; }
            public function get devilTurnBeginDate() : String { return null; }
            public function get devilTurnEndDate() : String { return null; }
            public function get devilTurnLotteryOneCost() : int { return 0; }
            public function get devilTurnLotteryTenCost() : int { return 0; }
            public function get devilTurnTotalJackpot() : int { return 0; }
            public function get devilTurnFreeLotteryCount() : int { return 0; }
            public function get devilTurnOpenLevelLimit() : int { return 0; }
            public function get consortiaTaskPriceArr() : Array { return null; }
            public function get gameExitPunishTimes() : int { return 0; }
            public function get unrealContestBuyCost() : int { return 0; }
            public function get unrealContestLevelLimits() : Array { return null; }
            public function get unrealContestEndDate() : Date { return null; }
            public function get DreamLandId() : int { return 0; }
            public function get petWashCost() : DictionaryData { return null; }
            public function get petQualityConfig() : Array { return null; }
            public function get clearWorldcupGuessPrice() : int { return 0; }
            public function get worldcupBackRate() : Array { return null; }
            public function get worldcupAwardCount() : Array { return null; }
            public function get MarkEquipSchemePrice() : int { return 0; }
            public function get OldPlayerTaskRemainTime() : String { return null; }
            public function get OldPlayerActiveRemainTime() : String { return null; }
   }}