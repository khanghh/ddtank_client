package GodSyah
{
   public class SyahMode
   {
       
      
      private var _syahID:int;
      
      private var _attack:int;
      
      private var _defense:int;
      
      private var _agility:int;
      
      private var _lucky:int;
      
      private var _hp:int;
      
      private var _armor:int;
      
      private var _damage:int;
      
      private var _isHold:Boolean;
      
      private var _isValid:Boolean;
      
      private var _level:int;
      
      private var _isGold:Boolean;
      
      private var _valid:String;
      
      public function SyahMode()
      {
         super();
      }
      
      public function get attack() : int
      {
         return _attack;
      }
      
      public function set attack(value:int) : void
      {
         _attack = value;
      }
      
      public function get defense() : int
      {
         return _defense;
      }
      
      public function set defense(value:int) : void
      {
         _defense = value;
      }
      
      public function get agility() : int
      {
         return _agility;
      }
      
      public function set agility(value:int) : void
      {
         _agility = value;
      }
      
      public function get lucky() : int
      {
         return _lucky;
      }
      
      public function set lucky(value:int) : void
      {
         _lucky = value;
      }
      
      public function get hp() : int
      {
         return _hp;
      }
      
      public function set hp(value:int) : void
      {
         _hp = value;
      }
      
      public function get armor() : int
      {
         return _armor;
      }
      
      public function set armor(value:int) : void
      {
         _armor = value;
      }
      
      public function get damage() : int
      {
         return _damage;
      }
      
      public function set damage(value:int) : void
      {
         _damage = value;
      }
      
      public function get isHold() : Boolean
      {
         return _isHold;
      }
      
      public function set isHold(value:Boolean) : void
      {
         _isHold = value;
      }
      
      public function get syahID() : int
      {
         return _syahID;
      }
      
      public function set syahID(value:int) : void
      {
         _syahID = value;
      }
      
      public function get isValid() : Boolean
      {
         return _isValid;
      }
      
      public function set isValid(value:Boolean) : void
      {
         _isValid = value;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function set level(value:int) : void
      {
         _level = value;
      }
      
      public function get isGold() : Boolean
      {
         return _isGold;
      }
      
      public function set isGold(value:Boolean) : void
      {
         _isGold = value;
      }
      
      public function get valid() : String
      {
         return _valid;
      }
      
      public function set valid(value:String) : void
      {
         _valid = value;
      }
   }
}
