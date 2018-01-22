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
      
      public function GlowFilterAnimation(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function start(param1:DisplayObject, param2:Boolean = false, param3:uint = 16711680, param4:Number = 1.0, param5:Number = 6.0, param6:Number = 6.0, param7:Number = 2, param8:int = 1, param9:Boolean = false, param10:Boolean = false) : void
      {
         _movieArr = [];
         _blurFilter = new GlowFilter(param3,param4,param5,param6,param7,param8,param9,param10);
         _view = param1;
         _overHasFilter = param2;
      }
      
      public function addMovie(param1:Number, param2:Number, param3:int, param4:int = 2) : void
      {
         var _loc5_:Object = {};
         _loc5_.blurX = param1;
         _loc5_.blurY = param2;
         _loc5_.strength = param4;
         _loc5_.time = param3;
         _loc5_.blurSpeedX = 0;
         _loc5_.blurSpeedY = 0;
         _movieArr.push(_loc5_);
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
      
      private function _inframe(param1:Event) : void
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
