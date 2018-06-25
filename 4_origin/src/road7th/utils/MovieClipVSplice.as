package road7th.utils
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class MovieClipVSplice extends EventDispatcher implements Disposeable
   {
       
      
      private var _movieSp:Sprite;
      
      private var _movies:Array;
      
      private var _movie:MovieClip;
      
      private var classRef:Class;
      
      public var repeat:Boolean;
      
      private var autoDisappear:Boolean;
      
      private var _isDispose:Boolean = false;
      
      private var _x:int = 0;
      
      private var _y:int = 0;
      
      private var _endFrame:int = -1;
      
      private var _spacing:Number;
      
      private var _rect:Rectangle;
      
      private var _centerDir:String;
      
      public function MovieClipVSplice(movie:MovieClip, createNum:int = 1, spacing:Number = 0, createMovieFun:Function = null, rect:Rectangle = null, centerDir:String = "center_bottom", autoplay:Boolean = true, autodisappear:Boolean = false, repeat:Boolean = true)
      {
         var i:int = 0;
         var newMovie:* = null;
         super();
         _movie = movie;
         this.repeat = repeat;
         this.autoDisappear = autodisappear;
         _centerDir = centerDir;
         _rect = rect;
         if(_rect == null)
         {
            _movie.gotoAndStop(1);
            _rect = new Rectangle(0,0,_movie.width,_movie.height);
         }
         _movieSp = new Sprite();
         _movies = [];
         classRef = getDefinitionByName(getQualifiedClassName(movie)) as Class;
         _movies.push(movie);
         _movieSp.addChild(movie);
         var remainNum:int = createNum - _movies.length;
         for(i = 0; i < remainNum; )
         {
            if(createMovieFun != null)
            {
               newMovie = createMovieFun();
            }
            else
            {
               newMovie = MovieClip(new classRef());
            }
            if(_centerDir == "center_bottom")
            {
               newMovie.y = (i + 1) * (_rect.height + spacing);
            }
            _movies.push(newMovie);
            _movieSp.addChild(newMovie);
            i++;
         }
         if(!autoplay)
         {
            exeMovieFun("stop");
            _movie.addEventListener("addedToStage",__onAddStage);
         }
         else
         {
            exeMovieFun("play");
            _movie.addEventListener("enterFrame",__frameHandler);
         }
      }
      
      public function exeMovieFun(funStr:String, params:Array = null, startIndex:int = 0, endLength:int = 0) : void
      {
         var i:* = 0;
         if(endLength == 0)
         {
            endLength = !!_movies?_movies.length:-1;
         }
         if(!_isDispose && endLength >= 0)
         {
            for(i = startIndex; i < endLength; )
            {
               if(params)
               {
                  if(params.length == 1)
                  {
                     _movies[i][funStr](params[0]);
                  }
                  else if(params.length == 2)
                  {
                     _movies[i][funStr](params[0],params[1]);
                  }
                  else if(params.length == 3)
                  {
                     _movies[i][funStr](params[0],params[1],params[2]);
                  }
               }
               else
               {
                  _movies[i][funStr]();
               }
               i++;
            }
         }
         else if(params.length >= 2)
         {
            params[1]();
         }
      }
      
      private function __onAddStage(event:Event) : void
      {
         exeMovieFun("gotoAndStop",[1]);
      }
      
      public function set endFrame(value:int) : void
      {
         _endFrame = value;
      }
      
      public function set x(val:int) : void
      {
         _x = val;
         if(_movieSp)
         {
            _movieSp.x = val;
         }
      }
      
      public function set y(val:int) : void
      {
         _y = val;
         if(_movieSp)
         {
            _movieSp.y = val;
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
         exeMovieFun("gotoAndPlay",[frame]);
      }
      
      public function gotoAndStop(frame:Object) : void
      {
         _movie.addEventListener("enterFrame",__frameHandler);
         exeMovieFun("gotoAndStop",[frame]);
      }
      
      public function doAction(type:String, callBack:Function = null, args:Array = null) : void
      {
         type = type;
         callBack = callBack;
         args = args;
         var currentCall:Function = function($back:Function, $args:Array):void
         {
            if($back != null)
            {
               callFun($back,$args);
            }
         };
         if(_movies && _movies.length > 1)
         {
            exeMovieFun("doAction",[type],1);
         }
         exeMovieFun("doAction",[type,currentCall,[callBack,args]],0,1);
      }
      
      private function callFun(fun:Function, args:Array) : void
      {
         if(args == null || args.length == 0)
         {
            fun();
         }
         else if(args.length == 1)
         {
            fun(args[0]);
         }
         else if(args.length == 2)
         {
            fun(args[0],args[1]);
         }
         else if(args.length == 3)
         {
            fun(args[0],args[1],args[2]);
         }
         else if(args.length == 4)
         {
            fun(args[0],args[1],args[2],args[3]);
         }
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
         exeMovieFun("play");
         if(_movie.framesLoaded <= 1)
         {
            stop();
         }
      }
      
      public function stop() : void
      {
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
            exeMovieFun("gotoAndPlay",[1]);
         }
         else
         {
            stop();
         }
      }
      
      public function get movie() : Sprite
      {
         return _movieSp;
      }
      
      public function get movies() : Array
      {
         return _movies;
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
            ObjectUtils.disposeAllChildren(_movieSp);
            _movieSp = null;
            _isDispose = true;
            _spacing = 0;
            _rect = null;
            _centerDir = null;
            _movies = null;
            classRef = null;
         }
      }
   }
}
