package catchbeast{   import catchbeast.view.CatchBeastView;   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.ui.ComponentFactory;   import ddt.view.UIModuleSmallLoading;   import flash.events.Event;   import flash.events.EventDispatcher;      public class CatchBeastControl extends EventDispatcher   {            public static var loadComplete:Boolean = false;            public static var useFirst:Boolean = true;            private static var _instance:CatchBeastControl;                   private var _catchBeastView:CatchBeastView;            public function CatchBeastControl() { super(); }
            public static function get instance() : CatchBeastControl { return null; }
            public function setup() : void { }
            protected function __onOpenView(event:Event) : void { }
            private function show() : void { }
            public function hide() : void { }
            private function __complainShow(event:UIModuleEvent) : void { }
            private function __progressShow(event:UIModuleEvent) : void { }
            protected function __onClose(event:Event) : void { }
            private function showCatchBeastFrame() : void { }
   }}