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
      
      public function ChristmasMonsterManager(param1:ThisIsSingleTon)
      {
         super();
         if(param1 == null)
         {
            throw new Error("this is singleton,can\'t be new like this!");
         }
      }
      
      public static function get Instance() : ChristmasMonsterManager
      {
         if(_instance == null)
         {
            _instance = new ChristmasMonsterManager(new ThisIsSingleTon());
         }
         return _instance;
      }
      
      public function set ActiveState(param1:Boolean) : void
      {
         _activeState = param1;
         ChristmasMonsterManager.Instance.dispatchEvent(new ChristmasMonsterEvent("monster_active_start",param1));
      }
      
      public function __gameStart(param1:CrazyTankSocketEvent) : void
      {
         if(_monsterInfo)
         {
            GameInSocketOut.sendGameRoomSetUp(_monsterInfo.MissionID,40,false,"","",3,0,0,false,_monsterInfo.MissionID);
            ChristmasMonsterManager.Instance.curMonster = null;
            GameInSocketOut.sendGameStart();
         }
      }
      
      public function removeFightEvent() : void
      {
         RoomManager.Instance.removeEventListener("gameRoomCreate",__gameStart);
      }
      
      public function get ActiveState() : Boolean
      {
         return _activeState;
      }
      
      public function set CurrentMonster(param1:MonsterInfo) : void
      {
         _monsterInfo = param1;
      }
   }
}

class ThisIsSingleTon
{
    
   
   function ThisIsSingleTon()
   {
      super();
   }
}
