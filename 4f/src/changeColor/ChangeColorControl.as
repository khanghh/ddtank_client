package changeColor{   import changeColor.view.ChangeColorFrame;   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.ChangeColorManager;   import ddt.view.UIModuleSmallLoading;   import flash.events.Event;      public class ChangeColorControl   {            private static var _instance:ChangeColorControl;                   private var _changeColorFrame:ChangeColorFrame;            public function ChangeColorControl() { super(); }
            public static function get instance() : ChangeColorControl { return null; }
            public function setup() : void { }
            private function __onOpenView(event:Event) : void { }
            private function __onClose(event:Event) : void { }
            private function __changeColorProgress(event:UIModuleEvent) : void { }
            private function __changeColorComplete(event:UIModuleEvent) : void { }
            public function show() : void { }
            public function close() : void { }
   }}