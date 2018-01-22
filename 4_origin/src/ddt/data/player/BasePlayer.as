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
      
      public function BasePlayer()
      {
         _changedPropeties = new Dictionary();
         _lastValue = new Dictionary();
         super();
      }
      
      public function set ZoneID(param1:int) : void
      {
         _zoneID = param1;
      }
      
      public function get ZoneID() : int
      {
         return _zoneID;
      }
      
      public function set NickName(param1:String) : void
      {
         _nick = param1;
      }
      
      public function get NickName() : String
      {
         return _nick;
      }
      
      public function get TotalCount() : int
      {
         return _totalCount;
      }
      
      public function set TotalCount(param1:int) : void
      {
         if(_totalCount == param1 || param1 <= 0)
         {
            return;
         }
         if(_totalCount == param1 - 1 || _totalCount == param1 - 2)
         {
            onPropertiesChanged("TotalCount");
         }
         _totalCount = param1;
      }
      
      public function set isFirstDivorce(param1:int) : void
      {
         this._isFirstDivorce = param1;
      }
      
      public function get isFirstDivorce() : int
      {
         return this._isFirstDivorce;
      }
      
      public function get Repute() : int
      {
         return _repute;
      }
      
      public function set Repute(param1:int) : void
      {
         _repute = param1;
         onPropertiesChanged("Repute");
      }
      
      public function get Grade() : int
      {
         return _grade;
      }
      
      public function set Grade(param1:int) : void
      {
         if(_grade == param1 || param1 <= 0)
         {
            return;
         }
         if(_grade != 0 && _grade < param1)
         {
            IsUpGrade = true;
         }
         _grade = param1;
         if(Grade == 11 && !PlayerManager.Instance.Self.IsWeakGuildFinish(132))
         {
            SocketManager.Instance.out.syncWeakStep(132);
            NoviceDataManager.instance.saveNoviceData(1130,PathManager.userName(),PathManager.solveRequestPath());
         }
         if(PvePowerBuffManager.instance.isInRefresh)
         {
            return;
         }
         BagAndInfoManager.Instance.hideBagAndInfo();
         onPropertiesChanged("Grade");
      }
      
      public function get ddtKingGrade() : int
      {
         return _ddtKingGrade;
      }
      
      public function set ddtKingGrade(param1:int) : void
      {
         if(_grade == param1)
         {
            return;
         }
         _ddtKingGrade = param1;
         onPropertiesChanged("ddtkingGrade");
      }
      
      public function get IsUpGrade() : Boolean
      {
         return _IsUpGrade;
      }
      
      public function set IsUpGrade(param1:Boolean) : void
      {
         _IsUpGrade = param1;
         noticeGrade();
      }
      
      public function get ImagePath() : String
      {
         if(_headURLPicGirl == "")
         {
            return "";
         }
         return _headURLPicGirl;
      }
      
      public function set ImagePath(param1:String) : void
      {
         _headURLPicGirl = param1;
      }
      
      public function get createPlayerDate() : Date
      {
         return _createPlayerDate;
      }
      
      public function set createPlayerDate(param1:Date) : void
      {
         _createPlayerDate = param1;
         WonderfulActivityManager.Instance.updateRealEndTime();
      }
      
      private function noticeGrade() : void
      {
         if(!IsUpGrade)
         {
            return;
         }
         var _loc1_:String = PathManager.solveGradeNotificationPath(Grade);
         if(_loc1_ == null)
         {
            return;
         }
         var _loc2_:URLRequest = new URLRequest(_loc1_);
         var _loc3_:URLVariables = new URLVariables();
         _loc3_["grade"] = Grade;
         _loc2_.data = _loc3_;
         return;
         §§push(sendToURL(_loc2_));
      }
      
      public function get FightPower() : int
      {
         return _fightPower;
      }
      
      public function get matchInfo() : MatchInfo
      {
         if(_matchInfo == null)
         {
            _matchInfo = new MatchInfo();
         }
         return _matchInfo;
      }
      
      public function set matchInfo(param1:MatchInfo) : void
      {
         if(_matchInfo == param1)
         {
            return;
         }
         ObjectUtils.copyProperties(matchInfo,param1);
         onPropertiesChanged("matchInfo");
      }
      
      public function get DailyLeagueFirst() : Boolean
      {
         return _leagueFirst;
      }
      
      public function set DailyLeagueFirst(param1:Boolean) : void
      {
         if(_leagueFirst == param1)
         {
            return;
         }
         _leagueFirst = param1;
         onPropertiesChanged("DailyLeagueFirst");
      }
      
      public function get DailyLeagueLastScore() : Number
      {
         return _lasetWeekScore;
      }
      
      public function set DailyLeagueLastScore(param1:Number) : void
      {
         if(_lasetWeekScore == param1)
         {
            return;
         }
         _lasetWeekScore = param1;
         onPropertiesChanged("DailyLeagueLastScore");
      }
      
      public function set FightPower(param1:int) : void
      {
         if(_fightPower == param1)
         {
            return;
         }
         _fightPower = param1;
         onPropertiesChanged("FightPower");
      }
      
      public function get Score() : Number
      {
         return _score;
      }
      
      public function set Score(param1:Number) : void
      {
         if(_score == param1)
         {
            return;
         }
         _score = param1;
         onPropertiesChanged("Score");
      }
      
      public function get CardSoul() : int
      {
         return _CardSoul;
      }
      
      public function set CardSoul(param1:int) : void
      {
         _CardSoul = param1;
         onPropertiesChanged("CardSoul");
         updateProperties();
      }
      
      public function get GP() : int
      {
         return _gP;
      }
      
      public function set GP(param1:int) : void
      {
         _gP = param1;
         Grade = Experience.getGrade(_gP);
         onPropertiesChanged("GP");
      }
      
      public function get Offer() : int
      {
         return _offer;
      }
      
      public function set Offer(param1:int) : void
      {
         if(_offer == param1)
         {
            return;
         }
         _offer = param1;
         onPropertiesChanged("Offer");
      }
      
      public function get Sign() : Boolean
      {
         return _sign;
      }
      
      public function set Sign(param1:Boolean) : void
      {
         if(_sign == param1)
         {
            return;
         }
         _sign = param1;
         onPropertiesChanged("Sign");
      }
      
      public function get GetSoulCount() : int
      {
         return _GetSoulCount;
      }
      
      public function set GetSoulCount(param1:int) : void
      {
         _GetSoulCount = param1;
         onPropertiesChanged("GetSoulCount");
         updateProperties();
      }
      
      public function get playerState() : PlayerState
      {
         if(_state == null)
         {
            _state = new PlayerState(1);
         }
         return _state;
      }
      
      public function set playerState(param1:PlayerState) : void
      {
         if(_state == null || _state.StateID == 1 || _state.StateID != param1.StateID && _state.Priority <= param1.Priority)
         {
            _state = param1;
            onPropertiesChanged("State");
         }
      }
      
      public function get IsVIP() : Boolean
      {
         return _typeVIP >= 1;
      }
      
      public function set IsVIP(param1:Boolean) : void
      {
         _typeVIP = int(param1);
      }
      
      public function set typeVIP(param1:int) : void
      {
         _typeVIP = param1;
         onPropertiesChanged("isVip");
      }
      
      public function get typeVIP() : int
      {
         return _typeVIP;
      }
      
      public function set snapVip(param1:Boolean) : void
      {
         _snapVip = param1;
      }
      
      public function get snapVip() : Boolean
      {
         return _snapVip;
      }
      
      public function get honor() : String
      {
         return _honor;
      }
      
      public function set honor(param1:String) : void
      {
         if(_honor == param1)
         {
            return;
         }
         _honor = param1;
         onPropertiesChanged("honor");
      }
      
      public function get AchievementPoint() : int
      {
         return _achievementPoint;
      }
      
      public function set AchievementPoint(param1:int) : void
      {
         _achievementPoint = param1;
      }
      
      public function set SpouseName(param1:String) : void
      {
         if(_spouseName == param1)
         {
            return;
         }
         _spouseName = param1;
         onPropertiesChanged("SpouseName");
      }
      
      public function get SpouseName() : String
      {
         return _spouseName;
      }
      
      public function set IsMarried(param1:Boolean) : void
      {
         if(param1 && !_isMarried)
         {
         }
         _isMarried = param1;
         onPropertiesChanged("IsMarried");
      }
      
      public function get IsMarried() : Boolean
      {
         return _isMarried;
      }
      
      public function get DutyName() : String
      {
         return _dutyName;
      }
      
      public function set DutyName(param1:String) : void
      {
         if(_dutyName == param1)
         {
            return;
         }
         _dutyName = param1;
         onPropertiesChanged("dutyName");
      }
      
      public function get Right() : int
      {
         return _right;
      }
      
      public function set Right(param1:int) : void
      {
         if(_right == param1)
         {
            return;
         }
         _right = param1;
         onPropertiesChanged("Right");
      }
      
      public function get RichesRob() : int
      {
         return _RichesRob;
      }
      
      public function set RichesRob(param1:int) : void
      {
         if(_RichesRob == param1)
         {
            return;
         }
         _RichesRob = param1;
         onPropertiesChanged("RichesRob");
      }
      
      public function get RichesOffer() : int
      {
         return _RichesOffer;
      }
      
      public function set RichesOffer(param1:int) : void
      {
         if(_RichesOffer == param1)
         {
            return;
         }
         _RichesOffer = param1;
         onPropertiesChanged("RichesOffer");
      }
      
      public function get UseOffer() : int
      {
         return _UseOffer;
      }
      
      public function set UseOffer(param1:int) : void
      {
         if(_UseOffer == param1)
         {
            return;
         }
         _UseOffer = param1;
         onPropertiesChanged("UseOffer");
      }
      
      public function get Riches() : int
      {
         return RichesOffer + RichesRob;
      }
      
      public function set Riches(param1:int) : void
      {
         RichesOffer = param1;
      }
      
      public function get badgeID() : int
      {
         return _badgeID;
      }
      
      public function set badgeID(param1:int) : void
      {
         _badgeID = param1;
         onPropertiesChanged("badgeid");
      }
      
      public function set apprenticeshipState(param1:int) : void
      {
         _apprenticeshipState = param1;
      }
      
      public function get apprenticeshipState() : int
      {
         return _apprenticeshipState;
      }
      
      public function get hpTexpExp() : int
      {
         return _hpTexpExp;
      }
      
      public function set hpTexpExp(param1:int) : void
      {
         if(_hpTexpExp == param1)
         {
            return;
         }
         _lastValue["hpTexpExp"] = _hpTexpExp;
         _hpTexpExp = param1;
         if(_lastValue["hpTexpExp"] != -1)
         {
            onPropertiesChanged("hpTexpExp");
         }
      }
      
      public function get attTexpExp() : int
      {
         return _attTexpExp;
      }
      
      public function set attTexpExp(param1:int) : void
      {
         if(_attTexpExp == param1)
         {
            return;
         }
         _lastValue["attTexpExp"] = _attTexpExp;
         _attTexpExp = param1;
         if(_lastValue["attTexpExp"] != -1)
         {
            onPropertiesChanged("attTexpExp");
         }
      }
      
      public function get defTexpExp() : int
      {
         return _defTexpExp;
      }
      
      public function set defTexpExp(param1:int) : void
      {
         if(_defTexpExp == param1)
         {
            return;
         }
         _lastValue["defTexpExp"] = _defTexpExp;
         _defTexpExp = param1;
         if(_lastValue["defTexpExp"] != -1)
         {
            onPropertiesChanged("defTexpExp");
         }
      }
      
      public function get spdTexpExp() : int
      {
         return _spdTexpExp;
      }
      
      public function set spdTexpExp(param1:int) : void
      {
         if(_spdTexpExp == param1)
         {
            return;
         }
         _lastValue["spdTexpExp"] = _spdTexpExp;
         _spdTexpExp = param1;
         if(_lastValue["spdTexpExp"] != -1)
         {
            onPropertiesChanged("spdTexpExp");
         }
      }
      
      public function get lukTexpExp() : int
      {
         return _lukTexpExp;
      }
      
      public function set lukTexpExp(param1:int) : void
      {
         if(_lukTexpExp == param1)
         {
            return;
         }
         _lastValue["lukTexpExp"] = _lukTexpExp;
         _lukTexpExp = param1;
         if(_lastValue["lukTexpExp"] != -1)
         {
            onPropertiesChanged("lukTexpExp");
         }
      }
      
      public function get magicAtkTexpExp() : int
      {
         return _magicAtkTexpExp;
      }
      
      public function set magicAtkTexpExp(param1:int) : void
      {
         if(_magicAtkTexpExp == param1)
         {
            return;
         }
         _lastValue["magicAtkTexpExp"] = _magicAtkTexpExp;
         _magicAtkTexpExp = param1;
         if(_lastValue["magicAtkTexpExp"] != -1)
         {
            onPropertiesChanged("magicAtkTexpExp");
         }
      }
      
      public function get magicDefTexpExp() : int
      {
         return _magicDefTexpExp;
      }
      
      public function set magicDefTexpExp(param1:int) : void
      {
         if(_magicDefTexpExp == param1)
         {
            return;
         }
         _lastValue["magicDefTexpExp"] = _magicDefTexpExp;
         _magicDefTexpExp = param1;
         if(_lastValue["magicDefTexpExp"] != -1)
         {
            onPropertiesChanged("magicDefTexpExp");
         }
      }
      
      public function get texpCount() : int
      {
         return _texpCount;
      }
      
      public function set texpCount(param1:int) : void
      {
         _texpCount = param1;
      }
      
      public function get magicTexpCount() : int
      {
         return _magicTexpCount;
      }
      
      public function set magicTexpCount(param1:int) : void
      {
         _magicTexpCount = param1;
      }
      
      public function get texpTaskCount() : int
      {
         return _texpTaskCount;
      }
      
      public function set texpTaskCount(param1:int) : void
      {
         _texpTaskCount = param1;
      }
      
      public function get texpTaskDate() : Date
      {
         return _texpTaskDate;
      }
      
      public function set texpTaskDate(param1:Date) : void
      {
         _texpTaskDate = param1;
      }
      
      public function beginChanges() : void
      {
         _changeCount = Number(_changeCount) + 1;
      }
      
      public function commitChanges() : void
      {
         _changeCount = Number(_changeCount) - 1;
         if(_changeCount <= 0)
         {
            _changeCount = 0;
            updateProperties();
         }
      }
      
      protected function onPropertiesChanged(param1:String = null) : void
      {
         if(param1 != null)
         {
            _changedPropeties[param1] = true;
         }
         if(_changeCount <= 0)
         {
            _changeCount = 0;
            updateProperties();
         }
      }
      
      public function get treasure() : int
      {
         return _treasure;
      }
      
      public function set treasure(param1:int) : void
      {
         _treasure = param1;
      }
      
      public function get treasureAdd() : int
      {
         return _treasureAdd;
      }
      
      public function set treasureAdd(param1:int) : void
      {
         _treasureAdd = param1;
      }
      
      public function get isOld() : Boolean
      {
         return _isOld;
      }
      
      public function set isOld(param1:Boolean) : void
      {
         _isOld = param1;
      }
      
      public function get isOld2() : Boolean
      {
         return _isOld2;
      }
      
      public function set isOld2(param1:Boolean) : void
      {
         _isOld2 = param1;
      }
      
      public function updateProperties() : void
      {
         var _loc2_:Dictionary = _changedPropeties;
         var _loc1_:Dictionary = _lastValue;
         _changedPropeties = new Dictionary();
         _lastValue = new Dictionary();
         dispatchEvent(new PlayerPropertyEvent("propertychange",_loc2_,_loc1_));
      }
      
      public function get activityTanabataNum() : int
      {
         return _activityTanabataNum;
      }
      
      public function get desertEnterCount() : int
      {
         return _desertEnterCount;
      }
      
      public function set desertEnterCount(param1:int) : void
      {
         _desertEnterCount = param1;
      }
      
      public function set activityTanabataNum(param1:int) : void
      {
         param1 = ServerConfigManager.instance.activityEnterNum - param1;
         _activityTanabataNum = param1 < 0?0:param1;
      }
      
      public function get MountsType() : int
      {
         return _mountsType;
      }
      
      public function set MountsType(param1:int) : void
      {
         if(_mountsType != param1)
         {
            _mountsType = param1;
            onPropertiesChanged("mountsType");
         }
      }
      
      public function get IsMounts() : Boolean
      {
         return MountsType > 0 && showMounts;
      }
      
      public function get showMounts() : Boolean
      {
         return _showMounts;
      }
      
      public function set showMounts(param1:Boolean) : void
      {
         _showMounts = param1;
      }
      
      public function get PetsID() : int
      {
         return _petsID;
      }
      
      public function set PetsID(param1:int) : void
      {
         if(_petsID == param1)
         {
            return;
         }
         _petsID = param1;
         onPropertiesChanged("petsID");
      }
      
      public function get isPetsFollow() : Boolean
      {
         return _petsID != -1;
      }
      
      public function getPetsPosIndex() : int
      {
         var _loc1_:int = 0;
         if(_petsID >= 62001 && _petsID <= 62003 || _petsID == 62010)
         {
            _loc1_ = MountsType <= 0?0:2;
         }
         else if(_petsID >= 62004 && _petsID <= 62009 || _petsID == 62011)
         {
            _loc1_ = MountsType <= 0?1:3;
         }
         return _loc1_;
      }
      
      public function get isAttest() : Boolean
      {
         return _isAttest;
      }
      
      public function set isAttest(param1:Boolean) : void
      {
         _isAttest = param1;
      }
   }
}
