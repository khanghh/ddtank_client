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
      
      public function MovieClipControl(total:int)
      {
         _movieArr = [];
         _evtSprite = new Sprite();
         super();
         _total = total;
      }
      
      public function addMovies(view:MovieClip, goInt:int, totalInt:int) : void
      {
         var obj:Object = {};
         view.visible = false;
         view.stop();
         obj.view = view;
         obj.goInt = goInt;
         obj.totalInt = totalInt + goInt;
         _movieArr.push(obj);
      }
      
      public function startMovie() : void
      {
         _currentInt = 0;
         _arrInt = _movieArr.length;
         _evtSprite.addEventListener("enterFrame",_inFrame);
      }
      
      private function _inFrame(e:Event) : void
      {
         var i:int = 0;
         _currentInt = _currentInt + 1;
         if(_currentInt >= _total)
         {
            _allMovieClipOver();
            return;
         }
         for(i = 0; i < _arrInt; )
         {
            if(_movieArr[i].goInt == _currentInt)
            {
               _movieArr[i].view.visible = true;
               _movieArr[i].view.play();
            }
            else if(_movieArr[i].totalInt == _currentInt)
            {
               _movieArr[i].view.visible = false;
               _movieArr[i].view.stop();
            }
            i++;
         }
      }
      
      private function _allMovieClipOver() : void
      {
         var i:int = 0;
         dispatchEvent(new Event("complete"));
         _evtSprite.removeEventListener("enterFrame",_inFrame);
         for(i = 0; i < _arrInt; )
         {
            _movieArr[i].view.visible = false;
            _movieArr[i].view.stop();
            i++;
         }
         _removeAllView();
      }
      
      private function _removeAllView() : void
      {
         _evtSprite = null;
         _movieArr = null;
      }
   }
}
