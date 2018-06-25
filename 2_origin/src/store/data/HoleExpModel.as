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
      
      public function set explist(val:String) : void
      {
         _expList = val.split("|");
      }
      
      public function set maxLv(lv:String) : void
      {
         _maxLv = int(lv);
      }
      
      public function set oprationLv(lv:String) : void
      {
         _maxOpLv = int(lv);
      }
      
      public function getMaxLv() : int
      {
         return _maxLv;
      }
      
      public function getMaxOpLv() : int
      {
         return _maxOpLv;
      }
      
      public function getExpByLevel(lv:int) : int
      {
         var exp:int = _expList[lv];
         if(exp >= 0)
         {
            return exp;
         }
         return -1;
      }
   }
}
