package uiModeManager.bombUI.model.bomb
{
   public class BombGameModel
   {
      
      public static const Bomb_TotalRank:int = 1;
      
      public static const Bomb_DayRank:int = 2;
       
      
      public var BombTrain:Array;
      
      public var bombPos:Array;
      
      public var CurrentGameCanBeClickTimes:int;
      
      public var CurrentScores:int;
      
      public var rankDayFixInfos:Vector.<BombRankInfo>;
      
      public var rankTotalFixInfos:Vector.<BombRankInfo>;
      
      public var rankDayRandomInfos:Vector.<BombRankInfo>;
      
      public var rankTotalRandomInfos:Vector.<BombRankInfo>;
      
      public var fixGameDayMaxLevel:int;
      
      public var fixGameDayMaxScore:int;
      
      public var fixGameHisMaxLevel:int;
      
      public var fixGameHisMaxScore:int;
      
      private var _randomGameDayMaxScore:int;
      
      private var _randomGameHisMaxScore:int;
      
      public function BombGameModel(){super();}
      
      public function get randomGameHisMaxScore() : int{return 0;}
      
      public function set randomGameHisMaxScore(param1:int) : void{}
      
      public function get randomGameDayMaxScore() : int{return 0;}
      
      public function set randomGameDayMaxScore(param1:int) : void{}
      
      public function clearData() : void{}
   }
}
