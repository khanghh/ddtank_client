package yzhkof{   import flash.display.InteractiveObject;   import flash.display.Stage;   import flash.events.Event;   import flash.events.KeyboardEvent;      public class KeyMy   {            private static var listener_object:InteractiveObject;            private static var btn_array:Object;            private static var stage:Stage;                   public function KeyMy() { super(); }
            public static function startListener(input_object:InteractiveObject) : void { }
            public static function stopListener() : void { }
            public static function isDown(key:uint) : Boolean { return false; }
            public static function setStage(stage_object:Stage) : void { }
            private static function mouseLeaveHandler(e:Event) : void { }
            private static function keyDownHandler(e:KeyboardEvent) : void { }
            private static function keyUpHandler(e:KeyboardEvent) : void { }
   }}