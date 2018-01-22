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
      
      public function setup(param1:DataAnalyzer) : void
      {
         if(param1 is DailyLeagueAwardAnalyzer)
         {
            _leagueAwardList = DailyLeagueAwardAnalyzer(param1).list;
         }
         else if(param1 is DailyLeagueLevelAnalyzer)
         {
            _leagueLevelRank = DailyLeagueLevelAnalyzer(param1).list;
         }
      }
      
      public function getLeagueLevelByScore(param1:Number, param2:Boolean = false) : DailyLeagueLevelInfo
      {
         var _loc4_:int = 0;
         var _loc3_:DailyLeagueLevelInfo = new DailyLeagueLevelInfo();
         if(param2)
         {
            _loc3_ = _leagueLevelRank[0];
            return _loc3_;
         }
         _loc4_ = 0;
         while(_loc4_ < _leagueLevelRank.length)
         {
            if(_leagueLevelRank[_loc4_].Score > -1 && param1 >= _leagueLevelRank[_loc4_].Score)
            {
               _loc3_ = _leagueLevelRank[_loc4_];
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function filterLeagueAwardList(param1:int, param2:int) : Array
      {
         _lv1 = PLAYER_LEVEL[param1][0];
         _lv2 = PLAYER_LEVEL[param1][1];
         _scoreLv = param1 * 4 + (param2 + 1);
         return _leagueAwardList.filter(filterLeagueAwardListCallback);
      }
      
      private function filterLeagueAwardListCallback(param1:DailyLeagueAwardInfo, param2:int, param3:Array) : Boolean
      {
         if(param1.Level >= _lv1 && param1.Level <= _lv2 && param1.Class == _scoreLv)
         {
            return true;
         }
         return false;
      }
   }
}
