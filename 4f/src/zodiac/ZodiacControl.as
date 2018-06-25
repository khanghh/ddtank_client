package zodiac{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import flash.events.Event;   import flash.events.EventDispatcher;      public class ZodiacControl extends EventDispatcher   {            private static var _instance:ZodiacControl;                   private var _frame:ZodiacFrame;            public var inRolling:Boolean = false;            public function ZodiacControl(zodiacInstance:ZodiacInstance) { super(); }
            public static function get instance() : ZodiacControl { return null; }
            public function setup() : void { }
            private function __showMainViewHandler(e:Event) : void { }
            private function __hideMainViewhandler(e:Event) : void { }
            private function __updataIndexHandler(e:Event) : void { }
            private function __updataMessageHandler(e:Event) : void { }
            public function setCurrentIndexView($index:int) : void { }
            public function getCurrentIndex() : int { return 0; }
   }}class ZodiacInstance{          function ZodiacInstance() { super(); }
}