package com.pickgliss.geom
{
   import flash.geom.Rectangle;
   
   public class IntRectangle
   {
       
      
      public var x:int = 0;
      
      public var y:int = 0;
      
      public var width:int = 0;
      
      public var height:int = 0;
      
      public function IntRectangle(x:int = 0, y:int = 0, width:int = 0, height:int = 0)
      {
         super();
         setRectXYWH(x,y,width,height);
      }
      
      public static function creatWithRectangle(r:Rectangle) : IntRectangle
      {
         return new IntRectangle(r.x,r.y,r.width,r.height);
      }
      
      public function toRectangle() : Rectangle
      {
         return new Rectangle(x,y,width,height);
      }
      
      public function setWithRectangle(r:Rectangle) : void
      {
         x = r.x;
         y = r.y;
         width = r.width;
         height = r.height;
      }
      
      public function setRect(rect:IntRectangle) : void
      {
         setRectXYWH(rect.x,rect.y,rect.width,rect.height);
      }
      
      public function setRectXYWH(x:int, y:int, width:int, height:int) : void
      {
         this.x = x;
         this.y = y;
         this.width = width;
         this.height = height;
      }
      
      public function setLocation(p:IntPoint) : void
      {
         this.x = p.x;
         this.y = p.y;
      }
      
      public function setSize(size:IntDimension) : void
      {
         this.width = size.width;
         this.height = size.height;
      }
      
      public function getSize() : IntDimension
      {
         return new IntDimension(width,height);
      }
      
      public function getLocation() : IntPoint
      {
         return new IntPoint(x,y);
      }
      
      public function union(r:IntRectangle) : IntRectangle
      {
         var x1:int = Math.min(x,r.x);
         var x2:int = Math.max(x + width,r.x + r.width);
         var y1:int = Math.min(y,r.y);
         var y2:int = Math.max(y + height,r.y + r.height);
         return new IntRectangle(x1,y1,x2 - x1,y2 - y1);
      }
      
      public function grow(h:int, v:int) : void
      {
         x = x - h;
         y = y - v;
         width = width + h * 2;
         height = height + v * 2;
      }
      
      public function move(dx:int, dy:int) : void
      {
         x = x + dx;
         y = y + dy;
      }
      
      public function resize(dwidth:int = 0, dheight:int = 0) : void
      {
         width = width + dwidth;
         height = height + dheight;
      }
      
      public function leftTop() : IntPoint
      {
         return new IntPoint(x,y);
      }
      
      public function rightTop() : IntPoint
      {
         return new IntPoint(x + width,y);
      }
      
      public function leftBottom() : IntPoint
      {
         return new IntPoint(x,y + height);
      }
      
      public function rightBottom() : IntPoint
      {
         return new IntPoint(x + width,y + height);
      }
      
      public function containsPoint(p:IntPoint) : Boolean
      {
         if(p.x < x || p.y < y || p.x > x + width || p.y > y + height)
         {
            return false;
         }
         return true;
      }
      
      public function equals(o:Object) : Boolean
      {
         var r:IntRectangle = o as IntRectangle;
         if(r == null)
         {
            return false;
         }
         return x === r.x && y === r.y && width === r.width && height === r.height;
      }
      
      public function clone() : IntRectangle
      {
         return new IntRectangle(x,y,width,height);
      }
      
      public function toString() : String
      {
         return "IntRectangle[x:" + x + ",y:" + y + ", width:" + width + ",height:" + height + "]";
      }
   }
}
