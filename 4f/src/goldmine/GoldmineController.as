package goldmine{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.CoreController;   import ddt.events.CEvent;   import goldmine.views.GoldmineMainFrame;      public class GoldmineController extends CoreController   {            private static var _instance:GoldmineController;                   private var _manager:GoldmineManager;            private var _goldmineMainFrame:GoldmineMainFrame;            public function GoldmineController() { super(); }
            public static function get Instance() : GoldmineController { return null; }
            public function setup() : void { }
            private function __onShowView(e:CEvent) : void { }
            private function __onCloseView(e:CEvent) : void { }
   }}