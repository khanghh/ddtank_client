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
      
      public function set magicAttack(param1:int) : void
      {
         _magicAttack = param1;
      }
      
      public function get magicDefense() : int
      {
         return _magicDefense;
      }
      
      public function set magicDefense(param1:int) : void
      {
         _magicDefense = param1;
      }
      
      public function get critDamage() : int
      {
         return _critDamage;
      }
      
      public function set critDamage(param1:int) : void
      {
         _critDamage = param1;
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function set title(param1:String) : void
      {
         _title = param1;
      }
   }
}
