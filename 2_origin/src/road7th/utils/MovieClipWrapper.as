package road7th.utils
{
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   [Event(name="complete",type="flash.events.Event")]
   public class MovieClipWrapper extends EventDispatcher implements Disposeable
   {
       
      
      private var _movie:MovieClip;
      
      public var repeat:Boolean;
      
      private var autoDisappear:Boolean;
      
      private var _isDispose:Boolean = false;
      
      private var _x:int = 0;
      
      private var _y:int = 0;
      
      private var _endFrame:int = -1;
      
      public function MovieClipWrapper(param1:MovieClip, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false)
      {
         super();
         _movie = param1;
         this.repeat = param4;
         this.autoDisappear = param3;
         if(!param2)
         {
            _movie.stop();
            _movie.addEventListener("addedToStage",__onAddStage);
         }
         else
         {
            _movie.addEventListener("enterFrame",__frameHandler);
         }
      }
      
      public function set endFrame(param1:int) : void
      {
         _endFrame = param1;
      }
      
      private function __onAddStage(param1:Event) : void
      {
         _movie.gotoAndStop(1);
      }
      
      public function set x(param1:int) : void
      {
         _x = param1;
         if(movie)
         {
            movie.x = param1;
         }
      }
      
      public function set y(param1:int) : void
      {
         _y = param1;
         if(movie)
         {
            movie.y = param1;
         }
      }
      
      public function get x() : int
      {
         return _x;
      }
      
      public function get y() : int
      {
         return _y;
      }
      
      public function gotoAndPlay(param1:Object) : void
      {
         _movie.addEventListener("enterFrame",__frameHandler);
         _movie.gotoAndPlay(param1);
      }
      
      public function gotoAndStop(param1:Object) : void
      {
         _movie.addEventListener("enterFrame",__frameHandler);
         _movie.gotoAndStop(param1);
      }
      
      public function addFrameScriptAt(param1:Number, param2:Function) : void
      {
         if(param1 == _movie.framesLoaded)
         {
            throw new Error("You can\'t add scprit at that frame,The MovieClipWrapper used for COMPLETE event!");
         }
         _movie.addFrameScript(param1,param2);
      }
      
      public function play() : void
      {
         _movie.addEventListener("enterFrame",__frameHandler);
         _movie.play();
         if(_movie.framesLoaded <= 1)
         {
            stop();
         }
      }
      
      public function get movie() : MovieClip
      {
         return _movie;
      }
      
      public function stop() : void
      {
         _movie.removeEventListener("enterFrame",__frameHandler);
         dispatchEvent(new Event("complete"));
         if(autoDisappear)
         {
            dispose();
         }
      }
      
      private function __frameHandler(param1:Event) : void
      {
         if(_movie.currentFrame == _endFrame || _movie.currentFrame == _movie.totalFrames)
         {
            __endFrame();
         }
      }
      
      private function __endFrame() : void
      {
         if(repeat)
         {
            _movie.gotoAndPlay(1);
         }
         else
         {
            stop();
         }
      }
      
      public function dispose() : void
      {
         if(!_isDispose)
         {
            _movie.removeEventListener("enterFrame",__frameHandler);
            _movie.removeEventListener("addedToStage",__onAddStage);
            if(_movie.parent)
            {
               _movie.parent.removeChild(_movie);
            }
            _movie.stop();
            _movie = null;
            _isDispose = true;
         }
      }
   }
}
