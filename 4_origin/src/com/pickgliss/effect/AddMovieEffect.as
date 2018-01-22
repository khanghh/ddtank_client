package com.pickgliss.effect
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class AddMovieEffect extends BaseEffect implements IEffect
   {
       
      
      private var _movies:Vector.<DisplayObject>;
      
      private var _rectangles:Vector.<Rectangle>;
      
      private var _data:Array;
      
      public function AddMovieEffect(param1:int)
      {
         super(param1);
      }
      
      override public function initEffect(param1:DisplayObject, param2:Array) : void
      {
         super.initEffect(param1,param2);
         _data = param2;
         creatMovie();
      }
      
      public function get movie() : Vector.<DisplayObject>
      {
         return _movies;
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         super.dispose();
         _loc1_ = 0;
         while(_loc1_ < _movies.length)
         {
            if(_movies[_loc1_] is MovieClip)
            {
               MovieClip(_movies[_loc1_]).stop();
            }
            if(_movies[_loc1_])
            {
               ObjectUtils.disposeObject(_movies[_loc1_]);
            }
            _loc1_++;
         }
         _movies = null;
      }
      
      override public function play() : void
      {
         var _loc1_:int = 0;
         super.play();
         _loc1_ = 0;
         while(_loc1_ < _movies.length)
         {
            if(_movies[_loc1_] is MovieClip)
            {
               MovieClip(_movies[_loc1_]).play();
            }
            if(_target.parent)
            {
               _target.parent.addChild(_movies[_loc1_]);
            }
            _movies[_loc1_].x = _target.x;
            _movies[_loc1_].y = _target.y;
            if(_rectangles.length - 1 >= _loc1_)
            {
               _movies[_loc1_].x = _movies[_loc1_].x + _rectangles[_loc1_].x;
               _movies[_loc1_].y = _movies[_loc1_].y + _rectangles[_loc1_].y;
            }
            _loc1_++;
         }
      }
      
      override public function stop() : void
      {
         var _loc1_:int = 0;
         super.stop();
         _loc1_ = 0;
         while(_loc1_ < _movies.length)
         {
            if(_movies[_loc1_] is MovieClip)
            {
               MovieClip(_movies[_loc1_]).stop();
            }
            if(_movies[_loc1_].parent)
            {
               _movies[_loc1_].parent.removeChild(_movies[_loc1_]);
            }
            _loc1_++;
         }
      }
      
      private function creatMovie() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _movies = new Vector.<DisplayObject>();
         _rectangles = new Vector.<Rectangle>();
         _loc3_ = 0;
         while(_loc3_ < _data.length)
         {
            if(_data[_loc3_] is DisplayObject)
            {
               _movies.push(_data[_loc3_]);
            }
            else if(_data[_loc3_] is String)
            {
               _movies.push(ComponentFactory.Instance.creat(_data[_loc3_]));
            }
            _loc3_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _data.length)
         {
            if(_data[_loc1_] is Point)
            {
               _rectangles.push(new Rectangle(_data[_loc1_].x,_data[_loc1_].y,0,0));
            }
            else if(_data[_loc1_] is Rectangle)
            {
               _rectangles.push(_data[_loc1_]);
            }
            _loc1_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _movies.length)
         {
            if(_movies[_loc2_] is InteractiveObject)
            {
               InteractiveObject(_movies[_loc2_]).mouseEnabled = false;
            }
            if(_movies[_loc2_] is DisplayObjectContainer)
            {
               DisplayObjectContainer(_movies[_loc2_]).mouseChildren = false;
               DisplayObjectContainer(_movies[_loc2_]).mouseEnabled = false;
            }
            _loc2_++;
         }
      }
   }
}
