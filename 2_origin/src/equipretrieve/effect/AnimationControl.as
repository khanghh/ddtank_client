package equipretrieve.effect
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class AnimationControl extends EventDispatcher
   {
       
      
      private var _movieArr:Array;
      
      private var _movieokNum:int = 0;
      
      private var _movieokTotal:int = 0;
      
      public function AnimationControl(param1:IEventDispatcher = null)
      {
         _movieArr = [];
         super(param1);
      }
      
      public function addMovies(param1:EventDispatcher) : void
      {
         _movieArr.push(param1);
      }
      
      public function startMovie() : void
      {
         var _loc1_:int = 0;
         _movieokTotal = _movieArr.length;
         _loc1_ = 0;
         while(_loc1_ < _movieokTotal)
         {
            _movieArr[_loc1_].movieStart();
            _movieArr[_loc1_].addEventListener("complete",_movieArrComplete);
            _loc1_++;
         }
      }
      
      private function _movieArrComplete(param1:Event) : void
      {
         param1.currentTarget.removeEventListener("complete",_movieArrComplete);
         _movieokNum = _movieokNum + 1;
         if(_movieokNum == _movieokTotal)
         {
            _movieArr = null;
            _movieokNum = 0;
            dispatchEvent(new Event("complete"));
         }
      }
   }
}
