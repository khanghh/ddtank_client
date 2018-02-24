package christmas.manager
{
   import christmas.event.ChristmasMonsterEvent;
   import christmas.info.MonsterInfo;
   import christmas.player.ChristmasMonster;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.GameInSocketOut;
   import flash.events.EventDispatcher;
   import room.RoomManager;
   
   public class ChristmasMonsterManager extends EventDispatcher
   {
      
      private static var _instance:ChristmasMonsterManager;
       
      
      private var _monsterInfo:MonsterInfo;
      
      public var isFighting:Boolean = false;
      
      private var _activeState:Boolean = false;
      
      public var curMonster:ChristmasMonster;
      
      public function ChristmasMonsterManager(param1:ThisIsSingleTon){super();}
      
      public static function get Instance() : ChristmasMonsterManager{return null;}
      
      public function set ActiveState(param1:Boolean) : void{}
      
      public function __gameStart(param1:CrazyTankSocketEvent) : void{}
      
      public function removeFightEvent() : void{}
      
      public function get ActiveState() : Boolean{return false;}
      
      public function set CurrentMonster(param1:MonsterInfo) : void{}
   }
}

class ThisIsSingleTon
{
    
   
   function ThisIsSingleTon(){super();}
}
