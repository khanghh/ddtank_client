package ddt.data
{
   import ddt.data.analyze.PetExpericenceAnalyze;
   import ddt.data.analyze.PetconfigAnalyzer;
   import pet.data.PetInfo;
   import petsBag.PetsBagManager;
   
   public class PetExperience
   {
      
      public static var expericence:Array;
      
      private static var _MAX_LEVEL:int = 0;
       
      
      public function PetExperience(){super();}
      
      public static function get MAX_LEVEL() : int{return 0;}
      
      public static function set MAX_LEVEL(param1:int) : void{}
      
      public static function setup(param1:PetExpericenceAnalyze) : void{}
      
      public static function getExpMax(param1:int) : int{return 0;}
      
      public static function getLevelByGP(param1:int) : int{return 0;}
   }
}
