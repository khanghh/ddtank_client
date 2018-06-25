package equipretrieve.effect
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.filters.GlowFilter;
   
   public dynamic class GlowFilterAnimation extends EventDispatcher
   {
       
      
      private var _blurFilter:GlowFilter;
      
      private var _view:DisplayObject;
      
      private var _movieArr:Array;
      
      private var _nowMovieID:int = 0;
      
      private var _overHasFilter:Boolean;
      
      public function GlowFilterAnimation(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public function start(view:DisplayObject, overHasFilter:Boolean = false, color:uint = 16711680, alpha:Number = 1.0, blurX:Number = 6.0, blurY:Number = 6.0, strength:Number = 2, quality:int = 1, inner:Boolean = false, knockout:Boolean = false) : void
      {
         _movieArr = [];
         _blurFilter = new GlowFilter(color,alpha,blurX,blurY,strength,quality,inner,knockout);
         _view = view;
         _overHasFilter = overHasFilter;
      }
      
      public function addMovie(blurX:Number, blurY:Number, timeFrame:int, strength:int = 2) : void
      {
         var obj:Object = {};
         obj.blurX = blurX;
         obj.blurY = blurY;
         obj.strength = strength;
         obj.time = timeFrame;
         obj.blurSpeedX = 0;
         obj.blurSpeedY = 0;
         _movieArr.push(obj);
      }
      
      public function movieStart() : void
      {
         if(_movieArr == null || _movieArr.length < 1 || _view == null)
         {
            return;
         }
         _nowMovieID = 0;
         _refeshSpeed();
         _view.addEventListener("enterFrame",_inframe);
      }
      
      private function _inframe(e:Event) : void
      {
         _blurFilter.blurX = _blurFilter.blurX + _movieArr[_nowMovieID].blurSpeedX;
         _blurFilter.blurY = _blurFilter.blurY + _movieArr[_nowMovieID].blurSpeedY;
         _view.filters = [_blurFilter];
         _movieArr[_nowMovieID].time = _movieArr[_nowMovieID].time - 1;
         if(_movieArr[_nowMovieID].time == 0)
         {
            if(_nowMovieID < _movieArr.length - 1)
            {
               _nowMovieID = _nowMovieID + 1;
               _refeshSpeed();
            }
            else
            {
               _view.removeEventListener("enterFrame",_inframe);
               _movieOver();
            }
         }
      }
      
      private function _refeshSpeed() : void
      {
         _movieArr[_nowMovieID].blurSpeedX = (_movieArr[_nowMovieID].blurX - _blurFilter.blurX) / _movieArr[_nowMovieID].time;
         _movieArr[_nowMovieID].blurSpeedY = (_movieArr[_nowMovieID].blurY - _blurFilter.blurY) / _movieArr[_nowMovieID].time;
      }
      
      private function _movieOver() : void
      {
         if(_overHasFilter == false)
         {
            _view.filters = null;
         }
         _blurFilter = null;
         _view = null;
         _movieArr = null;
         _nowMovieID = 0;
         dispatchEvent(new Event("complete"));
      }
   }
}
