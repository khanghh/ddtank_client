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
      
      public function AddMovieEffect(param1:int){super(null);}
      
      override public function initEffect(param1:DisplayObject, param2:Array) : void{}
      
      public function get movie() : Vector.<DisplayObject>{return null;}
      
      override public function dispose() : void{}
      
      override public function play() : void{}
      
      override public function stop() : void{}
      
      private function creatMovie() : void{}
   }
}
