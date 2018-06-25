package littleGame{   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.utils.ObjectUtils;   import ddt.interfaces.IProcessObject;   import ddt.manager.ProcessManager;   import flash.events.EventDispatcher;   import littleGame.data.Grid;   import littleGame.model.Scenario;      [Event(name="progress",type="com.pickgliss.loader.LoaderEvent")]   [Event(name="complete",type="com.pickgliss.loader.LoaderEvent")]   [Event(name="loadError",type="com.pickgliss.loader.LoaderEvent")]   public class LittleGameLoader extends EventDispatcher implements IProcessObject   {                   private var _game:Scenario;            private var _loaded:int = 0;            private var _total:int = 2;            private var _scenarioLoader:ScenarioLoader;            private var _monsterLoader:MonsterLoader;            private var _onProcess:Boolean;            public function LittleGameLoader(game:Scenario) { super(); }
            public function dispose() : void { }
            public function shutdown() : void { }
            public function startup() : void { }
            private function __monsterComplete(event:LoaderEvent) : void { }
            private function __scenarioComplete(event:LoaderEvent) : void { }
            public function get grid() : Grid { return null; }
            public function get progress() : int { return 0; }
            private function complete() : void { }
            public function get onProcess() : Boolean { return false; }
            public function set onProcess(val:Boolean) : void { }
            public function process(rate:Number) : void { }
            public function unload() : void { }
   }}