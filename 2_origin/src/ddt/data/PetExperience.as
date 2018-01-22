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
         var _loc2_:PetInfo = PetsBagManager.instance().petModel.currentPetInfo;
         if(_loc2_ == null)
         {
            return 60;
         }
         var _loc1_:int = _loc2_.breakGrade;
         switch(int(_loc1_) - 1)
         {
            case 0:
               _loc1_ = 63;
               break;
            case 1:
               _loc1_ = 65;
               break;
            case 2:
               _loc1_ = 68;
               break;
            case 3:
               _loc1_ = 70;
         }
         return _loc1_;
      }
      
      public static function set MAX_LEVEL(param1:int) : void
      {
      }
      
      public static function setup(param1:PetExpericenceAnalyze) : void
      {
         PetconfigAnalyzer;
         expericence = param1.expericence;
         expericence.sort(16);
         MAX_LEVEL = param1.expericence.length;
      }
      
      public static function getExpMax(param1:int) : int
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < expericence.length)
         {
            if(expericence[_loc2_] > param1)
            {
               return expericence[_loc2_];
            }
            _loc2_++;
         }
         return expericence[_loc2_];
      }
      
      public static function getLevelByGP(param1:int) : int
      {
         var _loc2_:int = 0;
         _loc2_ = MAX_LEVEL - 1;
         while(_loc2_ > -1)
         {
            if(expericence[_loc2_] <= param1)
            {
               return _loc2_ + 1;
            }
            _loc2_--;
         }
         return 1;
      }
   }
}
