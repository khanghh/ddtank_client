package GodSyah{   import flash.events.Event;   import flash.events.EventDispatcher;   import hallIcon.HallIconManager;      public class SyahControl extends EventDispatcher   {            private static var _instance:SyahControl;                   public function SyahControl(instance:SyahInstance) { super(); }
            public static function get instance() : SyahControl { return null; }
            public function setup() : void { }
            private function __showMainViewHandler(e:Event) : void { }
            private function __hideMainViewHandler(e:Event) : void { }
   }}class SyahInstance{          function SyahInstance() { super(); }
}