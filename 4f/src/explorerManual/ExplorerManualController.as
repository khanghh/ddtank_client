package explorerManual{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.player.SelfInfo;   import ddt.events.CEvent;   import ddt.events.PkgEvent;   import ddt.loader.LoaderCreate;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.utils.HelperDataModuleLoad;   import ddt.utils.HelperUIModuleLoad;   import explorerManual.data.DebrisInfo;   import explorerManual.data.ExplorerManualInfo;   import explorerManual.data.ManualPageDebrisInfo;   import explorerManual.view.ExplorerManualFrame;   import flash.events.Event;   import flash.events.EventDispatcher;   import road7th.comm.PackageIn;      public class ExplorerManualController extends EventDispatcher   {            private static var _instance:ExplorerManualController;                   private var _frame:ExplorerManualFrame = null;            private var _manaualModel:ExplorerManualInfo;            private var _autoUpgradeing:Boolean = false;            private var _puzzleState:Boolean = false;            public function ExplorerManualController() { super(); }
            public static function get instance() : ExplorerManualController { return null; }
            public function get puzzleState() : Boolean { return false; }
            public function set puzzleState(value:Boolean) : void { }
            public function setup() : void { }
            private function addEvent() : void { }
            private function __initDataHandler(evt:PkgEvent) : void { }
            private function updatePlayerManualPro() : void { }
            private function __openViewHandler(evt:Event) : void { }
            private function __upgradeHandler(evt:PkgEvent) : void { }
            private function __pageUpdateHandler(evt:PkgEvent) : void { }
            private function __pageActiveHandler(evt:PkgEvent) : void { }
            private function loadUIModule() : void { }
            private function openView() : void { }
            public function startUpgrade(autoBuy:Boolean, bindMoney:Boolean) : void { }
            public function autoUpgrade(autoBuy:Boolean, bindMoney:Boolean, autoUpgrade:Boolean) : void { }
            private function upgrade(autoBuy:Boolean, bindMoney:Boolean, autoUpgrade:Boolean = false) : void { }
            public function requestManualPageData(chapterID:int) : void { }
            public function switchChapterView(chapterID:int) : void { }
            public function sendManualPageActive(activeType:int, pageID:int) : void { }
            private function requestInitData() : void { }
            public function get autoUpgradeing() : Boolean { return false; }
            public function set autoUpgradeing(value:Boolean) : void { }
   }}