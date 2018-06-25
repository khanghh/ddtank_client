package godOfWealth{   import com.pickgliss.ui.LayerManager;   import ddt.CoreController;   import ddt.events.CEvent;   import ddt.manager.GameInSocketOut;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import godOfWealth.view.GodOfWealthMainView;      public class GodOfWealthController extends CoreController   {            private static var instance:GodOfWealthController;                   private var _godOfWealthView:GodOfWealthMainView;            public function GodOfWealthController(single:inner) { super(); }
            public static function getInstance() : GodOfWealthController { return null; }
            public function setup() : void { }
            private function onOpenView(e:CEvent) : void { }
            private function onUpdate(e:CEvent) : void { }
            private function onResultSuc(e:CEvent) : void { }
   }}class inner{          function inner() { super(); }
}