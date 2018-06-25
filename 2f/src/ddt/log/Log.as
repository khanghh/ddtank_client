package ddt.log{   import flash.display.Stage;   import flash.events.Event;   import flash.events.KeyboardEvent;   import flash.net.FileReference;      public class Log   {            private static var _instance:Log;                   private const ENABLE_TRACE:Boolean = false;            private const MSG_MAX_NUM:int = 1000;            private const REMOVE_COUNT:int = 10;            private var _stage:Stage;            private var _file:FileReference;            private var _msgArr:Array;            public function Log() { super(); }
            public static function get instance() : Log { return null; }
            public function init(stage:Stage) : void { }
            private function onKeyUp(evt:KeyboardEvent) : void { }
            private function onFileComplete(evt:Event) : void { }
            public function log(msg:*, tag:String = null) : void { }
            private function getDateString(date:Date) : String { return null; }
            private function fixTwoDigit(digit:int) : String { return null; }
            private function pushMsg(msg:String) : void { }
   }}