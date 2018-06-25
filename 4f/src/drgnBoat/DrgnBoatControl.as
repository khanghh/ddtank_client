package drgnBoat{   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import ddt.view.UIModuleSmallLoading;   import drgnBoat.event.DrgnBoatEvent;   import drgnBoat.views.DrgnBoatFrame;   import flash.events.EventDispatcher;      public class DrgnBoatControl extends EventDispatcher   {            private static var _instance:DrgnBoatControl;                   private var _loadResCount:int;            public function DrgnBoatControl() { super(); }
            public static function get instance() : DrgnBoatControl { return null; }
            public function setup() : void { }
            protected function __onOpenView(event:DrgnBoatEvent) : void { }
            private function loadDrgnBoatModule() : void { }
            private function onUimoduleLoadProgress(event:UIModuleEvent) : void { }
            private function loadFrameCompleteHandler(event:UIModuleEvent) : void { }
   }}