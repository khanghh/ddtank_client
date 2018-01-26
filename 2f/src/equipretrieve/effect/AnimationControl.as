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
      
      public function AnimationControl(param1:IEventDispatcher = null){super(null);}
      
      public function addMovies(param1:EventDispatcher) : void{}
      
      public function startMovie() : void{}
      
      private function _movieArrComplete(param1:Event) : void{}
   }
}
