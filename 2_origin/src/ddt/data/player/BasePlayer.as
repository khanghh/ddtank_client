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
      
      private var _critTexpExp:int = -1;
      
      private var _sunderArmorTexpExp:int = -1;
      
      private var _critDmgTexpExp:int = -1;
      
      private var _speedTexpExp:int = -1;
      
      private var _uniqueSkillTexpExp:int = -1;
      
      private var _dmgTexpExp:int = -1;
      
      private var _armorDefTexpExp:int = -1;
      
      private var _texpCount:int;
      
      private var _magicTexpCount:int;
      
      private var _nsTexpCount:int;
      
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
      
      public function set ZoneID(zoneID:int) : void
      {
         _zoneID = zoneID;
      }
      
      public function get ZoneID() : int
      {
         return _zoneID;
      }
      
      public function set NickName(value:String) : void
      {
         _nick = value;
      }
      
      public function get NickName() : String
      {
         return _nick;
      }
      
      public function get TotalCount() : int
      {
         return _totalCount;
      }
      
      public function set TotalCount(value:int) : void
      {
         if(_totalCount == value || value <= 0)
         {
            return;
         }
         if(_totalCount == value - 1 || _totalCount == value - 2)
         {
            onPropertiesChanged("TotalCount");
         }
         _totalCount = value;
      }
      
      public function set isFirstDivorce(value:int) : void
      {
         this._isFirstDivorce = value;
      }
      
      public function get isFirstDivorce() : int
      {
         return this._isFirstDivorce;
      }
      
      public function get Repute() : int
      {
         return _repute;
      }
      
      public function set Repute(value:int) : void
      {
         _repute = value;
         onPropertiesChanged("Repute");
      }
      
      public function get Grade() : int
      {
         return _grade;
      }
      
      public function set Grade(value:int) : void
      {
         if(_grade == value || value <= 0)
         {
            return;
         }
         if(_grade != 0 && _grade < value)
         {
            IsUpGrade = true;
         }
         _grade = value;
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
      
      public function set ddtKingGrade(value:int) : void
      {
         if(_grade == value)
         {
            return;
         }
         _ddtKingGrade = value;
         onPropertiesChanged("ddtkingGrade");
      }
      
      public function get IsUpGrade() : Boolean
      {
         return _IsUpGrade;
      }
      
      public function set IsUpGrade(value:Boolean) : void
      {
         _IsUpGrade = value;
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
      
      public function set ImagePath(value:String) : void
      {
         _headURLPicGirl = value;
      }
      
      public function get createPlayerDate() : Date
      {
         return _createPlayerDate;
      }
      
      public function set createPlayerDate(value:Date) : void
      {
         _createPlayerDate = value;
         WonderfulActivityManager.Instance.updateRealEndTime();
      }
      
      private function noticeGrade() : void
      {
         if(!IsUpGrade)
         {
            return;
         }
         var site:String = PathManager.solveGradeNotificationPath(Grade);
         if(site == null)
         {
            return;
         }
         var request:URLRequest = new URLRequest(site);
         var variable:URLVariables = new URLVariables();
         variable["grade"] = Grade;
         request.data = variable;
         return;
         §§push(sendToURL(request));
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
      
      public function set matchInfo(value:MatchInfo) : void
      {
         if(_matchInfo == value)
         {
            return;
         }
         ObjectUtils.copyProperties(matchInfo,value);
         onPropertiesChanged("matchInfo");
      }
      
      public function get DailyLeagueFirst() : Boolean
      {
         return _leagueFirst;
      }
      
      public function set DailyLeagueFirst(value:Boolean) : void
      {
         if(_leagueFirst == value)
         {
            return;
         }
         _leagueFirst = value;
         onPropertiesChanged("DailyLeagueFirst");
      }
      
      public function get DailyLeagueLastScore() : Number
      {
         return _lasetWeekScore;
      }
      
      public function set DailyLeagueLastScore(value:Number) : void
      {
         if(_lasetWeekScore == value)
         {
            return;
         }
         _lasetWeekScore = value;
         onPropertiesChanged("DailyLeagueLastScore");
      }
      
      public function set FightPower(value:int) : void
      {
         if(_fightPower == value)
         {
            return;
         }
         _fightPower = value;
         onPropertiesChanged("FightPower");
      }
      
      public function get Score() : Number
      {
         return _score;
      }
      
      public function set Score(value:Number) : void
      {
         if(_score == value)
         {
            return;
         }
         _score = value;
         onPropertiesChanged("Score");
      }
      
      public function get CardSoul() : int
      {
         return _CardSoul;
      }
      
      public function set CardSoul(value:int) : void
      {
         _CardSoul = value;
         onPropertiesChanged("CardSoul");
         updateProperties();
      }
      
      public function get GP() : int
      {
         return _gP;
      }
      
      public function set GP(value:int) : void
      {
         _gP = value;
         Grade = Experience.getGrade(_gP);
         onPropertiesChanged("GP");
      }
      
      public function get Offer() : int
      {
         return _offer;
      }
      
      public function set Offer(value:int) : void
      {
         if(_offer == value)
         {
            return;
         }
         _offer = value;
         onPropertiesChanged("Offer");
      }
      
      public function get Sign() : Boolean
      {
         return _sign;
      }
      
      public function set Sign(value:Boolean) : void
      {
         if(_sign == value)
         {
            return;
         }
         _sign = value;
         onPropertiesChanged("Sign");
      }
      
      public function get GetSoulCount() : int
      {
         return _GetSoulCount;
      }
      
      public function set GetSoulCount(value:int) : void
      {
         _GetSoulCount = value;
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
      
      public function set playerState(value:PlayerState) : void
      {
         if(_state == null || _state.StateID == 1 || _state.StateID != value.StateID && _state.Priority <= value.Priority)
         {
            _state = value;
            onPropertiesChanged("State");
         }
      }
      
      public function get IsVIP() : Boolean
      {
         return _typeVIP >= 1;
      }
      
      public function set IsVIP(value:Boolean) : void
      {
         _typeVIP = int(value);
      }
      
      public function set typeVIP(value:int) : void
      {
         _typeVIP = value;
         onPropertiesChanged("isVip");
      }
      
      public function get typeVIP() : int
      {
         return _typeVIP;
      }
      
      public function set snapVip(value:Boolean) : void
      {
         _snapVip = value;
      }
      
      public function get snapVip() : Boolean
      {
         return _snapVip;
      }
      
      public function get honor() : String
      {
         return _honor;
      }
      
      public function set honor(value:String) : void
      {
         if(_honor == value)
         {
            return;
         }
         _honor = value;
         onPropertiesChanged("honor");
      }
      
      public function get AchievementPoint() : int
      {
         return _achievementPoint;
      }
      
      public function set AchievementPoint(value:int) : void
      {
         _achievementPoint = value;
      }
      
      public function set SpouseName(value:String) : void
      {
         if(_spouseName == value)
         {
            return;
         }
         _spouseName = value;
         onPropertiesChanged("SpouseName");
      }
      
      public function get SpouseName() : String
      {
         return _spouseName;
      }
      
      public function set IsMarried(value:Boolean) : void
      {
         if(value && !_isMarried)
         {
         }
         _isMarried = value;
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
      
      public function set DutyName(value:String) : void
      {
         if(_dutyName == value)
         {
            return;
         }
         _dutyName = value;
         onPropertiesChanged("dutyName");
      }
      
      public function get Right() : int
      {
         return _right;
      }
      
      public function set Right(value:int) : void
      {
         if(_right == value)
         {
            return;
         }
         _right = value;
         onPropertiesChanged("Right");
      }
      
      public function get RichesRob() : int
      {
         return _RichesRob;
      }
      
      public function set RichesRob(value:int) : void
      {
         if(_RichesRob == value)
         {
            return;
         }
         _RichesRob = value;
         onPropertiesChanged("RichesRob");
      }
      
      public function get RichesOffer() : int
      {
         return _RichesOffer;
      }
      
      public function set RichesOffer(value:int) : void
      {
         if(_RichesOffer == value)
         {
            return;
         }
         _RichesOffer = value;
         onPropertiesChanged("RichesOffer");
      }
      
      public function get UseOffer() : int
      {
         return _UseOffer;
      }
      
      public function set UseOffer(value:int) : void
      {
         if(_UseOffer == value)
         {
            return;
         }
         _UseOffer = value;
         onPropertiesChanged("UseOffer");
      }
      
      public function get Riches() : int
      {
         return RichesOffer + RichesRob;
      }
      
      public function set Riches(value:int) : void
      {
         RichesOffer = value;
      }
      
      public function get badgeID() : int
      {
         return _badgeID;
      }
      
      public function set badgeID(value:int) : void
      {
         _badgeID = value;
         onPropertiesChanged("badgeid");
      }
      
      public function set apprenticeshipState(value:int) : void
      {
         _apprenticeshipState = value;
      }
      
      public function get apprenticeshipState() : int
      {
         return _apprenticeshipState;
      }
      
      public function get hpTexpExp() : int
      {
         return _hpTexpExp;
      }
      
      public function set hpTexpExp(value:int) : void
      {
         if(_hpTexpExp == value)
         {
            return;
         }
         _lastValue["hpTexpExp"] = _hpTexpExp;
         _hpTexpExp = value;
         if(_lastValue["hpTexpExp"] != -1)
         {
            onPropertiesChanged("hpTexpExp");
         }
      }
      
      public function get attTexpExp() : int
      {
         return _attTexpExp;
      }
      
      public function set attTexpExp(value:int) : void
      {
         if(_attTexpExp == value)
         {
            return;
         }
         _lastValue["attTexpExp"] = _attTexpExp;
         _attTexpExp = value;
         if(_lastValue["attTexpExp"] != -1)
         {
            onPropertiesChanged("attTexpExp");
         }
      }
      
      public function get defTexpExp() : int
      {
         return _defTexpExp;
      }
      
      public function set defTexpExp(value:int) : void
      {
         if(_defTexpExp == value)
         {
            return;
         }
         _lastValue["defTexpExp"] = _defTexpExp;
         _defTexpExp = value;
         if(_lastValue["defTexpExp"] != -1)
         {
            onPropertiesChanged("defTexpExp");
         }
      }
      
      public function get spdTexpExp() : int
      {
         return _spdTexpExp;
      }
      
      public function set spdTexpExp(value:int) : void
      {
         if(_spdTexpExp == value)
         {
            return;
         }
         _lastValue["spdTexpExp"] = _spdTexpExp;
         _spdTexpExp = value;
         if(_lastValue["spdTexpExp"] != -1)
         {
            onPropertiesChanged("spdTexpExp");
         }
      }
      
      public function get lukTexpExp() : int
      {
         return _lukTexpExp;
      }
      
      public function set lukTexpExp(value:int) : void
      {
         if(_lukTexpExp == value)
         {
            return;
         }
         _lastValue["lukTexpExp"] = _lukTexpExp;
         _lukTexpExp = value;
         if(_lastValue["lukTexpExp"] != -1)
         {
            onPropertiesChanged("lukTexpExp");
         }
      }
      
      public function get magicAtkTexpExp() : int
      {
         return _magicAtkTexpExp;
      }
      
      public function set magicAtkTexpExp(value:int) : void
      {
         if(_magicAtkTexpExp == value)
         {
            return;
         }
         _lastValue["magicAtkTexpExp"] = _magicAtkTexpExp;
         _magicAtkTexpExp = value;
         if(_lastValue["magicAtkTexpExp"] != -1)
         {
            onPropertiesChanged("magicAtkTexpExp");
         }
      }
      
      public function get magicDefTexpExp() : int
      {
         return _magicDefTexpExp;
      }
      
      public function set magicDefTexpExp(value:int) : void
      {
         if(_magicDefTexpExp == value)
         {
            return;
         }
         _lastValue["magicDefTexpExp"] = _magicDefTexpExp;
         _magicDefTexpExp = value;
         if(_lastValue["magicDefTexpExp"] != -1)
         {
            onPropertiesChanged("magicDefTexpExp");
         }
      }
      
      public function get critTexpExp() : int
      {
         return _critTexpExp;
      }
      
      public function set critTexpExp(value:int) : void
      {
         if(_critTexpExp == value)
         {
            return;
         }
         _lastValue["critTexpExp"] = _critTexpExp;
         _critTexpExp = value;
         if(_lastValue["critTexpExp"] != -1)
         {
            onPropertiesChanged("critTexpExp");
         }
      }
      
      public function get sunderArmorTexpExp() : int
      {
         return _sunderArmorTexpExp;
      }
      
      public function set sunderArmorTexpExp(value:int) : void
      {
         if(_sunderArmorTexpExp == value)
         {
            return;
         }
         _lastValue["sunderArmorTexpExp"] = _sunderArmorTexpExp;
         _sunderArmorTexpExp = value;
         if(_lastValue["sunderArmorTexpExp"] != -1)
         {
            onPropertiesChanged("sunderArmorTexpExp");
         }
      }
      
      public function get critDmgTexpExp() : int
      {
         return _critDmgTexpExp;
      }
      
      public function set critDmgTexpExp(value:int) : void
      {
         if(_critDmgTexpExp == value)
         {
            return;
         }
         _lastValue["critDmgTexpExp"] = _critDmgTexpExp;
         _critDmgTexpExp = value;
         if(_lastValue["critDmgTexpExp"] != -1)
         {
            onPropertiesChanged("critDmgTexpExp");
         }
      }
      
      public function get speedTexpExp() : int
      {
         return _speedTexpExp;
      }
      
      public function set speedTexpExp(value:int) : void
      {
         if(_speedTexpExp == value)
         {
            return;
         }
         _lastValue["speedTexpExp"] = _speedTexpExp;
         _speedTexpExp = value;
         if(_lastValue["speedTexpExp"] != -1)
         {
            onPropertiesChanged("speedTexpExp");
         }
      }
      
      public function get uniqueSkillTexpExp() : int
      {
         return _uniqueSkillTexpExp;
      }
      
      public function set uniqueSkillTexpExp(value:int) : void
      {
         if(_uniqueSkillTexpExp == value)
         {
            return;
         }
         _lastValue["uniqueSkillTexpExp"] = _uniqueSkillTexpExp;
         _uniqueSkillTexpExp = value;
         if(_lastValue["uniqueSkillTexpExp"] != -1)
         {
            onPropertiesChanged("uniqueSkillTexpExp");
         }
      }
      
      public function get dmgTexpExp() : int
      {
         return _dmgTexpExp;
      }
      
      public function set dmgTexpExp(value:int) : void
      {
         if(_dmgTexpExp == value)
         {
            return;
         }
         _lastValue["dmgTexpExp"] = _dmgTexpExp;
         _dmgTexpExp = value;
         if(_lastValue["dmgTexpExp"] != -1)
         {
            onPropertiesChanged("dmgTexpExp");
         }
      }
      
      public function get armorDefTexpExp() : int
      {
         return _armorDefTexpExp;
      }
      
      public function set armorDefTexpExp(value:int) : void
      {
         if(_armorDefTexpExp == value)
         {
            return;
         }
         _lastValue["armorDefTexpExp"] = _armorDefTexpExp;
         _armorDefTexpExp = value;
         if(_lastValue["armorDefTexpExp"] != -1)
         {
            onPropertiesChanged("armorDefTexpExp");
         }
      }
      
      public function get texpCount() : int
      {
         return _texpCount;
      }
      
      public function set texpCount(value:int) : void
      {
         _texpCount = value;
      }
      
      public function get magicTexpCount() : int
      {
         return _magicTexpCount;
      }
      
      public function set magicTexpCount(value:int) : void
      {
         _magicTexpCount = value;
      }
      
      public function get nsTexpCount() : int
      {
         return _nsTexpCount;
      }
      
      public function set nsTexpCount(value:int) : void
      {
         _nsTexpCount = value;
      }
      
      public function get texpTaskCount() : int
      {
         return _texpTaskCount;
      }
      
      public function set texpTaskCount(value:int) : void
      {
         _texpTaskCount = value;
      }
      
      public function get texpTaskDate() : Date
      {
         return _texpTaskDate;
      }
      
      public function set texpTaskDate(value:Date) : void
      {
         _texpTaskDate = value;
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
      
      protected function onPropertiesChanged(propName:String = null) : void
      {
         if(propName != null)
         {
            _changedPropeties[propName] = true;
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
      
      public function set treasure(value:int) : void
      {
         _treasure = value;
      }
      
      public function get treasureAdd() : int
      {
         return _treasureAdd;
      }
      
      public function set treasureAdd(value:int) : void
      {
         _treasureAdd = value;
      }
      
      public function get isOld() : Boolean
      {
         return _isOld;
      }
      
      public function set isOld(value:Boolean) : void
      {
         _isOld = value;
      }
      
      public function get isOld2() : Boolean
      {
         return _isOld2;
      }
      
      public function set isOld2(value:Boolean) : void
      {
         _isOld2 = value;
      }
      
      public function updateProperties() : void
      {
         var temp:Dictionary = _changedPropeties;
         var last:Dictionary = _lastValue;
         _changedPropeties = new Dictionary();
         _lastValue = new Dictionary();
         dispatchEvent(new PlayerPropertyEvent("propertychange",temp,last));
      }
      
      public function get activityTanabataNum() : int
      {
         return _activityTanabataNum;
      }
      
      public function get desertEnterCount() : int
      {
         return _desertEnterCount;
      }
      
      public function set desertEnterCount(value:int) : void
      {
         _desertEnterCount = value;
      }
      
      public function set activityTanabataNum(value:int) : void
      {
         value = ServerConfigManager.instance.activityEnterNum - value;
         _activityTanabataNum = value < 0?0:value;
      }
      
      public function get MountsType() : int
      {
         return _mountsType;
      }
      
      public function set MountsType(value:int) : void
      {
         if(_mountsType != value)
         {
            _mountsType = value;
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
      
      public function set showMounts(value:Boolean) : void
      {
         _showMounts = value;
      }
      
      public function get PetsID() : int
      {
         return _petsID;
      }
      
      public function set PetsID(value:int) : void
      {
         if(_petsID == value)
         {
            return;
         }
         _petsID = value;
         onPropertiesChanged("petsID");
      }
      
      public function get isPetsFollow() : Boolean
      {
         return _petsID != -1;
      }
      
      public function getPetsPosIndex() : int
      {
         var index:int = 0;
         if(_petsID >= 62001 && _petsID <= 62003 || _petsID == 62010)
         {
            index = MountsType <= 0?0:2;
         }
         else if(_petsID >= 62004 && _petsID <= 62009 || _petsID == 62011)
         {
            index = MountsType <= 0?1:3;
         }
         return index;
      }
      
      public function get isAttest() : Boolean
      {
         return _isAttest;
      }
      
      public function set isAttest(value:Boolean) : void
      {
         _isAttest = value;
      }
   }
}
