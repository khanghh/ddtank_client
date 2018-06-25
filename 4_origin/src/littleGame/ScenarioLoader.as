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
      
      public function ScenarioLoader(scene:Scenario)
      {
         _scene = scene;
         super();
      }
      
      public function startup() : void
      {
         loadObjects();
         loadConfig();
         loadResource();
      }
      
      private function loadObjects() : void
      {
         var i:int = 0;
         var loader:* = null;
         var objects:Array = _scene.objects.split(",");
         _total = objects.length + 2;
         _objectLoaders = new Vector.<BaseLoader>();
         var len:int = objects.length;
         for(i = 0; i < len; )
         {
            loader = LoadResourceManager.Instance.createLoader(PathManager.solveLittleGameObjectPath(objects[i]),4);
            loader.addEventListener("loadError",__loaderError);
            loader.addEventListener("complete",__objectComplete);
            LoadResourceManager.Instance.startLoad(loader);
            _objectLoaders.push(loader);
            i++;
         }
      }
      
      private function __loaderError(event:LoaderEvent) : void
      {
         var loader:BaseLoader = event.currentTarget as BaseLoader;
         loader.removeEventListener("complete",__scenarioConfigComplete);
         loader.removeEventListener("complete",__objectComplete);
         loader.removeEventListener("complete",__scenarioResComplete);
         loader.removeEventListener("loadError",__loaderError);
      }
      
      private function __objectComplete(event:LoaderEvent) : void
      {
         var loader:BaseLoader = event.currentTarget as BaseLoader;
         loader.removeEventListener("complete",__objectComplete);
         loader.removeEventListener("loadError",__loaderError);
         _objectLoaded = Number(_objectLoaded) + 1;
         _loaded = Number(_loaded) + 1;
         complete();
      }
      
      public function get progress() : int
      {
         return (_resLoader.progress / _total + _configLoader.progress / _total + _objectLoaded / _total + _configLoaded / _total) * 100;
      }
      
      public function shutdown() : void
      {
         _resLoader.removeEventListener("complete",__scenarioResComplete);
         _configLoader.removeEventListener("complete",__scenarioConfigComplete);
      }
      
      private function loadResource() : void
      {
         _resLoader = LoadResourceManager.Instance.createLoader(PathManager.solveLittleGameResPath(_scene.id),4);
         _resLoader.addEventListener("loadError",__loaderError);
         _resLoader.addEventListener("complete",__scenarioResComplete);
         LoadResourceManager.Instance.startLoad(_resLoader);
      }
      
      private function __scenarioResComplete(event:LoaderEvent) : void
      {
         var loader:BaseLoader = event.currentTarget as BaseLoader;
         loader.removeEventListener("complete",__scenarioResComplete);
         loader.removeEventListener("loadError",__loaderError);
         _loaded = Number(_loaded) + 1;
         complete();
      }
      
      private function loadConfig() : void
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["rnd"] = Math.random();
         _configLoader = LoadResourceManager.Instance.createLoader(PathManager.solveLittleGameConfigPath(_scene.id),3,args);
         _configLoader.addEventListener("loadError",__loaderError);
         _configLoader.addEventListener("complete",__scenarioConfigComplete);
         LoadResourceManager.Instance.startLoad(_configLoader);
      }
      
      private function __scenarioConfigComplete(event:LoaderEvent) : void
      {
         _loaded = Number(_loaded) + 1;
         var loader:BaseLoader = event.currentTarget as BaseLoader;
         loader.removeEventListener("complete",__scenarioConfigComplete);
         loader.removeEventListener("loadError",__loaderError);
         _configBytes = loader.content as ByteArray;
         _configBytes.uncompress();
         _configBytes.endian = "littleEndian";
         _w = _configBytes.readInt();
         _h = _configBytes.readInt();
         _grid = new Grid(_h,_w);
         _total = _total + _w * _h / 5000;
         _configReady = true;
         processConfig();
      }
      
      private function processConfig() : void
      {
         ProcessManager.Instance.addObject(this);
         _configProcessState = 3;
      }
      
      private function configProcessComplete() : void
      {
         _configProcessState = 4;
         ProcessManager.Instance.removeObject(this);
      }
      
      private function loadConfigData() : void
      {
         var i:int = 0;
         var j:int = 0;
         _configProcessState = 2;
         var w:int = _localW + 5000 / _h;
         w = w > _w?_w:int(w);
         for(i = _localW; i < w; )
         {
            for(j = 0; j < _h; )
            {
               _grid.setNodeWalkAble(i,j,_configBytes.readByte() == 1?true:false);
               _configBytes.readByte();
               j++;
            }
            i++;
         }
         _localW = w;
         if(_localW < _w)
         {
            _loaded = Number(_loaded) + 1;
            _configLoaded = Number(_configLoaded) + 1;
            _configProcessState = 3;
         }
         else
         {
            configProcessComplete();
            complete();
         }
      }
      
      private function __resDataComplete(event:Event) : void
      {
         var dataLoader:URLLoader = event.currentTarget as URLLoader;
         dataLoader.removeEventListener("complete",__resDataComplete);
         var bytes:ByteArray = dataLoader.data as ByteArray;
         var loader:Loader = new Loader();
         loader.contentLoaderInfo.addEventListener("complete",__resComplete);
         loader.loadBytes(bytes,new LoaderContext(false,ApplicationDomain.currentDomain));
      }
      
      private function __resComplete(event:Event) : void
      {
         event.currentTarget.removeEventListener("complete",__resComplete);
         _loaded = Number(_loaded) + 1;
         complete();
      }
      
      private function complete() : void
      {
         if(_loaded >= _total)
         {
            dispatchEvent(new LoaderEvent("complete",null));
         }
      }
      
      public function get grid() : Grid
      {
         return _grid;
      }
      
      public function dispose() : void
      {
         _grid = null;
         _objectLoaders = null;
         _resLoader = null;
         _configLoader = null;
         _scene = null;
         _configBytes = null;
         _configLoader = null;
      }
      
      public function unload() : void
      {
      }
      
      public function get onProcess() : Boolean
      {
         return _onProcess;
      }
      
      public function set onProcess(val:Boolean) : void
      {
         _onProcess = false;
      }
      
      public function process(rate:Number) : void
      {
         if(_configReady && _configProcessState == 3)
         {
            loadConfigData();
         }
      }
   }
}
