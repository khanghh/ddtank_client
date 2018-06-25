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
      
      public function MovieClipWrapper(movie:MovieClip, autoplay:Boolean = false, autodisappear:Boolean = false, repeat:Boolean = false)
      {
         super();
         _movie = movie;
         this.repeat = repeat;
         this.autoDisappear = autodisappear;
         if(!autoplay)
         {
            _movie.stop();
            _movie.addEventListener("addedToStage",__onAddStage);
         }
         else
         {
            _movie.addEventListener("enterFrame",__frameHandler);
         }
      }
      
      public function set endFrame(value:int) : void
      {
         _endFrame = value;
      }
      
      private function __onAddStage(event:Event) : void
      {
         _movie.gotoAndStop(1);
      }
      
      public function set x(val:int) : void
      {
         _x = val;
         if(movie)
         {
            movie.x = val;
         }
      }
      
      public function set y(val:int) : void
      {
         _y = val;
         if(movie)
         {
            movie.y = val;
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
      
      public function gotoAndPlay(frame:Object) : void
      {
         _movie.addEventListener("enterFrame",__frameHandler);
         _movie.gotoAndPlay(frame);
      }
      
      public function gotoAndStop(frame:Object) : void
      {
         _movie.addEventListener("enterFrame",__frameHandler);
         _movie.gotoAndStop(frame);
      }
      
      public function addFrameScriptAt(index:Number, func:Function) : void
      {
         if(index == _movie.framesLoaded)
         {
            throw new Error("You can\'t add scprit at that frame,The MovieClipWrapper used for COMPLETE event!");
         }
         _movie.addFrameScript(index,func);
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
      
      private function __frameHandler(e:Event) : void
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
