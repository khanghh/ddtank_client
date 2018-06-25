package littleGame{   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.ui.core.Disposeable;   import ddt.manager.PathManager;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.utils.ByteArray;      [Event(name="complete",type="com.pickgliss.loader.LoaderEvent")]   public class MonsterLoader extends EventDispatcher implements Disposeable   {                   private var _loaded:int;            private var _total:int;            private var _monsters:Array;            private var _loaders:Vector.<BaseLoader>;            private var _shutdown:Boolean = false;            public function MonsterLoader(monsters:Array) { super(); }
            public function dispose() : void { }
            public function startup() : void { }
            private function __loaderError(event:LoaderEvent) : void { }
            public function shutdown() : void { }
            private function __dataComplete(event:Event) : void { }
            private function complete() : void { }
            public function get progress() : int { return 0; }
            public function unload() : void { }
   }}