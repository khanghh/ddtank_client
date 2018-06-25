package christmas.loader{   import christmas.ChristmasCoreController;   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.ui.controls.Frame;   import ddt.manager.PathManager;   import ddt.manager.StateManager;   import ddt.view.UIModuleSmallLoading;   import flash.events.Event;      public class LoaderChristmasUIModule extends Frame   {            private static var _instance:LoaderChristmasUIModule;                   private var _func:Function;            private var _funcParams:Array;            public function LoaderChristmasUIModule(pct:PrivateClass) { super(); }
            public static function get Instance() : LoaderChristmasUIModule { return null; }
            public function loadUIModule(complete:Function = null, completeParams:Array = null) : void { }
            private function loadCompleteHandler(event:UIModuleEvent) : void { }
            private function onUimoduleLoadProgress(event:UIModuleEvent) : void { }
            public function loadMap() : void { }
            private function onChristmasMapSrcLoadedComplete(e:Event) : void { }
            private function __loadingIsCloseRoom(e:Event) : void { }
            public function getChristmasResource() : String { return null; }
            public function getMapRes() : String { return null; }
   }}class PrivateClass{          function PrivateClass() { super(); }
}