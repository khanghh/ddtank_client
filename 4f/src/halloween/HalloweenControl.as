package halloween{   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.utils.ObjectUtils;   import ddt.view.UIModuleSmallLoading;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import halloween.view.HalloweenView;      public class HalloweenControl extends EventDispatcher   {            public static var loadComplete:Boolean = false;            public static var useFirst:Boolean = true;            private static var _instance:HalloweenControl;                   private var _halloweenView:HalloweenView;            public function HalloweenControl(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : HalloweenControl { return null; }
            public function setup() : void { }
            protected function __onOpenView(event:Event) : void { }
            private function show() : void { }
            private function __complainShow(event:UIModuleEvent) : void { }
            private function __progressShow(event:UIModuleEvent) : void { }
            protected function __onClose(event:Event) : void { }
            private function showhalloweenFrame() : void { }
            public function hide() : void { }
   }}