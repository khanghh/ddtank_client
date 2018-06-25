package consortiaDomain{   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;      public class ConsortiaDomainController extends EventDispatcher   {            private static var _instance:ConsortiaDomainController;                   private var _mgr:ConsortiaDomainManager;            public function ConsortiaDomainController(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : ConsortiaDomainController { return null; }
            public function setup() : void { }
            protected function onComplete(event:Event) : void { }
            public function disposeRewardSelectFrame() : void { }
   }}