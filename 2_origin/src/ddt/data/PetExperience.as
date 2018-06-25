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
       
      
      public function PetExperience()
      {
         super();
      }
      
      public static function get MAX_LEVEL() : int
      {
         var info:PetInfo = PetsBagManager.instance().petModel.currentPetInfo;
         if(info == null)
         {
            return 60;
         }
         var breakGrade:int = info.breakGrade;
         switch(int(breakGrade) - 1)
         {
            case 0:
               breakGrade = 63;
               break;
            case 1:
               breakGrade = 65;
               break;
            case 2:
               breakGrade = 68;
               break;
            case 3:
               breakGrade = 70;
         }
         return breakGrade;
      }
      
      public static function set MAX_LEVEL(value:int) : void
      {
      }
      
      public static function setup(analyzer:PetExpericenceAnalyze) : void
      {
         PetconfigAnalyzer;
         expericence = analyzer.expericence;
         expericence.sort(16);
         MAX_LEVEL = analyzer.expericence.length;
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
   }
}
