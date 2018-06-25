package magicHouse.magicCollection
{
   public class MagicHouseTitleTipInfo
   {
       
      
      private var _magicAttack:int;
      
      private var _magicDefense:int;
      
      private var _critDamage:int;
      
      private var _title:String = "";
      
      public function MagicHouseTitleTipInfo()
      {
         super();
      }
      
      public function get magicAttack() : int
      {
         return _magicAttack;
      }
      
      public function set magicAttack(value:int) : void
      {
         _magicAttack = value;
      }
      
      public function get magicDefense() : int
      {
         return _magicDefense;
      }
      
      public function set magicDefense(value:int) : void
      {
         _magicDefense = value;
      }
      
      public function get critDamage() : int
      {
         return _critDamage;
      }
      
      public function set critDamage(value:int) : void
      {
         _critDamage = value;
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function set title(value:String) : void
      {
         _title = value;
      }
   }
}
