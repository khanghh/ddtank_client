package store.data{   import road7th.data.DictionaryData;   import store.analyze.StoreEquipExpericenceAnalyze;      public class StoreEquipExperience   {            public static var expericence:Array;            public static var MAX_LEVEL:int = 0;            public static var NECKLACE_MAX_LEVEL:int = 12;            public static var necklaceStrengthExpList:DictionaryData;            public static var necklaceStrengthPlusList:DictionaryData;                   public function StoreEquipExperience() { super(); }
            public static function setup(analyzer:StoreEquipExpericenceAnalyze) : void { }
            public static function getNecklaceStrengthPlus(level:int) : int { return 0; }
            public static function getExpPercent(level:int, gp:int) : Number { return 0; }
            public static function getExpMax(maxExp:int) : int { return 0; }
            public static function getLevelByGP(gp:int) : int { return 0; }
            public static function getNecklaceLevelByGP(gp:int) : int { return 0; }
            public static function getNecklaceExpMax(maxExp:int) : int { return 0; }
            public static function getNecklaceCurrentlevelExp(maxExp:int) : int { return 0; }
            public static function getNecklaceCurrentlevelMaxExp(level:int) : int { return 0; }
   }}