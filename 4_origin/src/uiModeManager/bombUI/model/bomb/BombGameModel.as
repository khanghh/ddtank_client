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
      
      public function BombGameModel()
      {
         bombPos = new Array([[36,40],[94,40],[150,40],[205,40],[262,40],[316,40],[372,40],[430,40],[485,40],[541,40]],[[36,95],[94,95],[150,95],[205,95],[262,95],[316,95],[372,95],[430,95],[485,95],[541,95]],[[36,151],[94,151],[150,151],[205,151],[262,151],[316,151],[372,151],[430,151],[485,151],[541,151]],[[36,208],[94,208],[150,208],[205,208],[262,208],[316,208],[372,208],[430,208],[485,208],[541,208]],[[36,264],[94,264],[150,264],[205,264],[262,264],[316,264],[372,264],[430,264],[485,264],[541,264]],[[36,320],[94,320],[150,320],[205,320],[262,320],[316,320],[372,320],[430,320],[485,320],[541,320]],[[36,376],[94,376],[150,376],[205,376],[262,376],[316,376],[372,376],[430,376],[485,376],[541,376]],[[36,432],[94,432],[150,432],[205,432],[262,432],[316,432],[372,432],[430,432],[485,432],[541,432]],[[36,488],[94,488],[150,488],[205,488],[262,488],[316,488],[372,488],[430,488],[485,488],[541,488]],[[36,544],[94,544],[150,544],[205,544],[262,544],[316,544],[372,544],[430,544],[485,544],[541,544]]);
         super();
         rankDayFixInfos = new Vector.<BombRankInfo>();
         rankTotalFixInfos = new Vector.<BombRankInfo>();
         rankDayRandomInfos = new Vector.<BombRankInfo>();
         rankTotalRandomInfos = new Vector.<BombRankInfo>();
      }
      
      public function get randomGameHisMaxScore() : int
      {
         return _randomGameHisMaxScore;
      }
      
      public function set randomGameHisMaxScore(value:int) : void
      {
         _randomGameHisMaxScore = value;
      }
      
      public function get randomGameDayMaxScore() : int
      {
         return _randomGameDayMaxScore;
      }
      
      public function set randomGameDayMaxScore(value:int) : void
      {
         _randomGameDayMaxScore = value;
      }
      
      public function clearData() : void
      {
         var info:* = null;
         CurrentScores = 0;
         if(rankDayFixInfos)
         {
            while(rankDayFixInfos.length > 0)
            {
               info = rankDayFixInfos.pop();
               info = null;
            }
         }
         if(rankTotalFixInfos)
         {
            while(rankTotalFixInfos.length > 0)
            {
               info = rankTotalFixInfos.pop();
               info = null;
            }
         }
         if(rankDayRandomInfos)
         {
            while(rankDayRandomInfos.length > 0)
            {
               info = rankDayRandomInfos.pop();
               info = null;
            }
         }
         if(rankTotalRandomInfos)
         {
            while(rankTotalRandomInfos.length > 0)
            {
               info = rankTotalRandomInfos.pop();
               info = null;
            }
         }
         CurrentGameCanBeClickTimes = 0;
         CurrentScores = 0;
      }
   }
}
