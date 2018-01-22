package ddt.data.fightLib
{
   public class FightLibAwardInfo
   {
       
      
      private var _id:int;
      
      private var _easyAward:Array;
      
      private var _normalAward:Array;
      
      private var _difficultAward:Array;
      
      public function FightLibAwardInfo()
      {
         super();
         _easyAward = [];
         _normalAward = [];
         _difficultAward = [];
      }
      
      public function get easyAward() : Array
      {
         return _easyAward;
      }
      
      public function set easyAward(param1:Array) : void
      {
         _easyAward = param1;
      }
      
      public function get normalAward() : Array
      {
         return _normalAward;
      }
      
      public function set normalAward(param1:Array) : void
      {
         _normalAward = param1;
      }
      
      public function get difficultAward() : Array
      {
         return _difficultAward;
      }
      
      public function set difficultAward(param1:Array) : void
      {
         _difficultAward = param1;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set id(param1:int) : void
      {
         _id = param1;
      }
   }
}
