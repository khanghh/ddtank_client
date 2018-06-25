package ddt.manager{   import ddt.view.chat.ChatEvent;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import road7th.comm.PackageIn;      public class SystemPostManager extends EventDispatcher   {            public static var SYSTEMPOST_UPDATE:String = "systemPostUpdate";            private static var instance:SystemPostManager;                   private var _postInfo:Object;            public function SystemPostManager(target:IEventDispatcher = null) { super(null); }
            public static function get Instance() : SystemPostManager { return null; }
            public function setup() : void { }
            protected function __onReceivePost(event:ChatEvent) : void { }
            private function addInfo(msg:String, type:int) : void { }
            public function get postInfo() : Object { return null; }
   }}