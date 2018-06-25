package com.pickgliss.utils
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.filters.GradientGlowFilter;
   import flash.geom.ColorTransform;
   
   public class EffectUtils
   {
       
      
      public function EffectUtils()
      {
         super();
      }
      
      public static function imageGlower($target:DisplayObject, glow_intensity:Number, glow_blur:Number, $glow_quality:Number, glow_color_name:String) : void
      {
         var glow_colors:* = null;
         var glow_distance:* = 0;
         var glow_angleInDegrees:* = 45;
         if(glow_color_name == "yellow")
         {
            glow_colors = [16754176,16754176,16754176,16754176];
         }
         if(glow_color_name == "gold")
         {
            glow_colors = [6684672,16737792,16755200,16777164];
         }
         if(glow_color_name == "blue")
         {
            glow_colors = [13209,13209,39423,10079487];
         }
         if(glow_color_name == "green")
         {
            glow_colors = [26112,3381504,10092288,16777164];
         }
         if(glow_color_name == "ocean")
         {
            glow_colors = [13107,3368550,10079436,13434879];
         }
         if(glow_color_name == "aqua")
         {
            glow_colors = [13107,26214,52428,65535];
         }
         if(glow_color_name == "ice")
         {
            glow_colors = [13158,3368601,6724044,10079487];
         }
         if(glow_color_name == "spark")
         {
            glow_colors = [102,26265,3394815,13434879];
         }
         if(glow_color_name == "silver")
         {
            glow_colors = [3355443,6710886,12303291,16777215];
         }
         if(glow_color_name == "neon")
         {
            glow_colors = [3355596,6697932,10066431,13421823];
         }
         var glow_alphas:Array = [0,1,1,1];
         var glow_ratios:Array = [0,63,126,255];
         var glow_blurX:* = glow_blur;
         var glow_blurY:* = glow_blur;
         var glow_strength:* = glow_intensity;
         var glow_quality:* = $glow_quality;
         var glow_type:String = "outer";
         var glow_knockout:Boolean = false;
         var filter:GradientGlowFilter = new GradientGlowFilter(glow_distance,glow_angleInDegrees,glow_colors,glow_alphas,glow_ratios,glow_blurX,glow_blurY,glow_strength,glow_quality,glow_type,glow_knockout);
         var filterArray:Array = [];
         filterArray.push(filter);
         $target.filters = filterArray;
      }
      
      public static function imageShiner($target:DisplayObject, shine_intensity:Number) : void
      {
         var colorTrans:ColorTransform = new ColorTransform();
         var color:* = shine_intensity;
         colorTrans.redOffset = color;
         colorTrans.redMultiplier = color / 100 + 1;
         colorTrans.greenOffset = color;
         colorTrans.greenMultiplier = color / 100 + 1;
         colorTrans.blueOffset = color;
         colorTrans.blueMultiplier = color / 100 + 1;
         $target.transform.colorTransform = colorTrans;
      }
      
      public static function creatMcToBitmap($target:DisplayObject, $color:uint) : Bitmap
      {
         var bitmapData:BitmapData = new BitmapData($target.width,$target.height,true,$color);
         bitmapData.draw($target);
         var bitmap:Bitmap = new Bitmap(bitmapData);
         return bitmap;
      }
      
      public static function toRadian(degree:Number) : Number
      {
         return 3.14159265358979 / 180 * degree;
      }
   }
}
