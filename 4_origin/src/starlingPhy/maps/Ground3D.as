package starlingPhy.maps
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import road7th.utils.MathUtils;
   
   public class Ground3D extends Tile3D
   {
       
      
      private var _bound:Rectangle;
      
      public function Ground3D(bitmapData:BitmapData, digable:Boolean)
      {
         super(bitmapData,digable);
         _bound = new Rectangle(0,0,width,height);
      }
      
      public function IsEmpty(x:int, y:int) : Boolean
      {
         return GetAlpha(x,y) <= 150;
      }
      
      public function IsRectangleEmpty(rect:Rectangle) : Boolean
      {
         rect = _bound.intersection(rect);
         if(rect.width == 0 || rect.height == 0)
         {
            return true;
         }
         if(!IsXLineEmpty(rect.x,rect.y,rect.width))
         {
            return false;
         }
         if(rect.height > 1)
         {
            if(!IsXLineEmpty(rect.x,rect.y + rect.height - 1,rect.width))
            {
               return false;
            }
            if(!IsYLineEmtpy(rect.x,rect.y + 1,rect.height - 1))
            {
               return false;
            }
            if(rect.width > 1 && !IsYLineEmtpy(rect.x + rect.width - 1,rect.y,rect.height - 1))
            {
               return false;
            }
         }
         return true;
      }
      
      public function IsRectangeEmptyQuick(rect:Rectangle) : Boolean
      {
         rect = _bound.intersection(rect);
         if(IsEmpty(rect.right,rect.bottom) && IsEmpty(rect.left,rect.bottom) && IsEmpty(rect.right,rect.top) && IsEmpty(rect.left,rect.top))
         {
            return true;
         }
         return false;
      }
      
      public function IsCircleEmptyQuick(rect:Rectangle, rAngle:Number = 30) : Boolean
      {
         var i:* = NaN;
         var posX:Number = NaN;
         var posY:Number = NaN;
         rect = _bound.intersection(rect);
         var r:Number = rect.width / 2;
         var xy:Point = new Point(0,0);
         var length:Number = 360 / rAngle;
         for(i = 1; i <= length; )
         {
            xy.x = r * Math.cos(i * rAngle * MathUtils.RADIAN);
            xy.y = r * Math.sin(i * rAngle * MathUtils.RADIAN);
            posX = rect.x + xy.x + r;
            posY = rect.y + xy.y + r;
            if(!IsEmpty(posX,posY))
            {
               return false;
            }
            i++;
         }
         return true;
      }
      
      public function IsXLineEmpty(x:int, y:int, w:int) : Boolean
      {
         var i:int = 0;
         x = x < 0?0:x;
         w = x + w > width?width - x:w;
         for(i = 0; i < w; )
         {
            if(!IsEmpty(x + i,y))
            {
               return false;
            }
            i++;
         }
         return true;
      }
      
      public function IsYLineEmtpy(x:int, y:int, h:int) : Boolean
      {
         var i:int = 0;
         y = y < 0?0:y;
         h = y + h > height?height - y:h;
         for(i = 0; i < h; )
         {
            if(!IsEmpty(x,y + i))
            {
               return false;
            }
            i++;
         }
         return true;
      }
      
      public function IsBitmapDataEmpty(secondObject:BitmapData, secondBitmapDataPoint:Point = null) : Boolean
      {
         return !bitmapData.hitTest(new Point(this.x,this.y),150,secondObject,secondBitmapDataPoint,150);
      }
      
      override public function dispose() : void
      {
         _bound = null;
         super.dispose();
      }
   }
}
