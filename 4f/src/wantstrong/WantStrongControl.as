package wantstrong{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import wantstrong.event.WantStrongEvent;   import wantstrong.model.WantStrongModel;   import wantstrong.view.WantStrongFrame;      public class WantStrongControl extends EventDispatcher   {            private static var _instance:WantStrongControl;                   private var _frame:Frame;            private var _initState;            private var _isTimeUpdated:Boolean;            public function WantStrongControl(target:IEventDispatcher = null) { super(null); }
            public static function get Instance() : WantStrongControl { return null; }
            public function setup() : void { }
            private function setData() : void { }
            public function setFindBackData(index:int) : void { }
            protected function __onSetCurrentInfo(event:WantStrongEvent) : void { }
            public function setCurrentInfo(data:* = null, stateChange:Boolean = false) : void { }
            protected function __onOpenView(event:WantStrongEvent) : void { }
            public function setinitState(value:*) : void { }
            public function get isTimeUpdated() : Boolean { return false; }
            public function set isTimeUpdated(value:Boolean) : void { }
            public function close() : void { }
   }}