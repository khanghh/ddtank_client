package character.action{   import flash.events.EventDispatcher;      public class ActionSet extends EventDispatcher   {                   private var _actions:Array;            private var _currentAction:BaseAction;            public function ActionSet(actionDefine:XML = null) { super(); }
            public function addAction(action:BaseAction) : void { }
            public function getAction(name:String) : BaseAction { return null; }
            public function get next() : BaseAction { return null; }
            public function get currentAction() : BaseAction { return null; }
            public function get stringActions() : Array { return null; }
            public function get actions() : Array { return null; }
            public function removeAction(action:String) : void { }
            private function parseFromXml(xml:XML) : void { }
            public function toXml() : XML { return null; }
            public function dispose() : void { }
   }}