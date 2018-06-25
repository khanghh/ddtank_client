package ddt.data.player{   import cardSystem.CardManager;   import cardSystem.data.CardInfo;   import cardSystem.data.SetsInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.BagInfo;   import ddt.data.BuffInfo;   import ddt.data.EquipType;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.GameEvent;   import ddt.events.WebSpeedEvent;   import ddt.manager.ItemManager;   import ddt.manager.PlayerManager;   import ddt.manager.TimeManager;   import explorerManual.data.model.PlayerManualProInfo;   import flash.events.Event;   import flash.utils.Dictionary;   import gemstone.info.GemstonInitInfo;   import giftSystem.MyGiftCellInfo;   import horse.HorseAmuletManager;   import mark.MarkMgr;   import mark.data.MarkBagData;   import mark.data.MarkChipData;   import mark.data.MarkProData;   import mark.data.MarkSuitTemplateData;   import pet.data.PetInfo;   import road7th.data.DictionaryData;   import store.data.StoreEquipExperience;   import store.equipGhost.data.EquipGhostData;   import store.view.embed.EmbedUpLevelCell;   import trainer.controller.NewHandGuideManager;      public class PlayerInfo extends BasePlayer   {            public static const SEX:String = "Sex";            public static const STYLE:String = "Style";            public static const HIDE:String = "Hide";            public static const SKIN:String = "Skin";            public static const COLORS:String = "Colors";            public static const NIMBUS:String = "Nimbus";            public static const GOLD:String = "Gold";            public static const MONEY:String = "Money";            public static const DDT_MONEY:String = "Money";            public static const BandMONEY:String = "BandMoney";            public static const JampsCurrency:String = "jampsCurrency";            public static const Energy:String = "Energy";            public static const BuyEnergyCount:String = "BuyEnergyCount";            public static const PETSCORE:String = "PetScore";            public static const ARM:String = "WeaponID";            public static const UPDATE_SHOP_FINALLY_TIME:String = "shopFinallyGottenTime";            public static const MOUNTS_TYPE:String = "mountsType";            public static const PETSID:String = "petsID";            public static const CHARM_LEVEL_NEED_EXP:Array = [0,10,50,120,210,320,450,600,770,960,1170,1410,1680,1980,2310,2670,3060,3480,3930,4410,4920,5470,6060,6690,7360,8070,8820,9610,10440,11310,12220,13190,14220,15310,16460,17670,18940,20270,21660,23110,25110,27660,30760,34410,38610,43360,48660,54510,60910,67860,75360,83460,92160,101460,111360,121860,132960,144660,156960,169860,183360,197460,212160,227460,243360,259860,276960,294660,312960,331860,351360,371460,392160,413460,435360,457860,480960,504660,528960,553860,579360,605460,632160,659460,687360,715860,744960,774660,804960,835860,867360,899460,932160,965460,999360,1033860,1068960,1104660,1140960,1177860];            public static const CHARM_LEVEL_ALL_EXP:Array = [0,10,60,180,390,710,1160,1760,2530,3490,4660,6070,7750,9730,12040,14710,17770,21250,25180,29590,34510,39980,46040,52730,60090,68160,76980,86590,97030,108340,120560,133750,147970,163280,179740,197410,216350,236620,258280,281390,306500,334160,364920,399330,437940,481300,529960,584470,645380,713240,788600,872060,964220,1065680,1177040,1298900,1431860,1576520,1733480,1903340,2086700,2284160,2496320,2723780,2967140,3227000,3503960,3798620,4111580,4443440,4794800,5166260,5558420,5971880,6407240,6865100,7346060,7850720,8379680,8933540,9512900,10118360,10750520,11409980,12097340,12813200,13558160,14332820,15137780,15973640,16841000,17740460,18672620,19638080,20637440,21671300,22740260,23844920,24985880,26163740];            public static const MAX_CHARM_LEVEL:int = 100;            public static const ESSENCE:String = "Essence";                   public var petsEatWeaponLevel:int;            public var petsEatClothesLevel:int;            public var petsEatHatLevel:int;            public var Markbag:MarkBagData;            private var _curcentRoomBordenTemplateId:int;            public var signMsg:String = "";            private var _lastLuckNum:int;            private var _luckyNum:int;            private var _lastLuckyNumDate:Date;            private var _attachtype:int = -1;            private var _attachvalue:int;            private var _hide:int;            private var _hidehat:Boolean;            private var _hideGlass:Boolean = false;            private var _suitesHide:Boolean = false;            private var _showSuits:Boolean = true;            private var _wingHide:Boolean = false;            private var _nimbus:int;            private var _modifyStyle:String;            private var _style:String;            private var _tutorialProgress:int;            private var _colors:String = "|,|,,,,||,,,,";            private var _intuitionalColor:String = "";            private var _skin:String;            private var _paopaoType:int = 0;            public var SuperAttack:int;            public var Delay:int;            private var _attack:int;            private var _answerSite:int;            private var _defence:int;            private var _luck:int;            private var _hp:int;            public var increaHP:int;            private var _agility:int;            private var _magicAttack:int;            private var _magicDefence:int;            private var _dungeonFlag:Object;            private var _propertyAddition:DictionaryData;            private var _bag:BagInfo;            public var _beadBag:BagInfo;            private var _deputyWeaponID:int = 0;            private var _webSpeed:int;            private var _weaponID:int;            protected var _buffInfo:DictionaryData;            private var _pvePermission:String;            public var _isDupSimpleTip:Boolean = false;            private var _fightLibMission:String;            private var _lastSpaDate:Object;            private var _pveEpicPermission:String;            private var _masterOrApprentices:DictionaryData;            private var _masterID:int;            private var _graduatesCount:int;            private var _honourOfMaster:String = "";            public var _freezesDate:Date;            private var _myGiftData:Vector.<MyGiftCellInfo>;            private var _charmLevel:int;            private var _charmGP:int;            private var _cardEquipDic:DictionaryData;            private var _cardBagDic:DictionaryData;            public var OptionOnOff:int;            private var _shopFinallyGottenTime:Date;            private var _lastDate:Date;            private var _isSameCity:Boolean;            private var _IsShowConsortia:Boolean;            private var _badLuckNumber:int;            protected var _isSelf:Boolean = false;            protected var _pets:DictionaryData;            private var _damageScores:int = 0;            private var _embedUpLevelCell:EmbedUpLevelCell;            private var _totemId:int;            private var _totemGrades:DictionaryData;            private var _gemstoneList:Vector.<GemstonInitInfo>;            private var _hardCurrency:int;            private var _jampsCurrency:int;            private var _leagueMoney:int;            private var _necklaceExp:int;            private var _necklaceLevel:int;            private var _necklaceExpAdd:int;            private var _pvpBadgeId:int;            public var Damage:int;            public var Blood:int;            public var Energy:int;            public var Guard:int;            private var _isTrusteeship:Boolean;            private var _fightStatus:int;            private var _accumulativeLoginDays:int;            private var _accumulativeAwardDays:int;            private var _evolutionGrade:int;            public var DungeonExpTotalNum:int;            public var DungeonExpReceiveNum:int;            private var _evolutionExp:int;            private var _horseInBookRidingID:int = 0;            private var _horsePicCherishBlood:int;            private var _horsePicCherishGuard:int;            private var _horsePicCherishHurt:int;            private var _horsePicCherishMagicAttack:int;            private var _horsePicCherishMagicDefence:int;            private var _horsePicCherishDic:DictionaryData;            private var _peerID:String;            public var curHorseLevel:int;            private var _fineSuitExp:int;            public var cardAchievementDamage:int;            public var cardAchievementArmor:int;            public var cardAchievementHp:int;            private var _guardCoreGrade:int;            private var _guardCoreID:int;            private var _experience_Rate:Number;            private var _offer_Rate:Number;            private var _trailEliteLevel:int;            private var _stive:int;            private var _manualProInfo:PlayerManualProInfo;            private var _horseAmuletHp:int;            public var horseAmuletProperty:Array;            private var _ghostDic:Dictionary = null;            public function PlayerInfo() { super(); }
            public function get curcentRoomBordenTemplateId() : int { return 0; }
            public function set curcentRoomBordenTemplateId(value:int) : void { }
            override public function updateProperties() : void { }
            private function parseHide() : void { }
            private function parseStyle() : void { }
            public function get lastLuckNum() : int { return 0; }
            public function set lastLuckNum(value:int) : void { }
            public function get luckyNum() : int { return 0; }
            public function set luckyNum(value:int) : void { }
            public function get lastLuckyNumDate() : Date { return null; }
            public function set lastLuckyNumDate(value:Date) : void { }
            public function get attachtype() : int { return 0; }
            public function get attachvalue() : int { return 0; }
            private function parseColos() : void { }
            public function get Hide() : int { return 0; }
            public function set Hide(value:int) : void { }
            public function getHatHide() : Boolean { return false; }
            public function setHatHide(value:Boolean) : void { }
            public function getGlassHide() : Boolean { return false; }
            public function setGlassHide(value:Boolean) : void { }
            public function getSuitesHide() : Boolean { return false; }
            public function setSuiteHide(value:Boolean) : void { }
            public function getShowSuits() : Boolean { return false; }
            public function get wingHide() : Boolean { return false; }
            public function set wingHide(value:Boolean) : void { }
            public function set Nimbus(nim:int) : void { }
            public function get Nimbus() : int { return 0; }
            public function getHaveLight() : Boolean { return false; }
            public function getHaveCircle() : Boolean { return false; }
            public function get Style() : String { return null; }
            public function set Style(value:String) : void { }
            public function getHairType() : int { return 0; }
            public function getSuitsType() : int { return 0; }
            public function getPrivateStyle() : String { return null; }
            public function get TutorialProgress() : int { return 0; }
            public function set TutorialProgress(value:int) : void { }
            public function setPartStyle(categoryId:int, needsex:int, templateId:int = -1, color:String = "", dispatch:Boolean = true) : void { }
            private function jionPic(tid:String, pic:String) : String { return null; }
            private function getTID(s:String) : String { return null; }
            private function replaceTID(original:String, tid:String, useTemplatePic:Boolean = true) : String { return null; }
            public function getPartStyle(categoryId:int) : int { return 0; }
            public function get Colors() : String { return null; }
            public function set Colors(value:String) : void { }
            public function getDressColor() : String { return null; }
            private function colorEqual(color_1:String, color_2:String) : Boolean { return false; }
            public function setPartColor(id:int, color:String) : void { }
            public function getPartColor(id:int) : String { return null; }
            public function setSkinColor(color:String) : void { }
            public function set Skin(color:String) : void { }
            public function get Skin() : String { return null; }
            public function getSkinColor() : String { return null; }
            public function clearColors() : void { }
            public function updateStyle(sex:Boolean, hide:int, style:String, colors:String, skin:String) : void { }
            public function get paopaoType() : int { return 0; }
            public function get Attack() : int { return 0; }
            public function set Attack(value:int) : void { }
            public function set userGuildProgress(p:int) : void { }
            public function get userGuildProgress() : int { return 0; }
            public function get Defence() : int { return 0; }
            public function set Defence(value:int) : void { }
            public function get Luck() : int { return 0; }
            public function set Luck(value:int) : void { }
            public function get hp() : int { return 0; }
            public function set hp(value:int) : void { }
            public function get Agility() : int { return 0; }
            public function set Agility(value:int) : void { }
            public function get MagicAttack() : int { return 0; }
            public function set MagicAttack(value:int) : void { }
            public function get MagicDefence() : int { return 0; }
            public function set MagicDefence(value:int) : void { }
            public function setAttackDefenseValues(attack:int, defense:int, agility:int, luck:int, magicAttack:int, magicDefence:int) : void { }
            public function get dungeonFlag() : Object { return null; }
            public function set dungeonFlag(value:Object) : void { }
            public function get propertyAddition() : DictionaryData { return null; }
            public function set propertyAddition(val:DictionaryData) : void { }
            public function getPropertyAdditionByType(type:String) : DictionaryData { return null; }
            public function get Bag() : BagInfo { return null; }
            public function get BeadBag() : BagInfo { return null; }
            public function get DeputyWeapon() : InventoryItemInfo { return null; }
            public function set DeputyWeaponID(value:int) : void { }
            public function get DeputyWeaponID() : int { return 0; }
            public function get webSpeed() : int { return 0; }
            public function set webSpeed(value:int) : void { }
            public function get WeaponID() : int { return 0; }
            public function set WeaponID(value:int) : void { }
            public function set paopaoType(type:int) : void { }
            public function get buffInfo1() : DictionaryData { return null; }
            protected function set buffInfo6(buffs:DictionaryData) : void { }
            public function addBuff(buff:BuffInfo) : void { }
            public function clearBuff() : void { }
            public function hasBuff(buffType:int) : Boolean { return false; }
            public function getBuff(buffType:int) : BuffInfo { return null; }
            public function get PvePermission() : String { return null; }
            public function set PvePermission(permission:String) : void { }
            public function get fightLibMission() : String { return null; }
            public function set fightLibMission(value:String) : void { }
            public function get LastSpaDate() : Object { return null; }
            public function set LastSpaDate(value:Object) : void { }
            public function set PveEpicPermission(value:String) : void { }
            public function get PveEpicPermission() : String { return null; }
            public function setMasterOrApprentices(value:String) : void { }
            public function getMasterOrApprentices() : DictionaryData { return null; }
            public function set masterID(value:int) : void { }
            public function get masterID() : int { return 0; }
            public function isMyMaster(id:int) : Boolean { return false; }
            public function isMyApprent(id:int) : Boolean { return false; }
            public function set graduatesCount(value:int) : void { }
            public function get graduatesCount() : int { return 0; }
            public function set honourOfMaster(value:String) : void { }
            public function get honourOfMaster() : String { return null; }
            public function set freezesDate(value:Date) : void { }
            public function get freezesDate() : Date { return null; }
            public function set myGiftData(list:Vector.<MyGiftCellInfo>) : void { }
            public function get myGiftData() : Vector.<MyGiftCellInfo> { return null; }
            public function get giftSum() : int { return 0; }
            public function set charmLevel(value:int) : void { }
            public function get charmLevel() : int { return 0; }
            public function set charmGP(value:int) : void { }
            private function getCharLevel(value:int) : int { return 0; }
            public function get charmGP() : int { return 0; }
            public function get cardEquipDic() : DictionaryData { return null; }
            public function set cardEquipDic(value:DictionaryData) : void { }
            public function get cardBagDic() : DictionaryData { return null; }
            public function set cardBagDic(value:DictionaryData) : void { }
            public function getCardInfoByID(id:int) : CardInfo { return null; }
            public function getCardNumByType(type:int) : int { return 0; }
            public function checkCurrentCardSets(id:int, type:int = 3) : Boolean { return false; }
            public function getCurrentCardSetsNum(id:int, type:int = 3) : int { return 0; }
            public function gainCardSetsNum(type:int) : int { return 0; }
            public function getOptionState(OptionType:int) : Boolean { return false; }
            public function get shopFinallyGottenTime() : Date { return null; }
            public function set shopFinallyGottenTime(value:Date) : void { }
            public function getLastDate() : int { return 0; }
            public function set lastDate(value:Date) : void { }
            public function get lastDate() : Date { return null; }
            public function get isSameCity() : Boolean { return false; }
            public function set isSameCity(value:Boolean) : void { }
            public function set IsShowConsortia(boo:Boolean) : void { }
            public function get IsShowConsortia() : Boolean { return false; }
            public function get showDesignation() : String { return null; }
            public function get badLuckNumber() : int { return 0; }
            public function set badLuckNumber(value:int) : void { }
            public function shouldShowAcademyIcon() : Boolean { return false; }
            public function get isSelf() : Boolean { return false; }
            public function set isSelf(value:Boolean) : void { }
            public function get pets() : DictionaryData { return null; }
            public function get currentPet() : PetInfo { return null; }
            public function set damageScores(value:int) : void { }
            public function get damageScores() : int { return 0; }
            public function get embedUpLevelCell() : EmbedUpLevelCell { return null; }
            public function set embedUpLevelCell(value:EmbedUpLevelCell) : void { }
            public function get totemId() : int { return 0; }
            public function set totemId(value:int) : void { }
            public function addTotemGrade(totemID:int, grade:int) : void { }
            public function getTotemGradeByID(chapterID:int) : int { return 0; }
            public function get totemGrades() : DictionaryData { return null; }
            public function set gemstoneList(list:Vector.<GemstonInitInfo>) : void { }
            public function get gemstoneList() : Vector.<GemstonInitInfo> { return null; }
            public function get hardCurrency() : int { return 0; }
            public function set hardCurrency(value:int) : void { }
            public function get jampsCurrency() : int { return 0; }
            public function set jampsCurrency(value:int) : void { }
            public function get leagueMoney() : int { return 0; }
            public function set leagueMoney(value:int) : void { }
            public function get necklaceExp() : int { return 0; }
            public function set necklaceExp(value:int) : void { }
            public function get necklaceLevel() : int { return 0; }
            public function set necklaceLevel(value:int) : void { }
            public function get necklaceExpAdd() : int { return 0; }
            public function set necklaceExpAdd(value:int) : void { }
            public function get pvpBadgeId() : int { return 0; }
            public function set pvpBadgeId(value:int) : void { }
            public function get isTrusteeship() : Boolean { return false; }
            public function set isTrusteeship(value:Boolean) : void { }
            public function get fightStatus() : int { return 0; }
            public function set fightStatus(value:int) : void { }
            public function get accumulativeLoginDays() : int { return 0; }
            public function set accumulativeLoginDays(value:int) : void { }
            public function get accumulativeAwardDays() : int { return 0; }
            public function set accumulativeAwardDays(value:int) : void { }
            public function get evolutionGrade() : int { return 0; }
            public function set evolutionGrade(value:int) : void { }
            public function get evolutionExp() : int { return 0; }
            public function set evolutionExp(value:int) : void { }
            public function get horsePicCherishBlood() : int { return 0; }
            public function set horsePicCherishBlood(value:int) : void { }
            public function get horsePicCherishGuard() : int { return 0; }
            public function set horsePicCherishGuard(value:int) : void { }
            public function get horsePicCherishHurt() : int { return 0; }
            public function set horsePicCherishHurt(value:int) : void { }
            public function get horsePicCherishMagicAttack() : int { return 0; }
            public function set horsePicCherishMagicAttack(value:int) : void { }
            public function get horsePicCherishMagicDefence() : int { return 0; }
            public function set horsePicCherishMagicDefence(value:int) : void { }
            public function get horsePicCherishDic() : DictionaryData { return null; }
            public function set peerID(id:String) : void { }
            public function get peerID() : String { return null; }
            public function get horseInBookRidingID() : int { return 0; }
            public function set horseInBookRidingID(value:int) : void { }
            public function get fineSuitExp() : int { return 0; }
            public function set fineSuitExp(value:int) : void { }
            public function get guardCoreGrade() : int { return 0; }
            public function set guardCoreGrade(value:int) : void { }
            public function get guardCoreID() : int { return 0; }
            public function set guardCoreID(value:int) : void { }
            public function get experience_Rate() : Number { return 0; }
            public function set experience_Rate(value:Number) : void { }
            public function get offer_Rate() : Number { return 0; }
            public function set offer_Rate(value:Number) : void { }
            public function get trailEliteLevel() : int { return 0; }
            public function set trailEliteLevel(value:int) : void { }
            public function get manualProInfo() : PlayerManualProInfo { return null; }
            public function get horseAmuletHp() : int { return 0; }
            public function set horseAmuletHp(value:int) : void { }
            public function addGhostData(data:EquipGhostData) : void { }
            public function getGhostData(bagType:int, place:int) : EquipGhostData { return null; }
            public function getGhostDataByCategoryID(categoryID:int) : EquipGhostData { return null; }
            public function getMarkChipCntByPlace(place:int) : int { return 0; }
            public function getMarkChipPropsByPlace(place:int) : Dictionary { return null; }
            public function getSuitListByPlace(place:int) : Array { return null; }
            public function clone() : PlayerInfo { return null; }
   }}