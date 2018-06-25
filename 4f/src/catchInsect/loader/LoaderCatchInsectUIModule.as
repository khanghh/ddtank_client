package catchInsect.loader{   import catchInsect.CatchInsectControl;   import catchInsect.CatchInsectManager;   import catchInsect.event.InsectEvent;   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.ui.controls.Frame;   import ddt.manager.StateManager;   import ddt.view.UIModuleSmallLoading;   import flash.events.Event;      public class LoaderCatchInsectUIModule extends Frame   {            private static var _instance:LoaderCatchInsectUIModule;                   private var _func:Function;            private var _funcParams:Array;            public function LoaderCatchInsectUIModule() { super(); }
            public static function get Instance() : LoaderCatchInsectUIModule { return null; }
            public function setup() : void { }
            protected function __onOpenView(event:InsectEvent) : void { }
            private function loadUIModule(complete:Function = null, completeParams:Array = null) : void { }
            private function loadCompleteHandler(event:UIModuleEvent) : void { }
            private function onUimoduleLoadProgress(event:UIModuleEvent) : void { }
            protected function __onLoadMap(event:InsectEvent) : void { }
            private function onCatchInsectMapSrcLoadedComplete(e:Event) : void { }
            private function __loadingIsCloseRoom(e:Event) : void { }
            public function getMapRes() : String { return null; }
   }}