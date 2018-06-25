package goldmine.model
{
   public class GoldmineModel
   {
       
      
      public var score:int;
      
      public var maxTimes:int;
      
      public var currentTimes:int;
      
      public var usedTimes:int;
      
      public var mineSmall:int;
      
      public var mineMiddle:int;
      
      public var mineBig:int;
      
      public var nextScoreNeed:int;
      
      public var goldNeed:int;
      
      public var goldArr:Array;
      
      public var goldNeedArr:Array;
      
      public function GoldmineModel()
      {
         super();
      }
      
      public function setValue($score:int, $maxTimes:int, $currentTimes:int, $usedTimes:int, $mineSmall:int, $mineMiddle:int, $mineBig:int, $nextScoreNeed:int, $goldNeed:int) : void
      {
         score = $score;
         maxTimes = $maxTimes;
         currentTimes = $currentTimes;
         usedTimes = $usedTimes;
         mineSmall = $mineSmall;
         mineMiddle = $mineMiddle;
         mineBig = $mineBig;
         nextScoreNeed = $nextScoreNeed;
         goldNeed = $goldNeed;
      }
   }
}
