package store.data
{
   import road7th.data.DictionaryData;
   import store.analyze.StoreEquipExpericenceAnalyze;
   
   public class StoreEquipExperience
   {
      
      public static var expericence:Array;
      
      public static var MAX_LEVEL:int = 0;
      
      public static var NECKLACE_MAX_LEVEL:int = 12;
      
      public static var necklaceStrengthExpList:DictionaryData;
      
      public static var necklaceStrengthPlusList:DictionaryData;
       
      
      public function StoreEquipExperience()
      {
         super();
      }
      
      public static function setup(analyzer:StoreEquipExpericenceAnalyze) : void
      {
         expericence = analyzer.expericence;
         MAX_LEVEL = analyzer.expericence.length;
         necklaceStrengthExpList = analyzer.necklaceStrengthExpList;
         necklaceStrengthPlusList = analyzer.necklaceStrengthPlusList;
      }
      
      public static function getNecklaceStrengthPlus(level:int) : int
      {
         return necklaceStrengthPlusList[level];
      }
      
      public static function getExpPercent(level:int, gp:int) : Number
      {
         if(expericence.hasOwnProperty(level))
         {
            return Math.floor(gp / expericence[level + 1] * 10000) / 100;
         }
         return 0;
      }
      
      public static function getExpMax(maxExp:int) : int
      {
         var i:int = 0;
         for(i = 0; i < expericence.length; )
         {
            if(expericence[i] > maxExp)
            {
               return expericence[i];
            }
            i++;
         }
         return expericence[i];
      }
      
      public static function getLevelByGP(gp:int) : int
      {
         var i:int = 0;
         for(i = MAX_LEVEL - 1; i > -1; )
         {
            if(expericence[i] <= gp)
            {
               return i + 1;
            }
            i--;
         }
         return 1;
      }
      
      public static function getNecklaceLevelByGP(gp:int) : int
      {
         var i:int = 0;
         for(i = NECKLACE_MAX_LEVEL; i > -1; )
         {
            if(necklaceStrengthExpList.list[i] <= gp)
            {
               return i;
            }
            i--;
         }
         return 1;
      }
      
      public static function getNecklaceExpMax(maxExp:int) : int
      {
         var i:int = 0;
         for(i = 0; i < expericence.length; )
         {
            if(necklaceStrengthExpList.list[i] > maxExp)
            {
               return necklaceStrengthExpList.list[i];
            }
            i++;
         }
         return necklaceStrengthExpList.list[i];
      }
      
      public static function getNecklaceCurrentlevelExp(maxExp:int) : int
      {
         var currentlevel:int = getNecklaceLevelByGP(maxExp);
         return maxExp - necklaceStrengthExpList[currentlevel];
      }
      
      public static function getNecklaceCurrentlevelMaxExp(level:int) : int
      {
         if(level < NECKLACE_MAX_LEVEL)
         {
            return necklaceStrengthExpList[level + 1] - necklaceStrengthExpList[level];
         }
         return necklaceStrengthExpList[level] - necklaceStrengthExpList[level - 1];
      }
   }
}
