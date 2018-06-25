package morn.core.components{   import com.pickgliss.loader.BitmapLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import flash.display.BitmapData;   import flash.events.Event;   import morn.core.handlers.Handler;   import morn.core.utils.StringUtils;   import morn.editor.core.IClip;      [Event(name="imageLoaded",type="morn.core.events.UIEvent")]   [Event(name="frameChanged",type="morn.core.events.UIEvent")]   public class Clip extends Component implements IClip   {                   protected var _autoStopAtRemoved:Boolean = true;            protected var _bitmap:AutoBitmap;            protected var _clipX:int = 1;            protected var _clipY:int = 1;            protected var _clipWidth:Number;            protected var _clipHeight:Number;            protected var _url:String;            protected var _autoPlay:Boolean;            protected var _interval:int;            protected var _from:int = -1;            protected var _to:int = -1;            protected var _complete:Handler;            protected var _isPlaying:Boolean;            protected var _clipsUrl:String;            protected var _bitmapLoader:BitmapLoader;            public function Clip(url:String = null, clipX:int = 1, clipY:int = 1) { super(); }
            override protected function createChildren() : void { }
            override protected function initialize() : void { }
            protected function onAddedToStage(e:Event) : void { }
            protected function onRemovedFromStage(e:Event) : void { }
            public function get url() : String { return null; }
            public function set url(value:String) : void { }
            public function get skin() : String { return null; }
            public function set skin(value:String) : void { }
            public function get clipX() : int { return 0; }
            public function set clipX(value:int) : void { }
            public function get clipY() : int { return 0; }
            public function set clipY(value:int) : void { }
            public function get clipWidth() : Number { return 0; }
            public function set clipWidth(value:Number) : void { }
            public function get clipHeight() : Number { return 0; }
            public function set clipHeight(value:Number) : void { }
            protected function changeClip() : void { }
            private function __onLoaderComplete(e:LoaderEvent) : void { }
            private function __onLoaderError(e:LoaderEvent) : void { }
            private function clearBitmapLoader() : void { }
            protected function loadComplete(url:String, isLoad:Boolean, bmd:BitmapData) : void { }
            public function get clips() : Vector.<BitmapData> { return null; }
            public function set clips(value:Vector.<BitmapData>) : void { }
            public function get clipsUrl() : String { return null; }
            public function set clipsUrl(value:String) : void { }
            public function set clipsUrlSimple(value:String) : void { }
            override public function set width(value:Number) : void { }
            override public function set height(value:Number) : void { }
            override public function commitMeasure() : void { }
            public function get sizeGrid() : String { return null; }
            public function set sizeGrid(value:String) : void { }
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
            public function playFromTo(from:int = -1, to:int = -1, complete:Handler = null) : void { }
            override public function set dataSource(value:Object) : void { }
            public function get smoothing() : Boolean { return false; }
            public function set smoothing(value:Boolean) : void { }
            public function get anchorX() : Number { return 0; }
            public function set anchorX(value:Number) : void { }
            public function get anchorY() : Number { return 0; }
            public function set anchorY(value:Number) : void { }
            public function get bitmap() : AutoBitmap { return null; }
            override public function dispose() : void { }
            public function destroy(clearFromLoader:Boolean = false) : void { }
   }}