package road7th.utils
{
   import bones.display.BoneMovieStarling;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StarlingObjectUtils;
   import flash.geom.Rectangle;
   import starling.display.Sprite;
   import starling.events.Event;
   import starling.events.EventDispatcher;
   
   public class BoneMovieVSplice extends EventDispatcher implements Disposeable
   {
       
      
      private var _movieSp:Sprite;
      
      private var _movies:Array;
      
      private var _movie:BoneMovieWrapper;
      
      private var className:String;
      
      public var repeat:Boolean;
      
      private var autoDisappear:Boolean;
      
      private var _isDispose:Boolean = false;
      
      private var _x:int = 0;
      
      private var _y:int = 0;
      
      private var _spacing:Number;
      
      private var _rect:Rectangle;
      
      private var _centerDir:String;
      
      public function BoneMovieVSplice(movie:BoneMovieStarling, createNum:int = 1, spacing:Number = 0, createMovieFun:Function = null, rect:Rectangle = null, centerDir:String = "center_bottom", autoplay:Boolean = true, autodisappear:Boolean = false, repeat:Boolean = true)
      {
         var i:int = 0;
         var newMovie:* = null;
         super();
         _movie = new BoneMovieWrapper(movie);
         this.repeat = repeat;
         this.autoDisappear = autodisappear;
         _centerDir = centerDir;
         _rect = rect;
         if(_rect == null)
         {
            _movie.playAction();
            _rect = new Rectangle(0,0,movie.width,movie.height);
         }
         _movieSp = new Sprite();
         _movies = [];
         className = _movie.movie.styleName;
         _movies.push(_movie);
         _movieSp.addChild(_movie.asDisplay);
         var remainNum:int = createNum - _movies.length;
         for(i = 0; i < remainNum; )
         {
            if(createMovieFun != null)
            {
               newMovie = new BoneMovieWrapper(createMovieFun());
            }
            else
            {
               newMovie = new BoneMovieWrapper(className);
            }
            if(_centerDir == "center_bottom")
            {
               BoneMovieStarling(newMovie.movie).y = (i + 1) * (_rect.height + spacing);
            }
            _movies.push(newMovie);
            _movieSp.addChild(newMovie.movie as BoneMovieStarling);
            i++;
         }
         if(!autoplay)
         {
            exeMovieFun("stop");
            boneMovie.addEventListener("addedToStage",__onAddStage);
         }
         else
         {
            exeMovieFun("playAction",["",stop]);
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
         exeMovieFun("playAction");
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
         exeMovieFun("gotoAndPlay",[frame]);
      }
      
      public function gotoAndStop(frame:Object) : void
      {
         exeMovieFun("gotoAndStop",[frame]);
      }
      
      public function playAction(type:String, callBack:Function = null, args:Array = null) : void
      {
         type = type;
         callBack = callBack;
         args = args;
         var currentCall:Function = function($args:Array = null):void
         {
            if(callBack != null)
            {
               callFun(callBack,$args);
            }
         };
         if(_movies && _movies.length > 1)
         {
            exeMovieFun("playAction",[type]);
         }
         exeMovieFun("playAction",[type,currentCall,args],0,1);
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
      
      public function play(action:String = "") : void
      {
         exeMovieFun("playAction",[action,stop]);
      }
      
      public function stop() : void
      {
         dispatchEvent(new Event("complete"));
         if(autoDisappear)
         {
            dispose();
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
      
      public function get boneMovie() : BoneMovieStarling
      {
         return _movie.movie as BoneMovieStarling;
      }
      
      public function dispose() : void
      {
         if(!_isDispose)
         {
            boneMovie.removeEventListener("addedToStage",__onAddStage);
            ObjectUtils.disposeObject(_movie);
            _movie = null;
            StarlingObjectUtils.disposeAllChildren(_movieSp);
            _movieSp = null;
            _isDispose = true;
            _spacing = 0;
            _rect = null;
            _centerDir = null;
            _movies = null;
            className = null;
         }
      }
   }
}
