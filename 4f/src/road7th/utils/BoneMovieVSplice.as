package road7th.utils{   import bones.display.BoneMovieStarling;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import com.pickgliss.utils.StarlingObjectUtils;   import flash.geom.Rectangle;   import starling.display.Sprite;   import starling.events.Event;   import starling.events.EventDispatcher;      public class BoneMovieVSplice extends EventDispatcher implements Disposeable   {                   private var _movieSp:Sprite;            private var _movies:Array;            private var _movie:BoneMovieWrapper;            private var className:String;            public var repeat:Boolean;            private var autoDisappear:Boolean;            private var _isDispose:Boolean = false;            private var _x:int = 0;            private var _y:int = 0;            private var _spacing:Number;            private var _rect:Rectangle;            private var _centerDir:String;            public function BoneMovieVSplice(movie:BoneMovieStarling, createNum:int = 1, spacing:Number = 0, createMovieFun:Function = null, rect:Rectangle = null, centerDir:String = "center_bottom", autoplay:Boolean = true, autodisappear:Boolean = false, repeat:Boolean = true) { super(); }
            public function exeMovieFun(funStr:String, params:Array = null, startIndex:int = 0, endLength:int = 0) : void { }
            private function __onAddStage(event:Event) : void { }
            public function set x(val:int) : void { }
            public function set y(val:int) : void { }
            public function get x() : int { return 0; }
            public function get y() : int { return 0; }
            public function gotoAndPlay(frame:Object) : void { }
            public function gotoAndStop(frame:Object) : void { }
            public function playAction(type:String, callBack:Function = null, args:Array = null) : void { }
            private function callFun(fun:Function, args:Array) : void { }
            public function play(action:String = "") : void { }
            public function stop() : void { }
            public function get movie() : Sprite { return null; }
            public function get movies() : Array { return null; }
            public function get boneMovie() : BoneMovieStarling { return null; }
            public function dispose() : void { }
   }}