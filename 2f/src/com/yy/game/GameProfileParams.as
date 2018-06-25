package com.yy.game{   import flash.net.URLVariables;      public class GameProfileParams   {                   private var _fightPower:int = -1;            private var _sex:String;            private var _job:String;            private var _partner:String;            private var _equip:String;            private var _iversion:String;            private var _updateVersion:String;            private var _runResource:String;            private var _referrer:String;            public function GameProfileParams(data:Object = null) { super(); }
            public function get fightPower() : int { return 0; }
            public function set fightPower(value:int) : void { }
            public function get sex() : String { return null; }
            public function set sex(value:String) : void { }
            public function get job() : String { return null; }
            public function set job(value:String) : void { }
            public function get partner() : String { return null; }
            public function set partner(value:String) : void { }
            public function get equip() : String { return null; }
            public function set equip(value:String) : void { }
            public function get iversion() : String { return null; }
            public function set iversion(value:String) : void { }
            public function get updateVersion() : String { return null; }
            public function set updateVersion(value:String) : void { }
            public function get runResource() : String { return null; }
            public function set runResource(value:String) : void { }
            public function get referrer() : String { return null; }
            public function set referrer(value:String) : void { }
            protected function setVariable(variable:URLVariables) : void { }
            private function getVal(key:String, obj:Object) : String { return null; }
   }}