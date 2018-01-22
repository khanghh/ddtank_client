package gameCommon.motions
{
   import road7th.data.DictionaryData;
   
   public class ScreenMotionManager
   {
       
      
      private var _motions:DictionaryData;
      
      public function ScreenMotionManager()
      {
         super();
      }
      
      public function addMotion(param1:BaseMotionFunc) : void
      {
      }
      
      public function removeMotion(param1:BaseMotionFunc) : void
      {
      }
      
      public function execute() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _motions;
         for each(var _loc1_ in _motions)
         {
            _loc1_.getResult();
         }
      }
   }
}
