package ddt.manager{   import ddt.events.PkgEvent;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.utils.ByteArray;      public class MaxBtnStateManager extends EventDispatcher   {            public static const MAX_BTN_STATE_CHANGE:String = "maxbtnstate_change";            private static var instance:MaxBtnStateManager;                   private var _maxBtnIsPackUp:Boolean = false;            public function MaxBtnStateManager() { super(); }
            public static function getInstance() : MaxBtnStateManager { return null; }
            public function dropDown() : void { }
            public function packUp() : void { }
            public function requireState() : void { }
            protected function onSetStateHandler(e:PkgEvent) : void { }
            protected function onGetStateHandler(e:PkgEvent) : void { }
            public function addEvents() : void { }
            public function removeEvents() : void { }
            public function dispose() : void { }
            public function get maxBtnIsPackUp() : Boolean { return false; }
   }}