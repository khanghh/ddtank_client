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
      
      public static function drawSector(x:Number, y:Number, radius:Number, sAngle:Number, lAngle:Number) : Sprite
      {
         var i:* = NaN;
         var nx:Number = NaN;
         var ny:Number = NaN;
         var sprite:Sprite = new Sprite();
         var sx:* = radius;
         var sy:* = 0;
         if(sAngle != 0)
         {
            sx = Number(Math.cos(sAngle * 3.14159265358979 / 180) * radius);
            sy = Number(Math.sin(sAngle * 3.14159265358979 / 180) * radius);
         }
         sprite.graphics.beginFill(16776960,1);
         sprite.graphics.moveTo(x,y);
         sprite.graphics.lineTo(x + sx,y - sy);
         var a:Number = lAngle * 3.14159265358979 / 180 / lAngle;
         var cos:Number = Math.cos(a);
         var sin:Number = Math.sin(a);
         var b:* = 0;
         for(i = 0; i < lAngle; )
         {
            nx = cos * sx - sin * sy;
            ny = cos * sy + sin * sx;
            sx = nx;
            sy = ny;
            sprite.graphics.lineTo(sx + x,-sy + y);
            i++;
         }
         sprite.graphics.lineTo(x,y);
         sprite.graphics.endFill();
         return sprite;
      }
      
      public static function drawDisplayMask(source:DisplayObject) : DisplayObject
      {
         var i:* = 0;
         var j:* = 0;
         var col:* = 0;
         var alphaChannel:* = 0;
         var alphaValue:Number = NaN;
         var textBitmapData:BitmapData = new BitmapData(source.width,source.height,true,16711680);
         textBitmapData.draw(source);
         var textGraphics:Shape = new Shape();
         textGraphics.cacheAsBitmap = true;
         for(i = uint(0); i < textBitmapData.width; )
         {
            for(j = uint(0); j < textBitmapData.height; )
            {
               col = uint(textBitmapData.getPixel32(i,j));
               alphaChannel = uint(col >> 24 & 255);
               alphaValue = alphaChannel / 255;
               if(col > 0)
               {
                  textGraphics.graphics.beginFill(0,alphaValue);
                  textGraphics.graphics.drawCircle(i,j,1);
               }
               j++;
            }
            i++;
         }
         return textGraphics;
      }
      
      public static function changeSectorAngle(sprite:Sprite, x:Number, y:Number, radius:Number, sAngle:Number, lAngle:Number) : void
      {
         var i:* = NaN;
         var nx:Number = NaN;
         var ny:Number = NaN;
         sprite.graphics.clear();
         var sx:* = radius;
         var sy:* = 0;
         if(sAngle != 0)
         {
            sx = Number(Math.cos(sAngle * 3.14159265358979 / 180) * radius);
            sy = Number(Math.sin(sAngle * 3.14159265358979 / 180) * radius);
         }
         sprite.graphics.beginFill(16776960,1);
         sprite.graphics.moveTo(x,y);
         sprite.graphics.lineTo(x + sx,y - sy);
         var a:Number = lAngle * 3.14159265358979 / 180 / lAngle;
         var cos:Number = Math.cos(a);
         var sin:Number = Math.sin(a);
         var b:* = 0;
         for(i = 0; i < lAngle; )
         {
            nx = cos * sx - sin * sy;
            ny = cos * sy + sin * sx;
            sx = nx;
            sy = ny;
            sprite.graphics.lineTo(sx + x,-sy + y);
            i++;
         }
         sprite.graphics.lineTo(x,y);
         sprite.graphics.endFill();
      }
   }
}
