package ddt.manager
{
   import com.pickgliss.loader.DataAnalyzer;
   import ddt.data.DailyLeagueAwardInfo;
   import ddt.data.DailyLeagueLevelInfo;
   import ddt.data.analyze.DailyLeagueAwardAnalyzer;
   import ddt.data.analyze.DailyLeagueLevelAnalyzer;
   import flash.events.EventDispatcher;
   
   public class DailyLeagueManager extends EventDispatcher
   {
      
      private static var _instance:DailyLeagueManager;
      
      private static const PLAYER_LEVEL:Array = [[20,29],[30,39],[40,49]];
       
      
      private var _leagueLevelRank:Array;
      
      private var _leagueAwardList:Array;
      
      private var _lv1:int;
      
      private var _lv2:int;
      
      private var _scoreLv:int;
      
      public function DailyLeagueManager()
      {
         super();
      }
      
      public static function get Instance() : DailyLeagueManager
      {
         if(_instance == null)
         {
            _instance = new DailyLeagueManager();
         }
         return _instance;
      }
      
      public function setup(analyzer:DataAnalyzer) : void
      {
         if(analyzer is DailyLeagueAwardAnalyzer)
         {
            _leagueAwardList = DailyLeagueAwardAnalyzer(analyzer).list;
         }
         else if(analyzer is DailyLeagueLevelAnalyzer)
         {
            _leagueLevelRank = DailyLeagueLevelAnalyzer(analyzer).list;
         }
      }
      
      public function getLeagueLevelByScore(score:Number, leagueFirst:Boolean = false) : DailyLeagueLevelInfo
      {
         var i:int = 0;
         var leagueLevel:DailyLeagueLevelInfo = new DailyLeagueLevelInfo();
         if(leagueFirst)
         {
            leagueLevel = _leagueLevelRank[0];
            return leagueLevel;
         }
         i = 0;
         while(i < _leagueLevelRank.length)
         {
            if(_leagueLevelRank[i].Score > -1 && score >= _leagueLevelRank[i].Score)
            {
               leagueLevel = _leagueLevelRank[i];
            }
            i++;
         }
         return leagueLevel;
      }
      
      public function filterLeagueAwardList(playerLv:int, scoreLv:int) : Array
      {
         _lv1 = PLAYER_LEVEL[playerLv][0];
         _lv2 = PLAYER_LEVEL[playerLv][1];
         _scoreLv = playerLv * 4 + (scoreLv + 1);
         return _leagueAwardList.filter(filterLeagueAwardListCallback);
      }
      
      private function filterLeagueAwardListCallback(item:DailyLeagueAwardInfo, index:int, array:Array) : Boolean
      {
         if(item.Level >= _lv1 && item.Level <= _lv2 && item.Class == _scoreLv)
         {
            return true;
         }
         return false;
      }
   }
}
