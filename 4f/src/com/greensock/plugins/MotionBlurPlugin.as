package com.greensock.plugins
{
   import com.greensock.TweenLite;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.filters.BlurFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   
   public class MotionBlurPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1.0;
      
      private static const _DEG2RAD:Number = 0.017453292519943295;
      
      private static const _RAD2DEG:Number = 57.29577951308232;
      
      private static const _point:Point = new Point(0,0);
      
      private static const _ct:ColorTransform = new ColorTransform();
      
      private static const _blankArray:Array = [];
      
      private static var _classInitted:Boolean;
      
      private static var _isFlex:Boolean;
       
      
      protected var _target:DisplayObject;
      
      protected var _time:Number;
      
      protected var _xCurrent:Number;
      
      protected var _yCurrent:Number;
      
      protected var _bd:BitmapData;
      
      protected var _bitmap:Bitmap;
      
      protected var _strength:Number = 0.05;
      
      protected var _tween:TweenLite;
      
      protected var _blur:BlurFilter;
      
      protected var _matrix:Matrix;
      
      protected var _sprite:Sprite;
      
      protected var _rect:Rectangle;
      
      protected var _angle:Number;
      
      protected var _alpha:Number;
      
      protected var _xRef:Number;
      
      protected var _yRef:Number;
      
      protected var _mask:DisplayObject;
      
      protected var _parentMask:DisplayObject;
      
      protected var _padding:int;
      
      protected var _bdCache:BitmapData;
      
      protected var _rectCache:Rectangle;
      
      protected var _cos:Number;
      
      protected var _sin:Number;
      
      protected var _smoothing:Boolean;
      
      protected var _xOffset:Number;
      
      protected var _yOffset:Number;
      
      protected var _cached:Boolean;
      
      protected var _fastMode:Boolean;
      
      public function MotionBlurPlugin(){super();}
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean{return false;}
      
      private function disable() : void{}
      
      private function onTweenDisable() : void{}
      
      override public function set changeFactor(param1:Number) : void{}
   }
}
