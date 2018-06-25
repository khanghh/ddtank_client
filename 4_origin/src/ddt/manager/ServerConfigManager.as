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
      
      public static const UNREALCONTEST_BUYCOST:String = "UnrealContestBuyCost";
      
      public static const UNREALCONTESTLEVELLIMITS:String = "UnrealContestLevelLimits";
      
      public static const UNREALCONTEST_ENDDATE:String = "UnrealContestEndDate";
      
      public static const PETWASH_COST:String = "PetWashCost";
      
      public static const PET_QUALITY_CONFIG:String = "PetQualityConfig";
       
      
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
      
      public function getserverConfigInfo(analyzer:ServerConfigAnalyz) : void
      {
         var i:int = 0;
         _serverConfigInfoList = analyzer.serverConfigInfoList;
         _BindMoneyMax = _serverConfigInfoList["BindMoneyMax"].Value.split("|");
         _VIPExtraBindMoneyUpper = _serverConfigInfoList["VIPExtraBindMoneyUpper"].Value.split("|");
         _activityEnterNum = _serverConfigInfoList["QXGameLimitCount"].Value;
         _dailyRewardIDForMonth = _serverConfigInfoList["DailyRewardIDForMonth"].Value.split("|");
         _christmasGiftGetTime = _serverConfigInfoList["ChristmasGiftsGetTime"].Value;
         _cryptBossOpenDay = _serverConfigInfoList["CryptBossOpenDay"].Value.split("|");
         var tmp:Array = _serverConfigInfoList["ConsortiaMissionAddTime"].Value.split("|");
         var len:int = tmp.length;
         _consortiaTaskDelayInfo = [];
         for(i = 0; i < len; )
         {
            _consortiaTaskDelayInfo.push(tmp[i].split(","));
            i++;
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
         var obj:ServerConfigInfo = findInfoByName("BuyCardSoulValueMoney");
         if(obj)
         {
            return Number(obj.Value);
         }
         return 500;
      }
      
      public function get lanternMaxHomeVisited() : int
      {
         return _serverConfigInfoList["LanternHomeVisited"].Value;
      }
      
      public function getNeedUseLotteryKicket(quality:int) : int
      {
         var temValue:* = null;
         var temArr:* = null;
         if(_serverConfigInfoList.hasKey("TurnTableCostCountByLevel"))
         {
            temValue = _serverConfigInfoList["TurnTableCostCountByLevel"].Value;
            temArr = temValue.split("|");
            if(temArr.length == 4 && quality <= 3)
            {
               return temArr[quality];
            }
            return temArr[temArr.length - 1];
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
      
      public function getBindBidLimit(level:int, vipLevel:int = 0) : int
      {
         var levelMax:int = level % 10 == 0?int(_BindMoneyMax[int(level / 10) - 1]):int(_BindMoneyMax[int(level / 10)]);
         var vipLevelMax:int = 0;
         if(PlayerManager.Instance.Self.IsVIP && vipLevel > 0)
         {
            vipLevelMax = _VIPExtraBindMoneyUpper[vipLevel - 1];
         }
         return levelMax + vipLevelMax;
      }
      
      public function get PayAimEnergy() : int
      {
         return int(findInfoByName("PayAimEnergy").Value);
      }
      
      public function get VIPPayAimEnergy() : Array
      {
         var arr:Array = findInfoByName("VIPPayAimEnergy").Value.split("|");
         return arr;
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
      
      public function findInfoByName(name:String) : ServerConfigInfo
      {
         return _serverConfigInfoList[name];
      }
      
      public function get VIPStrengthenEx() : Array
      {
         var obj:Object = findInfoByName("VIPStrengthenEx");
         if(obj)
         {
            return findInfoByName("VIPStrengthenEx").Value.split("|");
         }
         return null;
      }
      
      public function ConsortiaStrengthenEx() : Array
      {
         var obj:Object = findInfoByName("ConsortiaStrengthenEx");
         if(obj)
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
         var obj:Object = findInfoByName("VIPRenewalPrize");
         if(obj)
         {
            return String(obj.Value).split("|");
         }
         return null;
      }
      
      public function get VIPRateForGP() : Array
      {
         var obj:Object = findInfoByName("VIPRateForGP");
         if(obj)
         {
            return String(obj.Value).split("|");
         }
         return null;
      }
      
      public function get VIPQuestStar() : Array
      {
         var obj:Object = findInfoByName("VIPQuestStar");
         if(obj)
         {
            return String(obj.Value).split("|");
         }
         return null;
      }
      
      public function get VIPLotteryCountMaxPerDay() : Array
      {
         var obj:Object = findInfoByName("VIPLotteryCountMaxPerDay");
         if(obj)
         {
            return String(obj.Value).split("|");
         }
         return null;
      }
      
      public function get VIPTakeCardDisCount() : Array
      {
         var obj:Object = findInfoByName("VIPTakeCardDisCount");
         if(obj)
         {
            return String(obj.Value).split("|");
         }
         return null;
      }
      
      public function get VIPQuestFinishDirect() : Array
      {
         return analyzeData("VIPQuestFinishDirect");
      }
      
      public function analyzeData(field:String) : Array
      {
         var obj:Object = findInfoByName(field);
         if(obj)
         {
            return String(obj.Value).split("|");
         }
         return null;
      }
      
      public function getPrivilegeString(level:int) : String
      {
         var obj:Object = findInfoByName("VIPPrivilege");
         if(obj)
         {
            return String(obj.Value);
         }
         return null;
      }
      
      public function get VIPDailyPack() : Array
      {
         return findInfoByName("VIPDailyPackID").Value.split("|");
      }
      
      public function get VIPRewardCryptCount() : Vector.<String>
      {
         var data:Vector.<String> = Vector.<String>(findInfoByName("VIPRewardCryptCount").Value.split("|"));
         return data;
      }
      
      public function getPrivilegeMinLevel(type:String) : int
      {
         var obj:* = null;
         var level:int = 0;
         var arr:* = null;
         if(privileges == null)
         {
            obj = findInfoByName("VIPPrivilege");
            level = 1;
            arr = String(obj.Value).split("|");
            privileges = new Dictionary();
            var _loc10_:int = 0;
            var _loc9_:* = arr;
            for each(var s in arr)
            {
               var _loc8_:int = 0;
               var _loc7_:* = s.split(",");
               for each(var p in s.split(","))
               {
                  privileges[p] = level;
               }
               level++;
            }
         }
         return int(privileges[type]);
      }
      
      public function getBeadUpgradeExp() : DictionaryData
      {
         var vResultDic:DictionaryData = new DictionaryData();
         var vArray:Array = findInfoByName("RuneLevelUpExp").Value.split("|");
         var vLv:int = 1;
         var _loc6_:int = 0;
         var _loc5_:* = vArray;
         for each(var o in vArray)
         {
            vResultDic.add(vLv,o);
            vLv++;
         }
         return vResultDic;
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
         var obj:Object = findInfoByName("PlayerMinLevel");
         return int(obj.Value);
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
      
      public function getDragonBoatBuildStage(type:int) : Array
      {
         return findInfoByName("DragonBoatBuildStage" + type).Value.split("|");
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
         var tempArr:* = null;
         var obj:ServerConfigInfo = findInfoByName("PyramidTopPoint");
         if(obj)
         {
            tempArr = obj.Value.split("|");
            return new Array(tempArr[0],tempArr[tempArr.length - 1]);
         }
         return new Array(0,0);
      }
      
      public function get sevendayProgressGift() : Array
      {
         var obj:ServerConfigInfo = findInfoByName("SevenDayTargetReward");
         var temArr:Array = obj.Value.split("|");
         return temArr;
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
      
      public function SanXiaoStepPrice() : String
      {
         return _serverConfigInfoList["ThreeCleanBuyCost"].Value;
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
         var info:ServerConfigInfo = findInfoByName("DepotBuyMoney");
         if(info)
         {
            return info.Value.split(",");
         }
         return null;
      }
      
      public function get levelFundPrice() : Array
      {
         var info:ServerConfigInfo = findInfoByName("DDFundPrice");
         if(info)
         {
            return info.Value.split(",");
         }
         return null;
      }
      
      public function get homeFightBoxIDList() : Array
      {
         var info:ServerConfigInfo = findInfoByName("HomeTDHomeBoxID");
         if(info)
         {
            return info.Value.split(",");
         }
         return null;
      }
      
      public function get homeFightSkillPrice() : Array
      {
         var info:ServerConfigInfo = findInfoByName("HomeTDSkillPrice");
         if(info)
         {
            return info.Value.split(",");
         }
         return null;
      }
      
      public function entertainmentScore() : Array
      {
         var obj:ServerConfigInfo = findInfoByName("EntertainmentScore");
         var arr:Array = obj.Value.split(",");
         return arr;
      }
      
      public function entertainmentPrice() : int
      {
         var _info:ServerConfigInfo = findInfoByName("RecreationPvpRefreshPropBindMoney");
         if(_info)
         {
            return int(_info.Value);
         }
         return 0;
      }
      
      public function entertainmentLevel() : int
      {
         return int(findInfoByName("RecreationPvpMinLevel").Value);
      }
      
      public function get homeFightSkillEffect() : Array
      {
         var info:ServerConfigInfo = findInfoByName("HomeTDSkillEffect");
         if(info)
         {
            return info.Value.split(",");
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
         var obj:ServerConfigInfo = findInfoByName("HomeBarCleanCDPrice");
         if(obj)
         {
            return int(obj.Value);
         }
         return 0;
      }
      
      public function getHouseExtendNeed(next:int) : Array
      {
         var i:int = 0;
         var childArr:* = null;
         var obj:ServerConfigInfo = findInfoByName("HouseUpgradeUse");
         var arr:Array = obj.Value.split("|");
         for(i = 0; i <= arr.length - 1; )
         {
            childArr = arr[i].split(",");
            if(parseInt(childArr[0]) == next)
            {
               return childArr;
            }
            i++;
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
         var str:String = _serverConfigInfoList["YearMonsterBeginDate"].Value;
         return DateUtils.getDateByStr(str);
      }
      
      public function yearMonsterEndDate() : Date
      {
         var str:String = _serverConfigInfoList["YearMonsterEndDate"].Value;
         return DateUtils.getDateByStr(str);
      }
      
      public function rescueSpringBegin() : Date
      {
         var str:String = _serverConfigInfoList["HelpGameSpringBegin"].Value;
         return DateUtils.getDateByStr(str);
      }
      
      public function getSeniorMarryMoney(isSale:Boolean) : Array
      {
         if(isSale)
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
         var str:String = _serverConfigInfoList["ChristmasGiftsGetTime"].Value;
         var d:Date = DateUtils.getDateByStr(str);
         return [d.hours,d.minutes];
      }
      
      public function getSeniorMarryBegin() : Date
      {
         var str:String = _serverConfigInfoList["SeniorMarryBegin"].Value;
         return DateUtils.getDateByStr(str);
      }
      
      public function getSeniorMarryEnd() : Date
      {
         var str:String = _serverConfigInfoList["SeniorMarryEnd"].Value;
         return DateUtils.getDateByStr(str);
      }
      
      public function get AuctionRate() : String
      {
         return String(findInfoByName("Cess").Value * 100);
      }
      
      public function getDesertFreeEnterCount() : int
      {
         var count:int = _serverConfigInfoList["DesertFreeEnterCount"].Value;
         return count;
      }
      
      public function getDesertFeeEnterCount() : int
      {
         var count:int = _serverConfigInfoList["DesertFeeEnterCount"].Value;
         return count;
      }
      
      public function getMagicHighFamMaxLevel() : int
      {
         var count:int = _serverConfigInfoList["WarriorHighFamMaxLevel"].Value;
         return count;
      }
      
      public function get firstDivorcedMoney() : String
      {
         return findInfoByName("DivorcedDiscountMoney").Value;
      }
      
      public function getWarriorHighFamMaxLevel() : int
      {
         var count:int = _serverConfigInfoList["WarriorFamMaxLevel"].Value;
         return count;
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
         var i:int = 0;
         var obj:ServerConfigInfo = findInfoByName("BuyClothGroupCost");
         var temArr:Array = [];
         if(obj)
         {
            for(i = 0; i < 3; )
            {
               temArr[obj.Value.split("|")[i].split(",")[0]] = obj.Value.split("|")[i].split(",")[1];
               i++;
            }
         }
         return temArr;
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
         var obj:ServerConfigInfo = findInfoByName("DiffDimensionTimeControl");
         var arr:Array = obj.Value.split("|");
         return arr;
      }
      
      public function getSpaceControl() : Array
      {
         var obj:ServerConfigInfo = findInfoByName("DiffDimensionSpaceControl");
         var arr:Array = obj.Value.split("|");
         return arr;
      }
      
      public function getLootControl() : Array
      {
         var obj:ServerConfigInfo = findInfoByName("DiffDimensionLootControl");
         var arr:Array = obj.Value.split("|");
         return arr;
      }
      
      public function getLevelUpItemID() : int
      {
         var obj:ServerConfigInfo = findInfoByName("DiffDimensionLevelUpItemID");
         if(obj)
         {
            return int(obj.Value);
         }
         return 0;
      }
      
      public function getSearchPrice() : int
      {
         var obj:ServerConfigInfo = findInfoByName("DiffDimensionRefreshPrice");
         if(obj)
         {
            return int(obj.Value);
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
         var info:ServerConfigInfo = findInfoByName("PetDisappearPlayCount");
         var arr:Array = info.Value.split("|");
         return arr;
      }
      
      public function get petDisappearPlaySoncount() : Array
      {
         var info:ServerConfigInfo = findInfoByName("PetDisappearPlaySonCount");
         var arr:Array = info.Value.split("|");
         return arr;
      }
      
      public function get petDisappearPlayerBlood() : Array
      {
         var info:ServerConfigInfo = findInfoByName("PetDisappearUserBlood");
         var arr:Array = info.Value.split("|");
         return arr;
      }
      
      public function get petDisappearNPCBlood() : Array
      {
         var info:ServerConfigInfo = findInfoByName("PetDisappearNPCBlood");
         var arr:Array = info.Value.split("|");
         return arr;
      }
      
      public function get petDisappearRecoverPrice() : int
      {
         return _serverConfigInfoList["PetDisappearRecoverPrice"].Value;
      }
      
      public function get petDisappearSkillMoney() : Array
      {
         var info:ServerConfigInfo = findInfoByName("PetDisappearSkillMoney");
         var arr:Array = info.Value.split("|");
         return arr;
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
         var info:ServerConfigInfo = findInfoByName("PetDisappearSkillTwoMoney");
         var arr:Array = info.Value.split("|");
         return arr;
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
         var info:ServerConfigInfo = findInfoByName("HorseGameBuffConfig");
         var arr:Array = info.Value.split("|");
         return arr;
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
         var arr:Array = findInfoByName("PrayGoodsActivityConfig").Value.split("|");
         return arr;
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
         var info:ServerConfigInfo = findInfoByName("YearFoodItemsCount");
         var arr:Array = info.Value.split("|");
         return arr;
      }
      
      public function get localYearFoodItems() : Array
      {
         var info:ServerConfigInfo = findInfoByName("YearFoodItems");
         var arr:Array = info.Value.split(",");
         return arr;
      }
      
      public function get cityOccupationAddPrice() : Array
      {
         var info:ServerConfigInfo = findInfoByName("CityOccupationAddPrice");
         var arr:Array = info.Value.split("|");
         return arr;
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
         var info:ServerConfigInfo = findInfoByName("YearFoodItemPrices");
         var arr:Array = info.Value.split(",");
         return arr;
      }
      
      public function get getLightRiddleIsNew() : Boolean
      {
         var obj:ServerConfigInfo = findInfoByName("LightRiddleIsNew");
         if(obj)
         {
            return obj.Value.toLowerCase() != "false";
         }
         return false;
      }
      
      public function get getIsBuyQuestEnereyNeedKingBuff() : Boolean
      {
         var obj:ServerConfigInfo = findInfoByName("IsBuyQuestEnereyNeedKingBuff");
         if(obj)
         {
            return obj.Value.toLowerCase() != "false";
         }
         return false;
      }
      
      public function getDDTKingQuizPrize() : int
      {
         var obj:ServerConfigInfo = findInfoByName("DDTKingQuizPrize");
         if(obj)
         {
            return int(obj.Value);
         }
         return 100;
      }
      
      public function getDDTKingQuizCityList() : String
      {
         var obj:ServerConfigInfo = findInfoByName("DDTKingQuizCityList");
         if(obj)
         {
            return obj.Value;
         }
         return "1|2|3|4|5|6|7|8";
      }
      
      public function getDDTKingQuizPersonMaxCount() : String
      {
         var obj:ServerConfigInfo = findInfoByName("DDTKingQuizPersonMaxCount");
         if(obj)
         {
            return obj.Value;
         }
         return "1000|500|200|100";
      }
      
      public function getDDTKingQuizTeamMaxCount() : String
      {
         var obj:ServerConfigInfo = findInfoByName("DDTKingQuizTeamMaxCount");
         if(obj)
         {
            return obj.Value;
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
         var obj:ServerConfigInfo = findInfoByName("LightRiddleRemoveErrorMoney");
         if(obj)
         {
            return int(obj.Value);
         }
         return 0;
      }
      
      public function getDDTKingQuizLostID() : int
      {
         var obj:ServerConfigInfo = findInfoByName("DDTKingQuizLostID");
         if(obj)
         {
            return int(obj.Value);
         }
         return 0;
      }
      
      public function getDDTKingQuizWinID() : int
      {
         var obj:ServerConfigInfo = findInfoByName("DDTKingQuizWinID");
         if(obj)
         {
            return int(obj.Value);
         }
         return 0;
      }
      
      public function get magicStoneCostItemNum() : int
      {
         var obj:Object = findInfoByName("MagicStoneCostItem");
         return int(obj.Value);
      }
      
      public function get consortiaMatchStartTime() : Array
      {
         var info:ServerConfigInfo = findInfoByName("ConsortiaMatchStartTime");
         var arr:Array = info.Value.split(" ")[1].toString().split(":");
         return arr;
      }
      
      public function get consortiaMatchEndTime() : Array
      {
         var info:ServerConfigInfo = findInfoByName("ConsortiaMatchEndTime");
         var arr:Array = info.Value.split(" ")[1].toString().split(":");
         return arr;
      }
      
      public function get localConsortiaMatchDays() : Array
      {
         var info:ServerConfigInfo = findInfoByName("LocalConsortiaMatchDays");
         var arr:Array = info.Value.split("|");
         return arr;
      }
      
      public function get areaConsortiaMatchDays() : Array
      {
         var info:ServerConfigInfo = findInfoByName("AreaConsortiaMatchDays");
         var arr:Array = info.Value.split("|");
         return arr;
      }
      
      public function get getDeedPrices() : Array
      {
         var info:ServerConfigInfo = findInfoByName("DanDanBuffPrice");
         if(info)
         {
            return info.Value.split(",");
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
         var obj:ServerConfigInfo = findInfoByName("IsChickenActiveKeyOpen");
         if(obj)
         {
            return obj.Value.toLowerCase() == "true";
         }
         return false;
      }
      
      public function get chickenActiveKeyLvAwardNeedPrestige() : Array
      {
         var info:ServerConfigInfo = findInfoByName("ChickenActiveKeyLvAwardNeedPrestige");
         if(info)
         {
            return info.Value.split("|");
         }
         return null;
      }
      
      public function getToyMachinePrice() : Array
      {
         return _serverConfigInfoList["ToyMachinePrice"].Value.split("|");
      }
      
      public function getRedEnvelopeCount(type:int) : int
      {
         var arr:Array = _serverConfigInfoList["HongBaoCount"].Value.split("|");
         return parseInt(arr[type - 1]);
      }
      
      public function get getEveryDayOpenPrice() : Array
      {
         var info:ServerConfigInfo = findInfoByName("EveryDayOpenPrice");
         if(info)
         {
            return info.Value.split("|");
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
         var obj:ServerConfigInfo = findInfoByName("TotemPropMoneyOffset");
         if(obj)
         {
            return Number(obj.Value);
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
         var info:ServerConfigInfo = findInfoByName("DragonBoatProp");
         if(info)
         {
            return int(info.Value);
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
         var obj:ServerConfigInfo = findInfoByName("PromotePackagePrice");
         if(obj)
         {
            return Number(obj.Value);
         }
         return 0;
      }
      
      public function get growthPackageIsOpen() : Boolean
      {
         var obj:ServerConfigInfo = findInfoByName("IsPromotePackageOpen");
         if(obj)
         {
            return obj.Value.toLowerCase() != "false";
         }
         return false;
      }
      
      public function get wealthTreeIsOpen() : Boolean
      {
         var obj:ServerConfigInfo = findInfoByName("IsOpenWealthTree");
         if(obj)
         {
            return obj.Value.toLowerCase() != "false";
         }
         return false;
      }
      
      public function get trialBuffTipPropertyValue() : String
      {
         var str:String = "";
         if(_serverConfigInfoList.hasKey("NewFairBattleProperty"))
         {
            str = _serverConfigInfoList["NewFairBattleProperty"].Value.toString();
         }
         return str;
      }
      
      public function get trialfubenBuffTipPropertyValue() : String
      {
         var str:String = "";
         if(_serverConfigInfoList.hasKey("NewFairPVEBattleProperty"))
         {
            str = _serverConfigInfoList["NewFairPVEBattleProperty"].Value.toString();
         }
         return str;
      }
      
      public function get trialBattleLevelLimit() : int
      {
         var str:int = 0;
         if(_serverConfigInfoList.hasKey("FairBattleLevelLimit"))
         {
            str = _serverConfigInfoList["FairBattleLevelLimit"].Value.toString();
         }
         return str;
      }
      
      public function get weaponShellNormalAdd() : int
      {
         var str:int = 0;
         if(_serverConfigInfoList.hasKey("WeaponShellNormalAdd"))
         {
            str = _serverConfigInfoList["WeaponShellNormalAdd"].Value.toString();
         }
         return str;
      }
      
      public function get ddqyOfferCostMoneyArr() : Array
      {
         if(!_serverConfigInfoList.hasKey("DdtLuckWorshipMoney"))
         {
            throw new Error("ServerConfig 弹弹奇缘-上供1次、10次花费未配置");
         }
         var arr:Array = _serverConfigInfoList["DdtLuckWorshipMoney"].Value.toString().split("|");
         return arr;
      }
      
      public function get ddqyOpenTreasureboxCostMoney() : int
      {
         if(!_serverConfigInfoList.hasKey("DdtLuckOpenBoxMoney"))
         {
            throw new Error("ServerConfig 弹弹奇缘-开启宝藏花费未配置");
         }
         var str:int = _serverConfigInfoList["DdtLuckOpenBoxMoney"].Value.toString();
         return str;
      }
      
      public function get angelInvestmentAllPrice() : int
      {
         var price:int = 0;
         if(_serverConfigInfoList.hasKey("MonthCardBuyAllPrice"))
         {
            price = _serverConfigInfoList["MonthCardBuyAllPrice"].Value;
         }
         return price;
      }
      
      public function get angelInvestmentDiscount() : int
      {
         var discount:int = 0;
         if(_serverConfigInfoList.hasKey("MonthCardBuyAllDiscount"))
         {
            discount = _serverConfigInfoList["MonthCardBuyAllDiscount"].Value;
         }
         return discount;
      }
      
      public function get angelInvestmentDay() : int
      {
         var day:int = 0;
         if(_serverConfigInfoList.hasKey("MonthCardBuyAllDay"))
         {
            day = _serverConfigInfoList["MonthCardBuyAllDay"].Value;
         }
         return day;
      }
      
      public function get storeExaltRestorePrice() : int
      {
         var price:int = 0;
         if(_serverConfigInfoList.hasKey("ItemAdvanceRestoreMoney"))
         {
            price = _serverConfigInfoList["ItemAdvanceRestoreMoney"].Value;
         }
         return price;
      }
      
      public function get wasteRecycleAwardIdList() : Array
      {
         if(!_serverConfigInfoList.hasKey("RecycleGoodShowList"))
         {
            throw new Error("RecycleGoodShowList is null!!!");
         }
         var arr:Array = _serverConfigInfoList["RecycleGoodShowList"].Value.toString().split("|");
         return arr;
      }
      
      public function get wasteRecycleLotteryScore() : int
      {
         var score:int = 0;
         if(_serverConfigInfoList.hasKey("RecycleGoodGetRewardIntegal"))
         {
            score = _serverConfigInfoList["RecycleGoodGetRewardIntegal"].Value;
         }
         return score;
      }
      
      public function get wasteRecycleLimit() : int
      {
         var score:int = 0;
         if(_serverConfigInfoList.hasKey("RecyGoodDayMaxTimes"))
         {
            score = _serverConfigInfoList["RecyGoodDayMaxTimes"].Value;
         }
         return score;
      }
      
      public function get fireWorksList() : Array
      {
         var fireWorksListStr:* = null;
         if(_serverConfigInfoList.hasKey("FireWorksList"))
         {
            fireWorksListStr = String(_serverConfigInfoList["FireWorksList"].Value);
            return fireWorksListStr.split("|");
         }
         return "12549,100,5,10,3|12550,50,5,10,3|12551,200,5,20,3|12552,200,5,20,1|12553,200,5,20,3".split("|");
      }
      
      public function get maxLevelAllResetCost() : int
      {
         var price:int = 0;
         if(_serverConfigInfoList.hasKey("MaxLevelAllResetCost"))
         {
            price = _serverConfigInfoList["MaxLevelAllResetCost"].Value;
         }
         return price;
      }
      
      public function get maxLevelResetCost() : int
      {
         var price:int = 0;
         if(_serverConfigInfoList.hasKey("MaxLevelResetCost"))
         {
            price = _serverConfigInfoList["MaxLevelResetCost"].Value;
         }
         return price;
      }
      
      public function get rewardTaskPrice() : int
      {
         var Price:int = 0;
         if(_serverConfigInfoList.hasKey("QuestOfferRefreshQuest"))
         {
            Price = _serverConfigInfoList["QuestOfferRefreshQuest"].Value;
         }
         return Price;
      }
      
      public function get rewardMultiplePrice() : int
      {
         var Price:int = 0;
         if(_serverConfigInfoList.hasKey("QuestOfferRefreshReward"))
         {
            Price = _serverConfigInfoList["QuestOfferRefreshReward"].Value;
         }
         return Price;
      }
      
      public function get addRewardTaskPrice() : int
      {
         var Price:int = 0;
         if(_serverConfigInfoList.hasKey("QuestOfferBuyTimes"))
         {
            Price = _serverConfigInfoList["QuestOfferBuyTimes"].Value;
         }
         return Price;
      }
      
      public function get taskNumber() : int
      {
         var Num:int = 0;
         if(_serverConfigInfoList.hasKey("QuestOfferCanAcceptTimes"))
         {
            Num = _serverConfigInfoList["QuestOfferCanAcceptTimes"].Value;
         }
         return Num;
      }
      
      public function get addTaskNumPrice() : int
      {
         var Num:int = 0;
         if(_serverConfigInfoList.hasKey("QuestOfferBuyTimesAddMoney"))
         {
            Num = _serverConfigInfoList["QuestOfferBuyTimesAddMoney"].Value;
         }
         return Num;
      }
      
      public function get consortiaGuardReviveRiches() : int
      {
         var Num:int = 100;
         if(_serverConfigInfoList.hasKey("GReliveCost"))
         {
            Num = _serverConfigInfoList["GReliveCost"].Value;
         }
         return Num;
      }
      
      public function get consortiaGuardOpenRiches() : int
      {
         var Num:int = 0;
         if(_serverConfigInfoList.hasKey("GOpenActiveCost"))
         {
            Num = _serverConfigInfoList["GOpenActiveCost"].Value;
         }
         return Num;
      }
      
      public function get consortiaGuardReviveTime() : int
      {
         var Num:int = 10;
         if(_serverConfigInfoList.hasKey("GReliveTime"))
         {
            Num = _serverConfigInfoList["GReliveTime"].Value;
         }
         return Num;
      }
      
      public function get consortiaGuardBuyCost() : int
      {
         var Num:int = 0;
         if(_serverConfigInfoList.hasKey("GBuyBUFFCost"))
         {
            Num = _serverConfigInfoList["GBuyBUFFCost"].Value;
         }
         return Num;
      }
      
      public function get consortiaGuardBuyBuffMaxLevel() : int
      {
         var Num:int = 1;
         if(_serverConfigInfoList.hasKey("GBuyBUFFMax"))
         {
            Num = _serverConfigInfoList["GBuyBUFFMax"].Value;
         }
         return Num;
      }
      
      public function get battleDungeonLimitCount() : int
      {
         var count:int = 1;
         if(_serverConfigInfoList.hasKey("TreasureTimes"))
         {
            count = _serverConfigInfoList["TreasureTimes"].Value;
         }
         return count;
      }
      
      public function get nightmareDungeonLimitTimes() : int
      {
         var times:int = 5;
         if(_serverConfigInfoList.hasKey("ChickOrAntTreasureTimes"))
         {
            times = _serverConfigInfoList["ChickOrAntTreasureTimes"].Value;
         }
         return times;
      }
      
      public function get nightmareDungeonLimitPower() : int
      {
         var power:int = 500000;
         if(_serverConfigInfoList.hasKey("ChickOrAntTreasureMinFightPower"))
         {
            power = _serverConfigInfoList["ChickOrAntTreasureMinFightPower"].Value;
         }
         return power;
      }
      
      public function get equipAmuletBuyDustMax() : int
      {
         var dust:int = 20;
         if(_serverConfigInfoList.hasKey("AmuletBuyDustMax"))
         {
            dust = _serverConfigInfoList["AmuletBuyDustMax"].Value;
         }
         return dust;
      }
      
      public function get AmuletBuyDustCountAndNeedMoney() : Array
      {
         var arr:Array = [];
         if(_serverConfigInfoList.hasKey("AmuletBuyDustCountAndNeedMoney"))
         {
            arr = _serverConfigInfoList["AmuletBuyDustCountAndNeedMoney"].Value.split("|");
         }
         return arr;
      }
      
      public function get WorshipMoonBeginDate() : String
      {
         var time:String = "";
         if(_serverConfigInfoList.hasKey("WorshipMoonBeginDate"))
         {
            time = _serverConfigInfoList["WorshipMoonBeginDate"].Value;
         }
         return time;
      }
      
      public function get WorshipMoonEndDate() : String
      {
         var time:String = "";
         if(_serverConfigInfoList.hasKey("WorshipMoonEndDate"))
         {
            time = _serverConfigInfoList["WorshipMoonEndDate"].Value;
         }
         return time;
      }
      
      public function get batchOpenConfig() : DictionaryData
      {
         var result:* = null;
         var temConfig:* = null;
         var itemArr:* = null;
         var i:int = 0;
         if(_catchBatchOpen == null)
         {
            _catchBatchOpen = new DictionaryData();
            result = null;
            if(_serverConfigInfoList.hasKey("BatchOpen"))
            {
               temConfig = _serverConfigInfoList["BatchOpen"].Value;
               result = temConfig.split("|");
               for(i = 0; i < result.length; )
               {
                  itemArr = (result[i] as String).split(",");
                  _catchBatchOpen.add(itemArr[0],itemArr[1]);
                  i++;
               }
            }
         }
         return _catchBatchOpen;
      }
      
      public function get cubeGameRow() : int
      {
         var row:int = 11;
         if(_serverConfigInfoList.hasKey("ComboSlashMaxRow"))
         {
            row = _serverConfigInfoList["ComboSlashMaxRow"].Value;
         }
         return row;
      }
      
      public function get cubeGameColumn() : int
      {
         var column:int = 14;
         if(_serverConfigInfoList.hasKey("ComboSlashMaxColumn"))
         {
            column = _serverConfigInfoList["ComboSlashMaxColumn"].Value;
         }
         return column;
      }
      
      public function get strongDestroyScore() : int
      {
         var value:int = 500;
         if(_serverConfigInfoList.hasKey("ComboSlashRemoveSevevenCountAddScore"))
         {
            value = _serverConfigInfoList["ComboSlashRemoveSevevenCountAddScore"].Value;
         }
         return value;
      }
      
      public function get extraDestroyScore() : int
      {
         var value:int = 1000;
         if(_serverConfigInfoList.hasKey("ComboSlashRemoveFourteenCountAddScore"))
         {
            value = _serverConfigInfoList["ComboSlashRemoveFourteenCountAddScore"].Value;
         }
         return value;
      }
      
      public function get emptyColumnScore() : int
      {
         var value:int = 100;
         if(_serverConfigInfoList.hasKey("ComboSlashNullCloumnScore"))
         {
            value = _serverConfigInfoList["ComboSlashNullCloumnScore"].Value;
         }
         return value;
      }
      
      public function get cubeGameCostEnergy() : int
      {
         var value:int = 2;
         if(_serverConfigInfoList.hasKey("CubeGameCostEnergy"))
         {
            value = _serverConfigInfoList["CubeGameCostEnergy"].Value;
         }
         return value;
      }
      
      public function get nationDayGetMaxTimes() : Array
      {
         var value:Array = [10,10,10,10];
         if(_serverConfigInfoList.hasKey("NationalDayExchangeTimes"))
         {
            value = String(_serverConfigInfoList["NationalDayExchangeTimes"].Value).split(",");
         }
         return value;
      }
      
      public function get pvePowerBuffLevelLimit() : int
      {
         var value:int = 20;
         if(_serverConfigInfoList.hasKey("BlessBuffOpenLv"))
         {
            value = _serverConfigInfoList["BlessBuffOpenLv"].Value;
         }
         return value;
      }
      
      public function get pvePowerBuffRefreshPrice() : int
      {
         var value:int = 100;
         if(_serverConfigInfoList.hasKey("BlessBuffRefreshPrice"))
         {
            value = _serverConfigInfoList["BlessBuffRefreshPrice"].Value;
         }
         return value;
      }
      
      public function get pvePowerBuffGetBuffPrice() : int
      {
         var value:int = 100;
         if(_serverConfigInfoList.hasKey("BlessBuffAddBuffPrice"))
         {
            value = _serverConfigInfoList["BlessBuffAddBuffPrice"].Value;
         }
         return value;
      }
      
      public function get ItemDevelopPrice() : int
      {
         var value:int = 35;
         if(_serverConfigInfoList.hasKey("ItemDevelopPrice"))
         {
            value = _serverConfigInfoList["ItemDevelopPrice"].Value;
         }
         return value;
      }
      
      public function get stockLoanRechageRate() : int
      {
         var value:int = 10;
         if(_serverConfigInfoList.hasKey("ExchangeMargin"))
         {
            value = _serverConfigInfoList["ExchangeMargin"].Value;
         }
         return value;
      }
      
      public function get StockOpenTime() : String
      {
         var value:String = "9,15|16,22";
         if(_serverConfigInfoList.hasKey("StockOpenTime"))
         {
            value = String(_serverConfigInfoList["StockOpenTime"].Value);
         }
         return value;
      }
      
      public function get StockStartDate() : String
      {
         var value:String = "2017-03-21 00:00:00";
         if(_serverConfigInfoList.hasKey("StockStartDate"))
         {
            value = String(_serverConfigInfoList["StockStartDate"].Value);
         }
         return value;
      }
      
      public function get StockEndDate() : String
      {
         var value:String = "2017-03-26 23:59:59";
         if(_serverConfigInfoList.hasKey("StockEndDate"))
         {
            value = String(_serverConfigInfoList["StockEndDate"].Value);
         }
         return value;
      }
      
      public function get StockOverDate() : String
      {
         var value:String = "2017-03-27 23:59:59";
         if(_serverConfigInfoList.hasKey("StockOverDate"))
         {
            value = String(_serverConfigInfoList["StockOverDate"].Value);
         }
         return value;
      }
      
      public function get StockScoreAward() : String
      {
         var value:String = "100000,1120956|200000,1120956|300000,1120956|400000,1120956|500000,1120956";
         if(_serverConfigInfoList.hasKey("StockReward"))
         {
            value = String(_serverConfigInfoList["StockReward"].Value);
         }
         return value;
      }
      
      public function get consortionActiveTarget() : String
      {
         var value:String = "1,30,3000,0|3,50,6000,2000|5,80,12000,4000";
         if(_serverConfigInfoList.hasKey("ConsortiaDayActiveCondInfo"))
         {
            value = String(_serverConfigInfoList["ConsortiaDayActiveCondInfo"].Value);
         }
         return value;
      }
      
      public function get getTeamCreateCoin() : int
      {
         var value:int = 30000;
         if(_serverConfigInfoList.hasKey("CreateTeamMoney"))
         {
            value = _serverConfigInfoList["CreateTeamMoney"].Value;
         }
         return value;
      }
      
      public function get getTeamDonatePrice() : int
      {
         var value:int = 10;
         if(_serverConfigInfoList.hasKey("MoneyRichesOffer"))
         {
            value = _serverConfigInfoList["MoneyRichesOffer"].Value;
         }
         return value;
      }
      
      public function get getOnlineArmCostEnergy() : int
      {
         var value:int = 3;
         if(_serverConfigInfoList.hasKey("OnlineArmCostEnergy"))
         {
            value = _serverConfigInfoList["OnlineArmCostEnergy"].Value;
         }
         return value;
      }
      
      public function get FreeInviteLevelMin() : int
      {
         var value:int = 5;
         if(_serverConfigInfoList.hasKey("FreeInviteLevelMin"))
         {
            value = _serverConfigInfoList["FreeInviteLevelMin"].Value;
         }
         return value;
      }
      
      public function get FreeInviteLevelMax() : int
      {
         var value:int = 15;
         if(_serverConfigInfoList.hasKey("FreeInviteLevelMax"))
         {
            value = _serverConfigInfoList["FreeInviteLevelMax"].Value;
         }
         return value;
      }
      
      public function get FreeInviteCount() : int
      {
         var value:int = 2;
         if(_serverConfigInfoList.hasKey("FreeInviteCount"))
         {
            value = _serverConfigInfoList["FreeInviteCount"].Value;
         }
         return value;
      }
      
      public function get markOpenLevel() : int
      {
         var value:int = 10;
         if(_serverConfigInfoList.hasKey("EngraveLimitLevel"))
         {
            value = _serverConfigInfoList["EngraveLimitLevel"].Value;
         }
         return value;
      }
      
      public function get EngraveSaleStarConfig() : int
      {
         var value:int = 200;
         if(_serverConfigInfoList.hasKey("EngraveSaleStarConfig"))
         {
            value = _serverConfigInfoList["EngraveSaleStarConfig"].Value;
         }
         return value;
      }
      
      public function get EngraveSaleTemperConsumeConfig() : int
      {
         var value:int = 60;
         if(_serverConfigInfoList.hasKey("EngraveSaleTemperConsumeConfig"))
         {
            value = _serverConfigInfoList["EngraveSaleTemperConsumeConfig"].Value;
         }
         return value;
      }
      
      public function get getEngraveVaults() : Array
      {
         var temStr:* = null;
         var arr:Array = [];
         if(_serverConfigInfoList.hasKey("EngraveVaultsConfig"))
         {
            temStr = _serverConfigInfoList["EngraveVaultsConfig"].Value;
            arr.push((temStr.split("|")[0] as String).split(","));
            arr.push((temStr.split("|")[1] as String).split(","));
         }
         return arr;
      }
      
      public function get getEngraveVaultsFreeTimes() : int
      {
         var value:int = 0;
         if(_serverConfigInfoList.hasKey("EngraveVaultsFreeTimes"))
         {
            value = _serverConfigInfoList["EngraveVaultsFreeTimes"].Value;
         }
         return value;
      }
      
      public function get devilTurnCfgBox() : Array
      {
         var arr:Array = [];
         if(_serverConfigInfoList.hasKey("DevilTreasureCfgBox"))
         {
            arr = _serverConfigInfoList["DevilTreasureCfgBox"].Value.split("|");
         }
         return arr;
      }
      
      public function get devilTurnTemplateID() : int
      {
         var value:int = 0;
         if(_serverConfigInfoList.hasKey("DevilTreasureTemplateID"))
         {
            value = _serverConfigInfoList["DevilTreasureTemplateID"].Value;
         }
         return value;
      }
      
      public function get devilTurnBeginDate() : String
      {
         var date:* = null;
         if(_serverConfigInfoList.hasKey("DevilTreasureBeginDate"))
         {
            date = String(_serverConfigInfoList["DevilTreasureBeginDate"].Value);
         }
         return date;
      }
      
      public function get devilTurnEndDate() : String
      {
         var date:* = null;
         if(_serverConfigInfoList.hasKey("DevilTreasureEndDate"))
         {
            date = String(_serverConfigInfoList["DevilTreasureEndDate"].Value);
         }
         return date;
      }
      
      public function get devilTurnLotteryOneCost() : int
      {
         var date:int = 0;
         if(_serverConfigInfoList.hasKey("DevilTreasureOneCost"))
         {
            date = _serverConfigInfoList["DevilTreasureOneCost"].Value;
         }
         return date;
      }
      
      public function get devilTurnLotteryTenCost() : int
      {
         var date:int = 0;
         if(_serverConfigInfoList.hasKey("DevilTreasureTenCost"))
         {
            date = _serverConfigInfoList["DevilTreasureTenCost"].Value;
         }
         return date;
      }
      
      public function get devilTurnTotalJackpot() : int
      {
         var value:int = 0;
         if(_serverConfigInfoList.hasKey("DevilTreasurePrizePoolMax"))
         {
            value = _serverConfigInfoList["DevilTreasurePrizePoolMax"].Value;
         }
         return value;
      }
      
      public function get devilTurnFreeLotteryCount() : int
      {
         var value:int = 0;
         if(_serverConfigInfoList.hasKey("DevilTreasureFreeLotteryCount"))
         {
            value = _serverConfigInfoList["DevilTreasureFreeLotteryCount"].Value;
         }
         return value;
      }
      
      public function get devilTurnOpenLevelLimit() : int
      {
         var value:int = 20;
         if(_serverConfigInfoList.hasKey("DevilTreasLevelLimit"))
         {
            value = _serverConfigInfoList["DevilTreasLevelLimit"].Value;
         }
         return value;
      }
      
      public function get consortiaTaskPriceArr() : Array
      {
         var arr:Array = [];
         if(_serverConfigInfoList.hasKey("ConsortiaMissionLockPrices"))
         {
            arr = _serverConfigInfoList["ConsortiaMissionLockPrices"].Value.split("|");
         }
         return arr;
      }
      
      public function get gameExitPunishTimes() : int
      {
         var value:int = 5;
         if(_serverConfigInfoList.hasKey("GamePvpExitPunish"))
         {
            value = String(_serverConfigInfoList["GamePvpExitPunish"].Value).split(",")[3];
         }
         return value;
      }
      
      public function get unrealContestBuyCost() : int
      {
         return int(findInfoByName("UnrealContestBuyCost").Value);
      }
      
      public function get unrealContestLevelLimits() : Array
      {
         return findInfoByName("UnrealContestLevelLimits").Value.split(",");
      }
      
      public function get unrealContestEndDate() : Date
      {
         return DateUtils.getDateByStr(findInfoByName("UnrealContestEndDate").Value);
      }
      
      public function get DreamLandId() : int
      {
         var value:int = 3000;
         if(_serverConfigInfoList.hasKey("UnrealContestPveID"))
         {
            value = _serverConfigInfoList["UnrealContestPveID"].Value;
         }
         return value;
      }
      
      public function get petWashCost() : DictionaryData
      {
         var temArr:* = null;
         var i:int = 0;
         var costArr:Array = findInfoByName("PetWashCost").Value.split("|");
         var result:DictionaryData = new DictionaryData();
         for(i = 0; i < costArr.length; )
         {
            temArr = String(costArr[i]).split(",");
            result.add(temArr[0],temArr[1]);
            i++;
         }
         return result;
      }
      
      public function get petQualityConfig() : Array
      {
         var qualityArr:Array = findInfoByName("PetQualityConfig").Value.split("|");
         var result:Array = qualityArr.sort(function():*
         {
            var /*UnknownSlot*/:* = function(A:int, B:int):int
            {
               if(A >= B)
               {
                  return 1;
               }
               return -1;
            };
            return function(A:int, B:int):int
            {
               if(A >= B)
               {
                  return 1;
               }
               return -1;
            };
         }());
         return result;
      }
      
      public function get clearWorldcupGuessPrice() : int
      {
         var value:int = 500;
         if(_serverConfigInfoList.hasKey("RussianWorldCupQuizChangeQuizPrize"))
         {
            value = _serverConfigInfoList["RussianWorldCupQuizChangeQuizPrize"].Value;
         }
         return value;
      }
      
      public function get worldcupBackRate() : Array
      {
         var arr:Array = [1,10,20,40,60,80,100];
         if(_serverConfigInfoList.hasKey("RussianWorldCupQuizBackRate"))
         {
            arr = _serverConfigInfoList["RussianWorldCupQuizBackRate"].Value.split("|");
         }
         return arr;
      }
      
      public function get worldcupAwardCount() : Array
      {
         var arr:Array = [1000,5000,30000,100000,300000,500000];
         if(_serverConfigInfoList.hasKey("RussianWorldCupQuizAwardCount"))
         {
            arr = _serverConfigInfoList["RussianWorldCupQuizAwardCount"].Value.split("|");
         }
         return arr;
      }
      
      public function get MarkEquipSchemePrice() : int
      {
         var value:int = 100;
         if(_serverConfigInfoList.hasKey("AddEngraveEquipSchemeCostMoney"))
         {
            value = _serverConfigInfoList["AddEngraveEquipSchemeCostMoney"].Value;
         }
         return value;
      }
      
      public function get OldPlayerTaskRemainTime() : String
      {
         return _serverConfigInfoList["TurnZoneQuestDay"].Value;
      }
      
      public function get OldPlayerActiveRemainTime() : String
      {
         return _serverConfigInfoList["TurnZoneValidDay"].Value;
      }
   }
}
