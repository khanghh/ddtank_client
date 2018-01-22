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
      
      public function setValue(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int) : void
      {
         score = param1;
         maxTimes = param2;
         currentTimes = param3;
         usedTimes = param4;
         mineSmall = param5;
         mineMiddle = param6;
         mineBig = param7;
         nextScoreNeed = param8;
         goldNeed = param9;
      }
   }
}
