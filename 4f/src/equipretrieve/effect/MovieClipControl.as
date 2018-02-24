package equipretrieve.effect
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class MovieClipControl extends EventDispatcher
   {
       
      
      private var _movieArr:Array;
      
      private var _evtSprite:Sprite;
      
      private var _total:int;
      
      private var _currentInt:int;
      
      private var _arrInt:int;
      
      public function MovieClipControl(param1:int){super();}
      
      public function addMovies(param1:MovieClip, param2:int, param3:int) : void{}
      
      public function startMovie() : void{}
      
      private function _inFrame(param1:Event) : void{}
      
      private function _allMovieClipOver() : void{}
      
      private function _removeAllView() : void{}
   }
}
