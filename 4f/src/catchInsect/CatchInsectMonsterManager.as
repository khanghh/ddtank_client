package catchInsect{   import catchInsect.data.InsectInfo;   import catchInsect.event.InsectEvent;   import catchInsect.player.CatchInsectMonster;   import com.pickgliss.ui.LayerManager;   import ddt.events.CrazyTankSocketEvent;   import ddt.manager.GameInSocketOut;   import flash.events.EventDispatcher;   import room.RoomManager;      public class CatchInsectMonsterManager extends EventDispatcher   {            private static var _instance:CatchInsectMonsterManager;                   private var _monsterInfo:InsectInfo;            public var isFighting:Boolean = false;            private var _activeState:Boolean = false;            public var curMonster:CatchInsectMonster;            public function CatchInsectMonsterManager() { super(); }
            public static function get Instance() : CatchInsectMonsterManager { return null; }
            public function set ActiveState(value:Boolean) : void { }
            public function setupFightEvent() : void { }
            private function __gameStart(pEvent:CrazyTankSocketEvent) : void { }
            public function removeFightEvent() : void { }
            public function get ActiveState() : Boolean { return false; }
            public function set CurrentMonster(value:InsectInfo) : void { }
   }}