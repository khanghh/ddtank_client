package tofflist
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import consortion.data.ConsortiaApplyInfo;
   import ddt.data.ConsortiaInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import flash.events.EventDispatcher;
   import flash.net.URLVariables;
   import team.model.TeamRankInfo;
   import tofflist.analyze.RankInfoAnalyz;
   import tofflist.data.RankInfo;
   import tofflist.data.TofflistListData;
   
   public class TofflistModel
   {
      
      private static var _tofflistType:int;
      
      public static var childType:int;
      
      private static var _currentPlayerInfo:PlayerInfo;
      
      public static var currentText:String;
      
      public static var currentIndex:int;
      
      private static var _currentTeamInfo:TeamRankInfo;
      
      private static var _firstMenuType:String = "personal";
      
      private static var _secondMenuType:String = "battle";
      
      private static var _thirdMenuType:String = "total";
      
      private static var _mountsLevelInfo:String;
      
      private static var _dispatcher:EventDispatcher = new EventDispatcher();
      
      private static var _currentConsortiaInfo:ConsortiaInfo;
      
      private static var _instance:TofflistModel;
       
      
      private var _personalBattleAccumulate:TofflistListData;
      
      private var _individualGradeDay:TofflistListData;
      
      private var _individualGradeWeek:TofflistListData;
      
      private var _individualGradeAccumulate:TofflistListData;
      
      private var _individualExploitDay:TofflistListData;
      
      private var _individualExploitWeek:TofflistListData;
      
      private var _individualExploitAccumulate:TofflistListData;
      
      private var _personalAchievementPointDay:TofflistListData;
      
      private var _personalAchievementPointWeek:TofflistListData;
      
      private var _personalAchievementPoint:TofflistListData;
      
      private var _PersonalCharmvalueDay:TofflistListData;
      
      private var _PersonalCharmvalueWeek:TofflistListData;
      
      private var _PersonalCharmvalue:TofflistListData;
      
      private var _personalMatchesDay:TofflistListData;
      
      private var _personalMatchesWeek:TofflistListData;
      
      private var _personalMatchesTotal:TofflistListData;
      
      private var _personalMountsAccumulate:TofflistListData;
      
      private var _consortiaBattleAccumulate:TofflistListData;
      
      private var _consortiaGradeAccumulate:TofflistListData;
      
      private var _consortiaAssetDay:TofflistListData;
      
      private var _consortiaAssetWeek:TofflistListData;
      
      private var _consortiaAssetAccumulate:TofflistListData;
      
      private var _consortiaExploitDay:TofflistListData;
      
      private var _consortiaExploitWeek:TofflistListData;
      
      private var _consortiaExploitAccumulate:TofflistListData;
      
      private var _ConsortiaCharmvalueDay:TofflistListData;
      
      private var _ConsortiaCharmvalueWeek:TofflistListData;
      
      private var _ConsortiaCharmvalue:TofflistListData;
      
      private var _crossServerPersonalBattleAccumulate:TofflistListData;
      
      private var _crossServerIndividualGradeDay:TofflistListData;
      
      private var _crossServerIndividualGradeWeek:TofflistListData;
      
      private var _crossServerIndividualGradeAccumulate:TofflistListData;
      
      private var _crossServerIndividualExploitDay:TofflistListData;
      
      private var _crossServerIndividualExploitWeek:TofflistListData;
      
      private var _crossServerIndividualExploitAccumulate:TofflistListData;
      
      private var _crossServerPersonalAchievementPointDay:TofflistListData;
      
      private var _crossServerPersonalAchievementPointWeek:TofflistListData;
      
      private var _crossServerPersonalAchievementPoint:TofflistListData;
      
      private var _crossServerPersonalCharmvalueDay:TofflistListData;
      
      private var _crossServerPersonalCharmvalueWeek:TofflistListData;
      
      private var _crossServerPersonalCharmvalue:TofflistListData;
      
      private var _crossServerIndividualMountsAccumulate:TofflistListData;
      
      private var _crossServerConsortiaBattleAccumulate:TofflistListData;
      
      private var _crossServerConsortiaGradeAccumulate:TofflistListData;
      
      private var _crossServerConsortiaAssetDay:TofflistListData;
      
      private var _crossServerConsortiaAssetWeek:TofflistListData;
      
      private var _crossServerConsortiaAssetAccumulate:TofflistListData;
      
      private var _crossServerConsortiaExploitDay:TofflistListData;
      
      private var _crossServerConsortiaExploitWeek:TofflistListData;
      
      private var _crossServerConsortiaExploitAccumulate:TofflistListData;
      
      private var _crossServerConsortiaCharmvalueDay:TofflistListData;
      
      private var _crossServerConsortiaCharmvalueWeek:TofflistListData;
      
      private var _crossServerConsortiaCharmvalue:TofflistListData;
      
      private var _myConsortiaAuditingApplyData:Vector.<ConsortiaApplyInfo>;
      
      private var _theServerTeamIntegral:TofflistListData;
      
      private var _crossServerTeamIntegral:TofflistListData;
      
      public var rankInfo:RankInfo;
      
      public function TofflistModel()
      {
         super();
      }
      
      public static function addEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         _dispatcher.addEventListener(param1,param2,param3);
      }
      
      public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         _dispatcher.removeEventListener(param1,param2,param3);
      }
      
      public static function set firstMenuType(param1:String) : void
      {
         _firstMenuType = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflisttypechange",param1));
      }
      
      public static function get firstMenuType() : String
      {
         return _firstMenuType;
      }
      
      public static function set secondMenuType(param1:String) : void
      {
         _secondMenuType = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflisttypechange",param1));
      }
      
      public static function get secondMenuType() : String
      {
         return _secondMenuType;
      }
      
      public static function set thirdMenuType(param1:String) : void
      {
         _thirdMenuType = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflisttypechange",param1));
      }
      
      public static function get thirdMenuType() : String
      {
         return _thirdMenuType;
      }
      
      public static function set currentPlayerInfo(param1:PlayerInfo) : void
      {
         _currentPlayerInfo = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflistcurrentplaye",param1));
      }
      
      public static function get currentPlayerInfo() : PlayerInfo
      {
         return _currentPlayerInfo;
      }
      
      public static function set currentConsortiaInfo(param1:ConsortiaInfo) : void
      {
         _currentConsortiaInfo = param1;
      }
      
      public static function get currentConsortiaInfo() : ConsortiaInfo
      {
         return _currentConsortiaInfo;
      }
      
      public static function get Instance() : TofflistModel
      {
         if(_instance == null)
         {
            _instance = new TofflistModel();
         }
         return _instance;
      }
      
      public static function get mountsLevelInfo() : String
      {
         return _mountsLevelInfo;
      }
      
      public static function set mountsLevelInfo(param1:String) : void
      {
         _mountsLevelInfo = param1;
      }
      
      public static function get currentTeamInfo() : TeamRankInfo
      {
         return _currentTeamInfo;
      }
      
      public static function set currentTeamInfo(param1:TeamRankInfo) : void
      {
         _currentTeamInfo = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflistcurrentplaye",param1));
      }
      
      public function set personalBattleAccumulate(param1:TofflistListData) : void
      {
         _personalBattleAccumulate = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflistdatachange",getTofflistEventParams("personalBattleAccumulate",_personalBattleAccumulate)));
      }
      
      public function get personalBattleAccumulate() : TofflistListData
      {
         return _personalBattleAccumulate;
      }
      
      public function set individualGradeDay(param1:TofflistListData) : void
      {
         this._individualGradeDay = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflistdatachange",getTofflistEventParams("individualGradeDay",_individualGradeDay)));
      }
      
      public function get individualGradeDay() : TofflistListData
      {
         return this._individualGradeDay;
      }
      
      public function set individualGradeWeek(param1:TofflistListData) : void
      {
         this._individualGradeWeek = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflistdatachange",getTofflistEventParams("individualgradeWeek",_individualGradeWeek)));
      }
      
      public function get individualGradeWeek() : TofflistListData
      {
         return this._individualGradeWeek;
      }
      
      public function set individualGradeAccumulate(param1:TofflistListData) : void
      {
         this._individualGradeAccumulate = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflistdatachange",getTofflistEventParams("individualgradeweek",_individualGradeAccumulate)));
      }
      
      public function get individualGradeAccumulate() : TofflistListData
      {
         return this._individualGradeAccumulate;
      }
      
      public function set individualExploitDay(param1:TofflistListData) : void
      {
         this._individualExploitDay = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflistdatachange",getTofflistEventParams("individualexploitday",_individualExploitDay)));
      }
      
      public function get individualExploitDay() : TofflistListData
      {
         return this._individualExploitDay;
      }
      
      public function set individualExploitWeek(param1:TofflistListData) : void
      {
         this._individualExploitWeek = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflistdatachange",getTofflistEventParams("individualexploitweek",_individualExploitWeek)));
      }
      
      public function get individualExploitWeek() : TofflistListData
      {
         return this._individualExploitWeek;
      }
      
      public function set individualExploitAccumulate(param1:TofflistListData) : void
      {
         this._individualExploitAccumulate = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflistdatachange",getTofflistEventParams("individualexploitaccumulate",_individualExploitAccumulate)));
      }
      
      public function get individualExploitAccumulate() : TofflistListData
      {
         return this._individualExploitAccumulate;
      }
      
      public function set PersonalAchievementPointDay(param1:TofflistListData) : void
      {
         _personalAchievementPointDay = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflistdatachange",getTofflistEventParams("individualAchievementPointDay",_personalAchievementPointDay)));
      }
      
      public function get PersonalAchievementPointDay() : TofflistListData
      {
         return _personalAchievementPointDay;
      }
      
      public function set PersonalAchievementPointWeek(param1:TofflistListData) : void
      {
         _personalAchievementPointWeek = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflistdatachange",getTofflistEventParams("individualAchievementPointWeek",_personalAchievementPointWeek)));
      }
      
      public function get PersonalAchievementPointWeek() : TofflistListData
      {
         return _personalAchievementPointWeek;
      }
      
      public function set PersonalAchievementPoint(param1:TofflistListData) : void
      {
         _personalAchievementPoint = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflistdatachange",getTofflistEventParams("individualAchievementPointAccumulate",_personalAchievementPoint)));
      }
      
      public function get PersonalAchievementPoint() : TofflistListData
      {
         return _personalAchievementPoint;
      }
      
      public function set PersonalCharmvalueDay(param1:TofflistListData) : void
      {
         _PersonalCharmvalueDay = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflistdatachange",getTofflistEventParams("individualcharmvalueday",_PersonalCharmvalueDay)));
      }
      
      public function get PersonalCharmvalueDay() : TofflistListData
      {
         return _PersonalCharmvalueDay;
      }
      
      public function set PersonalCharmvalueWeek(param1:TofflistListData) : void
      {
         _PersonalCharmvalueWeek = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflistdatachange",getTofflistEventParams("individualcharmvalueweek",_PersonalCharmvalueWeek)));
      }
      
      public function get PersonalCharmvalueWeek() : TofflistListData
      {
         return _PersonalCharmvalueWeek;
      }
      
      public function set PersonalCharmvalue(param1:TofflistListData) : void
      {
         _PersonalCharmvalue = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflistdatachange",getTofflistEventParams("individualcharmvalueaccumulate",_PersonalCharmvalue)));
      }
      
      public function get PersonalCharmvalue() : TofflistListData
      {
         return _PersonalCharmvalue;
      }
      
      public function get personalMatchesDay() : TofflistListData
      {
         return _personalMatchesDay;
      }
      
      public function set personalMatchesDay(param1:TofflistListData) : void
      {
         _personalMatchesDay = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflistdatachange",getTofflistEventParams("individualMatchesDay",_personalMatchesDay)));
      }
      
      public function get personalMatchesWeek() : TofflistListData
      {
         return _personalMatchesWeek;
      }
      
      public function set personalMatchesWeek(param1:TofflistListData) : void
      {
         _personalMatchesWeek = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflistdatachange",getTofflistEventParams("individualMatchesWeek",_personalMatchesWeek)));
      }
      
      public function get personalMatchesTotal() : TofflistListData
      {
         return _personalMatchesTotal;
      }
      
      public function set personalMatchesTotal(param1:TofflistListData) : void
      {
         _personalMatchesTotal = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflistdatachange",getTofflistEventParams("individualMatchesTotal",_personalMatchesTotal)));
      }
      
      public function get personalMountsAccumulate() : TofflistListData
      {
         return _personalMountsAccumulate;
      }
      
      public function set personalMountsAccumulate(param1:TofflistListData) : void
      {
         _personalMountsAccumulate = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflistdatachange",getTofflistEventParams("individualMountsaccumulate",_personalMountsAccumulate)));
      }
      
      public function set consortiaBattleAccumulate(param1:TofflistListData) : void
      {
         _consortiaBattleAccumulate = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflistdatachange",getTofflistEventParams("consortiaBattleAccumulate",_consortiaBattleAccumulate)));
      }
      
      public function get consortiaBattleAccumulate() : TofflistListData
      {
         return _consortiaBattleAccumulate;
      }
      
      public function set consortiaGradeAccumulate(param1:TofflistListData) : void
      {
         this._consortiaGradeAccumulate = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflistdatachange",getTofflistEventParams("consortiagradeaccumulate",_consortiaGradeAccumulate)));
      }
      
      public function get consortiaGradeAccumulate() : TofflistListData
      {
         return this._consortiaGradeAccumulate;
      }
      
      public function set consortiaAssetDay(param1:TofflistListData) : void
      {
         this._consortiaAssetDay = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflistdatachange",getTofflistEventParams("consortiaassetday",_consortiaAssetDay)));
      }
      
      public function get consortiaAssetDay() : TofflistListData
      {
         return this._consortiaAssetDay;
      }
      
      public function set consortiaAssetWeek(param1:TofflistListData) : void
      {
         this._consortiaAssetWeek = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflistdatachange",getTofflistEventParams("consortiaassetweek",_consortiaAssetWeek)));
      }
      
      public function get consortiaAssetWeek() : TofflistListData
      {
         return this._consortiaAssetWeek;
      }
      
      public function set consortiaAssetAccumulate(param1:TofflistListData) : void
      {
         this._consortiaAssetAccumulate = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflistdatachange",getTofflistEventParams("consortiaassetaccumulate",_consortiaAssetAccumulate)));
      }
      
      public function get consortiaAssetAccumulate() : TofflistListData
      {
         return this._consortiaAssetAccumulate;
      }
      
      public function set consortiaExploitDay(param1:TofflistListData) : void
      {
         this._consortiaExploitDay = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflistdatachange",getTofflistEventParams("consortiaexploitday",_consortiaExploitDay)));
      }
      
      public function get consortiaExploitDay() : TofflistListData
      {
         return this._consortiaExploitDay;
      }
      
      public function set consortiaExploitWeek(param1:TofflistListData) : void
      {
         this._consortiaExploitWeek = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflistdatachange",getTofflistEventParams("consortiaexploitweek",_consortiaExploitWeek)));
      }
      
      public function get consortiaExploitWeek() : TofflistListData
      {
         return this._consortiaExploitWeek;
      }
      
      public function set consortiaExploitAccumulate(param1:TofflistListData) : void
      {
         this._consortiaExploitAccumulate = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflistdatachange",getTofflistEventParams("consortiaexploitaccumulate",_consortiaExploitAccumulate)));
      }
      
      public function get consortiaExploitAccumulate() : TofflistListData
      {
         return this._consortiaExploitAccumulate;
      }
      
      public function set ConsortiaCharmvalueDay(param1:TofflistListData) : void
      {
         _ConsortiaCharmvalueDay = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflistdatachange",getTofflistEventParams("consortiacharmvalueday",_ConsortiaCharmvalueDay)));
      }
      
      public function get ConsortiaCharmvalueDay() : TofflistListData
      {
         return _ConsortiaCharmvalueDay;
      }
      
      public function set ConsortiaCharmvalueWeek(param1:TofflistListData) : void
      {
         _ConsortiaCharmvalueWeek = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflistdatachange",getTofflistEventParams("consortiacharmvalueweek",_ConsortiaCharmvalueWeek)));
      }
      
      public function get ConsortiaCharmvalueWeek() : TofflistListData
      {
         return _ConsortiaCharmvalueWeek;
      }
      
      public function set ConsortiaCharmvalue(param1:TofflistListData) : void
      {
         _ConsortiaCharmvalue = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflistdatachange",getTofflistEventParams("consortiacharmvalueAccumulate",_ConsortiaCharmvalue)));
      }
      
      public function get ConsortiaCharmvalue() : TofflistListData
      {
         return _ConsortiaCharmvalue;
      }
      
      public function set crossServerPersonalBattleAccumulate(param1:TofflistListData) : void
      {
         _crossServerPersonalBattleAccumulate = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("crossServerTofflistDataChange",getTofflistEventParams("personalBattleAccumulate",_crossServerPersonalBattleAccumulate)));
      }
      
      public function get crossServerPersonalBattleAccumulate() : TofflistListData
      {
         return _crossServerPersonalBattleAccumulate;
      }
      
      public function set crossServerIndividualGradeDay(param1:TofflistListData) : void
      {
         this._crossServerIndividualGradeDay = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("crossServerTofflistDataChange",getTofflistEventParams("individualGradeDay",_crossServerIndividualGradeDay)));
      }
      
      public function get crossServerIndividualGradeDay() : TofflistListData
      {
         return this._crossServerIndividualGradeDay;
      }
      
      public function set crossServerIndividualGradeWeek(param1:TofflistListData) : void
      {
         this._crossServerIndividualGradeWeek = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("crossServerTofflistDataChange",getTofflistEventParams("individualgradeWeek",_crossServerIndividualGradeWeek)));
      }
      
      public function get crossServerIndividualGradeWeek() : TofflistListData
      {
         return this._crossServerIndividualGradeWeek;
      }
      
      public function set crossServerIndividualGradeAccumulate(param1:TofflistListData) : void
      {
         this._crossServerIndividualGradeAccumulate = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("crossServerTofflistDataChange",getTofflistEventParams("individualgradeweek",_crossServerIndividualGradeAccumulate)));
      }
      
      public function get crossServerIndividualGradeAccumulate() : TofflistListData
      {
         return this._crossServerIndividualGradeAccumulate;
      }
      
      public function set crossServerIndividualExploitDay(param1:TofflistListData) : void
      {
         this._crossServerIndividualExploitDay = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("crossServerTofflistDataChange",getTofflistEventParams("individualexploitday",_crossServerIndividualExploitDay)));
      }
      
      public function get crossServerIndividualExploitDay() : TofflistListData
      {
         return this._crossServerIndividualExploitDay;
      }
      
      public function set crossServerIndividualExploitWeek(param1:TofflistListData) : void
      {
         this._crossServerIndividualExploitWeek = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("crossServerTofflistDataChange",getTofflistEventParams("individualexploitweek",_crossServerIndividualExploitWeek)));
      }
      
      public function get crossServerIndividualExploitWeek() : TofflistListData
      {
         return this._crossServerIndividualExploitWeek;
      }
      
      public function set crossServerIndividualExploitAccumulate(param1:TofflistListData) : void
      {
         this._crossServerIndividualExploitAccumulate = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("crossServerTofflistDataChange",getTofflistEventParams("individualexploitaccumulate",_crossServerIndividualExploitAccumulate)));
      }
      
      public function get crossServerIndividualExploitAccumulate() : TofflistListData
      {
         return this._crossServerIndividualExploitAccumulate;
      }
      
      public function set crossServerPersonalAchievementPointDay(param1:TofflistListData) : void
      {
         _crossServerPersonalAchievementPointDay = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("crossServerTofflistDataChange",getTofflistEventParams("consortiaAchievementPointDay",_crossServerPersonalAchievementPointDay)));
      }
      
      public function get crossServerPersonalAchievementPointDay() : TofflistListData
      {
         return _crossServerPersonalAchievementPointDay;
      }
      
      public function set crossServerPersonalAchievementPointWeek(param1:TofflistListData) : void
      {
         _crossServerPersonalAchievementPointWeek = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("crossServerTofflistDataChange",getTofflistEventParams("consortiaAchievementPointWeek",_crossServerPersonalAchievementPointWeek)));
      }
      
      public function get crossServerPersonalAchievementPointWeek() : TofflistListData
      {
         return _crossServerPersonalAchievementPointWeek;
      }
      
      public function set crossServerPersonalAchievementPoint(param1:TofflistListData) : void
      {
         _crossServerPersonalAchievementPoint = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("crossServerTofflistDataChange",getTofflistEventParams("consortiaAchievementPointAccumulate",_crossServerPersonalAchievementPoint)));
      }
      
      public function get crossServerPersonalAchievementPoint() : TofflistListData
      {
         return _crossServerPersonalAchievementPoint;
      }
      
      public function set crossServerPersonalCharmvalueDay(param1:TofflistListData) : void
      {
         _crossServerPersonalCharmvalueDay = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("crossServerTofflistDataChange",getTofflistEventParams("individualcharmvalueday",_crossServerPersonalCharmvalueDay)));
      }
      
      public function get crossServerPersonalCharmvalueDay() : TofflistListData
      {
         return _crossServerPersonalCharmvalueDay;
      }
      
      public function set crossServerPersonalCharmvalueWeek(param1:TofflistListData) : void
      {
         _crossServerPersonalCharmvalueWeek = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("crossServerTofflistDataChange",getTofflistEventParams("individualcharmvalueweek",_crossServerPersonalCharmvalueWeek)));
      }
      
      public function get crossServerPersonalCharmvalueWeek() : TofflistListData
      {
         return _crossServerPersonalCharmvalueWeek;
      }
      
      public function set crossServerPersonalCharmvalue(param1:TofflistListData) : void
      {
         _crossServerPersonalCharmvalue = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("crossServerTofflistDataChange",getTofflistEventParams("individualcharmvalueaccumulate",_crossServerPersonalCharmvalue)));
      }
      
      public function get crossServerPersonalCharmvalue() : TofflistListData
      {
         return _crossServerPersonalCharmvalue;
      }
      
      public function set crossServerIndividualMountsAccumulate(param1:TofflistListData) : void
      {
         _crossServerIndividualMountsAccumulate = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("crossServerTofflistDataChange",getTofflistEventParams("individualMountsaccumulate",_crossServerIndividualMountsAccumulate)));
      }
      
      public function get crossServerIndividualMountsAccumulate() : TofflistListData
      {
         return _crossServerIndividualMountsAccumulate;
      }
      
      public function set crossServerConsortiaBattleAccumulate(param1:TofflistListData) : void
      {
         _crossServerConsortiaBattleAccumulate = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("crossServerTofflistDataChange",getTofflistEventParams("consortiaBattleAccumulate",_crossServerConsortiaBattleAccumulate)));
      }
      
      public function get crossServerConsortiaBattleAccumulate() : TofflistListData
      {
         return _crossServerConsortiaBattleAccumulate;
      }
      
      public function set crossServerConsortiaGradeAccumulate(param1:TofflistListData) : void
      {
         this._crossServerConsortiaGradeAccumulate = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("crossServerTofflistDataChange",getTofflistEventParams("consortiagradeaccumulate",_crossServerConsortiaGradeAccumulate)));
      }
      
      public function get crossServerConsortiaGradeAccumulate() : TofflistListData
      {
         return this._crossServerConsortiaGradeAccumulate;
      }
      
      public function set crossServerConsortiaAssetDay(param1:TofflistListData) : void
      {
         this._crossServerConsortiaAssetDay = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("crossServerTofflistDataChange",getTofflistEventParams("consortiaassetday",_crossServerConsortiaAssetDay)));
      }
      
      public function get crossServerConsortiaAssetDay() : TofflistListData
      {
         return this._crossServerConsortiaAssetDay;
      }
      
      public function set crossServerConsortiaAssetWeek(param1:TofflistListData) : void
      {
         this._crossServerConsortiaAssetWeek = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("crossServerTofflistDataChange",getTofflistEventParams("consortiaassetweek",_crossServerConsortiaAssetWeek)));
      }
      
      public function get crossServerConsortiaAssetWeek() : TofflistListData
      {
         return this._crossServerConsortiaAssetWeek;
      }
      
      public function set crossServerConsortiaAssetAccumulate(param1:TofflistListData) : void
      {
         this._crossServerConsortiaAssetAccumulate = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("crossServerTofflistDataChange",getTofflistEventParams("consortiaassetaccumulate",_crossServerConsortiaAssetAccumulate)));
      }
      
      public function get crossServerConsortiaAssetAccumulate() : TofflistListData
      {
         return this._crossServerConsortiaAssetAccumulate;
      }
      
      public function set crossServerConsortiaExploitDay(param1:TofflistListData) : void
      {
         this._crossServerConsortiaExploitDay = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("crossServerTofflistDataChange",getTofflistEventParams("consortiaexploitday",_crossServerConsortiaExploitDay)));
      }
      
      public function get crossServerConsortiaExploitDay() : TofflistListData
      {
         return this._crossServerConsortiaExploitDay;
      }
      
      public function set crossServerConsortiaExploitWeek(param1:TofflistListData) : void
      {
         this._crossServerConsortiaExploitWeek = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("crossServerTofflistDataChange",getTofflistEventParams("consortiaexploitweek",_crossServerConsortiaExploitWeek)));
      }
      
      public function get crossServerConsortiaExploitWeek() : TofflistListData
      {
         return this._crossServerConsortiaExploitWeek;
      }
      
      public function set crossServerConsortiaExploitAccumulate(param1:TofflistListData) : void
      {
         this._crossServerConsortiaExploitAccumulate = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("crossServerTofflistDataChange",getTofflistEventParams("consortiaexploitaccumulate",_crossServerConsortiaExploitAccumulate)));
      }
      
      public function get crossServerConsortiaExploitAccumulate() : TofflistListData
      {
         return this._crossServerConsortiaExploitAccumulate;
      }
      
      public function set crossServerConsortiaCharmvalueDay(param1:TofflistListData) : void
      {
         _crossServerConsortiaCharmvalueDay = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("crossServerTofflistDataChange",getTofflistEventParams("consortiacharmvalueday",_crossServerConsortiaCharmvalueDay)));
      }
      
      public function get crossServerConsortiaCharmvalueDay() : TofflistListData
      {
         return _crossServerConsortiaCharmvalueDay;
      }
      
      public function set crossServerConsortiaCharmvalueWeek(param1:TofflistListData) : void
      {
         _crossServerConsortiaCharmvalueWeek = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("crossServerTofflistDataChange",getTofflistEventParams("consortiacharmvalueweek",_crossServerConsortiaCharmvalueWeek)));
      }
      
      public function get crossServerConsortiaCharmvalueWeek() : TofflistListData
      {
         return _crossServerConsortiaCharmvalueWeek;
      }
      
      public function set crossServerConsortiaCharmvalue(param1:TofflistListData) : void
      {
         _crossServerConsortiaCharmvalue = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("crossServerTofflistDataChange",getTofflistEventParams("consortiacharmvalueAccumulate",_crossServerConsortiaCharmvalue)));
      }
      
      public function get crossServerConsortiaCharmvalue() : TofflistListData
      {
         return _crossServerConsortiaCharmvalue;
      }
      
      private function getTofflistEventParams(param1:String, param2:TofflistListData) : Object
      {
         var _loc3_:Object = {};
         _loc3_.flag = param1;
         _loc3_.data = param2;
         return _loc3_;
      }
      
      public function set myConsortiaAuditingApplyData(param1:Vector.<ConsortiaApplyInfo>) : void
      {
         _myConsortiaAuditingApplyData = param1;
      }
      
      public function get myConsortiaAuditingApplyData() : Vector.<ConsortiaApplyInfo>
      {
         return _myConsortiaAuditingApplyData;
      }
      
      public function set theServerTeamIntegral(param1:TofflistListData) : void
      {
         _theServerTeamIntegral = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("tofflistdatachange",getTofflistEventParams("teamIntegral",_theServerTeamIntegral)));
      }
      
      public function get theServerTeamIntegral() : TofflistListData
      {
         return _theServerTeamIntegral;
      }
      
      public function set crossServerTeamIntegral(param1:TofflistListData) : void
      {
         _crossServerTeamIntegral = param1;
         _dispatcher.dispatchEvent(new TofflistEvent("crossServerTofflistDataChange",getTofflistEventParams("teamIntegral",_crossServerTeamIntegral)));
      }
      
      public function get crossServerTeamIntegral() : TofflistListData
      {
         return _crossServerTeamIntegral;
      }
      
      public function loadRankInfo() : void
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_["userID"] = PlayerManager.Instance.Self.ID;
         _loc1_["ConsortiaID"] = PlayerManager.Instance.Self.ConsortiaID;
         var _loc2_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("UserRankDate.ashx"),6,_loc1_);
         _loc2_.loadErrorMessage = "";
         _loc2_.analyzer = new RankInfoAnalyz(_loadRankCom);
         LoadResourceManager.Instance.startLoad(_loc2_);
      }
      
      private function _loadRankCom(param1:RankInfoAnalyz) : void
      {
         rankInfo = param1.info;
         _dispatcher.dispatchEvent(new TofflistEvent("rankInfo_ready"));
      }
   }
}
