package morn.core.handlers{   public class Handler   {                   public var method:Function;            public var args:Array;            public function Handler(method:Function = null, args:Array = null) { super(); }
            public function execute() : void { }
            public function executeWith(data:Array) : void { }
   }}