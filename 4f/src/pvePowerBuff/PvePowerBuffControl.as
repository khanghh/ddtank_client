package pvePowerBuff{   import com.pickgliss.ui.ComponentFactory;   import ddt.utils.HelperUIModuleLoad;   import flash.events.EventDispatcher;      public class PvePowerBuffControl extends EventDispatcher   {            public static const SELECT_PLAYER:String = "select_player";            private static var _instance:PvePowerBuffControl;                   private var _uiLoader:HelperUIModuleLoad;            public var mainView:PvePowerBuffMainView;            public function PvePowerBuffControl(ppb:pvppowerbuffinstance) { super(); }
            public static function get instance() : PvePowerBuffControl { return null; }
            public function setup() : void { }
            private function __openView(e:PvePowerBuffEvent) : void { }
            private function __openPvePowerBuffView() : void { }
            private function __disposeView(e:PvePowerBuffEvent) : void { }
   }}class pvppowerbuffinstance{          function pvppowerbuffinstance() { super(); }
}