package ddt.utils{   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.ui.core.Disposeable;   import ddt.view.UIModuleSmallLoading;   import flash.events.Event;   import flash.events.EventDispatcher;      [Event(name="complete",type="flash.events.Event")]   [Event(name="change",type="flash.events.Event")]   [Event(name="close",type="flash.events.Event")]   public final class QueueLoaderUtil extends EventDispatcher implements Disposeable   {                   private var _loaders:Vector.<BaseLoader>;            private var _isSmallLoading:Boolean;            public function QueueLoaderUtil() { super(); }
            public function addLoader(loader:BaseLoader) : void { }
            public function start(isSmallLoading:Boolean = true) : void { }
            public function reset() : void { }
            public function dispose() : void { }
            public function removeEvent() : void { }
            public function isAllComplete() : Boolean { return false; }
            public function isLoading() : Boolean { return false; }
            public function get completeCount() : int { return 0; }
            public function get length() : int { return 0; }
            public function get loaders() : Vector.<BaseLoader> { return null; }
            private function __loadNext(event:LoaderEvent) : void { }
            private function __progress(event:LoaderEvent) : void { }
            private function tryLoadNext() : void { }
            private function __onClose(event:Event) : void { }
   }}