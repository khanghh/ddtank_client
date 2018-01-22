package com.pickgliss.effect
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.utils.EffectUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Matrix;
   
   public class ShinerAnimation extends BaseEffect
   {
      
      public static const SPEED:String = "speed";
      
      public static const INTENSITY:String = "intensity";
      
      public static const WIDTH:String = "width";
      
      public static const EFFECT:String = "effect";
      
      public static const COLOR:String = "color";
      
      public static const BLUR_WIDTH:String = "blurWidth";
      
      public static const IS_LOOP:String = "isLoop";
       
      
      private var _addGlowEffect:Boolean = true;
      
      private var _alphas:Array;
      
      private var _colors:Array;
      
      private var _currentPosition:Number;
      
      private var _endPosition:Number;
      
      private var _isFinish:Boolean;
      
      private var _glowBlurWidth:Number = 3;
      
      private var _glowColorName:String = "blue";
      
      private var _isLoop:Boolean = true;
      
      private var _maskHeight:Number;
      
      private var _maskShape:Shape;
      
      private var _maskWidth:Number;
      
      private var _percent:Array;
      
      private var _shineAnimationContainer:Sprite;
      
      private var _sourceBitmap:Bitmap;
      
      private var _shineBitmapContainer:Sprite;
      
      private var _shineIntensity:Number = 30;
      
      private var _shineMoveSpeed:Number = 15;
      
      private var _shineWidth:Number = 100;
      
      private var _startPosition:Number;
      
      public function ShinerAnimation(param1:int)
      {
         _maskShape = new Shape();
         super(param1);
      }
      
      override public function dispose() : void
      {
         StageReferance.stage.removeEventListener("enterFrame",onRenderAnimation);
         ObjectUtils.disposeObject(_shineAnimationContainer);
         ObjectUtils.disposeObject(_sourceBitmap);
         ObjectUtils.disposeObject(_shineBitmapContainer);
         _shineAnimationContainer = null;
         _sourceBitmap = null;
         _shineBitmapContainer = null;
         super.dispose();
      }
      
      override public function initEffect(param1:DisplayObject, param2:Array) : void
      {
         super.initEffect(param1,param2);
         var _loc3_:Object = param2[0];
         if(_loc3_)
         {
            if(_loc3_["speed"])
            {
               _shineMoveSpeed = _loc3_["speed"];
            }
            if(_loc3_["intensity"])
            {
               _shineIntensity = _loc3_["intensity"];
            }
            if(_loc3_["width"])
            {
               _shineWidth = _loc3_["width"];
            }
            if(_loc3_["effect"])
            {
               _addGlowEffect = _loc3_["effect"];
            }
            if(_loc3_["color"])
            {
               _glowColorName = _loc3_["color"];
            }
            if(_loc3_["blurWidth"])
            {
               _glowBlurWidth = _loc3_["blurWidth"];
            }
            if(_loc3_["isLoop"])
            {
               _isLoop = _loc3_["isLoop"];
            }
         }
         image_shiner(_shineMoveSpeed,_shineIntensity,_shineWidth,_addGlowEffect,_glowColorName,_glowBlurWidth,_isLoop);
      }
      
      override public function play() : void
      {
         super.play();
         DisplayObjectContainer(target).addChild(_shineAnimationContainer);
         StageReferance.stage.addEventListener("enterFrame",onRenderAnimation);
      }
      
      override public function stop() : void
      {
         super.stop();
         if(!_shineAnimationContainer.parent)
         {
            return;
         }
         _shineAnimationContainer.parent.removeChild(_shineAnimationContainer);
         StageReferance.stage.removeEventListener("enterFrame",onRenderAnimation);
      }
      
      private function image_shiner(param1:Number, param2:Number, param3:Number, param4:Boolean, param5:String, param6:Number, param7:Boolean) : void
      {
         _shineAnimationContainer = new Sprite();
         _shineBitmapContainer = new Sprite();
         _sourceBitmap = EffectUtils.creatMcToBitmap(target,16711680);
         _shineBitmapContainer.addChild(_sourceBitmap);
         _shineAnimationContainer.addChild(_shineBitmapContainer);
         EffectUtils.imageShiner(_shineAnimationContainer,param2);
         EffectUtils.imageGlower(_shineBitmapContainer,1,param6,15,param5);
         linear_fade(param3,param1,60);
      }
      
      private function linear_fade(param1:Number, param2:Number, param3:Number) : void
      {
         _maskShape.cacheAsBitmap = true;
         _shineAnimationContainer.cacheAsBitmap = true;
         _shineAnimationContainer.mask = _maskShape;
         _maskWidth = _shineAnimationContainer.width + param3;
         _maskHeight = _shineAnimationContainer.height + param3;
         _maskShape.x = _shineAnimationContainer.x - param3 / 2;
         _maskShape.y = _shineAnimationContainer.y - param3 / 2;
         _colors = [16777215,16777215,16777215];
         _alphas = [0,100,0];
         _percent = [0,127,255];
         _startPosition = -(param1 + param3);
         _currentPosition = _startPosition;
         _endPosition = _shineAnimationContainer.width + param1 + param3;
         _shineAnimationContainer.addChild(_maskShape);
      }
      
      private function onRenderAnimation(param1:Event) : void
      {
         _maskShape.graphics.clear();
         var _loc2_:Matrix = new Matrix();
         _loc2_.createGradientBox(_shineWidth,_maskHeight,EffectUtils.toRadian(45),_currentPosition,0);
         _maskShape.graphics.beginGradientFill("linear",_colors,_alphas,_percent,_loc2_,"pad","linearRGB");
         _maskShape.graphics.drawRect(0,0,_maskWidth,_maskHeight);
         _maskShape.graphics.endFill();
         if(_endPosition > _currentPosition)
         {
            _currentPosition = _currentPosition + _shineMoveSpeed;
         }
         else
         {
            _isFinish = true;
            if(_isLoop)
            {
               _currentPosition = _startPosition;
            }
            else
            {
               StageReferance.stage.removeEventListener("enterFrame",onRenderAnimation);
            }
         }
      }
   }
}
