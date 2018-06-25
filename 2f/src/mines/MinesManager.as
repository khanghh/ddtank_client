package mines{   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ClassUtils;   import ddt.events.PkgEvent;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.utils.AssetModuleLoader;   import flash.events.Event;   import flash.events.EventDispatcher;   import hallIcon.HallIconManager;   import mines.analyzer.MinesDropAnalyzer;   import mines.analyzer.MinesLevelAnalyzer;   import mines.analyzer.ShopDropInfo;   import mines.analyzer.ShopExchangeInfo;   import mines.model.MinesModel;   import road7th.comm.PackageIn;      public class MinesManager extends EventDispatcher   {            private static var _instance:MinesManager;            public static var INFOLABEL:String = "infoLabel";            public static var UPDATA_SHOP:String = "updataShop";            public static var LEVEL_UP_TOOL:String = "levelUpTool";            public static var LEVEL_UP_ARM:String = "levelUpArm";                   private var _model:MinesModel;            public var viewOpen:Boolean;            public function MinesManager(single:inner) { super(); }
            public static function get instance() : MinesManager { return null; }
            public function get model() : MinesModel { return null; }
            public function setup() : void { }
            public function checkMinesIcon() : void { }
            private function levelUpArm(e:PkgEvent) : void { }
            private function levelUpTool(e:PkgEvent) : void { }
            private function shopInfo(e:PkgEvent) : void { }
            private function digHandler(e:PkgEvent) : void { }
            private function openHandler(e:PkgEvent) : void { }
            private function show() : void { }
            public function templateDropDataSetup(analyzer:MinesDropAnalyzer) : void { }
            public function templateLevelDataSetup(analyzer:MinesLevelAnalyzer) : void { }
            public function getMinesProp() : void { }
   }}class inner{          function inner() { super(); }
}