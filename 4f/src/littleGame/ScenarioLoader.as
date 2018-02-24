package littleGame
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import ddt.interfaces.IProcessObject;
   import ddt.manager.PathManager;
   import ddt.manager.ProcessManager;
   import ddt.utils.RequestVairableCreater;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.net.URLLoader;
   import flash.net.URLVariables;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import littleGame.data.Grid;
   import littleGame.model.Scenario;
   
   [Event(name="complete",type="com.pickgliss.loader.LoaderEvent")]
   public class ScenarioLoader extends EventDispatcher implements IProcessObject
   {
      
      private static const GridProcessCount:int = 5000;
      
      private static const ConfigReady:int = 1;
      
      private static const ConfigStartProcess:int = 2;
      
      private static const ConfigEndProcess:int = 3;
      
      private static const ConfigComplete:int = 4;
       
      
      private var _onProcess:Boolean = false;
      
      private var _loaded:int = 0;
      
      private var _total:int = 2;
      
      private var _w:int;
      
      private var _h:int;
      
      private var _localW:int;
      
      private var _localH:int;
      
      private var _configBytes:ByteArray;
      
      private var _grid:Grid;
      
      private var _resLoader:BaseLoader;
      
      private var _configLoader:BaseLoader;
      
      private var _scene:Scenario;
      
      private var _objectLoaders:Vector.<BaseLoader>;
      
      private var _objectLoaded:int = 0;
      
      private var _configLoaded:int = 0;
      
      private var _configProcessState:int = 0;
      
      private var _configReady:Boolean = false;
      
      public function ScenarioLoader(param1:Scenario){super();}
      
      public function startup() : void{}
      
      private function loadObjects() : void{}
      
      private function __loaderError(param1:LoaderEvent) : void{}
      
      private function __objectComplete(param1:LoaderEvent) : void{}
      
      public function get progress() : int{return 0;}
      
      public function shutdown() : void{}
      
      private function loadResource() : void{}
      
      private function __scenarioResComplete(param1:LoaderEvent) : void{}
      
      private function loadConfig() : void{}
      
      private function __scenarioConfigComplete(param1:LoaderEvent) : void{}
      
      private function processConfig() : void{}
      
      private function configProcessComplete() : void{}
      
      private function loadConfigData() : void{}
      
      private function __resDataComplete(param1:Event) : void{}
      
      private function __resComplete(param1:Event) : void{}
      
      private function complete() : void{}
      
      public function get grid() : Grid{return null;}
      
      public function dispose() : void{}
      
      public function unload() : void{}
      
      public function get onProcess() : Boolean{return false;}
      
      public function set onProcess(param1:Boolean) : void{}
      
      public function process(param1:Number) : void{}
   }
}
