package ddt.manager{   import flash.events.EventDispatcher;      public class ConsortiaDutyManager extends EventDispatcher   {            private static var _instance:ConsortiaDutyManager;                   public function ConsortiaDutyManager() { super(); }
            public static function GetRight(right:int, consortiaDutyType:int) : Boolean { return false; }
            public static function get Instance() : ConsortiaDutyManager { return null; }
   }}