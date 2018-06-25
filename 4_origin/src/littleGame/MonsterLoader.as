package littleGame
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.manager.PathManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   
   [Event(name="complete",type="com.pickgliss.loader.LoaderEvent")]
   public class MonsterLoader extends EventDispatcher implements Disposeable
   {
       
      
      private var _loaded:int;
      
      private var _total:int;
      
      private var _monsters:Array;
      
      private var _loaders:Vector.<BaseLoader>;
      
      private var _shutdown:Boolean = false;
      
      public function MonsterLoader(monsters:Array)
      {
         _loaders = new Vector.<BaseLoader>();
         _monsters = monsters;
         _total = _monsters.length;
         super();
      }
      
      public function dispose() : void
      {
         _loaders = null;
      }
      
      public function startup() : void
      {
         var loader:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = _monsters;
         for each(var monster in _monsters)
         {
            loader = LoadResourceManager.Instance.createLoader(PathManager.solveASTPath(monster),3);
            if(CharacterFactory.Instance.hasFile(loader.url))
            {
               _loaded = Number(_loaded) + 1;
               complete();
            }
            else
            {
               loader.addEventListener("loadError",__loaderError);
               loader.addEventListener("complete",__dataComplete);
               LoadResourceManager.Instance.startLoad(loader);
               _loaders.push(loader);
            }
         }
      }
      
      private function __loaderError(event:LoaderEvent) : void
      {
         var loader:BaseLoader = event.currentTarget as BaseLoader;
         loader.removeEventListener("complete",__dataComplete);
         loader.removeEventListener("loadError",__loaderError);
      }
      
      public function shutdown() : void
      {
         _shutdown = true;
      }
      
      private function __dataComplete(event:Event) : void
      {
         var dataLoader:BaseLoader = event.currentTarget as BaseLoader;
         dataLoader.removeEventListener("ioError",__loaderError);
         dataLoader.removeEventListener("complete",__dataComplete);
         var bytes:ByteArray = dataLoader.content as ByteArray;
         CharacterFactory.Instance.addFile(dataLoader.url,bytes);
         var idx:int = _loaders.indexOf(dataLoader);
         if(idx >= 0)
         {
            _loaders.splice(idx,1);
         }
         _loaded = Number(_loaded) + 1;
         complete();
      }
      
      private function complete() : void
      {
         if(_loaded >= _total && !_shutdown)
         {
            dispatchEvent(new LoaderEvent("complete",null));
         }
      }
      
      public function get progress() : int
      {
         return _loaded / _total * 100;
      }
      
      public function unload() : void
      {
      }
   }
}
