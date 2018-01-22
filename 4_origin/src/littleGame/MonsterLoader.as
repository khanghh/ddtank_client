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
      
      public function MonsterLoader(param1:Array)
      {
         _loaders = new Vector.<BaseLoader>();
         _monsters = param1;
         _total = _monsters.length;
         super();
      }
      
      public function dispose() : void
      {
         _loaders = null;
      }
      
      public function startup() : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = _monsters;
         for each(var _loc1_ in _monsters)
         {
            _loc2_ = LoadResourceManager.Instance.createLoader(PathManager.solveASTPath(_loc1_),3);
            if(CharacterFactory.Instance.hasFile(_loc2_.url))
            {
               _loaded = Number(_loaded) + 1;
               complete();
            }
            else
            {
               _loc2_.addEventListener("loadError",__loaderError);
               _loc2_.addEventListener("complete",__dataComplete);
               LoadResourceManager.Instance.startLoad(_loc2_);
               _loaders.push(_loc2_);
            }
         }
      }
      
      private function __loaderError(param1:LoaderEvent) : void
      {
         var _loc2_:BaseLoader = param1.currentTarget as BaseLoader;
         _loc2_.removeEventListener("complete",__dataComplete);
         _loc2_.removeEventListener("loadError",__loaderError);
      }
      
      public function shutdown() : void
      {
         _shutdown = true;
      }
      
      private function __dataComplete(param1:Event) : void
      {
         var _loc2_:BaseLoader = param1.currentTarget as BaseLoader;
         _loc2_.removeEventListener("ioError",__loaderError);
         _loc2_.removeEventListener("complete",__dataComplete);
         var _loc4_:ByteArray = _loc2_.content as ByteArray;
         CharacterFactory.Instance.addFile(_loc2_.url,_loc4_);
         var _loc3_:int = _loaders.indexOf(_loc2_);
         if(_loc3_ >= 0)
         {
            _loaders.splice(_loc3_,1);
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
