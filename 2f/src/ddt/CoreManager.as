package ddt{   import com.pickgliss.loader.CodeLoader;   import com.pickgliss.ui.ComponentSetting;   import ddt.view.UIModuleSmallLoading;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;      public class CoreManager extends EventDispatcher   {                   private var _codeLoader:CodeLoader;            private var _codeURL:String;            public function CoreManager(target:IEventDispatcher = null) { super(null); }
            public final function show(codeURL:String = "4.png") : void { }
            private function onProgress(progress:Number) : void { }
            protected function __onClose(event:Event) : void { }
            protected function onLoaded() : void { }
            protected function start() : void { }
   }}