package worldcup{   import com.pickgliss.ui.LayerManager;   import ddt.events.CEvent;   import worldcup.view.WorldCupMainView;      public class WorldcupControl   {            private static var _instance:WorldcupControl;                   public var mainFrame:WorldCupMainView;            public function WorldcupControl() { super(); }
            public static function get instance() : WorldcupControl { return null; }
            public function setup() : void { }
            private function __openViewHandler(evt:CEvent) : void { }
            public function disposeMainview() : void { }
   }}