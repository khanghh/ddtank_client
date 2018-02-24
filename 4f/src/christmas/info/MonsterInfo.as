package christmas.info
{
   import christmas.event.ChristmasMonsterEvent;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   
   public class MonsterInfo extends EventDispatcher
   {
      
      public static const LIVIN:int = 0;
      
      public static const DEAD:int = 2;
      
      public static const FIGHTING:int = 1;
       
      
      public var ActionMovieName:String = "game.living.Living003";
      
      public var ID:int;
      
      public var MonsterName:String;
      
      public var MissionID:int;
      
      private var _state:int;
      
      public var MonsterPos:Point;
      
      public var MonsterNewPos:Point;
      
      public var type:int;
      
      public function MonsterInfo(){super();}
      
      public function get State() : int{return 0;}
      
      public function set State(param1:int) : void{}
   }
}
