package com.pickgliss.utils
{
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class PNGHitAreaFactory
   {
      
      private static var points1:Vector.<Point>;
      
      private static var points2:Vector.<Point>;
      
      private static var coord:Vector.<Number>;
      
      private static var commands:Vector.<int>;
       
      
      public function PNGHitAreaFactory()
      {
         super();
      }
      
      public static function drawHitArea(param1:BitmapData) : Sprite
      {
         var _loc5_:int = 0;
         getPointAroundImage(param1);
         var _loc8_:int = 0;
         var _loc7_:* = points1;
         for each(var _loc6_ in points1)
         {
            coord.push(_loc6_.x);
            coord.push(_loc6_.y);
         }
         var _loc10_:int = 0;
         var _loc9_:* = points2;
         for each(var _loc4_ in points2)
         {
            coord.push(_loc4_.x);
            coord.push(_loc4_.y);
         }
         var _loc3_:uint = points1.length + points2.length;
         commands.push(1);
         _loc5_ = 1;
         while(_loc5_ < _loc3_)
         {
            commands.push(2);
            _loc5_++;
         }
         var _loc2_:Sprite = new Sprite();
         _loc2_.graphics.beginFill(16711680);
         _loc2_.graphics.drawPath(commands,coord);
         _loc2_.graphics.endFill();
         return _loc2_;
      }
      
      private static function getPointAroundImage(param1:BitmapData) : void
      {
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = 0;
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         points1 = new Vector.<Point>();
         points2 = new Vector.<Point>();
         commands = new Vector.<int>();
         coord = new Vector.<Number>();
         var _loc2_:int = param1.width;
         var _loc7_:int = param1.height;
         _loc8_ = 1;
         while(_loc8_ <= _loc2_)
         {
            _loc5_ = 1;
            while(_loc5_ <= _loc7_)
            {
               _loc4_ = uint(param1.getPixel32(_loc8_,_loc5_) >> 24 & 255);
               if(_loc4_ != 0)
               {
                  points1.push(new Point(_loc8_,_loc5_));
                  break;
               }
               _loc5_++;
            }
            _loc6_ = _loc7_;
            while(_loc6_ > 0)
            {
               _loc3_ = uint(param1.getPixel32(_loc8_,_loc6_) >> 24 & 255);
               if(_loc3_ != 0 && _loc8_ != _loc6_)
               {
                  points2.unshift(new Point(_loc8_,_loc6_));
                  break;
               }
               _loc6_--;
            }
            _loc8_++;
         }
      }
   }
}
