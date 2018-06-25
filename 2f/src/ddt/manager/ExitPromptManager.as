package ddt.manager{   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.external.ExternalInterface;   import quest.TaskManager;      public class ExitPromptManager extends EventDispatcher   {            public static const EXIT_OPENVIEW_0:String = "exitOpenView0";            public static const EXIT_OPENVIEW_1:String = "exitOpenView1";            private static var _instance:ExitPromptManager;                   public function ExitPromptManager() { super(); }
            public static function get Instance() : ExitPromptManager { return null; }
            public function init() : void { }
            public function showView() : void { }
            public function receivedFromJavaScript(str:String = "") : void { }
            public function changeJSQuestVar() : void { }
   }}