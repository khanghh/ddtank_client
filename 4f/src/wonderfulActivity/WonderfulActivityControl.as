package wonderfulActivity{   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.view.UIModuleSmallLoading;   import flash.events.EventDispatcher;   import wonderfulActivity.event.WonderfulActivityEvent;   import wonderfulActivity.items.JoinIsPowerView;   import wonderfulActivity.items.StrengthDarenView;   import wonderfulActivity.views.ActivityUnitListCell;      public class WonderfulActivityControl extends EventDispatcher   {            private static var _instance:WonderfulActivityControl;                   private var _frame:WonderfulFrame;            public function WonderfulActivityControl() { super(); }
            public static function get Instance() : WonderfulActivityControl { return null; }
            public function setup() : void { }
            protected function __onOpenView(event:WonderfulActivityEvent) : void { }
            protected function __onAddElement(event:WonderfulActivityEvent) : void { }
            public function dispose() : void { }
            protected function onUIProgress(event:UIModuleEvent) : void { }
            public function get frame() : WonderfulFrame { return null; }
   }}