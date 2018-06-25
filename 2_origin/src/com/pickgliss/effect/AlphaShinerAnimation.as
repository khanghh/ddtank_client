package com.pickgliss.effect
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Sine;
   import com.pickgliss.utils.EffectUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   
   public class AlphaShinerAnimation extends BaseEffect
   {
      
      public static const SPEED:String = "speed";
      
      public static const INTENSITY:String = "intensity";
      
      public static const WIDTH:String = "width";
      
      public static const EFFECT:String = "effect";
      
      public static const COLOR:String = "color";
      
      public static const BLUR_WIDTH:String = "blurWidth";
      
      public static const IS_LOOP:String = "isLoop";
      
      public static const STRENGTH:String = "strength";
       
      
      private var _addGlowEffect:Boolean = true;
      
      private var _alphas:Array;
      
      private var _colors:Array;
      
      private var _glowBlurWidth:Number = 3;
      
      private var _glowColorName:String = "blue";
      
      private var _glowStrength:Number = 1;
      
      protected var _isLoop:Boolean = true;
      
      protected var _maskHeight:Number;
      
      protected var _maskShape:Shape;
      
      protected var _maskWidth:Number;
      
      private var _percent:Array;
      
      protected var _shineAnimationContainer:Sprite;
      
      private var _sourceBitmap:Bitmap;
      
      private var _shineBitmapContainer:Sprite;
      
      private var _shineIntensity:Number = 30;
      
      protected var _shineMoveSpeed:Number = 0.75;
      
      private var _shineWidth:Number = 100;
      
      public function AlphaShinerAnimation($id:int)
      {
         _maskShape = new Shape();
         super($id);
      }
      
      override public function dispose() : void
      {
         TweenMax.killTweensOf(_maskShape);
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
            if(data["strength"])
            {
               _glowStrength = data["strength"];
            }
         }
         image_shiner(_shineMoveSpeed,_shineIntensity,_shineWidth,_addGlowEffect,_glowColorName,_glowBlurWidth,_glowStrength,_isLoop);
      }
      
      override public function play() : void
      {
         if(TweenMax.isTweening(_maskShape))
         {
            return;
         }
         super.play();
         if(!(target is DisplayObjectContainer))
         {
            _shineAnimationContainer.x = target.x;
            _shineAnimationContainer.y = target.y;
            target.parent.addChild(_shineAnimationContainer);
         }
         else
         {
            DisplayObjectContainer(target).addChild(_shineAnimationContainer);
         }
         if(_isLoop)
         {
            TweenMax.to(_maskShape,_shineMoveSpeed,{
               "startAt":{"alpha":0},
               "alpha":1,
               "yoyo":true,
               "repeat":-1,
               "ease":Sine.easeOut
            });
         }
         else
         {
            TweenMax.to(_maskShape,_shineMoveSpeed,{
               "startAt":{"alpha":0},
               "alpha":1,
               "ease":Sine.easeOut
            });
         }
      }
      
      override public function stop() : void
      {
         super.stop();
         if(!_shineAnimationContainer.parent)
         {
            return;
         }
         _shineAnimationContainer.parent.removeChild(_shineAnimationContainer);
         _maskShape.alpha = 0;
         TweenMax.killTweensOf(_maskShape);
      }
      
      private function image_shiner(shine_move_speed:Number, shine_intensity:Number, shine_width:Number, add_glow_effect:Boolean, glow_color_name:String, glow_blur_width:Number, glow_strength:Number, loop:Boolean) : void
      {
         _shineAnimationContainer = new Sprite();
         _shineBitmapContainer = new Sprite();
         _sourceBitmap = EffectUtils.creatMcToBitmap(target,16711680);
         _shineBitmapContainer.addChild(_sourceBitmap);
         _shineAnimationContainer.addChild(_shineBitmapContainer);
         EffectUtils.imageShiner(_shineAnimationContainer,shine_intensity);
         EffectUtils.imageGlower(_shineBitmapContainer,glow_strength,glow_blur_width,15,glow_color_name);
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
         _colors = [16777215,16777215];
         _alphas = [100,100];
         _percent = [0,255];
         var matrix:Matrix = new Matrix();
         matrix.createGradientBox(_maskWidth,_maskHeight,0,(_maskWidth - _shineWidth) / 2,0);
         _maskShape.graphics.beginGradientFill("radial",_colors,_alphas,_percent,matrix,"pad","linearRGB");
         _maskShape.graphics.drawRect(0,0,_maskWidth,_maskHeight);
         _maskShape.graphics.endFill();
         _shineAnimationContainer.addChild(_maskShape);
      }
   }
}
