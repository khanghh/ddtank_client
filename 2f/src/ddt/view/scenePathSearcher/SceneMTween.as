package ddt.view.scenePathSearcher{   import flash.events.Event;   import flash.events.EventDispatcher;      public class SceneMTween extends EventDispatcher   {            public static const FINISH:String = "finish";            public static const CHANGE:String = "change";            public static const START:String = "start";            public static const STOP:String = "stop";                   private var _obj:Object;            private var _prop:String;            private var _prop2:String;            private var _isPlaying:Boolean;            private var _finish:Number;            private var _finish2:Number;            private var vectors:Number;            private var vectors2:Number;            private var currentCount:Number;            private var repeatCount:Number;            private var _time:Number;            public function SceneMTween(obj:Object) { super(); }
            private function onEnterFrame(event:Event) : void { }
            public function start(time:Number, prop:String, finish:Number, prop2:String = null, finish2:Number = 0) : void { }
            public function startGo() : void { }
            public function stop() : void { }
            public function dispose() : void { }
            public function get isPlaying() : Boolean { return false; }
            public function set time(value:Number) : void { }
   }}