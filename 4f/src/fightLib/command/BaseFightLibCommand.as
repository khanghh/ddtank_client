package fightLib.command{   import fightLib.FightLibCommandEvent;   import fightLib.IFightLibCommand;   import flash.events.Event;   import flash.events.EventDispatcher;      public class BaseFightLibCommand implements IFightLibCommand   {                   protected var _dispather:EventDispatcher;            private var _excuteFunArr:Array;            protected var _completeFunArr:Array;            protected var _prepareFun:Function;            protected var _undoFunArr:Array;            public function BaseFightLibCommand() { super(); }
            public function set completeFunArr(value:Array) : void { }
            public function get completeFunArr() : Array { return null; }
            public function get prepareFun() : Function { return null; }
            public function set prepareFun(value:Function) : void { }
            public function excute() : void { }
            public function finish() : void { }
            public function undo() : void { }
            public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void { }
            public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void { }
            public function dispatchEvent(event:Event) : Boolean { return false; }
            public function hasEventListener(type:String) : Boolean { return false; }
            public function willTrigger(type:String) : Boolean { return false; }
            public function get undoFunArr() : Array { return null; }
            public function set undoFunArr(value:Array) : void { }
            public function dispose() : void { }
            public function get excuteFunArr() : Array { return null; }
            public function set excuteFunArr(value:Array) : void { }
   }}