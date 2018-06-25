package effortView{   import ddt.manager.EffortManager;   import flash.events.Event;   import flash.events.EventDispatcher;      public class EffortController extends EventDispatcher   {                   private var _currentRightViewType:int;            private var _currentViewType:int;            private var _isSelf:Boolean;            public function EffortController() { super(); }
            public function set isSelf(isSelf:Boolean) : void { }
            public function set currentRightViewType(type:int) : void { }
            public function get currentRightViewType() : int { return 0; }
            public function set currentViewType(type:int) : void { }
            public function get currentViewType() : int { return 0; }
            private function updateRightView(type:int) : void { }
            private function updateView(type:int) : void { }
            private function updateTempRightView(type:int) : void { }
            private function updateTempView(type:int) : void { }
   }}