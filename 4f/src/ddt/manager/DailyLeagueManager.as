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
      
      public function DailyLeagueManager(){super();}
      
      public static function get Instance() : DailyLeagueManager{return null;}
      
      public function setup(param1:DataAnalyzer) : void{}
      
      public function getLeagueLevelByScore(param1:Number, param2:Boolean = false) : DailyLeagueLevelInfo{return null;}
      
      public function filterLeagueAwardList(param1:int, param2:int) : Array{return null;}
      
      private function filterLeagueAwardListCallback(param1:DailyLeagueAwardInfo, param2:int, param3:Array) : Boolean{return false;}
   }
}
