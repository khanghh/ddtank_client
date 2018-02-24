package cardSystem.data
{
   import cardSystem.GrooveInfoManager;
   
   public class GrooveInfo
   {
       
      
      public var playerid:int;
      
      public var Place:int;
      
      public var Type:int;
      
      public var Level:int;
      
      public var GP:int;
      
      public var CardId:int;
      
      public function GrooveInfo(){super();}
      
      public function get realAttack() : int{return 0;}
      
      public function get realDefence() : int{return 0;}
      
      public function get realAgility() : int{return 0;}
      
      public function get realLucky() : int{return 0;}
      
      public function get realDamage() : int{return 0;}
      
      public function get realGuard() : int{return 0;}
   }
}
