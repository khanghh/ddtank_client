package catchInsect
{
   import catchInsect.data.InsectInfo;
   import catchInsect.event.InsectEvent;
   import catchInsect.player.CatchInsectMonster;
   import com.pickgliss.ui.LayerManager;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.GameInSocketOut;
   import flash.events.EventDispatcher;
   import room.RoomManager;
   
   public class CatchInsectMonsterManager extends EventDispatcher
   {
      
      private static var _instance:CatchInsectMonsterManager;
       
      
      private var _monsterInfo:InsectInfo;
      
      public var isFighting:Boolean = false;
      
      private var _activeState:Boolean = false;
      
      public var curMonster:CatchInsectMonster;
      
      public function CatchInsectMonsterManager()
      {
         super();
      }
      
      public static function get Instance() : CatchInsectMonsterManager
      {
         if(_instance == null)
         {
            _instance = new CatchInsectMonsterManager();
         }
         return _instance;
      }
      
      public function set ActiveState(value:Boolean) : void
      {
         _activeState = value;
         CatchInsectMonsterManager.Instance.dispatchEvent(new InsectEvent("monster_active_start",value));
      }
      
      public function setupFightEvent() : void
      {
         RoomManager.Instance.addEventListener("gameRoomCreate",__gameStart);
      }
      
      private function __gameStart(pEvent:CrazyTankSocketEvent) : void
      {
         LayerManager.Instance.clearnStageDynamic();
         RoomManager.Instance.removeEventListener("gameRoomCreate",__gameStart);
         if(_monsterInfo)
         {
            GameInSocketOut.sendGameRoomSetUp(_monsterInfo.MissionID,52,false,"","",3,0,0,false,_monsterInfo.MissionID);
            CatchInsectMonsterManager.Instance.curMonster = null;
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
      
      public function set CurrentMonster(value:InsectInfo) : void
      {
         _monsterInfo = value;
      }
   }
}
