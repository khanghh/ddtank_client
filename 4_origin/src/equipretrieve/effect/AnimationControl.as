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
      
      public function AnimationControl(target:IEventDispatcher = null)
      {
         _movieArr = [];
         super(target);
      }
      
      public function addMovies(anim:EventDispatcher) : void
      {
         _movieArr.push(anim);
      }
      
      public function startMovie() : void
      {
         var i:int = 0;
         _movieokTotal = _movieArr.length;
         for(i = 0; i < _movieokTotal; )
         {
            _movieArr[i].movieStart();
            _movieArr[i].addEventListener("complete",_movieArrComplete);
            i++;
         }
      }
      
      private function _movieArrComplete(e:Event) : void
      {
         e.currentTarget.removeEventListener("complete",_movieArrComplete);
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
