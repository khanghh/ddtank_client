package yzhkof.ui.mouse{   import flash.display.DisplayObject;   import flash.display.DisplayObjectContainer;   import flash.display.InteractiveObject;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.ui.Mouse;   import yzhkof.core.StageManager;      public class MouseManager   {            private static var instance:MouseManager;            public static const STAGE_UP_EVENT:String = "STAGE_UP_EVENT";            public static const MOUSE_DOWN_AND_DRAGING_EVENT:String = "MOUSE_DOWN_AND_DRAGING_EVENT";                   private var cursorContainer:Sprite;            private var _cursor:DisplayObject;            public function MouseManager() { super(); }
            public static function getInstance() : MouseManager { return null; }
            public static function set cursor(value:DisplayObject) : void { }
            public static function get cursor() : DisplayObject { return null; }
            public static function registExtendMouseEvent(dobj:InteractiveObject) : void { }
            private static function __dobjDown(e:MouseEvent) : void { }
            private function init() : void { }
            public function get cursor() : DisplayObject { return null; }
            private function setCursor() : void { }
            private function unSetCursor() : void { }
            private function __mouseMove(e:MouseEvent) : void { }
            public function set cursor(value:DisplayObject) : void { }
   }}