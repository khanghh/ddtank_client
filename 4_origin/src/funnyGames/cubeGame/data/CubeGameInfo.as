package funnyGames.cubeGame.data
{
   public final class CubeGameInfo
   {
       
      
      public var level:uint;
      
      public var curWaveNum:uint;
      
      public var totalWaveNum:uint;
      
      public var dailyHighScore:uint;
      
      public var historyHgihScore:uint;
      
      public var curScore:uint;
      
      public var aviliable:Boolean;
      
      public var row:uint;
      
      public var column:uint;
      
      public var strongDestroyCnt:uint = 7;
      
      public var extraDestroyCnt:uint = 14;
      
      public var strongDestroyScore:uint;
      
      public var extraDestroyScore:uint;
      
      public var emptyColumnScore:uint;
      
      public var costEnergy:uint;
      
      public function CubeGameInfo()
      {
         super();
      }
   }
}
