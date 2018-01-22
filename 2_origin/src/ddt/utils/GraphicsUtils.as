package ddt.utils
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class GraphicsUtils
   {
       
      
      public function GraphicsUtils()
      {
         super();
      }
      
      public static function drawSector(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Sprite
      {
         var _loc12_:* = NaN;
         var _loc11_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc9_:Sprite = new Sprite();
         var _loc15_:* = param3;
         var _loc14_:* = 0;
         if(param4 != 0)
         {
            _loc15_ = Number(Math.cos(param4 * 3.14159265358979 / 180) * param3);
            _loc14_ = Number(Math.sin(param4 * 3.14159265358979 / 180) * param3);
         }
         _loc9_.graphics.beginFill(16776960,1);
         _loc9_.graphics.moveTo(param1,param2);
         _loc9_.graphics.lineTo(param1 + _loc15_,param2 - _loc14_);
         var _loc8_:Number = param5 * 3.14159265358979 / 180 / param5;
         var _loc7_:Number = Math.cos(_loc8_);
         var _loc13_:Number = Math.sin(_loc8_);
         var _loc6_:* = 0;
         _loc12_ = 0;
         while(_loc12_ < param5)
         {
            _loc11_ = _loc7_ * _loc15_ - _loc13_ * _loc14_;
            _loc10_ = _loc7_ * _loc14_ + _loc13_ * _loc15_;
            _loc15_ = _loc11_;
            _loc14_ = _loc10_;
            _loc9_.graphics.lineTo(_loc15_ + param1,-_loc14_ + param2);
            _loc12_++;
         }
         _loc9_.graphics.lineTo(param1,param2);
         _loc9_.graphics.endFill();
         return _loc9_;
      }
      
      public static function drawDisplayMask(param1:DisplayObject) : DisplayObject
      {
         var _loc8_:* = 0;
         var _loc6_:* = 0;
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         var _loc4_:Number = NaN;
         var _loc5_:BitmapData = new BitmapData(param1.width,param1.height,true,16711680);
         _loc5_.draw(param1);
         var _loc7_:Shape = new Shape();
         _loc7_.cacheAsBitmap = true;
         _loc8_ = uint(0);
         while(_loc8_ < _loc5_.width)
         {
            _loc6_ = uint(0);
            while(_loc6_ < _loc5_.height)
            {
               _loc3_ = uint(_loc5_.getPixel32(_loc8_,_loc6_));
               _loc2_ = uint(_loc3_ >> 24 & 255);
               _loc4_ = _loc2_ / 255;
               if(_loc3_ > 0)
               {
                  _loc7_.graphics.beginFill(0,_loc4_);
                  _loc7_.graphics.drawCircle(_loc8_,_loc6_,1);
               }
               _loc6_++;
            }
            _loc8_++;
         }
         return _loc7_;
      }
      
      public static function changeSectorAngle(param1:Sprite, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void
      {
         var _loc12_:* = NaN;
         var _loc11_:Number = NaN;
         var _loc10_:Number = NaN;
         param1.graphics.clear();
         var _loc15_:* = param4;
         var _loc14_:* = 0;
         if(param5 != 0)
         {
            _loc15_ = Number(Math.cos(param5 * 3.14159265358979 / 180) * param4);
            _loc14_ = Number(Math.sin(param5 * 3.14159265358979 / 180) * param4);
         }
         param1.graphics.beginFill(16776960,1);
         param1.graphics.moveTo(param2,param3);
         param1.graphics.lineTo(param2 + _loc15_,param3 - _loc14_);
         var _loc9_:Number = param6 * 3.14159265358979 / 180 / param6;
         var _loc8_:Number = Math.cos(_loc9_);
         var _loc13_:Number = Math.sin(_loc9_);
         var _loc7_:* = 0;
         _loc12_ = 0;
         while(_loc12_ < param6)
         {
            _loc11_ = _loc8_ * _loc15_ - _loc13_ * _loc14_;
            _loc10_ = _loc8_ * _loc14_ + _loc13_ * _loc15_;
            _loc15_ = _loc11_;
            _loc14_ = _loc10_;
            param1.graphics.lineTo(_loc15_ + param2,-_loc14_ + param3);
            _loc12_++;
         }
         param1.graphics.lineTo(param2,param3);
         param1.graphics.endFill();
      }
   }
}
