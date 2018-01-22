package store.data
{
   public class HoleExpModel
   {
       
      
      private var _expList:Array;
      
      private var _maxLv:int;
      
      private var _maxOpLv:int;
      
      public function HoleExpModel()
      {
         super();
      }
      
      public function set explist(param1:String) : void
      {
         _expList = param1.split("|");
      }
      
      public function set maxLv(param1:String) : void
      {
         _maxLv = int(param1);
      }
      
      public function set oprationLv(param1:String) : void
      {
         _maxOpLv = int(param1);
      }
      
      public function getMaxLv() : int
      {
         return _maxLv;
      }
      
      public function getMaxOpLv() : int
      {
         return _maxOpLv;
      }
      
      public function getExpByLevel(param1:int) : int
      {
         var _loc2_:int = _expList[param1];
         if(_loc2_ >= 0)
         {
            return _loc2_;
         }
         return -1;
      }
   }
}
