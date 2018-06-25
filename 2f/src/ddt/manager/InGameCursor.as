package ddt.manager{   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import flash.ui.Mouse;      public class InGameCursor extends EventDispatcher   {            private static const LOADING_CURSOR_CLASS:String = "cursor.LoadingCursor";            private static var _instance:InGameCursor;            public static var _disabled:Boolean;                   private var _setuped:Boolean;            public function InGameCursor(target:IEventDispatcher = null) { super(null); }
            public static function set disabled(value:Boolean) : void { }
            public static function get Instance() : InGameCursor { return null; }
            public static function hide() : void { }
            public static function show() : void { }
            public function set cursorType(value:String) : void { }
   }}