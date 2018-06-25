package starling.utils
{
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.errors.AbstractClassError;
   
   public class RectangleUtil
   {
      
      private static const sHelperPoint:Point = new Point();
      
      private static const sPositions:Vector.<Point> = new <Point>[new Point(0,0),new Point(1,0),new Point(0,1),new Point(1,1)];
       
      
      public function RectangleUtil()
      {
         super();
         throw new AbstractClassError();
      }
      
      public static function intersect(rect1:Rectangle, rect2:Rectangle, resultRect:Rectangle = null) : Rectangle
      {
         if(resultRect == null)
         {
            resultRect = new Rectangle();
         }
         var left:Number = rect1.x > rect2.x?rect1.x:Number(rect2.x);
         var right:Number = rect1.right < rect2.right?rect1.right:Number(rect2.right);
         var top:Number = rect1.y > rect2.y?rect1.y:Number(rect2.y);
         var bottom:Number = rect1.bottom < rect2.bottom?rect1.bottom:Number(rect2.bottom);
         if(left > right || top > bottom)
         {
            resultRect.setEmpty();
         }
         else
         {
            resultRect.setTo(left,top,right - left,bottom - top);
         }
         return resultRect;
      }
      
      public static function fit(rectangle:Rectangle, into:Rectangle, scaleMode:String = "showAll", pixelPerfect:Boolean = false, resultRect:Rectangle = null) : Rectangle
      {
         if(!ScaleMode.isValid(scaleMode))
         {
            throw new ArgumentError("Invalid scaleMode: " + scaleMode);
         }
         if(resultRect == null)
         {
            resultRect = new Rectangle();
         }
         var width:Number = rectangle.width;
         var height:Number = rectangle.height;
         var factorX:Number = into.width / width;
         var factorY:Number = into.height / height;
         var factor:* = 1;
         if(scaleMode == "showAll")
         {
            factor = Number(factorX < factorY?factorX:Number(factorY));
            if(pixelPerfect)
            {
               factor = Number(nextSuitableScaleFactor(factor,false));
            }
         }
         else if(scaleMode == "noBorder")
         {
            factor = Number(factorX > factorY?factorX:Number(factorY));
            if(pixelPerfect)
            {
               factor = Number(nextSuitableScaleFactor(factor,true));
            }
         }
         width = width * factor;
         height = height * factor;
         resultRect.setTo(into.x + (into.width - width) / 2,into.y + (into.height - height) / 2,width,height);
         return resultRect;
      }
      
      private static function nextSuitableScaleFactor(factor:Number, up:Boolean) : Number
      {
         var divisor:* = 1;
         if(up)
         {
            if(factor >= 0.5)
            {
               return Math.ceil(factor);
            }
            while(1 / (divisor + 1) > factor)
            {
               divisor++;
            }
         }
         else
         {
            if(factor >= 1)
            {
               return Math.floor(factor);
            }
            while(1 / divisor > factor)
            {
               divisor++;
            }
         }
         return 1 / divisor;
      }
      
      public static function normalize(rect:Rectangle) : void
      {
         if(rect.width < 0)
         {
            rect.width = -rect.width;
            rect.x = rect.x - rect.width;
         }
         if(rect.height < 0)
         {
            rect.height = -rect.height;
            rect.y = rect.y - rect.height;
         }
      }
      
      public static function getBounds(rectangle:Rectangle, transformationMatrix:Matrix, resultRect:Rectangle = null) : Rectangle
      {
         var i:int = 0;
         if(resultRect == null)
         {
            resultRect = new Rectangle();
         }
         var minX:* = 1.79769313486232e308;
         var maxX:* = -1.79769313486232e308;
         var minY:* = 1.79769313486232e308;
         var maxY:* = -1.79769313486232e308;
         for(i = 0; i < 4; )
         {
            MatrixUtil.transformCoords(transformationMatrix,sPositions[i].x * rectangle.width,sPositions[i].y * rectangle.height,sHelperPoint);
            if(minX > sHelperPoint.x)
            {
               minX = Number(sHelperPoint.x);
            }
            if(maxX < sHelperPoint.x)
            {
               maxX = Number(sHelperPoint.x);
            }
            if(minY > sHelperPoint.y)
            {
               minY = Number(sHelperPoint.y);
            }
            if(maxY < sHelperPoint.y)
            {
               maxY = Number(sHelperPoint.y);
            }
            i++;
         }
         resultRect.setTo(minX,minY,maxX - minX,maxY - minY);
         return resultRect;
      }
   }
}
