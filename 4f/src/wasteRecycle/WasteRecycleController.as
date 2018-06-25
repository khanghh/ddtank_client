package wasteRecycle{   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.ui.ComponentFactory;   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PathManager;   import ddt.manager.ServerConfigManager;   import ddt.utils.HelperDataModuleLoad;   import ddt.utils.HelperUIModuleLoad;   import flash.events.EventDispatcher;   import wasteRecycle.data.WasteRecycleAnalyzer;   import wasteRecycle.data.WasteRecycleModel;   import wasteRecycle.view.WasteRecycleFrame;   import wasteRecycle.view.WasteRecycleHelperFrame;      public class WasteRecycleController extends EventDispatcher   {            private static var _instance:WasteRecycleController;                   private var _model:WasteRecycleModel;            private var _isPlay:Boolean;            public function WasteRecycleController() { super(); }
            public static function get instance() : WasteRecycleController { return null; }
            private function initAwardList() : void { }
            public function showView() : void { }
            private function loadComplete() : void { }
            private function createLoader() : BaseLoader { return null; }
            private function onDataComplete(analyzer:WasteRecycleAnalyzer) : void { }
            public function get model() : WasteRecycleModel { return null; }
            public function set isPlay(value:Boolean) : void { }
            public function get isPlay() : Boolean { return false; }
            public function openHelpFram() : void { }
   }}