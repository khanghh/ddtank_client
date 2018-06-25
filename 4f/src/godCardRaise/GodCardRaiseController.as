package godCardRaise{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.CoreController;   import ddt.events.CEvent;   import godCardRaise.view.GodCardRaiseMainView;      public class GodCardRaiseController extends CoreController   {            private static var instance:GodCardRaiseController;                   private var _manager:GodCardRaiseManager;            private var _godCardRaiseMainView:GodCardRaiseMainView;            public function GodCardRaiseController() { super(); }
            public static function get Instance() : GodCardRaiseController { return null; }
            public function setup() : void { }
            private function onShowView(e:CEvent) : void { }
            private function onCloseView(event:CEvent) : void { }
   }}