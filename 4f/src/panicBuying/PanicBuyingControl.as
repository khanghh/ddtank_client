package panicBuying{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import ddt.manager.SocketManager;   import ddt.utils.AssetModuleLoader;   import panicBuying.event.PanicBuyingEvent;   import panicBuying.views.PanicBuyingFrame;      public class PanicBuyingControl   {            private static var _instance:PanicBuyingControl;                   private var _frame:PanicBuyingFrame;            public function PanicBuyingControl() { super(); }
            public static function get instance() : PanicBuyingControl { return null; }
            public function setup() : void { }
            protected function __updateView(event:PanicBuyingEvent) : void { }
            protected function __panicBuyingOpenView(event:PanicBuyingEvent) : void { }
            private function openPanicBuyingFrame() : void { }
   }}