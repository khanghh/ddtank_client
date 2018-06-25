package littleGame
{
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.interfaces.IProcessObject;
   import ddt.manager.ProcessManager;
   import flash.events.EventDispatcher;
   import littleGame.data.Grid;
   import littleGame.model.Scenario;
   
   [Event(name="progress",type="com.pickgliss.loader.LoaderEvent")]
   [Event(name="complete",type="com.pickgliss.loader.LoaderEvent")]
   [Event(name="loadError",type="com.pickgliss.loader.LoaderEvent")]
   public class LittleGameLoader extends EventDispatcher implements IProcessObject
   {
       
      
      private var _game:Scenario;
      
      private var _loaded:int = 0;
      
      private var _total:int = 2;
      
      private var _scenarioLoader:ScenarioLoader;
      
      private var _monsterLoader:MonsterLoader;
      
      private var _onProcess:Boolean;
      
      public function LittleGameLoader(game:Scenario)
      {
         _game = game;
         super();
      }
      
      public function dispose() : void
      {
         ProcessManager.Instance.removeObject(this);
         ObjectUtils.disposeObject(_scenarioLoader);
         _scenarioLoader = null;
         ObjectUtils.disposeObject(_monsterLoader);
         _monsterLoader = null;
      }
      
      public function shutdown() : void
      {
         ProcessManager.Instance.removeObject(this);
         _scenarioLoader.shutdown();
         _monsterLoader.shutdown();
      }
      
      public function startup() : void
      {
         _scenarioLoader = new ScenarioLoader(_game);
         _scenarioLoader.addEventListener("complete",__scenarioComplete);
         _scenarioLoader.startup();
         _monsterLoader = new MonsterLoader(_game.monsters.split(","));
         _monsterLoader.addEventListener("complete",__monsterComplete);
         _monsterLoader.startup();
         ProcessManager.Instance.addObject(this);
      }
      
      private function __monsterComplete(event:LoaderEvent) : void
      {
         _monsterLoader.removeEventListener("complete",__monsterComplete);
         _loaded = Number(_loaded) + 1;
         complete();
      }
      
      private function __scenarioComplete(event:LoaderEvent) : void
      {
         _scenarioLoader.removeEventListener("complete",__scenarioComplete);
         _loaded = Number(_loaded) + 1;
         complete();
      }
      
      public function get grid() : Grid
      {
         return _scenarioLoader.grid;
      }
      
      public function get progress() : int
      {
         return _scenarioLoader.progress / _total + _monsterLoader.progress / _total;
      }
      
      private function complete() : void
      {
         if(_loaded >= _total)
         {
            shutdown();
            dispatchEvent(new LoaderEvent("complete",null));
         }
      }
      
      public function get onProcess() : Boolean
      {
         return _onProcess;
      }
      
      public function set onProcess(val:Boolean) : void
      {
         _onProcess = val;
      }
      
      public function process(rate:Number) : void
      {
         dispatchEvent(new LoaderEvent("progress",null));
      }
      
      public function unload() : void
      {
         _monsterLoader.unload();
         _scenarioLoader.unload();
      }
   }
}
