package ddt.data.player
{
   import bagAndInfo.BagAndInfoManager;
   import com.pickgliss.manager.NoviceDataManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.Experience;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import flash.events.EventDispatcher;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.sendToURL;
   import flash.utils.Dictionary;
   import pvePowerBuff.PvePowerBuffManager;
   import wonderfulActivity.WonderfulActivityManager;
   
   [Event(name="propertychange",type="ddt.events.PlayerPropertyEvent")]
   [Event(name="gold_change",type="tank.data.player.PlayerPropertyEvent")]
   public class BasePlayer extends EventDispatcher
   {
      
      public static const BADGE_ID:String = "badgeid";
      
      public static const JUNIOR_VIP:int = 1;
      
      public static const SENIOR_VIP:int = 2;
       
      
      private var _zoneID:int;
      
      public var zoneName:String;
      
      public var ID:Number;
      
      public var targetId:int;
      
      public var LoginName:String;
      
      private var _activityTanabataNum:int;
      
      protected var _nick:String;
      
      public var Sex:Boolean;
      
      public var WinCount:int;
      
      public var EscapeCount:int;
      
      private var _totalCount:int = 0;
      
      private var _isFirstDivorce:int;
      
      private var _repute:int;
      
      protected var _grade:int;
      
      private var _ddtKingGrade:int = 0;
      
      private var _IsUpGrade:Boolean;
      
      private var _headURLPicGirl:String = "";
      
      public var IsShow:Boolean = false;
      
      private var _createPlayerDate:Date;
      
      public var isUpGradeInGame:Boolean = false;
      
      private var _fightPower:int;
      
      private var _matchInfo:MatchInfo;
      
      private var _leagueFirst:Boolean;
      
      private var _lasetWeekScore:Number;
      
      public var _score:Number = 0;
      
      private var _CardSoul:int;
      
      private var _gP:int;
      
      private var _offer:int;
      
      private var _sign:Boolean;
      
      private var _GetSoulCount:int;
      
      private var _state:PlayerState;
      
      private var _typeVIP:int = 0;
      
      private var _snapVip:Boolean;
      
      public var VIPLevel:int = 1;
      
      public var VIPExp:int;
      
      public var isOpenKingBless:Boolean;
      
      private var _honor:String = "";
      
      public var honorId:int;
      
      private var _achievementPoint:int;
      
      private var _isMarried:Boolean;
      
      public var SpouseID:int;
      
      private var _spouseName:String;
      
      public var ConsortiaID:int = 0;
      
      public var ConsortiaName:String;
      
      public var DutyLevel:int;
      
      private var _dutyName:String;
      
      private var _right:int;
      
      private var _RichesRob:int;
      
      private var _RichesOffer:int;
      
      private var _UseOffer:int;
      
      private var _badgeID:int = 0;
      
      private var _apprenticeshipState:int;
      
      public var LastLoginDate:Date;
      
      private var _hpTexpExp:int = -1;
      
      private var _attTexpExp:int = -1;
      
      private var _defTexpExp:int = -1;
      
      private var _spdTexpExp:int = -1;
      
      private var _lukTexpExp:int = -1;
      
      private var _magicAtkTexpExp:int = -1;
      
      private var _magicDefTexpExp:int = -1;
      
      private var _texpCount:int;
      
      private var _magicTexpCount:int;
      
      private var _texpTaskCount:int;
      
      private var _texpTaskDate:Date;
      
      protected var _changeCount:int = 0;
      
      protected var _changedPropeties:Dictionary;
      
      protected var _lastValue:Dictionary;
      
      private var _treasure:int;
      
      private var _treasureAdd:int;
      
      protected var _isOld:Boolean = false;
      
      protected var _isOld2:Boolean = false;
      
      private var _desertEnterCount:int = 0;
      
      public var BattleCount:int = 0;
      
      public var VipIntegral:int = 0;
      
      public var Rank:int = 0;
      
      private var _mountsType:int = 0;
      
      private var _showMounts:Boolean = true;
      
      public var RingExp:int = 0;
      
      private var _petsID:int;
      
      private var _isAttest:Boolean = false;
      
      public var teamID:int;
      
      public var teamName:String;
      
      public var teamTag:String;
      
      public var teamGrade:int;
      
      public var teamWinTime:int;
      
      public var teamTotalTime:int;
      
      public var teamDivision:int;
      
      public var teamScore:int;
      
      public var teamDuty:int;
      
      public var teamPersonalScore:int;
      
      public var teamLoginDate:Date;
      
      public function BasePlayer(){super();}
      
      public function set ZoneID(param1:int) : void{}
      
      public function get ZoneID() : int{return 0;}
      
      public function set NickName(param1:String) : void{}
      
      public function get NickName() : String{return null;}
      
      public function get TotalCount() : int{return 0;}
      
      public function set TotalCount(param1:int) : void{}
      
      public function set isFirstDivorce(param1:int) : void{}
      
      public function get isFirstDivorce() : int{return 0;}
      
      public function get Repute() : int{return 0;}
      
      public function set Repute(param1:int) : void{}
      
      public function get Grade() : int{return 0;}
      
      public function set Grade(param1:int) : void{}
      
      public function get ddtKingGrade() : int{return 0;}
      
      public function set ddtKingGrade(param1:int) : void{}
      
      public function get IsUpGrade() : Boolean{return false;}
      
      public function set IsUpGrade(param1:Boolean) : void{}
      
      public function get ImagePath() : String{return null;}
      
      public function set ImagePath(param1:String) : void{}
      
      public function get createPlayerDate() : Date{return null;}
      
      public function set createPlayerDate(param1:Date) : void{}
      
      private function noticeGrade() : void{}
      
      public function get FightPower() : int{return 0;}
      
      public function get matchInfo() : MatchInfo{return null;}
      
      public function set matchInfo(param1:MatchInfo) : void{}
      
      public function get DailyLeagueFirst() : Boolean{return false;}
      
      public function set DailyLeagueFirst(param1:Boolean) : void{}
      
      public function get DailyLeagueLastScore() : Number{return 0;}
      
      public function set DailyLeagueLastScore(param1:Number) : void{}
      
      public function set FightPower(param1:int) : void{}
      
      public function get Score() : Number{return 0;}
      
      public function set Score(param1:Number) : void{}
      
      public function get CardSoul() : int{return 0;}
      
      public function set CardSoul(param1:int) : void{}
      
      public function get GP() : int{return 0;}
      
      public function set GP(param1:int) : void{}
      
      public function get Offer() : int{return 0;}
      
      public function set Offer(param1:int) : void{}
      
      public function get Sign() : Boolean{return false;}
      
      public function set Sign(param1:Boolean) : void{}
      
      public function get GetSoulCount() : int{return 0;}
      
      public function set GetSoulCount(param1:int) : void{}
      
      public function get playerState() : PlayerState{return null;}
      
      public function set playerState(param1:PlayerState) : void{}
      
      public function get IsVIP() : Boolean{return false;}
      
      public function set IsVIP(param1:Boolean) : void{}
      
      public function set typeVIP(param1:int) : void{}
      
      public function get typeVIP() : int{return 0;}
      
      public function set snapVip(param1:Boolean) : void{}
      
      public function get snapVip() : Boolean{return false;}
      
      public function get honor() : String{return null;}
      
      public function set honor(param1:String) : void{}
      
      public function get AchievementPoint() : int{return 0;}
      
      public function set AchievementPoint(param1:int) : void{}
      
      public function set SpouseName(param1:String) : void{}
      
      public function get SpouseName() : String{return null;}
      
      public function set IsMarried(param1:Boolean) : void{}
      
      public function get IsMarried() : Boolean{return false;}
      
      public function get DutyName() : String{return null;}
      
      public function set DutyName(param1:String) : void{}
      
      public function get Right() : int{return 0;}
      
      public function set Right(param1:int) : void{}
      
      public function get RichesRob() : int{return 0;}
      
      public function set RichesRob(param1:int) : void{}
      
      public function get RichesOffer() : int{return 0;}
      
      public function set RichesOffer(param1:int) : void{}
      
      public function get UseOffer() : int{return 0;}
      
      public function set UseOffer(param1:int) : void{}
      
      public function get Riches() : int{return 0;}
      
      public function set Riches(param1:int) : void{}
      
      public function get badgeID() : int{return 0;}
      
      public function set badgeID(param1:int) : void{}
      
      public function set apprenticeshipState(param1:int) : void{}
      
      public function get apprenticeshipState() : int{return 0;}
      
      public function get hpTexpExp() : int{return 0;}
      
      public function set hpTexpExp(param1:int) : void{}
      
      public function get attTexpExp() : int{return 0;}
      
      public function set attTexpExp(param1:int) : void{}
      
      public function get defTexpExp() : int{return 0;}
      
      public function set defTexpExp(param1:int) : void{}
      
      public function get spdTexpExp() : int{return 0;}
      
      public function set spdTexpExp(param1:int) : void{}
      
      public function get lukTexpExp() : int{return 0;}
      
      public function set lukTexpExp(param1:int) : void{}
      
      public function get magicAtkTexpExp() : int{return 0;}
      
      public function set magicAtkTexpExp(param1:int) : void{}
      
      public function get magicDefTexpExp() : int{return 0;}
      
      public function set magicDefTexpExp(param1:int) : void{}
      
      public function get texpCount() : int{return 0;}
      
      public function set texpCount(param1:int) : void{}
      
      public function get magicTexpCount() : int{return 0;}
      
      public function set magicTexpCount(param1:int) : void{}
      
      public function get texpTaskCount() : int{return 0;}
      
      public function set texpTaskCount(param1:int) : void{}
      
      public function get texpTaskDate() : Date{return null;}
      
      public function set texpTaskDate(param1:Date) : void{}
      
      public function beginChanges() : void{}
      
      public function commitChanges() : void{}
      
      protected function onPropertiesChanged(param1:String = null) : void{}
      
      public function get treasure() : int{return 0;}
      
      public function set treasure(param1:int) : void{}
      
      public function get treasureAdd() : int{return 0;}
      
      public function set treasureAdd(param1:int) : void{}
      
      public function get isOld() : Boolean{return false;}
      
      public function set isOld(param1:Boolean) : void{}
      
      public function get isOld2() : Boolean{return false;}
      
      public function set isOld2(param1:Boolean) : void{}
      
      public function updateProperties() : void{}
      
      public function get activityTanabataNum() : int{return 0;}
      
      public function get desertEnterCount() : int{return 0;}
      
      public function set desertEnterCount(param1:int) : void{}
      
      public function set activityTanabataNum(param1:int) : void{}
      
      public function get MountsType() : int{return 0;}
      
      public function set MountsType(param1:int) : void{}
      
      public function get IsMounts() : Boolean{return false;}
      
      public function get showMounts() : Boolean{return false;}
      
      public function set showMounts(param1:Boolean) : void{}
      
      public function get PetsID() : int{return 0;}
      
      public function set PetsID(param1:int) : void{}
      
      public function get isPetsFollow() : Boolean{return false;}
      
      public function getPetsPosIndex() : int{return 0;}
      
      public function get isAttest() : Boolean{return false;}
      
      public function set isAttest(param1:Boolean) : void{}
   }
}
