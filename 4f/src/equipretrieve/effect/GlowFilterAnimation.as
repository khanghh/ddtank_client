package equipretrieve.effect{   import flash.display.DisplayObject;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import flash.filters.GlowFilter;      public dynamic class GlowFilterAnimation extends EventDispatcher   {                   private var _blurFilter:GlowFilter;            private var _view:DisplayObject;            private var _movieArr:Array;            private var _nowMovieID:int = 0;            private var _overHasFilter:Boolean;            public function GlowFilterAnimation(target:IEventDispatcher = null) { super(null); }
            public function start(view:DisplayObject, overHasFilter:Boolean = false, color:uint = 16711680, alpha:Number = 1.0, blurX:Number = 6.0, blurY:Number = 6.0, strength:Number = 2, quality:int = 1, inner:Boolean = false, knockout:Boolean = false) : void { }
            public function addMovie(blurX:Number, blurY:Number, timeFrame:int, strength:int = 2) : void { }
            public function movieStart() : void { }
            private function _inframe(e:Event) : void { }
            private function _refeshSpeed() : void { }
            private function _movieOver() : void { }
   }}