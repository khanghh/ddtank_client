package drgnBoatBuild{   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import ddt.view.UIModuleSmallLoading;   import drgnBoatBuild.components.DrgnBoatBuildListCell;   import drgnBoatBuild.event.DrgnBoatBuildEvent;   import drgnBoatBuild.views.DrgnBoatBuildFrame;   import flash.events.Event;   import flash.events.EventDispatcher;      public class DrgnBoatBuildControl extends EventDispatcher   {            private static var _instance:DrgnBoatBuildControl;                   private var _frame:DrgnBoatBuildFrame;            public function DrgnBoatBuildControl() { super(); }
            public static function get instance() : DrgnBoatBuildControl { return null; }
            public function setup() : void { }
            protected function __onOpenView(event:DrgnBoatBuildEvent) : void { }
            protected function onSmallLoadingClose(event:Event) : void { }
            protected function onUIProgress(event:UIModuleEvent) : void { }
            protected function createDrgnBoatBuildFrame(event:UIModuleEvent) : void { }
            public function set frame(value:DrgnBoatBuildFrame) : void { }
   }}