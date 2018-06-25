package cryptBoss{   import com.pickgliss.events.ComponentEvent;   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import cryptBoss.event.CryptBossEvent;   import cryptBoss.view.CryptBossMainFrame;   import ddt.data.map.DungeonInfo;   import ddt.manager.MapManager;   import ddt.view.UIModuleSmallLoading;      public class CryptBossControl   {            private static var _instance:CryptBossControl;            public static var loadComplete:Boolean = false;                   private var _cryptBossFrame:CryptBossMainFrame;            public function CryptBossControl() { super(); }
            public static function get instance() : CryptBossControl { return null; }
            public function setup() : void { }
            protected function __onUpdateView(event:CryptBossEvent) : void { }
            protected function __onOpenView(event:CryptBossEvent) : void { }
            public function show() : void { }
            private function loadCompleteHandler(event:UIModuleEvent) : void { }
            private function onUimoduleLoadProgress(event:UIModuleEvent) : void { }
            private function showFrame() : void { }
            public function getTemplateIdArr(mapId:int, star:int) : Array { return null; }
            private function frameDisposeHandler(event:ComponentEvent) : void { }
   }}