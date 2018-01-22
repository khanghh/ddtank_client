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
      
      public function MovieClipControl(param1:int)
      {
         _movieArr = [];
         _evtSprite = new Sprite();
         super();
         _total = param1;
      }
      
      public function addMovies(param1:MovieClip, param2:int, param3:int) : void
      {
         var _loc4_:Object = {};
         param1.visible = false;
         param1.stop();
         _loc4_.view = param1;
         _loc4_.goInt = param2;
         _loc4_.totalInt = param3 + param2;
         _movieArr.push(_loc4_);
      }
      
      public function startMovie() : void
      {
         _currentInt = 0;
         _arrInt = _movieArr.length;
         _evtSprite.addEventListener("enterFrame",_inFrame);
      }
      
      private function _inFrame(param1:Event) : void
      {
         var _loc2_:int = 0;
         _currentInt = _currentInt + 1;
         if(_currentInt >= _total)
         {
            _allMovieClipOver();
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < _arrInt)
         {
            if(_movieArr[_loc2_].goInt == _currentInt)
            {
               _movieArr[_loc2_].view.visible = true;
               _movieArr[_loc2_].view.play();
            }
            else if(_movieArr[_loc2_].totalInt == _currentInt)
            {
               _movieArr[_loc2_].view.visible = false;
               _movieArr[_loc2_].view.stop();
            }
            _loc2_++;
         }
      }
      
      private function _allMovieClipOver() : void
      {
         var _loc1_:int = 0;
         dispatchEvent(new Event("complete"));
         _evtSprite.removeEventListener("enterFrame",_inFrame);
         _loc1_ = 0;
         while(_loc1_ < _arrInt)
         {
            _movieArr[_loc1_].view.visible = false;
            _movieArr[_loc1_].view.stop();
            _loc1_++;
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
