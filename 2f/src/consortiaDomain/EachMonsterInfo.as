package consortiaDomain
{
   public class EachMonsterInfo
   {
       
      
      public var LivingID:int;
      
      public var TargetID:int;
      
      public var Type:int;
      
      public var BeginSecond:int;
      
      public var BirthSecond:int;
      
      public var FightID:int;
      
      public var state:int;
      
      public var posX:int;
      
      public var posY:int;
      
      public var lastState:int = 2147483647;
      
      public var LastTargetID:int = 2147483647;
      
      public var serverMonsterState:int;
      
      public function EachMonsterInfo(){super();}
      
      public function toString() : void{}
   }
}
