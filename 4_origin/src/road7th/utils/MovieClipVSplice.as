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
      
      public function MovieClipVSplice(param1:MovieClip, param2:int = 1, param3:Number = 0, param4:Function = null, param5:Rectangle = null, param6:String = "center_bottom", param7:Boolean = true, param8:Boolean = false, param9:Boolean = true)
      {
         var _loc12_:int = 0;
         var _loc11_:* = null;
         super();
         _movie = param1;
         this.repeat = param9;
         this.autoDisappear = param8;
         _centerDir = param6;
         _rect = param5;
         if(_rect == null)
         {
            _movie.gotoAndStop(1);
            _rect = new Rectangle(0,0,_movie.width,_movie.height);
         }
         _movieSp = new Sprite();
         _movies = [];
         classRef = getDefinitionByName(getQualifiedClassName(param1)) as Class;
         _movies.push(param1);
         _movieSp.addChild(param1);
         var _loc10_:int = param2 - _movies.length;
         _loc12_ = 0;
         while(_loc12_ < _loc10_)
         {
            if(param4 != null)
            {
               _loc11_ = param4();
            }
            else
            {
               _loc11_ = MovieClip(new classRef());
            }
            if(_centerDir == "center_bottom")
            {
               _loc11_.y = (_loc12_ + 1) * (_rect.height + param3);
            }
            _movies.push(_loc11_);
            _movieSp.addChild(_loc11_);
            _loc12_++;
         }
         if(!param7)
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
      
      public function exeMovieFun(param1:String, param2:Array = null, param3:int = 0, param4:int = 0) : void
      {
         var _loc5_:* = 0;
         if(param4 == 0)
         {
            param4 = !!_movies?_movies.length:-1;
         }
         if(!_isDispose && param4 >= 0)
         {
            _loc5_ = param3;
            while(_loc5_ < param4)
            {
               if(param2)
               {
                  if(param2.length == 1)
                  {
                     _movies[_loc5_][param1](param2[0]);
                  }
                  else if(param2.length == 2)
                  {
                     _movies[_loc5_][param1](param2[0],param2[1]);
                  }
                  else if(param2.length == 3)
                  {
                     _movies[_loc5_][param1](param2[0],param2[1],param2[2]);
                  }
               }
               else
               {
                  _movies[_loc5_][param1]();
               }
               _loc5_++;
            }
         }
         else if(param2.length >= 2)
         {
            param2[1]();
         }
      }
      
      private function __onAddStage(param1:Event) : void
      {
         exeMovieFun("gotoAndStop",[1]);
      }
      
      public function set endFrame(param1:int) : void
      {
         _endFrame = param1;
      }
      
      public function set x(param1:int) : void
      {
         _x = param1;
         if(_movieSp)
         {
            _movieSp.x = param1;
         }
      }
      
      public function set y(param1:int) : void
      {
         _y = param1;
         if(_movieSp)
         {
            _movieSp.y = param1;
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
         exeMovieFun("gotoAndPlay",[param1]);
      }
      
      public function gotoAndStop(param1:Object) : void
      {
         _movie.addEventListener("enterFrame",__frameHandler);
         exeMovieFun("gotoAndStop",[param1]);
      }
      
      public function doAction(param1:String, param2:Function = null, param3:Array = null) : void
      {
         type = param1;
         callBack = param2;
         args = param3;
         var currentCall:Function = function(param1:Function, param2:Array):void
         {
            if(param1 != null)
            {
               callFun(param1,param2);
            }
         };
         if(_movies && _movies.length > 1)
         {
            exeMovieFun("doAction",[type],1);
         }
         exeMovieFun("doAction",[type,currentCall,[callBack,args]],0,1);
      }
      
      private function callFun(param1:Function, param2:Array) : void
      {
         if(param2 == null || param2.length == 0)
         {
            param1();
         }
         else if(param2.length == 1)
         {
            param1(param2[0]);
         }
         else if(param2.length == 2)
         {
            param1(param2[0],param2[1]);
         }
         else if(param2.length == 3)
         {
            param1(param2[0],param2[1],param2[2]);
         }
         else if(param2.length == 4)
         {
            param1(param2[0],param2[1],param2[2],param2[3]);
         }
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
