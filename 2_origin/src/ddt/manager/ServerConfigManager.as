package ddt.manager
{
   import ddt.data.ServerConfigInfo;
   import ddt.data.analyze.ServerConfigAnalyz;
   import flash.utils.Dictionary;
   import road7th.data.DictionaryData;
   import road7th.utils.DateUtils;
   
   public class ServerConfigManager
   {
      
      private static var _instance:ServerConfigManager;
      
      public static const ADD_PLAYER_DRESS:String = "BuyClothGroupCost";
      
      public static const SEVENDAY:String = "SevenDayTargetReward";
      
      public static const MARRT_ROOM_CREATE_MONET:String = "MarryRoomCreateMoney";
      
      public static const PRICE_DIVORCED:String = "DivorcedMoney";
      
      public static const PRICE_DIVORCED_DISCOUNT:String = "DivorcedDiscountMoney";
      
      public static const MISSION_RICHES:String = "MissionRiches";
      
      public static const VIP_RATE_FOR_GP:String = "VIPRateForGP";
      
      public static const VIP_QUEST_STAR:String = "VIPQuestStar";
      
      public static const VIP_LOTTERY_COUNT_MAX_PER_DAY:String = "VIPLotteryCountMaxPerDay";
      
      public static const VIP_TAKE_CARD_DISCOUNT:String = "VIPTakeCardDisCount";
      
      public static const VIP_EXP_NEEDEDFOREACHLV:String = "VIPExpForEachLv";
      
      public static const HOT_SPRING_EXP:String = "HotSpringExp";
      
      public static const VIP_STRENGTHEN_EX:String = "VIPStrengthenEx";
      
      public static const CONSORTIA_STRENGTHEN_EX:String = "ConsortiaStrengthenEx";
      
      public static const VIPEXTTRA_BIND_MOMEYUPPER:String = "VIPExtraBindMoneyUpper";
      
      public static const AWARD_MAX_MONEY:String = "AwardMaxMoney";
      
      public static const VIP_RENEWAL_PRIZE:String = "VIPRenewalPrize";
      
      public static const VIP_DAILY_PACK:String = "VIPDailyPackID";
      
      public static const VIP_PRIVILEGE:String = "VIPPrivilege";
      
      public static const VIP_PAYAIMENERGY:String = "VIPPayAimEnergy";
      
      public static const PAYAIMENERGY:String = "PayAimEnergy";
      
      public static const VIP_QUEST_FINISH_DIRECT:String = "VIPQuestFinishDirect";
      
      public static const CARD_RESETSOUL_VALUE_CARD:String = "CardResetSoulValue";
      
      public static const CARD_GROOVE_REVERT:String = "CardGrooveRevert";
      
      public static const PLAYER_MIN_LEVEL:String = "PlayerMinLevel";
      
      public static const BEAD_UPGRADE_EXP:String = "RuneLevelUpExp";
      
      public static const REQUEST_BEAD_PRICE:String = "OpenRunePackageMoney";
      
      public static const BEAD_HOLE_UP_EXP:String = "HoleLevelUpExpList";
      
      public static const DRAGON_BOAT_BUILD_STAGE:String = "DragonBoatBuildStage";
      
      public static const HORSEGAMEBUFFCONFIG:String = "HorseGameBuffConfig";
      
      public static const PYRAMIDTOPPOINT:String = "PyramidTopPoint";
      
      public static const DDT_KING_FLOAT_FAST_TIME:String = "TankMatchFastTime";
      
      public static const DRAGON_BOAT_FAST_TIME:String = "DragonBoatFastTime";
      
      public static const RESCUE_CLEAN_CD_PRICE:String = "HelpGameCleanCDPrice";
      
      public static const RESCUE_SHOPITEM_PRICE:String = "HelpGameBuffPrice";
      
      public static const DEPOT_BUY_MONEY:String = "DepotBuyMoney";
      
      public static const DDFUNDPRICE:String = "DDFundPrice";
      
      public static const AUCTION_RATE:String = "Cess";
      
      public static const HOMEFIGHT_BOXID:String = "HomeTDHomeBoxID";
      
      public static const HOMEFIGHT_SKILL_PRICE:String = "HomeTDSkillPrice";
      
      public static const HOMEFIGHT_SKILL_EFFECT:String = "HomeTDSkillEffect";
      
      public static const HOMEFIGHT_REVIVE_PRICE:String = "HomeTDRevivePrice";
      
      public static const HOMEFIGHT_LV_LIMIT:String = "HomeLvLimit";
      
      public static const HOMEFIGHT_BLOOD:String = "HomeTDHomeBlood";
      
      public static const CALLSCORELIMIT:String = "CallScoreLimit";
      
      public static const OLDPLAYERSHOPBUYLIMIT:String = "OldPlayerShopBuyLimit";
      
      public static const HOMEBARCLEANCDPRICE:String = "HomeBarCleanCDPrice";
      
      public static const HOUSE_UPDATE_USE:String = "HouseUpgradeUse";
      
      public static const PETDISAPPEAR_PLAYCOUNT:String = "PetDisappearPlayCount";
      
      public static const PETDISAPPEAR_PLAYSONCOUNT:String = "PetDisappearPlaySonCount";
      
      public static const PETDISAPPEAR_USERBLOOD:String = "PetDisappearUserBlood";
      
      public static const PETDISAPPEAR_NPCBLOOD:String = "PetDisappearNPCBlood";
      
      public static const PRAYGOODS_ACTIVITY_CONFIG:String = "PrayGoodsActivityConfig";
      
      public static const ENTERTAINMENT_SCORE:String = "EntertainmentScore";
      
      public static const RECREATIONPVPREFRESHPROP_BINDMONEY:String = "RecreationPvpRefreshPropBindMoney";
      
      public static const RECREATIONPVP_MINLEVEL:String = "RecreationPvpMinLevel";
      
      public static const BUYCARDSOULVALUEMONEY:String = "BuyCardSoulValueMoney";
      
      public static const KINGBUFFPRICE:String = "KingBuffPrice";
      
      public static const KINGBUFFPRICEDISCOUNT:String = "KingBuffPriceDiscount";
      
      public static const ItemDevelopPrice:String = "ItemDevelopPrice";
      
      public static const SENIORMARRY_BEGIN:String = "SeniorMarryBegin";
      
      public static const SENIORMARRY_END:String = "SeniorMarryEnd";
      
      public static const WARRIORFAMRAIDPRICEPERMIN:String = "WarriorFamRaidPricePerMin";
      
      public static const YEARFOODITEMCOUNT:String = "YearFoodItemsCount";
      
      public static const YEARFOODITEMS:String = "YearFoodItems";
      
      public static const YEARFOODITEMPRICES:String = "YearFoodItemPrices";
      
      public static const MAGICSTONECOSTITEM:String = "MagicStoneCostItem";
      
      public static const WORSHIPMOONBEGINDATE:String = "WorshipMoonBeginDate";
      
      public static const WORSHIPMOONENDDATE:String = "WorshipMoonEndDate";
      
      public static const PRIVILEGE_CANBUYFERT:String = "8";
      
      public static const PRIVILEGE_LOTTERYNOTIME:String = "13";
      
      private static var privileges:Dictionary;
      
      public static const LIGHTROAD_MINLEVEL:String = "GoodsCollectMinLevel";
      
      public static const CONSORTIA_MATCH_START_TIME:String = "ConsortiaMatchStartTime";
      
      public static const CONSORTIA_MATCH_END_TIME:String = "ConsortiaMatchEndTime";
      
      public static const LOCAL_CONSORTIA_MATCH_DAYS:String = "LocalConsortiaMatchDays";
      
      public static const AREA_CONSORTIA_MATCH_DAYS:String = "AreaConsortiaMatchDays";
      
      public static const DEED_PRICES:String = "DanDanBuffPrice";
      
      public static const ISCHICKENACTIVEKEYOPEN:String = "IsChickenActiveKeyOpen";
      
      public static const CHICKENACTIVEKEYLVAWARDNEEDPRESTIGE:String = "ChickenActiveKeyLvAwardNeedPrestige";
      
      public static const EVERYDAYOPENPRICE:String = "EveryDayOpenPrice";
      
      public static const TOTEMPROPMONEYOFFSET:String = "TotemPropMoneyOffset";
      
      public static const WITCH_BLESS_GP:String = "WitchBlessGP";
      
      public static const WITCH_BLESS_DOUBLEGP_TIME:String = "WitchBlessDoubleGpTime";
      
      public static const WITCH_BLESS_MONEY:String = "WithcBlessMoney";
      
      public static const DRAGONBOAT_PROP:String = "DragonBoatProp";
      
      public static const ISBUYQUESTENERYNEEDKINGBUFF:String = "IsBuyQuestEnereyNeedKingBuff";
      
      public static const PROMOTEPACKAGEPRICE:String = "PromotePackagePrice";
      
      public static const ISPROMOTEPACKAGEOPEN:String = "IsPromotePackageOpen";
      
      public static const ISOPENWEALTHTREE:String = "IsOpenWealthTree";
      
      public static const CHRISTMAST_GIFTS_GETTIME:String = "ChristmasGiftsGetTime";
       
      
      private var _serverConfigInfoList:DictionaryData;
      
      private var _BindMoneyMax:Array;
      
      private var _VIPExtraBindMoneyUpper:Array;
      
      private var _activityEnterNum:int;
      
      private var _consortiaTaskDelayInfo:Array;
      
      private var _cryptBossOpenDay:Array;
      
      private var _dailyRewardIDForMonth:Array;
      
      private var _christmasGiftGetTime:String;
      
      private var _catchBatchOpen:DictionaryData;
      
      public function ServerConfigManager()
      {
         super();
      }
      
      public static function get instance() : ServerConfigManager
      {
         if(_instance == null)
         {
            _instance = new ServerConfigManager();
         }
         return _instance;
      }
      
      public function getserverConfigInfo(param1:ServerConfigAnalyz) : void
      {
         var _loc4_:int = 0;
         _serverConfigInfoList = param1.serverConfigInfoList;
         _BindMoneyMax = _serverConfigInfoList["BindMoneyMax"].Value.split("|");
         _VIPExtraBindMoneyUpper = _serverConfigInfoList["VIPExtraBindMoneyUpper"].Value.split("|");
         _activityEnterNum = _serverConfigInfoList["QXGameLimitCount"].Value;
         _dailyRewardIDForMonth = _serverConfigInfoList["DailyRewardIDForMonth"].Value.split("|");
         _christmasGiftGetTime = _serverConfigInfoList["ChristmasGiftsGetTime"].Value;
         _cryptBossOpenDay = _serverConfigInfoList["CryptBossOpenDay"].Value.split("|");
         var _loc2_:Array = _serverConfigInfoList["ConsortiaMissionAddTime"].Value.split("|");
         var _loc3_:int = _loc2_.length;
         _consortiaTaskDelayInfo = [];
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _consortiaTaskDelayInfo.push(_loc2_[_loc4_].split(","));
            _loc4_++;
         }
      }
      
      public function get raceDayCount() : int
      {
         return _serverConfigInfoList["RaceDayCount"].Value;
      }
      
      public function get raceMaxSorce() : int
      {
         return _serverConfigInfoList["RaceMaxSorce"].Value;
      }
      
      public function get getPrestigeTimes() : int
      {
         return _serverConfigInfoList["PrestigeTimes"].Value;
      }
      
      public function get getDayMaxAddPrestige() : int
      {
         return _serverConfigInfoList["DayMaxAddPrestige"].Value;
      }
      
      public function get lanternMaxHomeVisits() : int
      {
         return _serverConfigInfoList["LanternHomeVisits"].Value;
      }
      
      public function get buyCardSoulValueMoney() : Number
      {
         var _loc1_:ServerConfigInfo = findInfoByName("BuyCardSoulValueMoney");
         if(_loc1_)
         {
            return Number(_loc1_.Value);
         }
         return 500;
      }
      
      public function get lanternMaxHomeVisited() : int
      {
         return _serverConfigInfoList["LanternHomeVisited"].Value;
      }
      
      public function getNeedUseLotteryKicket(param1:int) : int
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(_serverConfigInfoList.hasKey("TurnTableCostCountByLevel"))
         {
            _loc3_ = _serverConfigInfoList["TurnTableCostCountByLevel"].Value;
            _loc2_ = _loc3_.split("|");
            if(_loc2_.length == 4 && param1 <= 3)
            {
               return _loc2_[param1];
            }
            return _loc2_[_loc2_.length - 1];
         }
         return 6;
      }
      
      public function get lanternCookLanternGold() : int
      {
         return _serverConfigInfoList["CookLanternGold"].Value;
      }
      
      public function get serverConfigInfo() : DictionaryData
      {
         return _serverConfigInfoList;
      }
      
      public function get LightRiddleAnswerTime() : Number
      {
         return _serverConfigInfoList["LightRiddleAnswerTime"].Value;
      }
      
      public function get YearMonsterBeginDate() : String
      {
         return _serverConfigInfoList["YearMonsterBeginDate"].Value;
      }
      
      public function get YearMonsterEndDate() : String
      {
         return _serverConfigInfoList["YearMonsterEndDate"].Value;
      }
      
      public function get YearMonsterBuyTimes() : int
      {
         return int(_serverConfigInfoList["YearMonsterBuyTimes"].Value);
      }
      
      public function get YearMonsterBuyPrice() : Array
      {
         return _serverConfigInfoList["YearMonsterBuyPrice"].Value.split("|");
      }
      
      public function get consortiaTaskDelayInfo() : Array
      {
         return _consortiaTaskDelayInfo;
      }
      
      public function get cryptBossOpenDay() : Array
      {
         return _cryptBossOpenDay;
      }
      
      public function getBindBidLimit(param1:int, param2:int = 0) : int
      {
         var _loc4_:int = param1 % 10 == 0?int(_BindMoneyMax[int(param1 / 10) - 1]):int(_BindMoneyMax[int(param1 / 10)]);
         var _loc3_:int = 0;
         if(PlayerManager.Instance.Self.IsVIP && param2 > 0)
         {
            _loc3_ = _VIPExtraBindMoneyUpper[param2 - 1];
         }
         return _loc4_ + _loc3_;
      }
      
      public function get PayAimEnergy() : int
      {
         return int(findInfoByName("PayAimEnergy").Value);
      }
      
      public function get VIPPayAimEnergy() : Array
      {
         var _loc1_:Array = findInfoByName("VIPPayAimEnergy").Value.split("|");
         return _loc1_;
      }
      
      public function get weddingMoney() : Array
      {
         return findInfoByName("MarryRoomCreateMoney").Value.split(",");
      }
      
      public function get MissionRiches() : Array
      {
         return findInfoByName("MissionRiches").Value.split("|");
      }
      
      public function get VIPExpNeededForEachLv() : Array
      {
         return findInfoByName("VIPExpForEachLv").Value.split("|");
      }
      
      public function get CardRestSoulValue() : String
      {
         return findInfoByName("CardResetSoulValue").Value;
      }
      
      public function get cardResetCardSoulMoney() : String
      {
         return findInfoByName("CardGrooveRevert").Value;
      }
      
      public function get VIPExtraBindMoneyUpper() : Array
      {
         return findInfoByName("VIPExtraBindMoneyUpper").Value.split("|");
      }
      
      public function get HotSpringExp() : Array
      {
         return findInfoByName("HotSpringExp").Value.split(",");
      }
      
      public function findInfoByName(param1:String) : ServerConfigInfo
      {
         return _serverConfigInfoList[param1];
      }
      
      public function get VIPStrengthenEx() : Array
      {
         var _loc1_:Object = findInfoByName("VIPStrengthenEx");
         if(_loc1_)
         {
            return findInfoByName("VIPStrengthenEx").Value.split("|");
         }
         return null;
      }
      
      public function ConsortiaStrengthenEx() : Array
      {
         var _loc1_:Object = findInfoByName("ConsortiaStrengthenEx");
         if(_loc1_)
         {
            return findInfoByName("ConsortiaStrengthenEx").Value.split("|");
         }
         return null;
      }
      
      public function get RouletteMaxTicket() : String
      {
         return findInfoByName("AwardMaxMoney").Value;
      }
      
      public function get VIPRenewalPrice() : Array
      {
         var _loc1_:Object = findInfoByName("VIPRenewalPrize");
         if(_loc1_)
         {
            return String(_loc1_.Value).split("|");
         }
         return null;
      }
      
      public function get VIPRateForGP() : Array
      {
         var _loc1_:Object = findInfoByName("VIPRateForGP");
         if(_loc1_)
         {
            return String(_loc1_.Value).split("|");
         }
         return null;
      }
      
      public function get VIPQuestStar() : Array
      {
         var _loc1_:Object = findInfoByName("VIPQuestStar");
         if(_loc1_)
         {
            return String(_loc1_.Value).split("|");
         }
         return null;
      }
      
      public function get VIPLotteryCountMaxPerDay() : Array
      {
         var _loc1_:Object = findInfoByName("VIPLotteryCountMaxPerDay");
         if(_loc1_)
         {
            return String(_loc1_.Value).split("|");
         }
         return null;
      }
      
      public function get VIPTakeCardDisCount() : Array
      {
         var _loc1_:Object = findInfoByName("VIPTakeCardDisCount");
         if(_loc1_)
         {
            return String(_loc1_.Value).split("|");
         }
         return null;
      }
      
      public function get VIPQuestFinishDirect() : Array
      {
         return analyzeData("VIPQuestFinishDirect");
      }
      
      public function analyzeData(param1:String) : Array
      {
         var _loc2_:Object = findInfoByName(param1);
         if(_loc2_)
         {
            return String(_loc2_.Value).split("|");
         }
         return null;
      }
      
      public function getPrivilegeString(param1:int) : String
      {
         var _loc2_:Object = findInfoByName("VIPPrivilege");
         if(_loc2_)
         {
            return String(_loc2_.Value);
         }
         return null;
      }
      
      public function get VIPDailyPack() : Array
      {
         return findInfoByName("VIPDailyPackID").Value.split("|");
      }
      
      public function get VIPRewardCryptCount() : Vector.<String>
      {
         var _loc1_:Vector.<String> = Vector.<String>(findInfoByName("VIPRewardCryptCount").Value.split("|"));
         return _loc1_;
      }
      
      public function getPrivilegeMinLevel(param1:String) : int
      {
         var _loc6_:* = null;
         var _loc2_:int = 0;
         var _loc4_:* = null;
         if(privileges == null)
         {
            _loc6_ = findInfoByName("VIPPrivilege");
            _loc2_ = 1;
            _loc4_ = String(_loc6_.Value).split("|");
            privileges = new Dictionary();
            var _loc10_:int = 0;
            var _loc9_:* = _loc4_;
            for each(var _loc3_ in _loc4_)
            {
               var _loc8_:int = 0;
               var _loc7_:* = _loc3_.split(",");
               for each(var _loc5_ in _loc3_.split(","))
               {
                  privileges[_loc5_] = _loc2_;
               }
               _loc2_++;
            }
         }
         return int(privileges[param1]);
      }
      
      public function getBeadUpgradeExp() : DictionaryData
      {
         var _loc2_:DictionaryData = new DictionaryData();
         var _loc4_:Array = findInfoByName("RuneLevelUpExp").Value.split("|");
         var _loc3_:int = 1;
         var _loc6_:int = 0;
         var _loc5_:* = _loc4_;
         for each(var _loc1_ in _loc4_)
         {
            _loc2_.add(_loc3_,_loc1_);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getRequestBeadPrice() : Array
      {
         return findInfoByName("OpenRunePackageMoney").Value.split("|");
      }
      
      public function getBeadHoleUpExp() : Array
      {
         return findInfoByName("HoleLevelUpExpList").Value.split("|");
      }
      
      public function get minOpenPetSystemLevel() : int
      {
         var _loc1_:Object = findInfoByName("PlayerMinLevel");
         return int(_loc1_.Value);
      }
      
      public function get activityEnterNum() : int
      {
         return _activityEnterNum;
      }
      
      public function get dailyRewardIDForMonth() : Array
      {
         return _dailyRewardIDForMonth;
      }
      
      public function get christmasGiftGetTime() : String
      {
         return _christmasGiftGetTime;
      }
      
      public function getDragonBoatBuildStage(param1:int) : Array
      {
         return findInfoByName("DragonBoatBuildStage" + param1).Value.split("|");
      }
      
      public function get dragonBoatFastTime() : int
      {
         return int(findInfoByName("DragonBoatFastTime").Value);
      }
      
      public function get ddtKingFloatFastTime() : int
      {
         return int(findInfoByName("TankMatchFastTime").Value);
      }
      
      public function get magpieBridgeCountPrice() : int
      {
         return int(findInfoByName("TanabataActivePrice").Value);
      }
      
      public function get searchGoodsRewardID() : Array
      {
         return _serverConfigInfoList["SearchGoodsRewardID"].Value.split(",");
      }
      
      public function get searchGoodsRewardTimes() : Array
      {
         return _serverConfigInfoList["SearchGoodsRewardTimes"].Value.split(",");
      }
      
      public function get rescueShopItemPrice() : Array
      {
         return findInfoByName("HelpGameBuffPrice").Value.split("|");
      }
      
      public function get rescueCleanCDPrice() : Array
      {
         return findInfoByName("HelpGameCleanCDPrice").Value.split("|");
      }
      
      public function get catchInsectBeginTime() : String
      {
         return _serverConfigInfoList["SummerAcitveBeginTime"].Value;
      }
      
      public function get catchInsectEndTime() : String
      {
         return _serverConfigInfoList["SummerAcitveEndTime"].Value;
      }
      
      public function get catchInsectPrizeInfo() : Array
      {
         return _serverConfigInfoList["SummerAcitveGifts"].Value.split("|");
      }
      
      public function get catchInsectLocalTitle() : Array
      {
         return _serverConfigInfoList["SummerAcitveTitle"].Value.split("|");
      }
      
      public function get catchInsectAreaTitle() : Array
      {
         return _serverConfigInfoList["AreaSummerAcitveTitle"].Value.split("|");
      }
      
      public function get nationalDayDropBeginDate() : String
      {
         return _serverConfigInfoList["NationalDayDropBeginDate"].Value.split("|");
      }
      
      public function get pyramidTopMinMaxPoint() : Array
      {
         var _loc1_:* = null;
         var _loc2_:ServerConfigInfo = findInfoByName("PyramidTopPoint");
         if(_loc2_)
         {
            _loc1_ = _loc2_.Value.split("|");
            return new Array(_loc1_[0],_loc1_[_loc1_.length - 1]);
         }
         return new Array(0,0);
      }
      
      public function get sevendayProgressGift() : Array
      {
         var _loc2_:ServerConfigInfo = findInfoByName("SevenDayTargetReward");
         var _loc1_:Array = _loc2_.Value.split("|");
         return _loc1_;
      }
      
      public function get nationalDayDropEndDate() : String
      {
         return _serverConfigInfoList["NationalDayDropEndDate"].Value.split("|");
      }
      
      public function get CookPanaxEndDate() : String
      {
         return _serverConfigInfoList["CookPanaxEndDate"].Value.split("|");
      }
      
      public function get CookPanaxBeginDate() : String
      {
         return _serverConfigInfoList["CookPanaxBeginDate"].Value.split("|");
      }
      
      public function SanXiaoChangeColorScore() : String
      {
         return _serverConfigInfoList["ThreeClearColourChangePoint"].Value;
      }
      
      public function SanXiaoChangeColorPrice() : String
      {
         return _serverConfigInfoList["ThreeClearColourChangeCost"].Value;
      }
      
      public function SanXiaoCrossBombScore() : String
      {
         return _serverConfigInfoList["ThreeClearCrossPoint"].Value;
      }
      
      public function SanXiaoCrossBombPrice() : String
      {
         return _serverConfigInfoList["ThreeClearCrossCost"].Value;
      }
      
      public function SanXiaoSquareBombScore() : String
      {
         return _serverConfigInfoList["ThreeClearRectPoint"].Value;
      }
      
      public function SanXiaoSquareBombPrice() : String
      {
         return _serverConfigInfoList["ThreeClearRectCost"].Value;
      }
      
      public function SanXiaoClearColorScore() : String
      {
         return _serverConfigInfoList["ThreeClearColourCleanPoint"].Value;
      }
      
      public function SanXiaoClearColorPrice() : String
      {
         return _serverConfigInfoList["ThreeClearColourCleanCost"].Value;
      }
      
      public function get halloweenBeginDate() : String
      {
         return _serverConfigInfoList["HalloweenBeginDate"].Value.split("|");
      }
      
      public function get halloweenEndDate() : String
      {
         return _serverConfigInfoList["HalloweenEndDate"].Value.split("|");
      }
      
      public function get depotBuyMoney() : Array
      {
         var _loc1_:ServerConfigInfo = findInfoByName("DepotBuyMoney");
         if(_loc1_)
         {
            return _loc1_.Value.split(",");
         }
         return null;
      }
      
      public function get levelFundPrice() : Array
      {
         var _loc1_:ServerConfigInfo = findInfoByName("DDFundPrice");
         if(_loc1_)
         {
            return _loc1_.Value.split(",");
         }
         return null;
      }
      
      public function get homeFightBoxIDList() : Array
      {
         var _loc1_:ServerConfigInfo = findInfoByName("HomeTDHomeBoxID");
         if(_loc1_)
         {
            return _loc1_.Value.split(",");
         }
         return null;
      }
      
      public function get homeFightSkillPrice() : Array
      {
         var _loc1_:ServerConfigInfo = findInfoByName("HomeTDSkillPrice");
         if(_loc1_)
         {
            return _loc1_.Value.split(",");
         }
         return null;
      }
      
      public function entertainmentScore() : Array
      {
         var _loc2_:ServerConfigInfo = findInfoByName("EntertainmentScore");
         var _loc1_:Array = _loc2_.Value.split(",");
         return _loc1_;
      }
      
      public function entertainmentPrice() : int
      {
         var _loc1_:ServerConfigInfo = findInfoByName("RecreationPvpRefreshPropBindMoney");
         if(_loc1_)
         {
            return int(_loc1_.Value);
         }
         return 0;
      }
      
      public function entertainmentLevel() : int
      {
         return int(findInfoByName("RecreationPvpMinLevel").Value);
      }
      
      public function get homeFightSkillEffect() : Array
      {
         var _loc1_:ServerConfigInfo = findInfoByName("HomeTDSkillEffect");
         if(_loc1_)
         {
            return _loc1_.Value.split(",");
         }
         return null;
      }
      
      public function get homeFightRevivePrice() : int
      {
         return int(findInfoByName("HomeTDRevivePrice").Value);
      }
      
      public function get homeFightLvLimit() : int
      {
         return int(findInfoByName("HomeLvLimit").Value);
      }
      
      public function get homeFightBlood() : String
      {
         return findInfoByName("HomeTDHomeBlood").Value;
      }
      
      public function get callScoreLimit() : String
      {
         return findInfoByName("CallScoreLimit").Value;
      }
      
      public function get oldPlayerShopBuyLimit() : String
      {
         return findInfoByName("OldPlayerShopBuyLimit").Value;
      }
      
      public function get dailyRewardIDList() : Array
      {
         return _serverConfigInfoList["CurrDailyRewardID"].Value.split("|");
      }
      
      public function get homeBarCleanCDPrice() : int
      {
         var _loc1_:ServerConfigInfo = findInfoByName("HomeBarCleanCDPrice");
         if(_loc1_)
         {
            return int(_loc1_.Value);
         }
         return 0;
      }
      
      public function getHouseExtendNeed(param1:int) : Array
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:ServerConfigInfo = findInfoByName("HouseUpgradeUse");
         var _loc2_:Array = _loc3_.Value.split("|");
         _loc5_ = 0;
         while(_loc5_ <= _loc2_.length - 1)
         {
            _loc4_ = _loc2_[_loc5_].split(",");
            if(parseInt(_loc4_[0]) == param1)
            {
               return _loc4_;
            }
            _loc5_++;
         }
         return [];
      }
      
      public function getWishingTreeDisplayRewards() : Array
      {
         return _serverConfigInfoList["WishTreeRewardInfo"].Value.split("|");
      }
      
      public function getWishingTreeAccRewards() : Array
      {
         return _serverConfigInfoList["WishTreeReward"].Value.split("|");
      }
      
      public function getWishingTreeEndDate() : String
      {
         return _serverConfigInfoList["WishTreeEndDate"].Value;
      }
      
      public function yearMonsterBeginDate() : Date
      {
         var _loc1_:String = _serverConfigInfoList["YearMonsterBeginDate"].Value;
         return DateUtils.getDateByStr(_loc1_);
      }
      
      public function yearMonsterEndDate() : Date
      {
         var _loc1_:String = _serverConfigInfoList["YearMonsterEndDate"].Value;
         return DateUtils.getDateByStr(_loc1_);
      }
      
      public function rescueSpringBegin() : Date
      {
         var _loc1_:String = _serverConfigInfoList["HelpGameSpringBegin"].Value;
         return DateUtils.getDateByStr(_loc1_);
      }
      
      public function getSeniorMarryMoney(param1:Boolean) : Array
      {
         if(param1)
         {
            return _serverConfigInfoList["SeniorMarryActivePrice"].Value.split(",");
         }
         return _serverConfigInfoList["SeniorMarryMoney"].Value.split(",");
      }
      
      public function getSeniorMarryGift() : Array
      {
         return _serverConfigInfoList["SeniorMarryGift"].Value.split(",");
      }
      
      public function getBattleSkillDefaultActivate() : Array
      {
         return _serverConfigInfoList["FairBattleDefaultActivateSkill"].Value.split("|");
      }
      
      public function getChristmasGiftsGetTime() : Array
      {
         var _loc2_:String = _serverConfigInfoList["ChristmasGiftsGetTime"].Value;
         var _loc1_:Date = DateUtils.getDateByStr(_loc2_);
         return [_loc1_.hours,_loc1_.minutes];
      }
      
      public function getSeniorMarryBegin() : Date
      {
         var _loc1_:String = _serverConfigInfoList["SeniorMarryBegin"].Value;
         return DateUtils.getDateByStr(_loc1_);
      }
      
      public function getSeniorMarryEnd() : Date
      {
         var _loc1_:String = _serverConfigInfoList["SeniorMarryEnd"].Value;
         return DateUtils.getDateByStr(_loc1_);
      }
      
      public function get AuctionRate() : String
      {
         return String(findInfoByName("Cess").Value * 100);
      }
      
      public function getDesertFreeEnterCount() : int
      {
         var _loc1_:int = _serverConfigInfoList["DesertFreeEnterCount"].Value;
         return _loc1_;
      }
      
      public function getDesertFeeEnterCount() : int
      {
         var _loc1_:int = _serverConfigInfoList["DesertFeeEnterCount"].Value;
         return _loc1_;
      }
      
      public function getMagicHighFamMaxLevel() : int
      {
         var _loc1_:int = _serverConfigInfoList["WarriorHighFamMaxLevel"].Value;
         return _loc1_;
      }
      
      public function get firstDivorcedMoney() : String
      {
         return findInfoByName("DivorcedDiscountMoney").Value;
      }
      
      public function getWarriorHighFamMaxLevel() : int
      {
         var _loc1_:int = _serverConfigInfoList["WarriorFamMaxLevel"].Value;
         return _loc1_;
      }
      
      public function getVipIntegral() : Array
      {
         return _serverConfigInfoList["ShopVipScore"].Value.split("|");
      }
      
      public function get CreateGuild() : int
      {
         return 50000;
      }
      
      public function getHappyRechargeSpecialItemCount() : Array
      {
         return _serverConfigInfoList["HappyChargeItemPercent"].Value.split("|");
      }
      
      public function memoryGameCardMoney() : int
      {
         return _serverConfigInfoList["PairUpCardCost"].Value;
      }
      
      public function memoryGameResetMoney() : int
      {
         return _serverConfigInfoList["PairUpResetCost"].Value;
      }
      
      public function get highCardResetSoulValue() : String
      {
         if(_serverConfigInfoList["HighCardResetSoulValue"])
         {
            return _serverConfigInfoList["HighCardResetSoulValue"].Value;
         }
         return "0";
      }
      
      public function get cardLockAttrMoney() : Array
      {
         if(_serverConfigInfoList["CardLockAttrMoney"])
         {
            return _serverConfigInfoList["CardLockAttrMoney"].Value.split("|");
         }
         return [0,0,0];
      }
      
      public function get BombFixGamePerScore() : int
      {
         if(_serverConfigInfoList["BombFixGamePerBombScore"])
         {
            return int(_serverConfigInfoList["BombFixGamePerBombScore"].Value);
         }
         return 10;
      }
      
      public function get BombRandomGamePerScore() : int
      {
         if(_serverConfigInfoList["BombRandomGamePerBombScore"])
         {
            return int(_serverConfigInfoList["BombRandomGamePerBombScore"].Value);
         }
         return 10;
      }
      
      public function get BombFixGamePerBombCountAddCount() : int
      {
         if(_serverConfigInfoList["BombFixGamePerBombCountAddCount"])
         {
            return int(_serverConfigInfoList["BombFixGamePerBombCountAddCount"].Value);
         }
         return 4;
      }
      
      public function get BombRandomGamePerBombCountAddCount() : int
      {
         if(_serverConfigInfoList["BombRandomGamePerBombCountAddCount"])
         {
            return int(_serverConfigInfoList["BombRandomGamePerBombCountAddCount"].Value);
         }
         return 4;
      }
      
      public function get addPlayerDressModel() : Array
      {
         var _loc3_:int = 0;
         var _loc2_:ServerConfigInfo = findInfoByName("BuyClothGroupCost");
         var _loc1_:Array = [];
         if(_loc2_)
         {
            _loc3_ = 0;
            while(_loc3_ < 3)
            {
               _loc1_[_loc2_.Value.split("|")[_loc3_].split(",")[0]] = _loc2_.Value.split("|")[_loc3_].split(",")[1];
               _loc3_++;
            }
         }
         return _loc1_;
      }
      
      public function get HappyLittleGameOpenList() : String
      {
         if(_serverConfigInfoList["LittleGameSwitch"])
         {
            return String(_serverConfigInfoList["LittleGameSwitch"].Value);
         }
         return "";
      }
      
      public function get BombGameDoubleScoreBeginCount() : int
      {
         if(_serverConfigInfoList["BombGameDoubleScoreBeginCount"])
         {
            return int(_serverConfigInfoList["BombGameDoubleScoreBeginCount"].Value);
         }
         return 20;
      }
      
      public function get BombGameDoubleScoreKeepCount() : int
      {
         if(_serverConfigInfoList["BombGameDoubleScoreKeepCount"])
         {
            return int(_serverConfigInfoList["BombGameDoubleScoreKeepCount"].Value);
         }
         return 5;
      }
      
      public function get godCardDailyFreeCount() : int
      {
         if(_serverConfigInfoList["GodCardDailyFreeCount"])
         {
            return int(_serverConfigInfoList["GodCardDailyFreeCount"].Value);
         }
         return 0;
      }
      
      public function get godCardOpenOneTimeMoney() : int
      {
         if(_serverConfigInfoList["GodCardOpenOneTimeMoney"])
         {
            return int(_serverConfigInfoList["GodCardOpenOneTimeMoney"].Value);
         }
         return 0;
      }
      
      public function get divorcedMoney() : String
      {
         return findInfoByName("DivorcedMoney").Value;
      }
      
      public function getTimeControl() : Array
      {
         var _loc2_:ServerConfigInfo = findInfoByName("DiffDimensionTimeControl");
         var _loc1_:Array = _loc2_.Value.split("|");
         return _loc1_;
      }
      
      public function getSpaceControl() : Array
      {
         var _loc2_:ServerConfigInfo = findInfoByName("DiffDimensionSpaceControl");
         var _loc1_:Array = _loc2_.Value.split("|");
         return _loc1_;
      }
      
      public function getLootControl() : Array
      {
         var _loc2_:ServerConfigInfo = findInfoByName("DiffDimensionLootControl");
         var _loc1_:Array = _loc2_.Value.split("|");
         return _loc1_;
      }
      
      public function getLevelUpItemID() : int
      {
         var _loc1_:ServerConfigInfo = findInfoByName("DiffDimensionLevelUpItemID");
         if(_loc1_)
         {
            return int(_loc1_.Value);
         }
         return 0;
      }
      
      public function getSearchPrice() : int
      {
         var _loc1_:ServerConfigInfo = findInfoByName("DiffDimensionRefreshPrice");
         if(_loc1_)
         {
            return int(_loc1_.Value);
         }
         return 0;
      }
      
      public function get godCardOpenFiveTimeMoney() : int
      {
         if(_serverConfigInfoList["GodCardOpenFiveTimeMoney"])
         {
            return int(_serverConfigInfoList["GodCardOpenFiveTimeMoney"].Value);
         }
         return 0;
      }
      
      public function get petDisappearPlaycount() : Array
      {
         var _loc2_:ServerConfigInfo = findInfoByName("PetDisappearPlayCount");
         var _loc1_:Array = _loc2_.Value.split("|");
         return _loc1_;
      }
      
      public function get petDisappearPlaySoncount() : Array
      {
         var _loc2_:ServerConfigInfo = findInfoByName("PetDisappearPlaySonCount");
         var _loc1_:Array = _loc2_.Value.split("|");
         return _loc1_;
      }
      
      public function get petDisappearPlayerBlood() : Array
      {
         var _loc2_:ServerConfigInfo = findInfoByName("PetDisappearUserBlood");
         var _loc1_:Array = _loc2_.Value.split("|");
         return _loc1_;
      }
      
      public function get petDisappearNPCBlood() : Array
      {
         var _loc2_:ServerConfigInfo = findInfoByName("PetDisappearNPCBlood");
         var _loc1_:Array = _loc2_.Value.split("|");
         return _loc1_;
      }
      
      public function get petDisappearRecoverPrice() : int
      {
         return _serverConfigInfoList["PetDisappearRecoverPrice"].Value;
      }
      
      public function get petDisappearSkillMoney() : Array
      {
         var _loc2_:ServerConfigInfo = findInfoByName("PetDisappearSkillMoney");
         var _loc1_:Array = _loc2_.Value.split("|");
         return _loc1_;
      }
      
      public function get petDisappearSkillMaxTimes() : int
      {
         return _serverConfigInfoList["PetDisappearSkillMaxTimes"].Value;
      }
      
      public function get petDisappearSkillTwoMaxTimes() : int
      {
         return _serverConfigInfoList["PetDisappearSkillTwoMaxTimes"].Value;
      }
      
      public function get petDisappearSkillTwoMoney() : Array
      {
         var _loc2_:ServerConfigInfo = findInfoByName("PetDisappearSkillTwoMoney");
         var _loc1_:Array = _loc2_.Value.split("|");
         return _loc1_;
      }
      
      public function get HorseGameEachDayMaxCount() : int
      {
         return _serverConfigInfoList["HorseGameEachDayMaxCount"].Value;
      }
      
      public function get HorseGameUsePapawMoney() : int
      {
         return _serverConfigInfoList["HorseGameUsePapawMoney"].Value;
      }
      
      public function get HorseGameCostMoneyCount() : int
      {
         return _serverConfigInfoList["HorseGameCostMoneyCount"].Value;
      }
      
      public function get horseGameBuffConfig() : Array
      {
         var _loc2_:ServerConfigInfo = findInfoByName("HorseGameBuffConfig");
         var _loc1_:Array = _loc2_.Value.split("|");
         return _loc1_;
      }
      
      public function get petDisappearMaxLevel() : int
      {
         return _serverConfigInfoList["PetDisappearMaxLevel"].Value;
      }
      
      public function get petDisappearAddScore() : int
      {
         return _serverConfigInfoList["PetDisappearAddScore"].Value;
      }
      
      public function get petDisappearMinLevel() : int
      {
         return _serverConfigInfoList["PetDisappearMinLevel"].Value;
      }
      
      public function get prayActivityConfig() : Array
      {
         var _loc1_:Array = findInfoByName("PrayGoodsActivityConfig").Value.split("|");
         return _loc1_;
      }
      
      public function get kingBuffPrice() : String
      {
         return String(findInfoByName("KingBuffPrice").Value);
      }
      
      public function get kingBuffPriceDiscount() : String
      {
         return String(findInfoByName("KingBuffPriceDiscount").Value);
      }
      
      public function get localYearFoodItemsCount() : Array
      {
         var _loc2_:ServerConfigInfo = findInfoByName("YearFoodItemsCount");
         var _loc1_:Array = _loc2_.Value.split("|");
         return _loc1_;
      }
      
      public function get localYearFoodItems() : Array
      {
         var _loc2_:ServerConfigInfo = findInfoByName("YearFoodItems");
         var _loc1_:Array = _loc2_.Value.split(",");
         return _loc1_;
      }
      
      public function get cityOccupationAddPrice() : Array
      {
         var _loc2_:ServerConfigInfo = findInfoByName("CityOccupationAddPrice");
         var _loc1_:Array = _loc2_.Value.split("|");
         return _loc1_;
      }
      
      public function get cityOccupationStartDate() : String
      {
         return findInfoByName("CityOccupationStartDate").Value;
      }
      
      public function get cityOccupationEndDate() : String
      {
         return findInfoByName("CityOccupationEndDate").Value;
      }
      
      public function get localYearFoodItemsPrices() : Array
      {
         var _loc2_:ServerConfigInfo = findInfoByName("YearFoodItemPrices");
         var _loc1_:Array = _loc2_.Value.split(",");
         return _loc1_;
      }
      
      public function get getLightRiddleIsNew() : Boolean
      {
         var _loc1_:ServerConfigInfo = findInfoByName("LightRiddleIsNew");
         if(_loc1_)
         {
            return _loc1_.Value.toLowerCase() != "false";
         }
         return false;
      }
      
      public function get getIsBuyQuestEnereyNeedKingBuff() : Boolean
      {
         var _loc1_:ServerConfigInfo = findInfoByName("IsBuyQuestEnereyNeedKingBuff");
         if(_loc1_)
         {
            return _loc1_.Value.toLowerCase() != "false";
         }
         return false;
      }
      
      public function getDDTKingQuizPrize() : int
      {
         var _loc1_:ServerConfigInfo = findInfoByName("DDTKingQuizPrize");
         if(_loc1_)
         {
            return int(_loc1_.Value);
         }
         return 100;
      }
      
      public function getDDTKingQuizCityList() : String
      {
         var _loc1_:ServerConfigInfo = findInfoByName("DDTKingQuizCityList");
         if(_loc1_)
         {
            return _loc1_.Value;
         }
         return "1|2|3|4|5|6|7|8";
      }
      
      public function getDDTKingQuizPersonMaxCount() : String
      {
         var _loc1_:ServerConfigInfo = findInfoByName("DDTKingQuizPersonMaxCount");
         if(_loc1_)
         {
            return _loc1_.Value;
         }
         return "1000|500|200|100";
      }
      
      public function getDDTKingQuizTeamMaxCount() : String
      {
         var _loc1_:ServerConfigInfo = findInfoByName("DDTKingQuizTeamMaxCount");
         if(_loc1_)
         {
            return _loc1_.Value;
         }
         return "1000|500|200|100";
      }
      
      public function getTwoColorBallBeginTime() : String
      {
         return _serverConfigInfoList["TwoColorBallBeginTime"].Value.split(" ")[0];
      }
      
      public function getTwoColorBallEndTime() : String
      {
         return _serverConfigInfoList["TwoColorBallEndTime"].Value.split(" ")[0];
      }
      
      public function getFairBattleScoreEndTime() : String
      {
         return _serverConfigInfoList["FairBattleScoreEndTime"].Value;
      }
      
      public function getFairBattleScoreBeginTime() : String
      {
         return _serverConfigInfoList["FairBattleScoreBeginTime"].Value;
      }
      
      public function getDDTKingQuizCanJoinEndTime() : String
      {
         return _serverConfigInfoList["DDTKingQuizCanJoinEndTime"].Value;
      }
      
      public function getDDTKingQuizCanJoinBeginTime() : String
      {
         return _serverConfigInfoList["DDTKingQuizCanJoinBeginTime"].Value;
      }
      
      public function getSysRedEnvelopePublishInfo() : String
      {
         return _serverConfigInfoList["SysRedEnvelopePublishInfo"].Value;
      }
      
      public function getDDTKingQuizEndTime() : String
      {
         return _serverConfigInfoList["DDTKingQuizEndTime"].Value;
      }
      
      public function getDDTKingQuizBeginTime() : String
      {
         return _serverConfigInfoList["DDTKingQuizBeginTime"].Value;
      }
      
      public function getRedEnvelopeEndTime() : String
      {
         return _serverConfigInfoList["RedEnvelopeEndTime"].Value;
      }
      
      public function getRedEnvelopeBeginTime() : String
      {
         return _serverConfigInfoList["RedEnvelopeBeginTime"].Value;
      }
      
      public function getLightRiddleRemoveErrorMoney() : int
      {
         var _loc1_:ServerConfigInfo = findInfoByName("LightRiddleRemoveErrorMoney");
         if(_loc1_)
         {
            return int(_loc1_.Value);
         }
         return 0;
      }
      
      public function getDDTKingQuizLostID() : int
      {
         var _loc1_:ServerConfigInfo = findInfoByName("DDTKingQuizLostID");
         if(_loc1_)
         {
            return int(_loc1_.Value);
         }
         return 0;
      }
      
      public function getDDTKingQuizWinID() : int
      {
         var _loc1_:ServerConfigInfo = findInfoByName("DDTKingQuizWinID");
         if(_loc1_)
         {
            return int(_loc1_.Value);
         }
         return 0;
      }
      
      public function get magicStoneCostItemNum() : int
      {
         var _loc1_:Object = findInfoByName("MagicStoneCostItem");
         return int(_loc1_.Value);
      }
      
      public function get consortiaMatchStartTime() : Array
      {
         var _loc2_:ServerConfigInfo = findInfoByName("ConsortiaMatchStartTime");
         var _loc1_:Array = _loc2_.Value.split(" ")[1].toString().split(":");
         return _loc1_;
      }
      
      public function get consortiaMatchEndTime() : Array
      {
         var _loc2_:ServerConfigInfo = findInfoByName("ConsortiaMatchEndTime");
         var _loc1_:Array = _loc2_.Value.split(" ")[1].toString().split(":");
         return _loc1_;
      }
      
      public function get localConsortiaMatchDays() : Array
      {
         var _loc2_:ServerConfigInfo = findInfoByName("LocalConsortiaMatchDays");
         var _loc1_:Array = _loc2_.Value.split("|");
         return _loc1_;
      }
      
      public function get areaConsortiaMatchDays() : Array
      {
         var _loc2_:ServerConfigInfo = findInfoByName("AreaConsortiaMatchDays");
         var _loc1_:Array = _loc2_.Value.split("|");
         return _loc1_;
      }
      
      public function get getDeedPrices() : Array
      {
         var _loc1_:ServerConfigInfo = findInfoByName("DanDanBuffPrice");
         if(_loc1_)
         {
            return _loc1_.Value.split(",");
         }
         return [100];
      }
      
      public function get worshipMoonBeginDate() : String
      {
         return findInfoByName("WorshipMoonBeginDate").Value;
      }
      
      public function get worshipMoonEndDate() : String
      {
         return findInfoByName("WorshipMoonEndDate").Value;
      }
      
      public function get chickActivationIsOpen() : Boolean
      {
         var _loc1_:ServerConfigInfo = findInfoByName("IsChickenActiveKeyOpen");
         if(_loc1_)
         {
            return _loc1_.Value.toLowerCase() == "true";
         }
         return false;
      }
      
      public function get chickenActiveKeyLvAwardNeedPrestige() : Array
      {
         var _loc1_:ServerConfigInfo = findInfoByName("ChickenActiveKeyLvAwardNeedPrestige");
         if(_loc1_)
         {
            return _loc1_.Value.split("|");
         }
         return null;
      }
      
      public function getToyMachinePrice() : Array
      {
         return _serverConfigInfoList["ToyMachinePrice"].Value.split("|");
      }
      
      public function getRedEnvelopeCount(param1:int) : int
      {
         var _loc2_:Array = _serverConfigInfoList["HongBaoCount"].Value.split("|");
         return parseInt(_loc2_[param1 - 1]);
      }
      
      public function get getEveryDayOpenPrice() : Array
      {
         var _loc1_:ServerConfigInfo = findInfoByName("EveryDayOpenPrice");
         if(_loc1_)
         {
            return _loc1_.Value.split("|");
         }
         return [];
      }
      
      public function get magicHouseJuniorAddAttribute() : Array
      {
         return _serverConfigInfoList["MagicRoomJuniorAddAttribute"].Value.split("|");
      }
      
      public function get magicHouseMidAddAttribute() : Array
      {
         return _serverConfigInfoList["MagicRoomMidAddAttribute"].Value.split("|");
      }
      
      public function get magicHouseSeniorAddAttribute() : Array
      {
         return _serverConfigInfoList["MagicRoomSeniorAddAttribute"].Value.split("|");
      }
      
      public function get magicHouseJuniorWeaponList() : Array
      {
         return _serverConfigInfoList["MagicRoomJuniorWeaponList"].Value.split("|");
      }
      
      public function get magicHouseMidWeaponList() : Array
      {
         return _serverConfigInfoList["MagicRoomMidWeaponList"].Value.split("|");
      }
      
      public function get magicHouseSeniorWeaponList() : Array
      {
         return _serverConfigInfoList["MagicRoomSeniorWeaponList"].Value.split("|");
      }
      
      public function get magicHouseBoxNeedMonry() : int
      {
         return _serverConfigInfoList["MagicRoomBoxNeedMoney"].Value;
      }
      
      public function get magicHouseOpenDepotNeedMoney() : int
      {
         return _serverConfigInfoList["MagicRoomOpenNeedMoney"].Value.split("|")[0];
      }
      
      public function get magicHouseDepotPromoteNeedMoney() : int
      {
         return _serverConfigInfoList["MagicRoomOpenNeedMoney"].Value.split("|")[1];
      }
      
      public function get magicHouseLevelUpNumber() : Array
      {
         return _serverConfigInfoList["MagicRoomLevelUpCount"].Value.split("|");
      }
      
      public function get zodiacAddPrice() : int
      {
         return _serverConfigInfoList["ConstellationExtraSpendMoney"].Value;
      }
      
      public function firstSeniorMarryMoney() : String
      {
         return findInfoByName("SeniorMarryMoney").Value;
      }
      
      public function get totemSignDiscount() : Number
      {
         var _loc1_:ServerConfigInfo = findInfoByName("TotemPropMoneyOffset");
         if(_loc1_)
         {
            return Number(_loc1_.Value);
         }
         return 40;
      }
      
      public function get getWitchBlessItemId() : String
      {
         return findInfoByName("WitchBlessTemplateId").Value;
      }
      
      public function get getWitchBlessDoubleGpTime() : String
      {
         return String(findInfoByName("WitchBlessDoubleGpTime").Value);
      }
      
      public function get getWitchBlessGP() : Array
      {
         return findInfoByName("WitchBlessGP").Value.split("|");
      }
      
      public function get getWitchBlessMoney() : int
      {
         return int(findInfoByName("WithcBlessMoney").Value);
      }
      
      public function get getDragonboatProp() : int
      {
         var _loc1_:ServerConfigInfo = findInfoByName("DragonBoatProp");
         if(_loc1_)
         {
            return int(_loc1_.Value);
         }
         return 11690;
      }
      
      public function get WarriorFamRaidPricePerMin() : Number
      {
         return Number(findInfoByName("WarriorFamRaidPricePerMin").Value);
      }
      
      public function get getThreeCleanBuyCost() : Number
      {
         return Number(findInfoByName("ThreeCleanBuyCost").Value);
      }
      
      public function get growthPackagePrice() : Number
      {
         var _loc1_:ServerConfigInfo = findInfoByName("PromotePackagePrice");
         if(_loc1_)
         {
            return Number(_loc1_.Value);
         }
         return 0;
      }
      
      public function get growthPackageIsOpen() : Boolean
      {
         var _loc1_:ServerConfigInfo = findInfoByName("IsPromotePackageOpen");
         if(_loc1_)
         {
            return _loc1_.Value.toLowerCase() != "false";
         }
         return false;
      }
      
      public function get wealthTreeIsOpen() : Boolean
      {
         var _loc1_:ServerConfigInfo = findInfoByName("IsOpenWealthTree");
         if(_loc1_)
         {
            return _loc1_.Value.toLowerCase() != "false";
         }
         return false;
      }
      
      public function get trialBuffTipPropertyValue() : String
      {
         var _loc1_:String = "";
         if(_serverConfigInfoList.hasKey("NewFairBattleProperty"))
         {
            _loc1_ = _serverConfigInfoList["NewFairBattleProperty"].Value.toString();
         }
         return _loc1_;
      }
      
      public function get trialfubenBuffTipPropertyValue() : String
      {
         var _loc1_:String = "";
         if(_serverConfigInfoList.hasKey("NewFairPVEBattleProperty"))
         {
            _loc1_ = _serverConfigInfoList["NewFairPVEBattleProperty"].Value.toString();
         }
         return _loc1_;
      }
      
      public function get trialBattleLevelLimit() : int
      {
         var _loc1_:int = 0;
         if(_serverConfigInfoList.hasKey("FairBattleLevelLimit"))
         {
            _loc1_ = _serverConfigInfoList["FairBattleLevelLimit"].Value.toString();
         }
         return _loc1_;
      }
      
      public function get weaponShellNormalAdd() : int
      {
         var _loc1_:int = 0;
         if(_serverConfigInfoList.hasKey("WeaponShellNormalAdd"))
         {
            _loc1_ = _serverConfigInfoList["WeaponShellNormalAdd"].Value.toString();
         }
         return _loc1_;
      }
      
      public function get ddqyOfferCostMoneyArr() : Array
      {
         if(!_serverConfigInfoList.hasKey("DdtLuckWorshipMoney"))
         {
            throw new Error("ServerConfig 弹弹奇缘-上供1次、10次花费未配置");
         }
         var _loc1_:Array = _serverConfigInfoList["DdtLuckWorshipMoney"].Value.toString().split("|");
         return _loc1_;
      }
      
      public function get ddqyOpenTreasureboxCostMoney() : int
      {
         if(!_serverConfigInfoList.hasKey("DdtLuckOpenBoxMoney"))
         {
            throw new Error("ServerConfig 弹弹奇缘-开启宝藏花费未配置");
         }
         var _loc1_:int = _serverConfigInfoList["DdtLuckOpenBoxMoney"].Value.toString();
         return _loc1_;
      }
      
      public function get angelInvestmentAllPrice() : int
      {
         var _loc1_:int = 0;
         if(_serverConfigInfoList.hasKey("MonthCardBuyAllPrice"))
         {
            _loc1_ = _serverConfigInfoList["MonthCardBuyAllPrice"].Value;
         }
         return _loc1_;
      }
      
      public function get angelInvestmentDiscount() : int
      {
         var _loc1_:int = 0;
         if(_serverConfigInfoList.hasKey("MonthCardBuyAllDiscount"))
         {
            _loc1_ = _serverConfigInfoList["MonthCardBuyAllDiscount"].Value;
         }
         return _loc1_;
      }
      
      public function get angelInvestmentDay() : int
      {
         var _loc1_:int = 0;
         if(_serverConfigInfoList.hasKey("MonthCardBuyAllDay"))
         {
            _loc1_ = _serverConfigInfoList["MonthCardBuyAllDay"].Value;
         }
         return _loc1_;
      }
      
      public function get storeExaltRestorePrice() : int
      {
         var _loc1_:int = 0;
         if(_serverConfigInfoList.hasKey("ItemAdvanceRestoreMoney"))
         {
            _loc1_ = _serverConfigInfoList["ItemAdvanceRestoreMoney"].Value;
         }
         return _loc1_;
      }
      
      public function get wasteRecycleAwardIdList() : Array
      {
         if(!_serverConfigInfoList.hasKey("RecycleGoodShowList"))
         {
            throw new Error("RecycleGoodShowList is null!!!");
         }
         var _loc1_:Array = _serverConfigInfoList["RecycleGoodShowList"].Value.toString().split("|");
         return _loc1_;
      }
      
      public function get wasteRecycleLotteryScore() : int
      {
         var _loc1_:int = 0;
         if(_serverConfigInfoList.hasKey("RecycleGoodGetRewardIntegal"))
         {
            _loc1_ = _serverConfigInfoList["RecycleGoodGetRewardIntegal"].Value;
         }
         return _loc1_;
      }
      
      public function get wasteRecycleLimit() : int
      {
         var _loc1_:int = 0;
         if(_serverConfigInfoList.hasKey("RecyGoodDayMaxTimes"))
         {
            _loc1_ = _serverConfigInfoList["RecyGoodDayMaxTimes"].Value;
         }
         return _loc1_;
      }
      
      public function get fireWorksList() : Array
      {
         var _loc1_:* = null;
         if(_serverConfigInfoList.hasKey("FireWorksList"))
         {
            _loc1_ = String(_serverConfigInfoList["FireWorksList"].Value);
            return _loc1_.split("|");
         }
         return "12549,100,5,10,3|12550,50,5,10,3|12551,200,5,20,3|12552,200,5,20,1|12553,200,5,20,3".split("|");
      }
      
      public function get maxLevelAllResetCost() : int
      {
         var _loc1_:int = 0;
         if(_serverConfigInfoList.hasKey("MaxLevelAllResetCost"))
         {
            _loc1_ = _serverConfigInfoList["MaxLevelAllResetCost"].Value;
         }
         return _loc1_;
      }
      
      public function get maxLevelResetCost() : int
      {
         var _loc1_:int = 0;
         if(_serverConfigInfoList.hasKey("MaxLevelResetCost"))
         {
            _loc1_ = _serverConfigInfoList["MaxLevelResetCost"].Value;
         }
         return _loc1_;
      }
      
      public function get rewardTaskPrice() : int
      {
         var _loc1_:int = 0;
         if(_serverConfigInfoList.hasKey("QuestOfferRefreshQuest"))
         {
            _loc1_ = _serverConfigInfoList["QuestOfferRefreshQuest"].Value;
         }
         return _loc1_;
      }
      
      public function get rewardMultiplePrice() : int
      {
         var _loc1_:int = 0;
         if(_serverConfigInfoList.hasKey("QuestOfferRefreshReward"))
         {
            _loc1_ = _serverConfigInfoList["QuestOfferRefreshReward"].Value;
         }
         return _loc1_;
      }
      
      public function get addRewardTaskPrice() : int
      {
         var _loc1_:int = 0;
         if(_serverConfigInfoList.hasKey("QuestOfferBuyTimes"))
         {
            _loc1_ = _serverConfigInfoList["QuestOfferBuyTimes"].Value;
         }
         return _loc1_;
      }
      
      public function get taskNumber() : int
      {
         var _loc1_:int = 0;
         if(_serverConfigInfoList.hasKey("QuestOfferCanAcceptTimes"))
         {
            _loc1_ = _serverConfigInfoList["QuestOfferCanAcceptTimes"].Value;
         }
         return _loc1_;
      }
      
      public function get addTaskNumPrice() : int
      {
         var _loc1_:int = 0;
         if(_serverConfigInfoList.hasKey("QuestOfferBuyTimesAddMoney"))
         {
            _loc1_ = _serverConfigInfoList["QuestOfferBuyTimesAddMoney"].Value;
         }
         return _loc1_;
      }
      
      public function get consortiaGuardReviveRiches() : int
      {
         var _loc1_:int = 100;
         if(_serverConfigInfoList.hasKey("GReliveCost"))
         {
            _loc1_ = _serverConfigInfoList["GReliveCost"].Value;
         }
         return _loc1_;
      }
      
      public function get consortiaGuardOpenRiches() : int
      {
         var _loc1_:int = 0;
         if(_serverConfigInfoList.hasKey("GOpenActiveCost"))
         {
            _loc1_ = _serverConfigInfoList["GOpenActiveCost"].Value;
         }
         return _loc1_;
      }
      
      public function get consortiaGuardReviveTime() : int
      {
         var _loc1_:int = 10;
         if(_serverConfigInfoList.hasKey("GReliveTime"))
         {
            _loc1_ = _serverConfigInfoList["GReliveTime"].Value;
         }
         return _loc1_;
      }
      
      public function get consortiaGuardBuyCost() : int
      {
         var _loc1_:int = 0;
         if(_serverConfigInfoList.hasKey("GBuyBUFFCost"))
         {
            _loc1_ = _serverConfigInfoList["GBuyBUFFCost"].Value;
         }
         return _loc1_;
      }
      
      public function get consortiaGuardBuyBuffMaxLevel() : int
      {
         var _loc1_:int = 1;
         if(_serverConfigInfoList.hasKey("GBuyBUFFMax"))
         {
            _loc1_ = _serverConfigInfoList["GBuyBUFFMax"].Value;
         }
         return _loc1_;
      }
      
      public function get battleDungeonLimitCount() : int
      {
         var _loc1_:int = 1;
         if(_serverConfigInfoList.hasKey("TreasureTimes"))
         {
            _loc1_ = _serverConfigInfoList["TreasureTimes"].Value;
         }
         return _loc1_;
      }
      
      public function get nightmareDungeonLimitTimes() : int
      {
         var _loc1_:int = 5;
         if(_serverConfigInfoList.hasKey("ChickOrAntTreasureTimes"))
         {
            _loc1_ = _serverConfigInfoList["ChickOrAntTreasureTimes"].Value;
         }
         return _loc1_;
      }
      
      public function get nightmareDungeonLimitPower() : int
      {
         var _loc1_:int = 500000;
         if(_serverConfigInfoList.hasKey("ChickOrAntTreasureMinFightPower"))
         {
            _loc1_ = _serverConfigInfoList["ChickOrAntTreasureMinFightPower"].Value;
         }
         return _loc1_;
      }
      
      public function get equipAmuletBuyDustMax() : int
      {
         var _loc1_:int = 20;
         if(_serverConfigInfoList.hasKey("AmuletBuyDustMax"))
         {
            _loc1_ = _serverConfigInfoList["AmuletBuyDustMax"].Value;
         }
         return _loc1_;
      }
      
      public function get AmuletBuyDustCountAndNeedMoney() : Array
      {
         var _loc1_:Array = [];
         if(_serverConfigInfoList.hasKey("AmuletBuyDustCountAndNeedMoney"))
         {
            _loc1_ = _serverConfigInfoList["AmuletBuyDustCountAndNeedMoney"].Value.split("|");
         }
         return _loc1_;
      }
      
      public function get WorshipMoonBeginDate() : String
      {
         var _loc1_:String = "";
         if(_serverConfigInfoList.hasKey("WorshipMoonBeginDate"))
         {
            _loc1_ = _serverConfigInfoList["WorshipMoonBeginDate"].Value;
         }
         return _loc1_;
      }
      
      public function get WorshipMoonEndDate() : String
      {
         var _loc1_:String = "";
         if(_serverConfigInfoList.hasKey("WorshipMoonEndDate"))
         {
            _loc1_ = _serverConfigInfoList["WorshipMoonEndDate"].Value;
         }
         return _loc1_;
      }
      
      public function get batchOpenConfig() : DictionaryData
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:int = 0;
         if(_catchBatchOpen == null)
         {
            _catchBatchOpen = new DictionaryData();
            _loc1_ = null;
            if(_serverConfigInfoList.hasKey("BatchOpen"))
            {
               _loc2_ = _serverConfigInfoList["BatchOpen"].Value;
               _loc1_ = _loc2_.split("|");
               _loc3_ = 0;
               while(_loc3_ < _loc1_.length)
               {
                  _loc4_ = (_loc1_[_loc3_] as String).split(",");
                  _catchBatchOpen.add(_loc4_[0],_loc4_[1]);
                  _loc3_++;
               }
            }
         }
         return _catchBatchOpen;
      }
      
      public function get cubeGameRow() : int
      {
         var _loc1_:int = 11;
         if(_serverConfigInfoList.hasKey("ComboSlashMaxRow"))
         {
            _loc1_ = _serverConfigInfoList["ComboSlashMaxRow"].Value;
         }
         return _loc1_;
      }
      
      public function get cubeGameColumn() : int
      {
         var _loc1_:int = 14;
         if(_serverConfigInfoList.hasKey("ComboSlashMaxColumn"))
         {
            _loc1_ = _serverConfigInfoList["ComboSlashMaxColumn"].Value;
         }
         return _loc1_;
      }
      
      public function get strongDestroyScore() : int
      {
         var _loc1_:int = 500;
         if(_serverConfigInfoList.hasKey("ComboSlashRemoveSevevenCountAddScore"))
         {
            _loc1_ = _serverConfigInfoList["ComboSlashRemoveSevevenCountAddScore"].Value;
         }
         return _loc1_;
      }
      
      public function get extraDestroyScore() : int
      {
         var _loc1_:int = 1000;
         if(_serverConfigInfoList.hasKey("ComboSlashRemoveFourteenCountAddScore"))
         {
            _loc1_ = _serverConfigInfoList["ComboSlashRemoveFourteenCountAddScore"].Value;
         }
         return _loc1_;
      }
      
      public function get emptyColumnScore() : int
      {
         var _loc1_:int = 100;
         if(_serverConfigInfoList.hasKey("ComboSlashNullCloumnScore"))
         {
            _loc1_ = _serverConfigInfoList["ComboSlashNullCloumnScore"].Value;
         }
         return _loc1_;
      }
      
      public function get cubeGameCostEnergy() : int
      {
         var _loc1_:int = 2;
         if(_serverConfigInfoList.hasKey("CubeGameCostEnergy"))
         {
            _loc1_ = _serverConfigInfoList["CubeGameCostEnergy"].Value;
         }
         return _loc1_;
      }
      
      public function get nationDayGetMaxTimes() : Array
      {
         var _loc1_:Array = [10,10,10,10];
         if(_serverConfigInfoList.hasKey("NationalDayExchangeTimes"))
         {
            _loc1_ = String(_serverConfigInfoList["NationalDayExchangeTimes"].Value).split(",");
         }
         return _loc1_;
      }
      
      public function get pvePowerBuffLevelLimit() : int
      {
         var _loc1_:int = 20;
         if(_serverConfigInfoList.hasKey("BlessBuffOpenLv"))
         {
            _loc1_ = _serverConfigInfoList["BlessBuffOpenLv"].Value;
         }
         return _loc1_;
      }
      
      public function get pvePowerBuffRefreshPrice() : int
      {
         var _loc1_:int = 100;
         if(_serverConfigInfoList.hasKey("BlessBuffRefreshPrice"))
         {
            _loc1_ = _serverConfigInfoList["BlessBuffRefreshPrice"].Value;
         }
         return _loc1_;
      }
      
      public function get pvePowerBuffGetBuffPrice() : int
      {
         var _loc1_:int = 100;
         if(_serverConfigInfoList.hasKey("BlessBuffAddBuffPrice"))
         {
            _loc1_ = _serverConfigInfoList["BlessBuffAddBuffPrice"].Value;
         }
         return _loc1_;
      }
      
      public function get ItemDevelopPrice() : int
      {
         var _loc1_:int = 35;
         if(_serverConfigInfoList.hasKey("ItemDevelopPrice"))
         {
            _loc1_ = _serverConfigInfoList["ItemDevelopPrice"].Value;
         }
         return _loc1_;
      }
      
      public function get stockLoanRechageRate() : int
      {
         var _loc1_:int = 10;
         if(_serverConfigInfoList.hasKey("ExchangeMargin"))
         {
            _loc1_ = _serverConfigInfoList["ExchangeMargin"].Value;
         }
         return _loc1_;
      }
      
      public function get StockOpenTime() : String
      {
         var _loc1_:String = "9,15|16,22";
         if(_serverConfigInfoList.hasKey("StockOpenTime"))
         {
            _loc1_ = String(_serverConfigInfoList["StockOpenTime"].Value);
         }
         return _loc1_;
      }
      
      public function get StockStartDate() : String
      {
         var _loc1_:String = "2017-03-21 00:00:00";
         if(_serverConfigInfoList.hasKey("StockStartDate"))
         {
            _loc1_ = String(_serverConfigInfoList["StockStartDate"].Value);
         }
         return _loc1_;
      }
      
      public function get StockEndDate() : String
      {
         var _loc1_:String = "2017-03-26 23:59:59";
         if(_serverConfigInfoList.hasKey("StockEndDate"))
         {
            _loc1_ = String(_serverConfigInfoList["StockEndDate"].Value);
         }
         return _loc1_;
      }
      
      public function get StockOverDate() : String
      {
         var _loc1_:String = "2017-03-27 23:59:59";
         if(_serverConfigInfoList.hasKey("StockOverDate"))
         {
            _loc1_ = String(_serverConfigInfoList["StockOverDate"].Value);
         }
         return _loc1_;
      }
      
      public function get StockScoreAward() : String
      {
         var _loc1_:String = "100000,1120956|200000,1120956|300000,1120956|400000,1120956|500000,1120956";
         if(_serverConfigInfoList.hasKey("StockReward"))
         {
            _loc1_ = String(_serverConfigInfoList["StockReward"].Value);
         }
         return _loc1_;
      }
      
      public function get consortionActiveTarget() : String
      {
         var _loc1_:String = "1,30,3000,0|3,50,6000,2000|5,80,12000,4000";
         if(_serverConfigInfoList.hasKey("ConsortiaDayActiveCondInfo"))
         {
            _loc1_ = String(_serverConfigInfoList["ConsortiaDayActiveCondInfo"].Value);
         }
         return _loc1_;
      }
      
      public function get getTeamCreateCoin() : int
      {
         var _loc1_:int = 30000;
         if(_serverConfigInfoList.hasKey("CreateTeamMoney"))
         {
            _loc1_ = _serverConfigInfoList["CreateTeamMoney"].Value;
         }
         return _loc1_;
      }
      
      public function get getTeamDonatePrice() : int
      {
         var _loc1_:int = 10;
         if(_serverConfigInfoList.hasKey("MoneyRichesOffer"))
         {
            _loc1_ = _serverConfigInfoList["MoneyRichesOffer"].Value;
         }
         return _loc1_;
      }
      
      public function get getOnlineArmCostEnergy() : int
      {
         var _loc1_:int = 3;
         if(_serverConfigInfoList.hasKey("OnlineArmCostEnergy"))
         {
            _loc1_ = _serverConfigInfoList["OnlineArmCostEnergy"].Value;
         }
         return _loc1_;
      }
      
      public function get FreeInviteLevelMin() : int
      {
         var _loc1_:int = 5;
         if(_serverConfigInfoList.hasKey("FreeInviteLevelMin"))
         {
            _loc1_ = _serverConfigInfoList["FreeInviteLevelMin"].Value;
         }
         return _loc1_;
      }
      
      public function get FreeInviteLevelMax() : int
      {
         var _loc1_:int = 15;
         if(_serverConfigInfoList.hasKey("FreeInviteLevelMax"))
         {
            _loc1_ = _serverConfigInfoList["FreeInviteLevelMax"].Value;
         }
         return _loc1_;
      }
      
      public function get FreeInviteCount() : int
      {
         var _loc1_:int = 2;
         if(_serverConfigInfoList.hasKey("FreeInviteCount"))
         {
            _loc1_ = _serverConfigInfoList["FreeInviteCount"].Value;
         }
         return _loc1_;
      }
      
      public function get markOpenLevel() : int
      {
         var _loc1_:int = 10;
         if(_serverConfigInfoList.hasKey("EngraveLimitLevel"))
         {
            _loc1_ = _serverConfigInfoList["EngraveLimitLevel"].Value;
         }
         return _loc1_;
      }
      
      public function get EngraveSaleStarConfig() : int
      {
         var _loc1_:int = 200;
         if(_serverConfigInfoList.hasKey("EngraveSaleStarConfig"))
         {
            _loc1_ = _serverConfigInfoList["EngraveSaleStarConfig"].Value;
         }
         return _loc1_;
      }
      
      public function get EngraveSaleTemperConsumeConfig() : int
      {
         var _loc1_:int = 60;
         if(_serverConfigInfoList.hasKey("EngraveSaleTemperConsumeConfig"))
         {
            _loc1_ = _serverConfigInfoList["EngraveSaleTemperConsumeConfig"].Value;
         }
         return _loc1_;
      }
      
      public function get getEngraveVaults() : Array
      {
         var _loc2_:* = null;
         var _loc1_:Array = [];
         if(_serverConfigInfoList.hasKey("EngraveVaultsConfig"))
         {
            _loc2_ = _serverConfigInfoList["EngraveVaultsConfig"].Value;
            _loc1_.push((_loc2_.split("|")[0] as String).split(","));
            _loc1_.push((_loc2_.split("|")[1] as String).split(","));
         }
         return _loc1_;
      }
      
      public function get getEngraveVaultsFreeTimes() : int
      {
         var _loc1_:int = 0;
         if(_serverConfigInfoList.hasKey("EngraveVaultsFreeTimes"))
         {
            _loc1_ = _serverConfigInfoList["EngraveVaultsFreeTimes"].Value;
         }
         return _loc1_;
      }
   }
}
