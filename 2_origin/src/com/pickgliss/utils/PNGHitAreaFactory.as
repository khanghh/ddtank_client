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
      
      public static function drawHitArea(bmd:BitmapData) : Sprite
      {
         var k:int = 0;
         getPointAroundImage(bmd);
         var _loc8_:int = 0;
         var _loc7_:* = points1;
         for each(var i in points1)
         {
            coord.push(i.x);
            coord.push(i.y);
         }
         var _loc10_:int = 0;
         var _loc9_:* = points2;
         for each(var j in points2)
         {
            coord.push(j.x);
            coord.push(j.y);
         }
         var len:uint = points1.length + points2.length;
         commands.push(1);
         for(k = 1; k < len; )
         {
            commands.push(2);
            k++;
         }
         var sp:Sprite = new Sprite();
         sp.graphics.beginFill(16711680);
         sp.graphics.drawPath(commands,coord);
         sp.graphics.endFill();
         return sp;
      }
      
      private static function getPointAroundImage(bm:BitmapData) : void
      {
         var i:int = 0;
         var j:int = 0;
         var k:* = 0;
         var alphaValue:* = 0;
         var alphaValue1:* = 0;
         points1 = new Vector.<Point>();
         points2 = new Vector.<Point>();
         commands = new Vector.<int>();
         coord = new Vector.<Number>();
         var w:int = bm.width;
         var h:int = bm.height;
         for(i = 1; i <= w; )
         {
            for(j = 1; j <= h; )
            {
               alphaValue = uint(bm.getPixel32(i,j) >> 24 & 255);
               if(alphaValue != 0)
               {
                  points1.push(new Point(i,j));
                  break;
               }
               j++;
            }
            for(k = h; k > 0; )
            {
               alphaValue1 = uint(bm.getPixel32(i,k) >> 24 & 255);
               if(alphaValue1 != 0 && i != k)
               {
                  points2.unshift(new Point(i,k));
                  break;
               }
               k--;
            }
            i++;
         }
      }
   }
}
