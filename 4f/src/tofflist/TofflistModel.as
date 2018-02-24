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
      
      public function TofflistModel(){super();}
      
      public static function addEventListener(param1:String, param2:Function, param3:Boolean = false) : void{}
      
      public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void{}
      
      public static function set firstMenuType(param1:String) : void{}
      
      public static function get firstMenuType() : String{return null;}
      
      public static function set secondMenuType(param1:String) : void{}
      
      public static function get secondMenuType() : String{return null;}
      
      public static function set thirdMenuType(param1:String) : void{}
      
      public static function get thirdMenuType() : String{return null;}
      
      public static function set currentPlayerInfo(param1:PlayerInfo) : void{}
      
      public static function get currentPlayerInfo() : PlayerInfo{return null;}
      
      public static function set currentConsortiaInfo(param1:ConsortiaInfo) : void{}
      
      public static function get currentConsortiaInfo() : ConsortiaInfo{return null;}
      
      public static function get Instance() : TofflistModel{return null;}
      
      public static function get mountsLevelInfo() : String{return null;}
      
      public static function set mountsLevelInfo(param1:String) : void{}
      
      public static function get currentTeamInfo() : TeamRankInfo{return null;}
      
      public static function set currentTeamInfo(param1:TeamRankInfo) : void{}
      
      public function set personalBattleAccumulate(param1:TofflistListData) : void{}
      
      public function get personalBattleAccumulate() : TofflistListData{return null;}
      
      public function set individualGradeDay(param1:TofflistListData) : void{}
      
      public function get individualGradeDay() : TofflistListData{return null;}
      
      public function set individualGradeWeek(param1:TofflistListData) : void{}
      
      public function get individualGradeWeek() : TofflistListData{return null;}
      
      public function set individualGradeAccumulate(param1:TofflistListData) : void{}
      
      public function get individualGradeAccumulate() : TofflistListData{return null;}
      
      public function set individualExploitDay(param1:TofflistListData) : void{}
      
      public function get individualExploitDay() : TofflistListData{return null;}
      
      public function set individualExploitWeek(param1:TofflistListData) : void{}
      
      public function get individualExploitWeek() : TofflistListData{return null;}
      
      public function set individualExploitAccumulate(param1:TofflistListData) : void{}
      
      public function get individualExploitAccumulate() : TofflistListData{return null;}
      
      public function set PersonalAchievementPointDay(param1:TofflistListData) : void{}
      
      public function get PersonalAchievementPointDay() : TofflistListData{return null;}
      
      public function set PersonalAchievementPointWeek(param1:TofflistListData) : void{}
      
      public function get PersonalAchievementPointWeek() : TofflistListData{return null;}
      
      public function set PersonalAchievementPoint(param1:TofflistListData) : void{}
      
      public function get PersonalAchievementPoint() : TofflistListData{return null;}
      
      public function set PersonalCharmvalueDay(param1:TofflistListData) : void{}
      
      public function get PersonalCharmvalueDay() : TofflistListData{return null;}
      
      public function set PersonalCharmvalueWeek(param1:TofflistListData) : void{}
      
      public function get PersonalCharmvalueWeek() : TofflistListData{return null;}
      
      public function set PersonalCharmvalue(param1:TofflistListData) : void{}
      
      public function get PersonalCharmvalue() : TofflistListData{return null;}
      
      public function get personalMatchesDay() : TofflistListData{return null;}
      
      public function set personalMatchesDay(param1:TofflistListData) : void{}
      
      public function get personalMatchesWeek() : TofflistListData{return null;}
      
      public function set personalMatchesWeek(param1:TofflistListData) : void{}
      
      public function get personalMatchesTotal() : TofflistListData{return null;}
      
      public function set personalMatchesTotal(param1:TofflistListData) : void{}
      
      public function get personalMountsAccumulate() : TofflistListData{return null;}
      
      public function set personalMountsAccumulate(param1:TofflistListData) : void{}
      
      public function set consortiaBattleAccumulate(param1:TofflistListData) : void{}
      
      public function get consortiaBattleAccumulate() : TofflistListData{return null;}
      
      public function set consortiaGradeAccumulate(param1:TofflistListData) : void{}
      
      public function get consortiaGradeAccumulate() : TofflistListData{return null;}
      
      public function set consortiaAssetDay(param1:TofflistListData) : void{}
      
      public function get consortiaAssetDay() : TofflistListData{return null;}
      
      public function set consortiaAssetWeek(param1:TofflistListData) : void{}
      
      public function get consortiaAssetWeek() : TofflistListData{return null;}
      
      public function set consortiaAssetAccumulate(param1:TofflistListData) : void{}
      
      public function get consortiaAssetAccumulate() : TofflistListData{return null;}
      
      public function set consortiaExploitDay(param1:TofflistListData) : void{}
      
      public function get consortiaExploitDay() : TofflistListData{return null;}
      
      public function set consortiaExploitWeek(param1:TofflistListData) : void{}
      
      public function get consortiaExploitWeek() : TofflistListData{return null;}
      
      public function set consortiaExploitAccumulate(param1:TofflistListData) : void{}
      
      public function get consortiaExploitAccumulate() : TofflistListData{return null;}
      
      public function set ConsortiaCharmvalueDay(param1:TofflistListData) : void{}
      
      public function get ConsortiaCharmvalueDay() : TofflistListData{return null;}
      
      public function set ConsortiaCharmvalueWeek(param1:TofflistListData) : void{}
      
      public function get ConsortiaCharmvalueWeek() : TofflistListData{return null;}
      
      public function set ConsortiaCharmvalue(param1:TofflistListData) : void{}
      
      public function get ConsortiaCharmvalue() : TofflistListData{return null;}
      
      public function set crossServerPersonalBattleAccumulate(param1:TofflistListData) : void{}
      
      public function get crossServerPersonalBattleAccumulate() : TofflistListData{return null;}
      
      public function set crossServerIndividualGradeDay(param1:TofflistListData) : void{}
      
      public function get crossServerIndividualGradeDay() : TofflistListData{return null;}
      
      public function set crossServerIndividualGradeWeek(param1:TofflistListData) : void{}
      
      public function get crossServerIndividualGradeWeek() : TofflistListData{return null;}
      
      public function set crossServerIndividualGradeAccumulate(param1:TofflistListData) : void{}
      
      public function get crossServerIndividualGradeAccumulate() : TofflistListData{return null;}
      
      public function set crossServerIndividualExploitDay(param1:TofflistListData) : void{}
      
      public function get crossServerIndividualExploitDay() : TofflistListData{return null;}
      
      public function set crossServerIndividualExploitWeek(param1:TofflistListData) : void{}
      
      public function get crossServerIndividualExploitWeek() : TofflistListData{return null;}
      
      public function set crossServerIndividualExploitAccumulate(param1:TofflistListData) : void{}
      
      public function get crossServerIndividualExploitAccumulate() : TofflistListData{return null;}
      
      public function set crossServerPersonalAchievementPointDay(param1:TofflistListData) : void{}
      
      public function get crossServerPersonalAchievementPointDay() : TofflistListData{return null;}
      
      public function set crossServerPersonalAchievementPointWeek(param1:TofflistListData) : void{}
      
      public function get crossServerPersonalAchievementPointWeek() : TofflistListData{return null;}
      
      public function set crossServerPersonalAchievementPoint(param1:TofflistListData) : void{}
      
      public function get crossServerPersonalAchievementPoint() : TofflistListData{return null;}
      
      public function set crossServerPersonalCharmvalueDay(param1:TofflistListData) : void{}
      
      public function get crossServerPersonalCharmvalueDay() : TofflistListData{return null;}
      
      public function set crossServerPersonalCharmvalueWeek(param1:TofflistListData) : void{}
      
      public function get crossServerPersonalCharmvalueWeek() : TofflistListData{return null;}
      
      public function set crossServerPersonalCharmvalue(param1:TofflistListData) : void{}
      
      public function get crossServerPersonalCharmvalue() : TofflistListData{return null;}
      
      public function set crossServerIndividualMountsAccumulate(param1:TofflistListData) : void{}
      
      public function get crossServerIndividualMountsAccumulate() : TofflistListData{return null;}
      
      public function set crossServerConsortiaBattleAccumulate(param1:TofflistListData) : void{}
      
      public function get crossServerConsortiaBattleAccumulate() : TofflistListData{return null;}
      
      public function set crossServerConsortiaGradeAccumulate(param1:TofflistListData) : void{}
      
      public function get crossServerConsortiaGradeAccumulate() : TofflistListData{return null;}
      
      public function set crossServerConsortiaAssetDay(param1:TofflistListData) : void{}
      
      public function get crossServerConsortiaAssetDay() : TofflistListData{return null;}
      
      public function set crossServerConsortiaAssetWeek(param1:TofflistListData) : void{}
      
      public function get crossServerConsortiaAssetWeek() : TofflistListData{return null;}
      
      public function set crossServerConsortiaAssetAccumulate(param1:TofflistListData) : void{}
      
      public function get crossServerConsortiaAssetAccumulate() : TofflistListData{return null;}
      
      public function set crossServerConsortiaExploitDay(param1:TofflistListData) : void{}
      
      public function get crossServerConsortiaExploitDay() : TofflistListData{return null;}
      
      public function set crossServerConsortiaExploitWeek(param1:TofflistListData) : void{}
      
      public function get crossServerConsortiaExploitWeek() : TofflistListData{return null;}
      
      public function set crossServerConsortiaExploitAccumulate(param1:TofflistListData) : void{}
      
      public function get crossServerConsortiaExploitAccumulate() : TofflistListData{return null;}
      
      public function set crossServerConsortiaCharmvalueDay(param1:TofflistListData) : void{}
      
      public function get crossServerConsortiaCharmvalueDay() : TofflistListData{return null;}
      
      public function set crossServerConsortiaCharmvalueWeek(param1:TofflistListData) : void{}
      
      public function get crossServerConsortiaCharmvalueWeek() : TofflistListData{return null;}
      
      public function set crossServerConsortiaCharmvalue(param1:TofflistListData) : void{}
      
      public function get crossServerConsortiaCharmvalue() : TofflistListData{return null;}
      
      private function getTofflistEventParams(param1:String, param2:TofflistListData) : Object{return null;}
      
      public function set myConsortiaAuditingApplyData(param1:Vector.<ConsortiaApplyInfo>) : void{}
      
      public function get myConsortiaAuditingApplyData() : Vector.<ConsortiaApplyInfo>{return null;}
      
      public function set theServerTeamIntegral(param1:TofflistListData) : void{}
      
      public function get theServerTeamIntegral() : TofflistListData{return null;}
      
      public function set crossServerTeamIntegral(param1:TofflistListData) : void{}
      
      public function get crossServerTeamIntegral() : TofflistListData{return null;}
      
      public function loadRankInfo() : void{}
      
      private function _loadRankCom(param1:RankInfoAnalyz) : void{}
   }
}
