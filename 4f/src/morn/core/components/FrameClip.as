package morn.core.components{   import flash.display.MovieClip;   import flash.events.Event;   import morn.core.handlers.Handler;   import morn.editor.core.IClip;      [Event(name="frameChanged",type="morn.core.events.UIEvent")]   public class FrameClip extends Component implements IClip   {                   protected var _autoStopAtRemoved:Boolean = true;            protected var _mc:MovieClip;            protected var _skin:String;            protected var _frame:int;            protected var _autoPlay:Boolean;            protected var _interval:int;            protected var _to:Object;            protected var _complete:Handler;            protected var _isPlaying:Boolean;            public function FrameClip(skin:String = null) { super(); }
            override protected function initialize() : void { }
            protected function onAddedToStage(e:Event) : void { }
            protected function onRemovedFromStage(e:Event) : void { }
            public function get skin() : String { return null; }
            public function set skin(value:String) : void { }
            public function get mc() : MovieClip { return null; }
            public function set mc(value:MovieClip) : void { }
            override public function set width(value:Number) : void { }
            override public function set height(value:Number) : void { }
            public function get frame() : int { return 0; }
            public function set frame(value:int) : void { }
            public function get index() : int { return 0; }
            public function set index(value:int) : void { }
            public function get totalFrame() : int { return 0; }
            public function get autoStopAtRemoved() : Boolean { return false; }
            public function set autoStopAtRemoved(value:Boolean) : void { }
            public function get autoPlay() : Boolean { return false; }
            public function set autoPlay(value:Boolean) : void { }
            public function get interval() : int { return 0; }
            public function set interval(value:int) : void { }
            public function get isPlaying() : Boolean { return false; }
            public function set isPlaying(value:Boolean) : void { }
            public function play() : void { }
            protected function loop() : void { }
            public function stop() : void { }
            public function gotoAndPlay(frame:int) : void { }
            public function gotoAndStop(frame:int) : void { }
            public function playFromTo(from:Object = null, to:Object = null, complete:Handler = null) : void { }
            override public function set dataSource(value:Object) : void { }
            private function clear() : void { }
            override public function dispose() : void { }
   }}