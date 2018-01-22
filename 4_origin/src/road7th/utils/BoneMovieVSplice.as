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
      
      public function BoneMovieVSplice(param1:BoneMovieStarling, param2:int = 1, param3:Number = 0, param4:Function = null, param5:Rectangle = null, param6:String = "center_bottom", param7:Boolean = true, param8:Boolean = false, param9:Boolean = true)
      {
         var _loc12_:int = 0;
         var _loc11_:* = null;
         super();
         _movie = new BoneMovieWrapper(param1);
         this.repeat = param9;
         this.autoDisappear = param8;
         _centerDir = param6;
         _rect = param5;
         if(_rect == null)
         {
            _movie.playAction();
            _rect = new Rectangle(0,0,param1.width,param1.height);
         }
         _movieSp = new Sprite();
         _movies = [];
         className = _movie.movie.styleName;
         _movies.push(_movie);
         _movieSp.addChild(_movie.asDisplay);
         var _loc10_:int = param2 - _movies.length;
         _loc12_ = 0;
         while(_loc12_ < _loc10_)
         {
            if(param4 != null)
            {
               _loc11_ = new BoneMovieWrapper(param4());
            }
            else
            {
               _loc11_ = new BoneMovieWrapper(className);
            }
            if(_centerDir == "center_bottom")
            {
               BoneMovieStarling(_loc11_.movie).y = (_loc12_ + 1) * (_rect.height + param3);
            }
            _movies.push(_loc11_);
            _movieSp.addChild(_loc11_.movie as BoneMovieStarling);
            _loc12_++;
         }
         if(!param7)
         {
            exeMovieFun("stop");
            boneMovie.addEventListener("addedToStage",__onAddStage);
         }
         else
         {
            exeMovieFun("playAction",["",stop]);
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
         exeMovieFun("playAction");
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
         exeMovieFun("gotoAndPlay",[param1]);
      }
      
      public function gotoAndStop(param1:Object) : void
      {
         exeMovieFun("gotoAndStop",[param1]);
      }
      
      public function playAction(param1:String, param2:Function = null, param3:Array = null) : void
      {
         type = param1;
         callBack = param2;
         args = param3;
         var currentCall:Function = function(param1:Array = null):void
         {
            if(callBack != null)
            {
               callFun(callBack,param1);
            }
         };
         if(_movies && _movies.length > 1)
         {
            exeMovieFun("playAction",[type]);
         }
         exeMovieFun("playAction",[type,currentCall,args],0,1);
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
      
      public function play(param1:String = "") : void
      {
         exeMovieFun("playAction",[param1,stop]);
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
