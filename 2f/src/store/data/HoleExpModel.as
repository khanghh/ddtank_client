package store.data
{
   public class HoleExpModel
   {
       
      
      private var _expList:Array;
      
      private var _maxLv:int;
      
      private var _maxOpLv:int;
      
      public function HoleExpModel(){super();}
      
      public function set explist(param1:String) : void{}
      
      public function set maxLv(param1:String) : void{}
      
      public function set oprationLv(param1:String) : void{}
      
      public function getMaxLv() : int{return 0;}
      
      public function getMaxOpLv() : int{return 0;}
      
      public function getExpByLevel(param1:int) : int{return 0;}
   }
}
