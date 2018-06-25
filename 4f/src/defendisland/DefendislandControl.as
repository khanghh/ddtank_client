package defendisland{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import defendisland.view.DefendislandFrame;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;      public class DefendislandControl extends EventDispatcher   {            private static var _instance:DefendislandControl;                   public var _frame:DefendislandFrame;            public function DefendislandControl(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : DefendislandControl { return null; }
            public function setup() : void { }
            private function __showHandler(e:Event) : void { }
            public function __hideHandler(e:Event) : void { }
   }}