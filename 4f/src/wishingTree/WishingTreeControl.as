package wishingTree{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import ddt.loader.LoaderCreate;   import ddt.utils.HelperDataModuleLoad;   import ddt.utils.HelperUIModuleLoad;   import flash.events.Event;   import wishingTree.views.WishingTreeFrame;      public class WishingTreeControl   {            private static var _instance:WishingTreeControl;                   private var _frame:WishingTreeFrame;            public function WishingTreeControl() { super(); }
            public static function get instance() : WishingTreeControl { return null; }
            public function setup() : void { }
            private function open(event:Event) : void { }
            private function openFrame() : void { }
            private function onLoaded() : void { }
   }}