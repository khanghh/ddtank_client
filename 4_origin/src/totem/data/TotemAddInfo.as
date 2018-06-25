package totem.data
{
   public class TotemAddInfo
   {
       
      
      public var Attack:int;
      
      public var Defence:int;
      
      public var Agility:int;
      
      public var Luck:int;
      
      public var Blood:int;
      
      public var Damage:int;
      
      public var Guard:int;
      
      public function TotemAddInfo()
      {
         super();
      }
      
      public function addGradePro(value:Number) : void
      {
         Attack = Attack + Attack * value;
         Defence = Defence + Defence * value;
         Agility = Agility + Agility * value;
         Luck = Luck + Luck * value;
         Blood = Blood + Blood * value;
         Damage = Damage + Damage * value;
         Guard = Guard + Guard * value;
      }
      
      public function add(info:TotemAddInfo) : void
      {
         Attack = Attack + info.Attack;
         Defence = Defence + info.Defence;
         Agility = Agility + info.Agility;
         Luck = Luck + info.Luck;
         Blood = Blood + info.Blood;
         Damage = Damage + info.Damage;
         Guard = Guard + info.Guard;
      }
   }
}
