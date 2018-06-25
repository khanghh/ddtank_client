package yzhkof.debug{   import flash.display.DisplayObject;   import flash.events.Event;   import flash.events.KeyboardEvent;   import flash.events.MouseEvent;   import flash.ui.Keyboard;      public class DebugDrag   {                   public var data;            private var _target:DisplayObject;            private var state:int = 1;            private var preX:Number;            private var preY:Number;            public function DebugDrag(target:DisplayObject = null) { super(); }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            private function __enterFrame(event:Event) : void { }
            public function stop() : void { }
            private function __mouseDown(event:MouseEvent) : void { }
            protected final function callBackFunction(fun:Function) : void { }
            public function get target() : DisplayObject { return null; }
            public function set target(value:DisplayObject) : void { }
            private function __onKeyDown(e:KeyboardEvent) : void { }
   }}