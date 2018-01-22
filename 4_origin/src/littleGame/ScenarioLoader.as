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
      
      public function ScenarioLoader(param1:Scenario)
      {
         _scene = param1;
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
         var _loc4_:int = 0;
         var _loc1_:* = null;
         var _loc3_:Array = _scene.objects.split(",");
         _total = _loc3_.length + 2;
         _objectLoaders = new Vector.<BaseLoader>();
         var _loc2_:int = _loc3_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc1_ = LoadResourceManager.Instance.createLoader(PathManager.solveLittleGameObjectPath(_loc3_[_loc4_]),4);
            _loc1_.addEventListener("loadError",__loaderError);
            _loc1_.addEventListener("complete",__objectComplete);
            LoadResourceManager.Instance.startLoad(_loc1_);
            _objectLoaders.push(_loc1_);
            _loc4_++;
         }
      }
      
      private function __loaderError(param1:LoaderEvent) : void
      {
         var _loc2_:BaseLoader = param1.currentTarget as BaseLoader;
         _loc2_.removeEventListener("complete",__scenarioConfigComplete);
         _loc2_.removeEventListener("complete",__objectComplete);
         _loc2_.removeEventListener("complete",__scenarioResComplete);
         _loc2_.removeEventListener("loadError",__loaderError);
      }
      
      private function __objectComplete(param1:LoaderEvent) : void
      {
         var _loc2_:BaseLoader = param1.currentTarget as BaseLoader;
         _loc2_.removeEventListener("complete",__objectComplete);
         _loc2_.removeEventListener("loadError",__loaderError);
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
      
      private function __scenarioResComplete(param1:LoaderEvent) : void
      {
         var _loc2_:BaseLoader = param1.currentTarget as BaseLoader;
         _loc2_.removeEventListener("complete",__scenarioResComplete);
         _loc2_.removeEventListener("loadError",__loaderError);
         _loaded = Number(_loaded) + 1;
         complete();
      }
      
      private function loadConfig() : void
      {
         var _loc1_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc1_["rnd"] = Math.random();
         _configLoader = LoadResourceManager.Instance.createLoader(PathManager.solveLittleGameConfigPath(_scene.id),3,_loc1_);
         _configLoader.addEventListener("loadError",__loaderError);
         _configLoader.addEventListener("complete",__scenarioConfigComplete);
         LoadResourceManager.Instance.startLoad(_configLoader);
      }
      
      private function __scenarioConfigComplete(param1:LoaderEvent) : void
      {
         _loaded = Number(_loaded) + 1;
         var _loc2_:BaseLoader = param1.currentTarget as BaseLoader;
         _loc2_.removeEventListener("complete",__scenarioConfigComplete);
         _loc2_.removeEventListener("loadError",__loaderError);
         _configBytes = _loc2_.content as ByteArray;
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
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _configProcessState = 2;
         var _loc1_:int = _localW + 5000 / _h;
         _loc1_ = _loc1_ > _w?_w:int(_loc1_);
         _loc3_ = _localW;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = 0;
            while(_loc2_ < _h)
            {
               _grid.setNodeWalkAble(_loc3_,_loc2_,_configBytes.readByte() == 1?true:false);
               _configBytes.readByte();
               _loc2_++;
            }
            _loc3_++;
         }
         _localW = _loc1_;
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
      
      private function __resDataComplete(param1:Event) : void
      {
         var _loc2_:URLLoader = param1.currentTarget as URLLoader;
         _loc2_.removeEventListener("complete",__resDataComplete);
         var _loc3_:ByteArray = _loc2_.data as ByteArray;
         var _loc4_:Loader = new Loader();
         _loc4_.contentLoaderInfo.addEventListener("complete",__resComplete);
         _loc4_.loadBytes(_loc3_,new LoaderContext(false,ApplicationDomain.currentDomain));
      }
      
      private function __resComplete(param1:Event) : void
      {
         param1.currentTarget.removeEventListener("complete",__resComplete);
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
      
      public function set onProcess(param1:Boolean) : void
      {
         _onProcess = false;
      }
      
      public function process(param1:Number) : void
      {
         if(_configReady && _configProcessState == 3)
         {
            loadConfigData();
         }
      }
   }
}
