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
       
      
      public function StoreEquipExperience(){super();}
      
      public static function setup(param1:StoreEquipExpericenceAnalyze) : void{}
      
      public static function getNecklaceStrengthPlus(param1:int) : int{return 0;}
      
      public static function getExpPercent(param1:int, param2:int) : Number{return 0;}
      
      public static function getExpMax(param1:int) : int{return 0;}
      
      public static function getLevelByGP(param1:int) : int{return 0;}
      
      public static function getNecklaceLevelByGP(param1:int) : int{return 0;}
      
      public static function getNecklaceExpMax(param1:int) : int{return 0;}
      
      public static function getNecklaceCurrentlevelExp(param1:int) : int{return 0;}
      
      public static function getNecklaceCurrentlevelMaxExp(param1:int) : int{return 0;}
   }
}
