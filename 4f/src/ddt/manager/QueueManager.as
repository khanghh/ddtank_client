package ddt.manager{   import ddt.events.CrazyTankSocketEvent;   import flash.display.Stage;   import flash.events.Event;      public class QueueManager   {            private static var _executable:Array = [];            public static var _waitlist:Array = [];            private static var _lifeTime:int = 0;            private static var _running:Boolean = true;            private static var _diffTimeValue:int = 0;            private static var _speedUp:int = 2;                   public function QueueManager() { super(); }
            public static function get lifeTime() : int { return 0; }
            public static function setup(stage:Stage) : void { }
            public static function pause() : void { }
            public static function resume() : void { }
            public static function setLifeTime(value:int) : void { }
            public static function addQueue(e:CrazyTankSocketEvent) : void { }
            private static function frameHandler(event:Event) : void { }
            private static function dispatchEvent(event:Event) : void { }
            public static function get executable() : Array { return null; }
   }}