package road7th.utils{   import com.pickgliss.ui.core.Disposeable;   import flash.display.MovieClip;   import flash.events.Event;   import flash.events.EventDispatcher;      [Event(name="complete",type="flash.events.Event")]   public class MovieClipWrapper extends EventDispatcher implements Disposeable   {                   private var _movie:MovieClip;            public var repeat:Boolean;            private var autoDisappear:Boolean;            private var _isDispose:Boolean = false;            private var _x:int = 0;            private var _y:int = 0;            private var _endFrame:int = -1;            public function MovieClipWrapper(movie:MovieClip, autoplay:Boolean = false, autodisappear:Boolean = false, repeat:Boolean = false) { super(); }
            public function set endFrame(value:int) : void { }
            private function __onAddStage(event:Event) : void { }
            public function set x(val:int) : void { }
            public function set y(val:int) : void { }
            public function get x() : int { return 0; }
            public function get y() : int { return 0; }
            public function gotoAndPlay(frame:Object) : void { }
            public function gotoAndStop(frame:Object) : void { }
            public function addFrameScriptAt(index:Number, func:Function) : void { }
            public function play() : void { }
            public function get movie() : MovieClip { return null; }
            public function stop() : void { }
            private function __frameHandler(e:Event) : void { }
            private function __endFrame() : void { }
            public function dispose() : void { }
   }}