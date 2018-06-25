package equipretrieve.effect{   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.EventDispatcher;      public class MovieClipControl extends EventDispatcher   {                   private var _movieArr:Array;            private var _evtSprite:Sprite;            private var _total:int;            private var _currentInt:int;            private var _arrInt:int;            public function MovieClipControl(total:int) { super(); }
            public function addMovies(view:MovieClip, goInt:int, totalInt:int) : void { }
            public function startMovie() : void { }
            private function _inFrame(e:Event) : void { }
            private function _allMovieClipOver() : void { }
            private function _removeAllView() : void { }
   }}