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
      
      public function set attack(param1:int) : void
      {
         _attack = param1;
      }
      
      public function get defense() : int
      {
         return _defense;
      }
      
      public function set defense(param1:int) : void
      {
         _defense = param1;
      }
      
      public function get agility() : int
      {
         return _agility;
      }
      
      public function set agility(param1:int) : void
      {
         _agility = param1;
      }
      
      public function get lucky() : int
      {
         return _lucky;
      }
      
      public function set lucky(param1:int) : void
      {
         _lucky = param1;
      }
      
      public function get hp() : int
      {
         return _hp;
      }
      
      public function set hp(param1:int) : void
      {
         _hp = param1;
      }
      
      public function get armor() : int
      {
         return _armor;
      }
      
      public function set armor(param1:int) : void
      {
         _armor = param1;
      }
      
      public function get damage() : int
      {
         return _damage;
      }
      
      public function set damage(param1:int) : void
      {
         _damage = param1;
      }
      
      public function get isHold() : Boolean
      {
         return _isHold;
      }
      
      public function set isHold(param1:Boolean) : void
      {
         _isHold = param1;
      }
      
      public function get syahID() : int
      {
         return _syahID;
      }
      
      public function set syahID(param1:int) : void
      {
         _syahID = param1;
      }
      
      public function get isValid() : Boolean
      {
         return _isValid;
      }
      
      public function set isValid(param1:Boolean) : void
      {
         _isValid = param1;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function set level(param1:int) : void
      {
         _level = param1;
      }
      
      public function get isGold() : Boolean
      {
         return _isGold;
      }
      
      public function set isGold(param1:Boolean) : void
      {
         _isGold = param1;
      }
      
      public function get valid() : String
      {
         return _valid;
      }
      
      public function set valid(param1:String) : void
      {
         _valid = param1;
      }
   }
}
