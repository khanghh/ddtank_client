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
      
      public function GlowFilterAnimation(param1:IEventDispatcher = null){super(null);}
      
      public function start(param1:DisplayObject, param2:Boolean = false, param3:uint = 16711680, param4:Number = 1.0, param5:Number = 6.0, param6:Number = 6.0, param7:Number = 2, param8:int = 1, param9:Boolean = false, param10:Boolean = false) : void{}
      
      public function addMovie(param1:Number, param2:Number, param3:int, param4:int = 2) : void{}
      
      public function movieStart() : void{}
      
      private function _inframe(param1:Event) : void{}
      
      private function _refeshSpeed() : void{}
      
      private function _movieOver() : void{}
   }
}
