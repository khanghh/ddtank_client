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
      
      public function set Boost(param1:int) : void
      {
         _Boost = param1;
      }
      
      public function get MagicResistance() : int
      {
         return _magicResistance;
      }
      
      public function set MagicResistance(param1:int) : void
      {
         _magicResistance = param1;
      }
      
      public function get MagicAttack() : int
      {
         return _magicAttack;
      }
      
      public function set MagicAttack(param1:int) : void
      {
         _magicAttack = param1;
      }
      
      public function get Describe() : String
      {
         return _describe;
      }
      
      public function set Describe(param1:String) : void
      {
         _describe = param1;
      }
      
      public function get Name() : String
      {
         return _name;
      }
      
      public function set Name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get Level() : int
      {
         return _level;
      }
      
      public function set Level(param1:int) : void
      {
         _level = param1;
      }
   }
}
