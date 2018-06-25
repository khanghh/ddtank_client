package ddt.data.player{   import bagAndInfo.BagAndInfoManager;   import com.pickgliss.manager.NoviceDataManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.Experience;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import flash.events.EventDispatcher;   import flash.net.URLRequest;   import flash.net.URLVariables;   import flash.net.sendToURL;   import flash.utils.Dictionary;   import pvePowerBuff.PvePowerBuffManager;   import wonderfulActivity.WonderfulActivityManager;      [Event(name="propertychange",type="ddt.events.PlayerPropertyEvent")]   [Event(name="gold_change",type="tank.data.player.PlayerPropertyEvent")]   public class BasePlayer extends EventDispatcher   {            public static const BADGE_ID:String = "badgeid";            public static const JUNIOR_VIP:int = 1;            public static const SENIOR_VIP:int = 2;                   private var _zoneID:int;            public var zoneName:String;            public var ID:Number;            public var targetId:int;            public var LoginName:String;            private var _activityTanabataNum:int;            protected var _nick:String;            public var Sex:Boolean;            public var WinCount:int;            public var EscapeCount:int;            private var _totalCount:int = 0;            private var _isFirstDivorce:int;            private var _repute:int;            protected var _grade:int;            private var _ddtKingGrade:int = 0;            private var _IsUpGrade:Boolean;            private var _headURLPicGirl:String = "";            public var IsShow:Boolean = false;            private var _createPlayerDate:Date;            public var isUpGradeInGame:Boolean = false;            private var _fightPower:int;            private var _matchInfo:MatchInfo;            private var _leagueFirst:Boolean;            private var _lasetWeekScore:Number;            public var _score:Number = 0;            private var _CardSoul:int;            private var _gP:int;            private var _offer:int;            private var _sign:Boolean;            private var _GetSoulCount:int;            private var _state:PlayerState;            private var _typeVIP:int = 0;            private var _snapVip:Boolean;            public var VIPLevel:int = 1;            public var VIPExp:int;            public var isOpenKingBless:Boolean;            private var _honor:String = "";            public var honorId:int;            private var _achievementPoint:int;            private var _isMarried:Boolean;            public var SpouseID:int;            private var _spouseName:String;            public var ConsortiaID:int = 0;            public var ConsortiaName:String;            public var DutyLevel:int;            private var _dutyName:String;            private var _right:int;            private var _RichesRob:int;            private var _RichesOffer:int;            private var _UseOffer:int;            private var _badgeID:int = 0;            private var _apprenticeshipState:int;            public var LastLoginDate:Date;            private var _hpTexpExp:int = -1;            private var _attTexpExp:int = -1;            private var _defTexpExp:int = -1;            private var _spdTexpExp:int = -1;            private var _lukTexpExp:int = -1;            private var _magicAtkTexpExp:int = -1;            private var _magicDefTexpExp:int = -1;            private var _critTexpExp:int = -1;            private var _sunderArmorTexpExp:int = -1;            private var _critDmgTexpExp:int = -1;            private var _speedTexpExp:int = -1;            private var _uniqueSkillTexpExp:int = -1;            private var _dmgTexpExp:int = -1;            private var _armorDefTexpExp:int = -1;            private var _texpCount:int;            private var _magicTexpCount:int;            private var _nsTexpCount:int;            private var _texpTaskCount:int;            private var _texpTaskDate:Date;            protected var _changeCount:int = 0;            protected var _changedPropeties:Dictionary;            protected var _lastValue:Dictionary;            private var _treasure:int;            private var _treasureAdd:int;            protected var _isOld:Boolean = false;            protected var _isOld2:Boolean = false;            private var _desertEnterCount:int = 0;            public var BattleCount:int = 0;            public var VipIntegral:int = 0;            public var Rank:int = 0;            private var _mountsType:int = 0;            private var _showMounts:Boolean = true;            public var RingExp:int = 0;            private var _petsID:int;            private var _isAttest:Boolean = false;            public var teamID:int;            public var teamName:String;            public var teamTag:String;            public var teamGrade:int;            public var teamWinTime:int;            public var teamTotalTime:int;            public var teamDivision:int;            public var teamScore:int;            public var teamDuty:int;            public var teamPersonalScore:int;            public var teamLoginDate:Date;            public function BasePlayer() { super(); }
            public function set ZoneID(zoneID:int) : void { }
            public function get ZoneID() : int { return 0; }
            public function set NickName(value:String) : void { }
            public function get NickName() : String { return null; }
            public function get TotalCount() : int { return 0; }
            public function set TotalCount(value:int) : void { }
            public function set isFirstDivorce(value:int) : void { }
            public function get isFirstDivorce() : int { return 0; }
            public function get Repute() : int { return 0; }
            public function set Repute(value:int) : void { }
            public function get Grade() : int { return 0; }
            public function set Grade(value:int) : void { }
            public function get ddtKingGrade() : int { return 0; }
            public function set ddtKingGrade(value:int) : void { }
            public function get IsUpGrade() : Boolean { return false; }
            public function set IsUpGrade(value:Boolean) : void { }
            public function get ImagePath() : String { return null; }
            public function set ImagePath(value:String) : void { }
            public function get createPlayerDate() : Date { return null; }
            public function set createPlayerDate(value:Date) : void { }
            private function noticeGrade() : void { }
            public function get FightPower() : int { return 0; }
            public function get matchInfo() : MatchInfo { return null; }
            public function set matchInfo(value:MatchInfo) : void { }
            public function get DailyLeagueFirst() : Boolean { return false; }
            public function set DailyLeagueFirst(value:Boolean) : void { }
            public function get DailyLeagueLastScore() : Number { return 0; }
            public function set DailyLeagueLastScore(value:Number) : void { }
            public function set FightPower(value:int) : void { }
            public function get Score() : Number { return 0; }
            public function set Score(value:Number) : void { }
            public function get CardSoul() : int { return 0; }
            public function set CardSoul(value:int) : void { }
            public function get GP() : int { return 0; }
            public function set GP(value:int) : void { }
            public function get Offer() : int { return 0; }
            public function set Offer(value:int) : void { }
            public function get Sign() : Boolean { return false; }
            public function set Sign(value:Boolean) : void { }
            public function get GetSoulCount() : int { return 0; }
            public function set GetSoulCount(value:int) : void { }
            public function get playerState() : PlayerState { return null; }
            public function set playerState(value:PlayerState) : void { }
            public function get IsVIP() : Boolean { return false; }
            public function set IsVIP(value:Boolean) : void { }
            public function set typeVIP(value:int) : void { }
            public function get typeVIP() : int { return 0; }
            public function set snapVip(value:Boolean) : void { }
            public function get snapVip() : Boolean { return false; }
            public function get honor() : String { return null; }
            public function set honor(value:String) : void { }
            public function get AchievementPoint() : int { return 0; }
            public function set AchievementPoint(value:int) : void { }
            public function set SpouseName(value:String) : void { }
            public function get SpouseName() : String { return null; }
            public function set IsMarried(value:Boolean) : void { }
            public function get IsMarried() : Boolean { return false; }
            public function get DutyName() : String { return null; }
            public function set DutyName(value:String) : void { }
            public function get Right() : int { return 0; }
            public function set Right(value:int) : void { }
            public function get RichesRob() : int { return 0; }
            public function set RichesRob(value:int) : void { }
            public function get RichesOffer() : int { return 0; }
            public function set RichesOffer(value:int) : void { }
            public function get UseOffer() : int { return 0; }
            public function set UseOffer(value:int) : void { }
            public function get Riches() : int { return 0; }
            public function set Riches(value:int) : void { }
            public function get badgeID() : int { return 0; }
            public function set badgeID(value:int) : void { }
            public function set apprenticeshipState(value:int) : void { }
            public function get apprenticeshipState() : int { return 0; }
            public function get hpTexpExp() : int { return 0; }
            public function set hpTexpExp(value:int) : void { }
            public function get attTexpExp() : int { return 0; }
            public function set attTexpExp(value:int) : void { }
            public function get defTexpExp() : int { return 0; }
            public function set defTexpExp(value:int) : void { }
            public function get spdTexpExp() : int { return 0; }
            public function set spdTexpExp(value:int) : void { }
            public function get lukTexpExp() : int { return 0; }
            public function set lukTexpExp(value:int) : void { }
            public function get magicAtkTexpExp() : int { return 0; }
            public function set magicAtkTexpExp(value:int) : void { }
            public function get magicDefTexpExp() : int { return 0; }
            public function set magicDefTexpExp(value:int) : void { }
            public function get critTexpExp() : int { return 0; }
            public function set critTexpExp(value:int) : void { }
            public function get sunderArmorTexpExp() : int { return 0; }
            public function set sunderArmorTexpExp(value:int) : void { }
            public function get critDmgTexpExp() : int { return 0; }
            public function set critDmgTexpExp(value:int) : void { }
            public function get speedTexpExp() : int { return 0; }
            public function set speedTexpExp(value:int) : void { }
            public function get uniqueSkillTexpExp() : int { return 0; }
            public function set uniqueSkillTexpExp(value:int) : void { }
            public function get dmgTexpExp() : int { return 0; }
            public function set dmgTexpExp(value:int) : void { }
            public function get armorDefTexpExp() : int { return 0; }
            public function set armorDefTexpExp(value:int) : void { }
            public function get texpCount() : int { return 0; }
            public function set texpCount(value:int) : void { }
            public function get magicTexpCount() : int { return 0; }
            public function set magicTexpCount(value:int) : void { }
            public function get nsTexpCount() : int { return 0; }
            public function set nsTexpCount(value:int) : void { }
            public function get texpTaskCount() : int { return 0; }
            public function set texpTaskCount(value:int) : void { }
            public function get texpTaskDate() : Date { return null; }
            public function set texpTaskDate(value:Date) : void { }
            public function beginChanges() : void { }
            public function commitChanges() : void { }
            protected function onPropertiesChanged(propName:String = null) : void { }
            public function get treasure() : int { return 0; }
            public function set treasure(value:int) : void { }
            public function get treasureAdd() : int { return 0; }
            public function set treasureAdd(value:int) : void { }
            public function get isOld() : Boolean { return false; }
            public function set isOld(value:Boolean) : void { }
            public function get isOld2() : Boolean { return false; }
            public function set isOld2(value:Boolean) : void { }
            public function updateProperties() : void { }
            public function get activityTanabataNum() : int { return 0; }
            public function get desertEnterCount() : int { return 0; }
            public function set desertEnterCount(value:int) : void { }
            public function set activityTanabataNum(value:int) : void { }
            public function get MountsType() : int { return 0; }
            public function set MountsType(value:int) : void { }
            public function get IsMounts() : Boolean { return false; }
            public function get showMounts() : Boolean { return false; }
            public function set showMounts(value:Boolean) : void { }
            public function get PetsID() : int { return 0; }
            public function set PetsID(value:int) : void { }
            public function get isPetsFollow() : Boolean { return false; }
            public function getPetsPosIndex() : int { return 0; }
            public function get isAttest() : Boolean { return false; }
            public function set isAttest(value:Boolean) : void { }
   }}