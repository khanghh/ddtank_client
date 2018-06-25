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
      
      public function AddMovieEffect($id:int)
      {
         super($id);
      }
      
      override public function initEffect(target:DisplayObject, data:Array) : void
      {
         super.initEffect(target,data);
         _data = data;
         creatMovie();
      }
      
      public function get movie() : Vector.<DisplayObject>
      {
         return _movies;
      }
      
      override public function dispose() : void
      {
         var i:int = 0;
         super.dispose();
         for(i = 0; i < _movies.length; )
         {
            if(_movies[i] is MovieClip)
            {
               MovieClip(_movies[i]).stop();
            }
            if(_movies[i])
            {
               ObjectUtils.disposeObject(_movies[i]);
            }
            i++;
         }
         _movies = null;
      }
      
      override public function play() : void
      {
         var i:int = 0;
         super.play();
         for(i = 0; i < _movies.length; )
         {
            if(_movies[i] is MovieClip)
            {
               MovieClip(_movies[i]).play();
            }
            if(_target.parent)
            {
               _target.parent.addChild(_movies[i]);
            }
            _movies[i].x = _target.x;
            _movies[i].y = _target.y;
            if(_rectangles.length - 1 >= i)
            {
               _movies[i].x = _movies[i].x + _rectangles[i].x;
               _movies[i].y = _movies[i].y + _rectangles[i].y;
            }
            i++;
         }
      }
      
      override public function stop() : void
      {
         var i:int = 0;
         super.stop();
         for(i = 0; i < _movies.length; )
         {
            if(_movies[i] is MovieClip)
            {
               MovieClip(_movies[i]).stop();
            }
            if(_movies[i].parent)
            {
               _movies[i].parent.removeChild(_movies[i]);
            }
            i++;
         }
      }
      
      private function creatMovie() : void
      {
         var i:int = 0;
         var j:int = 0;
         var k:int = 0;
         _movies = new Vector.<DisplayObject>();
         _rectangles = new Vector.<Rectangle>();
         for(i = 0; i < _data.length; )
         {
            if(_data[i] is DisplayObject)
            {
               _movies.push(_data[i]);
            }
            else if(_data[i] is String)
            {
               _movies.push(ComponentFactory.Instance.creat(_data[i]));
            }
            i++;
         }
         for(j = 0; j < _data.length; )
         {
            if(_data[j] is Point)
            {
               _rectangles.push(new Rectangle(_data[j].x,_data[j].y,0,0));
            }
            else if(_data[j] is Rectangle)
            {
               _rectangles.push(_data[j]);
            }
            j++;
         }
         for(k = 0; k < _movies.length; )
         {
            if(_movies[k] is InteractiveObject)
            {
               InteractiveObject(_movies[k]).mouseEnabled = false;
            }
            if(_movies[k] is DisplayObjectContainer)
            {
               DisplayObjectContainer(_movies[k]).mouseChildren = false;
               DisplayObjectContainer(_movies[k]).mouseEnabled = false;
            }
            k++;
         }
      }
   }
}
