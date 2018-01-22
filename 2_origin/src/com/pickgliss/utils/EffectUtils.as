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
      
      public static function imageGlower(param1:DisplayObject, param2:Number, param3:Number, param4:Number, param5:String) : void
      {
         var _loc10_:* = null;
         var _loc17_:* = 0;
         var _loc7_:* = 45;
         if(param5 == "yellow")
         {
            _loc10_ = [16754176,16754176,16754176,16754176];
         }
         if(param5 == "gold")
         {
            _loc10_ = [6684672,16737792,16755200,16777164];
         }
         if(param5 == "blue")
         {
            _loc10_ = [13209,13209,39423,10079487];
         }
         if(param5 == "green")
         {
            _loc10_ = [26112,3381504,10092288,16777164];
         }
         if(param5 == "ocean")
         {
            _loc10_ = [13107,3368550,10079436,13434879];
         }
         if(param5 == "aqua")
         {
            _loc10_ = [13107,26214,52428,65535];
         }
         if(param5 == "ice")
         {
            _loc10_ = [13158,3368601,6724044,10079487];
         }
         if(param5 == "spark")
         {
            _loc10_ = [102,26265,3394815,13434879];
         }
         if(param5 == "silver")
         {
            _loc10_ = [3355443,6710886,12303291,16777215];
         }
         if(param5 == "neon")
         {
            _loc10_ = [3355596,6697932,10066431,13421823];
         }
         var _loc8_:Array = [0,1,1,1];
         var _loc13_:Array = [0,63,126,255];
         var _loc11_:* = param3;
         var _loc14_:* = param3;
         var _loc12_:* = param2;
         var _loc15_:* = param4;
         var _loc6_:String = "outer";
         var _loc18_:Boolean = false;
         var _loc16_:GradientGlowFilter = new GradientGlowFilter(_loc17_,_loc7_,_loc10_,_loc8_,_loc13_,_loc11_,_loc14_,_loc12_,_loc15_,_loc6_,_loc18_);
         var _loc9_:Array = [];
         _loc9_.push(_loc16_);
         param1.filters = _loc9_;
      }
      
      public static function imageShiner(param1:DisplayObject, param2:Number) : void
      {
         var _loc3_:ColorTransform = new ColorTransform();
         var _loc4_:* = param2;
         _loc3_.redOffset = _loc4_;
         _loc3_.redMultiplier = _loc4_ / 100 + 1;
         _loc3_.greenOffset = _loc4_;
         _loc3_.greenMultiplier = _loc4_ / 100 + 1;
         _loc3_.blueOffset = _loc4_;
         _loc3_.blueMultiplier = _loc4_ / 100 + 1;
         param1.transform.colorTransform = _loc3_;
      }
      
      public static function creatMcToBitmap(param1:DisplayObject, param2:uint) : Bitmap
      {
         var _loc3_:BitmapData = new BitmapData(param1.width,param1.height,true,param2);
         _loc3_.draw(param1);
         var _loc4_:Bitmap = new Bitmap(_loc3_);
         return _loc4_;
      }
      
      public static function toRadian(param1:Number) : Number
      {
         return 3.14159265358979 / 180 * param1;
      }
   }
}
