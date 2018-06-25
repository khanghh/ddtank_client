package explorerManual.data.model
{
   public class ManualItemInfo
   {
       
      
      private var _level:int;
      
      private var _name:String;
      
      private var _describe:String;
      
      private var _magicAttack:int;
      
      private var _magicResistance:int;
      
      private var _Boost:int;
      
      public function ManualItemInfo()
      {
         super();
      }
      
      public function get Boost() : int
      {
         return _Boost;
      }
      
      public function set Boost(value:int) : void
      {
         _Boost = value;
      }
      
      public function get MagicResistance() : int
      {
         return _magicResistance;
      }
      
      public function set MagicResistance(value:int) : void
      {
         _magicResistance = value;
      }
      
      public function get MagicAttack() : int
      {
         return _magicAttack;
      }
      
      public function set MagicAttack(value:int) : void
      {
         _magicAttack = value;
      }
      
      public function get Describe() : String
      {
         return _describe;
      }
      
      public function set Describe(value:String) : void
      {
         _describe = value;
      }
      
      public function get Name() : String
      {
         return _name;
      }
      
      public function set Name(value:String) : void
      {
         _name = value;
      }
      
      public function get Level() : int
      {
         return _level;
      }
      
      public function set Level(value:int) : void
      {
         _level = value;
      }
   }
}
