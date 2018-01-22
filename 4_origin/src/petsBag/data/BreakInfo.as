package petsBag.data
{
   public class BreakInfo
   {
       
      
      public var targetGrade:int;
      
      public var stoneNumber:int;
      
      public var star1:int;
      
      public var breakGrade1:int;
      
      public var star2:int;
      
      public var breakGrade2:int = -1;
      
      public function BreakInfo()
      {
         super();
      }
      
      public function get numPetsNeeded() : int
      {
         if(breakGrade2 == 0)
         {
            return 1;
         }
         return 2;
      }
   }
}
