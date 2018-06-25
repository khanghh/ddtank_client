package sanXiao.juggler{   import flash.events.TimerEvent;   import flash.utils.Timer;      public class JugglerNative   {            private static var _inited:Boolean = false;                   private var _movieClipBitmap:Vector.<MovieClipShape>;            private var _timer:Timer;            private var _duration:Number;            public function JugglerNative(frameRate:int) { super(); }
            public function set duration(frameRate:int) : void { }
            public function add(movieClipBitmap:MovieClipShape) : void { }
            public function remove(bitmapClip:MovieClipShape) : void { }
            public function removeAll() : void { }
            public function hasAdded(mcs:MovieClipShape) : Boolean { return false; }
            public function dispose() : void { }
            public function stop() : void { }
            public function start() : void { }
            protected function onTimer(event:TimerEvent) : void { }
   }}