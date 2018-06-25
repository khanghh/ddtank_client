package tofflist{   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import consortion.data.ConsortiaApplyInfo;   import ddt.data.ConsortiaInfo;   import ddt.data.player.PlayerInfo;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import flash.events.EventDispatcher;   import flash.net.URLVariables;   import team.model.TeamRankInfo;   import tofflist.analyze.RankInfoAnalyz;   import tofflist.data.RankInfo;   import tofflist.data.TofflistListData;      public class TofflistModel   {            private static var _tofflistType:int;            public static var childType:int;            private static var _currentPlayerInfo:PlayerInfo;            public static var currentText:String;            public static var currentIndex:int;            private static var _currentTeamInfo:TeamRankInfo;            private static var _firstMenuType:String = "personal";            private static var _secondMenuType:String = "battle";            private static var _thirdMenuType:String = "total";            private static var _mountsLevelInfo:String;            private static var _dispatcher:EventDispatcher = new EventDispatcher();            private static var _currentConsortiaInfo:ConsortiaInfo;            private static var _instance:TofflistModel;                   private var _personalBattleAccumulate:TofflistListData;            private var _individualGradeDay:TofflistListData;            private var _individualGradeWeek:TofflistListData;            private var _individualGradeAccumulate:TofflistListData;            private var _individualExploitDay:TofflistListData;            private var _individualExploitWeek:TofflistListData;            private var _individualExploitAccumulate:TofflistListData;            private var _personalAchievementPointDay:TofflistListData;            private var _personalAchievementPointWeek:TofflistListData;            private var _personalAchievementPoint:TofflistListData;            private var _PersonalCharmvalueDay:TofflistListData;            private var _PersonalCharmvalueWeek:TofflistListData;            private var _PersonalCharmvalue:TofflistListData;            private var _personalMatchesDay:TofflistListData;            private var _personalMatchesWeek:TofflistListData;            private var _personalMatchesTotal:TofflistListData;            private var _personalMountsAccumulate:TofflistListData;            private var _consortiaBattleAccumulate:TofflistListData;            private var _consortiaGradeAccumulate:TofflistListData;            private var _consortiaAssetDay:TofflistListData;            private var _consortiaAssetWeek:TofflistListData;            private var _consortiaAssetAccumulate:TofflistListData;            private var _consortiaExploitDay:TofflistListData;            private var _consortiaExploitWeek:TofflistListData;            private var _consortiaExploitAccumulate:TofflistListData;            private var _ConsortiaCharmvalueDay:TofflistListData;            private var _ConsortiaCharmvalueWeek:TofflistListData;            private var _ConsortiaCharmvalue:TofflistListData;            private var _crossServerPersonalBattleAccumulate:TofflistListData;            private var _crossServerIndividualGradeDay:TofflistListData;            private var _crossServerIndividualGradeWeek:TofflistListData;            private var _crossServerIndividualGradeAccumulate:TofflistListData;            private var _crossServerIndividualExploitDay:TofflistListData;            private var _crossServerIndividualExploitWeek:TofflistListData;            private var _crossServerIndividualExploitAccumulate:TofflistListData;            private var _crossServerPersonalAchievementPointDay:TofflistListData;            private var _crossServerPersonalAchievementPointWeek:TofflistListData;            private var _crossServerPersonalAchievementPoint:TofflistListData;            private var _crossServerPersonalCharmvalueDay:TofflistListData;            private var _crossServerPersonalCharmvalueWeek:TofflistListData;            private var _crossServerPersonalCharmvalue:TofflistListData;            private var _crossServerIndividualMountsAccumulate:TofflistListData;            private var _crossServerConsortiaBattleAccumulate:TofflistListData;            private var _crossServerConsortiaGradeAccumulate:TofflistListData;            private var _crossServerConsortiaAssetDay:TofflistListData;            private var _crossServerConsortiaAssetWeek:TofflistListData;            private var _crossServerConsortiaAssetAccumulate:TofflistListData;            private var _crossServerConsortiaExploitDay:TofflistListData;            private var _crossServerConsortiaExploitWeek:TofflistListData;            private var _crossServerConsortiaExploitAccumulate:TofflistListData;            private var _crossServerConsortiaCharmvalueDay:TofflistListData;            private var _crossServerConsortiaCharmvalueWeek:TofflistListData;            private var _crossServerConsortiaCharmvalue:TofflistListData;            private var _myConsortiaAuditingApplyData:Vector.<ConsortiaApplyInfo>;            private var _theServerTeamIntegral:TofflistListData;            private var _crossServerTeamIntegral:TofflistListData;            public var rankInfo:RankInfo;            public function TofflistModel() { super(); }
            public static function addEventListener(type:String, listener:Function, useCapture:Boolean = false) : void { }
            public static function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void { }
            public static function set firstMenuType(type:String) : void { }
            public static function get firstMenuType() : String { return null; }
            public static function set secondMenuType(type:String) : void { }
            public static function get secondMenuType() : String { return null; }
            public static function set thirdMenuType(type:String) : void { }
            public static function get thirdMenuType() : String { return null; }
            public static function set currentPlayerInfo(info:PlayerInfo) : void { }
            public static function get currentPlayerInfo() : PlayerInfo { return null; }
            public static function set currentConsortiaInfo(value:ConsortiaInfo) : void { }
            public static function get currentConsortiaInfo() : ConsortiaInfo { return null; }
            public static function get Instance() : TofflistModel { return null; }
            public static function get mountsLevelInfo() : String { return null; }
            public static function set mountsLevelInfo(value:String) : void { }
            public static function get currentTeamInfo() : TeamRankInfo { return null; }
            public static function set currentTeamInfo(value:TeamRankInfo) : void { }
            public function set personalBattleAccumulate(arr:TofflistListData) : void { }
            public function get personalBattleAccumulate() : TofflistListData { return null; }
            public function set individualGradeDay(arr:TofflistListData) : void { }
            public function get individualGradeDay() : TofflistListData { return null; }
            public function set individualGradeWeek(arr:TofflistListData) : void { }
            public function get individualGradeWeek() : TofflistListData { return null; }
            public function set individualGradeAccumulate(arr:TofflistListData) : void { }
            public function get individualGradeAccumulate() : TofflistListData { return null; }
            public function set individualExploitDay(arr:TofflistListData) : void { }
            public function get individualExploitDay() : TofflistListData { return null; }
            public function set individualExploitWeek(arr:TofflistListData) : void { }
            public function get individualExploitWeek() : TofflistListData { return null; }
            public function set individualExploitAccumulate(arr:TofflistListData) : void { }
            public function get individualExploitAccumulate() : TofflistListData { return null; }
            public function set PersonalAchievementPointDay(value:TofflistListData) : void { }
            public function get PersonalAchievementPointDay() : TofflistListData { return null; }
            public function set PersonalAchievementPointWeek(value:TofflistListData) : void { }
            public function get PersonalAchievementPointWeek() : TofflistListData { return null; }
            public function set PersonalAchievementPoint(value:TofflistListData) : void { }
            public function get PersonalAchievementPoint() : TofflistListData { return null; }
            public function set PersonalCharmvalueDay(value:TofflistListData) : void { }
            public function get PersonalCharmvalueDay() : TofflistListData { return null; }
            public function set PersonalCharmvalueWeek(value:TofflistListData) : void { }
            public function get PersonalCharmvalueWeek() : TofflistListData { return null; }
            public function set PersonalCharmvalue(value:TofflistListData) : void { }
            public function get PersonalCharmvalue() : TofflistListData { return null; }
            public function get personalMatchesDay() : TofflistListData { return null; }
            public function set personalMatchesDay(value:TofflistListData) : void { }
            public function get personalMatchesWeek() : TofflistListData { return null; }
            public function set personalMatchesWeek(value:TofflistListData) : void { }
            public function get personalMatchesTotal() : TofflistListData { return null; }
            public function set personalMatchesTotal(value:TofflistListData) : void { }
            public function get personalMountsAccumulate() : TofflistListData { return null; }
            public function set personalMountsAccumulate(value:TofflistListData) : void { }
            public function set consortiaBattleAccumulate(value:TofflistListData) : void { }
            public function get consortiaBattleAccumulate() : TofflistListData { return null; }
            public function set consortiaGradeAccumulate(arr:TofflistListData) : void { }
            public function get consortiaGradeAccumulate() : TofflistListData { return null; }
            public function set consortiaAssetDay(arr:TofflistListData) : void { }
            public function get consortiaAssetDay() : TofflistListData { return null; }
            public function set consortiaAssetWeek($list:TofflistListData) : void { }
            public function get consortiaAssetWeek() : TofflistListData { return null; }
            public function set consortiaAssetAccumulate(arr:TofflistListData) : void { }
            public function get consortiaAssetAccumulate() : TofflistListData { return null; }
            public function set consortiaExploitDay($list:TofflistListData) : void { }
            public function get consortiaExploitDay() : TofflistListData { return null; }
            public function set consortiaExploitWeek($list:TofflistListData) : void { }
            public function get consortiaExploitWeek() : TofflistListData { return null; }
            public function set consortiaExploitAccumulate(arr:TofflistListData) : void { }
            public function get consortiaExploitAccumulate() : TofflistListData { return null; }
            public function set ConsortiaCharmvalueDay(value:TofflistListData) : void { }
            public function get ConsortiaCharmvalueDay() : TofflistListData { return null; }
            public function set ConsortiaCharmvalueWeek(value:TofflistListData) : void { }
            public function get ConsortiaCharmvalueWeek() : TofflistListData { return null; }
            public function set ConsortiaCharmvalue(value:TofflistListData) : void { }
            public function get ConsortiaCharmvalue() : TofflistListData { return null; }
            public function set crossServerPersonalBattleAccumulate(arr:TofflistListData) : void { }
            public function get crossServerPersonalBattleAccumulate() : TofflistListData { return null; }
            public function set crossServerIndividualGradeDay(arr:TofflistListData) : void { }
            public function get crossServerIndividualGradeDay() : TofflistListData { return null; }
            public function set crossServerIndividualGradeWeek(arr:TofflistListData) : void { }
            public function get crossServerIndividualGradeWeek() : TofflistListData { return null; }
            public function set crossServerIndividualGradeAccumulate(arr:TofflistListData) : void { }
            public function get crossServerIndividualGradeAccumulate() : TofflistListData { return null; }
            public function set crossServerIndividualExploitDay(arr:TofflistListData) : void { }
            public function get crossServerIndividualExploitDay() : TofflistListData { return null; }
            public function set crossServerIndividualExploitWeek(arr:TofflistListData) : void { }
            public function get crossServerIndividualExploitWeek() : TofflistListData { return null; }
            public function set crossServerIndividualExploitAccumulate(arr:TofflistListData) : void { }
            public function get crossServerIndividualExploitAccumulate() : TofflistListData { return null; }
            public function set crossServerPersonalAchievementPointDay(value:TofflistListData) : void { }
            public function get crossServerPersonalAchievementPointDay() : TofflistListData { return null; }
            public function set crossServerPersonalAchievementPointWeek(value:TofflistListData) : void { }
            public function get crossServerPersonalAchievementPointWeek() : TofflistListData { return null; }
            public function set crossServerPersonalAchievementPoint(value:TofflistListData) : void { }
            public function get crossServerPersonalAchievementPoint() : TofflistListData { return null; }
            public function set crossServerPersonalCharmvalueDay(value:TofflistListData) : void { }
            public function get crossServerPersonalCharmvalueDay() : TofflistListData { return null; }
            public function set crossServerPersonalCharmvalueWeek(value:TofflistListData) : void { }
            public function get crossServerPersonalCharmvalueWeek() : TofflistListData { return null; }
            public function set crossServerPersonalCharmvalue(value:TofflistListData) : void { }
            public function get crossServerPersonalCharmvalue() : TofflistListData { return null; }
            public function set crossServerIndividualMountsAccumulate(value:TofflistListData) : void { }
            public function get crossServerIndividualMountsAccumulate() : TofflistListData { return null; }
            public function set crossServerConsortiaBattleAccumulate(value:TofflistListData) : void { }
            public function get crossServerConsortiaBattleAccumulate() : TofflistListData { return null; }
            public function set crossServerConsortiaGradeAccumulate(arr:TofflistListData) : void { }
            public function get crossServerConsortiaGradeAccumulate() : TofflistListData { return null; }
            public function set crossServerConsortiaAssetDay(arr:TofflistListData) : void { }
            public function get crossServerConsortiaAssetDay() : TofflistListData { return null; }
            public function set crossServerConsortiaAssetWeek($list:TofflistListData) : void { }
            public function get crossServerConsortiaAssetWeek() : TofflistListData { return null; }
            public function set crossServerConsortiaAssetAccumulate(arr:TofflistListData) : void { }
            public function get crossServerConsortiaAssetAccumulate() : TofflistListData { return null; }
            public function set crossServerConsortiaExploitDay($list:TofflistListData) : void { }
            public function get crossServerConsortiaExploitDay() : TofflistListData { return null; }
            public function set crossServerConsortiaExploitWeek($list:TofflistListData) : void { }
            public function get crossServerConsortiaExploitWeek() : TofflistListData { return null; }
            public function set crossServerConsortiaExploitAccumulate(arr:TofflistListData) : void { }
            public function get crossServerConsortiaExploitAccumulate() : TofflistListData { return null; }
            public function set crossServerConsortiaCharmvalueDay(value:TofflistListData) : void { }
            public function get crossServerConsortiaCharmvalueDay() : TofflistListData { return null; }
            public function set crossServerConsortiaCharmvalueWeek(value:TofflistListData) : void { }
            public function get crossServerConsortiaCharmvalueWeek() : TofflistListData { return null; }
            public function set crossServerConsortiaCharmvalue(value:TofflistListData) : void { }
            public function get crossServerConsortiaCharmvalue() : TofflistListData { return null; }
            private function getTofflistEventParams(flag:String, data:TofflistListData) : Object { return null; }
            public function set myConsortiaAuditingApplyData(value:Vector.<ConsortiaApplyInfo>) : void { }
            public function get myConsortiaAuditingApplyData() : Vector.<ConsortiaApplyInfo> { return null; }
            public function set theServerTeamIntegral(value:TofflistListData) : void { }
            public function get theServerTeamIntegral() : TofflistListData { return null; }
            public function set crossServerTeamIntegral(value:TofflistListData) : void { }
            public function get crossServerTeamIntegral() : TofflistListData { return null; }
            public function loadRankInfo() : void { }
            private function _loadRankCom(analyzer:RankInfoAnalyz) : void { }
   }}