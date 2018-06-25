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
      
      public function ShinerAnimation($id:int)
      {
         _maskShape = new Shape();
         super($id);
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
      
      override public function initEffect(target:DisplayObject, datas:Array) : void
      {
         super.initEffect(target,datas);
         var data:Object = datas[0];
         if(data)
         {
            if(data["speed"])
            {
               _shineMoveSpeed = data["speed"];
            }
            if(data["intensity"])
            {
               _shineIntensity = data["intensity"];
            }
            if(data["width"])
            {
               _shineWidth = data["width"];
            }
            if(data["effect"])
            {
               _addGlowEffect = data["effect"];
            }
            if(data["color"])
            {
               _glowColorName = data["color"];
            }
            if(data["blurWidth"])
            {
               _glowBlurWidth = data["blurWidth"];
            }
            if(data["isLoop"])
            {
               _isLoop = data["isLoop"];
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
      
      private function image_shiner(shine_move_speed:Number, shine_intensity:Number, shine_width:Number, add_glow_effect:Boolean, glow_color_name:String, glow_blur_width:Number, loop:Boolean) : void
      {
         _shineAnimationContainer = new Sprite();
         _shineBitmapContainer = new Sprite();
         _sourceBitmap = EffectUtils.creatMcToBitmap(target,16711680);
         _shineBitmapContainer.addChild(_sourceBitmap);
         _shineAnimationContainer.addChild(_shineBitmapContainer);
         EffectUtils.imageShiner(_shineAnimationContainer,shine_intensity);
         EffectUtils.imageGlower(_shineBitmapContainer,1,glow_blur_width,15,glow_color_name);
         linear_fade(shine_width,shine_move_speed,60);
      }
      
      private function linear_fade(shine_width:Number, shine_move_speed:Number, mask_space:Number) : void
      {
         _maskShape.cacheAsBitmap = true;
         _shineAnimationContainer.cacheAsBitmap = true;
         _shineAnimationContainer.mask = _maskShape;
         _maskWidth = _shineAnimationContainer.width + mask_space;
         _maskHeight = _shineAnimationContainer.height + mask_space;
         _maskShape.x = _shineAnimationContainer.x - mask_space / 2;
         _maskShape.y = _shineAnimationContainer.y - mask_space / 2;
         _colors = [16777215,16777215,16777215];
         _alphas = [0,100,0];
         _percent = [0,127,255];
         _startPosition = -(shine_width + mask_space);
         _currentPosition = _startPosition;
         _endPosition = _shineAnimationContainer.width + shine_width + mask_space;
         _shineAnimationContainer.addChild(_maskShape);
      }
      
      private function onRenderAnimation(event:Event) : void
      {
         _maskShape.graphics.clear();
         var matrix:Matrix = new Matrix();
         matrix.createGradientBox(_shineWidth,_maskHeight,EffectUtils.toRadian(45),_currentPosition,0);
         _maskShape.graphics.beginGradientFill("linear",_colors,_alphas,_percent,matrix,"pad","linearRGB");
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
