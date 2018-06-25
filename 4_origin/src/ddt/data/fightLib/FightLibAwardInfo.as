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
      
      public function set easyAward(value:Array) : void
      {
         _easyAward = value;
      }
      
      public function get normalAward() : Array
      {
         return _normalAward;
      }
      
      public function set normalAward(value:Array) : void
      {
         _normalAward = value;
      }
      
      public function get difficultAward() : Array
      {
         return _difficultAward;
      }
      
      public function set difficultAward(value:Array) : void
      {
         _difficultAward = value;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set id(value:int) : void
      {
         _id = value;
      }
   }
}
