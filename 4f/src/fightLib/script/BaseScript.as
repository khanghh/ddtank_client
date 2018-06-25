package fightLib.script{   import fightLib.IFightLibCommand;   import fightLib.command.BaseFightLibCommand;   import flash.events.Event;   import flash.events.EventDispatcher;      public class BaseScript extends EventDispatcher   {                   protected var _type:int;            protected var _commonds:Array;            protected var _index:int;            protected var _initialized:Boolean;            protected var _isPaused:Boolean;            protected var _currentCommand:IFightLibCommand;            protected var _host:Object;            private var _hasRestarted:Boolean;            public function BaseScript(host:Object) { super(); }
            protected function initializeScript() : void { }
            public function start() : void { }
            public function restart() : void { }
            public function next() : void { }
            private function initEvents() : void { }
            private function removeEvents() : void { }
            protected function __finishHandler(evt:Event) : void { }
            protected function __waitHandler(evt:Event) : void { }
            public function finish() : void { }
            public function pause() : void { }
            public function continueScript() : void { }
            public function get hasRestarted() : Boolean { return false; }
            public function dispose() : void { }
   }}